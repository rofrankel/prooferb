graff = require 'graff'
google_suggest = require './util/googlesuggest'

theshold = 1000000

graph = new graff.Graph()

path = (start, goal, callback) ->
    graph.add_vertex(start)
    graph.add_vertex(goal)
    
    expand(start,
        do (graph, start, goal) ->
            ->
                path = graph.get_path(start, goal)
                if path then callback(path)
                return path
    )
    
    
expand = (phrase, done, expanded={}) ->
    if phrase of expanded
        return
    expanded[phrase] = 1
    known_children = (child for child of graph.vertices[phrase])
    if known_children.length and not done()
        for child in known_children
            expand(child, done, expanded)
    else
        google_suggest.suggest(phrase + ' is ',
            (completions) ->
                for completion in completions
                    graph.add_vertex(completion)
                    graph.connect(phrase, completion)
                    if not done()
                        expand(completion, done, expanded)
            
        )


exports.path = path
