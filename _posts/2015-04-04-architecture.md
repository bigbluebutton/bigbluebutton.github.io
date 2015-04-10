---
layout: page
title: "Architecture"
category: overview
date: 2015-04-04 22:11:11
---

# Overview

BigBlueButton is comprised of over a dozen [open source components](http://bigbluebutton.org/components/). This page describes how they all work together.

You can get access to BigBlueButton repository located at [Github](http://github.com/bigbluebutton/bigbluebutton). 

# High-level Architecture Overview

The following diagram provides a high-level overview of the BigBlueButton architecture.

![Architecture Overview](/images/bbb-arch-overview.png)

### Client

The Client is a Flash application which runs inside the browser. The client connects to Red5 using RTMP (port 1935) or RTMPT (port 80) if needs to tunnel.
When it needs to connect using RTMPT, it connects through Nginx which proxies the connection to Red5.

The Client also uploads presentations to Web API.

### 3rd-party Applications

3rd-party applications (Moodle, Wordpress, Canvas, Sakai, etc.) integrates with BigBlueButton using the Web API. From within the 3rd-party apps, users are able to create and join meetings as well as access the recordings.

### Nginx

Nginx proxies calls to different server side applications through port 80. Nginx allows the Flash client to connect using RTMPT for users who can't connect to Red5 on port 1935. It also front-ends the Web API which runs on Tomcat7 listening on port 8080. For users joining the voice conference using WebRTC, nginx proxies the WebRTC connection to FreeSWITCH.

### Web API

The Web [API](/dev/api.html) provides an integration endpoint for 3rd-party applications (Moodle, Wordpress, Canvas, Sakai, etc.).

### Presentation Conversion

Uploaded presentations undergoes conversion process in order to be displayed in the Flash client. If the uploaded file is an Office document, it gets converted into PDF using LibreOffice and then converted to SWF using SWFTools. The conversion process is described later in this page.

### Redis PubSub

Redis PubSub provides a communication channel between different server side applications.

### Redis DB

When a meeting is recorded, all events are stored in Redis DB. When the meeting ends, the Recording Processor will take all the recorded events as well as the different raw (PDF, WAV, FLV) files for processing.

### Red5 Apps (Deskshare, Apps, Voice, Video)

We think Red5 rocks, and we use it as the core server for handling all the real-time interaction with the client.

The Apps is the main BigBlueButton application that handles users, chat, whiteboard, presentation information shared by all users in a meeting. The Deskshare application allows the presenter to share the desktop. The Voice application allows the user to call into the voice conference using a headset or join listen-only. The Video application provides a user to share his/her webcam to the users in the meeting.

### FreeSWITCH

FreeSWITCH provides the voice conferencing capability in BigBlueButton. Users are able to join the voice conference through the headset. Those who use a browser (Chrome, Firefox) is able to take advantage of higher quality audio by connecting using WebRTC. FreeSWITCH can also be integrated with VOIP providers so that users who are not able to joining using the headset will be able to call in using their phone.

## BigBlueButton Apps

BigBlueButton Apps is the main application that pulls together the different applications to provide real-time collaboration in the meeting. It provides the list of users, chat, whiteboard, presentations in a meeting.

Below is a diagram of the different components of BigBlueButton Apps.

![BigBlueButton apps architecture](/images/bbb-apps-arch.png)

BigBlueButton Apps has several components for it to communicate externally. It has components to receive (Red5ClientMessageReceiver) and send (Red5ClientMessageSender) to the Flash client. It subscribes to messages from the Redis PubSub as well as publishes events to Redis. The VoiceService components allows it to communicate to FreeSWITCH. When a meeting is recorded, events are stored into the Redis DB.

The meeting business logic is in the MeetingActor. This is where information about the meeting is stored and where all messages for a meeting is processed.

## Joining a Voice Conference

In BigBlueButton, a user can join the voice conference in several ways. Users can join using Flash, WebRTC, or phone. When joining through Flash, the user can choose to join listen-only or listen-and-talk. Users joined with Chrome and Firefox are able to join using WebRTC. WebRTC provides higher-quality and lower delay. If FreeSWITCH is integrated with a VOIP provider, users are able to call in using their phone by dialing a number and pressing the conference number on their keypad.

![Joining Voice Conference](/images/joining-voice-conf.png)


## Uploading a Presentation

Uploaded presentations go through a conversion process in order to be displayed inside the Flash client. When the uploaded presentation is an Office document, it needs to be converted into PDF using LibreOffice. The PDF document is then converted in SWF using SWFTools. There are times when a PDF page fails to convert to SWF. In this case, an image snapshot of the page is taken using ImageMagick/GhostScript and the image is converted to PDF then to SWF.

![Uploading Presentation](/images/presentation-upload.png)

The conversion process sends progress messages to the client through the Redis pubsub.

## BigBlueButton Client

BigBlueButton client runs inside the browser. The main application is in Flash. There are Javascript libraries that provides connection to FreeSWITCH, launch the desktop sharing applet, etc. The Flash client connects to BigBlueButton App to send and recieve messages. The client internally uses a event bus for the components to talk to each other.

![Client Architecture](/images/bbb-client-arch.png)