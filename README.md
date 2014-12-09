Week 1 project

This is a simple clone of the twitter app.

Features:
- Network calls to Twitter's API
- JSON parsing
- Infinite scrolling in tableview of tweets
- Dynamic cell height

Monday:
Create groups in your project for the model, view, and controller layer of your app
Successfully parse the provided JSON file into Tweet model objects
Add a table view to your view controller, and have it display all of the tweets that you parsed from the JSON

Tuesday
Use the Accounts framework to get access to the user’s twitter account
Use the social framework to fetch the users timeline
Bake in status code checking into your network call and log out the status code
Have your tableview display the user’s timeline once the network operation is completed back on the main thread
Create a custom tableview cell class, and display the avatar image for each tweet in an image view on each cell

Wednesday
Create a network controller class that will be responsible for making all network calls to Twitter. The view controllers themselves should not be touching any URLS
Create a second view controller called SingleTweetViewController that is devoted to just showing a single tweet, the user who tweeted it, and how many retweets and favorite it has. This view controller should be segued to when the user selects a cell from the home timeline.
Move your image downloading to the network controller as well.
Using autolayout on your custom cell, achieve dynamic cell height.  Check out this blog post to get you started with this particular feature: http://www.appcoda.com/self-sizing-cells/ (Links to an external site.)

Thursday
Remove all Segues from your app, and instead use the push and pop methods on your navigation controller.
Create a nib for your tweet cell, so we don't have to layout the same tableview cell in multiple spots.
Create a third view controller that is devoted to showing a user’s most recent tweets. This should be pushed onto the navigation stack when the user clicks on the user’s picture in the single tweet view controller.
Create a table view header view in your user timeline view controller. It should display the user's image and the user's name.

Challenges
Harness the power of the since_id parameter on your api calls. The since_id gives you tweets that are more recent than the id you pass in as the since_id. Combine this, with pull to refresh, to let the user refresh their timelines with the latest tweets.
Use the max_id parameter. This is similar to since_id, except it gives you tweets older than the id provided as the max_id. So as the user scrolls towards the bottom of the table view, use the max_id to pull down more tweets. You can basically achieve infinite scrolling with this.
Implement a tab bar controller, just like the actual twitter app. Implement at least one of the tabs, you can pick which one you want to implement.
Implement an image cache. This cache should make it so you never download the same user image more than once while the app running. This cache can be completely in memory with no persistence. But persistence would be an extra challenge as well.