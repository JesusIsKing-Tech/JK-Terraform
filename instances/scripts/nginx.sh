#!/bin/bash
    apt install -y nginx

    # Copiando configurações do nginx
    cat > /etc/nginx/sites-available/default <<'NGINX_DEFAULT'
    ${file("${path.module}/../../nginx/default.conf")}
    NGINX_DEFAULT

    cat > /etc/nginx/conf.d/load-balancer.conf <<'NGINX_LB'
    ${file("${path.module}/../../nginx/load-balancer.conf")}
    NGINX_LB

    cat > /etc/nginx/conf.d/reverse-proxy.conf <<'NGINX_RP'
    ${file("${path.module}/../../nginx/reverse-proxy.conf")}
    NGINX_RP

    systemctl restart nginx