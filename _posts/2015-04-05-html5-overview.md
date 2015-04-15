---
layout: page
title: "HTML5 Overview"
category: html
date: 2015-04-05 11:41:36
---


# Overview

This document provides information about the HTML5 client that is integrated into the BigBlueButton platform for providing an additional entry point for users to join a BigBlueButton session.

## Vision
With the adoption of HTML5, the web browser is becoming the platform for rich client interfaces.

Furthermore, with the recent progress in WebRTC, an HTML5-based application can access the user's webcam and microphone **without** the need for plugins.

The long-term vision for the BigBlueButton HTML5 client is to enable users on all platforms supporting an HTML5 browser -- including mobile and tablets to -- to fully access all of BigBlueButton’s features.

This means the HTML5 client will completely implement the current Flash-based functionality, including the ability to broadcast audio and video from within the browser using WebRTC.

The existing Flash client will not be replaced by the HTML5 client -- all current functionality of BigBlueButton will remain intact.  We are adding to the functionality by providing users with the ability to join a session (and increasingly participate) through an HTML5 interface (no flash).

## Phases for Development of HTML5 Client

We’ve mapped out the development of the HTML5 client in three phases:

  1. Viewing a live BigBlueButton session using an HTML5 browser (view presentation updates, streaming audio/video, two-way chat).
  1. Broadcast audio/video from an HTML5 browser using WebRTC
  1. Support for all presentation features of BigBlueButton in HTML5

The following describes our efforts to implement phase 1: viewing a live BigBlueButton session using an HTML5 browser.

## UI


## Overview of Architecture


## Implementation of the HTML5 client
The HTML5 client is implemented using [Meteor.js](http://meteor.com) in [CoffeeScript](http://coffeescript.org/)

All the code for the HTML5 client is inside the `bigbluebutton/bigbluebutton-html5/app` folder. It mainly consists of LESS, HTML and CoffeeScript files.

### CoffeeScript
CoffeeScript is a language that compiles into JavaScript. It offers several advantages over JavaScript, especially that the code is usually a lot smaller and easier to maintain. Code in CoffeeScript can be run by Meteor.js thanks to a CoffeeScript [package](https://atmospherejs.com/meteor/coffeescript).

### WhiteboardPaperModel and Raphaël

A significant amount of the code of the client is related to the whiteboard. We use a library called [Raphaël](http://raphaeljs.com/) to work with vector graphics.

### LESS and Media Queries

We use [LESS](http://lesscss.org/) precompiler to keep the stylesheets short and readable. LESS is a stylesheet language that is compiled into CSS. It allows us to use variables and mixins. Selectors can be nested, thus making it easier to read the code.

The responsive UI of HTML5 client is constructed using media queries. Each LESS expression is tied to some specific range of devices and window sizes. HTML5 client provides four different views depending on your device (desktop/mobile) and browser orientation (landscape/portrait).

## API

### Check
Check if the HTML5 client is running and ready to serve users:
```http://<your_ip>/html5client/check```
The result should be ```{"html5clientStatus":"running"}```


## Current stage
### Implemented:
  * two way pyblic and private chat
  * viewing presentation with slides, cursor, anotations
  * audio using WebRTC (listen and speak)

### Not yet implemented (see more information about these features in the existing Flash client):
  * video
  * lock settings
  * listen Only audio

### Planned features:
  * presenter mode
  * localization
  * shortcut keys


## Whiteboard

The whiteboard is an SVG element embedded in the page, composed of images, a small red cursor and any shapes you draw. Raphael.js is used to automate most of the SVG manipulation but lots of math is still required on the client side. Raphael’s objects are always listening for events and acting on them according to the current tool selected. So when you have the Line tool selected, and you click on the whiteboard and drag around, your line events are sent to the server, and drawn when you get them back (at the same time all other meeting clients get the events back). When you hover over the page, the cursor is updated, but of course at the same time everyone elses cursor is updated.


Advantages to SVG:

  * Panning and zooming are relatively easy using SVG because no objects need to be scaled, it is all handled automatically when you simply adjust the viewBox property of the SVG object.

  * SVG, much as its acronym suggests, are scalable. Thus any screen size, big or small, can be adjusted and aside from the the background image, all shapes will be drawn at a greater resolution automatically. Things will just look great at any size.

  * SVG is in the DOM, so being an HTML5 application, means we have VIP access through JavaScript to everything in the whiteboard. So say we want to move that text around, click and delete that line we drew a while ago, or click and drag to select many shapes at once, this would be not only possible (important!) but also relatively easy to do, all on the client side.


## Setup Development

If you want to explore, develop and improve the HTML5 client, please follow the instructions on [setting up HTML5 development environment](/html/html5-dev.html)
