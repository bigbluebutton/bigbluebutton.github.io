---
layout: page
title: "WebRTC Screen Share"
category: "labs"
date: 2017-03-06 11:42:28
---


<style type="text/css">
pre
{
white-space: pre;
overflow-x: auto;
font-size: 0.85em;
font-family: Monaco,Menlo,Consolas,"Courier New",monospace;
}
</style>

## Overview

Note: This is still in development

## Prerequisites

### A BigBlueButton 1.1 server with HTTPS/SSL

[BigBlueButton setup](/install/install.html)

[Configuring HTTPS on BigBlueButton](/install/install.html#configuring-https-on-bigbluebutton)

you will need a non-root user account. We use the name `firstuser`. You will need to create the user account if you install from packages. If you set up a development environment you should already have it.

### Setting up FreeSWITCH to use SSL

Provided you have a domain name We can use letsencrypt certificates for free.

[Step by step instructions here](/install/install.html#using-lets-encrypt)

## Building the client

You may need to pull from from a separate branch for the latest code

If `ant` isn't installed you will need to install it. `sudo apt install ant`

Modify your `config.xml` to match below

```
<module name="ScreenshareModule"
  [...]
  tryWebRTCFirst="true"
  chromeExtensionLink="<extension_url>"
  chromeExtensionKey="<extension_key>"
  [...]
/>
```

If you are running a development environment, you will need to configure it to load via HTTPS [just like the packaged client was set up here](/install/install.html#configure-bigbluebutton-to-load-session-via-https)

Modify the command to enable HTTPS in your development `config.xml` file otherwise the modules will not load

`sed -e 's|http://|https://|g' -i ~/dev/bigbluebutton/bigbluebutton-client/src/conf/config.xml`

## Red5 video app

You will need to manually install the red5 app for webrtc deskshare video streams

`sudo apt install bbb-apps-video-broadcast`

### Configure FreeSWITCH

Create the following dialplan in `/opt/freeswitch/etc/freeswitch/dialplan/default/bbb_screenshare.xml`


```
<include>
    <extension name="bbb_screenshare">
      <condition field="destination_number" expression="^(\d{5}-SCREENSHARE)$">
        <action application="set" data="jitterbuffer_msec=20:400"/>
        <action application="answer"/>
        <action application="conference" data="${destination_number}@bbb-screenshare"/>
      </condition>
    </extension>
</include>

```

Then in a FreeSWITCH terminal (`/opt/freeswitch/bin/fs_cli`) run `reloadxml`

Make a backup of your wss.pem file in case

`sudo cp /opt/freeswitch/etc/freeswitch/tls/wss.pem /opt/freeswitch/etc/freeswitch/tls/wss.pem.BAK`

Now change directory to the LetsEncrypt directory for your website, for example 

```
/etc/letsencrypt/live/HOSTNAME/
```

Run the next command to set up SSL certificates for FreeSWITCH

```
cat cert.pem privkey.pem chain.pem > /opt/freeswitch/etc/freeswitch/tls/wss.pem
```

Restart the FreeSWITCH service `sudo service freeswitch restart`

## Configure BBB-Web bigbluebutton.properties

Verify that in `~/dev/bigbluebutton/bigbluebutton-web/grails-app/conf/bigbluebutton.properties`

```
# The server where FS will publish as RTMP stream
screenshareRtmpServer=[IP of your Red5 server]

# The Red5 app that receives the published RTMP stream
screenshareRtmpBroadcastApp=video-broadcast

# The suffix of our verto screenshare conference.
# Convention is {voiceConf}-SCREENSHARE
screenshareConfSuffix=-SCREENSHARE
```


## Disabling sound

Edit the file `/opt/freeswitch/conf/autoload_configs/conference.conf.xml` and add a new profile named `bbb-screenshare` with the following contents

```
<profile name="bbb-screenshare">
  <param name="domain" value="$${domain}"/>
  <param name="rate" value="48000"/>
  <param name="channels" value="2"/>
  <param name="interval" value="20"/>
  <param name="energy-level" value="200"/>
  <!-- <param name="tts-engine" value="flite"/> -->
  <!-- <param name="tts-voice" value="kal16"/> -->
  <!-- <param name="muted-sound" value="conference/conf-muted.wav"/>
  <param name="unmuted-sound" value="conference/conf-unmuted.wav"/>
  <param name="alone-sound" value="conference/conf-alone.wav"/>
  <param name="moh-sound" value="local_stream://stereo"/>
  <param name="enter-sound" value="tone_stream://%(200,0,500,600,700)"/>
  <param name="exit-sound" value="tone_stream://%(500,0,300,200,100,50,25)"/>
  <param name="kicked-sound" value="conference/conf-kicked.wav"/>
  <param name="locked-sound" value="conference/conf-locked.wav"/>
  <param name="is-locked-sound" value="conference/conf-is-locked.wav"/>
  <param name="is-unlocked-sound" value="conference/conf-is-unlocked.wav"/>
  <param name="pin-sound" value="conference/conf-pin.wav"/>
  <param name="bad-pin-sound" value="conference/conf-bad-pin.wav"/> -->
  <param name="caller-id-name" value="$${outbound_caller_name}"/>
  <param name="caller-id-number" value="$${outbound_caller_id}"/>
  <param name="comfort-noise" value="false"/>
  <param name="conference-flags" value="video-floor-only|rfc-4579|livearray-sync|minimize-video-encoding|manage-inbound-video-bitrate"/>
  <param name="video-second-screen" value="true"/>
  <param name="video-mode" value="mux"/>
  <param name="video-layout-name" value="3x3"/>
  <param name="video-layout-name" value="group:grid"/>
  <!--<param name="video-canvas-size" value="1920x1080"/>-->
  <param name="video-canvas-size" value="1280x1024"/>
  <param name="video-canvas-bgcolor" value="#333333"/>
  <param name="video-layout-bgcolor" value="#000000"/>
  <param name="video-codec-bandwidth" value="1mb"/>
  <param name="video-fps" value="15"/>
</profile>
```

# Modify verto.nginx

Edit `/etc/bigbluebutton/nginx/verto.nginx`. Modify the `proxy_pass` line's IP address from `127.0.0.1` to yours.
  
It should look like `proxy_pass https://<IP_ADDRESS>:8082;` with `<IP_ADDRESS>` being your external IP address

# Browser Extensions

  [Information available here](https://github.com/bigbluebutton/bigbluebutton/tree/master/bbb-screenshare/webrtc-extensions)

  Build your own extension to allow web browsers to share your screen with BigBlueButton
