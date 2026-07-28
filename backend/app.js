require("dotenv").config();

const express = require("express");
const cors = require("cors");
const http = require("http");
const socketManager = require("./socket/socketManager");

const config = require("./config");
const taskRoutes = require("./routes/tasks");
const listRoutes = require("./routes/lists");

const app = express();

app.use(cors());
app.use(express.json());

app.use("/api", taskRoutes);
app.use("/api", listRoutes);

const server = http.createServer(app);

socketManager.initialize(server);

server.listen(config.port, () => {

    console.log("Server avviato sulla porta", config.port);

});
