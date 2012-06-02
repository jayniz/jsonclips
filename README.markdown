XML. Why XML?
=============
![WHY??](https://dl.dropbox.com/u/1953503/gifs/JXLzX.gif)

Movieclips.com API as JSON
==========================

We wanted to use the movieclips.com API at the [2012 Movie Hack Day](http://moviehackday.com) but couldn't be bothered with XML. This little goliath app runs on heroku and provides a slimmed down version of their API in JSON instead of XML.

It runs on http://jsonclips.herokuapp.com but to try it out, click the example links below.

Supported Endpoints
===================

Fulltext search
-----------

Request like this ([example](http://jsonclips.herokuapp.com/search?q=he%20peed%20on%20my%20rug))

    http://jsonclips.herokuapp.com/search?q=he%20peed%20on%20my%20rug

You get stuff from movieclip.com's API endpoint [http://api.movieclips.com/v2/search/videos?q=searchterm](http://api.movieclips.com/v2/search/videos?q=searchterm) but in pretty JSON instead of bulky XML/atom.

Extras:

1. Associated movie id and name from search results (movie clips) are scraped from the description's HTML to allow for filtering and easier navigation.
2. Largest and smallest associated pictures are added to be used as thumbnail or large preview.


    
Search for clips mentioning movie titles
---------------

Want to search for clips mentioning movie names? No problemo:

    http://jsonclips.herokuapp.com/search_title_quote?q=top%20gun

This fetches a search for Top Gun, but excluding the movie Top Gun and mashups and top 10 lists ([example](http://jsonclips.herokuapp.com/search_title_quote?q=top%20gun)).

Tadaa, a search for movie clips that quote other movie names.

Exclude movies
--------------

You can also exclude movie names from the normal search by appending a `exclude_movie=movie1,movie2` parameter like so ([example](http://jsonclips.herokuapp.com/search?q=top%20gun&exclude_movie=top%20gun,mashup,top%2010)):

    http://jsonclips.herokuapp.com/search?q=top%20gun&exclude_movie=top%20gun,mashup,top%2010
    
JSONP
=====

Yeah, just append `callback=your_callback` to the query string and you gots teh data.

