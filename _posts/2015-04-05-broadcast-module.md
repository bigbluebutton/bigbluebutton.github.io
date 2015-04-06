---
layout: page
title: "Broadcast Module"
category: labs
date: 2015-04-05 11:42:17
---


Note:**The Broadcast Module is included in 0.81-RC (referred hereafter as 0.81), but its still in development and may change.**

## Set Up the broadcast module

  1. Setup a Ubuntu 10.0.4 64-bit server.

> 2. Install BigBlueButton 0.81 following the instructions [here](https://code.google.com/p/bigbluebutton/wiki/081InstallationUbuntu)

> 3. Open /var/www/bigbluebutton/client/conf/config.xml and uncomment the BroadcastModule section.
```
        <module name="BroadcastModule" url="http://HOST/client/BroadcastModule.swf?v=VERSION"
      	uri="rtmp://HOST/bigbluebutton"
        streamsUri="http://HOST/client/conf/streams.xml"
        position="top-left"
        showStreams="true"
        autoPlay="false"
        dependsOn="UsersModule"
       />
```

> 4. Edit HOST to point to your BBB server and to streams.xml.

> 5. Create the streams.xml in /var/www/bigbluebutton/client/conf/
```
     <?xml version="1.0" ?>
        <streams>
            <stream url="rtmp://192.168.153.128/oflaDemo" id="hobbit_vp6" name="The Hobbit"/>
            <stream url="rtmp://192.168.153.128/oflaDemo" id="startrekintodarkness_vp6" name="Star Trek"/>
         </streams>
```

> Properties:
    * rl=> the broadcast channel
    * d=> the name of the video played
    * ame=> The name which appears in the combobox to be selected in the flex client.

> 6. If the strems.xml is on a diferent server you should add a crossdomain.xml in root of the web server
```
      <cross-domain-policy xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.adobe.com/xml/schemas/PolicyFile.xsd">
          <allow-access-from domain="174.129.10.138"/>
          <allow-access-from domain="192.168.0.235"/>
          <site-control permitted-cross-domain-policies="master-only"/>
          <allow-http-request-headers-from domain="174.129.10.138" headers="*"  secure="true"/>
          <allow-http-request-headers-from domain="192.168.0.235" headers="*" secure="true"/>
       </cross-domain-policy> 
```


> 7. Modify the layout to make appear the braodcast module in the client. Go to /var/www/bigbluebutton/client/conf/layout.xml and change the broadcast Windows like
```
<window name="BroadcastWindow" hidden="true" draggable="false" resizable="false"/>
```

> and add this parameters to set visible, draggable, resizable and give a size and position
> in the window .
```
hidden="false" draggable="true" resizable="true" width="0.1772793053545586" 
height="0.30851063829787234" x="0" y="0.6875" minWidth="280"
```


## Set Up the broadcast module in Dev Mode

  1. Setup a Ubuntu 10.0.4 64-bit server.

> 2. Install BigBlueButton following the instructions [here](https://code.google.com/p/bigbluebutton/wiki/081InstallationUbuntu)

> 3. Set up the Development Environment following the instructions from https://code.google.com/p/bigbluebutton/wiki/081DevelopingBigBlueButton

> 3. Open /var/www/bigbluebutton/client/conf/config.xml and uncomment the BroadcastModule section.
```
        <module name="BroadcastModule" url="http://HOST/client/BroadcastModule.swf?v=VERSION"
      	uri="rtmp://HOST/bigbluebutton"
        streamsUri="http://HOST/client/conf/streams.xml"
        position="top-left"
        showStreams="true"
        autoPlay="false"
        dependsOn="UsersModule"
       />
```

> 4. Edit HOST to point to your BBB server and to streams.xml.

> 5. Create the streams.xml in /home/firstuser/dev/bigbluebutton/bigbluebutton-client/client/conf/
```
     <?xml version="1.0" ?>
        <streams>
            <stream url="rtmp://192.168.153.128/oflaDemo" id="hobbit_vp6" name="The Hobbit"/>
            <stream url="rtmp://192.168.153.128/oflaDemo" id="startrekintodarkness_vp6" name="Star Trek"/>
         </streams>
```

> Properties:
    * rl=> the broadcast channel
    * d=> the name of the video played
    * ame=> The name which appears in the combobox to be selected in the flex client.

> 6. If the strems.xml is on a diferent server you should add a crossdomain.xml in root of the web server
```
      <cross-domain-policy xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:noNamespaceSchemaLocation="http://www.adobe.com/xml/schemas/PolicyFile.xsd">
          <allow-access-from domain="174.129.10.138"/>
          <allow-access-from domain="192.168.0.235"/>
          <site-control permitted-cross-domain-policies="master-only"/>
          <allow-http-request-headers-from domain="174.129.10.138" headers="*"  secure="true"/>
          <allow-http-request-headers-from domain="192.168.0.235" headers="*" secure="true"/>
       </cross-domain-policy> 
```


> 7. Modify the layout to make appear the braodcast module in the client. Go to /home/firstuser/dev/bigbluebutton/bigbluebutton-client/client/conf/layout.xml and change the broadcast Windows like
```
<window name="BroadcastWindow" hidden="true" draggable="false" resizable="false"/>
```

> and add this parameters to set visible, draggable, resizable and give a size and position
> in the window .
```
hidden="false" draggable="true" resizable="true" width="0.1772793053545586" 
height="0.30851063829787234" x="0" y="0.6875" minWidth="280"
```

## Settin up Oflademo

  1. Download red5 from http://red5.org/downloads/red5/1_0_1/red5-1.0.1.tar.gz
  1. Extract into another VM
  1. start red5 (cd red5-1.0.1) (./red5.sh)
  1. Goto http://red5:5080
  1. Click on Install a ready-made application
  1. Install oflaDemo
  1. Check red5/webapps/oflaDemo/streams if it has the sample flv files
  1. modify streams.xml to use this new red5
  1. test broadcast module and it should work
