---
layout: page
title: "Green Light"
category: "1.1"
date: 2016-12-08 16:29:25
---

BigBlueButton is an open source web conferencing system for online learning.  The project’s goal is to enable teachers to provide remote students a high-quality online learning experience.

# Overview

GreenLight is a super simple front-end for your BigBlueButton server.  At it's core, Green Light provides a minimalistic web-based interface that lets users
  
   * Create a meeting
   * Invite others to the meeting
   * Join a meeting

Furthermore, if you configure GreenLight to use either Gmail or Twitter for authentication, users can create recorded meetings and manage the recordings for their meetings.

The steps below cover how to use and install GreenLight on your BigBlueButton server. 

# The quickest way to create a meeting

To start a new meeting, simply enter a meeting name - such as “New Meeting” - and GreenLight shows you two options: **Invite**  and **Start**.


![greenlight-start](/images/gl-start.png)

To **Invite** other users, share invite URL with others (click the copy icon to copy it to the clipboard).

To **Start** the meeting, click the `Start` button (blue of course).  GreenLight will then prompt for your name, after entering your name, click `Join`. You and anyone else invited will be in a BigBlueButton meeting, ready to collaborate.

![greenlight-join](/images/gl-join.png)

That’s it -- you can create as many meetings you want, as often as you want.   In the meeting  everyone is a moderator, which means anyone can make themselves the current presenter, upload a presentation, use the white board controls, and share his or her desktop.

After your finished, GreenLight remembers the previous meetings as well (GreenLight tries hard to reduce your typing).

![greenlight-previous](/images/gl-previous-meetings.png)


GreenLight makes it easy to have meetings, and it offers more capabilities if you login. 

# Create and manage recordings

When you login (using either your Gmail or Twitter account), GreenLight lets you create recorded meetings and manage the recordings.  

> How does GreenLight authentication work?  It uses a technology called `OAuth` that lets users authenticate with their Google or Twitter account and, if successful, GreenLight will create an account for them. token along with the user’s full name and (Google only) their email address.  

Invited users can’t join until you start the meeting
Once you have authenticated, any meetings you create are controlled and managed by yourself.  You can invite users as before, but this time invited users can’t join until you start the meeting.  In other words, no one can join your meetings until you do.


## You can record meetings

As moderator, you can record any segment of the meeting by pressing the Start/Stop Record button.

## Desktop notifications of users waiting to join

If you are using FireFox or Chrome, GreenLight will notify you when someone is waiting to join the meeting.

## Email notifications of finished recordings

After the meeting finishes, you will receive an e-mail notification when the recordings is ready.

## Manage visibility of recordings: Public, Unlisted, and Not Published

By default, all your recordings are “Unlisted”, which means that you (or anyone else you share this URL with) will be able to view the meeting.

You can change the visibility of recordings anytime.  They can be Public, Unlisted, and Not Published.

**Public** | **Unlisted** | **Not Published**
Everyone can view the recording URL at the meeting page. | Only users who have the recording URL can view it. |No one can view the recording.

## Delete recordings
You can delete a recording at anytime.

## Overview Video

We created the following video to give you an overview of how GreenLight works.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=yGX3JCv7OVM" target="_blank"><img src="/images/gl-video.png" 
alt="Installation Video Walkthrough" border="10" /></a>

# Installing GreenLight

To make it easy to install GreenLight on your BigBlueButton server, we’ve created a Docker image that contains everything to run it.  

By using Docker, you can easily install BigBlueButton on any server capable of running Docker, including the BigBlueButto server itself.  So you don’t need to setup a separate server, these instructions below cover installing it on a BigBlueButton 1.1-beta (or later) server.

And, thanks to Docker, it’s easy to upgrade GreenLight as well.

GreenLight is built as Ruby on Rails application, so, if you want to run it yourself, it will pretty much run anywhere you can run a rails application.  

These instructions show how to install GreenLight on your BigBlueButton server.

## Prerequisites

GreenLight requires BigBlueButton 1.1-beta (or later) that is configured with SSL.

To enable users to authenticate, GreenLight uses Google and Twitter as an OAuth provider.  While you don’t need to configure GreenLight for authentication, doing so will give users the ability to have recorded meetings.

Prerequisite checklist
  * A Google Account
  * A Twitter Account
  * A BigBlueButton 1.1-beta (or later) server configured with SSL

Having a Google account will enable you to request a client ID and client secret from Google’s API console to allow GreenLight to enable users to login with their (not yours) Google account.  It’s a similar configuration for a Twitter account.

We’ll use the Google account to configure GreenLight to send out e-mails to authenticated users when their recordings are ready.

## 1. Install Docker

To install GreenLight, run all the commands that follow as `root` on your BigBlueButton 1.1-beta (or later) server.

First, you need to install Docker on your Ubuntu 16.04 server running BigBlueButton.  The Docker documentation is the best resource (it’s pretty quick to install).

   https://docs.docker.com/engine/installation/linux/ubuntu/ 

To ensure you have docker installed correctly run the command to check the version (it should be at least 1.13.1).

~~~
# docker version
Client:
 Version:      1.13.1
 API version:  1.26
 Go version:   go1.7.5
 Git commit:   092cba3
 Built:        Wed Feb  8 06:50:14 2017
 OS/Arch:      linux/amd64

Server:
 Version:      1.13.1
 API version:  1.26 (minimum version 1.12)
 Go version:   go1.7.5
 Git commit:   092cba3
 Built:        Wed Feb  8 06:50:14 2017
 OS/Arch:      linux/amd64
 Experimental: false
~~~

## 2. Install GreenLight

First, let's setup a directory for running GreenLight (run all commands in this section as root). 

~~~
# mkdir ~/greenlight
# cd ~/greenlight
# docker run --rm bigbluebutton/greenlight cat ./env > env
~~~

The above command will download the latest version of GreenLight and setup a template file for you to modify.

### Generate Secret Key

Run the following command to generate a secret key

~~~
# docker run --rm bigbluebutton/greenlight rake secret
~~~

Edit the `env` file and add the contents of secret key.  After you edit, it should look like the following (replace `<secret>` with the output from the above command).

~~~
# Step 1 - Create a secret key for rails
#
# You can generate a secure one through the Greenlight docker image
# with with the command
#
#   docker run --rm bigbluebutton/greenlight rake secret
#
SECRET_KEY_BASE=<secret>
~~~

### Enter BigBlueButton Credentials

Next, enter the command

~~~
# bbb-conf --secret

       URL: https://demo.bigbluebutton.org/bigbluebutton/
    Secret: <secret>
~~~

which outputs the URL and shared Secret for your BigBlueButton server.  Of course, your server will be different than demo.bigbluebutton.org and your <secret> will be a long string of characters.

Enter these values into the `env` file.  It should look something like below

~~~
# Step 2 - Enter credentials for your BigBlueButton Server
#
# The endpoint and secret from your bigbluebutton server.  To get these values, run
# the following command on your BigBlueButton server
#
#    bbb-conf --secret
#
# and uncomment the following two variables
BIGBLUEBUTTON_ENDPOINT=https://<hostname>/bigbluebutton/
BIGBLUEBUTTON_SECRET=<secret>
~~~

Save the changes to `env` file.

### Run GreenLight Server

Using Docker you can start your server with the following command

~~~
# cd ~/greenlight
# docker run -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file env --name greenlight bigbluebutton/greenlight
~~~

>  For more information on docker commands take a look at [https://docs.docker.com/engine/reference/commandline/docker/](https://docs.docker.com/engine/reference/commandline/docker/). 

GreenLight uses nginx to forward request on `<hostname>/b` to port 5000 locally.  To configure nginx, enter the following command

~~~
# docker run --rm bigbluebutton/greenlight cat ./scripts/greenlight.nginx > /etc/bigbluebutton/nginx/greenlight.nginx
~~~

Next, restart nginx to have it read the new configuration file.

~~~
# systemctl restart nginx
~~~

After restart, you can access GreenLight without specifying the port like

>  `https://<hostname>/b`

If you would like to have GreenLight become the default application, add the following entry to `/etc/nginx/sites-available/bigbluebutton`

~~~
     location = / {
       return 301 /b;
     }
~~~

And restart nginx once more

~~~
# systemctl restart nginx
~~~

GreenLight is now the default landing page of your server

>   `https://<hostname>/`

## 3. Configure OAuth2

You only need to configure (at least) one OAuth provider to use authenticated meetings. GreenLight supports Google and Twitter.

### Google
You can use your own Google account, but since GreenLight will use this account for sending out emails, you may want to create a Google account related to the hostname of your BigBlueButton server.  For example, if your BigBlueButton server is called `example.myserver.com`, you may want to create a Google account called `greenlight_notifications_myserver`.

You need a Google account to create an OAuth 2 `CLIENT_ID` and `SECRET`.  The will enable users of GreenLight to authenticate with their own Google account (not yours).

Login to your Google account, and click the following link
  
  https://console.developers.google.com/

If you want to see the documentation behind OAuth2 at Google, click the link https://developers.google.com/identity/protocols/OAuth2.

First, enable the “Google+ API”.  

   1. Click Dashboard
   1. Click ‘+Enable APIs”
   1. Click “Google+ API”
   1. Click “Enable”
   1. Click “Credentials”

 Next, 

  1. Click “Create credentials
  1. Select “OAuth client ID
  1. Select “Web application”
  1. Under “Authorized redirect URIs” enter “http://<hostname>/b/auth/google/callback”
  1. Click “Create”

A window should open with your OAuth credentials


Add the client ID and client secret to the env file so it resembles the following (your credentials will be different).

~~~
GOOGLE_OAUTH2_ID=1093993040802-jjs03khpdl4dfasffq7hj6ansct5.apps.googleusercontent.com
GOOGLE_OAUTH2_SECRET=KLlBNy_b9pvBGasf7d5Wrcq
~~~

### Twitter

You need a Twitter account to create an OAuth 2 client ID and client secret. The will enable users of GreenLight to authenticate with their own Twitter account (not yours).

Login to your Twitter account, and click the following link: [https://apps.twitter.com/](https://apps.twitter.com/).

Next,

  1. Click “Create New App”
  1. Under “Callback URL” enter “http://<hostname>/b/auth/twitter/callback”
  1. Click “Create your Twitter application”
  1. Click “Keys and Access Tokens” tab

You should see a key and secret

Add the client id and client secret to the env file (your values will be different)

~~~
TWITTER_ID=SOj8AkIdeqJuP2asfbbGSBk0
TWITTER_SECRET=elxXJZqPVexBFf9ZJsafd4UTSzpr5AVmcH7Si5JzeHQ9th
~~~

If your server is still running you will need to recreate the container for changes to take effect.

See [Applying env File Changes]() section to enable your new configuration.

Once an OAuth provider is configured GreenLight will allow users to login and use authenticated meetings.

# Finishing Steps

## Applying env File Changes

To apply env file changes you must recreate the container running your Greenlight application.

Stop the currently running Greenlight instance:

~~~
# docker stop greenlight
# docker rm greenlight
~~~

Then use the same command to start the server

~~~
# docker run -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file env --name greenlight bigbluebutton/greenlight
~~~


## Configuring email notifications

There are three parts to configuring email notifications:

  * Add notify script to BigBlueButton
  * Configure the Greenlight mailer
  * Enable the publish callback script

### Add notify script to BigBlueButton
First, the script requires 2 dependencies `jwt` and `java_properties`.

~~~
# gem install jwt java_properties
~~~

Next, run the following command to install the callback script into BigBlueButton.

~~~
## docker run --rm bigbluebutton/greenlight cat ./scripts/greenlight_recording_notify.rb > /usr/local/bigbluebutton/core/scripts/post_publish/greenlight_recording_notify.rb
~~~

BigBlueButton will now execute this script at the end of processing each recording.


### Configure the GreenLight Mailer

To configure the mailer you will need to look up your email’s SMTP settings and enter the following to the env file:

~~~
GREENLIGHT_DOMAIN
SMTP_FROM
SMTP_SERVER
SMTP_PORT
SMTP_DOMAIN
SMTP_USERNAME
SMTP_PASSWORD
~~~

For a gmail account it would look something like

~~~
GREENLIGHT_DOMAIN=<domain>
SMTP_FROM=<gmail email address>
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_DOMAIN=gmail.com
SMTP_USERNAME=<gmail email address>
SMTP_PASSWORD=<gmail email password>
~~~

### Enable callback for email notifications

In the env file set

~~~
GREENLIGHT_USE_WEBHOOKS=true
GREENLIGHT_MAIL_NOTIFICATIONS=true
~~~

See [Applying env file changes](l#applying-env-file-changes) to apply the new changes


## Automatically start GreenLight on boot

Run the following command

~~~
# docker -n greenlight run -d -p 5000:80 --restart=unless-stopped -v $(pwd)/db/production:/usr/src/app/db/production --env-file env --name greenlight bigbluebutton/greenlight
~~~

## Updating Greenlight To A New Version

To download the latest greenlight image, do the following command:

~~~
# docker pull bigbluebutton/greenlight
~~~

To stop currently running Greenlight instance:

~~~
# docker stop greenlight
# docker rm greenlight
~~~

Then use the same command to start the server

~~~
# docker run -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file env --name greenlight bigbluebutton/greenlight
~~~