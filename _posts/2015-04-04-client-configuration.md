---
layout: page
title: "Client Configuration"
category: install
date: 2015-04-04 22:22:25
---


# Introduction

This document shows you how to configure the BigBlueButton 1.1 client by making changes to `config.xml`, the configuration file loaded at runtime by the client.

## Config.xml
The config.xml file is located in the deployed client directory, the default location is `/var/www/bigbluebutton/client/conf/config.xml`. If you are working with the source code, it is located in the client's src/conf directory, the default location is `~/dev/source/bigbluebutton/bigbluebutton-client/src/conf/config.xml`.

Here's an overview of the conetns of `config.xml file` for BigBlueButton.

The template can be found [here](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/resources/config.xml.template).

## Main parameters
~~~xml
<localeversion suppressWarning="false">0.9.0</localeversion>
<version>VERSION</version>
<help url="http://HOST/help.html"/>
<javaTest url="http://HOST/testjava.html"/>
<porttest host="HOST" application="video/portTest" timeout="10000"/>
<bwMon server="HOST" application="video/bwTest"/>    
<application uri="rtmp://HOST/bigbluebutton" host="http://HOST/bigbluebutton/api/enter"/>
<language userSelectionEnabled="true" rtlEnabled="true"/>
<skinning enabled="true" url="http://HOST/client/branding/css/BBBDefault.css.swf?v=VERSION" />
<shortcutKeys showButton="true" />
<browserVersions chrome="CHROME_VERSION" firefox="FIREFOX_VERSION" flash="FLASH_VERSION" java="1.7.0_51" />
<layout showLogButton="false" defaultLayout="bbb.layout.name.defaultlayout"
        showToolbar="true" showFooter="true" showMeetingName="true" showHelpButton="true" 
        showLogoutWindow="true" showLayoutTools="true" confirmLogout="true" showNetworkMonitor="false"
        showRecordingNotification="true" logoutOnStopRecording="false"/>
<meeting muteOnStart="false" />
<breakoutRooms enabled="true" record="false" />
<logging enabled="true" target="trace" level="info" format="{dateUTC} {time} :: {name} :: [{logLevel}] {message}" uri="http://HOST/log" logPattern=".*"/>
<lock disableCam="false" disableMic="false" disablePrivateChat="false" 
      disablePublicChat="false" lockLayout="false" lockOnJoin="true" lockOnJoinConfigurable="false"/>
~~~


~~~xml
<localeversion suppressWarning="false">0.9.0</localeversion>
~~~

This should be left as is. It has to do with the client caching localization files. If you're having problems with the Warning Dialog for old localizations, you can set the **suppressWarning** parameter to true.

~~~xml
<version>VERSION</version>
~~~
This has to do with the caching of the client as a whole. Should also be left alone, in general.

~~~xml
<help url="http://HOST/help.html"/>
~~~

This is the URL that you would like users redirected to when they click the Help button in the client.

~~~xml
<porttest host="HOST" application="video/portTest" timeout="10000"/>
~~~
The IP and Red5 application the client uses to test whether necessary ports are open, and determine whether tunnelling should be used. The **host** should be your BBB server IP. The **application** should be left as is.

~~~xml
<application uri="rtmp://HOST/bigbluebutton" host="http://HOST/bigbluebutton/api/enter" />
~~~
The URL that the client queries for the user's information when the user joins a meeting.

~~~xml
<language userSelectionEnabled="true" rtlEnabled="true" />
~~~

|Name                  | Default Value | Description |
|:---------------------|:--------------|:------------|
| userSelectionEnabled | true          | This enables/disables the language selector combo box in the client. Enable this if you would like your users to be able to select the language of their BigBlueButton client themselves instead of the language being detected automatically for them. |
| rtlEnabled           | true          | If set to true, if using a languages that have `direction="rtl"` in `locales.xml` will fully change the layout direction to right from left reading mode. |

~~~xml
<skinning enabled="true" url="branding/css/theme.css.swf" />
~~~
Set **enabled** to true and set the **url** to the SWF file with your theme modifications. This enables/disables skinning support for the client. If the value is false, the **url** attribute will be ignored. Otherwise the **url** attribute specifies the compiled CSS file to load on startup. See [Branding](/dev/branding.html) for more details.

~~~xml
<shortcutKeys showButton="true" />
~~~
This disables/enables the visibility of the Shortcut Keys button. It should be left as true.

~~~xml
<browserVersions chrome="CHROME_VERSION" firefox="FIREFOX_VERSION" flash="FLASH_VERSION" java="1.7.0_51" />
~~~
This is used to determine whether a browser or plugin is out-of-date. The values are filled in when the client is packaged, but can be changed manually.

~~~xml
<layout showLogButton="false" defaultLayout="bbb.layout.name.defaultlayout"
        showToolbar="true" showFooter="true" showMeetingName="true" showHelpButton="true" 
        showLogoutWindow="true" showLayoutTools="true" confirmLogout="true"
        showRecordingNotification="true" logoutOnStopRecording="false"/>
~~~

|Name             | Default Value | Description|
|:----------------|:--------------|:-----------|
| showLogButton   | false         | Show or hide the button (lower right-hand corner) to display the debug window. |
| defaultLayout   | bbb.layout.name.defaultlayout | Determine which layout to load by default. |
| showToolbar     | true          | Show or hide the main toolbar on the top part of the client. |
| showFooter      | true          | Show or hide the footer bar at the bottom of the client. |
| showMeetingName | true          | Show or hide the meeting name that is in the top toolbar. |
| showHelpButton  | true          | Show the help button on the main toolbar. |
| showLogoutWindow | true         | Show the logout window when the client logs out. |
| showLayoutTools | true          | Show the layout options toolbar. |
| confirmLogout   | true          | Show a confirmation pop-up when a user wishes to logout. |
| showNetworkMonitor        | false | Show a network monitor button in the top bar. |
| showRecordingNotification | true  | Show or hide a notification on the top toolbar when recording is active. |
| logoutOnStopRecording     | true  | Immediately logout all users when the recording is stopped. |

~~~xml
<meeting muteOnStart="false" />
~~~
This determines whether people should join the audio muted by default.

~~~xml
<breakoutRooms enabled="true" record="false" />
~~~
Determines whether breakout rooms feature si enabled and if recording is enabled for them.

~~~xml
<logging enabled="true" target="trace" level="info" format="{dateUTC} {time} :: {name} :: [{logLevel}] {message}" uri="http://HOST/log" logPattern=".*"/>
~~~
It contains the logging configuration. Mainly used for debugging purpose.

|Name             | Default Value | Description|
|:----------------|:--------------|:-----------|
| enabled    | true  | It is preferred to set this to false in production if you don't need client logs. |
| target     | trace | By default logs are output to the Flash Player console. |
| level      | info  | Only info logs are written by default. |
| format     | "{dateUTC} {time} :: {name} :: [{logLevel}] {message} | The default log format. |
| uri        | none | This option only works when the target is set to to `server`, it should be the broker of your logs. |
| logPattern | true  | RegExp pattern for which to enable logging. |

The following logging targets are available

| Value            | Description |
|:----------------|:------------|
| trace     | Write logs using trace function. |
| logwindow | Write logs in LogWindow view. |
| server    | Send logs to the server. |
| jsnlog    | Uses jsnlog javascript library (experimental). |

The possible level values are: none, fatal_only, fatal, error_only, error, warn_only, warn, info_only, info, debug_only, debug, all

The format token are described in the table below.

| Name            | Description |
|:----------------|:------------|
| {dateUTC}     | he UTC date in the format YYYY/MM/DD |
| {gmt}         | The time offset of the statement to the Greenwich mean time in the format GMT+9999 |
| {logLevel}    | The level of the log statement (example | DEBUG). |
| {logTime}     | The UTC time in the format HH:MM:SS.0MS |
| {message}     | The message of the logger. |
| {message_dqt} | The message of the logger, double quote escaped. |
| {name}        | The name of the logger. |
| {time}        | The time in the format H:M:S.MS |
| {timeUTC}     | The UTC time in the format H:M:S.MS |
| {shortName}   | The short name of the logger. |
| {shortSWF}    | The SWF file name. |
| {swf}         | The full SWF path. |
| {person}      | The Person that wrote this statement. |
| {atPerson}    | he Person that wrote this statement with the 'at' prefix. |

~~~xml
<lock disableCam="false" disableMic="false" disablePrivateChat="false" 
      disablePublicChat="false" lockLayout="false" lockOnJoin="true" lockOnJoinConfigurable="false"/>
~~~

|Name             | Default Value | Description|
|:----------------|:--------------|:-----------|
| disableCam         | false | Default camera lock state for users that have been locked. |
| disableMic         | false | Default microphone lock state for users that have been locked. |
| disablePrivateChat | false | Default private chat lock state for users that have been locked. |
| disablePublicChat  | false | Default public chat lock state for users that have been locked. |
| lockLayout         | false | Default layout lock state for users that have been locked. |
| lockOnJoin         | true  | Lock users when they join. |
| lockOnJoinConfigurable | false | Show or hide the check box for lock-on-join. |

## Modules

The BigBlueButton client is comprised of one or more modules. You can specify which modules you would like loaded in the config.xml file. The modules will be loaded at startup. The properties for the different currently available modules are shown here in no particular order. Most of the modules share certain attributes:

### Attributes

| Name            | Description |
|:----------------|:------------|
| name            | The unique name of the module|
| url             | The url to the compiled module .swf file. Usually has a version appended to it, to prevent caching of old version when a new version of BigBlueButton is released. |
| uri             | The uri the module will connect to using rtmp. This is usually your bbb server ip with /bigbluebutton appended to it. Apart from making sure the ip is correct, you don't have to worry about it. |
| dependsOn       | Optional parameter that should be included in the case that the module being loaded depends on another BigBlueButton module being loaded first in order to work properly. |
| baseTabIndex    | The accessibilty starting tab index for the module components. |


### Chat Module

~~~xml
<module name="ChatModule" url="http://HOST/client/ChatModule.swf?v=VERSION" 
	uri="rtmp://HOST/bigbluebutton" 
	dependsOn="UsersModule"	
	privateEnabled="true"  
	fontSize="14"
	baseTabIndex="801"
	colorPickerIsVisible="false"
	maxMessageLength="1024"
/>
~~~

|Name                  | Default Value | Description|
|:---------------------|:--------------|:-----------|
| privateEnabled       | true          | Set to true to enable private chat. |
| fontSize             | 14            | Set the default size of the chat messages. |
| colorPickerIsVisible | false         | Show or hide the chat message color picker. |
| maxMessageLength     | 1024          | Set the maximum legnth of a message to be sent. |


### Users Module
~~~xml
<module name="UsersModule" url="http://HOST/client/UsersModule.swf?v=VERSION"
	uri="rtmp://HOST/bigbluebutton"
	allowKickUser="false"
	enableEmojiStatus="true"
	enableSettingsButton="true"
    enableGuestUI="false"

/>
~~~

|Name             | Default Value | Description|
|:---------------------|:--------------|:-----------|
| allowKickUser        | false | Determines whether or not the Moderators of the meeting are able to eject a user from the conference. If set to true, a Moderator will be given the option of ejecting a selected user from the conference by clicking on their Kick button inside the Users window. |
| enableEmojiStatus    | true  | Show or hide the emoji status button. |
| enableSettingsButton | true  | Show or hide the the settings button. |
| enableGuestUI        | true  | Show or hide the the guest settings button. |

### Screenshare Sharing
~~~xml
<module name="ScreenshareModule"
	url="http://HOST/client/ScreenshareModule.swf?v=VERSION"
	uri="rtmp://HOST/screenshare"
    showButton="true"
    enablePause="true"
    tryWebRTCFirst="false"
    chromeExtensionLink=""
    chromeExtensionKey=""
    baseTabIndex="201"
	help="http://HOST/client/help/screenshare-help.html"
/>
~~~
The Desktop Sharing module. Note that it connects to /deskShare, which is a red5 application on the server separate from the /bigbluebutton application.

|Name            | Default Value | Description|
|:---------------|:--------------|:-----------|
| showButton     | true          | Show or hide the button that is added to the toolbar for the presenter. |
| enablePause    | true          | Show or hide the pause button to the toolbar for the presenter. |
| tryWebRTCFirst | false         | Try using WebRTC screen-sharing before falling back to Java screen-sharing. |
| chromeExtensionLink | -        | Link to WebRTC chrome extension for sceen-sharing. |
| chromeExtensionKey  | -        | Key of WebRTC chrome extension for sceen-sharing. |
| help           | -             | The help link to explain how screensharing works. |

### Phone Module
~~~xml
<module name="PhoneModule" url="http://HOST/client/PhoneModule.swf?v=VERSION"
	uri="rtmp://HOST/sip" 
	autoJoin="true"
	listenOnlyMode="true"
    forceListenOnly="false"
	skipCheck="false"
	showButton="true"
	enabledEchoCancel="true"
	useWebRTCIfAvailable="true"
	showPhoneOption="false"
	showWebRTCStats="false"
    showWebRTCMOS="false"
    echoTestApp="9196"
	dependsOn="UsersModule"
/>
~~~
The Phone Module shows as the small headset icon in the upper left of the client. It allows users to join the meeting through VoIP by using a headset. Note again the client connect to /sip instead of /bigbluebutton on the server side.

|Name                  | Default Value | Description|
|:---------------------|:--------------|:-----------|
| autoJoin             | true          | Set to true to have the user automatically join the voice conference. |
| listenOnlyMode       | true          | Shows or hides listen-only mode as an option for audio. |
| forceListenOnly      | false         | If enabled, joining any audio conference will be restricted to listen mode. |
| presenterShareOnly   | false         | If true, only the presenter may join with a microphone. |
| skipCheck            | false         | Skip checking if user has working microphone. |
| showButton           | true          | Set to true to have the headset icon visible on the toolbar. |
| enabledEchoCancel    | true          | Set to true to enable the acoustic echo cancellation. |
| useWebRTCIfAvailable | true          | If true, then on Firefox and Chrome browsers the client will try to use WebRTC. |
| showPhoneOption      | false         | Show or hide a third option for a dial-in number. |
| showWebRTCStats      | false         | Show or hide WebRTC call quality. |
| showWebRTCMOS        | false         | Show or hide WebRTC detailed statistics. |
| echoTestApp          | 9196          | The pin number to use for the echo test. Do not change. |

### Videoconf Module
~~~xml
<module name="VideoconfModule" url="http://HOST/client/VideoconfModule.swf?v=VERSION" 
	uri="rtmp://HOST/video"
    dependsOn="UsersModule"
    baseTabIndex="401"
    autoStart="false"
    skipCamSettingsCheck="false"
    showButton="true"
    applyConvolutionFilter="false"
    convolutionFilter="-1, 0, -1, 0, 6, 0, -1, 0, -1"
    filterBias="0"
    filterDivisor="4"
    displayAvatar="false"
    priorityRatio="0.67"
/>
~~~

The Video Conferencing Module. Allows users to share their webcams with the room. It connects to the separate /video application on the bbb server. See also [changing quality of webcam picture](/support/faq.html#how-do-i-change-the-video-quality-of-the-shared-webcams) in the FAQ.

|Name                  | Default Value            | Description|
|:---------------------|:-------------------------|:-----------|
| autoStart            | false                    | Start the webcam automatically. |
| skipCamSettingsCheck | false                    | If enabled, it will skip the camera check window and select the first available webcam to start streaming immediately |
| showButton           | true                     | Show button in main toolbar. |
| applyConvolutionFilter | false                  | See [Camera doc](http://help.adobe.com/en_US/FlashPlatform/beta/reference/actionscript/3/flash/media/Camera.html) |
| convolutionFilter      | -1, 0, -1, 0, 6, 0, -1, 0, -1 | See [Camera doc](http://help.adobe.com/en_US/FlashPlatform/beta/reference/actionscript/3/flash/media/Camera.html) |
| filterBias             | 0                             | See [Camera doc](http://help.adobe.com/en_US/FlashPlatform/beta/reference/actionscript/3/flash/media/Camera.html) |
| filterDivisor          | 4                             | See [Camera doc](http://help.adobe.com/en_US/FlashPlatform/beta/reference/actionscript/3/flash/media/Camera.html) |
| displayAvatar          | false                         | Display avatar in webcam window. |
| priorityRatio          | 0.67                          | The weight ratio for the webcam when clicking on it. |


### Present Module
~~~xml
<module name="PresentModule" url="http://HOST/client/PresentModule.swf?v=VERSION"
        uri="rtmp://HOST/bigbluebutton" 
        dependsOn="UsersModule"
        host="http://HOST" 
        showPresentWindow="true"
        showWindowControls="true"
        openExternalFileUploadDialog="false"
        baseTabIndex="501"
        maxFileSize="30"
        enableDownload="true"
/>
~~~
The Presentation Module which lets users share slides and other documents in the main viewing area inside of BigBlueButton.

|Name                  | Default Value            | Description|
|:---------------------|:-------------------------|:-----------|
| showPresentWindow    | true                     | Set true to show the presentation window. |
| showWindowControls   | true                     | Set true to show the presentation window controls. |
| openExternalFileUploadDialog | false |  |
| maxFileSize | 30 |  |
| enableDownload | true | Enables the download of presentations from the server. |

### Whiteboard Module
~~~xml
<module name="WhiteboardModule" url="http://HOST/client/WhiteboardModule.swf?v=VERSION" 
        uri="rtmp://HOST/bigbluebutton" 
        dependsOn="PresentModule"
        baseTabIndex="601"
        keepToolbarVisible="false"
/>
~~~
The Whiteboard Module is a transparent overlaid canvas on top of the presentation window. It allows users to draw annotations on top of uploaded slides and documents.

|Name                | Default Value | Description|
|:-------------------|:--------------|:-----------|
| keepToolbarVisible | false         | Always show the whiteboard toolbar to the presenter instead of just when the Presentation window is moused over. |

### Shared Notes Module
~~~xml
<module name="SharedNotesModule" url="http://HOST/client/SharedNotesModule.swf?v=VERSION"
    uri="rtmp://HOST/bigbluebutton"
    dependsOn="UsersModule"
    refreshDelay="500"
    toolbarVisibleByDefault="false"
    showToolbarButton="true"
    fontSize="14"
    maxMessageLength="5000"
    maxNoteLength="10000"
    enableDeleteNotes="false"
    hideAdditionalNotes="false"
/>
~~~
The Shared Notes Module gives users a collaborative note pad capturing content during the session.

|Name                     | Default Value | Description|
|:------------------------|:--------------|:-----------|
| refreshDelay            | 500           | The delay for fetching notes update from the server. |
| toolbarVisibleByDefault | false         | Show or hide the control bar by default. |
| showToolbarButton       | true          | Show or hide the text format button. |
| fontSize                | 14            | Default notes font size. |
| maxMessageLength        | 5000          | The maximum length for a note update to be sent to the server. |
| maxNoteLength           | 10000         | The maximum length for a single note. |
| enableDeleteNotes       | false         | Offers the ability to close a shared note and delete its content by closing it. |
| hideAdditionalNotes     | false         | Show or hide the button to create additional shared notes. |

## Layouts

Layouts documentation

The layouts are defined in XML format, and the default layouts file is located at `/var/www/bigbluebutton/client/conf/layout.xml`.

The format is as follows:

~~~xml
<layouts>
    <layout name=”LAYOUT_NAME” ... >
        <window name=”WINDOW_NAME” ... />
        <window ... />
        ...
    </layout>
    <layout ... />
    ...
</layouts>
~~~

### Layout parameters

|Name                  | Default Value            | Description|
|:---------------------|:-------------------------|:-----------|
| name                 |                          | This is the name that will appear in the list of layouts on BigBlueButton |
| default              | false                    | Only one layout in the entire definition should be the default one (that will organize the windows on startup).|
| role                 | viewer                   | This parameter make possible to define multiple layouts with the same name but with different definitions depending on the participant role. They must have the same name to assign them together. Values are “viewer”, “moderator” and “presenter”.|

### Window parameters


|Name       | Required / Optional | Type | Description|
|:----------|:--------------------|:-----|:-----------|
| name      | Required            | String | This is the window identifier. Example: PresentationWindow, VideoDock, ChatWindow, UsersWindow.|
| width     | Required (optional only if hidden=”true” or minimized=”true”) | Number | The width of the window relative to the canvas. Values are [0..1].|
| height    | Required (optional only if hidden=”true” or minimized=”true”) | Number | The height of the window relative to the canvas. Values are [0..1].|
| x         | Required (optional only if hidden=”true” or minimized=”true”) | Number | The x position of the window relative to the canvas. Values are [0..1].|
| y         | Required (optional only if hidden=”true” or minimized=”true”) | Number | The y position of the window relative to the canvas. Values are [0..1].|
| order     | Optional            | Number | Specifies the z order of the window, i.e, which window is in front of the others.|
| hidden    | Optional (default is “false”) | Boolean | If hidden=”true” the window won’t show up in the BigBlueButton interface.|
| minimized | Optional (default is “false”) | Boolean | If minimized=”true” the window will be minimized at the left bottom corner and can be restored.|
| maximized | Optional (default is “false”) | Boolean | If maximized=”true” the window will be maximized to use the entire screen.|
| minWidth  | Optional            | Number | The minimum width of the window expressed in pixels.|
| minHeight | Optional            | Number | The minimum height of the window expressed in pixels. Not implemented yet.|
| draggable | Optional            | Boolean | Not implemented yet.|
| resizable | Optional            | Boolean | Not implemented yet.|


You can have multiple layout definitions, and inside each layout, multiple window layout definitions.

### Example:
~~~xml
<layout name="Default minWidth">
<window name="PresentationWindow" width="0.5137481910274964" height="0.9946808510638298" x="0.18017366136034732" y="0" />
    <window name="VideoDock" width="0.1772793053545586" height="0.30851063829787234" x="0" y="0.6875" minWidth="280" />
    <window name="ChatWindow" width="0.3031837916063676" height="0.9960106382978723" x="0.6968162083936325" y="0" />
    <window name="UsersWindow" width="0.1772793053545586" height="0.6795212765957446" x="0" y="0" minWidth="280" />
</layout>
~~~

### Configuration on config.xml:

|Name | Required / Optional | Type | Description|
|:----|:--------------------|:-----|:-----------|
|layoutConfig | Required            | String | URL of the layouts definition file.|
|enableEdit | Required (default is “false”) | Boolean|Enable the buttons for moderators to manage layouts within the session. The buttons enable the moderator to add custom layouts to the list, save layouts to file and load layouts back from file.|

This is the moderator view when enableEdit=”true”.


When the moderator clicks on the “lock layout” button, every participant will see the same layout and won’t be able to change it (except for moderators).
New layouts can be created using the “add layout to list” button. Sysadmins always have the possibility to create a new layout, save it to file, edit is using a text editor to insert constraints like minWidth, and then copy this new layout to the default layouts definition file (/var/www/bigbluebutton/client/conf/layout.xml).

Example of the layouts module definition on config.xml:

~~~xml
<module name="LayoutModule" 
    url="http://HOST/client/LayoutModule.swf?v=VERSION" 
    uri="rtmp://HOST/bigbluebutton" 
    layoutConfig="conf/layout.xml" 
    enableEdit="false"
/>
~~~
