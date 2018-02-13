---
layout: page
title: "Install"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---

# Overview 

This document covers how to install the latest developer build of the BigBlueButton HTML5 client.  See also [Overview](html/html5-overview.html) and [Design](/html/html5-design.html) of the HTML5 client.

As the HTML5 client is still under active development.  As such, we do not recommend it for production use.  You can try the latest version of the HTML5 client at [https://test.bigbluebutton.org/](https://test.bigbluebutton.org/).


# Before you install

Before installing the HTML5 client you need an [BigBlueButton 2.0-beta server](/2.0/20install.html) (referred hereafter as simply BigBlueButton 2.0).  All the development of the HTML5 client now occurs on the 2.0 code base.

To ensure you have the latest version of BigBlueButton 2.0, do

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

# Installation

## 1. Install MongDB and NodeJS

BigBlueButton HTML5 client uses mongodb, a very efficent database, to keep the user synchronized with the current meeting state.  To install MongoDB, do the following 

~~~
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
$ echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
$ sudo apt-get update
$ sudo apt-get install -y mongodb-org curl
$ sudo service mongod start
~~~

Next, the HTML5 client uses a nodeJS server to communicate with the BigBlueButton server.  

Note: If you were running an earlier version of the HTML5 client and have nodejs 4.x or nodejs 6.x installed (to check do `dpkg -l | grep nodejs`), uninstall the node 4.x packges before proceeding.

To install nodejs, do the following

~~~
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
~~~

You need only install mongodb and nodeJS once.  


## 2. Install HTML5 client

To install the HTML5 client, enter 

~~~
sudo apt-get install -y bbb-html5
~~~

After the installation finishes, restart your BigBlueButton server with the command

~~~
sudo bbb-conf --restart
~~~

As we publish updates to the HTML5 client (which is under active development) you can upgrade to the latest version with the commands

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

The HTML5 client uses the kurento media server to send/receive WebRTC video streams.  If your installing on a BigBlueButton server behind network address translation (NAT), you need to give kurento access to a STUN server (which stans for Session Traversal of UDP through NAT).  A STUN server will help Kurento determine its external address when behind NAT.

You'll find a list of publically available STUN servers at the [kurento documentation](http://doc-kurento.readthedocs.io/en/stable/installation_guide.html#stun-and-turn-servers).  

To configure Kurento to use a STUN server from the above list, you need to edit `/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini`.  Here's the default configuration.

~~~
# cat /etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini
; Only IP address are supported, not domain names for addresses
; You have to find a valid stun server. You can check if it works
; usin this tool:
;   http://webrtc.github.io/samples/src/content/peerconnection/trickle-ice/
; stunServerAddress=<serverAddress>
; stunServerPort=<serverPort>

; turnURL gives the necessary info to configure TURN for WebRTC.
;    'address' must be an IP (not a domain).
;    'transport' is optional (UDP by default).
; turnURL=user:password@address:port(?transport=[udp|tcp|tls])

;pemCertificate is deprecated. Please use pemCertificateRSA instead
;pemCertificate=<path>
;pemCertificateRSA=<path>
;pemCertificateECDSA=<path>
~~~

For example, to use the STUN server at 74.125.204.127 with port 19302, change the values for `stunServerAddress` and `stunServerPort` as follows.

~~~
stunServerAddress=74.125.204.127
stunServerPort=19302
~~~

Save your changes, then restart BigBlueButton with the command:

~~~
sudo bbb-conf --restart
~~~

## 3. Loading the HTML5 client

To try out the HTML5 client, access your BigBlueButton server with an Android device (phone or tablet), or iOS device (iPhone or iPad) running iOS 11 (you need iOS 11 to have support for WebRTC audio).   The HTML5 client runs alongside the Flash client, so after you join with your mobile device join the with your web browser and try uploading slides and moving around.  You'll see the updates come through to the HTML5 client running on your mobile device.

The HTML5 client also runs within Chrome, FireFox, or Safari 11 on the desktop. These browser support WebRTC for audio.

To try the HTML5 client on the desktop, install the [API demos](/install/install.html#install-api-demos-optional) and then join the Demo Meeting via the URL `https://<your_server>/demo/demoHTML5.jsp`.  

You can do this on the test.bigbluebutton.org server via the URL [https://test.bigbluebutton.org/demo/demoHTML5.jsp](https://test.bigbluebutton.org/demo/demoHTML5.jsp).

<p align="center">
  <img src="/images/20html5-demo.png"/>
</p><br>


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

# After you install

## Development

The HTML5 client for BigBlueButton is a very active project.  If you want to join the development effort, see [development of HTML5 client](/html/html5-dev.html).

## Localization

You can contribute to the localization of the HTML5 client. The method is the same as in the Flash client - by using Transifex. For more information, please visit [the localization page](/dev/localization.html). The Transifex project is titled "BigBlueButton HTML5".

## Join the Community

If you have any questions or feedback, join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  

We look forward to hearing from you.

