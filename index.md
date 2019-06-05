--- 
layout: default
title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

**BigBlueButton** is an open source web conferencing system for online learning.  

As an _open source_ project you have full access to BigBlueButton's [source code](http://github.com/bigbluebutton/bigbluebutton) under an [open source license](ihttps://bigbluebutton.org/open-source-license/).  This means if you are a developer, you can build, customize, and extend BigBlueButton for your own project.  If you are a server administrator, you can setup you own BigBlueButton server in about 15 minutes (see [bbb-install.sh](https://github.com/bigbluebutton/bbb-install).

As a _web conferencing system_, BigBlueButton provides all the core capabilities you expect for team and group collaboration, including real-time sharing of

  * audio
  * video
  * presentation
  * screen

BigBlueButton runs within your browser (we recommend Firefox and Chrome) on your desktop, laptop, and Chromebook.  BigBlueButton is written in pure HTML5: it does not require you to install any plugings, extensions, or executables.  None.

The BigBlueButton HTML5 client also runs within your mobile browser on iOS 12.2+ and Android 6.0+.  There is no app for your users to install.  Deployment is inviting users to click on a link. 

Here is a screen shot of the BigBlueButton client running within the Chrome browser.  From left to right, you can see User list (the list of users in the session), the chat area, the presentation area, and a shared webcam (you can have many shared webcams in a session).

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

How does BigBlueButton enable real-time sharing of media without plugins or downloads?  Chrome, FireFox, and Safari Mobile (iOS) all support the web real-time communications (WebRTC) libraries.  These built-in libraries give The browser the aility to send/receive audio, video, and screen.  What about Edge?  The good news is Microsoft recently [announced](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/) they are switching Chromium engine (yay!).

BigBlueButton is designed for _online learning_: it has specific features to enable a teacher to engage students in one of the following use cases:

  1. tutoring/virtual office hours
  1. flipped classroom
  1. student collaboration
  1. full online classes

These features include:

  * chat (public and private)
  * multi-user whiteboard
  * shared notes
  * emojis
  * polling
  * breakout rooms

(Of course, all these features are useful in a business meeting, but they are particularly useful in an online class).

BigBlueButton can record your session for later playback.  To support users with accessibility needs, BigBlueButton is compatible with JAWS screen reader (see our [accessibility statement](https://bigbluebutton.org/accessibility/)).  

Want to try out BigBlueButton?  Anyone can setup an account on [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org)).  


This site contains the project's documentation.  It is written for administrators and developers who want to setup a BigBlueButton server, customize it, and integrate it with existing applications using our API. If you are an end-user (instructor or teacher) and interested in how to use BigBlueButton, visit [bigbluebutton.org](http://bigbluebutton.org). 

## A brief overview of BigBlueButton

In BigBlueButton there are only two types of users: a viewer or a moderator.  

A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as raise hand), and participate in a breakout room.  All normal user capabilties.

A _moderator_ (typically the instructor) has all the capabilities of a viewer plus the ability to mute/unmute other viewers, lock down viewers (i.e. restrict them from doing private chat), and assign anyone (including themselves) the role of _presenter_.  

The presenter controls the presentation area.  This means they can 
  * upload slides, 
  * annotate the current slide with the whiteboard controls, 
  * enable/disable multi-user whiteboard, 
  * start a poll, and 
  * share their screen.

We provide two overview videos describing the above capabilities:
  * Viewer overview
  * Moderator/Presenter overview


## Getting started quickly with BigBlueButton

If you are new to BigBlueButton and want to learn more about its capabilities:  

  1. Watch the [overview videos](http://bigbluebutton.org/videos) to better understand the capabilities of viewer, moderator, and presenter.
  1. Setup a free account to use BigBlueButton on our [demo server](http://demo.bigbluebutton.org/). 
  1. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/).
  1. Follow us social media: [Twitter](https://twitter.com/bigbluebutton), [Facebook](https://www.facebook.com/bigbluebutton), and [YouTube](https://www.youtube.com/user/bigbluebuttonshare).
      
If you want to setup your own BigBlueButton server, follow either the step-by-step install instructions for [2.0](/install/install.html) or [2.2-beta](/2.2/install.html) or, use the [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) installation script to setup a server in about 15 minutes.

You'll need to a front-end for users to access BigBlueButton.  If your setting up a server for the first time, check out [Greenlight](/install/greenlight-v2.html) (which `bbb-install.sh` can install for you as well).  We also provide a number of [integrations](http://bigbluebutton.org/open-source-integrations/) with popular open source platforms (such as Moodle or WordPress).

If you are a developer, after setting up your own BigBlueButton server, we recommend
  1. Checkout the [BigBlueButton API](/dev/api.html)
  1. [Setup a development environment](/dev/setup.html) a development environment to modify and extend BigBlueButton itself.

The BigBlueButton project is managed by a core group of [core committers](/support/faq.html#bigbluebutton-committer) who care about good design and a streamlined user experience.  You can join the community by subscribing to one of our [mailing lists](https://bigbluebutton.org/support/community/) and participate in the discussion.  Ask a question.  Share your experience with BigBlueButton.  Or even help us build a feature.

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


The previous stable release is BigBlueButton 2.0. See the [overview](/overview/overview.html), [install](/install/install.html), and [architecture](/overview/architecture.html) documentation.

### Spreading the word

If you use BigBlueButton and find it worthwhile, let others know.  Blog about it, tweet about it, upload a video to YouTube, etc.  Also, we welcome developers who want to [help improve BigBlueButton](/faq.html#contributing-to-bigbluebutton).  You'll find the more you give, the more you get back.

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).

