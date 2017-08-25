# BoB Replays

BoB Replays is a VOD watching site, where the chat decides what match is going to play next. Using [Nightbot](https://www.nightbot.tv/), the user can vote for the next game that is going to be played typing a simple command:

```
!vote numberOfMatch
```

To get the number of the match just go to [BoB Replays Match Finder](http://bobreplays.herokuapp.com). There you can find all the matches available through [LoL eSports Youtube Channel](https://www.youtube.com/user/LoLChampSeries), and can apply filters you find the exact match that you want, and lookup for the code to vote for that match.

1. You can vote only one time for a match each round.
2. You can vote for as many matches as you want each round.
3. You can't vote for a match that was played less than 6 hours ago.

The next most voted match is automatically loaded when the video ends, and all the counter are automatically resetted.

To keep in sync with the others, when you land on the site it will set an offset of the start of the match based at what time the match started playing on the site based on a server clock.

With futher due, [Let's watch VODs together!](http://bobreplays.herokuapp.com)

## How does it work?
The user land on the website and the [`home.js`](app/assets/javascripts/home.js) script is loaded and makes a request to API [`video/playing`](app/controllers/videos_controller.rb#L27), which gives it the information on what video to load, which includes the offset of the video, so new arrivals can be on sync with the rest. When the video ends a new request is made to the same API endpoint which loads chooses the next video.

## How are the videos collected

Using a little [Youtube API Data client](lib/youtube_api.rb) to get all the information for each video, the script can be run manually to update the list
