---
layout: default

title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

Welcome to BigBlueButton, an open source web conferencing system for online learning.  

  * **open source** - You have full access to BigBlueButton's [source code](https://github.com/bigbluebutton/bigbluebutton) under an [open source license](https://bigbluebutton.org/open-source-license/).  You can [setup](/2.2/install.html) your own BigBlueButton server (or 10 servers if you want), [customize it's features](/2.2/dev.html), and integrate BigBlueButton (or you customized version of it) into you applications using [BigBlueButton's API](/dev/api.html).

  * **web conferencing system** - BigBlueButton gives you all the core capabilities you would expect from a commercial web conferencing system, but under an open source license.  These capabilities include real-time sharing of audio, video, presentation, and screen.  BigBlueButton provides an easy-to-use front-end called [Greenlight](https://github.com/bigbluebutton/greenlight).  BigBlueButtoncan record your sessions for later playback.

  * **online learning** - BigBlueButton extends many of its core web conferencing capabilities with additional focus on enaging your users.  For example, BigBlueButton's multi-user whiteboard allows multiple users to draw on the whiteboard at the same time.

You can try out the latest version of BigBlueButton by visiting our [demo server](https://demo.bigbluebutton.org) server and setup a free account.

To learn more about BigBlueButton, the following sections give you an overview of the project and details of how you and your users can start using it.

## Using BigBlueButton on desktop, laptop, or Chromebook

BigBlueButton is a web based application.   To join a live session, you click a link in your browser (such as a link to join a room in Greenlight).   The browser will download the BigBlueButton client (written in HTML and Javascript) and run it.  That's it.  There is no app to install, no binary to first run.

BigBlueButton uses the browser's built-in libraries, called web real-time communication (WebRTC), to send and receive audio, video, and screen.  For desktop and laptop users, we recommend Chrome or Firefox -- both have excellent support for WebRTC.  For Chromebooks, we recommend Google Chrome.  

Recently, Microsoft [announced that Microsoft Edge](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/) is switching to use the Chromium engine (the open source engine that powers Google Chrome).  This means in 2020 about a billion Windows 10 computers will be able to join a BigBlueButton session with a single click using Window's built-in browser.  Cool.

Here is a screen shot of the BigBlueButton client running in Chrome.

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

From left to right, you can see the list of users in the session, the chat area, the presentation area (where the current presenter can update), and one shared web cam (you can share as many webcams as bandwidth allows), and the whiteboard tools.

## Using BigBlueButton on mobile devices

BigBlueButton runs with the mobile browser on your phone.  There is no mobile app to download and install on your phone or tablet.

BigBlueButton runs on iOS version 12.2+ and Android version 6.0+.  To join a session, click a link within the browser and, like the desktop, the browser will download and run the BigBlueButton HTMl5 client.

Here's a screen shot of BigBlueButton running on an iOS phone.

<p align="center">
  <img src="/images/22-ios.png"/>
</p><br>

This is the exact same client as the desktop.


## Designed for online learning

Imagine you are instructor teaching an online class.  You want to engage students within the use cases of teaching and learning.  The are four main core cases:

1. tutoring/virtual office hours
1. flipped classroom
1. student collaboration
1. full online classes

BigBlueButton helps you engage students in each of these use cases with features that include

* chat (public and private)
* multi-user whiteboard
* shared notes
* emojis
* polling
* break out rooms

(Of course, all these features are still useful in a business meeting, but they are particularly useful in an online class).

To support users with accessibility needs, BigBlueButton is WCAG 2.0 AA certified (with some exceptions).  For more details, see see our official [Accessibility Statement and VPAT](https://bigbluebutton.org/accessibility/).  

Want to try out BigBlueButton?  Visit [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org)) and setup an account.  BigBlueButton is also built into the free version of [Moodle Cloud](https://moodlecloud.com/).

Want to learn more about BigBlueButton?  This site contains the project's documentation.  Whether you are an administrator that wants to setup your own BigBlueButton server, or you are a developer want to setup a BigBlueButton server, customize it, and integrate your existing applications, this site has all the information you need to get started. 

If you are an end-user (instructor or teacher) and interested in how to use BigBlueButton, visit [https://bigbluebutton.org/html5](https://bigbluebutton.org/html5) for tutorial videos.


## A brief overview of BigBlueButton

In BigBlueButton there are only two types of users: a viewer or a moderator.  

  * A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as raise hand), and participate in a break out room.  All normal user capabilities.

  * A _moderator_ (typically the instructor) has all the capabilities of a viewer plus the ability to mute/unmute other viewers, lock down viewers (i.e. restrict them from doing private chat), and assign anyone (including themselves) the role of _presenter_.  

The presenter controls the presentation area.  This means they can 

* upload slides, 
* annotate the current slide with the whiteboard controls, 
* enable/disable multi-user whiteboard, 
* start a poll, and 
* share their screen.

We provide two overview videos describing the above capabilities:

* [Viewer overview](https://www.youtube.com/watch?v=uYYnryIM0Uw)
* [Moderator/Presenter overview](https://www.youtube.com/watch?v=Q2tG2SS4gXA)

## Getting started quickly 

If you are new to BigBlueButton and want to learn more about its capabilities:  

1. Watch the [overview videos](https://bigbluebutton.org/html5) to better understand the capabilities of viewer, moderator, and presenter.
1. Setup a free account to use BigBlueButton on our [demo server](https://demo.bigbluebutton.org/). 
1. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/).
1. Follow us social media: [Twitter](https://twitter.com/bigbluebutton), [Facebook](https://www.facebook.com/bigbluebutton), and [YouTube](https://www.youtube.com/user/bigbluebuttonshare).

What to setup your own BigBlueButton server?  We provide an install script called [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) that for most cases will get you going with a server with SSL certificate in about 15 minutes.  Foer other cases, we provide step-by-step install instructions for [2.2](/2.2/install.html).

Want a front-end to your server?  As described above, check out [Greenlight](/install/greenlight-v2.html) (which `bbb-install.sh` can install for you as well).  We also provide a number of [integrations](https://bigbluebutton.org/integrations/) with popular open source platforms (such as Moodle or WordPress).

If you are a developer, after setting up your own BigBlueButton server, we recommend

1. Checkout the [BigBlueButton API](/dev/api.html)
1. [Setup a development environment](/dev/setup.html) a development environment to modify and extend BigBlueButton itself.

The BigBlueButton project is managed by a core group of [core committers](/support/faq.html#bigbluebutton-committer) who care about good design and a streamlined user experience.  You can join the community by subscribing to one of our [mailing lists](https://bigbluebutton.org/support/community/) and participate in the discussion.  Ask a question.  Share your experience with BigBlueButton.  Or even help us build a feature.

## Latest Release

The latest version of BigBlueButton is BigBlueButton 2.2 which features a pure HTML5 client (no plugin required).  See [install BigBlueButton 2.2](/2.2/install.html).

Overview for Viewers (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=uYYnryIM0Uw" target="_blank"><img src="https://img.youtube.com/vi/uYYnryIM0Uw/0.jpg" alt="Overview of BigBlueButton 2.2 for viewers" width="480" height="360" border="10" /></a>
</p>

Overview for Moderators/Presenters (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=Q2tG2SS4gXA" target="_blank"><img src="https://img.youtube.com/vi/Q2tG2SS4gXA/0.jpg" alt="Overview of BigBlueButton 2.2 for moderators/presenters" width="480" height="360" border="10" /></a>
</p>

### Helping out the BigBlueButton project

If you find our work helps you reach users online, spread the word to others by 

  * sending us a tweet at [@bigbluebutton](https://twitter.com/bigbluebutton),
  * uploading a video on YouTube demonstrating how you are using BigBlueButton, or, if your a blogger,
  * writing a blog post on your blog about BigBlueButton.

We are passionate about making the worlds best open source web conferencing system for online learning.  We enjoy reading about how others are benefiting from and building upon BigBlueButton.

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).
