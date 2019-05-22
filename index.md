--- 
layout: default
title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

**BigBlueButton** is an open source web conferencing system for online learning.  

BigBlueButton provides all the core capabilities you expect in a web conferencing system, including real-time sharing of

  * audio
  * video
  * presentation
  * screen

BigBlueButton is a pure HTML5 application.  As such, there is no downloaded, plugin, or extension to install.  Instead, it uses the browser's built-in support for web real-time communications (WebRTC) for sharing of media.  For desktop computers, we recommend Chrome or FireFox as they both provide excellent ssupport for webRTC.  Microsoft recently [announced](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/#oddLFwrg6sWEZyXO.97) they are moving Edge to use the Chromium engine as well (yay!).

BigBlueButton implements a responsive interface that run on desktop and mobile devices.  The follwoing screen shot was taken from our demo server at [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org)).  (Anyone can use [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org) to try out BigBlueButton).

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

The goal of the BigBlueButton project is to enable instructors to engage remote student in a high-quality online learning experience.   We designed BigBlueButton for the following use cases:

  1. tutoring/virtual office hours
  1. flipped classroom
  1. student collaboration
  1. full online classes

For online learning, BigBlueButton gives you many ways to engage students, including 

  * chat (public and private)
  * multi-user whiteboard
  * shared notes
  * emojis
  * polling
  * breakout rooms

BigBlueButton can record your session for later playback.  To support students with accessibility needs, BigBlueButton is compatible with JAWS screen reader (see our [accessibility statement](https://bigbluebutton.org/accessibility/)).  

BigBlueButton is [open source](http://github.com/bigbluebutton/bigbluebutton) under the LGPL license.  If you are a developer you are free (and welcome) to build upon our project for your needs.  If you are familiar with Linux, you are (more than) welcome to setup your own BigBlueButton server (see linmks below).

This site contains the project's documentation.  It is written for administrators and developers who want to setup a BigBlueButton server, customize it, and integrate it with existing applications using our API. If you are an end-user (instructor or teacher) and interested in how to use BigBlueButton, visit [bigbluebutton.org](http://bigbluebutton.org). 

## Two types of users

In a BigBlueButton session there are only two types of users: a _viewer_ or _moderator_.  

A viewer (typically the student) can chat, send/receive audio and video, respond to polls, and display an emoji (such as raise hand).  

A moderator (typically the instructor) has all the capabilities of a viewer plus the ability to mute/unmute other viewers, lock down viewers (i.e. restrict them from doing private chat), and assign anyone (including themselves) the role of _presenter_.  

The presenter controls the presentation area.  This means they can upload slides, annotate the current slide with the whiteboard controls, enable/disable multi-user whiteboard, start a poll, and share their screen for all to see.

## Getting started auickly with BigBlueButton

If you are new to BigBlueButton and want to learn more about its capabilities:  

  1. Watch the [overview videos](http://bigbluebutton.org/videos) to better understand the capabilities of viewer, moderator, and presenter.
  1. Try out BigBlueButton using our [Demo Server](http://demo.bigbluebutton.org/). 
  1. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/).
  1. Follow the project on social media: [Twitter](https://twitter.com/bigbluebutton), [FaceBook](https://www.facebook.com/bigbluebutton), or [YouTube](https://www.youtube.com/user/bigbluebuttonshare).
      
If you want to setup your own BigBlueButton server:

  1. To install BigBlueButton, follow either the step-by-step install instructions for [2.0](/install/install.html) or [2.2-beta](/2.2/install.html) or, to setup a server in about 15 minutes, use the [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) installation script.
  1. To setup a front-end for users, check out [Greenlight](/install/greenlight-v2.html) (which `bbb-install.sh` can install for you as well), or use one of the existing [integrations](http://bigbluebutton.org/open-source-integrations/) (such as Moodle or WordPress).
  1. Take a quick read through the [FAQ](/support/faq.html).

If you are a developer, after setting up your own BigBlueButton server, we recommend
  1. Checkout the [BigBlueButton API](/dev/api.html)
  1. [Setup a development environment](/dev/setup.html) a development environment to modify and extend BigBlueButton itself.

The BigBlueButton project is managed by a core group of [committers](/support/faq.html#bigbluebutton-committer) who care about building an easy to use product with strong community and commercial support.  If you want to join the community, then join one of our [mailing lists](https://bigbluebutton.org/support/community/) and participate in the discussion.  Ask a question.  Share your experience with BigBlueButton.  Or even help us build a feature.

## Latest Release

The latest version of BigBlueButton is BigBlueButton 2.2-beta which features a pure HTML5 client.  See [overview](/2.2/overview.html) and [install](/2.2/install.html).

Overview for Viewers (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=uYYnryIM0Uw" target="_blank"><img src="http://img.youtube.com/vi/uYYnryIM0Uw/0.jpg" alt="Overview of BigBlueButton 2.2 for viewers" width="480" height="360" border="10" /></a>
</p>

Overview for Moderators/Presenters (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=Q2tG2SS4gXA" target="_blank"><img src="http://img.youtube.com/vi/Q2tG2SS4gXA/0.jpg" alt="Overview of BigBlueButton 2.2 for moderators/presenters" width="480" height="360" border="10" /></a>
</p>


The latest release is BigBlueButton 2.0. See the [overview](/overview/overview.html), [install](/install/install.html), and [architecture](/overview/architecture.html) documentation.

### Spreading the word

If you use BigBlueButton and find it worthwhile, let other know.  Blog about it, tweet about it, upload a video to YouTube, etc.  Also, we welcome developers who want to [help improve BigBlueButton](/faq.html#contributing-to-bigbluebutton).  You'll find the more you give, the more you get back.

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).

