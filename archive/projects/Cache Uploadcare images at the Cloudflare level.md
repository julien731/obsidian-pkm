---
type: project
created: 2026-01-10
status: completed
tags:
  - nimble
migrated_from: notion
migrated_at: 2026-01-10
---

# Cache Uploadcare images at the Cloudflare level


# Why

When client apps load assets from the Uploadcare CDN, it creates traffic, which ends up costing a lot.

# Expected Outcome

Images coming from the CDN are loaded from Cloudflare’s cache.

# Notes

- Check using a Worker to fetch/cache CND assets.

# Resources

[Untitled](Cache%20Uploadcare%20images%20at%20the%20Cloudflare%20level/Untitled%2021e37367d0b38048ad4be1f8385df9b5.csv)
