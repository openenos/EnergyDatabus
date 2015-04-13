"use strict";

var request = require("request"), fetchDataFromWS = require("../helpers/helper").fetchDataFromWS;

function getPowerUsage(req, res) {
  fetchDataFromWS('/home/getCurrentDemandSolarPowerUtilityPower.json?group_id='+req.param('group_id'), res);
}

function getPast30DaysUsage(req, res) {
  fetchDataFromWS('/home/getGroupAllSitesChannelsUsageList.json?group_id='+req.param('group_id'), res);
}

function getLast12MonthsData(req, res) {
  fetchDataFromWS('/home/last12MonthsData.json?group_id='+req.param('group_id'), res);
}

function getAllGroups(req, res) {
    request({
    headers: {
      'Content-Type': 'application/json'
    },
    uri: "http://localhost:3001/home/index.json?group_id="+req.param('group_id'),
    method: 'GET'
     }, function (err, response, body) {
      res.end(JSON.stringify(JSON.parse(body)[0]));
    });    
}

function getPastDaysUsage(req, res) {
    request({
    headers: {
      'Content-Type': 'application/json'
    },
    uri: "http://localhost:3001/home/index.json?group_id="+req.param('group_id'),
    method: 'GET'
     }, function (err, response, body) {
      res.end(JSON.stringify(JSON.parse(body)[1]));
    });    
}

module.exports = {
    getPowerUsage: getPowerUsage,
    getPast30DaysUsage: getPast30DaysUsage,
    getLast12MonthsData: getLast12MonthsData,
    getAllGroups: getAllGroups,
    getPastDaysUsage: getPastDaysUsage
};
