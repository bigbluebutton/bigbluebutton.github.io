---
layout: default

title: 'BigBlueButton'
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

BigBlueButton is an open source web conferencing system for online learning. This means

- **Open source** - you have full access to BigBlueButton's [source code](https://github.com/bigbluebutton/bigbluebutton) under an [open source license](https://bigbluebutton.org/open-source-license/). With the source code, [installation steps](/2.3/install.html), and [community support](https://bigbluebutton.org/support/), you can easily deploy your own BigBlueButton server (or 10 servers if you want). For each server you can [customize it](admin/customize.html), [modify it](/2.3/dev.html) and [integrate it](/dev/api.html) into your products and services. Cool.

- **Web conferencing system** - you get the core features you would expect from a commercial web conferencing system (but under an open source license). These features include real-time sharing of audio, video, presentation, and screen -- along with collaboration tools such as whiteboard, shared notes, polling, and breakout rooms. BigBlueButton can record your sessions for later playback.

- **Online learning** - BigBlueButton extends these core features to enable a teacher to engage students for learning. For example, a tutor can use BigBlueButton's multi-user whiteboard to help a student with solving a difficult math problem. BigBlueButton has built-in integrations with all the major learning management systems (LMS), including Canvas, Jenzabar, Moodle, Sakai, and Schoology. It also supports Learning Tools Interoperability (LTI) 1.0 for integration with other LMS systems (such as Blackboard and D2L).

Want to try out BigBlueButton? Visit our demo server at [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org) and setup a free account. The demo server also runs [Greenlight](https://github.com/bigbluebutton/greenlight), an easy-to-use front-end for creating rooms, starting meetings, inviting others, and managing recordings. Greenlight is open source as well.

Want to setup your own BigBlueButton server? If you have a server that meets the [minimum requirements](/2.3/install.html#minimum-server-requirements) and have a domain name pointing to its public IP address, then you can use [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) to install the latest version of BigBlueButton, configure the server with SSL (thanks to Let's Encrypt), setup Greenlight, and have all ready in under 15 minutes. Very cool.

Want to learn more about BigBlueButton? Read on. The site gives you all the details on how to install, configure, and customize BigBlueButton to your needs. We'll start below with brief overview of how BigBlueButton works.

## BigBlueButton overview

BigBlueButton is an HTML5-based web application. Unlike many commercial web conferencing systems that require you to install software, BigBlueButton runs within your web browser. You click a link (such as in Greenlight), your browser runs BigBlueButton and prompts you to join the audio bridge. There is no plugin to download, no software to install. BigBlueButton provides high-quality audio, video, and screen sharing using the browser's built-in support for web real-time communication (WebRTC) libraries.

WebRTC is a standard supported by all major browsers, including Chrome, FireFox, Safari, and Safari Mobile. For best results on desktop and laptops, we recommend Chrome or Firefox. For Chromebooks, we recommend the built-in Chrome browser.

Support for WebRTC within the browser is rapidly growing. Microsoft recently (January 2020) released new version of Microsoft Edge that [switched to use the Chromium engine](https://blogs.windows.com/windowsexperience/2019/04/08/microsoft-edge-preview-builds-the-next-step-in-our-oss-journey/) the open source engine that powers Google Chrome. This means that soon that hundreds of millions of Windows 10 computers will be able to run BigBlueButton with a single click. Super cool.

Here is a screen shot of the BigBlueButton client running in Google Chrome.

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

From left to right, you can see the list of users in the session, the chat area, the presentation area (where the current presenter can update), one shared web cam (you can share as many webcams as bandwidth allows), and the whiteboard tools.

## Mobile support

BigBlueButton has a "mobile first" design. We designed the user interface (UI) to first run on a mobile device. Like the desktop, there is no mobile app to download or install. BigBlueButton runs within your mobile browser.

BigBlueButton runs on iOS version 12.2+ and Android version 6.0+. To join a session, you click a link within the browser or a mobile app (such as Moodle Mobile), and BigBlueButton will run within Safari Mobile (iOS) or Google Chrome (Android).

Here's a screen shot of BigBlueButton running on an iOS phone in landscape mode.

<p align="center">
  <img src="/images/22-ios.png"/>
</p><br>

The only limitation on mobile platforms is the browsers do not support sharing of the mobile screen (though you can view another user's screen share).

It's worth emphasizing that the same HTML5 client runs across desktop, laptop, chromebook, iOS, and Android devices. This gives us a single code base to enhance, localize, and innovate without the multiple code bases.

## Designed for online learning

We stated above that BigBlueButton extends many of its core features to focus on enabling the instructor to engage students. There are four main use cases for engagement:

1. Tutoring/virtual office hours
2. Flipped classroom
3. Group collaboration
4. Full online classes

If you are an instructor, BigBlueButton helps you engage students with:

- Multi-user whiteboard
- Break out rooms
- Chat (public and private)
- Polling
- Shared notes
- Closed captions
- Selecting a student
- Emojis

We think of _engagement_ as an activity that causes the user to recall (such as answering a poll), demonstrate (such as using multi-user whiteboard), apply (such as in breakout rooms), or ask questions (such as using public chat) about the material the instructor is trying to teach. The more students are engaged, the more they are thinking and learning.

Of course, all these features are still useful in a business meeting, video chat, or audio conference -- but they are really useful when teaching users online.

To support users with accessibility needs, BigBlueButton is [WCAG 2.0 AA certified (with some exceptions)](https://bigbluebutton.org/accessibility/).

## A brief overview of BigBlueButton

There are two types of users in BigBlueButton: viewer and moderator.

- A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as their raised hand), and participate in a breakout sessions.

- A _moderator_ (typically the instructor) can do everything a viewer can, plus more. A moderator can mute/unmute other viewers, lock down viewers (such as restrict them from using private chat), and make anyone the current _presenter_. There can be multiple moderators in a session.

The presenter can do the following:

- Upload slides
- Use the whiteboard to annotate any side
- Enable/disable multi-user whiteboard
- Start a poll
- Share a YouTube, vimeo, or [Canvas Studio](https://community.canvaslms.com/community/answers/guides/studio-guide) video
- Share their screen

There can be only one presenter at a time in the session. Any moderator can make any user presenter, including themselves.

We created two overview videos -- one for the viewer and the other for the moderator -- to show you how the above features work.

- [Viewer overview](https://www.youtube.com/watch?v=uYYnryIM0Uw)
- [Moderator/Presenter overview](https://www.youtube.com/watch?v=Q2tG2SS4gXA)

## Next steps,

If you are an administrator interested in setting up your own BigBlueButton server, we recommend you:

1. Watch the [overview videos](https://bigbluebutton.org/html5) to better understand the capabilities of viewer, moderator, and presenter.
2. Set up a free account to use BigBlueButton on our [demo server](https://demo.bigbluebutton.org/).
3. Follow us on social media: [Twitter](https://twitter.com/bigbluebutton), [Facebook](https://www.facebook.com/bigbluebutton), and [YouTube](https://www.youtube.com/user/bigbluebuttonshare).
4. Setup your own BigBlueButton server using [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) (for those that want to get going quickly), or follow our [step-by-step install instructions](/2.3/install.html) (for those that want to understand the details of setting up a server).
5. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/) to engage the community (such as if you need help setting up your server).

If you are a developer, we recommend you:

1. Follow the above guidelines for administrator
2. Explore the options to [customize BigBlueButton](/admin/customize.html)
3. Checkout the [BigBlueButton API](/dev/api.html)
4. [Setup a development environment](/dev/setup.html) to modify and extend BigBlueButton itself.

If your interested in using BigBlueButton in a production environment, [check out the companies](https://bigbluebutton.org/commercial-support/) that offer commercial support and hosting for BigBlueButton.

## Latest release

The latest version of BigBlueButton is BigBlueButton 2.3. See [install BigBlueButton](/2.3/install.html).

Overview for Viewers (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=uYYnryIM0Uw" target="_blank"><img src="https://img.youtube.com/vi/uYYnryIM0Uw/0.jpg" alt="Overview of BigBlueButton 2.2 for viewers" width="480" height="360" border="10" /></a>
</p>

Overview for Moderators/Presenters (click image below to watch YouTube video):

<p align="center">
  <a href="https://www.youtube.com/watch?feature=player_embedded&v=Q2tG2SS4gXA" target="_blank"><img src="https://img.youtube.com/vi/Q2tG2SS4gXA/0.jpg" alt="Overview of BigBlueButton 2.2 for moderators/presenters" width="480" height="360" border="10" /></a>
</p>

We frequently update each BigBlueButton release. To follow the updates, check out the [release notes](https://github.com/bigbluebutton/bigbluebutton/releases).

### Contributing to our project

The BigBlueButton project is managed by a core group of [committers](/support/faq.html#bigbluebutton-committer) who care about good design and a streamlined user experience.

An easy way to contribute to our project is to tell your peers about it.

- Sending out a tweet at [@bigbluebutton](https://twitter.com/bigbluebutton)
- Uploading a video on YouTube demonstrating how you are using BigBlueButton
- Writing a blog post on your blog about BigBlueButton

We are passionate about making the world's best open source web conferencing system for online learning. We enjoy reading about how others are benefiting from and building upon BigBlueButton.

BigBlueButton welcomes contributions from others on the project. See [contributing to Bigbluebutton](/support/faq.html#contributing-to-bigbluebutton).

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).
