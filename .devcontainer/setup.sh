#!/bin/bash

# Update and install necessary packages
sudo apt-get update && sudo apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    libglu1-mesa

# Install Flutter
FLUTTER_VERSION="3.29.2-stable"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz"

echo "Downloading Flutter SDK..."
wget -q $FLUTTER_URL -O flutter.tar.xz
echo "Extracting Flutter SDK..."
tar -xf flutter.tar.xz
rm flutter.tar.xz
mv flutter ~/flutter

# Add Flutter to PATH
echo "export PATH=\$PATH:~/flutter/bin" >> ~/.bashrc
export PATH=$PATH:~/flutter/bin

# Enable Flutter web support
flutter config --enable-web

# Pre-download Flutter dependencies
flutter precache

# Accept Android licenses (if Android SDK is installed)
yes | flutter doctor --android-licenses || true

# Run Flutter doctor
flutter doctor

echo "Devcontainer setup complete."