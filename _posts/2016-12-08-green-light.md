---
layout: page
title: "GreenLight"
category: "install"
date: 2016-12-08 16:29:25
---

BigBlueButton is an open source web conferencing system for online learning.  The project’s goal is to enable teachers to provide remote students anywhere in the world a high-quality online learning experience.

# Overview

GreenLight is a super simple front-end for your BigBlueButton server.  At its core, Green Light provides a minimalistic web-based interface that lets users

   * Create a meeting
   * Invite others to the meeting
   * Join a meeting

Furthermore, if you configure GreenLight to use either Gmail or Twitter for authentication, users can login and record meetings and manage the recordings.

The steps below cover how to use and install GreenLight on your BigBlueButton server.

# The quickest way to create a meeting

From the user's perspective, to start a new meeting, simply enter a meeting name - such as "New Meeting" - and GreenLight shows you two options: **Invite**  and **Start**.


![greenlight-start](/images/gl-start.png)

To **Invite** other users, GreenLight gives you a uniform resource locater (URL) that you can share with others.  Clicking the copy button below the URL copies it to the clipboard; clicking the mail button opens your default email client with the URL in the body.

To **Start** the meeting, click the `Start` button (blue of course).  GreenLight will then prompt for your name and, after entering your name, click `Join`. You will then join the meeting along with anyone else who received the invite URL.

![greenlight-join](/images/gl-join.png)

That’s it -- you can create as many meetings you want, as often as you want.   In the meeting  everyone is a moderator, which means anyone can make themselves the current presenter, upload a presentation, use the white board controls, and share his or her desktop.

After your leave the meeting, GreenLight remembers the previous names so you can click the name instead of typing it again (GreenLight tries hard to reduce your typing).

![greenlight-previous](/images/gl-previous-meetings.png)


GreenLight offers more capabilities if you login (see next section).

# Create and manage recordings

When you login using either your Google or Twitter account, GreenLight lets you create recorded meetings and manage the recordings.

> How does GreenLight's authentication work?  It uses a technology called `OAuth` that first has users authenticate with either their Google or Twitter account and, if successful, GreenLight will receive an authentication token with very limited information.  In the case of Twitter, this is only the users name.  In the case of Google, it's the users name and Gmail address.  GreenLight can then use the Gmail address to send out e-mail notifications of when a recording is ready.

When you login to GreenLight, your personal meetings operate differently than a general meeting:

  * users with the invite URL can’t join until you start the meeting, and
  * only you are the moderator (everyone else is a viewer).

In other words, with your personal meetings, no one can join your meetings until you do.


## You can record meetings

As moderator, you can record any segment of the meeting by pressing the Start/Stop Record button.  You can press the Start/Stop Record button multiple times during the meeting to mark multiple segments for recording.  After the meeting finishes, BigBlueButton will create a single playback file of all segments.

## Desktop notifications of users waiting to join

If you are using FireFox or Chrome, GreenLight will notify you on the desktop (outside the browser) when someone is waiting to join your personal meeting.

## Realtime updates on active meetings
Not only does GreenLight keep track of your previous meetings, it also lets you know when they are active, along with how many users and moderators are currently in them.

![greenlight-active-meetings](/images/gl-active-meetings.png)

## Email notifications of finished recordings

After a meeting finishes, you will receive an e-mail notification when the recordings is ready.

![greenlight-recording-ready-email](/images/gl-recording-ready-email.png)

## Manage visibility of recordings: Public, Unlisted, and Not Published

By default, all your recordings are "Unlisted", which means that GreenLight will not show other users the recording URL.  Only you, or anyone else you share this URL with, will be able to view the recording.

You can change the visibility of recordings anytime within GreenLight (you need to be logged in to do this).  A recording can be one of three states: Public, Unlisted, and Not Published.

**Public** | **Unlisted** | **Not Published**
Everyone can view the recording URL at the meeting page. | Only users who have the recording URL can view it. |No one can view the recording.

## Share recordings
You can use the share button to share your recordings via email or upload to [Youtube](www.youtube.com) (provided they have a video component).

![greenlight-youtube-upload](/images/gl-youtube-upload.png)

## Delete recordings
You can delete a recording at anytime.

## Overview Video

We created the following video to give you an overview of how GreenLight works.

<a href="http://www.youtube.com/watch?feature=player_embedded&v=yGX3JCv7OVM" target="_blank"><img src="/images/gl-video.png"
alt="Installation Video Walkthrough" border="10" /></a>

# Installing GreenLight

To make it easy to install GreenLight on your BigBlueButton 1,1 (or later) server, we’ve created a Docker image that encapsulates everything into a single container.

GreenLight is built as Ruby on Rails application.  If you don't want to use the Docker image and, instead, run it from source, see the steps at [https://github.com/bigbluebutton/greenlight](https://github.com/bigbluebutton/greenlight).

These instructions show how to install GreenLight on your BigBlueButton 1.1 (or later) server using Docker.

## Prerequisites

Before you install, you need the following

  * BigBlueButton 1.1 (or later) server
  * The BigBlueButton server has been configure with a fully qualified hostname with valid SSL certificate

While you don’t need to configure GreenLight for authentication, if you do it will enable users to have recorded meetings and manage the meetings.  To setup GreenLight for authentication, you need

  * A Google Account
  * A Twitter Account
  * A BigBlueButton 1.1 (or later) server configured with SSL

Having a Google account will enable you to request a client ID and client secret from Google’s API console to allow GreenLight to enable users to login with their (not yours) Google account.  It’s a similar configuration for a Twitter account.

Also, configuring authentication with a Google account will enable GreenLight to send out e-mails when recordings are ready.

## 1. Install Docker

Run all the commands in section as `root` on your BigBlueButton 1.1 (or later) server.

First, you need to install Docker.  The Docker documentation is the best resource and for the latest steps.  To install Docker (recommend installing Docker CE unless you have a subscription to Docker EE), see [Instal Docker on Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/).

Once you have followed the installation steps for Docker, check you have the latest version using the following command (it you should see version 1.13.1 or later).

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

Next, setup directory for running GreenLight.

~~~
# mkdir ~/greenlight
# cd ~/greenlight
~~~

We need to create a template environment file for GreenLight that we can put in all the settings.  To both install GreenLight and create a template environment file (called `env`), run the following command:

~~~
# docker run --rm bigbluebutton/greenlight cat ./env > env
~~~


### Generate Secret Key

We're now going to configure GreenLight with the minimal settings to run. First, run the following command to generate a secret key.

~~~
# docker run --rm bigbluebutton/greenlight rake secret
~~~

Next, edit the `env` file and add assign the output for the above command to `SECRET_KEY_BASE`.  After you edit, it should look like the following (replace `<secret>` with the output from the above command).

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

## 3. Enter BigBlueButton Credentials

Next, we need to tell GreenLight how to connect to your BigBlueButton server and issue API commands.  Enter the command `bbb-conf --secret`.  For example, here's what the command looks like when running on `demo.bigbluebutton.org` (we've masked the shared secret).

~~~
# bbb-conf --secret

       URL: https://demo.bigbluebutton.org/bigbluebutton/
    Secret: <secret>
~~~

Of course, the URL for your BigBlueButton server will be different than demo.bigbluebutton.org and your secret will be a long string of characters.

Assign the values for `URL` and `Secret` to `BIGBLUEBUTTON_ENDPOINT` and  `BIGBLUEBUTTON_SECRET` in the `env` file.  It should look something like below

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

## 4. Install Webhooks on your BigBlueButton Server

Some of the features in GreenLight require webhooks to be installed on your BigBlueButton server.

To install webhooks, run the following command on your BigBlueButton server:

`# apt-get install bbb-webhooks`

You will also need to tell GreenLight that you have enabled webhooks on your BigBlueButton server. To do this, change the `GREENLIGHT_USE_WEBHOOKS` environment variable in your `env` file from `false` to `true`.

`GREENLIGHT_USE_WEBHOOKS=true`

## 5. Run GreenLight Server

Using Docker you can start your server with the following command

~~~
# cd ~/greenlight
# docker run -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file env --name greenlight bigbluebutton/greenlight
~~~

>  For more information on docker commands take a look at [https://docs.docker.com/engine/reference/commandline/docker/](https://docs.docker.com/engine/reference/commandline/docker/).

Before trying to access GreenLight, we'll setup nginx to forward request on `<hostname>:5000/b` to port 5000 locally.  To configure nginx, enter the following command

~~~
# docker run --rm bigbluebutton/greenlight cat ./scripts/greenlight.nginx | sudo tee  /etc/bigbluebutton/nginx/greenlight.nginx
~~~

And restart nginx to have it read the new configuration file.

~~~
# systemctl restart nginx
~~~

After restart, you can access GreenLight with `https://<hostname>/b`, where `<hostname>` is the hostname for your BigBlueButton server.

If you want to replace the default page on your BigBlueButton server with GreenLight, add the following entry to the bottom `/etc/nginx/sites-available/bigbluebutton` just before the last '}'.

~~~
     location = / {
       return 301 /b;
     }
~~~

And restart nginx once more

~~~
# systemctl restart nginx
~~~

GreenLight is now the default landing page of your server.


## 6. Configure OAuth2 (optional)

You only need to configure (at least) one OAuth provider to use authenticated meetings. GreenLight supports Google and Twitter.

### Google OAuth
You can use your own Google account, but since GreenLight will use this account for sending out emails, you may want to create a Google account related to the hostname of your BigBlueButton server.  For example, if your BigBlueButton server is called `example.myserver.com`, you may want to create a Google account called `greenlight_notifications_myserver`.

You need a Google account to create an OAuth 2 `CLIENT_ID` and `SECRET`.  The will enable users of GreenLight to authenticate with their own Google account (not yours).

Login to your Google account, and click the following link

  [https://console.developers.google.com/](https://console.developers.google.com/)

If you want to see the documentation behind OAuth2 at Google, click the link [https://developers.google.com/identity/protocols/OAuth2](https://developers.google.com/identity/protocols/OAuth2).

![greenlight-google-plus-api](/images/gl-google-plus-api.png)

First, enable the "Google+ API".

   1. Click Dashboard
   1. Click "+Enable APIs"
   1. Click "Google+ API"
   1. Click "Enable"
   1. Click "Credentials"

 Next,

  1. Click "Create credentials
  1. Select "OAuth client ID
  1. Select "Web application"
  1. Under "Authorized redirect URIs" enter "http://hostname/b/auth/google/callback" where hostname is your hostname
  1. Click "Create"

A window should open with your OAuth credentials. In this window, copy client ID and client secret to the `env` file so it resembles the following (your credentials will be different).

~~~
GOOGLE_OAUTH2_ID=1093993040802-jjs03khpdl4dfasffq7hj6ansct5.apps.googleusercontent.com
GOOGLE_OAUTH2_SECRET=KLlBNy_b9pvBGasf7d5Wrcq
~~~

The `GOOGLE_OAUTH2_HD` environment varaible is optional and can be used to restrict Google authentication to a specific Google Apps hosted domain.

~~~
GOOGLE_OAUTH2_HD=example.com
~~~

### Twitter OAuth

You need a Twitter account to create an OAuth 2 client ID and client secret. The will enable users of GreenLight to authenticate with their own Twitter account (not yours).

Login to your Twitter account, and click the following link: [https://apps.twitter.com/](https://apps.twitter.com/).

Next,

  1. Click "Create New App"
  1. Under "Callback URL" enter "http://hostname/b/auth/twitter/callback" where hostname is your hostname
  1. Click "Create your Twitter application"
  1. Click "Keys and Access Tokens" tab

You should see a key and secret.  Add the `client id` and `client secret` to the `env` file (your values will be different)

~~~
TWITTER_ID=SOj8AkIdeqJuP2asfbbGSBk0
TWITTER_SECRET=elxXJZqPVexBFf9ZJsafd4UTSzpr5AVmcH7Si5JzeHQ9th
~~~

### LDAP OAuth

GreenLight is able to authenticate users using an external LDAP server. To connect GreenLight to an LDAP server, you will have to provide values for the environment variables under the 'LDAP Login Provider' section in the `env` file. You need to provide all of the values for LDAP authentication to work correctly.

> `LDAP_SERVER` is the server host.

> `LDAP_PORT` is the server port (commonly 389).

> `LDAP_METHOD` is the authentication method, either 'plain' (default), 'ssl' or 'tls'.

> `LDAP_UID` is the name of the attribute that contains the user id. For example, OpenLDAP uses 'uid'.

> `LDAP_BASE` is the location to look up users.

> `LDAP_BIND_DN` is the default account to use for user lookup.

> `LDAP_PASSWORD` is the password for the account to perform user lookup.

Here are some example settings using an [OpenLDAP](http://www.openldap.org/) server.

~~~
LDAP_SERVER=host
LDAP_PORT=389
LDAP_METHOD=plain
LDAP_UID=uid
LDAP_BASE='dc=example,dc=org'
LDAP_BIND_DN='cn=admin,dc=example,dc=org'
LDAP_PASSWORD=password
~~~

If your server is still running you will need to recreate the container for changes to take effect.

See [Applying env File Changes](#applying-env-file-changes) section to enable your new configuration.

Once an OAuth provider is configured GreenLight will allow users to login and use authenticated meetings.

## 7. Configuring email notifications (optional)

There are three steps to configuring email notifications:

  1. Add notify script to BigBlueButton
  1. Configure the Greenlight mailer
  1. Enable the publish callback script

### Add notify script to BigBlueButton
First, the script requires two gem dependencies `jwt` and `java_properties`.  To install these gems, run

~~~
# gem install jwt java_properties
~~~

Next, run the following command to install the callback script into BigBlueButton.

~~~
# docker run --rm bigbluebutton/greenlight cat ./scripts/greenlight_recording_notify.rb > /usr/local/bigbluebutton/core/scripts/post_publish/greenlight_recording_notify.rb
# chmod +x /usr/local/bigbluebutton/core/scripts/post_publish/greenlight_recording_notify.rb
~~~

BigBlueButton will now execute this script at the end of processing each recording.


### Configure the GreenLight to send emails

Using the Google account that you configured for OAuth 2 in section [Google OAuth](#google-oauth), edit `env` and apply the following settings.

~~~
GREENLIGHT_DOMAIN=<domain>
SMTP_FROM=<gmail_email_address>
SMTP_SERVER=smtp.gmail.com
SMTP_PORT=587
SMTP_DOMAIN=gmail.com
SMTP_USERNAME=<gmail_email_address>
SMTP_PASSWORD=<gmail_email_password>
~~~

Do the steps in [Applying env file changes](#applying-env-file-changes) to apply the new changes.

### Enable callback for email notifications

In the `env` file set

~~~
GREENLIGHT_USE_WEBHOOKS=true
GREENLIGHT_MAIL_NOTIFICATIONS=true
~~~

Do the steps in [Applying env file changes](#applying-env-file-changes) to apply the new changes.

## 8. Enabling uploading to Youtube (optional)

In order to allow users to upload their recordings to [Youtube](https://www.youtube.com/), you will need to configure GreenLight to work with Google OAuth2. To do this, see the section on [Google OAuth](#google-oauth).

Once you have GreenLight successfully authenticating users with OAuth2, you will need to enable the Youtube Data API within the [Google Developer Console](https://console.developers.google.com). This will allow GreenLight to ask users for permission to access their Youtube account (and upload recordings).

![greenlight-youtube-data-api](/images/gl-youtube-data-api.png)

In order to enable the Youtube Data API, you should follow these steps:

   1. Click Dashboard
   1. Click "+Enable APIs"
   1. Click "Youtube Data API"
   1. Click "Enable"
   1. Click "Credentials"

Users will be required to authenticate again in order to allow Youtube access. If a user attempts to upload a recording without access, GreenLight will prompt them to reauthenticate.

Lastly, you will also need to change the `ENABLE_YOUTUBE_UPLOADING` varaible in the `env` file from `false` to `true`. This will make sure GreenLight asks users for permission to access their Youtube accounts when authenticating.

## 9. Configuring Slack notifications (optional)

Enabling Slack notifications will allow GreenLight to send notifications to a Slack channel (or user) when:

  1. A recording is published/unpublished.
  1. A user joins a meeting.
  1. A meeting ends.

### Registering your Slack Webhook

Follow the steps below to register your Slack Webhook:

  1. Go to [https://slack.com/apps/A0F7XDUAZ-incoming-webhooks](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks).
  1. Select your team and click 'Configure'.
  1. Choose a channel, and select 'Add Incoming Webhooks Integration'.

### Enabling Slack notifications

To enable Slack notifications you will need to open your `env` file and insert values for the `SLACK_WEBHOOK` and `SLACK_CHANNEL` environment variables.

`SLACK_WEBHOOK` is the webhook you generated for your team on the [Slack website](https://slack.com/apps/A0F7XDUAZ-incoming-webhooks) (see above).

`SLACK_CHANNEL` is the channel you want the notifications to display to. Keep in mind, channels start with a # symbol (#channel_name). You can also send messages directly to a user with the @ symbol (@username). If you don't specify a channel, the messages will be sent to the channel you selected when registering your webhook.

Do the steps in [Applying env file changes](#applying-env-file-changes) to apply the new changes.

## 10. Configuring a custom background (optional)

By default, GreenLight will use a standard background for its landing image. If you would like to change this background, you can go into the `env` file and set the `LANDING_BACKGROUND` variable to a URL that points to an image. For best results, use a large image that takes up most of the screen (such as 1280 x 1024).

`LANDING_BACKGROUND=http://www.somewebsite.com/coolbackground.png`

It is important to note that users who have configured custom landing backgrounds on their account will not see the `LANDING_BACKGROUND`, but rather their own.

Do the steps in [Applying env file changes](#applying-env-file-changes) to apply the new changes.

# Administration


## Automatically start GreenLight on boot

To have GreenLight automatically restart when you star the host server, first stop and remove the existing container named 'greenlight':

~~~
# docker stop greenlight
# docker rm greenlight
~~~

and then run Greenlight with the following docker command

~~~
# docker run -d -p 5000:80 --restart=unless-stopped -v $(pwd)/db/production:/usr/src/app/db/production -v $(pwd)/assets:/usr/src/app/public/system --env-file env --name greenlight bigbluebutton/greenlight
~~~

The parameter `--restart=unless-stopped` will automatically restart the docker image when you restart the computer.

If you don't wish to save user content (such as custom landing images) locally on your sever, you can remove `-v $(pwd)/assets:/usr/src/app/public/system` from the command. They will then be saved in Greenlight's public directory within the docker container.

## Applying env File Changes

Whenever you update the `env` file and want to apply the changes to GreenLight, you must stop GreenLight, delete the container, and run it again.

To stop GreenLight and remove the existing container named 'greenlight', do the following:

~~~
# docker stop greenlight
# docker rm greenlight
~~~

Then use the same command to start the server

~~~
# docker run -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production -v $(pwd)/assets:/usr/src/app/public/system --env-file env --name greenlight bigbluebutton/greenlight
~~~


## Updating Greenlight to a new version

To update GreenLight to the latest docker image, do the following command:

~~~
# docker pull bigbluebutton/greenlight
~~~

To stop currently running Greenlight instance:

~~~
# docker stop greenlight
# docker rm greenlight
~~~

Then use the command to start the BigBlueButton server:

~~~
# docker run -d -p 5000:80 --restart=unless-stopped -v $(pwd)/db/production:/usr/src/app/db/production -v $(pwd)/assets:/usr/src/app/public/system --env-file env --name greenlight bigbluebutton/greenlight
~~~


## Disabling guest access

A user must login to GreenLight to access features such as meeting updates, preferences, recording management, and more. However, GreenLight will allow unauthenticated users to create meetings.

If you wish to disable guest access and only allow authenticated users to create meetings, you should uncomment and set the `DISABLE_GUEST_ACCESS` environment variable in the `env` file to `true`.

`DISABLE_GUEST_ACCESS=true`

This will **not** prevent unauthenticated users from joining meetings created by authenticated users if they have been given the invite URL.

Disabling guest access will also set a new landing page that welcomes the user to GreenLight, and prompts them to login.

Do the steps in [Applying env file changes](#applying-env-file-changes) to apply the new changes.

# Troubleshooting

## Logging

GreenLight logs to `log/production.log` within the docker container by default. This means that if you recreate your docker container, you will lose all of the logs. To prevent this, you can mount the log directory in the containter to a directory on your host machine. This will mirror the `production.log` file from within the container and save to the host machine instead.

To save logs to the host machine, you should include the following option when running GreenLight.
~~~
# -v $(pwd)/log:/usr/src/app/log
~~~

This makes the full run command:
~~~
# docker run -d -p 5000:80 --restart=unless-stopped -v $(pwd)/db/production:/usr/src/app/db/production -v $(pwd)/assets:/usr/src/app/public/system -v $(pwd)/log:/usr/src/app/log --env-file env --name greenlight bigbluebutton/greenlight
~~~

You can then find `production.log` at `~/greenlight/log`.

If you want to access logs within the docker container without mounting the log directory, you can enter to docker container to retrieve the logs using:

~~~
# docker exec -i -t greenlight /bin/bash
~~~

If you don't want GreenLight send logs to `log/production.log`, you can configure it to log to the console instead. To do this, you should comment out the `DISABLE_RAILS_LOG_TO_STDOUT` environment variable in the `env` file.

## Launching Greenlight in the Host Network

If you want to run GreenLight on the host network, you can edit the env file and add this line:

~~~
PORT=5000
~~~

Run this command:

~~~
# docker run -d -p 5000:5000 --restart=unless-stopped -v $(pwd)/db/production:/usr/src/app/db/production -v $(pwd)/assets:/usr/src/app/public/system --env-file env --name greenlight --network=host bigbluebutton/greenlight
~~~

## Check Greenlight configuration

To check Greenlight's configuration for connecting to a BigBlueButton server use the following command:

~~~
# docker run --rm --env-file env bigbluebutton/greenlight rake conf:check
~~~

To check Greenlight's mailer configuration use the following command and replace <your_email> with an email address to receive the test email.

~~~
# docker run --rm --env-file env bigbluebutton/greenlight rake conf:check_email['<your_email>']
~~~
