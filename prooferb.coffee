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


to_proof = (path) ->
    proof = "<h1>Proof of the equivalency of <em>#{path[0]}</em> and <em>#{path[path.length-1]}</em></h1>"
    
    if not path
        proof += "Proof could not be found.  These things may not be equivalent.  Please adjust your wordlview accordingly."
        return proof
    
    proof += "<table style='border: 0px collapse;'>"
    
    for step in [0...path.length - 1]
        proof += "<tr>"
        proof += "<td style='padding-right: 30px'>#{step}."
        proof += "<td style='padding-right: 30px'>#{path[step]}"
        proof += "<td style='padding-right: 30px'>is"
        proof += "<td style='padding-right: 30px'>#{path[step+1]}"
        proof += "</tr>"
    proof += "</table>"
    proof += "<p>By n-transitivity, #{path[0]} is #{path[path.length-1]}. <strong>QED</strong></p>"
    
    return proof


exports.path = path
exports.to_proof = to_proof
