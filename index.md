---
layout: default

title: "BigBlueButton"
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

BigBlueButton is an open source web conferencing system for online learning.   

  * **Open source** - You have full access to the [source code](https://github.com/bigbluebutton/bigbluebutton) under an [open source license](https://bigbluebutton.org/open-source-license/) to install, configure, and customize BigBlueButton.  You install BigBlueButton in under 15 minutes with [bbb-install.sh](https://github.com/bigbluebutton/bbb-install).  BigBlueButton comes with [Greenlight](https://github.com/bigbluebutton/greenlight), an easy-to-use front-end that lets you create rooms, invite users, and manage recordings.  You can try out BigBlueButton and Greenlight at [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org).

  * **Web conferencing system** - BigBlueButton gives you all the core capabilities you would expect from a commercial web conferencing system (but under an open source license), including real-time sharing of audio, video, presentation, and screen.  BigBlueButton can record your sessions for later playback.

  * **Online learning** - BigBlueButton offers many features -- such as multi-user whiteboard and shared notes -- that enable you to engage remote users to promote learning.


## Using BigBlueButton within your web browser

There is no application to install to use BigBlueButton.

BigBlueButton runs within your web browser using its built-in libraries, called web real-time communication (WebRTC), to send and receive high quality audio/video.  To run BigBlueButton, your simply click a browser link (such as an invitation link to a room in Greenlight) and the BigBlueButton HTML5 client loads and runs within your browser.

For desktop and laptop, We recommend both Chrome and Firefox as they have the best support for WebRTC.

Here is a screen shot of the BigBlueButton client running within Chrome.  From left to right, the screen shot shows the User list (the list of users in the session), the chat area, the presentation area, and one shared web cam (you can have many shared web cams in a session).

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

BigBlueButton runs within your mobile browsers as well (we recommend iOS 12.2+ and Android 6.0+).  There is no mobile application to install -- just click a link within your mobile browser on Android (Chrome) and iOS (Safari mobile) and BigBlueButton will load and run.  (Both these mobile browsers support WebRTC).

What about Microsoft Edge?  Recently, Microsoft [announced](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/) they are switching Chromium engine.  This means that before the end of the year almost a billion Windows 10 computers will be able to run BigBlueButton with a single click.  Very cool.


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

A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as raise hand), and participate in a break out room.  All normal user capabilities.

A _moderator_ (typically the instructor) has all the capabilities of a viewer plus the ability to mute/unmute other viewers, lock down viewers (i.e. restrict them from doing private chat), and assign anyone (including themselves) the role of _presenter_.  

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

If you want to setup your own BigBlueButton server, follow either the step-by-step install instructions for [2.2](/2.2/install.html) or, use the [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) installation script to setup a server in about 15 minutes.

You'll need to a front-end for users to access BigBlueButton.  If you are setting up a server for the first time, check out [Greenlight](/install/greenlight-v2.html) (which `bbb-install.sh` can install for you as well).  We also provide a number of [integrations](https://bigbluebutton.org/integrations/) with popular open source platforms (such as Moodle or WordPress).

If you are a developer, after setting up your own BigBlueButton server, we recommend

1. Checkout the [BigBlueButton API](/dev/api.html)
1. [Setup a development environment](/dev/setup.html) a development environment to modify and extend BigBlueButton itself.

The BigBlueButton project is managed by a core group of [core committers](/support/faq.html#bigbluebutton-committer) who care about good design and a streamlined user experience.  You can join the community by subscribing to one of our [mailing lists](https://bigbluebutton.org/support/community/) and participate in the discussion.  Ask a question.  Share your experience with BigBlueButton.  Or even help us build a feature.

## Latest Release

The latest version of BigBlueButton is BigBlueButton 2.2-beta which features a pure HTML5 client.  See [overview](/2.2/overview.html) and [install](/2.2/install.html).

Overview for Viewers (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=uYYnryIM0Uw" target="_blank"><img src="https://img.youtube.com/vi/uYYnryIM0Uw/0.jpg" alt="Overview of BigBlueButton 2.2 for viewers" width="480" height="360" border="10" /></a>
</p>

Overview for Moderators/Presenters (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=Q2tG2SS4gXA" target="_blank"><img src="https://img.youtube.com/vi/Q2tG2SS4gXA/0.jpg" alt="Overview of BigBlueButton 2.2 for moderators/presenters" width="480" height="360" border="10" /></a>
</p>

The previous stable release is BigBlueButton 2.0. See the [overview](/overview/overview.html), [install](/install/install.html), and [architecture](/overview/architecture.html) documentation.

### Spreading the word

If you use BigBlueButton and find value in our work, spread the word to others by 

  * tweeting us at [@bigbluebutton](https://twitter.com/bigbluebutton),
  * posting a blog about us,
  * uploading a video on YouTube demonstrating how you are using BigBlueButton.

Or share your experiences on your favorite social media site.  We are passionate about making the worlds best open source web conferencing system for online learning and enjoy reading about how others are benefiting from and building upon BigBlueButton.

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).
