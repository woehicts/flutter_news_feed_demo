# Flutter news feed demo

This repository contains a source files required to build a Flutter application using IntelliJ idea platform.

Before building the application, the `request.config.json` file must be created in the `assets/` folder. 
The created file should contain newsapi.org API key and a search keyword:

```[json]
{
  "apiKey" : "<API Key>",
  "SearchKeyword" : "tesla"
}
```

## User controls guide

A pull-to-refresh action is triggered once a user drags the list items down (i.e. overscrolls up) at the top of the news feed.
Use a scroll to the top button (shown as an arrow-up button) before you may want to refresh the news feed,
provided that the list of the news articles is already scrolled long way down from the top.

When scrolling down the list of news articles, new items from the next news feed page should automatically populate the
list view.

To view an article double tap on a list item.

Detailed article view is dismissed by dragging left or right the page.