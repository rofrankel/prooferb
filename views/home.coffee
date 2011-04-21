title 'Prooferb'

script type: 'text/javascript', "var A='money', B='awesome';"

h1 'Prooferb - proof by proverb'

p   'Welcome to Prooferb.  Go to /a/b to generate a proof of the equivalence of \'a\' and \'b\', based on ',
    -> a href: 'http://google.com/complete/search?output=toolbar&q=money%20is', -> 'Google Suggest completions',
    ' of "a is".'
  

p   'For example, visit ',
    -> a href: "/money/awesome", -> '/money/awesome',
    ' to prove that money is awesome.'

p   'Or just enter your two terms here: ',
    -> input id: 'A',
    ' IS ',
    -> input id: 'B',
    ' and click ',
    -> a href: '#', onclick: "this.href = document.getElementById('A').value + '/' + document.getElementById('B').value;", -> 'here',
    '.'

br()
br()
br()
br()

p   style: "font-size: 12px",
        -> 'I got this idea from someone I met at the HackNY Spring 2011 Hackathon and whose name I don\'t recall.  If it\'s you, ',
        -> a href: "mailto:richard@frankel.tv?subject=prooferb%20idea%20credit", -> 'email me',
        ' for credit.'