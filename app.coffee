app = require('express').createServer();
prooferb = require './prooferb'

app.get('/', (req, res) ->
  res.send('Welcome to Prooferb.  Go to /a/b to generate a proof of the equivalence of \'a\' and \'b\'.<br><br>For example, visit <a href="/money/awesome">/money/awesome</a> to prove that money is awesome.');
);

app.get('/:start/:goal', (req, res) ->
    path = prooferb.path(req.params.start, req.params.goal,
        (path) ->
            return if res.finished
            proof = prooferb.to_proof(path)
            res.send(proof)
    )
)

app.listen(3000);