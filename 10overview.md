---
layout: page
title: "1.0"
---



# BigBlueButton 1.0-beta

This document covers what is new in BigblueButton 1.0-beta (referred hereafter as 1.0).

The goal of this release is to increase interactivity between the instructor and student.  For users there are three new capabilities in this release

  * Polling
  * Improved Video Doc
  * Emote Icons

As with every release, we refactor specific components to improve stability.  
  * Refactoring of message passing (see [2684](https://github.com/bigbluebutton/bigbluebutton/issues/2684))
  * Automatic reconnect of client

We've added enhancements for developers as well
  * Desksahre TLS over Stunnel
  * API Updates
  * WebHooks

We've also updated the build scripts to work with servers that have HTTPS installed.  


# Polling

Our guiding design polling was the following user story

  _As an instructor I want to easily poll my students to increase their engagement and use the polling results help me re-enforce key concepts._

We observed that the current slide provides the context for discussion and can also provide the context for polling.  Consider the following slide:

![Context](/images/polling-context.png)

It would be natural for the instructor to ask students "What do you think is the answer?". 

Focusing on 'easy', we built polling to be as seamless and quick as possible -- in some cases the presenter can initiate a poll with a single click.  Polling offers three types of interactions

   1. Pre-configured choices
   1. Smart Polling
   1. Custom Choices

## Pre-configured choices

The presenter can initiate a poll at anytime during the session.  To initiate a poll, the presenter clicks the polling button (located to the right of the upload slide button) and chooses from a list of pre-defined questions.

![Pre-defined](/images/polling-pop-up.png)

When the presenter initiates a poll, a dialog box appears showing the results in real-time (along with the number of respondents).

![Live Results](/images/polling-live-results.png)

At this point only the presenter sees the results.  The presenter can close the polling results (no one else sees the results) or click 'Publish' to publish the results to the presentation as a whiteboard mark.

![Publish](/images/polling-publish.png)

Here the presenter can zoom into the poll results, annotate them with the whiteboard tools, and clear them with whiteboard controls.

When the presenter initiates a poll, the other users will hear a soft beam and the choices will appear underneath the  slide.  

![Response](/images/polling-response.png)

Users can respond with a single click.

## Smart Polling

Let's look again at the slide -- notice that it follows a standard pattern of having the choices prefixes by A., B., and C..  BigBlueButton will scan the text of the slides and present the instructor a _smart poll_ button to initiate the a three choice poll with a single click.

![Response](/images/polling-smart-poll.png)

