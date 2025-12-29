FROM ubuntu:22.04

LABEL maintainer="anakterminal@localhost"
LABEL description="Dockerfile for Online Terminal using Node.js + xterm.js + pty.js"

ENV DEBIAN_FRONTEND=noninteractive

# Install dependency dasar + build tools
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    curl \
    git \
    wget \
    bash \
    nano \
    lsof \
    ffmpeg \
    webp \
    imagemagick \
    python3 \
    python3-pip \
    build-essential \
    apt-utils \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js LTS (RESMI)
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs

# Cek biar gak halu
RUN node -v && npm -v

# Folder kerja
WORKDIR /app

# Install dependencies dulu (biar cache Docker kepake)
COPY package*.json ./
RUN npm install

# Copy source code
COPY . .

# Expose port
EXPOSE 8080

# Run app
CMD ["npm", "start"]
