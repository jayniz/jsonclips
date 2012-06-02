Movieclips.com API as JSON
==========================

We wanted to use the movieclips.com API at the 2012 [Movie Hack Day](http://moviehackday.com). This little goliath app runs on heroku and provides a slimmed down version of their API in JSON instead of XML.

It runs on http://jsonclips.herokuapp.com but to try it out, click the example links below.

Supported Resources
===================

Fulltext search
-----------

Request like this ([example](http://jsonclips.herokuapp.com/search?q=he%20peed%20on%20my%20rug))

    http://localhost:9000/search?q=he%20peed%20on%20my%20rug
    
Search espeçial
---------------

The search scrapes the movie id and name from the description of the search results. Also, you can append the

    http://localhost:9000/search?q=top%20gun&exclude_movie=top%20gun,mashup,top%2010

to fetch a search for Top Gun, but excluding the movie Top Gun and mashups and top 10 lists.
    
JSONP
=====

Yeah, just append `callback=your_callback` to the query string and you gots teh data.



