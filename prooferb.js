(function() {
  var expand, google_suggest, graff, graph, path, theshold, to_proof;
  graff = require('graff');
  google_suggest = require('./util/googlesuggest');
  theshold = 1000000;
  graph = new graff.Graph();
  path = function(start, goal, callback) {
    graph.add_vertex(start);
    graph.add_vertex(goal);
    return expand(start, (function(graph, start, goal) {
      return function() {
        var path;
        path = graph.get_path(start, goal);
        if (path) {
          callback(path);
        }
        return path;
      };
    })(graph, start, goal));
  };
  expand = function(phrase, done, expanded) {
    var child, known_children, _i, _len, _results;
    if (expanded == null) {
      expanded = {};
    }
    if (phrase in expanded) {
      return;
    }
    expanded[phrase] = 1;
    known_children = (function() {
      var _results;
      _results = [];
      for (child in graph.vertices[phrase]) {
        _results.push(child);
      }
      return _results;
    })();
    if (known_children.length && !done()) {
      _results = [];
      for (_i = 0, _len = known_children.length; _i < _len; _i++) {
        child = known_children[_i];
        _results.push(expand(child, done, expanded));
      }
      return _results;
    } else {
      return google_suggest.suggest(phrase + ' is ', function(completions) {
        var completion, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = completions.length; _i < _len; _i++) {
          completion = completions[_i];
          graph.add_vertex(completion);
          graph.connect(phrase, completion);
          _results.push(!done() ? expand(completion, done, expanded) : void 0);
        }
        return _results;
      });
    }
  };
  to_proof = function(path) {
    var proof, step, _ref;
    proof = "<h1>Proof of the equivalency of <em>" + path[0] + "</em> and <em>" + path[path.length - 1] + "</em></h1>";
    if (!path) {
      proof += "Proof could not be found.  These things may not be equivalent.  Please adjust your wordlview accordingly.";
      return proof;
    }
    proof += "<table style='border: 0px collapse;'>";
    for (step = 0, _ref = path.length - 1; (0 <= _ref ? step < _ref : step > _ref); (0 <= _ref ? step += 1 : step -= 1)) {
      proof += "<tr>";
      proof += "<td style='padding-right: 30px'>" + step + ".";
      proof += "<td style='padding-right: 30px'>" + path[step];
      proof += "<td style='padding-right: 30px'>is";
      proof += "<td style='padding-right: 30px'>" + path[step + 1];
      proof += "</tr>";
    }
    proof += "</table>";
    proof += "<p>By n-transitivity, " + path[0] + " is " + path[path.length - 1] + ". <strong>QED</strong></p>";
    return proof;
  };
  exports.path = path;
  exports.to_proof = to_proof;
}).call(this);
