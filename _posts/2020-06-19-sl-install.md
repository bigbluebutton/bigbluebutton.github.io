---
layout: page
title: "Deploy"
category: scalelite
date: 2020-06-19 22:13:42
order: 2
---

This section walks you through the installation and set up of Scalelite so that you can effectively scale BigBlueButton to fully leverage its functionality.

**Note:** All of the source code and files are available on [GitHub](https://github.com/blindsidenetworks/scalelite).

# Introduction

## Before you begin

The Scalelite installation process requires advanced technical knowledge. You should, at a minimum, be very familar with

* Setup and administration of a BigBlueButton server
* Setup and administration of a Linux server and using common tools, such as systemd, to manage processes on the server
* How the [BigBlueButton API](http://docs.bigbluebutton.org/dev/api.html) works with a front-end
* How [docker](https://www.docker.com/) containers work
* How UDP and TCP/IP work together
* How to administrate a Linux Firewall
* How to setup a TURN server

If you are a beginner, you will have a difficult time getting any part of this deployment correct. In this case, you should [seek help](/2.2/getting-help.html).

## Minimum requirements

For the Scalelite Server, the minimum recommended server requirements are:

* 4 CPU Cores
* 8 GB Memory

For each BigBlueButton server, the minimum requirements can be found [here](http://docs.bigbluebutton.org/2.2/install.html#minimum-server-requirements).

For the external Postgres Database, the minimum recommended server requirements are:

* 2 CPU Cores
* 2 GB Memory
* 20 GB Disk Space (should be good for tens of thousands of recordings)

For the external Redis Cache, the minimum recommended server requirements are:

* 2 CPU Cores
* 0.5GB Memory
* **Persistence must be enabled**

# Installation

## Setup a pool of BigBlueButton servers

To setup a pool of BigBlueButton servers (minimum recommended number is 3), we recommend using `bbb-install.sh` as it can automate the steps to install, configure (with SSL + Let's Encrypt), and update the server when new versions of BigBlueButton are released. Alternatively, if you are managing a large amount of servers, it is preferable to use Ansible to manage these.

All details and more are can be found in the [installation section](/2.2/install.html).

## Setup a shared volume for recordings

### Mounting the shared volume

A shared volume should be mounted via NFS on the following systems:

* BigBlueButton servers
* Host system for `scalelite-nginx` Docker container
* Host system for `scalelite-recording-importer` Docker container

The mount point should be different from any of the paths used by stock BigBlueButton. A good choice is `/mnt/scalelite-recordings` - this is the path that will be referenced below. If you use a different path, modify the path in the instructions to match.

### Setting up directory structure and permissions
It is critical to note that NFS file permissions are based on numeric UID/GID values, and not by user and group names. As a result, it is important to set up users and groups with consistent numbers on the various services.

The docker containers that operate on recording files use a fixed UID value of 1000.
A fresh BigBlueButton server install will usually have a “bigbluebutton” user with UID 997, but this UID is not guaranteed.

In order to solve the consistency issue, you should create a new group on the BigBlueButton server with a consistent GID to control write permissions. Pick a GID that's unused on the server. In the examples below, I use 2000.

**On each BigBlueButton server**, run these commands to create the group and add the bigbluebutton user to the group:

```bash
# Create a new group with GID 2000
groupadd -g 2000 scalelite-spool
# Add the bigbluebutton user to the group
usermod -a -G scalelite-spool bigbluebutton
```

**On the Scalelite server**, you are now ready to set up the directory structure and permissions on the shared volume. Assuming you're using the mountpoint `/mnt/scalelite-recordings` the commands to do so will look like this:

```bash
# Create the spool directory for recording transfer from BigBlueButton
mkdir -p /mnt/scalelite-recordings/var/bigbluebutton/spool
chown 1000:2000 /mnt/scalelite-recordings/var/bigbluebutton/spool
chmod 0775 /mnt/scalelite-recordings/var/bigbluebutton/spool

# Create the temporary (working) directory for recording import
mkdir -p /mnt/scalelite-recordings/var/bigbluebutton/recording/scalelite
chown 1000:1000 /mnt/scalelite-recordings/var/bigbluebutton/recording/scalelite
chmod 0775 /mnt/scalelite-recordings/var/bigbluebutton/recording/scalelite

# Create the directory for published recordings
mkdir -p /mnt/scalelite-recordings/var/bigbluebutton/published
chown 1000:1000 /mnt/scalelite-recordings/var/bigbluebutton/published
chmod 0775 /mnt/scalelite-recordings/var/bigbluebutton/published

# Create the directory for unpublished recordings
mkdir -p /mnt/scalelite-recordings/var/bigbluebutton/unpublished
chown 1000:1000 /mnt/scalelite-recordings/var/bigbluebutton/unpublished
chmod 0775 /mnt/scalelite-recordings/var/bigbluebutton/unpublished
```

### Configuring the BigBlueButton recording transfer

#### On each BigBlueButton server

The `scalelite_recording_transfer.rb` post publish script should be installed with its configuration file as described in [this document](/scalelite/sl-configure.html).

To match the mount configuration described in this document, the configuration file `/usr/local/bigbluebutton/core/scripts/scalelite.yml` should have the following contents:

```bash
# Local directory for temporary storage of working files
work_dir: /var/bigbluebutton/recording/scalelite
# Directory to place recording files for scalelite to import
spool_dir: /mnt/scalelite-recordings/var/bigbluebutton/spool
```

**Note:** the next step is only needed if you have existing recordings on your BigBlueButton server**

Once the configuration is performed, you can run the provided `scalelite_batch_import.sh` script to transfer any existing recordings from the BigBlueButton server to Scalelite.

Once the recording transfer has been tested, you can **optionally** enable recording automatic deletion on the BigBlueButton server to remove the local copies of the recordings and free up disk space.

## Setup a PostgreSQL database

Setting up a PostgreSQL Database depends heavily on the infrastructure you use to setup Scalelite. We recommend you refer to your infrastructure provider's documentation.

Ensure the `DATABASE_URL` that you set in `/etc/default/scalelite` (in the next step) matches the connection url of your PostgreSQL Database.

## Setup a Redis Cache

Setting up a Redis Cache depends heavily on the infrastructure you use to setup Scalelite. We recommend you refer to your infrastructure provider's documentation.

Ensure the `REDIS_URL` that you set in `/etc/default/scalelite` (in the next step) matches the connection url of your Redis Cache.

## Deploying Scalelite with Docker

The recommended method to deploy this release of Scalelite is to use `systemd` to start and manage the Docker containers. Some initial preparation is required on each host that will run Scalelite containers. Alternatively, you may use `systemd` entirely to deploy Scalelite, see the [community-sourced Ansible roles](/2.2/install.html).

**Note**: `host` here will mean the server hosting Scalelite and *not* the BigBlueButton servers.

### Install Docker

To install the several components required by Scalelite, Docker must be installed on the host system. Please [follow the instructions provided by Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/).

### Create a private Docker network

For communication between Scalelite containers, a private network should be created. To create a network with the default bridged mode, run:

`docker network create scalelite`

Create a file `/etc/default/scalelite` with the environment variables to configure the application. Reference the [Required Configuration](README.md#required) section for details as needed. For most deployments, you will need to include the following variables at a minimum:

```bash
URL_HOST
SECRET_KEY_BASE
LOADBALANCER_SECRET
DATABASE_URL
REDIS_URL
```

Add the following lines to configure the docker image tag to use and the location of the recording directory to mount into the containers:

```bash
SCALELITE_TAG=v1
SCALELITE_RECORDING_DIR=/mnt/scalelite-recordings/var/bigbluebutton
```

**If Scalelite is responsible for serving via HTTPS**, you must add the following lines to enable HTTPs configuration:

```
NGINX_SSL=true
SCALELITE_NGINX_EXTRA_OPTS=--mount type=bind,source=/etc/letsencrypt,target=/etc/nginx/ssl,readonly
```

Next you should create a file `/etc/systemd/system/scalelite.target` with the content found in the [scalelite.target](https://github.com/blindsidenetworks/scalelite/tree/master/systemd) file. This unit is a helper to allow starting and stopping all of the Scalelite containers together.

Lastly, enable the target by running `systemctl enable scalelite.target`.

### scalelite-api

The scalelite-api container holds the application code responsible for responding to BigBlueButton API requests.

Create a systemd unit file `/etc/systemd/system/scalelite-api.service` with the content found in the [scalelite-api.service](https://github.com/blindsidenetworks/scalelite/blob/master/systemd/scalelite-api.service) file.

And enable it by running `systemctl enable scalelite-api.service`.

#### Initialize the scalelite-api Database

If this is a fresh install, you can load the database schema insto PostgreSQL by running this command:

`docker exec -it scalelite-api bin/rake db:setup`

You should restart all Scalelite services again afterwards by running `systemctl restart scalelite.target`.

### scalelite-nginx

The scalelite-nginx container is responsible for SSL termination (if configured) and for serving recording playback files. Both containers must be on the same host. For a high availability deployment, you can run multiple instances on different hosts behind an external HTTP load balancer.

Create a systemd unit file `/etc/systemd/system/scalelite-nginx.service` with the content found in the [scalelite-nginx.service](https://github.com/blindsidenetworks/scalelite/blob/master/systemd/scalelite-nginx.service) file.

And enable it by running `systemctl enable scalelite-nginx.service`.

### scalelite-poller

The scalelite-poller container runs a process that periodically checks the reachability and load of BigBlueButton servers, and detects when meetings have ended.

Only a single poller is required in a deployment, but running multiple pollers will not cause any errors. It can be put on the same host system as the web frontend.

Create a systemd unit file `/etc/systemd/system/scalelite-poller.service` with the content found in the [scalelite-poller.service](https://github.com/blindsidenetworks/scalelite/blob/master/systemd/scalelite-poller.service) file.

And enable it by running `systemctl enable scalelite-poller.service`.

### scalelite-recording-importer

The scalelite-recording-importer container runs a process that monitors for new recordings transferred to the spool directory from BigBlueButton servers. It unpacks the transferred recordings, adds the recording information to the Scalelite database, and places the recording files into the correct places so scalelite-nginx can serve the recordings.

You MUST run only one instance of the recording importer.

If you are doing a high-availability deployment of Scalelite, then the recording importer **MUST** be set up on a separate host from the web frontend.

If you are not doing a high-availability deployment of Scalelite, then you **MAY** colocate the web frontend and recording importer on the same host.

You **MAY** colocate the recording importer and meeting status poller on the same host.

Create a systemd unit file `/etc/systemd/system/scalelite-recording-importer.service` with the content found in the [scalelite-recording-importer.service](https://github.com/blindsidenetworks/scalelite/blob/master/systemd/scalelite-recording-importer.service) file.

And enable it by running `systemctl enable scalelite-recording-importer.service`.

## Final steps

You can now restart all scalelite services by running

`systemctl restart scalelite.target`

Afterwards, check the status with

```bash
systemctl status scalelite-poller.service scalelite-api.service scalelite-nginx.service scalelite-recording-importer.service
```

to verify that the containers started correctly.

Congratulations! You now have a fully scalable load bablancer for BigBlueButton. Now, you need to configure your front-end to talk to Scalelite as well as polish some other things. Head on to the [configuration section](/scalelite/configure.html).

## Upgrading

Upgrading Scalelite to the latest version can be done using one command: `systemctl restart scalelite.target`. If you have gone for a non-Docker setup, you just need to `git pull` the latest version of Scalelite and restart Scalelite.

To confirm that you have the latest version, enter `http(s)://<scalelite-hostname>/bigbluebutton/api` in your browser and confirm that the value inside the `<build><\build>` tag is equal to the new version.
