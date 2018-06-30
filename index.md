--- 
layout: default
title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

**BigBlueButton** is an open source web conferencing system for online learning.  The goal of BigBlueButton is to enable every student with a web browser to a high-quality online learning experience.  

<p align="center">
  <img src="/images/20-screenshot.png"/>
</p><br>

BigBlueButton provides all the core capabilities you expect in a web conferencing system: sharing of audio, video, screen, presentation, and chat -- the product emphasizes engagement with users.  We've streamlined the user interface to make it easy presenters to upload content and engage users through multi-user whiteboard, shared notes, emojis, polling, and breakout rooms.  We care about accessiblity too.  The client is compatible with JAWS and NVDA screen reader and supports live closed captioning.

BigBlueButton is an [open source](http://github.com/bigbluebutton/bigbluebutton) project licensed under the LGPL license.  If you are a developer you are free (and welcome) to build upong our project for your needs.

This documentation site is for administrators and developers who want to setup a BigBlueButton server, customize it, and integrate it with existing applications using our API. If you are an end-user (instructor or teacher) and interested in how to use BigBlueButton, visit [bigbluebutton.org](http://bigbluebutton.org). 

## Overview

In a BigBlueButton session there are only two types of users: a _viewer_ or _moderator_.  

A viewer (typically the student) can chat, send/receive audio and video, respond to polls, and display an emoji (such as raise hand).  A moderator (typically the instructor) has all the capabilities of a viewer, plus the ability to mute/unmute other viewers, lock down viewers, and assign anyone (including themselves) the rle of presenter.  

The current presenter can upload slides, use the whiteboard controls to annotate the slides, start a poll, and share their screen for all to see.

## Getting Started with BigBlueButton

If you are new to BigBlueButton we recommend (in order): 

  1. Watch the [overview videos](http://bigbluebutton.org/videos) to better understand the capabilities of viewer, moderator, and presenter.
  1. Try out BigBlueButton using our [Demo Server](http://demo.bigbluebutton.org/). 
  1. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/).
  1. Follow the project on social media: [Twitter](https://twitter.com/bigbluebutton), [FaceBook](https://www.facebook.com/bigbluebutton), [YouTube](https://www.youtube.com/user/bigbluebuttonshare), or [Google+](https://plus.google.com/+bigbluebutton).  
      
Next, if you intend to setuip your own BigBlueButton server, we recommend:

  1. Visit [Install](/install/install.html) to BigBlueButton your own server (Ubuntu 16.04 64-bit).  You'll find step-by-step instructions and a [one line installer](https://github.com/bigbluebutton/bbb-install).
  1. Setup the [GreenLight](/install/green-light.html) front end, or use an existing [integration](http://bigbluebutton.org/open-source-integrations/) (such as Moodle or WordPress).
  1. Take a quick read through the [FAQ](/support/faq.html).

If you are a developer, after setting up your own BigBlueButton server, we recommend
  1. [Setup](/dev/setup.html) a development environment to modify and extend BigBlueButton for your needs.
  1. Integrate BigBlueButton with your application using the [BigBlueButton API](/dev/api.html).

The BigBlueButton project is managed by a core group of [committers](/support/faq.html#bigbluebutton-committer) who care about building the community.  If you are interested to engage us, we encourage you to join the [community](https://bigbluebutton.org/support/community/) and participate in the discussion around the project.  We also hold bi-weekly BigBlueButton Community Calls (using BigBlueButton of course).

## Latest Release: 2.0-RC1

The latest release is BigBlueButton 2.0-RC1. See the [overview](/overview/overview.html), [install](/install/install.html), and [architecture](/overview/architecture.html) documentation.


<p align="center">
  <a href="http://www.youtube.com/watch?feature=player_embedded&v=NQPrdc-W-6A" target="_blank"><img src="http://img.youtube.com/vi/NQPrdc-W-6A/0.jpg" alt="Overview of BigBlueButton 2.0" width="480" height="360" border="10" /></a>
</p>

If you use BigBlueButton and find it worthwhile, an easy way to help support the project is to spread the word about your experiences (blog, tweet, upload a video to YouTube, etc.) or, if you want to really contribute, help improve us [improve](/faq.html#contributing-to-bigbluebutton) the product.  You'll find the more you give, the more you get back.

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).

