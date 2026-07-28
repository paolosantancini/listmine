const express = require("express");

const controller =
    require("../controllers/listController");

const router = express.Router();

router.post(
    "/lists",
    controller.openList
);

module.exports = router;
