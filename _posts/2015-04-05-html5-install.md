---
layout: page
title: "Install"
category: html
redirect_from: "/labs/html5-overview"
date: 2015-04-05 11:41:36
order: 1
---

# Overview 

This document covers how to install/update the latest developer build of the BigBlueButton HTML5 client.  See also [Overview](/html/html5-overview.html) and [Design](/html/html5-design.html) of the HTML5 client.

As the HTML5 client is still under active development.  As such, we do not recommend it for production use.  You can try the latest version of the HTML5 client at [https://test.bigbluebutton.org/](https://test.bigbluebutton.org/).

Before installing the HTML5 client you need an [BigBlueButton 2.0-beta server](/2.0/20install.html) (referred hereafter as simply BigBlueButton 2.0).  All the development of the HTML5 client now occurs on the 2.0 code base.

# Upgrade options


## Single Command

If you have a  BigBlueButton 2.0 server, you can install/upgrade to the latest version of the HTML5 client with a single command, see [bbb-install.sh](https://github.com/bigbluebutton/bbb-install).


## Manual Upgrade

If you have a BigBlueButton 2.0 server with an earlier version of the HTML5 client installed, follow the steps below.  First, do a general update.  *Note:  We changed some of the package names (kms-server-6.0 to kms-server), this will actually uninstall some of the existing packages (due to missing dependencies).* After

~~~
sudo apt-get update
sudo apt-get dist-upgrade
~~~

As stated above, this will actually remove some older HTML5 packages -- you'll see the message.

~~~
The following packages will be REMOVED:
  bbb-html5 bbb-webrtc-sfu kms-core-6.0 kms-elements-6.0 kms-filters-6.0 kurento-media-server-6.0
~~~

Enter 'Y' to continue.  After the upgrade runs, you can run `sudo apt-get install bbb-html5` to install the new HTML5 packages.

~~~
sudo apt-get install bbb-html5
~~~

and then remove the older `kms-core-6.0` and `kms-elements-6.0` packages 

~~~
sudo apt-get purge kms-core-6.0 kms-elements-6.0 kurento-media-server-6.0
~~~

Also, check the contents of `/usr/local/bigbluebutton/bbb-webrtc-sfu/config/default.yml` for the entry for `kurentoUrl` (it is near the top).  If `kurentoUrl` has a `wss` in it, then 

~~~
  kurentoUrl: wss://<server_name>/kurento
~~~

then change it to the format

~~~
  kurentoUrl: ws://<server_name>:8888/kurento
~~~

and save the updated file.

As of BigBlueButton 2.0-RC5, the HTML5 client now uses Kurento for listen only.  First, set `enableListenOnly` to true in `/usr/share/meteor/bundle/programs/server/assets/app/config/settings-production.json`, as in

~~~
# cat /usr/share/meteor/bundle/programs/server/assets/app/config/settings-production.json | grep enableListenOnly
      "enableListenOnly": true
~~~

Next, edit `/usr/local/bigbluebutton/bbb-webrtc-sfu/config/default.yml` change the value to `ip` to match the external IP address of the server.  For example, if the server's external IP address is `203.0.113.1`, then edit this file so the value for `ip` is as follows

~~~
freeswitch:
    ip: '203.0.113.1'
    port: '5066'
~~~

Next, ensure that `/opt/freeswitch/etc/freeswitch/sip_profiles/external.xml` has entries for `ws-binding` and `wss-binding` for your external IP address.  For example, if the server's external IP address is `203.0.113.1`, then edit `external.xml` so the values for `ws-binding` and `wss-binding` are as follows

~~~
    <param name="ws-binding"   value="203.0.113.1:5066"/>
    <param name="wss-binding"  value="203.0.113.1:7443"/>
~~~

Next, ensure that `/opt/freeswitch/etc/freeswitch/sip_profiles/external.xml` has the value for `enable-3pcc` set to `proxy`, as in

~~~
  <param name="enable-3pcc" value="proxy"/>
~~~

Finally, run `sudo bbb-conf --setip <hostname/IP address>` to ensure all the components have the latest hostname/IP address.  For example, if your server had the hostname `bbb.myserver.com`, you would run

~~~
sudo bbb-conf --setip bbb.myserver.com
~~~

You can now test out the HTML5 client by going to `/demo/demoHTML5.jsp` (as in `https://bbb.myserver.com/demo/demoHTML5.jsp`).  If you need to install the API demos, enter

~~~
sudo apt-get install bbb-demo
~~~

The server should automatically load the HTML5 client when you access your server with an Android 6.0 or iOS 11+ client.  

# Step-by-Step Installation

## 1. Install MongDB and NodeJS

BigBlueButton HTML5 client uses mongodb, a very efficent database, to keep the user synchronized with the current meeting state.  To install MongoDB, do the following 

~~~
$ sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 0C49F3730359A14518585931BC711F9BA15703C6
$ echo "deb [ arch=amd64,arm64 ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.4.list
$ sudo apt-get update
$ sudo apt-get install -y mongodb-org curl
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

### Extra steps for SSL
If you have, or are going to have, HTTPS access to your server there is one extra line that needs to be changed to make the webcam and screenshare work with SSL.

Open `/usr/share/meteor/bundle/programs/server/assets/app/config/settings-production.json` editing and change:
```
"wsUrl": "ws://<server>/bbb-webrtc-sfu",
```
to
```
"wsUrl": "wss://<server>/bbb-webrtc-sfu",
```

Restart BigBlueButton with `sudo bbb-conf --restart` so that the change will take effect.

### Extra steps when server is behind NAT
The HTML5 client uses the kurento media server to send/receive WebRTC video streams.  If you are installing on a BigBlueButton server behind network address translation (NAT), you need to give kurento access to a STUN server (which stans for Session Traversal of UDP through NAT).  A STUN server will help Kurento determine its external address when behind NAT.

You'll find a list of publicly available STUN servers at the [kurento documentation](https://kurento.readthedocs.io/en/stable/doc/admin_guide.html#installation).  

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

For example, to use the STUN server at 64.233.177.127 with port 19302, change the values for `stunServerAddress` and `stunServerPort` as follows.

~~~
stunServerAddress=64.233.177.127
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

The logs for the component can be seen/followed using `journalctl -f -u bbb-html5.service` and the code for the client can be found at `/usr/share/meteor/bundle/`.

The configuration files for the [packaged] client are located at `/usr/share/meteor/bundle/programs/server/assets/app/config/settings-production.json`. If you modify the file, you will need to restart bbb-html5.service for the new configuration to take effect.

Later on if you wish to remove the HTML5 client, you can enter the command

~~~
$ sudo apt-get purge bbb-html5
~~~

# After you install

## Creating an extension for Chrome to share your screen

The HTML5 client uses WebRTC to enable the presenter to share the screen.  While FireFox enables the presenter to share their screen directly, Chrome requires the presenter have installed a Chrome extension (that contains a small bit of JavaScript) to whitelist the target BigBlueButton server.

To create the chrome extension, fork the code at [screenshare-chrome-extension](https://github.com/bigbluebutton/screenshare-chrome-extension), modify the `manifest.json` so it points to the hostname for your BigBlueButton server, and upload it to the Google Chrome store.  See the README.md file in the above repository for details. 


## Making the HTML5 client default

If you want, you can configure your BigBlueButton server to make the HTML5 client the default client.  To do this, edit `/var/lib/tomcat7/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties` and set the values for `attendeesJoinViaHTML5Client` and `moderatorsJoinViaHTML5Client` to true, as in

~~~
# Force all attendees to join the meeting using the HTML5 client
attendeesJoinViaHTML5Client=true

# Force all moderators to join the meeting using the HTML5 client
moderatorsJoinViaHTML5Client=true
~~~

Restart BigBlueButton with `sudo bbb-conf --restart` and then join from your front-end.  You should automatically join with the HTML5 client.


## Development

The HTML5 client for BigBlueButton is a very active project.  If you want to join the development effort, see [development of HTML5 client](/html/html5-dev.html).

## Localization

You can contribute to the localization of the HTML5 client. The method is the same as in the Flash client - by using Transifex. For more information, please visit [the localization page](/dev/localization.html). The Transifex project is titled "BigBlueButton HTML5".

## Customization

The HTML5 client can be customized in several ways

### Modify the existing configuration

You can find the configurations file for the HTML5 packaged client in `/usr/share/meteor/bundle/programs/server/assets/app/config/settings-production.json`. If you modify the file you will need to restart the server side component before your changes are applied: `sudo systemctl restart bbb-html5`

Some commonly modified parameters include:

`chromeExtensionKey` and `chromeExtensionLink` - this is where you specify the Google Chrome extension key for screensharing as described in [the documentation for creating Screenshare Extension](https://github.com/bigbluebutton/screenshare-chrome-extension#to-configure-your-html5-client).

`enableScreensharing` and `enableVideo` control the functionality for sharing/viewing WebRTC screenshare and webcams.

`log.level` controls the level of logging for the server application - you can set it to 'debug' or 'info' if you need more information or 'error' or 'warn' in case you want to limit logging and optimize the speed of the application.

`autoJoin`, `listenOnlyMode`, `forceListenOnly` and `skipCheck` control the audio participation of users in the HTML5 client in the same way they do in the Flash client:

`"autoJoin": true` means we want to display the microphone vs listen only choice immediately after login

`"listenOnlyMode": false` - do not allow joining as listen only

`"forceListenOnly": true` - do not allow full audio for attendees (note this requires `"listenOnlyMode": true`)

`"skipCheck": true` skips echo test when joining full audio

### Branding

The HTML5 client has an area for a custom logo in the upper left-hand corner. To display your logo first you should enable the display of this branding area by editing `displayBrandingArea` to be `true` in the configuration file for HTML5 client (see the section above on how to modify the existing configuration). The URL used for the logo should be passed as a parameter on the create meeting call `customLogoURL=https://your.logo.png`

### Pass in meta parameters

The HTML5 client functionality and looks can be modified by passing meta parameters when creating the BigBlueButton meeting. The currently supported meta parameters are as follows:

`html5autoswaplayout`: `true` -- loads the client with presentation and webcam areas swapped

`html5autosharewebcam`: `true` -- requests access for webcam and initiates its sharing as soon as the client is finished loading

`html5hidepresentation`: `true` -- hides the presentation area so that webcams display take over the focus of the whole view

## Join the Community

If you have any questions or feedback, join [the BigBlueButton community](https://bigbluebutton.org/support/community/) and post to the [bigbluebutton-dev](https://groups.google.com/forum/#!forum/bigbluebutton-dev) mailing list.  

We look forward to hearing from you.

