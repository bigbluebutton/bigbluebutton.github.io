---
layout: page
title: "HTML5 Overview"
category: html
date: 2015-04-05 11:41:36
---


# Overview

**Note**: This document is DRAFT and currently under construction.

This DRAFT document outlines some of our progress to-date, which has been to prototype a stand-alone HTML5 client that is integrated into the BigBlueButton platform, thus providing an additional entry point for users to join a BigBlueButton session.

# Vision
With the adoption of HTML5, the web browser is becoming the platform for rich client interfaces.

Furthermore, with the recent progress in WebRTC, an HTML5-based application can access the user's webcam and microphone _without_ the need for plugins.

The long-term vision for the BigBlueButton HTML5 client is to enable users on all platforms supporting an HTML5 browser -- including mobile and tablets to -- to fully access all of BigBlueButton’s features.

This means the HTML5 client will completely implement the current Flash-based functionality, including the ability to broadcast audio and video from within the browser using WebRTC.

The existing Flash client will not be replaced by the HTML5 client -- all current functionality of BigBlueButton will remain intact.  We are adding to the functionality by providing users with the ability to join a session (and increasingly participate) through an HTML5 interface (no flash).

## Phases for Development of HTML5 Client

We’ve mapped out the development of the HTML5 client in three phases:

  1. Viewing a live BigBlueButton session using an HTML5 browser (view presentation updates, streaming audio/video, two-way chat).
  1. Broadcast audio/video from an HTML5 browser using WebRTC
  1. Support for all presentation features of BigBlueButton in HTML5

The following describes our efforts to implement phase 1: viewing a live BigBlueButton session using an HTML5 browser.

## UI Mockups

The following images show some rough early-stage designs of a BigBlueButton HTML5 client interface.

A mockup of a presentation view of the interface.  A viewer only mode for Phase 1 would be a simplification of this interface that removes the presenter controls.

![bbb_html5_presenter](/images/bbb_html5_presenter.png)

Here are a series of mockups of showing how video could be viewed within the interface.  The first mockup shows a single webcam, which is what we are working to achieve in Phase 1.

![bbb_html_cam1](/images/bbb_html_cam1.png)

This shows multiple webcams.

![bbb_html_cam2](/images/bbb_html_cam2.png)

Here's a variation showing the webcams along the bottom.
![bbb_html_cam3](/images/bbb_html_cam3.png)

Here's another variation showing the webcams taking a complete row.
![bbb_html_cam4](/images/bbb_html_cam4.png)


## Overview of Architecture

BigBlueButton already provides the full client/server architecture for real-time collaboration and presentations, which includes
  * API interface
  * Presentation conversion
  * Whiteboard
  * Record and playback infrastructure
  * real-time audio and video sharing

Building on this platform, we want to extend BigBlueButton’s architecture to enable a HTML5-based BigBlueButton client to join a live session, specifically:

  * Get presence information from the BigBlueButton server
  * Two-way chat
  * View all the presentation events
  * Hear the presenter's audio
  * See the presenter's video

The following diagram outlines our intended approach

![html5-architecture](/images/html5-architecture.png)

Figure 1. Prototype extensions to the current BigBlueButton architecture to support Phase 1: viewer receives presentation, audio, and video (single webcam) and has two-way chat.

## Client Architecture
![html5-client-arch](/images/html5-client-arch.png)

## Prototype Implementation

We have been working on an HTML5 prototype by extending BigBlueButton’s architecture as described in Figure 1. The major pieces are:
  * HTML 5 client
  * HTML 5 server (node.js)
  * Shared database with BigBlueButton (redis)
  * Streaming server for broadcast of audio and video in WebM


We designed the BigBlueButton HTML5 client to be stand-alone from the BigBlueButton server, which enabled us to development them in parallel.  In the final form, the HTML5 client will integrate with BigBlueButton server for all session and events.
Node.js


The web server for the HTML5 client is built using the Node.js platform. The Node server serves up static web pages to the clients that connect to it.

The Node server connects to BigBlueButton via redis. When BigBlueButton creates a session (when requested by an API call), it creates a corresponding session in Redis.  The user joins the HTML5 interface via a URL that is similar to the current join URL for BigBlueButton.

Once the user has been served the client interface, it’s client-side javascript under the hood immediately connects back to the Node server using WebSockets (through SocketIO).  the BigBlueButton client gives the Node server the cookies it was just given, and server-side verification of the meetingID and the user’s unique sessionID are cross referenced to Redis. The server then stores the cookie information right in the handshake data of the socket so it can be used when the client emits events through SocketIO.

Aside from file uploads of presentations, almost all the communication from this point on between the client and the server is done through SocketIO.


## SocketIO


WebSockets is the key to having a real-time application built in the web browser using HTML5. Node at this point, acts as a delegate of information for every connected client, and WebSockets is the way it communicates back with the clients when it needs to, such as to send a message for example.

The intensive calculations for the whiteboard are done on the client.  ImageMagick takes care of the file conversions/processing, and Redis handles all the data store and retrieval actions. Node simply calls on all these pieces and tells the clients whenever it gets a reply back.

SocketIO allows the delegation of rooms so once the socket has connected successfully to the node server, it is then joined into two rooms:

Room 1, SessionID: The value of the room is the sessionID of the user. By sending messages to all members of this room, a client is effectively sending messages to all connected sockets of that particular user. All open tabs in the same browser connected to the server will have the same sessionID (though different sockets) so if a user clicks logout on one tab, the server will reiterate the logout command to all sockets of that particular sessionID, effectively logging the user out of all tabs with a single click from one tab. Implementing private messages from user to user is another way that messages to a specific SessionID would be utilized.

Room 2, MeetingID: The value of the room is the MeetingID of the user. By sending messages to all members of this room, a client is effectively sending messages to all connected sockets of every user in that particular meeting. When a user sends a public chat, the chat messages is saved in Redis and sent to all members of the room matching the MeetingID of the socket that sent the chat message. To send messages back to the client, messages will be published using Redis PubSub.


## Redis PubSub


The Redis server in our infrastructure is actually serving multiple purposes. The first of its purposes is to store and serve data to and from the clients. It’s second purpose is for publishing and subscribing to allow the relay of messages to be picked up by any additional clients connected to the Redis server. This will be particularly useful when the existing BigBlueButton infrastructure is implemented to connect to the Redis server being shared by the Node server, thus allowing the relay of messages between the Node server for HTML5 clients and the Red5 server for Flash based clients.

In Node, there are in fact three clients connected to Redis. The first is the store, allowing the transfer and retrieval of data to/from the Redis server, and the other two are Pub (for publishing messages) and Sub (for subscribing to messages from Pub). Pub publishes on a channel equal to either a SessionID or a MeetingID, which is then received by Sub (who currently is subscribed to the channel `*`, a wildcard for receiving all messages.) and Sub then parses the message, and relays the message to the SocketIO room equal to the channel it just received the message from (either SessionID or MeetingID). The code snippet that handles all of these messages is below.

```
sub.on("pmessage", function(pattern, channel, message) {
  var channel_viewers = io.sockets['in'](channel);
  channel_viewers.emit.apply(channel_viewers, JSON.parse(message));
});
```


Once the message has been received by sub, it immediately sends it back through SocketIO to all members of the particular room that was specified. From here the client takes care of the message.


## HTML5 Client


The HTML5 client has many different features to it that can and should be taken as individual pieces. All parts of the client share the common goal which essentially will result in either sending a message to the server, or acting on a message received from the server. Usually it does this so fast you wouldn’t even know it has gone to the server and is already back waiting for more. The main features of the client can be seen at a glance (see Figure 4) and include:

  * Public Chat
  * User List/Switcher
  * Whiteboard
  * Upload Dialog
  * Logout button
  * Public Chat

Features include:
  * Send and receive messages between all members of the current meeting.
  * Receive all messages that have occurred since the meeting has begun on login.
  * Character limit of 140 characters adjustable and enforced client and server side.
  * Full escaped messages on server-side as a security measure.

### Under the hood

The HTML5 BigBlueButton client started out as a simple chat between clients. It’s arguably one of the easiest things to implement using WebSockets. As long as our client has a connected socket through SocketIO, which will occur essentially immediately upon login, sending a message to all members of the meeting is as simple as “socket.emit(‘msg’, “Hello World!”);”. The server, after validation, relays the message to all members of the meeting, including the sender.

This is to say, the user won’t see their update until everyone in the meeting sees the update, and this is the way communication is implemented for all actions in the client. This removes all the burden off of the presenter who may question whether the members of the meeting can see what they are presenting. If the presenter doesn’t see it, nobody can.


## User List/Switcher

### Features include
  * See real-time current users connected.
  * Delegate specific user as presenter without exposing their private sessionID to others
  * See who is current presenter at a glance
  * Presenter is verified server-side to ensure only one (or no) presenter at a time.

### Under the hood

To tell the server to change the presenter, the server needs to know the sessionID of the user we are talking about. But we don’t want to tell all the clients everyone’s sessionID because it could be used illegitimately to mimic/duplicate other clients. To solve this, we have the server generate a publicID for every sessionID. The publicID can be shared with other clients and is used in only specific cases where one client needs to tell the server a message about another specific client, such as with switching presenter, sending a private message, or muting/unmuting another user. Attempting to use the publicID to mimic another user would never work.


## Whiteboard


What you see on your whiteboard is what all members of the meeting see on theirs:
  * Forward slide/backward slide buttons switch current slide to next/previous slide.
  * Line tool allows drawing of pencil marks on the whiteboard in real-time.
  * Holding shift while using the line tool draws a straight line.
Rectangle tool allows drawing of rectangles on the whiteboard in real-time.
  * Holding shift while using the rectangle tool draws a square.
Ellipse tool allows drawing of ellipses on the whiteboard in real-time.
Holding shift while using the ellipse tool draws a circle.
Text tool allows for typing and entering text on the whiteboard in real-time.
  * Colour wheels allows the change of colour to lines, rectangles, ellipses and text.
  * Thickness slider allows the change of thickness to lines, rectangles, and ellipses.
  * Fit to page (default) fits the entire document into the slide view.
  * Fit to width stretches page to fill the width, allowing panning up and down if applicable.
  * Clear button clears all markings on the page, leaving only the slide image.
  * Undo button clears the last shape made on the page, leaving all other shapes in tact.
  * Pan tool for panning around the document.
Zoom by scrolling with the mouse wheel at any point while you are presenter.

### Under the hood
The whiteboard is an SVG element embedded in the page, composed of images, a small red cursor and any shapes you draw. Raphael.js is used to automate most of the SVG manipulation but lots of math is still required on the client side. Raphael’s objects are always listening for events and acting on them according to the current tool selected. So when you have the Line tool selected, and you click on the whiteboard and drag around, your line events are sent to the server, and drawn when you get them back (at the same time all other meeting clients get the events back). When you hover over the page, the cursor is updated, but of course at the same time everyone elses cursor is updated.

SocketIO makes this communication of small events fast and flexible as there is very little overhead to talk to the server compared to other methods of two-way server/client communication.

All shapes that need to be saved are given a unique shapeID that is stored in an ordered Redis list. Undoing a shape is simply popping the last shapeID from this list, and removing that key (referencing to the shape data) from the server as well. Clearing involves iterating through the list of shapeIDs, removing each key and then deleting the list. If we wish to save the shapes for processing later, we can add the shapeID to two lists, one for current shapes and the other for all shapes. Simply delete from the current shapes when undoing/clearing, and add to both when adding more shapes. Then at the end of the meeting, process the all shapes list. This is what currently happens, however processing the all shapes list simply deletes everything for now.

Advantages to SVG:

  * Panning and zooming are relatively easy using SVG because no objects need to be scaled, it is all handled automatically when you simply adjust the viewBox property of the SVG object.

  * SVG, much as its acronym suggests, are scalable. Thus any screen size, big or small, can be adjusted and aside from the the background image, all shapes will be drawn at a greater resolution automatically. Things will just look great at any size.

  * SVG is in the DOM, so being an HTML5 application, means we have VIP access through JavaScript to everything in the whiteboard. So say we want to move that text around, click and delete that line we drew a while ago, or click and drag to select many shapes at once, this would be not only possible (important!) but also relatively easy to do, all on the client side.

### Upload Dialog

Features include:
  * Uploading any document supported by ImageMagick to be converted into png images.  (If processing of a document fails, it will revert to its previous presentation)
  * AJAX upload results in a seamless upload experience (no refreshing required)
  * Displays updates on the status of the upload as it uploads, processes and finishes.

### Under the hood

When you upload a new document, Node receives the request, it creates a new presentation folder for these files and passes the file uploaded into ImageMagick to process. If ImageMagick can successfully convert the file into a png image or series of png images (such is the case with a multi-page PDF file), then each file is stored in Redis and the new slide urls are sent to every client in the meeting. Each client then handles downloading the images and embedding them into their person SVG.

The images are stored as a file name in an ordered Redis list. As the presenter clicks next and previous, the list is rotated in Redis (e.g. pop off the back and push onto the front), and the new ordered list of filenames is sent to each client, where the browser will load them in that particular order.

To ensure the client doesn’t redownload every file at every next/previous action, a hidden image is loaded and stored on the client that remains there until the client refreshes their browser. When the browser realizes the file reference is equal to the src of an image already embedded and loaded in the background of its DOM, it simply uses the image data of that element instead of re-downloading.

### Logout

Features include:
  * Single click button will log you out of all connected sessions simultaneously.
  * If you close the browser, you will be automatically logged out.
  * If your browser refreshes within a 1 second timeout, you will remain in the session.
  * If you are logged into one tab, and open a new one, you will automatically log in.

### Under the hood

Clicking the logout button sends a message to Node through SocketIO, which deletes that user from Redis, tells all sessions under the particular sessionID to log out themselves as well, and disconnects the socket. Basically telling every user to logout themselves will essentially force that particular socket to callback to the server, upon which it will be immediately verified as being an invalid user and thus they will be immediately redirected to the front page.

Telling every socket under that sessionID to logout is not necessary to complete the logout procedure as they will be forcefully logged out when the first request is made, however it forces them to realize they have been logged out and immediately redirect all tabs back to the main login page, resulting in a better experience for the user.

# Setup Development

If you want to explore, develop and improve the current **html5 prototype**, please follow the instructions on [setting up HTML5 development environment](/html/html5-dev.html)

For more details on the curent HTML5 architecture, see [HTML5Architecture](https://code.google.com/p/bigbluebutton/wiki/HTML5Architecture).
