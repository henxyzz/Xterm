# Menggunakan image Node.js 20 sebagai base image
FROM node:20

# Menambahkan label untuk maintainer dan deskripsi
LABEL maintainer="anakterminal@localhost"
LABEL description="Dockerfile for Online Terminal using Node.js + xterm.js + pty.js"

# Memperbarui apt dan menginstal dependensi dasar
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y \
    ffmpeg \
    git \
    wget \
    imagemagick \
    bash \
    libwebp \
    && rm -rf /var/lib/apt/lists/*

# Menetapkan folder kerja
WORKDIR /app

# Menyalin package.json dan package-lock.json, kemudian instal dependencies
COPY package*.json ./
RUN npm install

# Menyalin semua kode sumber ke dalam container
COPY . .

# Menentukan port yang akan diekspos
EXPOSE 8080

# Menjalankan server menggunakan Node.js
CMD ["node", "server.js"]
