/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Apr 10th 2015
 !**/
 
"use strict";

//require("./function-utils");

var crypto = require('crypto'),
    config = require("../config/config"),
    request = require("request");
var helper = {};

/**
 * Hash a password.
 * @param {String} password the password to hash
 * @return {String} the password hash
 */
helper.hashPassword = function (password) {
    var pass = crypto.pbkdf2Sync(password, config.security.salt, config.security.iterations, config.security.keylen);
    return new Buffer(pass, "binary").toString("hex");
};

module.exports = {
    helper: helper
};

