"use strict";

var userService = require("../services/UserService");

function signup(req, res) {
  userService.createUser(req.body.username, req.body.password, req.body.apikey, req.body.tableprefix, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

function signin(req, res) {
  userService.getUserByName(req.body.username, function(status){
    res.writeHead(200, { 'Content-Type': 'application/json' });
    res.end(JSON.stringify({status: status}));
  });
}

module.exports = {
    signup: signup,
    signin: signin
};
