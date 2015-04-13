"use strict";

var winston = require('winston'),
    config = require("./config");
    winston.add(winston.transports.File, { filename: config.log_file });
    winston.remove(winston.transports.Console);

module.exports = winston;
