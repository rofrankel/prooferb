Really bare-bones Sunday afternoon project. `coffee app.coffee` to run. Go to
`localhost:9511/a/b` to generate a "proof" of the equivalency of "a" and "b"
using Google Suggest completions of "a is".

NB This graph is just built in memory. Proofs will be generated faster the
longer you let the app run and the more terms you prime it with, as this will
allow the graph to grow...but the app will also consume more memory. Nothing
resembling cleverness, elegance, or even basic human decency is done to mitigate
this. If you restart the server (or the app crashes due to going out of memory,
which can definitely happen), proofs will be slow again, because there is no
persistence backend right now.

This idea was taken from someone at the HackNY Spring 2011 Hackathon, who
mentioned the idea to me and then left without implementing it. If this is you,
[email me](mailto:richard@frankel.tv?subject=prooferb%20credit) so I can give
you credit for the idea.

Copyright Richard Frankel 2011.  Code released under the MIT license.