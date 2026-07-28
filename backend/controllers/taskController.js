const service = require("../services/taskService");
const socket = require("../socket/socketManager");

// GET /api/lists/:listId/tasks
exports.getTasks = async (req, res) => {
    try {

        const tasks = await service.getTasks(req.params.listId);

        res.json(tasks);

    } catch (err) {

        console.error(err);
        res.status(500).json({
            error: err.message
        });

    }
};

// POST /api/lists/:listId/tasks
exports.createTask = async (req, res) => {
    try {

        const task = await service.createTask(
            req.params.listId,
            req.body.title
        );

        socket.emitTaskCreated(
            req.params.listId,
            task
        );

        res.status(201).json(task);

    } catch (err) {

        console.error(err);
        res.status(500).json({
            error: err.message
        });

    }
};

// PUT /api/tasks/:id
exports.updateTask = async (req, res) => {
    try {

        const task = await service.updateTask(
            req.params.id,
            req.body
        );

        if (!task) {
            return res.status(404).json({
                error: "Task non trovata"
            });
        }

        socket.emitTaskUpdated(
            task.list_id,
            task
        );

        res.json(task);

    } catch (err) {

        console.error(err);
        res.status(500).json({
            error: err.message
        });

    }
};

// DELETE /api/tasks/:id
exports.deleteTask = async (req, res) => {
    try {

        const task = await service.deleteTask(req.params.id);

        if (!task) {
            return res.status(404).json({
                error: "Task non trovata"
            });
        }

        socket.emitTaskDeleted(
            task.list_id,
            task.id
        );

        res.json({
            success: true
        });

    } catch (err) {

        console.error(err);
        res.status(500).json({
            error: err.message
        });

    }
};
