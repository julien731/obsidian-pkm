---
type: idea
status: active
created: 2026-02-10
category: maker/iot
summary: Build a physical ESP32-based face/display that gives an AI agent visual presence and self-expression capabilities
tags:
  - ai
  - iot
  - esp32
  - openclaw
  - maker
  - hardware
related:
  - "[[projects/OpenClaw Setup]]"
source: https://www.linkedin.com/posts/angel-dimitrov-85b3b499_ai-opensource-esp32-activity-7426644724301766656-HMmV
---

# ESP32 AI Face - Physical Agent Presence

Inspired by Angel Dimitrov's OpenClaw project: an ESP32-powered display that gives an AI agent a physical face. The agent designs its own expressions, can see itself via camera, and iterates on its appearance autonomously.

## What Angel Built

- **Hardware**: ESP32 with display, housed in a handmade 60×60mm pine cube
- **Connectivity**: WiFi, REST API for control, OTA firmware updates
- **Integration**: OpenClaw skill — agent picks emotions in real-time during interactions
- **Self-improvement loop**: iPhone as continuity camera → agent sees its own face → critiques → pushes updated firmware
- **Result**: 20 distinct emotions with visual indicators (tears, thought bubbles, anger vein, etc.)
- **Ambient layer**: Weather-aware effects (rain, snow) connecting to physical world

## Why This Is Interesting

1. **Physical presence** — transforms an AI from chat-only to something with embodiment
2. **Self-design loop** — agent iterates on its own visual identity, not pre-programmed
3. **Continuous expression** — runs 24/7, reflects emotional state in real-time
4. **Maker accessibility** — ESP32 + basic woodworking, not expensive robotics

## Implementation Approach

### Hardware Options

| Component | Budget Option | Better Option |
|-----------|--------------|---------------|
| MCU | ESP32-WROOM | ESP32-S3 (more RAM, native USB) |
| Display | 1.3" OLED (128×64) | 1.69" IPS LCD (240×280, color) |
| Housing | 3D printed | Handmade wood like Angel's |
| Camera | Phone as continuity cam | ESP32-CAM module for self-contained |

Estimated cost: $15-40 depending on display choice.

### Software Architecture

```
┌─────────────────┐     REST/WebSocket     ┌──────────────────┐
│   OpenClaw      │ ◄──────────────────────► │   ESP32 Face     │
│   (Gateway)     │                          │   Device         │
└─────────────────┘                          └──────────────────┘
        │                                            │
        │  Skill: face-control                       │  Serves:
        │  - Set emotion                             │  - GET /emotion
        │  - Get current state                       │  - POST /emotion
        │  - Push OTA update                         │  - POST /ota
        │                                            │  - GET /snapshot
        ▼                                            ▼
┌─────────────────┐                          ┌──────────────────┐
│   Camera Feed   │ ────────────────────────► │   Display        │
│   (optional)    │    Agent can "see self"  │   (emotions)     │
└─────────────────┘                          └──────────────────┘
```

### OpenClaw Skill Design

The skill would:
1. **Register device** — mDNS discovery or static IP config
2. **Emotion mapping** — map conversation sentiment to emotion codes
3. **Real-time updates** — call device API on each response
4. **Self-design mode** — agent can request display code changes, push OTA
5. **Camera integration** — periodic snapshots for self-reflection

### Emotion Set (Starting Point)

Angel's agent designed 20 emotions. Start with core 8:
- `neutral`, `happy`, `thinking`, `confused`, `excited`, `sad`, `angry`, `sleepy`

Let the agent expand from there.

## Phases

### Phase 1: Basic Display (Weekend Project)
- [ ] ESP32 + OLED, simple emotion display
- [ ] REST API for emotion control
- [ ] OpenClaw skill to set emotion on response

### Phase 2: Self-Expression
- [ ] Agent designs additional emotions
- [ ] OTA update capability
- [ ] Expression persistence across reboots

### Phase 3: Self-Awareness
- [ ] Camera integration
- [ ] Agent can see and critique its expressions
- [ ] Weather-aware ambient effects

## Open Questions

- Display resolution vs. expression complexity tradeoff?
- Self-contained (ESP32-CAM) vs external camera for self-view?
- Where to mount it? Desk? Next to monitor?
- Should multiple devices sync (office + home)?

## Resources

- [Original LinkedIn post](https://www.linkedin.com/posts/angel-dimitrov-85b3b499_ai-opensource-esp32-activity-7426644724301766656-HMmV)
- ESP32 Arduino framework
- OpenClaw skills documentation
