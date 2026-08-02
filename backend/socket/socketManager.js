let io;

function initialize(server) {

    const { Server } = require("socket.io");

    io = new Server(server, {

	path: "/listmine/socket.io/",
        cors: {

           origin: "*"

        }
    });

    io.on("connection", (socket) => {

        console.log("Client:", socket.id);

        socket.on("join-list", (listId) => {

            socket.join(listId);

            console.log(
                socket.id,
                "joined",
                listId
            );

        });

        socket.on("join-list", (listId) => {

            socket.join(listId);

        });

        socket.on("leave-list", (listId) => {

            socket.leave(listId);

        });

        socket.on("disconnect", () => {

            console.log("Disconnected");

        });

    });

}

function emitTaskCreated(listId, task) {

    io.to(listId)
      .emit("taskCreated", task);

}

function emitTaskUpdated(listId, task) {

    io.to(listId)
      .emit("taskUpdated", task);

}

function emitTaskDeleted(listId, taskId) {

    io.to(listId)
      .emit("taskDeleted", {

          id: taskId

      });

}

module.exports = {

    initialize,

    emitTaskCreated,

    emitTaskUpdated,

    emitTaskDeleted

};
