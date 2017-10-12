---
layout: page
title: "HTML5 Overview"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---


# Overview 

This document gives an overview of the long-term vision and near-term scope (the first release) planned for the BigBlueButton HTML5 client.

The BigBlueButton project started in 2009 with one goal: to prove remote students a high-quality online learning experience.  Since then, BigBlueButton client, written in Flash, has been has been used by millions of users in online classes.  

Flash enjoys support from a wide range of browsers (FireFox, Chrome, Safari, Edge, and IE) and a wide range of platforms (Windows, Mac OS X, Linux, and Chromebook).  Google embeds Flash into their browser and provides automatic updates, and  so does Microsoft in Edge.  BigBlueButton also leverages the browser's support for web real-time communications (WebRTC) for sending and receiving high-quliaty audio.

We also want BigBlueButton to run on mobile devices.  However, mobile devices do not support Flash natively.  Also, Adobe recently announce that Flash will be end of life in 2020 (which as the time of this writing is over three years away).  We want to move the BigBlueButton project to pure HTML5 and support mobile users _long_ before then.  Hence, the HTML5 client project.

It's worth stating that the HTML5 client is part of the BigBlueButton project.  It will be open source.  

If you are a developer,  this means you can integrate and extend the HTML5 client into your commercial product.  To support developers, we provide documentation on the architecture, setting up a development environment, and installing on a BigBlueButton 1.1 (or later) server.  We also provide support in the [bigbluebutton-dev](https://bigbluebutton.org/support/community/) mailing list from the core BigBlueButton devs.

For the sections below, a few definitions.  In the BigBlueButton client, a user joins as either a `viewer` or `moderator`.  A viewer can send/receive audio and video, engage in public/private chat, raise hand, respond to polls, join breakout rooms, and view close captions.  Students typically join as viewers.

A moderator can, in addition to all the viewer capabilities, also mute/unmute other viewers, lock down all viewers, create live closed captioning, create breakout rooms, and make anyone (including themselves) the presenter.  Teachers typically join as moderators.

Any moderator can make a user presenter (including themselves).  The current presenter can upload slides, annotate the slides using whiteboard tools, and share their desktop for all to see.

## Vision
The vision for the BigBlueButton project is to provide remote students a high-quality online learning experience regardless of the student's computer or device.

To achieve this vision, we want to deliver HTML5 client that works on desktop, laptops, and _mobile_ clients.  Working towards this vision, we want the HTML5 client to work alongside the Flash client to provide a smooth transition from one platform to another.  In this way, as the HTML5 client matures, we expect it to be increasingly used over the Flash client.  And, when the HTML5 client achieves parity of features with the Flash client, we can retire the Flash client.

## Scope

The near-term goal (the first release) is to create an HTML5 client that implements all the viewer capabilities of the Flash client with the exception of two-way webcams (that will come in a subsequent release) in an Andorid or iOS phone or tablet.  

Android provides excellent support for WebRTC in the Chrome browser.  As of the time of this writing, Apple recently released support for WebRTC in mobie Safari in iOS 11 (yay).  

# Features for the first release

The feature list for the first release of the HTML5 client will include

  * send/receive high-quality, low latency audio with WebRTC
  * engage in public/private chat
  * Share emojis (including raise hand)
  * Respond to polls
  * Join breakout rooms
  * View presentation
  * View desktop sharing video from presenter
  * View close captions
  * Restrict of sharing chat and/or audio based on Moderator changing lock settings
  * Localization
  * Responsive user experience on phone and tablet in portrait and landscape mode
  * Accessibility through keyboard navagitation 

The above feature list covers a lot of ground.  All the above is currently implemented, with the remaining features still in deveopment 

  * Initiate desktop sharing
  * View desktop sharing video from presenter

Recall we said that the first release will only support viewer capabilities.  We're a bit further along in the development of the HTML5 client than originally planned, so the first release will support some presentation capabilities 

  * Advance the slides
  * Upload a presentation

You can try out the latest build of the BigBlueButton HTML5 client at the test server [https://test.bigbluebutton.org/](https://test.bigbluebutton.org/).  This developer release does not yet support viewing desktop sharing from the presenter.


# Future Releases

Building upon the first release, we plan to add the additional presenter and moderator capabilities to the HTML5 client, including:

  * Whiteboard controls (pan/zoom and annotations, such as draw and text tool)
  * Two-way webcam
  * Share desktop
  * All remaining moderator capabilities, including
    * Make user presenter
    * Initiate breakout rooms
    * Lock down viewers


## User Interface 

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

# Installation of the HTML5 client
Before you install the HTML5 client, first follow the steps to setup a [BigBlueButton 2.0-beta](/2.0/20install.html) server.  As the HTML5 client is still under active develoipment we do not recommend it for production use.  

After you have BigBlueButton 2.0 setup, next install Modgo DB.

~~~
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
$ echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
$ sudo apt-get update
$ sudo apt-get install -y mongodb-org curl
$ sudo service mongod start
~~~

And then install the nodeJS server.

~~~
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
~~~

You need only install mongodb and nodeJS once.  After they are setup, you can install the BigBlueButton HTML5 client with a single command.

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


## Development of the HTML5 client

We welcome [contributions](/support/faq.html#contributing-to-bigbluebutton) from others.  See [setting up HTML5 development environment](/html/html5-dev.html) and [HTML5 Coding Practices](/html/CodingPractices.html)

Our directory structure is based off of Meteor's, see it here [HTML5 Project Structure](/html/project-structure.html)

## Localization

You can contribute to the localization of the HTML5 client. The method is the same as in the Flash client - by using Transifex. For more information, please visit [the localization page](/dev/localization.html). The Transifex project is titled "BigBlueButton HTML5".

# Join the Community

If you have any questions or feedback, please join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post them to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  We look forward to hearing from you.

## Accessibility

We designed the BigBlueButton HTML5 client to be accessible to as many users as possible regardless of any underlying disability. Screen reader compatibility has been provided for two of the most popular and widely used software solutions currently on the market.
 
  * NVDA (Open Source Software)
  * JAWS (Paid Software)

Keyboard support has also been provided so that users can interact with all interactable elements of the client via keyboard only.

#### Keyboard Example : Send a Public message when client first loads

* Close audio modal
  1. Tab
  2. Enter
* Open users pane
  1. Tab
  2. Enter
* Focus messages list
  1. Shift + Tab (x2)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Focus message input
  1. Tab (x6)
* Send message
  1. Type message
  2. Enter


### NVDA 

Common Navigation Shortcut keys: 

b - next button
k - next link
h - next heading
f - next form field
d - next landmark
NVDA shortcuts resource

***Note: NVDA works best with Mozilla FireFox and users must toggle focus mode off by pressing the ESC key or NVDAKEY + Spacebar to switch to Browse mode.***

#### NVDA Example : Send a Public message when client first loads 

* Close audio modal
  1. Tab
  2. Enter
* Open users pane
  1. Enter
* Focus messages list
  1. Shift + D (x2)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Focus message input
  1. ‘f’ key (x2)
  2. NDVA + spacebar
* Send message
  1. Type message
  2. Enter
  3. NDVA + spacebar


### JAWS

Common Navigation Shortcut keys:

JAWS shortcuts resource

***Note: JAWS users must ensure that cursor mode is toggled off by pressing JAWSKEY + z, in order to interact with users in the userlist. By default, the JAWSKEY is set to the insert key on the keyboard.***

#### JAWS Example : Send a Public message when client first loads

* Close audio modal
  1. JAWSKEY + z
  2. Tab
  3. Spacebar
* Open users pane
  1. Tab (x2)
  2. Space
* Focus messages list
  1. Shift + Tab (x3)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Focus message input
  1. JAWSKEY + z
  2. Tab
  3. ‘f’ key (x2)
  4. Enter
* Send message
  1. Type message
  2. Enter
