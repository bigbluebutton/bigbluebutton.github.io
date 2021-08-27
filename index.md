---
layout: default

title: 'BigBlueButton'
---

<p align="center">
  <img src="/images/logo.png"/>
</p><br>

BigBlueButton is an open source web conferencing system for online learning. This means

- **Open source** - you have full access to BigBlueButton's [source code](https://github.com/bigbluebutton/bigbluebutton) under an [open source license](https://bigbluebutton.org/open-source-license/). With the source code, you can [install](/2.3/install.html), [customize](admin/customize.html), [develop](/2.3/dev.html), [scale](https://github.com/blindsidenetworks/scalelite), and [integrate](/dev/api.html) it into your products and services with help from the [community](https://bigbluebutton.org/support/). Cool.

- **Web conferencing system** - BigBluebutton provides you all the core features you would expect from a commercial web conferencing system (but under an open source license) including real-time sharing of audio, video, presentation, and screen -- along with collaboration tools such as chat (public and private), whiteboard, shared notes, polling, and breakout rooms.  BigBlueButton can record your sessions for later playback.

- **Online learning** - BigBlueButton extends these core features for online learning. For example, a tutor can enable multi-user whiteboard to directly work with a student on solving a math problem.  BigBlueButton has [deep integrations](https://bigbluebutton.org/schools/integrations/) with all the major learning management systems (LMS). It also supports Learning Tools Interoperability (LTI) 1.0 for integration with other LMS systems.

Want to try out BigBlueButton? Visit our demo server at [https://demo.bigbluebutton.org](https://demo.bigbluebutton.org) and setup a free account. The demo server also runs [Greenlight](https://github.com/bigbluebutton/greenlight), an easy-to-use front-end for creating rooms, starting meetings, inviting others, and managing recordings. Greenlight is open source as well.

Want to setup your own BigBlueButton server? If you have a server that meets the [minimum requirements](/2.3/install.html#minimum-server-requirements) and have a domain name pointing to its public IP address, then you can use [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) to install the latest version of BigBlueButton, configure the server with SSL (thanks to Let's Encrypt), setup Greenlight, and have all ready in under 15 minutes. Very cool.

Want to learn more about BigBlueButton? Read on. The documentation covers all details on how to install, configure, and customize BigBlueButton to your needs. We'll start below with brief overview of how BigBlueButton works.  If you find any issues with these docs, [please let us know](https://github.com/bigbluebutton/bigbluebutton.github.io/).

## BigBlueButton overview

BigBlueButton is an HTML5-based web application. Unlike many commercial web conferencing systems that require you to install software, BigBlueButton runs within your web browser.  To join a BigBlueButton session, you click a link (such as in Greenlight) that opens a valid join URL in your browser. The BigBlueButton server receives the URL, validates it, and loads the BigBlueButton client.  After loading, it immediately prompts you to join the audio bridge and start collaborating. There is no plugins to download, no software to install.  BigBlueButton provides high-quality audio, video, and screen sharing using the browser's built-in support for web real-time communication (WebRTC) libraries.

WebRTC is a standard supported by all major browsers, including Chrome, FireFox, Safari, and Safari Mobile. For best results on desktop and laptops, we recommend Chrome, Microsoft Edge, or Firefox. For Chromebooks, we recommend the built-in Chrome browser.

Here is a screen shot of the BigBlueButton client running in Google Chrome.

<p align="center">
  <img src="/images/22-overview-2.png"/>
</p><br>

From left to right, you can see the list of Users in the session, the Chat area, the Presentation area (where the current presenter can update), one webcam, and whiteboad tools.

## Mobile support

BigBlueButton has a "mobile first" design: we designed the user interface (UI) to first run on a mobile device.  Like the desktop, there is no mobile app to download or install. BigBlueButton runs within your mobile browser.

BigBlueButton runs on iOS version 12.2+ and Android version 6.0+. To join a session, you click a link within the browser or a mobile app (such as Moodle Mobile), and BigBlueButton will run within Safari Mobile (iOS) or Google Chrome (Android).

Here's a screen shot of BigBlueButton running on an iOS phone in landscape mode.

<p align="center">
  <img src="/images/22-ios.png"/>
</p><br>

The only limitation on mobile clients is that the mobile browsers do not support sharing of the mobile screen (though you can view another user's screen share).

It's worth emphasizing that the same HTML5 client runs across desktop, laptop, chromebook, iOS, and Android devices. This enables a single code base to enhance, localize, and innovate without the multiple code bases.


## Designed for online learning

We stated above that BigBlueButton extends many of its core features to focus on enabling the instructor to engage students. There are four main use cases for engagement:

1. Tutoring/virtual office hours
2. Flipped classroom
3. Group collaboration
4. Full online classes

If you are an instructor, BigBlueButton helps you engage students with:

- Multi-user whiteboard
- Breakout rooms (group and individual)
- Chat (public and private)
- Polling
- Shared notes
- Randomly selecting a student
- Emojis

We think of _engagement_ in terms of activities designed to help students learn, such as following the [Bloom's Taxonomy](https://en.wikipedia.org/wiki/Bloom's_taxonomy) framework.  Examples include an activity that causes the user to recall (such as answering a poll), demonstrate (such as using multi-user whiteboard), apply (such as in breakout rooms), or ask questions (such as using public chat) about the material the instructor is trying to teach. The more students are engaged, the more they are thinking and learning.

Of course, all these features are still useful in a business meeting, video chat, or audio conference -- but they are *really* useful when teaching users online.

To support users with accessibility needs, BigBlueButton is [WCAG 2.0 AA certified (with some exceptions)](https://bigbluebutton.org/accessibility/).

## A brief overview of BigBlueButton

There are two types of users in BigBlueButton: viewer and moderator.

- A _viewer_ (typically the student) can chat, send/receive audio and video, respond to polls, display an emoji (such as their raised hand), and participate in a breakout sessions.  They can not affect other students in the class. 

- A _moderator_ (typically the instructor) can do everything a viewer can, plus more. A moderator can mute/unmute other viewers, lock down viewers (such as restrict them from using private chat), make any user (including themselves) the current _presenter_, and start breakout rooms. There can be multiple moderators in a session.

The presenter is an extra layer of privileges that gives any user the ability to

- Upload slides
- Use the whiteboard to annotate any side
- Enable/disable multi-user whiteboard
- Start a poll
- Share a YouTube, vimeo, [peertube](https://joinpeertube.org/), or [Canvas Studio](https://community.canvaslms.com/community/answers/guides/studio-guide) video
- Share their screen

There can be only one presenter at a time. Again, any moderator can make any user (including themselves) the current presenter.

We created two overview videos -- one for the viewer and the other for the moderator -- to show you how the above features work.

- [Viewer overview](https://www.youtube.com/watch?v=uYYnryIM0Uw)
- [Moderator/Presenter overview](https://www.youtube.com/watch?v=Q2tG2SS4gXA)

## Next steps

Interesting in getting started with BigBlueButton?

If you are an administrator interested in setting up your own BigBlueButton server, we recommend you:

1. Watch the [overview videos](https://bigbluebutton.org/html5) to better understand the capabilities of viewer, moderator, and presenter.
2. Set up a free account to use BigBlueButton on our [demo server](https://demo.bigbluebutton.org/).
3. Join the [BigBlueButton community](https://bigbluebutton.org/support/community/) for help and, as you become an expert, help others.
4. Setup your own BigBlueButton server using [bbb-install.sh](https://github.com/bigbluebutton/bbb-install).
3. Follow us on social media: [Twitter](https://twitter.com/bigbluebutton), [Facebook](https://www.facebook.com/bigbluebutton), and [YouTube](https://www.youtube.com/user/bigbluebuttonshare).

If you are a developer, we recommend you:

1. Follow the above guidelines for administrator
2. Explore the options to [customize BigBlueButton](/admin/customize.html)
3. Checkout the [BigBlueButton API](/dev/api.html)
4. [Setup a development environment](/dev/setup.html) to modify and extend BigBlueButton itself.

If your interested in using BigBlueButton in a production environment, there are a [number of companies that offer commercial support](https://bigbluebutton.org/commercial-support/) hosting and customizing BigBlueButton.

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

For information on the latest versions check out the [release notes](https://github.com/bigbluebutton/bigbluebutton/releases).

### Share your experience with others

The BigBlueButton project is managed by a core group of [committers](/support/faq.html#bigbluebutton-committer) who care about good design and a streamlined user experience.

An easy way to help the project is to tell your peers about it.

- Sending out a tweet at [@bigbluebutton](https://twitter.com/bigbluebutton)
- Uploading a video on YouTube demonstrating how you are using BigBlueButton
- Writing a blog post on your blog about BigBlueButton

We are passionate about making the world's best open source web conferencing system for online learning. We enjoy reading about how others are benefiting from and building upon BigBlueButton.

BigBlueButton welcomes contributions from others on the project. See [contributing to Bigbluebutton](/support/faq.html#contributing-to-bigbluebutton).

---

![yourkit](/images/yourkit.png)

YourKit is kindly supporting open source projects with its full-featured Java Profiler. YourKit, LLC is the creator of innovative and intelligent tools for profiling Java and .NET applications. Take a look at YourKit's leading software products: [YourKit Java Profiler](https://www.yourkit.com/java/profiler/index.jsp) and [YourKit .NET Profiler](https://www.yourkit.com/.net/profiler/index.jsp).
