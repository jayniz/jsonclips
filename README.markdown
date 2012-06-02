Movieclips.com API as JSON
==========================

We wanted to use the movieclips.com API at the 2012 [Movie Hack Day](http://moviehackday.com). This little goliath app runs on heroku and provides a slimmed down version of their API in JSON instead of XML.

It runs on http://jsonclips.herokuapp.com but to try it out, click the example links below.

Supported Resources
===================

Fulltext search
-----------

Request like this ([example](http://localhost:9000/search?q=he%20peed%20on%20my%20rug))

    http://localhost:9000/search?q=he%20peed%20on%20my%20rug
    
JSONP
=====

Yeah, just append `callback=your_callback` to the query string and you gots teh data.



