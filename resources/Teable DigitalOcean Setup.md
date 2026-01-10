---
type: resource
created: 2026-01-10
status: active
related:
  - "[[Replace Airtable for Budgeting]]"
migrated_from: notion
migrated_at: 2026-01-10
---

# Teable DigitalOcean Setup


1. Create Droplet
2. Setup Teable
    
    [Docker Compose | Teable Help](https://help.teable.io/deployment/docker-compose)
    
    <aside>
    ⚠️ `docker-compose` is deprecated on the latest versions of Ubuntu. Use `docker compose` instead. See [https://www.reddit.com/r/docker/comments/16rbxe5/dockercompose_up_keeps_throwing_errors/](https://www.reddit.com/r/docker/comments/16rbxe5/dockercompose_up_keeps_throwing_errors/)
    
    </aside>
    
3. Setup Nginx with Let’s Encrypt

[Deploying NEXTJS site with nginx + pm2](https://gist.github.com/jjsquady/5399d6e1b23f501083a9c262d806e248)

- Nginx Config
    
    ```
    # Redirect HTTP to HTTPS
    server {
      listen 80 default_server;
      listen [::]:80 default_server;
      server_name teable.tannyandjulien.com;
      return 301 https://$server_name$request_uri;
    }
    
    server {
      # listen on *:443 -> ssl; instead of *:80
      listen 443 ssl http2 default_server;
      listen [::]:443 ssl http2 default_server;
    
      server_name teable.tannyandjulien.com;
      
      ssl_certificate /etc/letsencrypt/live/teable.tannyandjulien.com/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/teable.tannyandjulien.com/privkey.pem;
      include snippets/ssl-params.conf;
    
      location / {
        # reverse proxy for next server
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
      
        # we need to remove this 404 handling
        # because next's _next folder and own handling
        # try_files $uri $uri/ =404;
      }
      
      location ~ /.well-known {
        allow all;
      }
    }
    ```
    

# Updating Teable

Just pull the latest version of the Docker images:

```bash
docker compose pull
```
