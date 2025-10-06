@echo off
echo ================================
echo Docker Hub Deployment Script
echo ================================
echo.

REM Check if Docker is running
docker --version >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo ERROR: Docker is not running or not installed!
    pause
    exit /b 1
)

echo Step 1: Login to Docker Hub
echo Please enter your Docker Hub credentials when prompted...
docker login
if %ERRORLEVEL% neq 0 (
    echo ERROR: Docker Hub login failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Tagging images for Docker Hub
echo Please enter your Docker Hub username:
set /p DOCKER_USERNAME="Docker Hub Username: "

if "%DOCKER_USERNAME%"=="" (
    echo ERROR: Username cannot be empty!
    pause
    exit /b 1
)

echo.
echo Tagging thinkify-client image...
docker tag thinkify-client:latest %DOCKER_USERNAME%/thinkify-client:latest
docker tag thinkify-client:latest %DOCKER_USERNAME%/thinkify-client:v1.0.0

echo Tagging thinkify-server image...
docker tag thinkify-server:latest %DOCKER_USERNAME%/thinkify-server:latest
docker tag thinkify-server:latest %DOCKER_USERNAME%/thinkify-server:v1.0.0

echo.
echo Step 3: Pushing images to Docker Hub
echo This may take several minutes depending on your internet connection...

echo.
echo Pushing client image...
docker push %DOCKER_USERNAME%/thinkify-client:latest
docker push %DOCKER_USERNAME%/thinkify-client:v1.0.0

echo.
echo Pushing server image...
docker push %DOCKER_USERNAME%/thinkify-server:latest
docker push %DOCKER_USERNAME%/thinkify-server:v1.0.0

echo.
echo ================================
echo DEPLOYMENT COMPLETED SUCCESSFULLY!
echo ================================
echo.
echo Your Docker Hub URLs:
echo Client Image: https://hub.docker.com/r/%DOCKER_USERNAME%/thinkify-client
echo Server Image: https://hub.docker.com/r/%DOCKER_USERNAME%/thinkify-server
echo.
echo SUBMISSION URLS:
echo 1. Original Repository: https://github.com/masum184e/thinkify
echo 2. Your Forked Repository: https://github.com/23IT098-VRAJ/thinkify
echo 3. Client Docker Image: https://hub.docker.com/r/%DOCKER_USERNAME%/thinkify-client
echo 4. Server Docker Image: https://hub.docker.com/r/%DOCKER_USERNAME%/thinkify-server
echo.
pause
