---
layout: page
title: "HTML5 Overview"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---


# Overview

This document gives an overview of current development build of the HTML5 client for BigBlueButton.  

Today, the Flash-based client for BigBlueButton supports a wide range of browsers (FireFox, Chrome, Safari, Edge, IE, etc.) and wide range of platforms (Windows, Mac OS X, Linux, and Chromebook).  The Flash client also leverages WebRTC if supported by the browser to give teachers and students the best audio experience.  Flash has great platform support as well: Google has built auto-updating capabilities into Chrome from the beginning, and recently Microsoft added auto-updating support IE 11 and their next-generation browser Edge.  

However, Flash does not work on mobile browsers.  And we want to ensure students with mobile devices can participate in a BigBlueButton session.

## Vision
The BigBlueButton project wants to provide remote students a high-quality online learning experience regardless of their devices.   Our long-term vision is to deliver an HTML5 client would be work on all devices.

## Scope

The first step towards this vision is to create an HTML5 client that students to participate in a BigBlueButton session on browsers that support WebRTC.  Currently, this means FireFox and Chrome on the desktop and laptop, and Chrome on Android devices.  The Safari browser on iOS devices does *not* support WebRTC yet.  We are also building an iOS client for BigBlueButton.

The first release Flash client will not be replaced by the HTML5 client -- all current functionality of BigBlueButton will remain intact.  Instead, we are adding to the functionality to connect via an HTML5 client to a BigBlueButton session.  This gives user the ability to have the best experience for their platform.  

## Phases for Development of HTML5 Client

We’ve mapped out the development of the HTML5 client in the phases:

  1. Viewing a live BigBlueButton session using an HTML5 browser (view presentation updates, view desktop sharing, two-way chat, two-way audio, respond to polls, emjoi icons).
  1. Presentation capabilities: advance slides and switch presentation.
  1. Two-way video
  1. All presenter capabilities
  1. All moderator capabilities

The following describes our efforts to implement Phase 1: viewing a live BigBlueButton session using an HTML5 browser.  The current builds support WebRTC audio and we are working on viewing the presenter's desktop via WebRTC video.

## User Interface Design

We intend the design of the HTML5 client to leverage a more modern, consistent design that would be familiar to users on mobile devices.  Here's an example view.

<br>
<center>
<img src="/images/bbb-html5_presenter_sidebar_chat.png" />
</center>

<br>
For more details on the design of the user experience, see [HTML5 Design](/html/html5-design.html).

## Overview of Architecture

The MongoDB database on the server side of the HTML5 client contains information about all meetings on the BigBlueButton server. Each user's client is only aware of the meeting the user is currently in and the communication the user is part of (public chat messages and private messages between that user and others).

Below you can see the current architecture of the HTML5 client and its communications with the other components in BigBlueButton.

![HTML5 Overview](/images/html5-client-architecture.png)

## Implementation of the HTML5 Client (client side):
The HTML5 client is implemented using [Meteor.js](http://meteor.com) in [ECMA2015](http://www.ecma-international.org/ecma-262/6.0/)
The client side is built using React.js

All the code for the HTML5 client is inside the `bigbluebutton/bigbluebutton-html5/` folder.

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


We parse this information and populate a Meetings [MongoDB] collection on the server side for all the ongoing meetings on this BigBlueButton server.
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
It is crucial for the HTML5 client that the Mongo database stays up to date.

### Behind the curtains:

We rely heavily on the fact that MongoDB on the server side automatically pushes updates to MiniMongo on the client side.
The client side subscribes to the published collections on the server side. During the subscription, the meetingId, userId and authToken of the user logged in the client are required. These 3 identifiers provide enough information for the publishing mechanism to decide what subset of the collections the user logged in the client is authorized to view.

Losing connection:
(Client side) If a user loses connection while in the meeting, a message appears on the screen informing the user about the disconnection and the reconnection countdown. The client will periodically attempt to reconnect. If the reconnection is successful, the client will reappear with everything up to date.


## API

### Check
Check if the HTML5 client is running and ready to serve users:

`http://your_ip>/html5client/check`

The result should be `{"html5clientStatus": "running"}`.


## Current stage

### Implemented:
  * two way public and private chat
  * viewing presentation with slides, cursor, whiteboard annotations
  * audio using WebRTC (listen and speak AND listen only modes)
  * lock settings
  * polling
  * breakout rooms
  * accessibility
  * localizations

### Not yet implemented (see more information about these features in the existing Flash client):
  * viewing of desktop sharing video

### Planned features:
  * webcam video


## Whiteboard

The whiteboard is an SVG element embedded in the page, composed of images, a small red cursor and any shapes drawn by the presenter.

# Installation
There are two ways to install the client:
- setting up a development environment or
- installing packages for { bbb-html5, Nodejs, MongoDB }


## Install the HTML5 client from packages

To install the current dev version of the BigBlueButton HTML5 client, setup a [BigBlueButton 1.1](/install/install.html) server.  

First, you need to install the latest version of mongodb:

~~~
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
$ echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org curl
sudo service mongod start
~~~

Then add nodeJS:

~~~
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
~~~

You need only install mongodb and nodeJS once.  At this point, you can install the current build of the BigBlueButton HTML5 client

~~~
sudo apt-get install -y bbb-html5
~~~

After the install, you should be able to navigate to the `<your domain>/demo/demoHTML5.jsp` demo and join via the HTML5 client.  The HTML5 client will be updated along with other components when you do a

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

From now on the HTML5 client's package (bbb-html5) will update when you update BigBlueButton, will restart with the other components when you perform `bbb-conf --restart` or `bbb-conf --clean`.
If you want to manually restart (or stop) it you can do so with the command

~~~
$ sudo service bbb-html5 restart
~~~

Note that the logs for the component are located at `/var/log/bigbluebutton/html5/html5.log` and the code for the client can be found at `/usr/share/meteor/html5/`.

Later on if you wish to remove the HTML5 client, you can enter the command

~~~
$ sudo apt-get purge bbb-html5
~~~

## Set up a Development Environment

If you want to explore, develop and improve the HTML5 client, please follow the instructions on [setting up HTML5 development environment](/html/html5-dev.html)

## Coding Practices

When making a new component there is a certain structure to implement and existing components to utilize to make your life easier. [HTML5 Coding Practices](/html/CodingPractices.html)

## Project Structure

Our directory structure is based off of Meteor's, see it here [HTML5 Project Structure](/html/project-structure.html)
