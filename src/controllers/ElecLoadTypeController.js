"use strict";

var loadtypeService = require("../services/ElecLoadTypeService");

function create(req, res) {
  loadtypeService.createLoadType(req.body.tablePrefix, req.body.displayName, req.body.loadType, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

module.exports = {
    create: create
};
