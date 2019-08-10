---
layout: default

title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

BigBlueButton is an open source web conferencing system for online learning.   

BigBlueButton is **open source** project, which means you have full access to the [source code](http://github.com/bigbluebutton/bigbluebutton) under an [open source license](https://bigbluebutton.org/open-source-license/).  You can setup your own BigBlueButton server in about [15 minutes](https://github.com/bigbluebutton/bbb-install) (or setup 10 BigBlueButton servers if you want).  BigBlueButton also comes with a [Greenlight](https://github.com/bigbluebutton/greenlight), a simple front-end that gives you the ability to create rooms and manage recordings. 

Bigbluebutton is a **web conferencing system**, which means it implements all the core capabilities you would expect from a commercial web conferencing system (but available to you under an open source license).  These capabilities include real-time sharing of audio, video, presentation, and your screen.

BigBlueButton is designed for **online learning**, which means that while it offers you all expected features of a web conferencing system, it has additional features to give teachers multiple ways to engage students in online learning.  

a tutoring session with the multi-user whiteboard or getting students to apply what they just learned in breakout rooms.

## Using BigBlueButton

BigBlueButton sends and receieves audio/video using the built-in web real-time communication (WebRTC) libraries in modern web browsers.  Thanks to these libraries, there is no plugin to download, not binary to install.  We recommend Chrome and FireFox browsers as they have the best support for WebRTC.

To join a BigBlueButton session, you click a link in your browser, such as clicking the 'Join' link in Greenlight.  The BigBlueButton components download, run, and prompt you to share your microphone and join the session.


Here is a screenshot of the BigBlueButton client running inside the Chrome browser.  From left to right, the screenshot shows the User list (the list of users in the session), the chat area, the presentation area, and one shared webcam (you can have many shared webcams in a session).

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

BigBlueButton runs within your mobile browsers as well (we recomend iOS 12.2 and Android 6.0).  There is no mobile application to install -- just click a link and it's ready top run.

Recently, Microsoft [announced](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/) they are switching Chromium engine.  This means almost a billion Windows 10 computers will be able to run BigBlueButton with a single click.  Very cool.


## Designed for online learning

Imagine you are instructor teaching an online class.  You have all the core capabilities of a web conferencing system, but you want to _engage_ your students for online learning.  Your use cases for online learning are likely one of the following

1. tutoring/virtual office hours
1. flipped classroom
1. student collaboration
1. full online classes

To help you reach students in any of the above use cases, BigBlueButton offers many features to engage your students.  These include:

* chat (public and private)
* multi-user whiteboard
* shared notes
* emojis
* polling
* breakout rooms

(Of course, all these features are still useful in a business meeting, but they are particularly useful in an online class).

BigBlueButton can record your session for later playback.  To support users with accessibility needs, BigBlueButton is compatible with JAWS screen reader (see our [accessibility statement](https://bigbluebutton.org/accessibility/)).  

Want to try out BigBlueButton?  Anyone can setup an account on [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org)).  

This site contains the project's documentation.  It is written for administrators and developers who want to setup a BigBlueButton server, customize it, and integrate it with existing applications using our API. If you are an end-user (instructor or teacher) and interested in how to use BigBlueButton, visit [bigbluebutton.org](http://bigbluebutton.org). 

## A brief overview of BigBlueButton

In BigBlueButton there are only two types of users: a viewer or a moderator.  

A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as raise hand), and participate in a breakout room.  All normal user capabilities.

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

You'll need to a front-end for users to access BigBlueButton.  If you are setting up a server for the first time, check out [Greenlight](/install/greenlight-v2.html) (which `bbb-install.sh` can install for you as well).  We also provide a number of [integrations](http://bigbluebutton.org/open-source-integrations/) with popular open source platforms (such as Moodle or WordPress).

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
