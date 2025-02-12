# Nginx Web Server Setup Guide

## 1. Install Nginx

```bash
sudo apt update && sudo apt install nginx
```

## 2. Start/Enable Nginx

```bash
sudo systemctl start nginx
sudo systemctl enable nginx  # Auto-start on boot
```

## 3. Modify Default Configuration

### Backup original config

```bash
sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.backup
```

### Edit config file

```bash
sudo nano /etc/nginx/sites-available/default
```

### Replace with

```nginx
server {
    listen 80;
    server_name 192.168.68.116;  # Replace with your IP/domain

    root /var/www/my-app;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;  # For client-side routing
    }

    # Optional: Enable Gzip compression
    gzip on;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript;
}
```

## 4. Validate & Reload Nginx

```bash
sudo nginx -t           # Check config syntax
sudo systemctl reload nginx
```

## 5. Deploy Application

```bash
sudo mkdir -p /var/www/my-app
sudo cp -r /path/to/your/app/build/* /var/www/my-app/
sudo chown -R www-data:www-data /var/www/my-app  # Fix permissions
```

## 6. Optional: HTTPS (Self-Signed)

### Generate certificate

```bash
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/selfsigned.key \
  -out /etc/nginx/ssl/selfsigned.crt
```

### Update Nginx config for HTTPS

```nginx
server {
    listen 443 ssl;
    server_name 192.168.68.116;
    ssl_certificate /etc/nginx/ssl/selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/selfsigned.key;
    # ... rest of config ...
}

server {
    listen 80;
    server_name 192.168.68.116;
    return 301 https://$host$request_uri;
}
```

### Reload Nginx

```bash
sudo systemctl reload nginx
```

## 7. Stop Nginx

```bash
sudo systemctl stop nginx
```

## 8. Uninstall Nginx

```bash
sudo systemctl stop nginx
sudo apt purge nginx nginx-common
sudo rm -rf /etc/nginx  # Remove configs
```

## Verification

- Access via `http://192.168.68.116` or `https://192.168.68.116`
- Check logs:

  ```bash
  sudo tail -f /var/log/nginx/error.log
  ```

## Notes

- **Firewall**: Allow ports 80/443:

  ```bash
  sudo ufw allow 'Nginx Full'
  ```

- For production, replace `server_name` with a domain (e.g., `example.com`).
