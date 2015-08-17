/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      read configuration credentials
 !**/


"use strict";

var env = require('node-env-file'),
    path = require("path");

env(path.join(__dirname, "../../.env"));

function getEnv(name) {
    if (!process.env.hasOwnProperty(name)) {
        throw new Error("Env setting: " + name + " is not configured!");
    }
    return process.env[name].trim();
}

module.exports = {
    log_file: getEnv("LOG_FILE"),
    mysqldb: getEnv("MYSQLDB"),
    mysqldb_host: getEnv("MYSQLDB_HOST"),
    mysqldb_port: getEnv("MYSQLDB_PORT"),
    mysqldb_user: getEnv("MYSQLDB_USER"),
    mysqldb_password: getEnv("MYSQLDB_PASSWORD"),
    kairosdb_host: getEnv("KAIROSDB_HOST"),
    kairosdb_port: getEnv("KAIROSDB_PORT"),
    mongodb: getEnv("MONGODB"),
    mongodb_host: getEnv("MONGODB_HOST"),
    wunderground: getEnv("WUNDERGROUND"),
};
