---
layout: page
title: "Architecture"
category: overview
date: 2015-04-04 22:11:11
---




# Overview

The master branch of the [GIT repository](http://github.com/bigbluebutton/bigbluebutton) contains the following components of BigBlueButton:

  * bigbluebutton-apps - The server side red5 web-apps of BigBlueButton (written in Java)
  * bigbluebutton-client - The Flex/Flash client of BigBlueButton (written in ActionScript)
  * bigbluebutton-web - The Grails application for scheduling conferences and logging in/out (written in Java)
  * deskshare-app - The Desktop Sharing server side red5 web-app (written in Java)
  * deskshare-applet - The Applet program used to capture the screen on the client (written in Java).

Other languages used in BigBlueButton are ruby (for [record and playback](Recording.md) processing) and bash (for [administrative tools](BBBConf.md)).

There are over a dozen [open source components](http://bigbluebutton.org/components/) that comprise BigBlueButton, along with the above parts.  The following diagrams describe how they all work together.


---


# Architecture Overview

The following diagram shows the major pieces of the BigBlueButton architecture.

![architecture_diagram_08](/images/architecture_diagram_08.png)

Notes:
  * BigBlueButton uses nginx as a proxy server to route incoming requests to the BigBlueButton client, to tomcat6 (running on port 8080) for api calls, and for supporting HTTP tunnelling when the client connects using RTMPT (port 80) instead of RTMP (port 1935).

---


## BigBlueButton Red5 Apps

We think Red5 rocks, and we use it as the core server for handling all the real-time interaction with the client.

![bbb_apps_overview_08](/images/bbb_apps_overview_08.png)


---


## BigBlueButton Client

We've written the real-time client in Flash.  Since Flash 10, Flash is now available on Mac, Unix, and PCs, and it provides the interface for collaboration with other users.



---


## Joining a Voice Conference

The following diagram shows the steps that occur when a new client joins a voice conference.

![joining_voice_conference_08](/images/joining_voice_conference_08.png)


---


## Uploading a Presentation

The following diagram shows the steps that occur when a presenter uploads a presentation to the server.

![uploading_presentation_08](/images/uploading_presentation_08.png)


---


## Desktop Sharing

The diagram bellow shows the main components of our screen sharing solution.

![bbb-deskshare](/images/bbb-deskshare.png)


---


## Integrated VOIP (red5 Phone)

The diagram bellow shows the main components of our integrated VOIP(red5 Phone) solution.

![bbb_voip](/images/bbb_voip.png)


---
