"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS, postalInfoService = require("../services/PostalInfoService");

function create(req, res) {
  postalInfoService.createPostalInfo(req.body.tablePrefix, req.body.postalCode, req.body.city, req.body.state, req.body.country, req.body.timezone, req.body.weatherRef, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

module.exports = {
    create: create
};
