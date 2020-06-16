# Reddit

This is a full navite swift, without any libraries, example app that fetches posts from the Reddit public API. It uses MVVM. Not MVC, because I like this structure a little bit better and I plan to add some more functionality so MVC would have become outdated too fast, and not VIPER since it won't grow that much and it's too much boilerplate.

Things you can do:

First you'll be presented with 50 posts from reddit, this are the top posts at the moment.

You can navigate to a detailed view from the post if tap on the row, however, if you tap on the thumbnail, you'll be redirected to the url reddit provided, this could a post, an image or a gif.

Once you visited a post, if you navigate back, you'll notice that the blue dot at the top right will dissappear, that's the status indicator that shows you whether you read a post or not.

You can navigate back and forth from the dashboard with posts to the detailed view by pressing the back button or the cell, and you can show or dismiss the dashboard on iPads by swiping left or right.

You can delete items from the the by pressing the edit button or you can delete everything by pressing the dismiss all button.

If you pull the tableview down, you can refresh the posts that have been dismissed.
