FROM node:20

LABEL maintainer="anakterminal@localhost"
LABEL description="Dockerfile for Online Terminal using Node.js + xterm.js + pty.js"

# Buat folder kerja
WORKDIR /app

# Copy package dan install dependencies
COPY package*.json ./
RUN npm install

# Copy semua source code
COPY . .

# Expose port
EXPOSE 8080

# Jalankan server
CMD ["node", "server.js"]
