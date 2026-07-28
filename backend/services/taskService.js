const db = require("../db");

exports.getTasks = async(listId)=>{

    const [rows] = await db.execute(

        `
        SELECT
            id,
            title,
            done
        FROM tasks
        WHERE list_id=?
        ORDER BY done,title
        `,

        [listId]

    );

    return rows;

};

exports.addTask = async(listId,title)=>{

    const [result] = await db.execute(

        `
        INSERT INTO tasks
        (
            list_id,
            title
        )
        VALUES
        (
            ?,
            ?
        )
        `,

        [listId,title]

    );

    const [rows]=await db.execute(

        `
        SELECT *
        FROM tasks
        WHERE id=?
        `,

        [result.insertId]

    );

    return rows[0];

};

exports.updateTask = async(id,data)=>{

    const fields = [];
    const values = [];

    if (Object.prototype.hasOwnProperty.call(data, "title")) {
        fields.push("title = ?");
        values.push(data.title);
    }

    if (Object.prototype.hasOwnProperty.call(data, "done")) {
        fields.push("done = ?");
        values.push(data.done);
    }

    if (fields.length === 0) {
        throw new Error("Nessun campo da aggiornare.");
    }

    values.push(id);

    const sql = `
        UPDATE tasks
        SET ${fields.join(", ")}
        WHERE id = ?
    `;

    await db.execute(sql, values);

    return await exports.getTaskById(id);

};

exports.deleteTask = async(id)=>{

    const task = await exports.getTaskById(id);

    await db.execute(

        `
        DELETE FROM tasks
        WHERE id=?
        `,

        [id]

    );

    return task;
};

exports.createTask = async(listId,title)=>{

    const [result] = await db.execute(

        `
        INSERT INTO tasks
        (list_id,title)
        VALUES (?,?)
        `,

        [listId,title]

    );

    return await exports.getTaskById(
        result.insertId
    );

};

exports.getTaskById = async(id)=>{

    const [rows] = await db.execute(

        `
        SELECT *
        FROM tasks
        WHERE id=?
        `,

        [id]

    );

    return rows[0];

};

exports.getListId = async(id)=>{

    const [rows] = await db.execute(

        `
        SELECT list_id
        FROM tasks
        WHERE id=?
        `,

        [id]

    );

    if(rows.length==0){

        return null;

    }

    return rows[0].list_id;

};
