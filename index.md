---
layout: default

title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

BigBlueButton is an open source web conferencing system for online learning.

  * **Open source** - You have full access to BigBlueButton's [source code](https://github.com/bigbluebutton/bigbluebutton) under an [open source license](https://bigbluebutton.org/open-source-license/).  With the source code, and the documentation herin, you can easily [setup](/2.2/install.html) your own BigBlueButton server (or 10 servers if you want), [customize](2.2/customize.html), [develop](/2.2/dev.html) and [integrate it](/dev/api.html) it into your products and services.

  * **Web conferencing system** - BigBlueButton gives you all the core features you would expect from a commercial web conferencing system (but under and open source license).  These core features include real-time sharing of audio, video, presentation, and screen -- along with collaboration tools such as whiteboard, shared notes, polling, and breakout rooms.   BigBlueButton can record your sessions for later playback.  

  * **Online learning** - BigBlueButton extends these core features to help instructors engage remote students.  For example, a tutor can use BigBlueButton's multi-user whiteboard to work to help a student solve a difficult math problem.  BigBlueButton integrates with all the major learning management systems (LMS), including Moodle, Canvas, Sakai, Jenzabar, Blackboard, and D2L.

Want to try out BigBlueButton?  Visit our demo server at [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org) and setup an account.   The demo server uses Greenlight (also open source), an easy-to-use front-end for creating rooms, starting meetings, inviting others, and managing recordings.

Want to jump right in and setup your own BigBlueButton server?  Check out the [15 minute bbb-install.sh](https://github.com/bigbluebutton/bbb-install) script which can install the latest version of BigBlueButton, along with a secure sockets (SSL) certificate (thanks to Let's Encrypt), and Greenlight.  Cool.

Want to learn more about BigBlueButton?  This documentation site below gives all you the details on how to install, configure, and customize BigBlueButton to your needs.


## BigBlueButton overview

BigBlueButton is an HTML5-based web application.  Unlike many commercial web conferencing systems that require you to install software, BigBlueButton run within your web browser.  There is no binary to download, no plugin to install.

BigBlueButton runs within your browser.  It uses the browser's built-in libraries -- called web real-time communication (WebRTC) -- to send and receive audio, video, and screen in real-time.  We recommend Chrome or Firefox for desktop users as both of these browsers have excellent support for WebRTC.  For Chromebooks users, the built-in Chrome browser is good.

For Windows users, Microsoft recently [announced that Microsoft Edge](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/) will be switching to use the Chromium engine (the open source engine that powers Google Chrome) in early 2020.  This means in 2020 about a billion Windows 10 computers will be able to run BigBlueButton with a single click using Window's default web browser.  Cool.

Here is a screen shot of the BigBlueButton client running in Google Chrome.

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

From left to right, you can see the list of users in the session, the chat area, the presentation area (where the current presenter can update),  one shared web cam (you can share as many webcams as bandwidth allows), and the whiteboard tools.

## Mobile support

BigBlueButton has a "mobile first" design.  The produce is designed to run on a mobile device. 

Like the desktop, is no mobile app to download or install on your phone and table.  BigBlueButton runs within your mobile browser.  

BigBlueButton runs on iOS version 12.2+ and Android version 6.0+.  To join a session, click a link within the browser -- such as within Greenlight or your LMS -- and BigBlueButton will run with Safari Mobile (iOS) and Google Chrome (Android).

Here's a screen shot of BigBlueButton running on an iOS phone in landscape mode.

<p align="center">
  <img src="/images/22-ios.png"/>
</p><br>

It's worth emphasizing there isn't mobile client and desktop client -- the same HTML5 client runs on all devices.  This gives us a single code base to enhance and innovate with adoption across desktop, laptop, chromebook, iOS, and Android.  Nice!

## Designed for online learning

In the introduction, we said that BigBlueButton extends many of its core features of a web conferencing system to focus on enabling the instructor to engage students.  There are four main use cases for engagement:

1. tutoring/virtual office hours
1. flipped classroom
1. group collaboration
1. full online classes

BigBlueButton helps you engage students in each of these use cases with features that include

* multi-user whiteboard
* break out rooms
* chat (public and private)
* polling
* shared notes
* emojis

Of course, all these features are still useful in a business meeting, but they are really useful when teaching students online.

To support users with accessibility needs, BigBlueButton is [WCAG 2.0 AA certified (with some exceptions)](https://bigbluebutton.org/accessibility/).  


## A brief overview of BigBlueButton

There are two types of users in BigBlueButton: viewer and moderator.  

  * A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as their raise hand), and participate in a break out room. 

  * A _moderator_ (typically the instructor) has all the capabilities of a viewer plus the ability to mute/unmute other viewers, lock down viewers (such as strict them from using private chat), and assign anyone (including themselves) the role of _presenter_.  

The user who is the current presenter can do the following: 

* upload slides
* use the whiteboard to annotate any side
* enable/disable multi-user whiteboard\
* start a poll
* share a YouTube, vimeo, or [Canvas Studio](https://community.canvaslms.com/community/answers/guides/studio-guide) video
* share their screen

To show users how to use the above features, we created two overview videos, one for viewer and the other for moderator:

* [Viewer overview](https://www.youtube.com/watch?v=uYYnryIM0Uw)
* [Moderator/Presenter overview](https://www.youtube.com/watch?v=Q2tG2SS4gXA)

## Getting started quickly 

If you are an administrator, we recommend you

1. Watch the [overview videos](https://bigbluebutton.org/html5) to better understand the capabilities of viewer, moderator, and presenter.
1. Setup a free account to use BigBlueButton on our [demo server](https://demo.bigbluebutton.org/). 
1. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/).
1. Follow us social media: [Twitter](https://twitter.com/bigbluebutton), [Facebook](https://www.facebook.com/bigbluebutton), and [YouTube](https://www.youtube.com/user/bigbluebuttonshare).
1. Setup a your own BigBlueButton server in 15 minutes using [bbb-install.sh](https://github.com/bigbluebutton/bbb-install), or follow our [step-by-step install instructions](/2.2/install.html).
1. Need help?  Join the [bigbluebutton-setup](https://bigbluebutton.org/support/community/) mailing list.


If you are a developer, we recommend you

1. Follow the above guidelines for administrator
1. Explore the options to [customize BigBlueButton](/2.2/customize.html)
1. Checkout the [BigBlueButton API](/dev/api.html)
1. [Setup a development environment](/dev/setup.html) to modify and extend BigBlueButton itself.
1. Need help?  Join the [bigbluebutton-dev](https://bigbluebutton.org/support/community/) mailing list.

The BigBlueButton project is managed by a core group of [core committers](/support/faq.html#bigbluebutton-committer) who care about good design and a streamlined user experience.  

## Latest Release

The latest version of BigBlueButton is BigBlueButton 2.2 which features a pure HTML5 client built upon React.  See [install BigBlueButton](/2.2/install.html).

Overview for Viewers (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=uYYnryIM0Uw" target="_blank"><img src="https://img.youtube.com/vi/uYYnryIM0Uw/0.jpg" alt="Overview of BigBlueButton 2.2 for viewers" width="480" height="360" border="10" /></a>
</p>

Overview for Moderators/Presenters (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=Q2tG2SS4gXA" target="_blank"><img src="https://img.youtube.com/vi/Q2tG2SS4gXA/0.jpg" alt="Overview of BigBlueButton 2.2 for moderators/presenters" width="480" height="360" border="10" /></a>
</p>

### Contributing to our project

An easy way to contribute to our project is tell your peers about it.

  * sending out a tweet at [@bigbluebutton](https://twitter.com/bigbluebutton)
  * uploading a video on YouTube demonstrating how you are using BigBlueButton
  * writing a blog post on your blog about BigBlueButton

We are passionate about making the worlds best open source web conferencing system for online learning.  We enjoy reading about how others are benefiting from and building upon BigBlueButton.

BigBlueButton welcomes contributions from others on the project, see [contributing to Bigbluebutton](/support/faq.html#contributing-to-bigbluebutton).

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).
