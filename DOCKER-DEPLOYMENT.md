# Thinkify - MERN Stack Deployment with Docker

This repository contains a containerized MERN (MongoDB, Express.js, React, Node.js) stack application for the Thinkify platform.

## 🚀 Quick Start

### Prerequisites
- Docker and Docker Compose installed
- Git

### Running the Application

1. Clone the repository:
```bash
git clone <your-forked-repo-url>
cd thinkify
```

2. Build and run the complete stack:
```bash
docker-compose up --build
```

3. Access the application:
- **Frontend**: http://localhost
- **Backend API**: http://localhost:3000
- **MongoDB**: localhost:27017

## 🐳 Docker Images

### Frontend (React + Nginx)
- **Multi-stage build** for optimized production image
- **Stage 1**: Build React application with Node.js
- **Stage 2**: Serve with Nginx for better performance
- **Size**: ~25MB (Alpine Linux + Nginx)

### Backend (Node.js + Express)
- **Production-optimized** with security best practices
- **Non-root user** execution
- **Health checks** for container monitoring
- **Size**: ~150MB (Alpine Linux + Node.js)

### Database (MongoDB)
- **Persistent storage** with Docker volumes
- **Initialization scripts** for setup
- **Health checks** for reliability

## 📋 Services Overview

| Service | Port | Description |
|---------|------|-------------|
| Frontend | 80 | React app served by Nginx |
| Backend | 3000 | Node.js API server |
| MongoDB | 27017 | Database server |

## 🔧 Configuration

### Environment Variables

#### Frontend (.env.production)
```
VITE_SERVER_ENDPOINT=http://localhost:3000/api
VITE_TOKEN_KEY=thinkify
VITE_USER_ROLE=role
VITE_COOKIE_EXPIRES=1
```

#### Backend (.env.production)
```
PORT=3000
DATABASE_URL=mongodb://admin:password123@mongodb:27017/
DATABASE_NAME=thinkify
BCRYPT_GEN_SALT_NUMBER=10
JWT_SECRET_KEY=abcdefghijklmnopqrstuvwxyz
COOKIE_EXPIRES=5d
COOKIE_KEY=thinkify
UPLOAD_DIRECTORY=uploads
NODE_ENV=production
```

## 🛠️ Development Commands

### Build individual images
```bash
# Build frontend image
docker build -t thinkify-client ./client

# Build backend image
docker build -t thinkify-server ./server
```

### Run individual services
```bash
# Run only database
docker-compose up mongodb

# Run backend with database
docker-compose up mongodb server

# Run full stack
docker-compose up
```

### Check service health
```bash
# Check all services
docker-compose ps

# Check logs
docker-compose logs [service-name]
```

## 🚢 Docker Hub Deployment

### Build and tag images for Docker Hub
```bash
# Build and tag frontend
docker build -t yourusername/thinkify-client:latest ./client
docker build -t yourusername/thinkify-client:v1.0.0 ./client

# Build and tag backend
docker build -t yourusername/thinkify-server:latest ./server
docker build -t yourusername/thinkify-server:v1.0.0 ./server
```

### Push to Docker Hub
```bash
# Login to Docker Hub
docker login

# Push frontend
docker push yourusername/thinkify-client:latest
docker push yourusername/thinkify-client:v1.0.0

# Push backend
docker push yourusername/thinkify-server:latest
docker push yourusername/thinkify-server:v1.0.0
```

## 📊 Performance & Security Features

### Frontend
- **Multi-stage build** for minimal image size
- **Nginx optimization** for static file serving
- **Security headers** configuration
- **Gzip compression** enabled

### Backend
- **Non-root user** execution
- **Health checks** implementation
- **Production dependencies** only
- **Resource optimization**

### Database
- **Persistent volumes** for data safety
- **Authentication** enabled
- **Connection pooling** optimization

## 🔍 Monitoring & Logs

### View logs
```bash
# All services
docker-compose logs -f

# Specific service
docker-compose logs -f server
docker-compose logs -f client
docker-compose logs -f mongodb
```

### Monitor resources
```bash
# Container stats
docker stats

# Service status
docker-compose ps
```

## 🛡️ Security Considerations

1. **Changed default MongoDB credentials**
2. **JWT secret key configuration**
3. **Non-root container execution**
4. **Network isolation** with Docker networks
5. **Security headers** in Nginx configuration

## 📝 Troubleshooting

### Common Issues

1. **Port conflicts**: Ensure ports 80, 3000, and 27017 are available
2. **Memory issues**: Ensure Docker has enough memory allocated
3. **Permission issues**: Check file permissions and Docker user access

### Reset everything
```bash
# Stop and remove all containers, networks, and volumes
docker-compose down -v --remove-orphans

# Remove all images
docker rmi $(docker images -q)

# Rebuild from scratch
docker-compose up --build
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test with Docker
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
