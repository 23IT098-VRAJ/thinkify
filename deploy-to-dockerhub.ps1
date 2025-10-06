# Docker Hub Deployment Script for Thinkify MERN Application
# This script will tag and push your Docker images to Docker Hub

Write-Host "================================" -ForegroundColor Cyan
Write-Host "Docker Hub Deployment Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if Docker is running
try {
    docker --version | Out-Null
    Write-Host "✓ Docker is running" -ForegroundColor Green
} catch {
    Write-Host "✗ ERROR: Docker is not running or not installed!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if images exist
$clientImage = docker images -q thinkify-client:latest
$serverImage = docker images -q thinkify-server:latest

if (-not $clientImage) {
    Write-Host "✗ ERROR: thinkify-client:latest image not found!" -ForegroundColor Red
    Write-Host "Please build the images first using: docker-compose build" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

if (-not $serverImage) {
    Write-Host "✗ ERROR: thinkify-server:latest image not found!" -ForegroundColor Red
    Write-Host "Please build the images first using: docker-compose build" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✓ Both images found locally" -ForegroundColor Green
Write-Host ""

# Login to Docker Hub
Write-Host "Step 1: Login to Docker Hub" -ForegroundColor Yellow
Write-Host "Please enter your Docker Hub credentials when prompted..." -ForegroundColor White
docker login

if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ ERROR: Docker Hub login failed!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host "✓ Successfully logged in to Docker Hub" -ForegroundColor Green
Write-Host ""

# Get Docker Hub username
Write-Host "Step 2: Enter your Docker Hub username" -ForegroundColor Yellow
$DOCKER_USERNAME = Read-Host "Docker Hub Username"

if ([string]::IsNullOrWhiteSpace($DOCKER_USERNAME)) {
    Write-Host "✗ ERROR: Username cannot be empty!" -ForegroundColor Red
    Read-Host "Press Enter to exit"
    exit 1
}

Write-Host ""
Write-Host "Step 3: Tagging images for Docker Hub" -ForegroundColor Yellow

# Tag images
Write-Host "Tagging thinkify-client image..." -ForegroundColor Cyan
docker tag thinkify-client:latest "$DOCKER_USERNAME/thinkify-client:latest"
docker tag thinkify-client:latest "$DOCKER_USERNAME/thinkify-client:v1.0.0"

Write-Host "Tagging thinkify-server image..." -ForegroundColor Cyan
docker tag thinkify-server:latest "$DOCKER_USERNAME/thinkify-server:latest"
docker tag thinkify-server:latest "$DOCKER_USERNAME/thinkify-server:v1.0.0"

Write-Host "✓ Images tagged successfully" -ForegroundColor Green
Write-Host ""

# Push images
Write-Host "Step 4: Pushing images to Docker Hub" -ForegroundColor Yellow
Write-Host "This may take several minutes depending on your internet connection..." -ForegroundColor White
Write-Host ""

Write-Host "Pushing client image (latest)..." -ForegroundColor Cyan
docker push "$DOCKER_USERNAME/thinkify-client:latest"

Write-Host "Pushing client image (v1.0.0)..." -ForegroundColor Cyan
docker push "$DOCKER_USERNAME/thinkify-client:v1.0.0"

Write-Host "Pushing server image (latest)..." -ForegroundColor Cyan
docker push "$DOCKER_USERNAME/thinkify-server:latest"

Write-Host "Pushing server image (v1.0.0)..." -ForegroundColor Cyan
docker push "$DOCKER_USERNAME/thinkify-server:v1.0.0"

Write-Host ""
Write-Host "================================" -ForegroundColor Green
Write-Host "DEPLOYMENT COMPLETED SUCCESSFULLY!" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""

# Display submission URLs
Write-Host "SUBMISSION URLS FOR YOUR ASSIGNMENT:" -ForegroundColor Yellow -BackgroundColor Black
Write-Host ""
Write-Host "1. Original Repository:" -ForegroundColor White
Write-Host "   https://github.com/masum184e/thinkify" -ForegroundColor Blue
Write-Host ""
Write-Host "2. Your Forked Repository:" -ForegroundColor White
Write-Host "   https://github.com/23IT098-VRAJ/thinkify" -ForegroundColor Blue
Write-Host ""
Write-Host "3. Client Docker Image:" -ForegroundColor White
Write-Host "   https://hub.docker.com/r/$DOCKER_USERNAME/thinkify-client" -ForegroundColor Blue
Write-Host ""
Write-Host "4. Server Docker Image:" -ForegroundColor White
Write-Host "   https://hub.docker.com/r/$DOCKER_USERNAME/thinkify-server" -ForegroundColor Blue
Write-Host ""

# Save URLs to file for easy copy-paste
$submissionFile = "SUBMISSION-URLS.txt"
@"
MERN To-Do List Deployment - Submission URLs
Generated on: $(Get-Date)

1. Original Repository:
   https://github.com/masum184e/thinkify

2. Your Forked Repository:
   https://github.com/23IT098-VRAJ/thinkify

3. Client Docker Image:
   https://hub.docker.com/r/$DOCKER_USERNAME/thinkify-client

4. Server Docker Image:
   https://hub.docker.com/r/$DOCKER_USERNAME/thinkify-server

Additional Information:
- Frontend Image Size: ~59MB (Multi-stage build with Nginx)
- Backend Image Size: ~162MB (Node.js Alpine)
- Database: MongoDB with persistent volumes
- All images include health checks and security best practices
"@ | Out-File -FilePath $submissionFile -Encoding UTF8

Write-Host "✓ Submission URLs saved to: $submissionFile" -ForegroundColor Green
Write-Host ""
Write-Host "You can now copy these URLs for your assignment submission!" -ForegroundColor Yellow

Read-Host "Press Enter to exit"
