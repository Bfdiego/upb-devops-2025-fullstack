#!/bin/bash
set -e

SERVER_USER="${SERVER_USER:-ubuntu}"
SERVER_HOST="${FRONTEND_HOST:?FRONTEND_HOST no está definido}"
SERVER_DIR="/var/www/frontend"
SSH_KEY_PATH="${SSH_KEY_PATH:-$HOME/.ssh/id_rsa}"

echo "===> Deploy Frontend a $SERVER_HOST"

echo "[1/4] Eliminando build anterior en EC2..."
ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_HOST "sudo rm -rf $SERVER_DIR/*"

echo "[2/4] Copiando nuevo build..."
rsync -avz -e "ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no" frontend/dist/ $SERVER_USER@$SERVER_HOST:$SERVER_DIR

echo "[3/4] Reiniciando Nginx..."
ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_HOST "sudo systemctl restart nginx"

echo "[4/4] Deploy del frontend completado."