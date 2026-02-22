Run OpenClaw's browser tool on a headless Linux server using Xvfb, bypassing Cloudflare bot detection.
## How it works

OpenClaw has two browser profiles:

- **`openclaw`** (managed) -- Launches a dedicated Chromium via Playwright/CDP. Full control: snapshots, screenshots, navigation. This does the actual browsing.
- **`chrome`** (extension relay) -- The agent checks this profile for attached tabs to determine if "browser search" is available. Without at least one tab attached, the agent refuses to search.

On a desktop, a human clicks the extension icon to attach tabs. On a headless server, we automate this by:

1. Running Xvfb to provide a virtual display
2. Running the `openclaw` managed browser on that display (`headless: false` to look like a real browser)
3. Running a second Chromium instance with the relay extension patched to auto-attach tabs

Both profiles must be running for the agent to browse and search.

## Prerequisites

- Linux server with systemd
- OpenClaw installed globally (`npm install -g openclaw`)
- An existing OpenClaw gateway (user-level systemd service)
- sudo access for installing packages and the Xvfb service

## Step 1: Install packages

```bash
# Debian/Ubuntu
sudo apt-get update
sudo apt-get install -y xvfb chromium

# Check the binary name -- some distros use chromium-browser
which chromium || which chromium-browser
```

> **Note:** On Debian, the package and binary are `chromium`. On Ubuntu, it may be `chromium-browser`. Adjust paths below accordingly.

## Step 2: Create Xvfb system service

```bash
sudo tee /etc/systemd/system/xvfb.service > /dev/null << 'EOF'
[Unit]
Description=Xvfb Virtual Framebuffer
After=network.target

[Service]
Type=simple
ExecStart=/usr/bin/Xvfb :99 -screen 0 1280x720x24 -nolisten tcp
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable xvfb
sudo systemctl start xvfb
```

Verify: `DISPLAY=:99 xdpyinfo | head -5`

## Step 3: Update OpenClaw config

Merge the `browser` section into `~/.openclaw/openclaw.json`:

```json
{
  "browser": {
    "enabled": true,
    "headless": false,
    "noSandbox": true,
    "executablePath": "/usr/bin/chromium",
    "defaultProfile": "openclaw"
  }
}
```

Key settings:
- `headless: false` -- Runs as a real browser window on the virtual display (bypasses bot detection)
- `noSandbox: true` -- Required for running as a regular user without Chrome's sandbox
- `defaultProfile: "openclaw"` -- Uses the managed CDP browser by default

## Step 4: Add DISPLAY to the gateway service

Add `Environment=DISPLAY=:99` and an `ExecStartPost` to your existing OpenClaw gateway service. If you use the managed `openclaw-gateway.service`:

```bash
# Edit the service
systemctl --user edit openclaw-gateway --force
```

Add under `[Service]`:

```ini
Environment=DISPLAY=:99
ExecStartPost=/bin/bash -c 'sleep 5 && /usr/bin/openclaw browser start'
```

The `ExecStartPost` auto-starts the managed CDP browser after the gateway is up.

## Step 5: Install and patch the relay extension

Install the extension files:

```bash
openclaw browser extension install
```

This creates `~/.openclaw/browser/chrome-extension/`.

Now patch `~/.openclaw/browser/chrome-extension/background.js` to auto-attach tabs on a headless server. Append this block at the end of the file:

```javascript
// --- Headless auto-attach: attach to every tab automatically ---
async function autoAttachTab(tabId) {
  if (tabs.has(tabId)) return
  // Skip extension pages
  try {
    const tab = await chrome.tabs.get(tabId)
    if (tab.url && tab.url.startsWith('chrome-extension://')) return
  } catch { return }
  try {
    await ensureRelayConnection()
    await attachTab(tabId)
  } catch {
    // relay not ready yet, ignore
  }
}

async function autoAttachAllTabs() {
  try {
    await ensureRelayConnection()
  } catch {
    return false
  }
  const allTabs = await chrome.tabs.query({})
  let attached = 0
  for (const tab of allTabs) {
    if (tab.id && !tabs.has(tab.id)) {
      if (tab.url && tab.url.startsWith('chrome-extension://')) continue
      await autoAttachTab(tab.id).catch(() => {})
      attached++
    }
  }
  return attached > 0
}

async function autoAttachAllTabsWithRetry() {
  for (let i = 0; i < 10; i++) {
    await new Promise(r => setTimeout(r, 2000))
    const ok = await autoAttachAllTabs().catch(() => false)
    if (ok) return
  }
}

chrome.tabs.onCreated.addListener((tab) => {
  if (tab.id) {
    // Small delay for tab to be ready
    setTimeout(() => void autoAttachTab(tab.id), 500)
  }
})

chrome.tabs.onUpdated.addListener((tabId, changeInfo) => {
  if (changeInfo.status === 'complete' && !tabs.has(tabId)) {
    void autoAttachTab(tabId)
  }
})

// On startup and on service worker wake, retry attaching
void autoAttachAllTabsWithRetry()
```

Also change the existing `chrome.runtime.onInstalled` listener to skip opening the options page:

```javascript
// Replace:
chrome.runtime.onInstalled.addListener(() => {
  void chrome.runtime.openOptionsPage()
})

// With:
chrome.runtime.onInstalled.addListener(() => {
  void autoAttachAllTabsWithRetry()
})
```

## Step 6: Create the relay browser launcher script

```bash
mkdir -p ~/.openclaw/browser

cat > ~/.openclaw/browser/start-relay-browser.sh << 'SCRIPT'
#!/usr/bin/env bash
# Launch Chromium with the OpenClaw relay extension on Xvfb display :99
# The extension auto-attaches to all tabs and connects to the relay server.

export DISPLAY=:99

EXTENSION_DIR="$HOME/.openclaw/browser/chrome-extension"
USER_DATA_DIR="$HOME/.openclaw/browser/relay-profile"

mkdir -p "$USER_DATA_DIR"

exec /usr/bin/chromium \
  --no-sandbox \
  --disable-gpu \
  --disable-dev-shm-usage \
  --disable-blink-features=AutomationControlled \
  --silent-debugger-extension-api \
  --load-extension="$EXTENSION_DIR" \
  --user-data-dir="$USER_DATA_DIR" \
  --no-first-run \
  --disable-default-apps \
  --disable-popup-blocking \
  --disable-translate \
  --disable-background-timer-throttling \
  --disable-renderer-backgrounding \
  --disable-backgrounding-occluded-windows \
  "about:blank"
SCRIPT

chmod +x ~/.openclaw/browser/start-relay-browser.sh
```

Key flags:
- `--silent-debugger-extension-api` -- Lets the extension use `chrome.debugger` without user confirmation
- `--disable-blink-features=AutomationControlled` -- Hides automation fingerprint from sites
- `--load-extension` -- Loads the patched relay extension at startup

## Step 7: Create the relay browser systemd service

Replace `YOUR_USER` with your username:

```bash
cat > ~/.config/systemd/user/openclaw-relay-browser.service << 'EOF'
[Unit]
Description=OpenClaw Relay Browser (Chromium + Extension on Xvfb)
After=openclaw-gateway.service
Wants=openclaw-gateway.service

[Service]
Type=simple
ExecStartPre=/bin/sleep 8
ExecStart=%h/.openclaw/browser/start-relay-browser.sh
Restart=on-failure
RestartSec=10
Environment=DISPLAY=:99
Environment=HOME=%h

[Install]
WantedBy=default.target
EOF
```

The `ExecStartPre=/bin/sleep 8` ensures the gateway and its relay server are fully up before Chromium launches the extension.

## Step 8: Enable and start everything

```bash
systemctl --user daemon-reload
systemctl --user enable openclaw-relay-browser
systemctl --user restart openclaw-gateway
sleep 5
systemctl --user start openclaw-relay-browser
```

## Step 9: Verify

Wait ~20 seconds for everything to initialize, then:

```bash
# Both profiles should be running with tabs
openclaw browser profiles

# Expected output:
# openclaw: running (1 tabs) [default]
#   port: 18800, color: #FF4500
# chrome: running (1 tabs)
#   port: 18792, color: #00AA00

# Test the managed browser can snapshot a page
openclaw browser open https://www.cloudflare.com
sleep 3
openclaw browser snapshot --format aria --limit 10

# Should show real page content, not a bot challenge
```

## Startup order

```
xvfb.service (system)           -- display :99
  |
  v
openclaw-gateway.service (user) -- gateway + relay server on :18792
  |
  +-- ExecStartPost             -- openclaw browser start (managed CDP on :18800)
  |
  v
openclaw-relay-browser (user)   -- Chromium + extension, auto-attaches to relay
```

## Troubleshooting

### Browser shows 0 tabs on chrome profile

The extension didn't connect. Check:

```bash
# Is the relay browser running?
systemctl --user status openclaw-relay-browser

# Is the gateway relay server up?
curl -s http://127.0.0.1:18792/ && echo "relay up"

# Nuke the cached profile and restart
systemctl --user stop openclaw-relay-browser
rm -rf ~/.openclaw/browser/relay-profile
systemctl --user start openclaw-relay-browser
```

### openclaw browser start fails

```bash
# Is Xvfb running?
systemctl status xvfb

# Is DISPLAY set?
systemctl --user show openclaw-gateway | grep DISPLAY

# Manual test
export DISPLAY=:99
openclaw browser start
```

### Agent still asks to "click the extension icon"

Both profiles need tabs. Check `openclaw browser profiles` and ensure neither shows `0 tabs`.

### OpenClaw update resets the extension

`openclaw browser extension install` overwrites `background.js`. After updating OpenClaw, re-apply the auto-attach patch from Step 5 and restart the relay browser:

```bash
systemctl --user restart openclaw-relay-browser
```

Consider keeping the patched `background.js` in a backup:

```bash
cp ~/.openclaw/browser/chrome-extension/background.js \
   ~/.openclaw/browser/background.js.patched
```

Then after an update:

```bash
cp ~/.openclaw/browser/background.js.patched \
   ~/.openclaw/browser/chrome-extension/background.js
systemctl --user restart openclaw-relay-browser
```