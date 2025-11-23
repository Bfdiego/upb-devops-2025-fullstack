#!/bin/bash

# === CONFIG ===
SERVER_USER="ubuntu"
SERVER_HOST="IP_PUBLICA_FRONTEND"
SERVER_DIR="/var/www/frontend"
SSH_KEY="ruta/a/tu/key.pem"

echo "===> Deploy Frontend"

echo "[1/4] Eliminando build anterior en EC2..."
ssh -i $SSH_KEY $SERVER_USER@$SERVER_HOST "sudo rm -rf $SERVER_DIR/*"

echo "[2/4] Copiando nuevo build..."
rsync -avz -e "ssh -i $SSH_KEY" frontend/dist/ $SERVER_USER@$SERVER_HOST:$SERVER_DIR

echo "[3/4] Reiniciando Nginx..."
ssh -i $SSH_KEY $SERVER_USER@$SERVER_HOST "sudo systemctl restart nginx"

echo "[4/4] Deploy del frontend completado."