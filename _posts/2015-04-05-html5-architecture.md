---
layout: page
title: "HTML5 Architecture"
category: html
date: 2015-04-05 17:39:46
---


# DRAFT

**Note**: This document is DRAFT and currently under construction.

This document gives a high-level overview of the architecture for implementing the HTML5 client in BigBlueButton.

The audience is developers who will be contributing to the HTML5 development.

The goal of this Google Docs document is to clearly describe how the current HTML5 client is implement, including the server-side components


# HTML5 Client

The HTML5 client is implemented using [coffeescript](http://coffeescript.org/) , require.js, and [backbone.js](http://backbonejs.org/)

All the code for the HTML5 client is inside the `public/` folder. It has basically CSS, image and javascript/coffeescript files.

## Coffeescript
Coffeescript is a language that compiles into javascript. It offers several advantages over javascript, especially that the code is usually a lot smaller and easier to maintain. Code in coffeescript can be run by node.js or by a browser (including the coffeescript.js library), so you don’t really need to compile it to javascript.

In the HTML5 client, everything is in coffeescript. In development the files are served as coffeescript, but in production they are previously compiled to javascript.

## Require.js
Require.js is used for two purposes:

(1) Include files in other files, i.e. specify dependencies. In a javascript application in the browser is not so easy to separate your application in several files/modules. With require.js you can create different files for different classes/modules and make them “see” each other in the browser. For example:

```
define [
  'jquery',
  'underscore',
  'cs!views/app',
  'cs!views/login'
], ($, _, AppView, LoginView) ->
```

When this is included in the top of a file, it will include jQuery, underscore (another utility lib) and two application views and set them as the variables $, _, AppView and LoginView. to be used in the rest of the file._

(2) Optimize the application for production. It has a tool called r.js that optimizes the code  (uglifies, minifies) to make it smaller and faster.

Backbone.js is the backbone of the client (!). It is basically a MVC framework for javascript applications. The views are objects that render things in a web page. The controllers control the routes (e.g. if a user goes to http://bigbluebutton.org/#session, the controller will be in the “session” route) and are usually very simple. The models do the hard work (socket communication, user authentication, drawings in the whiteboard), and are used by the views.

Other libs: jQuery and underscore

jQuery (http://jquery.com/) is a well known javascript library that helps the manipulation of DOM elements. Underscore (http://underscorejs.org/) is another library that has several utility methods to work with object, arrays, collections and so on.
Client Architecture

![capture](/images/capture.png)

Diagram above shows most of the classes in the client.

The client starts when an HTML page is rendered and requires the file main.js. This file has all the configurations require.js needs to load the rest of the application. When everything is loaded, app.coffee is executed to start the app. It will create some objects, especially the router, telling it to render the login page.

The router can render two views: the login view and the session view. The login view renders a text input where the user can enter his/her name and uses two models to get the list of meetings in the server (MeetingModel) and authenticates the user when the “join” button is pressed (AuthenticationModel). The view itself only renders html elements on the screen and listens for events (clicks, input changes, etc).
The session view renders everything inside a meeting. It uses several other views that each render a part of the screen: the list of users, the whiteboard, the chat, and so on. These views use ConnectionModel to connect with the server using websockets (socket.io) and WhiteboardPaperModel to do everything that’s done in the presentation and whiteboard area: show a slide, change the current slide, draw forms, show the pointer, etc.

Together with these two views there's the AppView. It is a utility view, that doesn't render anything on the screen. It is simply used to clear the screen, render one of the other two views and keep track of the view that is being shown.

Views render HTML using templates, that are simple HTML files. There are several templates in the application: chat, user list, single user in the list, chat message, etc.

## WhiteboardPaperModel and raphael

Most of the code of the current client is in this model. It uses a library called [Raphaël](http://raphaeljs.com/) used to work with vector graphics. So what the model does is basic work with a SVG element inside the web page. It paints images on it, draws forms, and so on.
Optimization and deployment

The client has a file named build.js that configures the optimization tool r.js. It will basically convert all files from coffeescript to javascript, join them in a single (main-dist.js) file and minify/uglify it. Having a single file is a lot faster to load in a web page than loading every file separately.

To run the optimization tool, there is a Cakefile in the application with the task “build”. So you run the command below from the application root and it will build the output file main-dist.js, that will contain the entire HTML5 client application.

```
    cake build
```

When the HTML is served by the node.js server, it will check if the server is in production or development and use the appropriate client application (i.e. javascript file). See this.






# HTML5 Server


Description of how node.js, express.js and redis and support communication amongst the HTML5 clients
Node.js

It’s an event driven I/O server based on V8 javascript engine.
It’s used as a web server and socket server for the BigBlueButton HTML5 Client. It has two main purpose:

(1) Handle the websockets for the html5 clients which basically allows to connect, disconnect, and send messages with the updates about a BigBlueButton meeting.

(2) Serves the HTML5 client and store information users, chat, etc using a redis lib.

## express.js
It’s a web framework for node.js which basically makes easier to build a web application by providing an API, pattern, and allows to define routes:

```
// Routes (see /routes/index.js)
app.get('/', routes.get_index);
app.get('/auth', routes.get_auth);
app.post('/auth', routes.post_auth);
app.post('/logout', requiresLogin, routes.logout);
app.get('/join', routes.join);
app.post('/upload', requiresLogin, routes.post_upload);
app.get('/meetings', routes.meetings);
```

sources: https://github.com/bigbluebutton/bigbluebutton/blob/html5-bridge/labs/bbb-html5-client/app.coffee#L30

> https://github.com/bigbluebutton/bigbluebutton/blob/html5-bridge/labs/bbb-html5-client/routes/main_router.coffee#L21-L25

## Redis

It’s a key-value database used by the html5 client. It has two main purposes:

{1) store the information about list of users, chat messages, presentation events, and whiteboard events. The keys are separate by the dash character “-”. You can check the keys created in a meeting, by running the following command:

```
redis-cli
> keys *
```

(2) Send and receive updates through the pubsub messaging pattern. For receive the updates, we need to subscribe to a channel or a pattern channel like this:

```
sub.on("pmessage", function(pattern, channel, message) {
```

source: https://github.com/bigbluebutton/bigbluebutton/blob/html5-bridge/labs/bbb-html5-client/app.js#L173

BigBlueButton Integration with HTML5 Server


The following describes how server-based components of the BigBlueButton server integrate with the HTML5 Server.

In order to allow an integration between the HTML5 Server and BigBlueButton Server, we use a messaging system called Redis PubSub which basically allows to publish messages (updates) with information about when a user leave, a new chat message is sent, etc. And enables to subscribe to a channel to receive these messages, and send it back to the respective client.

Workflow

![over-datasharing](/images/over-datasharing.png)



(1) Both Servers subscribe for updates to redis.

(2) When for example from the BigBlueButton server has sent a chat message, the BigBlueButton Server publish this update with the data, this is received by Redis.

(3) Like Both servers are subscribed, both receive the new update, handle the update, and send back to the respective client.

## Data Sharing

As it was mentioned previously, redis is also used as storage of information like user list, chat messages, and other info occurred in a meeting. This info is used in order to do get history about a module, let’s take for example a new user joins to a meeting using the HTML5 Server, the user will need to request the list of users connected, the chat history, etc. The following explains how this data is shared:

![over-pubsub](/images/over-pubsub.png)



# API

## Create

When a meeting is created, it’s also stored in Redis a new meeting, under the key: “meetings”. This key is used for validate that when a user joins to a meeting, the meeting should have been created.
