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

Modify the 2 FreeSWITCH dialplans and add the following contents for each file

/opt/freeswitch/etc/freeswitch/dialplan/default.xml

```
<extension name="public_extensions">
  <condition field="destination_number" expression="^\d{5}-DESKSHARE$">
    <action application="transfer" data="${destination_number} XML public"/>
  </condition>
</extension>
```

/opt/freeswitch/etc/freeswitch/dialplan/public.xml

```
<extension name="public_extensions">
  <condition field="destination_number" expression="^\d{5}-DESKSHARE$">
    <action application="answer"/>
    <action application="conference" data="${destination_number}@video-mcu-stereo"/>
  </condition>
</extension>
```

Then in a FreeSWITCH terminal (`/opt/freeswitch/bin/fs_cli`) run `reloadxml`
then.

Confirm that mod_av and mod_verto are enabled in autoload_configs/modules.conf.xml

```
<load module="mod_av"/>
<load module="mod_verto"/>
```

After that you can verify with

```
freeswitch@machine> module_exists mod_av
true
freeswitch@machine> module_exists mod_verto
true
```

Make a backup of your wss.pem file in case

`sudo cp /opt/freeswitch/etc/freeswitch/tls/wss.pem /opt/freeswitch/etc/freeswitch/tls/wss.pem.BAK`

Now modify the existing file so the contents match below

```
/etc/letsencrypt/live/example.bigbluebutton.com/
cert.pem
privkey.pem
chain.pem
```

Restart the FreeSWITCH service `sudo service freeswitch restart`

## Configure Akka Apps

Verify that in `~/dev/bigbluebutton/akka-bbb-apps/src/main/resources/application.conf`

```
red5 {
    deskshareip="192.168.0.109"
    deskshareapp="video-broadcast"
}
```

we have `deskshareip` matching your IP address, if not-- make the change so that red5 will work correctly


# Final notes

  * ensure that the Google Chrome extension you use has your domain whitelisted
