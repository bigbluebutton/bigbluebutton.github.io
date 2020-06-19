---
layout: page
title: "Overview"
category: scalelite
date: 2020-06-19 22:13:43
order: 1
---

This section outlines what Scalelite is, how it works and why you might be interested in using it to fully leverage BigBlueButton.

# Introduction

Scalelite is an open source load balancer that manages a pool of BigBlueButton servers and, to any BigBlueButton front-end, such as Moodle or Greenlight, makes the pool of BigBlueButton servers appear as a single (very scalable) BigBlueButton server.

It was released by Blindside Networks under the AGPL license on March 13, 2020, in response to the high demand of Universities looking into scaling BigBlueButton as a result of the COVID-19 pandemic of 2020.

The full source code is available on [GitHub](https://github.com/blindsidenetworks/scalelite) and pre-built docker images that can be found on [DockerHub](https://hub.docker.com/repository/docker/blindsidenetwks/scalelite). See the [deployment section](/scalelite/sl-install.html) for installation instructions.

**Note:** Scalelite is targeted at system administrators with experience managing BigBlueButton servers and the infrastructure required to support a distributed service.

## Motivation

A single BigBlueButton server that meets the minimum configuration supports around 200 concurrent users.

For many schools and organizations, the ability to 4 simultaneous classes of 50 users, or 8 simultaneous meetings of 25 users, is enough capacity. However, what if a school wants to support 1,500 users across 50 simultaneous classes? A single BigBlueButton server cannot handle such a load.

With Scalelite, a school can create a pool of 4 BigBlueButton servers and handle 16 simultaneous classes of 50 users. Want to scale higher? Add more BigBlueButton servers to the pool. Our install script `bbb-install.sh` will quickly get you up and running, or alternatively you can manage your servers with Ansible to add a new server to the pool in less than 20 minutes.

# Architecture

There are several components required to get Scalelite up and running:

* Multiple BigBlueButton Servers
* Scalelite LoadBalancer Server
* NFS Shared Volume
* PostgreSQL Database
* Redis Cache

An example Scalelite deployment will look like this:

![Scalelite architecture](/images/scalelite/scalelite.png)

# How it works

Scalelite is composed of four main components:

* **Frontend API**: a Rails application that implements the BigBlueButton API and loadbalancing.
* **nginx proxy**: a custom build of nginx that includes configuration files for handling the requests in the same way BigBlueButton does.
* **Server poller**: a Ruby script that is run as a scheduled task for polling the status of the BigBlueButton servers registered.
* **Recording importer**: a Ruby script that is run as a scheduled task for importing the recording feed by the BigBlueButton servers into the database.

![Scalelite components](/images/scalelite/overview.png)

The components interact as shown above. These components may or may not be run as Docker contains, but regardless of the installation these logical units still stand.  

Scalelite periodically polls each BigBlueButton to check if it is reachable online, ready to receive API requests, and to determine its current load (number of connected users). With this information, when Scalelite receives an incoming API call to create a new meeting, it places the new meeting on the least loaded server in the pool. In this way, Scalelite can balance the load of meeting requests evenly across the pool.

Many BigBlueButton servers will create many recordings. Scalelite can serve a large set of recordings by consolidating them together, indexing them in a database, and, when receiving an incoming `getRecordings`, use the database index to quickly return  the list of available recordings.

To install and deploy these components as docker containers, please see [installing Scalelite](/scalelite/sl-install.html). You may alternatively use `systemd` to manage the entire setup without Docker.
