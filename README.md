# 🚀 Proyecto DevOps – Despliegue Fullstack con Docker, EC2 y CI/CD

Este documento describe el despliegue completo en Docker, la ejecución local, la arquitectura, el pipeline CI/CD y la URL pública del proyecto desarrollado para el Segundo Parcial de DevOps – UPB 2025.

Este README documenta únicamente el trabajo del equipo:

- Mazen Abu Hamdan  
- Diego Alba  
- Joaquín Aguilera  
- Diego Gómez  

---

## 📦 1. Clonar el repositorio

git clone https://github.com/Bfdiego/upb-devops-2025-fullstack.git  
cd upb-devops-2025-fullstack

---

## 🧩 2. Configurar variables de entorno (ejecución local)

Crear los siguientes archivos:

### backend/.env

POSTGRES_USER=postgres  
POSTGRES_PASSWORD=postgres123  
POSTGRES_DB=app  
POSTGRES_HOST=db  
POSTGRES_PORT=5432  

### frontend/.env.local

VITE_API_URL=http://localhost:8000  

---

## 🐳 3. Ejecutar todo el proyecto localmente con Docker

Asegúrate de tener instalado Docker y Docker Compose.

docker compose up --build

Servicios:
- Frontend → http://localhost  
- Backend → http://localhost:8000  
- PostgreSQL → Interno por Docker  

Para detener servicios:

docker compose down

---

## 🧪 4. Pruebas locales

Probar backend:

curl http://localhost:8000/health

Respuesta esperada:

{ "status": "ok" }

Probar frontend:

Abrir http://localhost en el navegador.

---

## 🏗️ 5. Arquitectura del proyecto

Usuario → Frontend (React) → Backend API (FastAPI/Express) → PostgreSQL (no expuesta)

Todos los servicios corren en contenedores Docker comunicándose por red interna.

---

## ☁️ 6. Despliegue en AWS EC2 (Producción)

Conectarse vía SSH:

ssh -i TU_LLAVE.pem ubuntu@YOUR_EC2_PUBLIC_IP

Actualizar imágenes y reiniciar servicios:

cd ~/app  
docker compose -f docker-compose.prod.yml pull  
docker compose -f docker-compose.prod.yml up -d  

Ver logs:

docker logs backend  
docker logs frontend  

---

## 🌐 7. URL pública del proyecto

http://YOUR_EC2_PUBLIC_IP

Ejemplo:

http://18.219.129.0

---

## 🤖 8. Pipeline CI/CD (GitHub Actions)

Cada push a main ejecuta:

1. Build & Test  
2. Build & Push Docker Images  
3. Deploy automático vía SSH  

Secrets usados:

SSH_PRIVATE_KEY  
DOCKERHUB_USERNAME  
DOCKERHUB_TOKEN  
EC2_HOST  
FRONTEND_API_URL  

---

## 🛡️ 9. Seguridad

- Base de datos no expuesta  
- `.env` ignorado (no se sube al repo)  
- Secrets manejados solo en GitHub Actions  
- Security Groups mínimos (22, 80, 8000)  

---

## 🌟 10. Mejoras adicionales

- Healthchecks automáticos  
- Rollback de versiones  
- HTTPS con Nginx (opcional)  

---

## 👥 11. Autores

- Mazen Abu Hamdan  
- Diego Alba  
- Joaquín Aguilera  
- Diego Gómez  
