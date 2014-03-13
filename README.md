ruby-oo-pingpong
================

Implementing ping pong scorer logic in ruby without database, as TDD learning exercise.

##Description

Scoring ping pong, and in particular doubles ping pong, presents an interesting problem. See rules of ping pong [here](http://tabletennis.about.com/od/thelawsoftabletennis/a/orderserving.htm).

Here are some of the main challenges:

* game won at 11 points but only if player/pair two ahead
* players/pairs swap service every two points normally, but after every point from 10-all 
* players/pairs swap ends after every game, and when first player/pair reaches 5 points in last possible game
* in doubles at each change of service previous receiver becomes server; partner of previous server becomes receiver
* in doubles at start of game, the pair to serve chooses which partner serves first. In the first game of a match the receiving pair decides which partner receives first; in subsequent games the first server having been chosen, the first receiver shall be the player who served to him/her in the preceding game
* in the last possible game of a doubles match the pair due to receive next changes order of receiving when first pair reaches 5 points



##Technology
* Ruby
* RSpec


