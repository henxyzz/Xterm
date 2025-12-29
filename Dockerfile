FROM ubuntu:22.04

LABEL maintainer="anakterminal@localhost"
LABEL description="Dockerfile for Online Terminal using Node.js + xterm.js + pty.js"

# Install dependency dasar + pm2 + bersihin warning apt-utils
RUN apt-get update && apt-get upgrade -y && \
  apt-get install -y \
  lsof \
  ffmpeg \
  git \
  nodejs \
  webp \
  wget \
  imagemagick \
  bash \
  python3 \
  python3-pip \
  nano \
  apt-utils \
  && rm -rf /var/lib/apt/lists/*

# Buat folder kerja
WORKDIR /app

# Copy package.json dan install dependencies
COPY package*.json ./
RUN npm install

# Copy seluruh source code
COPY . .

# Expose port
EXPOSE 8080

# Jalankan server dengan PM2
CMD ["npm", "start"]
