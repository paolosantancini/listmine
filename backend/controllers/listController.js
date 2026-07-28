const service = require("../services/listService");

exports.openList = async (req, res) => {

    try {

        const list = await service.openList(
            req.body.id
        );

        res.json(list);

    } catch (err) {

        console.error(err);

        res.status(500).json({
            error: err.message
        });

    }

};
