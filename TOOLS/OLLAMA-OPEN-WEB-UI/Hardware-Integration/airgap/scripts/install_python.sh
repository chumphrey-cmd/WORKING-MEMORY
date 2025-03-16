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