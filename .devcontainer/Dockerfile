# Use the base image specified in the devcontainer.json
FROM mcr.microsoft.com/devcontainers/base:ubuntu

# Install necessary packages
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    wget \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Correct the Flutter URL
ENV FLUTTER_VERSION=3.29.2-stable
ENV FLUTTER_URL=https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}.tar.xz

# Verify the URL before downloading
RUN echo "Downloading Flutter from ${FLUTTER_URL}" && \
    wget -q ${FLUTTER_URL} -O flutter.tar.xz && \
    tar -xf flutter.tar.xz && \
    rm flutter.tar.xz && \
    mv flutter /home/vscode/flutter && \
    echo "export PATH=\"/home/vscode/flutter/bin:\${PATH}\"" >> /home/vscode/.bashrc && \
    chown -R vscode:vscode /home/vscode/flutter

# Set the default user to vscode
USER vscode

# Add Flutter to PATH
ENV PATH="/home/vscode/flutter/bin:${PATH}"

# Enable Flutter web support
RUN flutter config --enable-web

# Pre-download Flutter dependencies
RUN flutter precache

# Accept Android licenses (if Android SDK is installed)
RUN yes | flutter doctor --android-licenses || true

# Run Flutter doctor
RUN flutter doctor

# Set the working directory
WORKDIR /workspaces/payments