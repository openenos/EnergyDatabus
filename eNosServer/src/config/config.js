/*
 * Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
 */
/**
 * Contains general configuration for app.
 *
 * @version 1.0
 * @author TCSASSEMBLER
 */
"use strict";

var env = require('node-env-file'),
    path = require("path");

env(path.join(__dirname, "../../.env"));

/**
 * Get an environmental setting
 * @param {String} name the name of setting
 * @returns {String} the value
 * @throws {Error} if setting is not defined
 */
function getEnv(name) {
    if (!process.env.hasOwnProperty(name)) {
        throw new Error("Env setting: " + name + " is not configured!");
    }
    return process.env[name].trim();
}

module.exports = {
    db: getEnv("DB"),
    db_host: getEnv("DB_HOST"),
    db_port: getEnv("DB_PORT"),
    db_user: getEnv("DB_USER"),
    db_password: getEnv("DB_PASSWORD"),
    kairosdb_host: getEnv("KAIROSDB_HOST"),
    kairosdb_port: getEnv("KAIROSDB_PORT"),
    wunderground: getEnv("WUNDERGROUND"),
    log_file: getEnv("LOG_FILE")
/*    sessionSecret: getEnv("SESSION_SECRET"),
    mongodbUrl: getEnv("MONGODB_URL"),
    databus: {
        databaseName: getEnv("DATABUS_DATABASE_NAME"),
        apiUrl: getEnv("DATABUS_API_URL")
    },
    kwChartInterval: 5*60*1000,
    chartIntervalTime: 5*60*1000,
    security: {
        salt: getEnv("SECURITY_SALT"),
        iterations: 100,
        keylen: 16
    }
*/
};
