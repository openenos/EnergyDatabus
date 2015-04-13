"use strict";

var fetchDataFromWS = require("../helpers/helper").fetchDataFromWS;

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
    getAllChannels: getAllChannels,
    getCurrentDemand: getCurrentDemand,
    getMonthValue: getMonthValue,
    getDayWeekMonthYearJsonReport: getDayWeekMonthYearJsonReport
};
