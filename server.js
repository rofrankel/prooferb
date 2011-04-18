 (function() {
  var app, prooferb;
  app = require('express').createServer();
  prooferb = require('./prooferb');
  app.get('/', function(req, res) {
    return res.send('Welcome to Prooferb.  Go to /a/b to generate a proof of the equivalence of \'a\' and \'b\'.<br><br>For example, visit <a href="/money/awesome">/money/awesome</a> to prove that money is awesome.');
  });
  app.get('/:start/:goal', function(req, res) {
    var path;
    return path = prooferb.path(req.params.start, req.params.goal, function(path) {
      var proof;
      if (res.finished) {
        return;
      }
      proof = prooferb.to_proof(path);
      return res.send(proof);
    });
  });
  app.listen(9511);
}).call(this);
