# TMFeeds
App that fetches Reddit feeds and displays in an infinite scrolling list.  
<br/>
<p align="center">
  <img src="https://github.com/savitap18/TMFeeds/blob/main/demo.gif?raw=true" alt="Sublime's custom image"/>
</p>

# Summary
* Designed using MVVM. 
* Application supports from iOS 13.  
* REST api is consumed using URL Session and Codables are used for JSON parsing.  
* List is shown using Table View and Prefetch delegate is used for infinite scrolling.  
* Unit test cases for models are written.

# Libraries 
* Swiftlint is used to enforce swift coding styles and conventions.  
* SDWebImage SDK is used for asynchronous fetching and image caching. 
* Reachability file that checks for connection availability.  

**This can further be improved by**
* Adding offline support.      
* Analytics ex: How does app end up with a bad/invalid url. 
* Cancel Prefetch can be implemented in order to avoid the call once user starts scrolling upwards.This functionality proves more useful when each cell needs a separate api call for rendering data.

