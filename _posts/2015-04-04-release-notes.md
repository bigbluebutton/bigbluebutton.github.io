---
layout: page
title: "Release Notes"
category: support
date: 2015-04-04 22:26:10
---


# Release 0.9.0-beta

Updated: March 27, 2015 ([Installation Instructions](090InstallationUbuntu.md))

This release of BigBlueButton 0.9.0-beta is a significant towards the release of 0.9.0 final (see [development process](https://code.google.com/p/bigbluebutton/wiki/FAQ#BigBlueButton_Development_Process)).

## Major Features

  * **WebRTC Audio** - BigBlueButton now uses web real-time communications (WebRTC) audio for users of FireFox and Chrome.  WebRTC audio is sampled at 48 Khz, encoded in [OPUS](http://www.opus-codec.org/) codec, uses UDP for transport, and communicates directly with [FreeSWITCH](http://freeswitch.org/) on the BigBlueButton server –- all this combines to give users high quality, low latency audio.

  * **Audio Check** - To ensure users have a functioning microphone when joining a session, BigBlueButton now provides a microphone check for users _before_ they join the session.

  * **Listen Only Audio** - To quickly join the conference as a listener  only (no microphone check), BigBlueButton offers a Listen Only mode.  Under the hood, Listen Only users share a single, one-way audio channel from FreeSWITCH, which means they require less overall CPU resources on the BigBlueButton server compared with users joining with a microphone.  The Listen Only mode brings BigBlueButton closer to supporting webinar-type sessions.

  * **Start/Stop Button for Recording** - Moderators can now mark segments of the recorded session for later publishing using a new Start/Stop Recording button in the toolbar.  After the session is over, the BigBlueButton server extracts the marked segments for publishing the recording.

  * **Ubuntu 14.04 64-bit** - BigBlueButton now installs on Ubuntu 14.04 64-bit.

For details of the new features (with screen shots) see [BigBlueButton 0.9.0 Overview](090Overview.md).  See also [0.9.0 Documentation](090Docs.md)

## Fixed Issues

See [issues fixed in BigBlueButton 0.9.0](https://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.9.0%20status=Fixed&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary).


# Release 0.81

Released: November 7, 2013 ([Installation Instructions](InstallationUbuntu.md))

This is our eleventh release of BigBlueButton.  For a quick summary of what's new since the previous release, see this [overview video](http://youtu.be/4C-rOd8bi6s).

## Major Features
  * **Usability Improvements** - BigBlueButton now has a consolidated Users window for easier session management and a more consistent user interface (including updated skin and icons) to help new users get started quickly.  For a closer look, see [moderator/presenter tutorial](http://youtu.be/PHTZvbL1NT4) and for [viewer tutorial](http://www.youtube.com/watch?v=LS2lttmPi6A).

  * **Recording** - BigBlueButton now records all activity in the session (audio, video, presentation, chat, and desktop sharing) for playback.  Playback of recording is supported in Chrome and FireFox.

  * **Layout Manager** - BigBlueButton now enables users to choose from a number of preset layouts to quickly adapt to different modes of learning.

  * **Text tool for whiteboard** - Presenters can now annotate their slides with text.

  * **New APIs** - The BigBlueButton API now includes the ability to dynamically configure each client on a per-user bases, thus enabling developers to configure the skin, layout, modules, etc. for each user.  There is also a JavaScript interface to control the client.

  * **Accessiblity for screen readers** - BigBlueButton adds accessibility by supporting screen readers such as JAWS (version 11+) and NVDA. A list of keyboard shortcuts have been added to make it easier to navigate through the interface using the keyboard.

  * **LTI Support** - BigBlueButton is IMS Learning Tools Interoperability (LTI) 1.0 compliant. This means any LTI consumer can integrate with BigBlueButton without requiring custom plug-ins (see [BigBlueButton LTI certification](http://www.imsglobal.org/cc/detail.cfm?ID=172) and [video](http://www.youtube.com/watch?v=OSTGfvICYX4)).

  * **Mozilla Persona** - The API demos now demonstrate how to sign into a BigBlueButton session using Mozilla Persona.

  * **Support for LibreOffice 4.0** - BigBlueButton now uses LibreOffice 4.0 for conversion of of MS Office documents (upload of PDF is still recommend to provide best results).

  * **Updated components** -  We've updated BigBlueButton packaging to use red5 1.0.2,  FreeSWITCH (1.5.x), and grails 1.3.6.


## Fixed Issues
See [issues fixed in BigBlueButton 0.81](https://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.81%20status=Fixed&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary).



# Release 0.8: Bailetti

_Code named in honor of [Tony Bailetti](http://www.sce.carleton.ca/faculty/bailetti.html), head of the Technology Information Management program (Carleton University) who inspired the creation of BigBlueButton.  For more information, see [History of the BigBlueButton Project](http://www.bigbluebutton.org/history/)._

Released: June 18, 2012 ([Installation](Installation.md))

## Major Features
  * **Reduced latency in audio** - The BigBlueButton server sets the audio codec for Flash to speex and passes through the packets to FreeSWITCH for processing.

  * **Recording of a session** - BigBlueButton now record events (join, leave, who's talking, chat) and media (audio, webcam, presentations, and desktop sharing) for later playback.  After the session ends, the BigBlueButton server will run one (or more) ingest and processing scripts to convert the recorded events + media into playback formats (see [Record and Playback Specification](RecordPlaybackSpecification.md)).

  * **Playback of recordings in HTML 5** - The default playback format will playback synchronized slides, audio, and chat.  Playback uses  [popcorn.js](http://popcornjs.org/) for playback within an HTML5 browser.  Current supported browsers are Chrome, Firefox, and IE using the Google Chrome Frame.  Playback of desktop sharing and webcam is supported through the Matterhorn integration.

  * **New API calls** - The API now includes calls for recording a meeting (pass record=true to the 'create' API call) and for accessing recordings: getRecordings, publishRecordings, deleteRecordings (see [API updates for 0.8](API#Version_0.8.md)).

  * **Matterhorn integration** -  When integrated with Matterhorn, BigBlueButton can capture and process the desktop and webcam for automatic submission to a Matterhorn server (see [Matterhorn integration](Matterhorn.md)).


## Usability Updates
  * **Audio Settings dialog** -  To assist users in checking their audio setup **before** joining the voice conference, BigBlueButton now displays an Audio Settings dialog box to enable the user to verify that audio and microphone are correctly configured for a headset.  See [audio settings screenshot](http://code.google.com/p/bigbluebutton/wiki/08Overview#Audio_Settings_Dialog).

  * **Video Dock** -  To help users view webcams from multiple sources, a new video dock window now 'docks' all the webcams.  The user can drag individual windows in and out of the dock.  See [video dock screenshot](http://code.google.com/p/bigbluebutton/wiki/08Overview#Video_Dock).

  * **Fit-to-Width for layout of portrait documents** -  Presentation module now enables presenter to switch between fit-to-width and fit-to-page layout for best viewing of  portrait and landscape documents.  See  [screenshot](http://code.google.com/p/bigbluebutton/wiki/08Overview#Fit-to-width).

  * **Push to Talk** -  Remote students can now mute/unmute themselves with a 'push to talk' button.  See  [screenshot](http://code.google.com/p/bigbluebutton/wiki/08Overview#Push_To_Talk).


## Configuration Updates
  * **API demos now separate** - The API demos are installed in their own package (for easy addition and removal).  The install location has changed to `/var/lib/tomcat6/webapps/demo`, which changes the URL from accessing them from `/bigbluebutton/demo` to `/demo`.

  * **Upload slides on create** - The 'create' API now supports specification for upload of slides upon creation of the session.  To upload slides, developers can pass an xml with the 'create' request (send via POST).  The xml file may include the slides inline or reference them via URLs.

  * **Default Presentation** - You can now specify a default presentation for all BigBlueButton sessions, which lets you, for example, show an initial help page in a session.  See [defaultUploadedPresentation](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-web/grails-app/conf/bigbluebutton.properties#L130) property.

  * **Auto-translate disabled** -  Google Translate APIs are [no longer free](http://code.google.com/apis/language/translate/overview.html) so the auto translate feature is now disabled by default until we can determine the best way to support their new model (see [1079](http://code.google.com/p/bigbluebutton/issues/detail?id=1079))

  * **bbb-conf now Installs development tools** - To make it easer to develop BigBlueButton, `bbb-conf` can now install a build environment on a BigBlueButton server within any account with sudo privileges.  See [setting development tools](08SettingDevEnvironment#Setting_up_the_development_tools.md).

  * **Under the hood** -  Replaced activemq with redis.  Updated red5 to RC1.  Updated FreeSWITCH to a snapshot of 1.0.7.  BigBlueButton no longer requires installation of mysql.

## Fixed Issues
See [detailed list of issues fixed in BigBlueButton 0.8](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=status%3DFixed+milestone%3DRelease0.8&sort=priority)


# Release 0.71a

Released: January 13, 2011

  * **Maintenance Release** - We spent six weeks profiling and testing the server code to speed handling of VoIP packets and lower memory usage on the server.  See documentation to [install](InstallationUbuntu.md) or [for upgrade](InstallationUbuntu#Upgrading_to_BigBlueButton_0.71a.md) your Ubuntu 10.04 server to BigBlueButton 0.71a.

## Fixed Issues
See [detailed list of issues fixed in BigBlueButton 0.71a](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.71a)

# Release 0.71: Europa

_Code named after Europa, Jupiter's moon, whose surface is among the brightest in the solar system._


Released: November 9, 2010

  * **VoIP Improvements** - This was the bulk of our effort for 0.71. We improved the algorithms to handle audio packets coming to and from the BigBlueButton server. You should experience less audio lag using VoIP when compared to 0.70. (We'll let you judge the extent to which the lag has been reduced.)

> BigBlueButton 0.71 now supports FreeSWITCH as a voice conference server (contributed by Leif Jackson). This enables the BigBlueButton client to transmit either wide-band (16 kHz) Speex or the Nellymoser voice codec. In our testing so far, we found that nellymoser scales better and will remain the default voice codec in BigBlueButton.

  * **Webcam Auto-Display** - When a user shares their webcam, it automatically opens on all other users connected to the virtual classroom.

  * **Selectable area for Desktop Sharing** - The Desktop Sharing application now supports selecting the desktop are to share, in additional to supporting sharing of fullscreen.  This allows the user to select a specific window, for example, and reduces the bandwidth requirements for desktop sharing.

  * **Auto Chat Translation** - BigBlueButton's chat now uses the Google Translate API for real-time of chat messages.  This allows the user to view the chat in their native language.

  * **Client Localization** -  The user can change their locale now through a drop-down menu on-the-fly.  This also triggers a change in the locale language for automatic chat translation.

  * **Client Branding** - Administrators can now [skin](Branding.md) the BigBlueButton using cascading style sheets.

  * **Client Configuration** - Administrators can configure, on a server basis, specific capabilities of the BigBlueButton client.  For example, you can change the video quality, define who can share video, and allow moderators to kick users.   See [Client Configuration](ClientConfiguration.md) for the full list of configuration parameters.

  * **Mate** - The BigBlueButton client is now fully migrated to the [mate](http://mate.asfusion.com/) framework.

## Fixed Issues
See [detailed list of issues fixed in BigBlueButton 0.71](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.71)

## Known Issues
  * [Issue 567](http://code.google.com/p/bigbluebutton/issues/detail?id=567) Hitting backspace on Safari causes the browser to go back one page
  * [Issue 634](http://code.google.com/p/bigbluebutton/issues/detail?id=634) You have been logged out
  * [Issue 670](http://code.google.com/p/bigbluebutton/issues/detail?id=670) Listener Window Count


# Release 0.7: Feynman

_Code named in honor of the Nobel prize winning physicist Richard Feynman._


Released: July 15, 2010

  * **Whiteboard** - Yes, BigBlueButton 0.7 comes with an integrated whiteboard. The whiteboard is overlaid over the presentation, and enables the presenter to draw freehand as well as simple shapes on top of the presentation slides. Each slide has it's own whiteboard instance, which is persistent as the presenter moves across the slides. Everything drawn on the whiteboard is synchronized in real time across all the conference participants.  See [whiteboard overview video](http://bigbluebutton.org/sites/all/videos/whiteboard/index.html).

  * **Desktop Sharing** - The mouse pointer is now visible to the viewers when the presenter is sharing their desktop.  The presenter also has 'b' system tray icon when desktop sharing is active.

  * **UI Improvements** - Changes to the UI make are part of an ongoing effort to make BigBlueButton even simpler for people to use. The make presenter icon has been changed by a button labeled 'Make Presenter', the two mute/unmute buttons have merged into one button: click to mute all (button stays down), click again to unmute all (button comes up).  As well, we've added a new layout manager that ensures BigBlueButton looks better on screens of varying resolutions and sizes.

  * **Font size in chat** -  You can now increase the font size in the chat window.

  * **Ubuntu 10.04 32-bit and 64-bit support** - While we maintain support for Ubuntu 9.04 32-bit with this release, we are adding support for installation via packages on [Ubuntu 10.04 32-bit and 64-bit](http://code.google.com/p/bigbluebutton/wiki/InstallationUbuntu).

  * **Desktop Sharing is now LGPL** - We've remove the AGPL license from the desktop sharing module.  This means that all the BigBlueButton code is available under the LGPL license.

  * **UTF-8** - Users can now login using UTF-8 names in the API examples.

  * **Source code moved to Github** - As the developer community grows, better source code control becomes more important. The entire source code repository has been moved to [Github](http://github.com/bigbluebutton/bigbluebutton). This enables developers to more easily branch and merge the BigBlueButton source, and maintain feature branches.

  * **API Updates** - Removed the redundant meetingToken parameter.  See [what's new in 0.7 API](http://code.google.com/p/bigbluebutton/wiki/API#What's_New) for more details.

  * **Improved Documentation** - There is a new, simpler, [Example module](SampleModule.md) for bbb-client. As well, the [Developer documentation](DevelopingBBB.md) has been updated to reflect the move to git.

## Fixed Issues
See [detailed list of issues fixed in BigBlueButton 0.7](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.7)

## Known Issues
  * [Issue 524](http://code.google.com/p/bigbluebutton/issues/detail?id=524) Problems with audio delay using VoIP
  * [Issue 579](http://code.google.com/p/bigbluebutton/issues/detail?id=579) Presenter can't widen the view of portrait documents
  * [Issue 580](http://code.google.com/p/bigbluebutton/issues/detail?id=580) CentOS packages do not support BigBlueButton 0.7

# Release 0.64: Lickety-split

_Code named for the reduced bandwidth and speed improvements to desktop sharing_

Released: April 3, 2010

  * **Faster desktop sharing** - We refactored the desktop sharing applet so it now uses less CPU on the presenter's computer.  We also refactored the desktop sharing server component (bbb-apps-deskshare) so it runs faster and only sends a keyframe when new users join, which results in much less bandwidth usage during a session.

  * **Fine-grain listener management** - To make it easier for the moderator to manage listeners, such as "mute everyone except the presenter", the moderator can now "lock" a participant's mute/unmuted state in the Listener's window.  When locked, a listener is unaffected by the global mute all/unmute all buttons in the lower left-hand corner of the Listener window.  This lets the moderator lock the presenter as unmuted, then click the global mute all button to mute everyone else.  In addition, after clicking the mute all button, new listeners join as muted (this is good when a class has started and you don't want latecomers to disturb the lecture).

  * **API Additions** - Jeremy Thomerson has added three new API calls: getMeetings (returns an XML file listing all the active meetings), getMeetingInfo (get information on a specific meeting), and end (end a specific meeting).  In particular, getMeetingInfo enables external applications to query the list of users in a conference. See this [api example](http://demo.bigbluebutton.org/bigbluebutton/demo/demo4.jsp) that uses getMeetingInfo.

  * **Show number of participants** - When there are more than five participants in either the Users or Listeners window, the title of the window will show a count (i.e. Users: 7, Listeners: 9).

  * **New method for slide selection** - The presenter can now jump to a particular slide by clicking the page number button (located between the left and right arrows) and clicking on the slide from the film strip of thumbnails.

  * **Localization** - Thanks to members of the mailing list -- and to DJP for checking in language contributions -- there are now [sixteen localizations](LocalizationOfBBB.md) for BigBlueButton.

  * **RPM packages for CentOS 5.4** - We now provide [RPM packages](RPMPackaging.md) for installation on CentOS 5.4 (32-bit and 64-bit).

## Fixed Issues

  * See [issues fixed in BigBlueButton 0.64](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.64&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary)

## Known Issues

  * [Issue 419](http://code.google.com/p/bigbluebutton/issues/detail?id=419&sort=priority&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary) Viewers are unable to mute/unmute themselves
  * [Issue 357](http://code.google.com/p/bigbluebutton/issues/detail?id=357&sort=priority&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary) Uploading a presentation overwrites a previous presentation with the same name
  * [Issue 467](http://code.google.com/p/bigbluebutton/issues/detail?id=467&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary) Creating a meeting with a blank meetingID overrides any previous meetings with blank meetingIDs


# Release 0.63: Red Dot

_Code named for the red dot that's now visible in the presentation module_

Released: January 25, 2010

## New Features

  * **API for Third-Party Integration** - Thanks to Jeremy Thomerson, we now have a [BigBlueButton API](http://code.google.com/p/bigbluebutton/wiki/API) that makes it easy to create and join meetings, and integrate BigBlueButton with third-party applications.

  * **Localization Support** - Another big contribution to this release is work done by Xie Yan Qing and Chen Guangtao from China, who made [localization of the BBB Client](LocalizationOfBBB.md) possible.

  * **Support for other file formats** - Jean-Philippe Guiot, a contributor from France, submitted a patch months ago that allows uploading of different file formats for the presentation module.  Now, we've finally integrated his work into BBB, so from version 0.63 you will be able to upload not only .pdf, but also .ppt, doc, txt, and other file formats!

  * **Improved Presentation Module** - The presentation module has been refactored to use the Mate Framework for Flex. It is now more robust, and has several new features, such as the ability for the viewers in a conference to see where the presenter is pointing his mouse of the current slide (the red dot!). The stability of the file upload and conversion process has also been improved.

  * **VoIP stability** - VoIP is now more stable, with fewer dropped calls than ever, and better voice quality. And no system-access fee either!

  * **Distribution** - You now longer need to compile a kernel module for VoIP.  This means that you can now [install BigBlueButton](InstallationUbuntu.md) 0.63 on any Ubuntu 9.04 32-bit (server or desktop) with just five commands.

  * **Updated Install instructions** - If you want to install BigBlueButton's components, we've provided step-by-step instructions for [Ubuntu 9.04](InstallingBigBlueButton.md), [CentOS 5.03](InstallingBigBlueButtonCentOS.md), and [Fedora 12](InstallingBigBlueButtonFedora.md).

## Fixed Issues
  * [See Issues Fixed in BigBlueButton 0.63](http://code.google.com/p/bigbluebutton/issues/list?can=1&q=milestone=Release0.63%20status=Fixed&colspec=ID%20Type%20Status%20Priority%20Milestone%20Owner%20Component%20Summary)

## Known Issues
  * [Issue 324](http://code.google.com/p/bigbluebutton/issues/detail?id=324) List of uploaded presentation doesn't get transferred when changing presenters
  * [Issue 322](http://code.google.com/p/bigbluebutton/issues/detail?id=322) Odd issue with presentation getting out of sync



# Release 0.62: Nebula NGC604

_Code named in honor of Nubula NGC604_

Released: November 11, 2009

## New Features

  * **Better Desktop Sharing!** - We've made our Desktop Sharing much better by reverse engineering the Adobe Screen Codec from specs.  The result is much faster, platform independent implementation for desktop sharing.   To share their desktop, the presenter must have Java (1.6) installed to run a Java applet.   There is no changes required for the viewers to view the presenter's desktop.  We've also simplified the user interface for both presenter and viewer

  * **Full built-in development environment** - The BigBlueButton VM makes it easier to modify and build your own versions of BigBlueButton.  See [developing in BigBlueButton](http://code.google.com/p/bigbluebutton/wiki/Developing_BigBlueButton).

  * **Updated command-line tools** - The command-line tools `bbb-setip` and `bbb-setupdev` have been consolidated into a single script `bbb-conf`. If you modify your setup, typing `bbb-conf --check` will perform some checks on your setup to look for common configuration problems with running BigBlueButton

## To upgrade your BigBlueButton 0.61 installation to 0.62

If you are running  BigBlueButton VM 0.61 -- either from VM or from [apt-get packages](InstallationUbuntu.md) -- you can upgrade your installation to BigBlueButton 0.62 with with three commands.

```
  sudo apt-get update
  sudo apt-get upgrade
  sudo apt-get dist-upgrade
```

**Note**: Be sure to do `sudo apt-get update` _before_ `sudo apt-get dist-upgrade`.  We've moved out a lot of configuration files into a new package called `bbb-common`.  If you skip doing an `upgrade` and go directly to `dist-upgrade`, the package manager will complain that `bbb-common` is trying to overwrite files owned by another package.

**Note**: If you had desktop sharing installed, you can upgrade the apt-get install command described in InstallingDesktopSharing.


## Fixed Issues
  * [Issue 11](http://code.google.com/p/bigbluebutton/issues/detail?id=11)   	 Listeners window not getting updates
  * [Issue 110](http://code.google.com/p/bigbluebutton/issues/detail?id=110) Deskshare works only when tunneling on Mac OS X
  * [Issue 150](http://code.google.com/p/bigbluebutton/issues/detail?id=150) Deskshare applet should test port to check if it should tunnel
  * [Issue 168](http://code.google.com/p/bigbluebutton/issues/detail?id=168) One one deskshare usage per session
  * [Issue 170](http://code.google.com/p/bigbluebutton/issues/detail?id=170) Switching presenter while screensharing results in old presenter seeing screenshare viewer window
  * [Issue 177](http://code.google.com/p/bigbluebutton/issues/detail?id=177) When selecting a slide from the fisheye control, the cursor becomes an i-beam
  * [Issue 179](http://code.google.com/p/bigbluebutton/issues/detail?id=179) Zooming can cause a slide to disapper when clicking next
  * [Issue 180](http://code.google.com/p/bigbluebutton/issues/detail?id=180) Deskshare can leave a stream open
  * [Issue 187](http://code.google.com/p/bigbluebutton/issues/detail?id=187) Improve slide navigation from keyboard
  * [Issue 189](http://code.google.com/p/bigbluebutton/issues/detail?id=189) Improve speed of Desktop Sharing
  * [Issue 200](http://code.google.com/p/bigbluebutton/issues/detail?id=200) Update build.sh scripts with Virtual Machine
  * [Issue 201](http://code.google.com/p/bigbluebutton/issues/detail?id=201) Update desktop sharing video
  * [Issue 203](http://code.google.com/p/bigbluebutton/issues/detail?id=203) Create wiki on how to setup development environment
  * [Issue 204](http://code.google.com/p/bigbluebutton/issues/detail?id=204) Update Installing BBB from source wiki
  * [Issue 208](http://code.google.com/p/bigbluebutton/issues/detail?id=208) Port 9123 could still be in use on restart of red5
  * [Issue 220](http://code.google.com/p/bigbluebutton/issues/detail?id=220) Not all viewers automatically seeing the shared desktop
  * [Issue 221](http://code.google.com/p/bigbluebutton/issues/detail?id=221) Tooltips for all icons
  * [Issue 226](http://code.google.com/p/bigbluebutton/issues/detail?id=226) Desktop sharing window remains open when sharer closes connection / crashes
  * [Issue 229](http://code.google.com/p/bigbluebutton/issues/detail?id=229) Last frame of desktop sharing is visible to viewers
  * [Issue 230](http://code.google.com/p/bigbluebutton/issues/detail?id=230) Flash debug client shows messages

## Known Issues
  * [Issue 233](http://code.google.com/p/bigbluebutton/issues/detail?id=233) 	java.io.IOException: Too many open files
  * [Issue 227](http://code.google.com/p/bigbluebutton/issues/detail?id=227) BBB apps (Red5) should reconnect to ActiveMQ when connection drops
  * [Issue 214](http://code.google.com/p/bigbluebutton/issues/detail?id=214) VoIP stops working
  * [Issue 198](http://code.google.com/p/bigbluebutton/issues/detail?id=198) Mozilla crashes uploading PDF

# Release 0.61: Titan

Released: September 15, 2009

_Code named in honor of Saturn's largest moon_

## New Features

In preparation for schools and universities that are using BigBlueButton for the fall term, this month saw a lot of bug fixes, hardening, and a few new features.  Our goal was (and continues to be) to make the BigBlueButton code base as solid as possible.  Notable additions to this release include:

  * **Support for High Res Web Cameras** - As presenter, if you have the bandwidth, it's now possible to share video using your webcam at 640x480 high resolution or 320x240 standard resolution.  We've refactored the video module itself so the code is much cleaner and better organized.

  * **Simplified Desktop Sharing User Interface** - We've simplified the user experiences for initiating desktop sharing.  It now shares the entire desktop by default.  We've also refactored the desktop sharing module.

  * **Refactored slide conversion** - We went deep into the slide conversion process and fixed a number of bugs.

  * **Desktop Sharing and Xuggler** - The sharing capture applet now divides the presenter's screen into distinct tiles and only sends to the server the tiles that have changed since the last frame.  The desktop sharing also uses Xuggler re-assemble the tiles and compress the images into a flash video stream.  Because desktop sharing incorporates Xuggler, which is licensed under the AGPL, we've had to make desktop sharing a separate module (don't worry, you can install it with a single command).
However, if you choose to incorporate desktop sharing into BigBlueButton, you must accept the AGPL license for BigBlueButton. This has similar implications for any web application that, in turn, incorporates BigBlueButton.
For information on installing desktop sharing in BigBlueButton and how it changes the licensing, please see [how to install desktop sharing](http://code.google.com/p/bigbluebutton/wiki/InstallingDesktopSharing).


## To upgrade your installation

If you are running a BigBlueButton VM or had installed BigBlueButton using packages, you can upgrade to this release with the following two commands

```
  sudo apt-get update
  sudo apt-get upgrade
```

**Note:** If you get an error during upgrade, just run `sudo apt-get upgrade` again.  We refactored the install scripts and a previous install script and new install scrip both reference the same configuration file.  Running the upgrade command a second time will solve the problem as the first time upgrades all the install script.

## Fixed Issues
  * [Issue 25](http://code.google.com/p/bigbluebutton/issues/detail?id=25) Windows can get hidden or off-screen
  * [Issue 52](http://code.google.com/p/bigbluebutton/issues/detail?id=52) First moderator should become default presenter
  * [Issue 66](http://code.google.com/p/bigbluebutton/issues/detail?id=66) Progress should include generating thumbnails
  * [Issue 71](http://code.google.com/p/bigbluebutton/issues/detail?id=71) Reload after login doesn't load the person back into the session
  * [Issue 90](http://code.google.com/p/bigbluebutton/issues/detail?id=90) deskshare-app blocks red5 from restarting
  * [Issue 72](http://code.google.com/p/bigbluebutton/issues/detail?id=72) Upon uploading a presentation the first slide does not show
  * [Issue 115](http://code.google.com/p/bigbluebutton/issues/detail?id=115) Windows respond very poorly when maximized
  * [Issue 128](http://code.google.com/p/bigbluebutton/issues/detail?id=128) Unable to drag desktop sharing window while sharing fullscreen
  * [Issue 129](http://code.google.com/p/bigbluebutton/issues/detail?id=129) BigBlueButton client will hang for ~ 1 minute while it waits for direct connection to 1935 to timeout
  * [Issue 146](http://code.google.com/p/bigbluebutton/issues/detail?id=146) User can log in without entering a username
  * [Issue 149](http://code.google.com/p/bigbluebutton/issues/detail?id=149) Session not invalidated after logout
  * [Issue 157](http://code.google.com/p/bigbluebutton/issues/detail?id=157) Red5 ip is lost after upgrading
  * [Issue 161](http://code.google.com/p/bigbluebutton/issues/detail?id=161) Red5 logs are erased on restart
  * [Issue 163](http://code.google.com/p/bigbluebutton/issues/detail?id=163) Sharing full screen may cause red5 server to halt
  * [Issue 166](http://code.google.com/p/bigbluebutton/issues/detail?id=166) Video screen not resized according to the window resize
  * [Issue 168](http://code.google.com/p/bigbluebutton/issues/detail?id=168) One one deskshare usage per session
  * [Issue 169](http://code.google.com/p/bigbluebutton/issues/detail?id=169) Make "USB Video Class Video" default choice for Mac
  * [Issue 175](http://code.google.com/p/bigbluebutton/issues/detail?id=175) Maximize deskshare window when in full screen causes hang
  * [Issue 176](http://code.google.com/p/bigbluebutton/issues/detail?id=176) Share web cam icon allows multiple clicks
  * [Issue 178](http://code.google.com/p/bigbluebutton/issues/detail?id=178) Reset layout should reset sizes of windows

## Known Issues
  * [Issue 181](http://code.google.com/p/bigbluebutton/issues/detail?id=181) Stopping deskshare crashes Safari
  * ~~[Issue 180](http://code.google.com/p/bigbluebutton/issues/detail?id=180) Deskshare can leave a stream open~~
  * ~~[Issue 179](http://code.google.com/p/bigbluebutton/issues/detail?id=179) Zooming can cause a slide to disapper when clicking next~~
  * ~~[Issue 170](http://code.google.com/p/bigbluebutton/issues/detail?id=170) Switching presenter while screensharing results in old presenter seeing screenshare viewer window~~
  * [Issue 153](http://code.google.com/p/bigbluebutton/issues/detail?id=153)  The Show button on the Upload Window doesn't work

# 0.6 Release: Mir Space Station. August 12 2009


### New Features
**Integrated VOIP**

Participants can now use their headset to join a voice conference using voice over IP (VoIP).  For sites that setup BigBlueButton to connect to the phone system, both VoIP and dial-in participants can share the same voice conference.

The VoIP capability is based on the [Red5Phone](http://code.google.com/p/red5phone) project to connect Asterisk and Red5.

### Fixed Issues
Here are the list of issues we fixed on this release:
  * [Issue 67](http://code.google.com/p/bigbluebutton/issues/detail?id=67) Red5 Phone Module
  * [Issue 69](http://code.google.com/p/bigbluebutton/issues/detail?id=69) Users do not see slides from presenter
  * [Issue 98](http://code.google.com/p/bigbluebutton/issues/detail?id=98) Left and Right arrow keys not working
  * [Issue 99](http://code.google.com/p/bigbluebutton/issues/detail?id=99) Update Reset Zoom icon
  * [Issue 104](http://code.google.com/p/bigbluebutton/issues/detail?id=104) Add Desktop Sharing to BigBlueButton
  * [Issue 106](http://code.google.com/p/bigbluebutton/issues/detail?id=106) Unable to start desktop sharing
  * [Issue 108](http://code.google.com/p/bigbluebutton/issues/detail?id=108) Client does not provide proper feedback when logging out
  * [Issue 114](http://code.google.com/p/bigbluebutton/issues/detail?id=114) Client trying to load history.js and history.htm
  * [Issue 117](http://code.google.com/p/bigbluebutton/issues/detail?id=117) Log window is hard to read
  * [Issue 118](http://code.google.com/p/bigbluebutton/issues/detail?id=118) Limitation of conference session does not work.
  * [Issue 121](http://code.google.com/p/bigbluebutton/issues/detail?id=121) Can't input chat text in full screen mode
  * [Issue 125](http://code.google.com/p/bigbluebutton/issues/detail?id=125) Build bbb-apps from VM
  * [Issue 130](http://code.google.com/p/bigbluebutton/issues/detail?id=130) Hearing voices after logging out
  * [Issue 135](http://code.google.com/p/bigbluebutton/issues/detail?id=135) Participant entry sound plays when user icon is clicked
  * [Issue 136](http://code.google.com/p/bigbluebutton/issues/detail?id=136) Phone Logout null pointer exception
  * [Issue 138](http://code.google.com/p/bigbluebutton/issues/detail?id=138) Unmute-all icon mis-aligned
  * [Issue 139](http://code.google.com/p/bigbluebutton/issues/detail?id=139) bbb-setip not detecting rtmp port

### Known Issues
  * [Issue 141](http://code.google.com/p/bigbluebutton/issues/detail?id=141) Impossible to disconnect from voice-conference w/o logging out
  * ~~[Issue 133](http://code.google.com/p/bigbluebutton/issues/detail?id=133) Webcam window still visible to other participants after logging out~~
  * ~~[Issue 129](http://code.google.com/p/bigbluebutton/issues/detail?id=129) Client takes too long to test port 1935 and start tunneling~~
  * [Issue 127](http://code.google.com/p/bigbluebutton/issues/detail?id=127) Video stream not properly closing in client
  * ~~[Issue 107](http://code.google.com/p/bigbluebutton/issues/detail?id=107) Cut-and-paste url should give a login error~~
  * [Issue 88](http://code.google.com/p/bigbluebutton/issues/detail?id=88) PDF slide with many symbols causing long delay
  * ~~[Issue 72](http://code.google.com/p/bigbluebutton/issues/detail?id=72) Upon uploading a presentation the first slide does not show~~

Released: August 12, 2009

# 0.5 Release: Apollo 11

Released: July 21, 2009

_Code named in honor of the 40th anniversary of the moon landing_

### New Features
**Desktop Sharing**

Desktop Sharing has been in development for a long time.  We wanted a solution that would work on all three platforms (Mac, Unix, and PC), so we decided to use a Java Applet to grab to send screen updates to the Red5 server.  We then used Xuggler from within Red5 to create a live stream from the incoming images from the applet.

From the presenter's perspective, there is a new screen icon on the top toolbar. Once clicked, the presenter can choose the area of their screen to share.  Clicking on Start Sharing causes this area of their screen to appear on all the clients.  While sharing the presenter can still drag around the window to determine which portion of the screen gets shared.

**Private Chat**

Any participant can now chat privately with anyone else in the room by choosing their name from the drop-down menu in the chat window.

Under the hood, the private chat works in the same way as the public chat, except that each participant has a dedicated shared object on the server to which messages get sent, and to which only they listen to.

### Fixed Issues
Here are the list of issues we fixed on this release:
  * [Issue 109](http://code.google.com/p/bigbluebutton/issues/detail?id=109) Cannot upload twice a file
  * [Issue 101](http://code.google.com/p/bigbluebutton/issues/detail?id=101) Red5 video app has significant delay
  * [Issue 96](http://code.google.com/p/bigbluebutton/issues/detail?id=96) Fixed the thumbnail view in presentation module to be more responsive and user friendly
  * [Issue 94](http://code.google.com/p/bigbluebutton/issues/detail?id=94) Change applet certificate
  * [Issue 93](http://code.google.com/p/bigbluebutton/issues/detail?id=93) deskshare-client should tunnel through port 80
  * [Issue 87](http://code.google.com/p/bigbluebutton/issues/detail?id=87) Logout should close the deskshare module
  * [Issue 85](http://code.google.com/p/bigbluebutton/issues/detail?id=85) Added a zoom slide to presentation module, for users without mousewheel
  * [Issue 84](http://code.google.com/p/bigbluebutton/issues/detail?id=84) Only one instance of the upload window can now be opened.
  * [Issue 78](http://code.google.com/p/bigbluebutton/issues/detail?id=78) Added Desktop Sharing. The presenter can now do a screen-cast
  * [Issue 75](http://code.google.com/p/bigbluebutton/issues/detail?id=75) bbb-setupdev -s (setup samba) now gives the correct path
  * [Issue 5](http://code.google.com/p/bigbluebutton/issues/detail?id=5) Added Private Chat. Participants can now chat privately with any other participant in the conference

### Known Issues
  * [Issue 112](http://code.google.com/p/bigbluebutton/issues/detail?id=112) Desk share video shows the final frame when presenter logs out
  * ~~[Issue 111](http://code.google.com/p/bigbluebutton/issues/detail?id=111) Desk share video has narrow yellow stripe at the top~~
  * ~~[Issue 110](http://code.google.com/p/bigbluebutton/issues/detail?id=110) Deskshare works only when tunneling on Mac OS X~~
  * [Issue 95](http://code.google.com/p/bigbluebutton/issues/detail?id=95) Deskshare app sometimes crashes
  * ~~[Issue 90](http://code.google.com/p/bigbluebutton/issues/detail?id=90) deskshare-app blocks red5 from restarting~~

# Release 0.4

Released: June 12, 2009

Much of the effort in this release was on creating individual packages for the components and distributing the entire package as a [downloadable virtual machine](http://code.google.com/p/bigbluebutton/wiki/BigBlueButtonVM).

Other updates include:
  * BigBlueButton client now supports tunneling through a firewall via port 80
  * Uploading of multiple slides
