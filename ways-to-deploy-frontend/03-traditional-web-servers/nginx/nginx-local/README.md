# Deploying a Next application on a local Linux machine using Nginx is a straightforward process

### Simple web server

```
server {
    listen 80;
    server_name <IP>

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### Web server with openssl configuration

#### Enable HTTPS (Self-Signed)

```
sudo mkdir -p /etc/nginx/ssl
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/nginx/ssl/selfsigned.key \
  -out /etc/nginx/ssl/selfsigned.crt
```

#### configuration

```
server {
    listen 443 ssl;
    server_name <IP>

    ssl_certificate /etc/nginx/ssl/selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/selfsigned.key;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}

server {
    listen 80;
    server_name <IP>
    return 301 https://$host$request_uri;
}
```

### Bind with specific ip

```
server {
    listen 192.168.68.104:443 ssl;
    server_name 192.168.68.104; 

    ssl_certificate /etc/nginx/ssl/selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/selfsigned.key;

    root /var/www/html;
    index index.html;

    location / {
        try_files $uri $uri/ /index.html;
    }
}

server {
    listen 192.168.68.104:80;
    server_name 192.168.68.104;
    return 301 https://$host$request_uri;
}
```
