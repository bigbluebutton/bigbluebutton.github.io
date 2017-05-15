---
layout: page
title: "HTML5 Overview"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---


# Overview 

Welcome!  This document gives an overview of vision and scope (the first release) for the HTML5 client for BigBlueButton.  

Today, the Flash-based client for BigBlueButton supports a wide range of browsers (FireFox, Chrome, Safari, Edge, IE, etc.) and wide range of platforms (Windows, Mac OS X, Linux, and Chromebook).  It's seen over eight years with a focus on stability, usability, and features -- in that order.  The Flash client also leverages the latest technologies of the browsers to send and receive audio via web real-time communications (WebRTC).  If the user is running FireFox and Chrome, the BigBlueButton client defaults to WebRTC for audio.  This takes advantage of the browser to give users the best audio experience.   Flash has grown in platform support as well.  Google always has the latest version of Flash in Chrome, and recently Microsoft integrated Flash into IE11 and their next-generation browser Edge and ensure the user has the latest version of Flash via automatic Windows Update.

We always state the goal of the BigBlueButton project is to _provide remote students a high-quality online learning experience_.   However, the BigBlueButton Flash client does not work on mobile browsers, which means a student with only a mobile device can not participate.

If we can enable mobile users to run the HTML5 client alongside desktop and laptop users running the Flash client, then we could significantly increase the adoption of BigBlueButton (as measured by how many student could use from a mobile device) and the growth of the BigBlueButton community (as measured by how many educational institutions -- higher education, K12, or corporate learning -- use BigBlueButton within their learning management systems).

In a online classroom there are two broad sets of users: students and teachers.  These sets of users map into two different roles within the client: `viewers` and `moderators`.

A viewer can send/receive audio and video, engage in public/private chat, raise hand, respond to polls, join breakout rooms, and view close captions. 

Ini addition, a moderator can also mute/unmute other viewers, lock down all viewers, provide closed captioning, create breakout rooms, and make anyone (including themselves) the presenter.  The current presenter can upload slides, annotate the slides using whiteboard tools, and share their desktop for all to see.

## Vision
The BigBlueButton project wants to provide remote students a high-quality online learning experience regardless of their devices.   The long-term vision is to deliver an HTML5 client that works across all mobile devices.

The HTML5 client will fully integrate into the BigBlueButton server and provide an additional entry path into the session.  It will interoprate with other users.  The instructor shoudl not care which client student are using -- the both will give the same visibility into the session.


## Scope

The first step towards this vision is to create an HTML5 client that implements all the viewer capabilities in the Flash client.  This will enable remote students to participate in a BigBlueButton session using a mobile device that supports WebRTC for sending/receivng audio and video. 

Currently, desktop and laptop users of FireFox and Chrome have WebRTC, Chromebook users of Chrome have WebRTC, and users of Andorid clients have WebRTC in their browser.  However, as of today, Apple's Safari browser on iOS devices does *not* support WebRTC.  In a parallel project, we are building an iOS client for BigBlueButton.

The BigBlueButton HTML5 client represents a significant step towards the long-term vision.  For users, it would enable a significant number of mobile users to participate in an online class.   For developers, it would provide a modern platform for synchronous collaboration that other companies could build upon for the near-term and long-term.

# First Release

The first release of the HTML5 client will have all viewer capabilities of the Flash client in BigBlueButton 1.1 except two-way video (that will come in a subsequent release).  This means any user of the HTML5 client running in a browser that supports WebRTC will be able to do the following

  * send/receive audio
  * engage in public/private chat
  * Share emojis (including raise hand)
  * Respond to polls
  * Join breakout rooms
  * View desktop sharing
  * View close captions
  * Restrict of sharing chat and/or audio based on Moderator changing lock settings
  * Change the localization of the client

Secondary features include
  * Go into full-screen mode
  * Have responsive user experience on phone and tablet in portrait and landscape mode
  * Fully support all accessibility functions (such as keyboard navigation) in an HTML5 environment

Initial presentation capabilities include
  * Advance the slides
  * Go to a specific slide

Like BigBlueButton itself, the HTML5 client will be fully open source.  From the developers perspective, we want others to build up (and contribute to) the HTML5 client.  To support developers, we will provide documetation on the architecure, installation (via packages), and setting up the development environment, along with support in the bigbluebutton-dev mailing list from the core BigBlueButton devs.

Students and instructors can still join from Flash client on their desktop, laptop, and Chromebook.  The HTML5 client is a full BigBlueButton client and can interoperate with other users in a session using the above capabilities.

# Subsequent Releases

Building upon the first release, we plan to add additional capabilities in incremental updates that provide the following capabilities.

  * Upload slides
  * Whitebaord controls (pan/zoom and annotations, such as draw and text tool)
  * Two-way webcam
  * Share desktop
  * All remaining moderator capabilities, including
    * Make user presenter
    * Initiate breakout rooms
    * Lock down viewers

## User Interface Design

The user expereience of the HTML5 client should work well for both desktop and mobile clients.  As the first release of the HTML5 is targeting mobile users, the design should present a consisten and familiar mobile interface.  Here's an example view.

<br>
<center>
<img src="/images/bbb-html5_presenter_sidebar_chat.png" />
</center>

<br>
For more details on the design of the user experience, see [HTML5 Design](/html/html5-design.html).

## Overview of Architecture

The core architecural components of the HTML5 client are 
  * [Meteor.js](http://meteor.com) in [ECMA2015](http://www.ecma-international.org/ecma-262/6.0/)
The client side is built using React.js
  * [React.js](https://facebook.github.io/react/) for rendering the user interface in an efficent manner
  * [MongoDB](https://www.mongodb.com/) for keeping the state of each BigBlueButton client consistent with the BigBlueButton server
  * [WebRTC](https://webrtc.org/) for sending/receiving audio and video

The MongoDB database on the server side of the HTML5 client contains information about all meetings on the BigBlueButton server.  Each user's client is only aware of the meeting the user is currently in and the communication and state, such as public chat messages and private messages between that user and others.

The following diagram gives an overview of the architecture of the HTML5 client and its communications with the other components in BigBlueButton.

![HTML5 Overview](/images/html5-client-architecture.png)

## Implementation of the HTML5 Client (client side):

All the code for the HTML5 client is inside the `bigbluebutton/bigbluebutton-html5/` folder.  The whiteboard is an SVG element embedded in the page.

### SASS and Media Queries

We use [SASS](http://sass-lang.com/) precompiler to keep the stylesheets short and readable. SASS is a stylesheet language that is compiled into CSS. It allows us to use variables and mixins. Selectors can be nested, thus making it easier to read the code.

The responsive UI of the HTML5 client is constructed using media queries. Each SASS expression is tied to some specific range of devices and window sizes.

### React.js

We use the React front end for Meteor applications.

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


We parse this information and populate a Meetingscollection on the server side (stored in  MongoDB) for all the ongoing meetings on this BigBlueButton server.
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


## API

### HTML5 client installed


# Installation
There are two ways to install the client: from packages and for the development environment.

## From packages

You can install the current developer build of the HTML5 client on your existing [BigBlueButton 1.1](/install/install.html) server using the steps below.  As this is a development build, we do not recommend it for production use.

First, you need to install the latest version of mongodb:

~~~
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
$ echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org curl
sudo service mongod start
~~~

Next, install the nodeJS server:

~~~
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
~~~

You need only install mongodb and nodeJS once.  Next, install BigBlueButton HTML5 client

~~~
sudo apt-get install -y bbb-html5
~~~

The BigBlueButton configuration utility `bbb-conf` will automatically stop/restart BigBlueButton. 

As we update the BigBlueButton HTML5 client, you'll be able to update it along along with other components with the standard

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

The HTML5 client's package (bbb-html5) will restart with the other components when you perform `bbb-conf --restart` or `bbb-conf --clean`.

If you want to manually restart (or stop) it you can do so with the command

~~~
$ sudo service bbb-html5 restart
~~~

The logs for the component are located at `/var/log/bigbluebutton/html5/html5.log` and the code for the client can be found at `/usr/share/meteor/html5/`.

Later on if you wish to remove the HTML5 client, you can enter the command

~~~
$ sudo apt-get purge bbb-html5
~~~

# Development of the HTML5 client

If you want to explore, develop and improve the HTML5 client, please follow the instructions on [setting up HTML5 development environment](/html/html5-dev.html).

## Coding Practices

When making a new component there is a certain structure to implement and existing components to utilize to make your life easier. [HTML5 Coding Practices](/html/CodingPractices.html)

## Project Structure

Our directory structure is based off of Meteor's, see it here [HTML5 Project Structure](/html/project-structure.html)

# Join the Community

If you have any questions or feedback, please join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post them to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  We look forward to
 hearing from you.
