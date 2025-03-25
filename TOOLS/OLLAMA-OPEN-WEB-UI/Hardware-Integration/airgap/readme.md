# Structure, Deployment Process, and Installation

# Part 1: Online Package Creation (WSL2)

## Directory Structure
```plaintext
airgap/
├── docker/
│   └── deps/           # Docker RPM packages
├── ollama/
│   ├── models/         # Model files
│   └── ollama         # Linux binary
├── openwebui/
│   ├── openwebui_image.tar     # OpenWebUI Docker source
└── scripts/            #  Will serve as the location for future installation 
```

## Collection Steps

### 1. Create Base Structure
```bash
mkdir -p airgap-deployment/{python/{source,deps},docker/deps,ollama/models,openwebui/{source,packages},scripts}
cd airgap-deployment
```

### 2. Download Docker Packages
```bash
cd docker/deps

# Download specific Docker packages
wget https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/containerd.io-1.7.25-3.1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-ce-27.5.1-1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-ce-cli-27.5.1-1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-buildx-plugin-0.20.0-1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-compose-plugin-2.32.4-1.el8.x86_64.rpm
```

### 3. Download and Prepare Ollama
```bash
cd ollama

# Download and extract Ollama
curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama
chmod +x ollama

# Pull model and copy to models directory
./ollama pull mistral
cp -r ~/.ollama/models/* models/

```

### 4. Prepare OpenWebUI
   ```bash
   # Pull OpenWebUI image
   docker pull ghcr.io/open-webui/open-webui:latest
   
   # Save image as tarball
   docker save ghcr.io/open-webui/open-webui:latest > openwebui_image.tar
   ```


### 5. Create deployment package
```bash 
tar -czf airgap-deployment.tar.gz airgap/
```


# Part 2: Offline Deployment (RHEL)

## Installation Steps

### 1. Transfer and Extract Package
```bash
# Copy airgap-deployment.tar.gz to RHEL system
tar xzf airgap.tar.gz
cd airgap
```

### 2. Install Docker

```bash
cd docker/deps

# Install packages in correct order
sudo rpm -i containerd.io-*.rpm
sudo rpm -i docker-ce-cli-*.rpm
sudo rpm -i docker-ce-*.rpm
sudo rpm -i docker-buildx-plugin-*.rpm
sudo rpm -i docker-compose-plugin-*.rpm

# Start and enable Docker service
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
docker --version
docker compose version
```


### 3. Install Ollama
```bash

# Create ollama user and group
sudo useradd -r -s /bin/false -U -m -d /usr/share/ollama ollama
sudo usermod -a -G ollama $(whoami)

# Extract Ollama to /usr
sudo tar -C /usr -xzf ollama/ollama-linux-amd64.tgz

# Create models directory
sudo install -d -m 755 -o ollama -g ollama /usr/share/ollama
sudo install -d -m 755 -o ollama -g ollama /usr/share/ollama/models

# Copy models
sudo cp -r ollama/models/* /usr/share/ollama/models/
sudo chown -R ollama:ollama /usr/share/ollama/models

# Create systemd service
cat << EOF | sudo tee /etc/systemd/system/ollama.service
[Unit]
Description=Ollama Service
After=network-online.target

[Service]
ExecStart=/usr/bin/ollama serve
User=ollama
Group=ollama
Restart=always
RestartSec=3
CPUQuota=6000%
MemoryMax=400G
Environment="OLLAMA_MODELS=/usr/share/ollama/models"

[Install]
WantedBy=default.target
EOF

# Reload systemd and start service
sudo systemctl daemon-reload
sudo systemctl enable ollama
sudo systemctl start ollama
```

#### Ollama Resource Allocation
- Ollama: 60 CPU cores (CPUQuota=6000%), 400GB RAM
- OpenWebUI: 2 CPU cores (CPUQuota=200%), 16GB RAM

### 4. Install Open WebUI

```bash
# Load Docker image
docker load < openwebui_image.tar

# Create data directory
sudo mkdir -p /opt/openwebui/data

# Run container once to create it
docker run -d \
    --name openwebui \
    -v /opt/openwebui/data:/app/backend/data \
    -p 3000:8080 \
    -e OLLAMA_API_BASE_URL=http://localhost:11434 \
    ghcr.io/open-webui/open-webui:latest

# Stop container (we'll manage it with systemd)
docker stop openwebui

# Create systemd service
cat << EOF | sudo tee /etc/systemd/system/openwebui.service
[Unit]
Description=OpenWebUI Container
After=docker.service ollama.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker start -a openwebui
ExecStop=/usr/bin/docker stop openwebui

[Install]
WantedBy=multi-user.target
EOF

# Start service
sudo systemctl daemon-reload
sudo systemctl enable --now openwebui
```

5. Verify Installation

```bash
# Check services
systemctl status ollama
systemctl status openwebui

# Test endpoints
curl http://localhost:11434/api/version
curl http://localhost:3000/health
```
