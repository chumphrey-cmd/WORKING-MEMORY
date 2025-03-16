# Structure, Deployment Process, and Installation

# Part 1: Online Package Creation (WSL2)

## Directory Structure
```plaintext
airgap-deployment/
├── python/
│   ├── source/          # Python 3.11.8 source code
│   └── deps/            # Python build dependencies
├── docker/
│   └── deps/           # Docker RPM packages
├── ollama/
│   ├── models/         # Model files
│   └── ollama         # Linux binary
├── openwebui/
│   ├── source/         # OpenWebUI source
│   └── packages/       # Python packages
└── scripts/            # Installation scripts
```

## Collection Steps

### 1. Create Base Structure
```bash
mkdir -p airgap-deployment/{python/{source,deps},docker/deps,ollama/models,openwebui/{source,packages},scripts}
cd airgap-deployment
```

### 2. Download Python Source and Dependencies
```bash
# Download Python source
wget https://www.python.org/ftp/python/3.11.8/Python-3.11.8.tgz -O python/source/Python-3.11.8.tgz

Downloading Rocky 8.10 for RHEL 8 Compatibility
wsl --import rocky8_10 "C:\Program Files\WSL\rocky8_10" "C:\Users\Chuma-Lab\Downloads\Rocky-8-Container-Base.latest.x86_64.tar.xz" --version 2

sudo yum -y update
yum install dnf-plugins-core yum-utils createrepo -y

# Download Python build dependencies
dnf --releasever=8 download --resolve --alldeps -y \
    gcc make zlib-devel bzip2-devel openssl-devel sqlite-devel \
    libffi-devel readline-devel ncurses-devel tk-devel \
    gdbm-devel xz-devel libuuid-devel python3-pip \
    --destdir=./
```

### 3. Download Docker Packages
```bash
cd docker/deps

# Download specific Docker packages
wget https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/containerd.io-1.7.25-3.1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-ce-27.5.1-1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-ce-cli-27.5.1-1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-buildx-plugin-0.20.0-1.el8.x86_64.rpm \
     https://download.docker.com/linux/rhel/8/x86_64/stable/Packages/docker-compose-plugin-2.32.4-1.el8.x86_64.rpm
```

### 4. Download and Prepare Ollama
```bash
cd ollama

# Download and extract Ollama
curl -L https://ollama.com/download/ollama-linux-amd64.tgz -o ollama
chmod +x ollama

# Pull model and copy to models directory
./ollama pull mistral
cp -r ~/.ollama/models/* models/

```

### 5. Prepare OpenWebUI
```bash
# Clone OpenWebUI repository
git clone https://github.com/open-webui/open-webui.git openwebui/source

# Download Python packages
mkdir -p wheel
pip3.11 download -r requirements.txt -d wheel

cd ..
```
### 6. Create Installation Scripts

**scripts/install.sh**

```bash
#!/bin/bash
set -e

echo "=== Starting airgapped installation of Ollama + OpenWebUI ==="

# 1. Install Python
./install_python.sh

# 2. Install Docker
./install_docker.sh

# 3. Setup Ollama
./setup_ollama.sh

# 4. Setup OpenWebUI
./setup_openwebui.sh

echo "=== Installation complete! Verifying services... ==="
./verify.sh
```


**`scripts/install_python.sh`**
```bash
#!/bin/bash
set -e

echo "Installing Python 3.11 dependencies..."
cd python/deps
sudo rpm -ivh *.rpm

echo "Installing Python 3.11..."
cd ../source
tar xzf Python-3.11.8.tgz
cd Python-3.11.8

./configure --enable-optimizations \
    --with-system-ffi \
    --enable-loadable-sqlite-extensions \
    --prefix=/usr/local

make -j $(nproc)
sudo make altinstall

echo "Setting up Python alternatives..."
sudo update-alternatives --install /usr/bin/python3 python3 /usr/local/bin/python3.11 1
sudo ldconfig

echo "Verifying installation..."
python3.11 --version
cd ../..
```

**scripts/install_docker.sh:**
```bash
#!/bin/bash
set -e

echo "Installing Docker packages..."
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

echo "Docker installation complete."
cd ..
```

**setup_ollama.sh:**
```bash
#!/bin/bash
set -e

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

cd ..
```

**scripts/setup_openwebui.sh:**
```bash
#!/bin/bash
set -e

echo "=== Setting up OpenWebUI ==="

cd openwebui/source
python3.11 -m pip install --no-index --find-links=../packages -r requirements.txt

cat << EOF | sudo tee /etc/systemd/system/openwebui.service
[Unit]
Description=OpenWebUI Service
After=ollama.service

[Service]
ExecStart=/usr/local/bin/python3.11 $(pwd)/main.py --host 0.0.0.0 --port 5000
Restart=always
CPUQuota=200%
MemoryMax=16G
Environment="PATH=/usr/local/bin:/usr/bin:/bin"

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable openwebui
sudo systemctl start openwebui
```

**verify.sh:**
```bash
#!/bin/bash
set -e

echo "Verifying Python installation..."
python3.11 --version
python3.11 -m pip --version

echo "Verifying Docker installation..."
docker --version
docker compose version

echo "Verifying Ollama service..."
systemctl status ollama
curl -s http://localhost:11434/api/version

echo "Verifying OpenWebUI service..."
systemctl status openwebui
curl -s http://localhost:5000/health

echo "Checking Python packages..."
python3.11 -m pip list
```

### 7. Create Final Package
```bash
# Make all scripts executable
chmod +x scripts/*.sh

# Create deployment package
tar czf ../airgap-deployment.tar.gz .
```

# Part 2: Offline Deployment (RHEL)

## Installation Steps

### 1. Transfer and Extract Package
```bash
# Copy airgap-deployment.tar.gz to RHEL system
tar xzf airgap-deployment.tar.gz
cd airgap-deployment
```

### 2. Sequential Installation

```bash
# 1. Install Python 3.11
./scripts/install_python.sh

# Verify Python
python3.11 --version
python3.11 -m pip --version

# 2. Install Docker
./scripts/install_docker.sh

# Verify Docker
docker --version
docker compose version

# 3. Setup Ollama
./scripts/setup_ollama.sh

# Verify Ollama
systemctl status ollama
curl http://localhost:11434/api/version

# 4. Setup OpenWebUI
./scripts/setup_openwebui.sh

# Verify OpenWebUI
systemctl status openwebui
curl http://localhost:5000/health
```

### 3. Comprehensive Verification
```bash
# Run complete verification suite
./scripts/verify.sh

# Additional Python checks
python3.11 -c "import ssl; print(ssl.OPENSSL_VERSION)"
python3.11 -c "import sqlite3; print(sqlite3.sqlite_version)"

# Check service resource allocation
systemctl show ollama | grep CPU
systemctl show ollama | grep Memory
systemctl show openwebui | grep CPU
systemctl show openwebui | grep Memory

# Verify all services
systemctl status docker
systemctl status ollama
systemctl status openwebui
```

### Resource Allocation
- Ollama: 60 CPU cores (CPUQuota=6000%), 400GB RAM
- OpenWebUI: 2 CPU cores (CPUQuota=200%), 16GB RAM


## Troubleshooting Tips
1. Check service logs:
```bash
journalctl -u ollama
journalctl -u openwebui
journalctl -u docker
```

2. Verify permissions:
```bash
ls -l /usr/share/ollama/models
ls -l /usr/bin/ollama
```

3. Check resource usage:
```bash
top
free -h
df -h
```
