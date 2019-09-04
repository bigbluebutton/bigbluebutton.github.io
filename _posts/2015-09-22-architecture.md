---
layout: page
title: "Architecture"
category: 2.2
redirect_from: "/1.0/10architecture"
date: 2015-09-20 17:34:41
---

# Overview

BigBlueButton is built upon many amazing software components -- nginx, red5, FreeSWITCH, tomcat7, redis, and others.  This page describes the overall architecture of BigBlueButton and how the components work together.

# High-level Architecture Overview for BigBlueButton

The following diagram provides a high-level overview of the BigBlueButton architecture.

![Architecture Overview](/images/10/bbb-arch-overview.png)

We'll break down each component below.

## HTML5 Client and Server

The HTML5 client is a single page, responsive web application that is built upon the following components: 
  * [React.js](https://facebook.github.io/react/) for rendering the user interface in an efficient manner
  * [WebRTC](https://webrtc.org/) for sending/receiving audio and video

The HTML5 server is built upon
  * [Meteor.js](http://meteor.com) in [ECMA2015](http://www.ecma-international.org/ecma-262/6.0/)
for communication between client and server.
  * [MongoDB](https://www.mongodb.com/) for keeping the state of each BigBlueButton client consistent with the BigBlueButton server

The MongoDB database contains information about all meetings on the server and, in turn, each client connected to a meeting. Each user's client is only aware of the their meeting's state, such the user's public and private chat messages sent and received. The client side subscribes to the published collections on the server side. Updates to MongoDB on the server side are automatically pushed to MiniMongo on the client side.

The following diagram gives an overview of the architecture of the HTML5 client and its communications with the other components in BigBlueButton.

![HTML5 Overview](/images/html5-client-architecture.png)

More information on the architecture of the HTML5 client can be found [here](/html5-overview.html).

## BBB Web 

The Web [API](/dev/api.html) provides the integration endpoint for third-party applications -- such as Moodle, Wordpress, Canvas, Sakai, etc. -- to control the BigBlueButton server. 

Every access to BigBlueButton comes through a front-end portal (we refer to as a third-party application).  BigBlueButton integrates Moodle, Wordpress, Canvas, Sakai, and others (see [third-party integrations](http://bigbluebutton.org/integrations/)).  BigBlueButton comes with its own front-end called [GreenLight](/install/greenlight-v2.html).  When using a learning management system (LMS) such as Moodle, teachers can setup BigBlueButton rooms within their course and students can access the rooms and their recordings. 

The BigBlueButton comes with some simple [API demos](http://demo.bigbluebutton.org/demo/demo1.jsp).  Regardless of which front-end you use, they all use the [API](/dev/api.html) under the hood.

## Redis PubSub

Redis PubSub provides a communication channel between different applications running on the BigBlueButton server.

## Redis DB

When a meeting is recorded, all events are stored in Redis DB. When the meeting ends, the Recording Processor will take all the recorded events as well as the different raw (PDF, WAV, FLV) files for processing.

## Red5 Apps (Screenshare, Apps, Voice, Video)

We think Red5 rocks! (We just had to get that upfront).

Red5 Apps are different applications that provide media streaming in the meeting and forwards messages between clients and Apps Akka.

The Apps is the main BigBlueButton application that handles users, chat, whiteboard, presentation information shared by all users in a meeting. The Screenshare application allows the presenter to share their screen. The Voice application allows the user to call into the voice conference using a headset or join listen-only. The Video application provides a user to share his/her webcam to the users in the meeting.

![Red5 Apps architecture](/images/10/red5-apps-arch.png)

## Apps Akka

BigBlueButton Apps is the main application that pulls together the different applications to provide real-time collaboration in the meeting. It provides the list of users, chat, whiteboard, presentations in a meeting.

Below is a diagram of the different components of Apps Akka.

![Apps Akka architecture](/images/10/akka-apps-arch.png)

The meeting business logic is in the MeetingActor. This is where information about the meeting is stored and where all messages for a meeting is processed.

## FsESL Akka

We have extracted out the component that integrates with FreeSWITCH into it's own application. This allows others who are using voice conference systems other than
FreeSWITCH to easily create their own integration. Communication between apps and FreeSWITCH Event Socket Layer (fsels) uses messages through redis pubsub.

![FsESL Akka architecture](/images/10/fsesl-akka-arch.png)


## FreeSWITCH

We think FreeSWITCH rocks too!

FreeSWITCH provides the voice conferencing capability in BigBlueButton. Users are able to join the voice conference through the headset. Users joining through Google Chrome or Mozilla Firefox are able to take advantage of higher quality audio by connecting using WebRTC. FreeSWITCH can also be [integrated with VOIP providers](/install/install.html#add-a-phone-number-to-the-conference-bridge) so that users who are not able to join using the headset will be able to call in using their phone.

## Joining a Voice Conference

A user can join the voice conference (running in FreeSWITCH) in several ways. Users can join using Flash, WebRTC, or phone. When joining through Flash, the user can choose to join listen-only or listen-and-talk. Users joined with Chrome and Firefox are able to join using WebRTC.  Thanks to the browser's ability to send opus encoded audio packets via UDP, WebRTC provides users higher-quality audio with lower delay. If FreeSWITCH is integrated with a VOIP provider, users are able to call in using their phone by dialing a number and pressing the conference number on their keypad.

![Joining Voice Conference](/images/10/joining-voice-conf.png)


## Uploading a Presentation

Uploaded presentations go through a conversion process in order to be displayed inside the Flash client. When the uploaded presentation is an Office document, it needs to be converted into PDF using LibreOffice. The PDF document is then converted in SWF using SWFTools. There are times when a PDF page fails to convert to SWF. In this case, an image snapshot of the page (as PNG) is taken using pdftocairo the resulting image is converted SWF.

![Uploading Presentation](/images/10/presentation-upload-11.png)

The conversion process sends progress messages to the client through the Redis pubsub.

## Presentation conversion flow

The diagram below describes the flow of the presentation conversion. We take in consideration the configuration for enabling and disabling SWF, SVG and PNG conversion.

![General Conversion Flow](/images/diagrams/Presentation Conversion Diagram-General Conversion Flow.png)

Then below the SVG conversion flow. It covers the conversion fallback. Sometimes we detect that the generated SVG file is heavy to load by the browser, we use the fallback to put a rasterized image inside the SVG file and make its loading light for the browser.

![SVG Conversion Flow](/images/diagrams/Presentation Conversion Diagram-SVG Conversion Flow.png)

And finally, the SWF conversion flow. We cover it too with its fallback conversion.

![SWF Conversion Flow](/images/diagrams/Presentation Conversion Diagram-SWF Conversion Flow.png)

## BigBlueButton Client

BigBlueButton Flash client runs inside the browser. The main application is in ActionScript. There are Javascript libraries that provides connection to FreeSWITCH, launch the screen sharing applet, etc. The Flash client connects to BigBlueButton App to send and receive messages. The client internally uses an event bus for the components to talk to each other. The client connects to Red5 using RTMP (port 1935) or RTMPT (port 80) if needs to tunnel. When it needs to connect using RTMPT, it connects through Nginx which proxies the connection to Red5.

![Client Architecture](/images/10/bbb-client-arch.png)
