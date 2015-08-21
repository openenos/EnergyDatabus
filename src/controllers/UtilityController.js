"use strict";

var utilityService = require("../services/UtilityService");

function create(req, res) {
  utilityService.createUtility(req.body.tablePrefix, req.body.displayName, req.body.utilityType, req.body.baseRate, req.body.demand, req.body.tier1Rate, req.body.tier2Rate, req.body.tier3Rate, req.body.tier4Rate, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

module.exports = {
    create: create
};
