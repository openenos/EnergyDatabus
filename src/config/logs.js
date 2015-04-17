/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 * Description:
 *      create logger
 !**/

"use strict";

var winston = require('winston'),
    config = require("./config");
    winston.add(winston.transports.File, { filename: config.log_file });
    
module.exports = winston;
