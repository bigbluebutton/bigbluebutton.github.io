---
layout: page
title: "HTML5 Overview"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---


# Overview 

This document gives an overview of the long-term vision and scope (the first release) for the development of the HTML5 client for BigBlueButton.

Today, the current BigBlueButton client runs in Flash.  Flash enjoys a wide range of browsers (FireFox, Chrome, Safari, Edge, IE, etc.) and a wide range of platforms (Windows, Mac OS X, Linux, and Chromebook).  The BigBlueButton client has over seven years of development with a focus on stability, usability, and features.  Over that time, the BigBlueButton client has been used by millions of users.  The BigBlueButton client also leverages web real-time communications (WebRTC), if available in the browser, for sending and receiving high-quliaty audio with very good echo cancellation.   

Over the years, support for the Flash runtime has grown as well.  Google has always bundled the latest version of Flash into Chrome, and, since recently, Microsoft integrates the Flash runtime into IE11 and into their next-generation browser Edge and automatically updates both via Windows Update.

We always state the goal of the BigBlueButton project is to _provide remote students a high-quality online learning experience_.   However, Flash does not run on mobile browsers, which means those students with only a mobile device cannot participate.

We want the BigBlueButton client to run on all mobile clients.  With mobile support we could increase the adoption of BigBlueButton (as measured by how many students could use it from a mobile device), increase the size of of the BigBlueButton community (as measured by how the number of educational institutions -- higher education, K12, or corporate learning -- that use BigBlueButton within their learning management systems), and increase the number of developers who build upon the BigBlueButton platform to create new products and services (as measured by design wins).

In an online classroom there are teachers and students.  In the BigBlueButton client, these groups of users map into `viewers` and `moderators` respectively. 

A viewer can send/receive audio and video, engage in public/private chat, raise hand, respond to polls, join breakout rooms, and view close captions. 

A moderator can, in addition to all the viewer capabilities, also mute/unmute other viewers, lock down all viewers, create live closed captioning, create breakout rooms, and make anyone (including themselves) the presenter.  The current presenter can upload slides, annotate the slides using whiteboard tools, and share their desktop for all to see.

## Vision
The BigBlueButton project wants to provide remote students a high-quality online learning experience _regardless of their devices_.   The long-term vision is to deliver an HTML5 client that works across all mobile devices.

The HTML5 client should interoperate with the Flash client.  The instructor should not care which client the user loads -- the both should give the same visibility and interactivity to the online class.  This approach builds upon the adoption of the Flash client and gives a smooth transition to the HMTL5 client.


## Scope

The first step towards this vision is to create an HTML5 client that implements all the viewer capabilities except two-way webcams (that will come in a subsequent release).  By focusing first on the viewer capabilities, we can release soon and enable remote students to participate using any mobile device that supports WebRTC.

Android devices (phone and tablet) provide excellent support for WebRTC.  However, Apple's Safari browser on both desktop and iOS devices does *not* yet support WebRTC (though there are indications this may change as WebKit, the underlying rendering engine for Safari, is getting support for WebRTC).  To support iOS, we are developing an iOS client in a parallel project.  The rest of this document focuses on the HTML5 client.

The BigBlueButton HTML5 client represents a significant step towards the long-term vision.  For users, it would enable Android users to participate in an online class.   For developers, it provides a modern platform for integrating synchronous collaboration into their products and services.

# First Release

The first release of the HTML5 client will have all viewer capabilities of the Flash client in BigBlueButton 1.1 (except two-way webcams).  This means FireFox and Chrome on the desktop, Chrome on the Chromebook, and Chrome or FireFox on an Android phone or tablet can

  * send/receive high-quality, low latency audio
  * engage in public/private chat
  * Share emojis (including raise hand)
  * Respond to polls
  * Join breakout rooms
  * View desktop sharing video from presenter
  * View close captions
  * Restrict of sharing chat and/or audio based on Moderator changing lock settings
  * Change the localization of the client

Secondary features include
  * Full-screen mode
  * Responsive user experience on phone and tablet in portrait and landscape mode
  * Support keyboard and screen reader accessibility functions

For the first release, we are also supporting presentation capabilities to
  * Advance the slides
  * Go to a specific slide

Like BigBlueButton itself, the HTML5 client will be fully open source.  From the developers' perspective, this means you can integrate and extend the HTML5 client.  To support developers, we provide documentation on the architecture, setting up a development environment, and installing on a BigBlueButton 1.1 (or later) server.  We also provide support in the [bigbluebutton-dev](https://bigbluebutton.org/support/community/) mailing list from the core BigBlueButton devs.

For a video walkthrough of what capabilities are in place as of 2017-05-15, click the image below of the HTML5 client.

[![BigBlueButton HTML5 client overview (dev release)](https://img.youtube.com/vi/wD7KCdFRm00/0.jpg)](https://www.youtube.com/watch?v=wD7KCdFRm00" BigBlueButton HTML5 client overview (dev release)")

You can try out the latest build of the BigBlueButton HTML5 client at the test server [https://test.bigbluebutton.org/](https://test.bigbluebutton.org/).  This developer release does not yet support viewing desktop sharing from the presenter.

# Future Releases

Building upon the first release, we plan to add the additional presenter and moderator capabilities to the HTML5 client, including:

  * Upload slides
  * Whiteboard controls (pan/zoom and annotations, such as draw and text tool)
  * Two-way webcam
  * Share desktop
  * All remaining moderator capabilities, including
    * Make user presenter
    * Initiate breakout rooms
    * Lock down viewers

The development goal is that the HTML5 client will reach feature parity with the Flash client, giving BigBlueButton a very broad platform choices for clients.

## User Interface Design

The user experience of the HTML5 client should work well for both desktop and mobile clients.  As the first release of the HTML5 is targeting mobile users, the design should present a consistent and familiar mobile interface.  Here's an example view.

<br>
<center>
<img src="/images/bbb-html5_presenter_sidebar_chat.png" />
</center>

<br>
For more details on the design of the user experience, see [HTML5 Design](/html/html5-design.html).

## Overview of Architecture

The core architecural components of the HTML5 client are 
  * [Meteor.js](http://meteor.com) in [ECMA2015](http://www.ecma-international.org/ecma-262/6.0/)
for communication between client and server.
  * [React.js](https://facebook.github.io/react/) for rendering the user interface in an efficient manner
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

# Installation
The steps below install the HTML5 client from packages.  If you are interested in development of the HTML5 client, after following the steps below see: [setting up HTML5 development environment](/html/html5-dev.html).

You can install the current developer build of the HTML5 client on your existing [BigBlueButton 1.1](/install/install.html) server using the steps below.  As this is a development build, we do not recommend it for production use.  If you are interested modifying the the HTML5 client, after following the steps below see: [setting up HTML5 development environment](/html/html5-dev.html).

To isntall the HTML5 client, first install the latest version of mongodb:

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

You need only install mongodb and nodeJS once.  Next, to install BigBlueButton HTML5 client

~~~
sudo apt-get install -y bbb-html5
~~~

As we update the BigBlueButton HTML5 client, you'll be able to update it along along with other components with the standard

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

The HTML5 client's package (bbb-html5) will restart with the other components when you perform `bbb-conf --restart` or `bbb-conf --clean`.

If you want to manually restart (or stop) it you can do so with the command

~~~
$ sudo systemctl restart bbb-html5.service
~~~

The logs for the component are located at `/var/log/bigbluebutton/html5/html5client.log` and the code for the client can be found at `/usr/share/meteor/bundle/`.

The configuration files for the client are located at `/usr/share/meteor/bundle/programs/server/assets/app/config`. If you modify them, you will need to restart bbb-html5.service for the new configuration to take effect.

Later on if you wish to remove the HTML5 client, you can enter the command

~~~
$ sudo apt-get purge bbb-html5
~~~

## Coding Practices

When making a new component there is a certain structure to implement and existing components to utilize to make your life easier. [HTML5 Coding Practices](/html/CodingPractices.html)

## Project Structure

Our directory structure is based off of Meteor's, see it here [HTML5 Project Structure](/html/project-structure.html)

## Localization

You can contribute to the localization of the HTML5 client. The method is the same as in the Flash client - by using Transifex. For more information, please visit [the localization page](/dev/localization.html). The Transifex project is titled "BigBlueButton HTML5".

# Join the Community

If you have any questions or feedback, please join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post them to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  We look forward to
 hearing from you.

