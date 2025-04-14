FROM node:20

LABEL maintainer="anakterminal@localhost"
LABEL description="Dockerfile for Online Terminal using Node.js + xterm.js + pty.js"

# Install dependensi + apt-utils biar gak warning
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    apt-utils \
    ffmpeg \
    git \
    wget \
    imagemagick \
    bash \
    libwebp-dev \
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

# Jalankan server
CMD ["node", "server.js"]
