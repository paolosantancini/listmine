const express = require("express");

const router = express.Router();

const controller = require("../controllers/taskController");

router.get(
    "/lists/:listId/tasks",
    controller.getTasks
);

router.post(
    "/lists/:listId/tasks",
    controller.createTask
);

router.put(
    "/tasks/:id",
    controller.updateTask
);

router.delete(
    "/tasks/:id",
    controller.deleteTask
);

module.exports = router;
