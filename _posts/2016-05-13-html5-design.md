---
layout: page
title: "HTML5 Design"
category: html
date: 2016-05-13 17:34:41
order: 2
---

---
<br>

# Overview

BigBlueButton is an open source web conferencing system for online learning.  Our goal is to provide remote students with a high-quality online learning experience..

To achieve this goal, we are always looking at ways to improve the teacher and learning experience within our product.  The user interface (UI) for BigBlueButton is a major component of that experience.

Since the project’s inception in 2008, BigBlueButton has evolved and improved with each product iteration (over 14 releases since the initial version).  While there have been significant architectural changes over the years, the UI has remained largely consistent with the first release.

Recently, we’ve been working on developing an HTML5 mobile client for BigBlueButton that has an updated user experience for participating in BigBlueButton sessions.  While there are many architectural changes needed to support an HTML5 client, and while we wanted to create a consistent user experience across platforms, we took this opportunity to ask ourselves "How could we improve the user experience to better reach our goal?".

This document will give you an overview of our motivation and design decisions consistent with the BigBlueButton user interface in HTML5 that is intended to span across platforms (mobile, tablet, and desktop).


## Cross platform capability

There are many technical challenges to creating a cross-platform HTML5 product that implements similar functionality on all devices.  Today, platforms provide by the browsers -- especially those that support web real-time communications (WebRTC) frameworks -- are nothing short of amazing.
If you are a busy student, commuting into campus, or a business professional conducting a collaborative online training session, we would like to provide you multiple options (phone, tablet, and desktop) to join a BigBlueButton session.

## User expectations

With the increased adoption of mobile applications, new standards, new user expectations, and new best practices have evolved; such as CSS frameworks, grid systems, layouts, placement and sizing of elements, that are creating a fairly consistent means of interaction with mobile devices.

For example, if you have used Slack, Facebook, Twitter, or GMail mobile applications, you would notice they all share similar UI conventions that have evolved over the past few years.

When updating the BigBlueButton user interface, we didn’t feel the need to create any radically new ways of interaction; rather, we wanted to provide users with a modern, consistent, modular and accessible interface that would be familiar to users based on their experience with other applications.

## Consistent across platforms

In the beginning when designing the BigBlueButton HTML5 client, we initially focused on the mobile experience, which had a very different experience from the the current Flash-based web client.  After all, they are different forms of interaction: touch vs. mouse, handheld vs. screen, tap vs. keyboard.

As we developed designs for the mobile interface -- starting from a very small set of design goals -- we knew that while it didn’t need to work exactly the same on all platforms we wanted to create a design language that was consistent across all platforms.

<br><br>

# Design Goals

## Mobile first approach

Designing for mobile first allows us to take a step back from the current user experience and think about the minimal set of features required for a participant to engage in a session (you will see lots of examples of this in the designs below).

The current Flash-based user experience has a series of windows and layouts to accommodate different users.  However; mobile applications don’t have windows, instead they have a core set of elements that intelligently overlay as the user needs to access them.

We have a similar set of elements in BigBlueButton

* The presentation area
* Group or private chat
* Participants list
* Video (webcam and desktop sharing)
* Preferences

## Unified experience

Providing a unified experience will allow our users to quickly become familiar with the product and reduce the overall learning curve. If you are using the web, tablet or mobile client, our goal is to have consistent styles and placement of elements. By doing so, will also make the experience of contributing or building on top of BigBlueButton a lot easier for developers.


## Accessibility

Accessibility is _very_ important to our target market of online learning.  We wanted to make sure the designs would allow us to provide our users with a variety of accessibility best practises, such as Aria landmarks, Aria labels, Aria polite and providing a colour palette that supports visually impared users. While Flash has very good support for accessibility within the web browser, we wanted to be sure the HTML5 client was equally accessible as well.

## Extensible UI design

BigBlueButton is not only a solution, but a platform that other companies build upon.  In creating a new design one of our goals is to provide our community with a modular design so that new features or components can be created with ease.   If a developer wanted to add a shared notes module in the UI, for example, or additional volume controls, we want to make sure the look and feel are consistent with the existing user interface.

<br><br>

# Client Designs | Initial Release

Below are designs for our first release for the web, tablet and mobile HTML5 client.

## Mobile Views

With the first release of the HTML5 mobile views, we've focused our efforts on tackling the experience of how individuals will best consume content on a smaller device. This includes, consuming the presentation, enabling/disabling your audio, emoji interactions and public/private chat.

<br>
<img src="/images/html5/bbb_mobile_default.png" width="225" alt="BigBlueButton Mobile Default View"/>
<img src="/images/html5/bbb_mobile_participants_list.png" width="225" alt="BigBlueButton Mobile Participants List" />
<img src="/images/html5/bbb_mobile_chat_public.png" width="225" alt="BigBlueButton Mobile Public Chat"/>
<img src="/images/html5/bbb_mobile_polling.png" width="225" alt="BigBlueButton Mobile Polling" />

<br>

## Tablet Views

The tablet views follow the same design pattern approach as the mobile screens.

<br>
<img src="/images/html5/bbb_tablet_portrait.png" width="465" />
<img src="/images/html5/bbb_tablet_portrait_sidebar.png" width="465" style="margin-left:20px;"/>
<br><br>
<br><br>
<img src="/images/html5/bbb_tablet_landscape.png" width="465"/>
<img src="/images/html5/bbb_tablet_landscape_sidebar.png" width="465" style="margin-left:20px;"/>
<br><br>

## Desktop Views

The desktop experience is where we start to see more of the functionality become present. Here is where you will see as a presenter the ability to upload slides, annotations, multi whiteboard and closed captioning.

<br>
<img src="/images/html5/bbb-html5_default.png" />
<center> Default View </center>
<br><br>

<img src="/images/html5/bbb-html5_default_expanded_sidebar.png" />
<center> Expanded Sidebar View |  Public & direct messages and the list of participants. </center>
<br><br>

<img src="/images/html5/bbb-html5_default_expanded.png" />
<center> Full Expanded View |  Public and private chat. </center>
<br><br>

<img src="/images/html5/bbb-html5_breakout_rooms.png" />
<center> Breakout Rooms </center>
<br><br>

<img src="/images/html5/bbb-html5_upload.png" style="border:1px solid #ccc;" />
<center> Uploading a presentation </center>
<br><br>

<img src="/images/html5/bbb-html5_settings.png" style="border:1px solid #ccc;" />
<center> User Settings </center>
<br><br>

<img src="/images/html5/bbb-html5_close_caption.png" style="border:1px solid #ccc;" />
<center> Closed Caption </center>
<br><br>


## Style Guide

### Overview

Without the style you'll find a breakout of the core colour palette, typography and elements styles.

<img src="/images/html5/bbb_style_guide.png" style="border:1px solid #ccc;" />


### Accessible Colour Palette

As a team passionate about maintaining accessibility best practices within BigBlueButton and in the case of colour, we want to make sure all types of users (visually impaired or not) have a pleasant experience. Below you'll find a detailed overview of our core colour palette and their contrast ratio. Our goal was to maintain a ratio of 4.5:1 an above.
<img src="/images/html5/bbb_colour_palette.png" />
<br>

### Custom Icon Library
With the new client we wanted to also include a shareable icon library that can openly use for their development efforts.
<br><br>
<img src="/images/html5/bbb_icons.png" style="border:1px solid #ccc;" />
<br><br><br>

# Client Designs | Planned Updates

### Desktop Sharing
When a presenter chooses to shares their desktop, it will replace the existing presentation area. When a presenter has finished sharing their desktop, they can select "stop", and the presentation will resume.
<img src="/images/html5/bbb-html5_deskshare.png" />

### Expanding the presentation controls
Updated presentation controls that include, zoom, fit to width and fit to page.
<img src="/images/html5/bbb_default.png" />

### Audio dialog with echo test
When a use joins a session, a dialogue box will appear signifying to the user which auto route they should take, join with microphone or listen only (similar to the flash experience). If they select join via a microphone, a user will be prompted with a another step asking if they can hear themselves (echo test).

<img src="/images/html5/bbb-html5_audio_dialogue.png" />

<br>
<br>

## Client Designs | Roadmap Features
Multiple Chat
Audio Only Breakout Rooms
Video Sharing
User Management
<br>
<br>

### Shared Notes
<img src="/images/html5/bbb_multiple_shared_notes.png" />
<br><br>
<img src="/images/html5/bbb_mobile_participants_list_notes.png"  width="350"/>
<img src="/images/html5/bbb_mobile_notes.png" width="350" />
<hr>

### Multiple Chat Rooms
<img src="/images/html5/bbb_multiple_chat_pods.png" />
<br><br>
<img src="/images/html5/bbb_mobile_participants_list_chat.png" width="350" />
<img src="/images/html5/bbb_mobile_chat_public.png"  width="350"/>

### User Management
Add Text

### Audio Only Breakout Rooms
Add Text


If you have any questions or feedback, please join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post them to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  We look forward to hearing from you.
