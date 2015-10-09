---
layout: page
title: "HTML5 Overview"
category: labs
date: 2015-04-05 11:41:36
---


# Overview

This document provides information about the BigBlueButton HTML5 client that provides users an additional entry point for users to join a BigBlueButton session.

The BigBlueButton HTML5 client is under development.  

## Vision
With the adoption of HTML5, the web browser is becoming the platform for rich client interfaces.

Furthermore, with the recent progress in WebRTC, an HTML5-based application can access the user's webcam and microphone **without** the need for plugins.

The long-term vision for the BigBlueButton HTML5 client is to enable users on all platforms supporting an HTML5 browser -- including smartphones and tablets to -- to fully access all of BigBlueButton’s features.

This vision means the HTML5 client will, at some point, completely implement the current Flash-based functionality, including the ability to broadcast audio and video from within the browser using web real-time communications (WebRTC) framework.

Google Chrome on Android devices supports WebRTC (we use these devices for development and testing); however, Apple's Safari browser on iOS devices does not.  It would be great if Apple were to support WebRTC -- or to enable other browsers to use their own rendering engine on iOS -- but until then we (and you) are restricted to using the HTML5 client platforms that support WebRTC.

The existing Flash client will not be replaced by the HTML5 client -- all current functionality of BigBlueButton will remain intact.  We are adding to the functionality by providing users with the ability to join a session (and increasingly participate) through an HTML5 interface (no Flash required).

## Phases for Development of HTML5 Client

We’ve mapped out the development of the HTML5 client in the phases:

  1. Viewing a live BigBlueButton session using an HTML5 browser (view presentation updates, view desktop sharing, two-way chat, two-way audio, respond to polls, emjoi icons).
  1. Presentation capabilities: advance slides and switch presentation.
  1. Two-way video
  1. All presenter capabilities
  1. All moderator capabilities

The following describes our efforts to implement Phase 1: viewing a live BigBlueButton session using an HTML5 browser.  The current builds support WebRTC audio and we are working on viewing the presenter's desktop via WebRTC video.

## UI

<p>The overall design of the HTML5 client [in landscape view] aims to resemble what the users are familiar with from the existing Flash client.</p>
<img src="/images/html5_client_20150922_desktop.png" width="800" />
<p>The HTML5 client also has a portrait view where the interface was modified to better accommodate devices with smaller/narrow screens (mobile devices).</p>


<img src="/images/html5_client_20150922_vertical.png" width="600" style="" />
<p>Notice the large raiseHand and fullScreen buttons designed to be easy to tap on a touch screen. Two expansions are accessible via the buttons in the top left and right hand corners. The left wing displays the users while the right one brings up the settings, and the controls for chat display and logout.</p>

<img src="/images/html5_client_20150922_settings.png" width="800" />
<p>The settings dialog provides a way to join the audio as listenOnly or with a microphone as well as other settings.</p>

<img src="/images/html5_client_20150922_full_screen.png" width="800" />
<p>The full-screen capability allows a distraction free mode aimed at handheld devices.</p>


The interface differences include:

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
The client side subscribes to the published collections on the server side. During the subscription, the userId and authToken of the user logged in the client are required. These 2 identifiers together with the meetingId provide enough information for the publishing mechanism to decide what subset of the collections the user logged in the client is authorized to view.

When an event in the meeting occurs the database on the server side is updated and the information is propagated to the client side MiniMongo database. The templates are automatically rendered with the most recent information so the user interface is updated.

Losing connection:
(Client side) If a user loses connection while in the meeting, a message appears on the screen informing the user about the disconnection and the reconnection countdown. The client will periodically attempt to reconnect. If the reconnection is successful, the client will reappear with everything up to date. However, if the client is unable to reconnect the user will be asked to log in again.


## API

### Check
Check if the HTML5 client is running and ready to serve users:

`http://your_ip>/html5client/check`

The result should be ```{"html5clientStatus":"running"}```


## Current stage
### Implemented:
  * two way public and private chat
  * viewing presentation with slides, cursor, whiteboard annotations
  * audio using WebRTC (listen and speak)
  * lock settings
  * listen Only audio

### Not yet implemented (see more information about these features in the existing Flash client):
  * viewing of desktop sharing video

### Planned features:
  * webcam video
  * presenter mode
  * accessibility
  * localization
  * shortcut keys


## Whiteboard

The whiteboard is an SVG element (or PNG if working with BigBlueButton version 0.9) embedded in the page, composed of images, a small red cursor and any shapes drawn by the presenter. Raphaël.js is used to automate most of the SVG manipulation but lots of math is still required on the client side. The information for all of the slides and shapes in the meeting are stored in a collection and are used to keep the whiteboard in the Presenter module up to date so that it matches what all other viewers (and the presenter) see.

Advantages to SVG:

  * Panning and zooming are relatively easy using SVG because no objects need to be scaled, it is all handled automatically when you simply adjust the viewBox property of the SVG object.

  * SVG, much as its acronym suggests, are scalable. Thus any screen size, big or small, can be adjusted and aside from the the background image, all shapes will be drawn at a greater resolution automatically. Things will just look great at any size.

  * SVG is in the DOM, which means that we can control them through JavaScript. This will make using the HTML5 client for presenting relatively easy to implement at a later stage.


## Try out the HTML5 client by installing it from packages

<b>!! DRAFT - this section will be updated when BigBlueButton 1.0-beta is released</b>

You can easily add the HTML5 client to your server so you can try it out. These are the steps to add it:

```
$ sudo apt-get install bbb-html5
$ sudo bbb-conf --restart
```

From now on the HTML5 client's package (bbb-html5) will update when you update BigBlueButton, will restart with the other components when you perform `bbb-conf --restart` or `bbb-conf --clean`.
If you want to manually restart (or stop) it you can do so with the command

```
$ sudo service bbb-html5 restart
```

Note that the logs for the component are located at `/var/log/bigbluebutton/html5/html5.log` and the code for the client can be found at `/usr/share/meteor/html5/app/`.

Later on if you wish to remove the HTML5 client, you can enter the command

```
$ sudo apt-get purge bbb-html5
```

## Set up a Development Environment

If you want to explore, develop and improve the HTML5 client, please follow the instructions on [setting up HTML5 development environment](/labs/html5-dev.html)
