app = require('express').createServer();
prooferb = require './prooferb'

app.get('/', (req, res) ->
  res.send('hello world');
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