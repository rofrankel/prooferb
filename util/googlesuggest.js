(function() {
  var http, jsdom, suggest;
  http = require('http');
  jsdom = require('jsdom');
  suggest = function(phrase, callback) {
    var options, querystring;
    querystring = require('querystring').stringify({
      q: phrase,
      output: 'toolbar'
    });
    options = {
      host: 'google.com',
      port: 80,
      path: "/complete/search?" + querystring
    };
    return http.get(options, function(res) {
      var xml;
      xml = '';
      res.on('data', function(chunk) {
        return xml += chunk;
      });
      return res.on('end', function() {
        var match, results, suggestion, suggestions, _i, _len;
        suggestions = jsdom.jsdom(xml).createWindow().document.getElementsByTagName('suggestion');
        suggestions = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = suggestions.length; _i < _len; _i++) {
            suggestion = suggestions[_i];
            _results.push(suggestion.getAttribute('data'));
          }
          return _results;
        })();
        results = [];
        for (_i = 0, _len = suggestions.length; _i < _len; _i++) {
          suggestion = suggestions[_i];
          if (match = suggestion.match(phrase + "(.*)")) {
            results.push(match[1]);
          }
        }
        return callback(results);
      });
    });
  };
  exports.suggest = suggest;
}).call(this);
