---
type: project
created: 2026-01-10
status: completed
tags:
  - nimble
migrated_from: notion
migrated_at: 2026-01-10
---

# Okya URL Shortener


# Why

Describe the rationale for this project.

# Expected Outcome

Define what the project completion should achieve.

# Notes

- Use Cloudflare workers.

# Readme

1. Create the worker

```bash
wrangler init cloudflare-url-shortener
cd cloudflare-url-shortener
```

1. Follow the Cloudflare setup assistant (use “Hello world app”, “Worker only”, “JavaScript”)
2. Create the URL store
    
    ```bash
    wrangler kv namespace create "SHORT_URL_STORE"
    ```
    
3. Follow the instructions and add the `kv_namespaces` array to your `wrangler.jsonc` config file
4. Deploy the worker
    
    ```bash
    wrangler deploy
    ```
    
5. On the Cloudflare dashboard, open `Compute (Worker) > Workers & Pages > {your worker} > Settings` and add a custom domain
6. Go to `Go to Zero Trust > Access > Applications`
7. Create a new “Self-hosted” application

# Resources

[Untitled](Okya%20URL%20Shortener/Untitled%2020137367d0b380a88368ed9e8b2e9b25.csv)
