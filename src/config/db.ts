import "dotenv/config"
import mysql from "mysql2/promise"
import { logger } from "./logger.js";


const pool = mysql.createPool({
    database: process.env.DB_NAME!,
    host: process.env.DB_HOST!,
    user: process.env.DB_USER!,
    password: process.env.DB_PASSWORD!,
    port: Number(process.env.DB_PORT),
    connectionLimit: 10,
    queueLimit: 0,
    waitForConnections: true
})

const testDB = async () => {
    try {
        const connection = await pool.getConnection();
        logger.info("Database Connected")
        connection.release()
    } catch (error) {
        logger.error("Database Connenction failed: " + error)
    }
}

testDB();
