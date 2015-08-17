"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS, channelService = require("../services/ChannelService");

function create(req, res) {
  channelService.createChannel(req.body.tablePrefix, req.body.displayName, req.body.channelNumber, req.body.active, req.body.input, req.body.isProducing, req.body.doubleCT, req.body.doubleBreaker, req.body.breakerNumber, req.body.breakerSize, req.body.elecLoadType, req.body.CTSensotType, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

function getAllChannels(req, res) {
  fetchDataFromWS('/site_circuit/getAllChannelsListBySiteRef.json?site_ref=HGV1', res);
}

function getCurrentDemand(req, res) {
  fetchDataFromWS('/site_circuit/currentDemand.json?site_ref=HGV1&channel=2', res);
}

function getMonthValue(req, res) {
  fetchDataFromWS('/site_circuit/channelMonthValue.json?site_ref=HGV1&channel=2', res);
}

function getDayWeekMonthYearJsonReport(req, res) {
  fetchDataFromWS('/site_circuit/getDayWeekMonthYearJsonReport.json?site_ref=HGV1&date=24-03-2015&type=day&days=0&channel=2&offset=-330', res);
}

module.exports = {
    create: create,
    getAllChannels: getAllChannels,
    getCurrentDemand: getCurrentDemand,
    getMonthValue: getMonthValue,
    getDayWeekMonthYearJsonReport: getDayWeekMonthYearJsonReport
};
