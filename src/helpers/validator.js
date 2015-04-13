/*
 * Copyright (C) 2015 TopCoder Inc., All Rights Reserved.
 */
/**
 * Contains validation functions
 *
 * @version 1.0
 * @author TCSASSEMBLER
 */
"use strict";

var validator = require('rox').validator;

/**
 * Define a global function used for validation.
 * @param {Object} input the object to validate
 * @param {Object} definition the definition object. Refer to rox module for more details.
 * @param {String} [prefix] the prefix for error message.
 * @returns {Error|Null} error if validation failed or null if validation passed.
 */
function validate(input, definition, prefix) {
    var error = validator.validate(prefix || "prefix-to-remove", input, definition);
    if (!error) {
        return null;
    }
    //remove prefix in error message
    error.message = error.message.replace("prefix-to-remove.", "");
    //if input is invalid then change the name to input
    error.message = error.message.replace("prefix-to-remove", "input");
    error.httpStatus = 400;
    return error;
}


//MongoDB id
validator.registerType({
    name: "objectId",
    /**
     *
     * Validate if value is valid ObjectId
     * @param {String} name the property name
     * @param {*} value the value to check
     * @returns {Error|Null} null if value is valid or error if invalid
     */
    validate: function (name, value) {
        var notString = validator.validate(name, value, "string");
        if (notString || !/^[a-zA-Z0-9]{24}$/.test(value)) {
            return new Error(name + " should be a valid ObjectId (24 hex characters)");
        }
        return null;
    }
});


module.exports = {
    validate: validate
};