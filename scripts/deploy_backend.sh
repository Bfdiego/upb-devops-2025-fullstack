#!/bin/bash
set -e

# Config: se leen de variables de entorno
SERVER_USER="${SERVER_USER:-ubuntu}"
SERVER_HOST="${BACKEND_HOST:?BACKEND_HOST no está definido}"
SERVER_DIR="/var/www/full-stack-fastapi-template/backend"
SSH_KEY_PATH="${SSH_KEY_PATH:-$HOME/.ssh/id_rsa}"

echo "===> Deploy Backend a $SERVER_HOST"

echo "[1/4] Copiando archivos al servidor..."
rsync -avz -e "ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no" backend/ $SERVER_USER@$SERVER_HOST:$SERVER_DIR

echo "[2/4] Instalando dependencias con uv..."
ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_HOST "cd $SERVER_DIR && source .venv/bin/activate && uv sync"

echo "[3/4] Reiniciando servicio backend..."
ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_HOST "sudo systemctl restart backend"

echo "[4/4] Estado del servicio:"
ssh -i $SSH_KEY_PATH -o StrictHostKeyChecking=no $SERVER_USER@$SERVER_HOST "sudo systemctl status backend --no-pager"

echo "===> Deploy del backend completado correctamente."