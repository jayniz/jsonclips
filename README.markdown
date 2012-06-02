Movieclips.com API as JSON
==========================

We wanted to use the movieclips.com API at the [2012 Movie Hack Day](http://moviehackday.com). This little goliath app runs on heroku and provides a slimmed down version of their API in JSON instead of XML.

It runs on http://jsonclips.herokuapp.com but to try it out, click the example links below.

Supported Endpoints
===================

Fulltext search
-----------

Request like this ([example](http://jsonclips.herokuapp.com/search?q=he%20peed%20on%20my%20rug))

    http://jsonclips.herokuapp.com/search?q=he%20peed%20on%20my%20rug

You get stuff from movieclip.com's API endpoint [http://api.movieclips.com/v2/search/videos?q=searchterm](http://api.movieclips.com/v2/search/videos?q=searchterm) but in pretty JSON instead of bulky XML/atom.
    
Search espeçial
---------------

Apart from turning XML/atom into JSON, this search does two more things:

1. It scrapes the movie id and name from the description of the search results
2. This allows to filter search results (clips) by the associated movie. You can append a `exclude_movie=movie1,movie2` parameter like so:

    http://jsonclips.herokuapp.com/search?q=top%20gun&exclude_movie=top%20gun,mashup,top%2010

This fetches a search for Top Gun, but excluding the movie Top Gun and mashups and top 10 lists ([example](http://localhost:9000/search?q=top%20gun&exclude_movie=top%20gun,mashup,top%2010)).

Tadaa, a search for movie clips that quote other movie names.
    
JSONP
=====

Yeah, just append `callback=your_callback` to the query string and you gots teh data.



