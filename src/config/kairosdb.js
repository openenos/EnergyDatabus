"use strict";

var kairosdb = require('kairosdb'),
    config = require("./config"),
    winston = require("./logs"),
    kairosdbConnection = kairosdb.init(config.kairosdb_host, config.kairosdb_port, {});
    
    module.exports = kairosdbConnection;
