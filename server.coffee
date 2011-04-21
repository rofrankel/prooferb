app = require('express').createServer()
prooferb = require './prooferb'

coffeekup = require './vendor/coffeekup/coffeekup'
    

app.register('.coffee', coffeekup)
app.set('view engine', 'coffee')
app.set('view options', layout: false)


app.get('/', (req, res) ->
  res.render 'home'
)

app.get('/:start/:goal', (req, res) ->
    path = prooferb.path(req.params.start, req.params.goal,
        (path) ->
            return if res.finished
            res.render('proof', context: {path})
    )
)

app.listen(9511)