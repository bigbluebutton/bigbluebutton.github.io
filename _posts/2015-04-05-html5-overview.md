---
layout: page
title: "HTML5 Overview"
category: labs
date: 2015-04-05 11:41:36
---


# Overview

This document provides information about the HTML5 client that is integrated into the BigBlueButton platform for providing an additional entry point for users to join a BigBlueButton session.

## Vision
With the adoption of HTML5, the web browser is becoming the platform for rich client interfaces.

Furthermore, with the recent progress in WebRTC, an HTML5-based application can access the user's webcam and microphone **without** the need for plugins.

The long-term vision for the BigBlueButton HTML5 client is to enable users on all platforms supporting an HTML5 browser -- including smartphones and tablets to -- to fully access all of BigBlueButton’s features.

This means the HTML5 client will completely implement the current Flash-based functionality, including the ability to broadcast audio and video from within the browser using WebRTC.

The existing Flash client will not be replaced by the HTML5 client -- all current functionality of BigBlueButton will remain intact.  We are adding to the functionality by providing users with the ability to join a session (and increasingly participate) through an HTML5 interface (no Flash required).

## Phases for Development of HTML5 Client

We’ve mapped out the development of the HTML5 client in three phases:

  1. Viewing a live BigBlueButton session using an HTML5 browser (view presentation updates, streaming audio/video, two-way chat).
  1. Broadcast audio/video from an HTML5 browser using WebRTC
  1. Support for all presentation features of BigBlueButton in HTML5

The following describes our efforts to implement phase 1: viewing a live BigBlueButton session using an HTML5 browser.  The current builds support webRTC audio and we are working on adding video support through webRTC.

## UI
The overall design of the HTML5 client [in landscape view] aims to resemble what the users are familiar with from the existing Flash client.

<img src="/images/html5-client-landscape.png" width="900" />

The HTML5 client also has a portrait view where the interface was modified to better accommodate devices with smaller screens (mobile devices). 

<img src="/images/html5-client-mobile-view.png" width="350" />
<img src="/images/html5-client-mobile-menu.png" width="350" />

Other interface differences include:

  * toggle for controlling which modules are visible (Users, Presentation, Chat)
  * an additional button for displaying the presentation in full screen (on a mobile device)
  * slightly different Chat Options panel, redesigned to utilize native option selection offered for browsers on mobile devices.


## Overview of Architecture

The MongoDB database on the server side of the HTML5 client contains information about all meetings on the BigBlueButton server. Each user's client is only aware of the meeting the user is currently in and the communication the user is part of (public chat messages and private messages between that user and others).

Below you can see the current architecture of the HTML5 client and its communications with the other components in BigBlueButton.

![HTML5 Overview](/images/html5-client-architecture.png)

## Implementation of the HTML5 client
The HTML5 client is implemented using [Meteor.js](http://meteor.com) in [CoffeeScript](http://coffeescript.org/)

All the code for the HTML5 client is inside the `bigbluebutton/bigbluebutton-html5/app` folder. It mainly consists of LESS, HTML and CoffeeScript files.

### CoffeeScript
CoffeeScript is a language that compiles into JavaScript. It offers several advantages over JavaScript, especially that the code is usually a lot smaller and easier to maintain. Code in CoffeeScript can be run by Meteor.js thanks to a CoffeeScript [package](https://atmospherejs.com/meteor/coffeescript).

### WhiteboardPaperModel and Raphaël

A significant amount of the code of the client is related to the whiteboard. We use a library called [Raphaël](http://raphaeljs.com/) to work with vector graphics.

### LESS and Media Queries

We use [LESS](http://lesscss.org/) precompiler to keep the stylesheets short and readable. LESS is a stylesheet language that is compiled into CSS. It allows us to use variables and mixins. Selectors can be nested, thus making it easier to read the code.

The responsive UI of the HTML5 client is constructed using media queries. Each LESS expression is tied to some specific range of devices and window sizes. HTML5 client provides four different views depending on your device (desktop/mobile) and browser orientation (landscape/portrait).

## Implementation details

### HTML5 Client's server side:

As we run
```$ ./start.sh```
we start the Meteor process in the terminal. We initialize Meteor.RedisPubSub and then publish a json request message “get_all_meetings_request” to BigBlueButton-Apps, which triggers the following response:

```
{
   "payload": {
     "meetings": [
       {
         "meetingID": "183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1415134791204",
         "meetingName": "Demo Meeting",
         "recorded": false,
         "voiceBridge": "70827",
         "duration": 0
       }
     ]
   },
   "header": {
     "timestamp": 3350491563,
     "name": "get_all_meetings_reply",
     "current_time": 1415312516720,
     "version": "0.0.1"
   }
}
```


We parse this information and populate a Meetings [MongoDB] collection on the server side for all the ongoing meetings on this BigBlueButton server.
Similarly we obtain an array of all users, presentations and the chat history for each meeting.
Using this information we populate our collections Users, Chat, Presentations, Shapes, Slides.
We are subscribed to receive event messages on the following Redis channel:

  * "bigbluebutton:from-bbb-apps:*"

And we publish event messages on:

  * "bigbluebutton:to-bbb-apps:chat"
  * "bigbluebutton:to-bbb-apps:meeting"
  * "bigbluebutton:to-bbb-apps:users"
  * "bigbluebutton:to-bbb-apps:voice"
  * "bigbluebutton:to-bbb-apps:whiteboard"

Throughout the meeting we keep receiving json messages via Redis about all the events in the meetings on the BigBlueButton server. We classify them in server/redispubsub.coffee and handle them in server/collection_methods/*
The handling procedure typically involves updating the particular document[s] in the collection.
It is crucial for the HTML5 client that the Mongo database stays up to date. Therefore if the Meteor process is terminated while there are running sessions, we query BigBlueButton-Apps in attempt to update our database and continue serving the meetings. Note that if an HTML5 client user is in a meeting and the Meteor process is stopped, the user will not be able to reconnect to the meeting automatically. The user will have to log in again.

We have disabled autopublishing. We publish manually inside server/publish.coffee based on what information the specific client provides during the subscription phase in lib/router.coffee. This is how we limit clients from receiving data for meetings they are not authorized to attend.



### HTML5 Client's client side:

We rely heavily on the fact that MongoDB on the server side automatically pushes updates to MiniMongo on the client side.
The client side subscribes to the published collections on the server side. During the subscription, the userId and auth_token of the user logged in the client are required. Providing these 2 identifiers, together with the meetingId, the publishing mechanism is enough information to decide what subset of the collections the user logged in the client is authorized to view.

When an event in the meeting occurs the database on the server side is updated and the information is propagated to the client side MiniMongo database. The templates are automatically rendered with the most recent information so the user interface is updated.

Losing connection:
(Client side) If a user loses connection while in the meeting, a message appears on the screen informing the user about the disconnection and the reconnection countdown. The client will periodically attempt to reconnect. If the reconnection is successful, the client will reappear with everything up to date. However, if the client is unable to reconnect the user will be asked to log in again.


## API

### Check
Check if the HTML5 client is running and ready to serve users:

```
http://<your_ip>/html5client/check
```

The result should be ```{"html5clientStatus":"running"}```


## Current stage
### Implemented:
  * two way public and private chat
  * viewing presentation with slides, cursor, whiteboard annotations
  * audio using WebRTC (listen and speak)

### Not yet implemented (see more information about these features in the existing Flash client):
  * video
  * lock settings
  * listen Only audio

### Planned features:
  * presenter mode
  * accessibility
  * localization
  * shortcut keys


## Whiteboard

The whiteboard is an SVG element embedded in the page, composed of images, a small red cursor and any shapes drawn by the presenter. Raphaël.js is used to automate most of the SVG manipulation but lots of math is still required on the client side. The information for all of the slides and shapes in the meeting are stored in a collection and are used to keep the whiteboard in the Presenter module up to date so that it matches what all other viewers (and the presenter) see.

Advantages to SVG:

  * Panning and zooming are relatively easy using SVG because no objects need to be scaled, it is all handled automatically when you simply adjust the viewBox property of the SVG object.

  * SVG, much as its acronym suggests, are scalable. Thus any screen size, big or small, can be adjusted and aside from the the background image, all shapes will be drawn at a greater resolution automatically. Things will just look great at any size.

  * SVG is in the DOM, which means that we can control them through JavaScript. This will make using the HTML5 client for presenting relatively easy to implement at a later stage.


## Set up a Development Environment

If you want to explore, develop and improve the HTML5 client, please follow the instructions on [setting up HTML5 development environment](/html/html5-dev.html)
