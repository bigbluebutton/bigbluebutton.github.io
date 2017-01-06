---
layout: page
title: "Green Light"
category: labs
date: 2016-12-08 16:29:25
---

## Overview

Green Light is a simple front-end for your BigBlueButton server.  At it's core, Green Light provides a minmialistic web-based interface to let users
  
   * Create a meeting
   * Invite others to the meeting

 In the meeting all users are moderators, which means anyone can make themselves presenter and share slides with others.  

Green Light is build on rails 5.  The steps below show how to install Green Light on an existing BigBlueButton 1.1 (or above) server using Docker.  Docker enables Green Light to within it's own container and not install any dependencies on BigBlueButton.  Nginx will proxy all requests to Green Light.

It provides you (the developer) a reference implementation of how to create a front-end for BigBlueButton.  All strings are localized, so it's easy to extend to other languages.

Green Light supports an authenticated user via OAuth (Twitter or Facebook).  An authenticated user can create a meeting where only they are the moderator and other users are viewers.

### Building from source
(instructions coming soon)

