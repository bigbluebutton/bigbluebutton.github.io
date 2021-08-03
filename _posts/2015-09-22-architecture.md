---
layout: page
title: "Architecture"
category: 2.2
redirect_from: 
  - /1.0/10architecture
  - /architecture
date: 2015-09-20 17:34:41
order: 8
---

BigBlueButton is built upon a solid foundation of underlying components, including nginx, FreeSWITCH, Kurento, redis, react, and others.  

This page describes the overall architecture of BigBlueButton and how these components work together.

# High-level architecture

The following diagram provides a high-level view of how BigBlueButton's components work together.

![Architecture Overview](/images/10/bbb-arch-overview.png)

We'll break down each component in more detail below.

## HTML5 client 

The HTML5 client is a single page, responsive web application that is built upon the following components: 
  * [React.js](https://facebook.github.io/react/) for rendering the user interface in an efficient manner
  * [WebRTC](https://webrtc.org/) for sending/receiving audio and video

The HTML5 client connects directly with the BigBlueButton server over port 443 (SSL), from loading the BigBlueButton client to making a web socket connection.  These connections are all handled by nginx.

## HTML5 server

The HTML5 server sits behind nginx. 

The HTML5 server is built upon
  * [Meteor.js](http://meteor.com) in [ECMA2015](http://www.ecma-international.org/ecma-262/6.0/)
for communication between client and server.
  * [MongoDB](https://www.mongodb.com/) for keeping the state of each BigBlueButton client consistent with the BigBlueButton server

The MongoDB database contains information about all meetings on the server and, in turn, each client connected to a meeting. Each user's client is only aware of the their meeting's state, such the user's public and private chat messages sent and received. The client side subscribes to the published collections on the server side. Updates to MongoDB on the server side are automatically pushed to MiniMongo on the client side.

The following diagram gives an overview of the architecture of the HTML5 client and its communications with the other components in BigBlueButton.

![HTML5 Overview](/images/html5-client-architecture.png)


## BBB web 

BigBlueButton web application is a Java-based application written in Scala.  It implements the [BigBlueButton API](/dev/api.html) and holds a copy of the meeting state.

The BigBlueButton API provides a third-party integration (such as the [BigBlueButtonBN plugin](https://moodle.org/plugins/mod_bigbluebuttonbn) for Moodle) with an endpoint to control the BigBlueButton server.

Every access to BigBlueButton comes through a front-end portal (we refer to as a third-party application).  BigBlueButton integrates Moodle, Wordpress, Canvas, Sakai, and others (see [third-party integrations](http://bigbluebutton.org/integrations/)).  BigBlueButton comes with its own front-end called [Greenlight](/install/greenlight-v2.html).  When using a learning management system (LMS) such as Moodle, teachers can setup BigBlueButton rooms within their course and students can access the rooms and their recordings. 

The BigBlueButton comes with some simple [API demos](http://demo.bigbluebutton.org/demo/demo1.jsp).  Regardless of which front-end you use, they all use the [API](/dev/api.html) under the hood.

## Redis PubSub

Redis PubSub provides a communication channel between different applications running on the BigBlueButton server.

## Redis DB

When a meeting is recorded, all events are stored in Redis DB. When the meeting ends, the Recording Processor will take all the recorded events as well as the different raw (PDF, WAV, FLV) files for processing.

## Apps akka

BigBlueButton Apps is the main application that pulls together the different applications to provide real-time collaboration in the meeting. It provides the list of users, chat, whiteboard, presentations in a meeting.

Below is a diagram of the different components of Apps Akka.

![Apps Akka architecture](/images/10/akka-apps-arch.png)

The meeting business logic is in the MeetingActor. This is where information about the meeting is stored and where all messages for a meeting is processed.

## FSESL akka

We have extracted out the component that integrates with FreeSWITCH into it's own application. This allows others who are using voice conference systems other than
FreeSWITCH to easily create their own integration. Communication between apps and FreeSWITCH Event Socket Layer (fsels) uses messages through redis pubsub.

![FsESL Akka architecture](/images/10/fsesl-akka-arch.png)


## FreeSWITCH

We think FreeSWITCH is an amazing piece of software for handling audio.

FreeSWITCH provides the voice conferencing capability in BigBlueButton. Users are able to join the voice conference through the headset. Users joining through Google Chrome or Mozilla Firefox are able to take advantage of higher quality audio by connecting using WebRTC. FreeSWITCH can also be [integrated with VOIP providers](/install/install.html#add-a-phone-number-to-the-conference-bridge) so that users who are not able to join using the headset will be able to call in using their phone.

## Kurento and WebRTC-SFU

Kurento Media Server KMS is a media server that implements both SFU and MCU models. KMS is responsible for streaming of webcams, listen-only audio, and screensharing. The WebRTC-SFU acts as the media controller handling negotiations and to manage the media streams.

## Joining a voice conference

A user can join the voice conference (running in FreeSWITCH) from the BigBlueButton HTML5 client or through the [phone](/2.2/customize.html#add-a-phone-number-to-the-conference-bridge). When joining through the client, the user can choose to join Microphone or Listen Only, and the BigBlueButton client will make an audio connection to the server via WebRTC.  WebRTC provides the user with high-quality audio with lower delay. 

![Joining Voice Conference](/images/10/joining-voice-conf.png)


## Uploading a presentation

Uploaded presentations go through a conversion process in order to be displayed inside the client. When the uploaded presentation is an Office document, it needs to be converted into PDF using LibreOffice. The PDF document is then converted into scalable vector graphics (SVG) via `bbb-web`.  

![Uploading Presentation](/images/10/presentation-upload-11.png)

The conversion process sends progress messages to the client through the Redis pubsub.

## Presentation conversion flow

The diagram below describes the flow of the presentation conversion. We take in consideration the configuration for enabling and disabling SWF, SVG and PNG conversion.

![General Conversion Flow](/images/diagrams/Presentation Conversion Diagram-General Conversion Flow.png)

Then below the SVG conversion flow. It covers the conversion fallback. Sometimes we detect that the generated SVG file is heavy to load by the browser, we use the fallback to put a rasterized image inside the SVG file and make its loading light for the browser.

![SVG Conversion Flow](/images/diagrams/Presentation Conversion Diagram-SVG Conversion Flow.png)

## Internal network connections
The following diagram shows how the various components of BigBlueButton connect to each other via sockets.

![Network Connections](/images/22-connections.png)
