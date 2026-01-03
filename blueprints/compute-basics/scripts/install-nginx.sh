#!/bin/bash
# Este script se ejecuta como root durante el primer inicio de la VM
apt-get update
apt-get install -y nginx
# Opcional: Personalizar la página de bienvenida con el nombre de la VM
echo "<h1>Bienvenido al Lab 01 - Desplegado con Terraform</h1>" > /var/www/html/index.nginx-debian.html