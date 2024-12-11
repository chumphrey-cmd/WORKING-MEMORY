# Open WebUI Local Deployment Guide

## Prerequisites
1. [Install WSL2](https://learn.microsoft.com/en-us/windows/wsl/install)
2. [Install Docker Desktop for Windows](https://docs.docker.com/desktop/setup/install/windows-install/): follow steps listed in documentation.
3. [Install Ollama](https://ollama.com/download/windows)

## Initial Setup

### 1. Start Ollama
```bash
ollama serve
```

### 2. Pull Base Models
```bash
# Pull your preferred models
ollama pull [YOUR_MODEL]
```

#### **Configuration Steps** 

**Install VS Code**:  
   - Download and install [VS Code](https://code.visualstudio.com/).  
   - Add the **Docker Extension** by Microsoft from the Extensions view (`Ctrl+Shift+X`). 

**Verify Docker with WSL2 Integration**:  
   - Open Docker Desktop as Administrator and go to:  
     - *Settings > General*: Enable "Use the WSL 2 based engine."  
     - *Settings > Resources > WSL Integration*: Enable Docker for your Linux distributions.  

### Docker User Management
- Open PowerShell as Administrator

```
# Create docker-users group (if not exists)
net localgroup docker-users /add

# Add user to group
net localgroup docker-users YourUsername /add

# View group members
net localgroup docker-users

# Remove user from group
net localgroup docker-users YourUsername /delete
```

**Test Docker Functionality**:  
   - Open a terminal (PowerShell or WSL2) and run:  
     ```bash
     docker --version
     docker run hello-world
     ```
   - This confirms Docker is working properly.

### Pull Open WebUI Image

```bash
docker pull ghcr.io/open-webui/open-webui:main
```

### 3. Docker Container Setup (GPU support)
```bash
docker run -d -p 3000:8080 --gpus all -v open-webui:/app/backend/data --name open-webui ghcr.io/open-webui/open-webui:cuda
```

### 4. Verify Installation
1. Open browser to `http://localhost:3000`
2. Create administrator account (first account)
3. Verify Ollama connection in Settings
4. Test model inference

## Basic Configuration

### Model Settings
1. Navigate to Admin Settings
2. Configure default parameters:
   - Context length
   - Temperature
   - Top P value
   - Frequency penalty

### Chat Interface
1. Select model from dropdown
2. Create new chat
3. Test basic prompts
4. Verify markdown and code rendering

## Testing Features

### RAG Testing
1. Upload test document
2. Create new chat with RAG enabled
3. Query document content
4. Verify response accuracy

### Custom Models
1. Create basic modelfile
2. Test model creation:
```bash
ollama create custommodel --file custom.modelfile
```
3. Verify model appears in WebUI

## Maintenance

### Container Management
**Start Container**
```bash
docker start open-webui
```

**Stop Container**
```bash
docker stop open-webui
```

**View Logs**
```bash
docker logs open-webui
```

### Updates
```bash
# Pull latest image
docker pull ghcr.io/open-webui/open-webui:main

# Remove existing container
docker rm -f open-webui

# Run updated container
docker run -d -p 3000:8080 \
--add-host=host.docker.internal:host-gateway \
-v open-webui:/app/backend/data \
--name open-webui \
--restart always \
ghcr.io/open-webui/open-webui:main
```

## Next Steps
After successful local deployment:
1. Document working configuration
2. Plan enterprise security requirements
3. Design user access controls
4. Configure network access
5. Plan backup strategy