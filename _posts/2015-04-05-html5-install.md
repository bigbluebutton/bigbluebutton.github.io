---
layout: page
title: "Install"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---


# Overview 

This document covers how to install the latest build of the BigBlueButton HTML5 client.


## Before you install

The BigBlueButton HTML5 client runs on BigBlueButton 2.0-beta server (referred hereafter as simply BigBlueButton 2.0).  Before setting up the HTML5 client, first setup a [BigBlueButton 2.0-beta server](/2.0/20install.html).  

As the HTML5 client is still under active develoipment we do not recommend it for production use.  

# Instal Installation

The first step is to in stall mongodb.  

~~~
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
$ echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
$ sudo apt-get update
$ sudo apt-get install -y mongodb-org curl
$ sudo service mongod start
~~~

Next, install the nodeJS server.

~~~
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get install -y nodejs
~~~

You need only install mongodb and nodeJS once.  Once these steps are done, you can install the BigBlueButton HTML5 client with a single command.

~~~
sudo apt-get install -y bbb-html5
~~~

As we update the BigBlueButton HTML5 client, you'll be able to update it along along with other components with the standard

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

The BigBlueButton configuration tool `bbb-conf` will automatically restart the components for the HTML5 client when you perform `bbb-conf --restart` or `bbb-conf --clean`.

If you want to manually restart (or stop) it you can do so with the command

~~~
$ sudo systemctl restart bbb-html5.service
~~~

The logs for the component are located at `/var/log/bigbluebutton/html5/html5client.log` and the code for the client can be found at `/usr/share/meteor/bundle/`.

The configuration files for the client are located at `/usr/share/meteor/bundle/programs/server/assets/app/config`. If you modify them, you will need to restart bbb-html5.service for the new configuration to take effect.

Later on if you wish to remove the HTML5 client, you can enter the command

~~~
$ sudo apt-get purge bbb-html5
~~~


## Localization

You can contribute to the localization of the HTML5 client. The method is the same as in the Flash client - by using Transifex. For more information, please visit [the localization page](/dev/localization.html). The Transifex project is titled "BigBlueButton HTML5".

## Join the Community

If you have any questions or feedback, please join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post them to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  We look forward to hearing from you.

## Accessibility

We designed the BigBlueButton HTML5 client to be accessible to as many users as possible regardless of any underlying disability. Screen reader compatibility has been provided for two of the most popular and widely used software solutions currently on the market.
 
  * NVDA (Open Source Software)
  * JAWS (Paid Software)

Keyboard support has also been provided so that users can interact with all interactable elements of the client via keyboard only.

#### Keyboard Example : Send a Public message when client first loads

* Close audio modal
  1. Tab
  2. Enter
* Open users pane
  1. Tab
  2. Enter
* Focus messages list
  1. Shift + Tab (x2)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Focus message input
  1. Tab (x6)
* Send message
  1. Type message
  2. Enter


### NVDA 

Common Navigation Shortcut keys: 

b - next button
k - next link
h - next heading
f - next form field
d - next landmark
NVDA shortcuts resource

***Note: NVDA works best with Mozilla FireFox and users must toggle focus mode off by pressing the ESC key or NVDAKEY + Spacebar to switch to Browse mode.***

#### NVDA Example : Send a Public message when client first loads 

* Close audio modal
  1. Tab
  2. Enter
* Open users pane
  1. Enter
* Focus messages list
  1. Shift + D (x2)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Focus message input
  1. ‘f’ key (x2)
  2. NDVA + spacebar
* Send message
  1. Type message
  2. Enter
  3. NDVA + spacebar


### JAWS

Common Navigation Shortcut keys:

JAWS shortcuts resource

***Note: JAWS users must ensure that cursor mode is toggled off by pressing JAWSKEY + z, in order to interact with users in the userlist. By default, the JAWSKEY is set to the insert key on the keyboard.***

#### JAWS Example : Send a Public message when client first loads

* Close audio modal
  1. JAWSKEY + z
  2. Tab
  3. Spacebar
* Open users pane
  1. Tab (x2)
  2. Space
* Focus messages list
  1. Shift + Tab (x3)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Focus message input
  1. JAWSKEY + z
  2. Tab
  3. ‘f’ key (x2)
  4. Enter
* Send message
  1. Type message
  2. Enter
