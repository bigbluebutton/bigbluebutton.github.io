---
layout: page
title: "1.0 Architecture"
category: labs
date: 2015-09-20 17:34:41
---

# Overview

BigBlueButton is build upon some amazing [open source components](http://bigbluebutton.org/components/). This page describes how they work together.

# High-level Architecture Overview

The following diagram provides a high-level overview of the BigBlueButton architecture.

![Architecture Overview](/images/10/bbb-arch-overview.png)

We'll break down each component below.

### Client

The Client is a Flash application which runs inside the browser. The client connects to Red5 using RTMP (port 1935) or RTMPT (port 80) if needs to tunnel.
When it needs to connect using RTMPT, it connects through Nginx which proxies the connection to Red5.

The Client also uploads presentations to Web API.


### HTML5 Client and Server

The HTML5 client and server is built using [Meteor](https://www.meteor.com/) and communicates with the other components of the system through redis pubsub. 

See the [HTML5 Overview] (/labs/html5-overview.html) document for more info.

### BBB Web 

The Web [API](/dev/api.html) provides the integration endpoint for third-party applications -- such as Moodle, Wordpress, Canvas, Sakai, etc. -- to control the BigBlueButton server. 

Every access to BigBlueButton comes through a front-end portal (we refer to as a third-party application).  BigBlueButton integrates Moodle, Wordpress, Canvas, Sakai, and others (see [third-party integrations](http://bigbluebutton.org/open-source-integrations/)).  From a learning management system (LMS) such as Moodle, teachers can setup BigBlueButton rooms within their course and students can access the rooms and their recordings. 

The BigBlueButton comes with some simple [API demos](http://demo.bigbluebutton.org/demo/demo1.jsp), but you really want to use an existing front-end or develop your own using the [BigBlueButton API](/dev/api.html).

### Presentation Conversion

Uploaded presentations undergoes conversion process in order to be displayed in the Flash client. If the uploaded file is an Office document, it gets converted into PDF using LibreOffice and then converted to SWF using SWFTools. The conversion process is described later in this page.

### Redis PubSub

Redis PubSub provides a communication channel between different server side applications.

### Redis DB

When a meeting is recorded, all events are stored in Redis DB. When the meeting ends, the Recording Processor will take all the recorded events as well as the different raw (PDF, WAV, FLV) files for processing.

### Red5 Apps (Deskshare, Apps, Voice, Video)

We think Red5 rocks! 

Red5 Apps are different applications that provide media streaming in the meeting and forwards messages between clients and Apps Akka.

The Apps is the main BigBlueButton application that handles users, chat, whiteboard, presentation information shared by all users in a meeting. The Deskshare application allows the presenter to share the desktop. The Voice application allows the user to call into the voice conference using a headset or join listen-only. The Video application provides a user to share his/her webcam to the users in the meeting.

![Red5 Apps architecture](/images/10/red5-apps-arch.png)

## Apps Akka

BigBlueButton Apps is the main application that pulls together the different applications to provide real-time collaboration in the meeting. It provides the list of users, chat, whiteboard, presentations in a meeting.

Below is a diagram of the different components of Apps Akka.

![Apps Akka architecture](/images/10/akka-apps-arch.png)

The meeting business logic is in the MeetingActor. This is where information about the meeting is stored and where all messages for a meeting is processed.

## FsESL Akka

We have extracted out the component that integrates with FreeSWITCH into it's own application. This allows others who are using voice conference systems other than
FreeSWITCH to easily create their own integration. Communication between apps and fsesl uses messages through redis pubsub.

![FsESL Akka architecture](/images/10/fsesl-akka-arch.png)


### FreeSWITCH

FreeSWITCH provides the voice conferencing capability in BigBlueButton. Users are able to join the voice conference through the headset. Users joining through Google Chrome or Mozilla Firefox are able to take advantage of higher quality audio by connecting using WebRTC. FreeSWITCH can also be integrated with VOIP providers so that users who are not able to join using the headset will be able to call in using their phone.

## Joining a Voice Conference

In BigBlueButton, a user can join the voice conference in several ways. Users can join using Flash, WebRTC, or phone. When joining through Flash, the user can choose to join listen-only or listen-and-talk. Users joined with Chrome and Firefox are able to join using WebRTC. WebRTC provides higher-quality and lower delay. If FreeSWITCH is integrated with a VOIP provider, users are able to call in using their phone by dialing a number and pressing the conference number on their keypad.

![Joining Voice Conference](/images/10/joining-voice-conf.png)


## Uploading a Presentation

Uploaded presentations go through a conversion process in order to be displayed inside the Flash client. When the uploaded presentation is an Office document, it needs to be converted into PDF using LibreOffice. The PDF document is then converted in SWF using SWFTools. There are times when a PDF page fails to convert to SWF. In this case, an image snapshot of the page is taken using ImageMagick/GhostScript and the image is converted to PDF then to SWF.

![Uploading Presentation](/images/10/presentation-upload.png)

The conversion process sends progress messages to the client through the Redis pubsub.

## BigBlueButton Client

BigBlueButton client runs inside the browser. The main application is in Flash. There are Javascript libraries that provides connection to FreeSWITCH, launch the desktop sharing applet, etc. The Flash client connects to BigBlueButton App to send and receive messages. The client internally uses a event bus for the components to talk to each other.

![Client Architecture](/images/10/bbb-client-arch.png)
