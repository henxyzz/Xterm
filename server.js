const express = require("express");
const http = require("http");
const { Server } = require("socket.io");
const pty = require("node-pty");
const path = require("path");

const app = express();
const server = http.createServer(app);
const io = new Server(server);

app.use(express.static("public"));

app.get("/", (req, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

io.on("connection", (socket) => {
  const shell = pty.spawn("bash", [], {
    name: "xterm-color",
    cols: 80,
    rows: 24,
    cwd: process.env.HOME,
    env: process.env,
  });

  shell.on("data", (data) => {
    socket.emit("output", data);
  });

  socket.on("input", (input) => {
    shell.write(input);
  });

  socket.on("resize", (size) => {
    shell.resize(size.cols, size.rows);
  });

  socket.on("disconnect", () => {
    shell.kill();
  });
});

server.listen(8080, () => {
  console.log("Terminal online jalan di http://localhost:3000");
});
