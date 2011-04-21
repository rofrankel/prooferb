title 'Prooferb - ' + @path[0] + ' is ' + @path[@path.length-1]

h1 'Proof of the equivalency of <em>' + @path[0] + '</em> and <em>' + @path[@path.length-1] + '</em>'

if not @path
    p "Proof could not be found.  These things may not be equivalent.  Please adjust your wordlview accordingly."
else
    td_style = 'padding-right: 30px'
    table style: 'border 0px collapse', ->
        for step in [0...@path.length - 1]
            tr ->
                td style: td_style, -> (step+1) + '.'
                td style: td_style, -> @path[step]
                td style: td_style, -> 'is'
                td style: td_style, -> @path[step+1]
    
    p 'By n-transitivity and the reliability of Google Suggest, ' + @path[0] + ' is ' + @path[@path.length-1] + '. <strong>QED</strong>'