#!/bin/bash
set -e

echo "Starting airgapped installation of Ollama + OpenWebUI..."

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