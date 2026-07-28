const db = require("../db");

exports.openList = async (id) => {

    const code = id.trim().toUpperCase();

    const [rows] = await db.execute(
        "SELECT id FROM lists WHERE id = ?",
        [code]
    );

    if (rows.length === 0) {

        await db.execute(
            "INSERT INTO lists(id) VALUES(?)",
            [code]
        );

    }

    return {
        id: code
    };
};
