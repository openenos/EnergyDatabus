/*!
 * Author:
 *      Amzur Technologies
 * Date:
 *      Mar 2nd 2015
 * Description:
 *      routes and passport authentication
 !**/

var express = require('express'),
    router = express.Router(),
    passport = require('passport'),
    LocalStrategy = require('passport-local').Strategy,
    crypto = require('crypto'),
    flash = require('connect-flash'),
    userService = require('../services/userServices'),
    User = require('../models/user');

passport.serializeUser(function(user, done) {
  done(null, user.id);
});

passport.deserializeUser(function(id, done) {
  User.findById(id, function(err, user) {
    done(err, user);
  });
});

passport.use('login', new LocalStrategy({
    passReqToCallback : true
  },
  function(req, username, password, done) { 
    userService.checkLogin(req, username, password, done);
}));

router.get('/', function(req, res) {
  res.render('login', { message: req.flash('message') });
});
  
router.post('/login', passport.authenticate('login', {
    successRedirect: '/dashboard',
    failureRedirect: '/',
    failureFlash : true 
}));
/*
router.get('/signup', function(req, res){
  res.render('register',{ message: req.flash('message')});
});
*/
router.post('/signup', passport.authenticate('signup', {
  successRedirect: '/',
  failureRedirect: '/signup',
  failureFlash : true 
}));  

router.get('/signout', function(req, res) {
  req.logout();
  res.redirect('/');
});

router.get('/dashboard', function(req, res){
  if(req.isAuthenticated()){
    res.render('dashboard',{ message: req.flash('message')});
  } else {
    req.flash('message', 'Please login');
    res.render('login', { message: req.flash('message') });
  }   
});

module.exports = router;
