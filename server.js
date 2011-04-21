(function() {
  var app, coffeekup, prooferb;
  app = require('express').createServer();
  prooferb = require('./prooferb');
  coffeekup = require('coffeekup');
  app.register('.coffee', require('coffeekup'));
  app.set('view engine', 'coffee');
  app.set('view options', {
    layout: false
  });
  app.get('/', function(req, res) {
    return res.render('home');
  });
  app.get('/:start/:goal', function(req, res) {
    var path;
    return path = prooferb.path(req.params.start, req.params.goal, function(path) {
      if (res.finished) {
        return;
      }
      return res.render('proof', {
        context: {
          path: path
        }
      });
    });
  });
  app.listen(9511);
}).call(this);
