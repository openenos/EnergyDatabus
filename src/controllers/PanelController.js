"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS, panelService = require("../services/PanelService");

function create(req, res) {
  panelService.createPanel(req.body.tablePrefix, req.body.displayName, req.body.url, req.body.noOfCircuitsSupport, req.body.amp, req.body.channels, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

module.exports = {
    create: create
};
