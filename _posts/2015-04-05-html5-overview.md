---
layout: page
title: "Overview"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---


# Overview 

This document gives an overview of the long-term vision and near-term scope (the first release) planned for HTML5 client for BigBlueButton.

The BigBlueButton project started in 2009 with one goal: to provide remote students a high-quality online learning experience.  Since then, the BigBlueButton client, written in Flash, has been used by millions of users.

Today, users are increasingly looking for options to join to a BigBlueButton session from a mobile device.  However, mobile devices do not support Flash natively.  

Also, while Flash enjoys support from a wide range of browsers (FireFox, Chrome, Safari, Edge, and IE) and a wide range of platforms (Windows, Mac OS X, Linux, and Chromebook), and while Google embeds Flash into their browser and provides automatic updates, as so does Microsoft in Edge, Adobe has announced that it will discontinue support for Flash by the [end of 2020](https://theblog.adobe.com/adobe-flash-update/).   

We want to move the BigBlueButton project to pure HTML5 and support mobile users _long_ before the end of 2020.  Hence, the HTML5 client project.

A BigBlueButton 2.0-beta server (hereafter referred to as simply "BigBlueButton 2.0")  can support users connecting from either the Flash or HTML5 client in the same sessions.  The server routes messages seamslessly between the clients. 

The HTML5 support for real-time audio and video has substantially improved of the years with WebRTC.  The Flash client already uses WebRTC for sending and receiving high-quliaty audio for the audio (with a fallback to built-in Flash audio if the network blocks the ports needed for WebRTC).

It's worth emhasizing that the HTML5 client is part of the BigBlueButton project.  It will be open source.  

If you are a developer, this means you can integrate and extend the HTML5 client into your commercial product.  To support developers, we provide documentation on the architecture, setting up a development environment, and installing on a BigBlueButton 2.0 (or later) server.  We also provide support in the [bigbluebutton-dev](https://bigbluebutton.org/support/community/) mailing list from the core BigBlueButton devs.

In the BigBlueButton client, a user joins as either a `viewer` or `moderator`.  A viewer can send/receive audio and video, engage in public/private chat, raise hand, respond to polls, join breakout rooms, and view close captions.  Students typically join as viewers.

A moderator can -- in addition to all the viewer capabilities -- also mute/unmute other viewers, lock down all viewers, create live closed captioning, create breakout rooms, and make anyone (including themselves) the presenter.  Teachers typically join as moderators.

Any moderator can make anyone presenter (including themselves).  The current presenter can upload slides, annotate the slides using whiteboard tools, and share their desktop for all to see.


## Vision
The vision for the BigBlueButton project is to provide remote students a high-quality online learning experience regardless of the student's computer or device.

To achieve this vision, we want to deliver HTML5 client that works on desktop, laptops, and _mobile_ clients.  

Working towards this vision, we want the HTML5 client to work alongside the Flash client to provide a smooth transition from one platform to another.  In this way, as the HTML5 client matures, we expect it to be increasingly used over the Flash client.  Over time, when the HTML5 client achieves parity of features with the Flash client, we plan to retire the Flash client and use pure HTML5 accross the board.

## Scope

The near-term goal (the first release) is to create an HTML5 client that implements all the viewer capabilities of the Flash client with the exception of two-way webcams (that will come in a subsequent release) in an Andorid or iOS (iOS 11+) phone or tablet.  

Android provides excellent support for WebRTC in the Chrome browser.  As of the time of this writing, Apple recently released support for WebRTC in iOS 11 which has a [76% market penetration](https://www.macrumors.com/2018/04/25/ios-11-installed-on-76-percent-of-devices/).

# Features for the first release

The feature list for the first release of the HTML5 client will include

  * send/receive high-quality, low latency audio with WebRTC
  * engage in public/private chat
  * Share emojis (including raise hand)
  * Respond to polls
  * Join breakout rooms
  * View presentation
  * View close captions
  * Restrict of sharing chat and/or audio based on Moderator changing lock settings
  * Localization
  * Responsive user experience on phone and tablet in portrait and landscape mode
  * Accessibility through keyboard navagitation 

Recall we said that the first release will only support viewer capabilities.  We're a bit further along in the development of the HTML5 client than originally planned, so the first release will support some presentation capabilities 

  * Advance the slides
  * Upload a presentation
  * Whiteboard controls (except for pan/zoom)
  * Share desktop (FireFox and Chrome only)
  * Start/stop recording

and some moderator capabilities

  * Make user presenter
  * Promote/demote user
  * Kick user
  * Mute/unmute user

You can try out the latest build of the BigBlueButton HTML5 client at our test server [https://test.bigbluebutton.org/](https://test.bigbluebutton.org/). 

With the above it's now possible to hold a fairly complete meeting wiht just the HTML5 client.  If you do this, you can also make use of two-way video between the HTML5 clients.  The video codecs on the Flash client are different, so Flash users don't see video from the HTML5 client and vice-versa.

# Future Releases

Building upon the first release, we plan to add the remaining presenter and moderator capabilities to the HTML5 client, including:

  * Remaining whiteboard controls (pan/zoom)
  * Breakout Rooms
  * Closed Captioning
  * Shared Notes
  * All remaining moderator capabilities, including
    * Lock down viewers


## User Interface 

The requirements for an HTML5 interface include ease of use, responsive design, and the ability to run on multiple platforms.

While we are targeting the first release of the HTML5 client for mobile users, we have designed its interface (UI) for both desktop and mobile clients.  

<br>
<center>
<img src="/images/bbb-html5_presenter_sidebar_chat.png" />
</center>

<br>
For more details on the design of the user experience, see [HTML5 Design](/html/html5-design.html).

## Architecture

The server components of the HTML5 client are built upon the core BigBlueButton server.  The components specific to supporting the HTML5 client are 
  * [Meteor.js](http://meteor.com) in [ECMA2015](http://www.ecma-international.org/ecma-262/6.0/)
for communication between client and server.
  * [MongoDB](https://www.mongodb.com/) for keeping the state of each BigBlueButton client consistent with the BigBlueButton server

The MongoDB database on the server side of the HTML5 client contains information about all meetings on the BigBlueButton server.  Each user's client is only aware of the meeting the user is currently in and the communication and state, such as public chat messages and private messages between that user and others.

The HTML5 client itself is built upon the following components: 
  * [React.js](https://facebook.github.io/react/) for rendering the user interface in an efficient manner
  * [WebRTC](https://webrtc.org/) for sending/receiving audio and video

All the code for the HTML5 client is inside the `bigbluebutton/bigbluebutton-html5/` folder.  

The following diagram gives an overview of the architecture of the HTML5 client and its communications with the other components in BigBlueButton.

![HTML5 Overview](/images/html5-client-architecture.png)

The client uses the [SASS](http://sass-lang.com/) precompiler to keep the stylesheets short and readable. SASS is a stylesheet language that is compiled into CSS.   

The responsive UI of the HTML5 client is constructed using media queries. Each SASS expression is tied to some specific range of devices and window sizes.

### Implementation of the HTML5 Client (server side):

As we start the Meteor process in the terminal, we initialize RedisPubSub and then publish a json request message “get_all_meetings_request” to BigBlueButton-Apps, which triggers the following response:

~~~json
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
~~~


We parse this information and populate a Meetings collection on the server side (stored in  MongoDB) for all the ongoing meetings on this BigBlueButton server.
Similarly we obtain an array of all users, presentations and the chat history for each meeting.
Using this information we populate our collections Users, Chat, Presentations, Shapes, Slides, etc.
We are subscribed to receive event messages on the following Redis channel:

  * "bigbluebutton:from-bbb-apps:* "

And we publish event messages on:

  * "bigbluebutton:to-bbb-apps:chat"
  * "bigbluebutton:to-bbb-apps:meeting"
  * "bigbluebutton:to-bbb-apps:users"
  * "bigbluebutton:to-bbb-apps:voice"
  * "bigbluebutton:to-bbb-apps:whiteboard"

Throughout the meeting we keep receiving json messages via Redis about all the events in the meetings on the BigBlueButton server.
The handling procedure typically involves updating the particular document[s] in the collection.

The BigBlueButton Flash client can detect if the HTML5 client is installed and available on the server by making a GET request to `http://your_ip>/html5client/check` and receiving `{"html5clientStatus": "running"}`.

### Consistency of state

We rely heavily on the fact that MongoDB on the server side automatically pushes updates to MiniMongo on the client side.
The client side subscribes to the published collections on the server side. During the subscription, the meetingId, userId and authToken of the user logged in the client are required. These 3 identifiers provide enough information for the publishing mechanism to decide what subset of the collections the user logged in the client is authorized to view.

If a user loses connection while in the meeting, a message appears on the screen informing the user about the disconnection and the reconnection countdown. The client will periodically attempt to reconnect. If the reconnection is successful, the client will reappear with everything up to date.

