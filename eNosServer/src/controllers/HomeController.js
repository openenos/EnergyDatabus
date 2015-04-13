"use strict";

function login(req, res, next) {
  console.log("welcome");
}

function logout(req, res) {
    res.redirect("/");
}

module.exports = {
    login: login,
    logout: logout
};
