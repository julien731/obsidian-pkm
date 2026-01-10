---
type: resource
created: 2026-01-10
status: active
tags:
  - proxmox
  - cloudflare
  - cloudflared
migrated_from: notion
migrated_at: 2026-01-10
---

# Setting Up Cloudflared on Proxmox Alpine VM


1. Setup the tunnel on Cloudflare.
2. Setup the agent on the VM
    
    ```bash
    wget -O cloudflared https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
    chmod +x cloudflared
    sudo mv cloudflared /usr/local/bin/
    ```
    
3. Create an OpenRC service (so that the agent starts on boot)
    1. Create the file
        
        ```bash
        nano /etc/init.d/cloudflared
        ```
        
    2. Add the config
        
        ```bash
        #!/sbin/openrc-run
        
        name="cloudflared"
        command="/usr/bin/cloudflared"
        command_args="tunnel --no-autoupdate run --token YOUR-TOKEN-HERE"
        pidfile="/run/${RC_SVCNAME}.pid"
        command_background=true
        ```
        
        <aside>
        ⚠️ Make sure the path to Cloudflared in `command` is correct. Check the path with `which cloudflared`.
        
        </aside>
        
    3. Make it executable
        
        ```bash
        chmod +x /etc/init.d/cloudflared
        ```
        
    4. Add to startup
        
        ```bash
        rc-update add cloudflared default
        ```
        
    5. Start the service
        
        ```bash
        rc-service cloudflared start
        ```
