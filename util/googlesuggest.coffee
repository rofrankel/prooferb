http = require 'http'
jsdom = require 'jsdom'

suggest = (phrase, callback) ->
    querystring = require('querystring').stringify({
        q: phrase
        output: 'toolbar'
    })
    
    options = {
        host: 'google.com'
        port: 80
        path: "/complete/search?#{querystring}"
    }
    
    http.get(options, (res) ->
        xml = ''
        res.on('data', (chunk) -> xml += chunk)
        res.on('end', ->
            suggestions = jsdom.jsdom(xml).createWindow().document.getElementsByTagName('suggestion')
            suggestions = (suggestion.getAttribute('data') for suggestion in suggestions)
            results = []
            for suggestion in suggestions
                if match = suggestion.match(phrase + "(.*)")
                    results.push(match[1])
            callback(results)
        )
    )

exports.suggest = suggest