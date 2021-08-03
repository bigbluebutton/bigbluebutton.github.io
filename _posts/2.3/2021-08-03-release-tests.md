---
layout: page
title: 'Testing a release'
category: 2.3
date: 2021-08-03 21:59:03
order: 6
---

This document describes manual tests, which ensure release quality. They should
be performed by humans using different browsers. It is usefull to have multiple
humans performing these tests together. You should plan at least an hour to perform
all of these tests.

## Audio tests

### Join audio by microphone

This test ensures that people can talk to each other in a conference. If this
test works, users can connect to freeswitch.

* Join a meeting. You should see a dialog which lets you choose between joining
  by microphone or listen only
* Choose "join by microphone"
* Speak. Other participants should hear you, you should hear other participants
* You should see the names of the speaking participants above the presentation
  area
* You should see an animation in the users list. Speaking users should be
  animated. Silent users should not be animated.
* Press the micophone button in the action bar below the presentation area. This
  should toggle your muted status. If you are muted the microphone symbol
  should be outlined. If you are not muted the microphone symbol should be
  filled.

### Join audio in listen only mode

* Join a meeting. You should see a dialog which lets you choose between joining
  by microphone or listen only
* Choose "listen only"
* If you are the only participant in the meeting you should hear a voice telling
  you that you are the only participant in this meeting
* If there are other participants in the meeting you should hear them speaking.

### Dial-in to a meeting

For this test you need a server which has phone dialin setup.

* Join a meeting. At least one participant needs to join audio, either by
  micorphone or in listen only mode
* Dial-in to the meeting
* Other participants should be able to hear you, and you should hear the others
* Press '0' on the phone dial pad. This should toggle your muted status

### Mute users

For this test multiple users should speak.

* You should see the names of the speaking users in the activity bar above the
  presentation area. Click on the name of one person in the activity bar.
  * If you are moderator: The person you clicked on should be muted. This is
    visible in the activity bar as well in the users list by a crossed out
    red microphone symbol.
  * If you are regular viewer (not moderator): Nothing should happen
* Choose any user from the users list. Click on the name in the users list. A
  menu should open.
  * If you are moderator: The menu should contain an entry "mute user". Click on
    then menu entry. The user should be muted then.
  * If you are regular viewer (not moderator): There should not be an menu entry
    which allows muting the user.

### Mute all users except presenter

* If you are moderator:
  * Next to the users list there is a gear icon. Click on this icon. A menu
    should open. In this menu there should be an entry which allows you to mute
    all users except of the presenter. Click on that entry.
  * All user except of the presenter should be muted.
* If you are regular viewer (not moderator): 
  * there should not be a gear icon next to the users list

## User roles

### Multiple moderators

### Switch presenter

## Video tests

For these tests it is advisable to have at least one user with multiple cameras.
You you don't own multiple cameras, you can install a virtual webcam (for
example using OBS Studio).

### Share video camera

* Click on the camera icon in the action bar below the presentation area
* A dialog should open, allowing you to choose your camera and camera quality
* Select one camera to share and choose the quality
* Click on the share camera button in the dialog
* You should see the video stream of your camera
* Other participants should see your video
* the video stream element should be highlighted in the UI if you speak
* In the video stream there should be a label with your name. Click on that
  label. You should be able to mirror the camera video.
* Click on the camera icon in the action bar again.
  * If you have multiple cameras, the dialog should open again, allowing you to share another camera or
    to unshare the camera
  * If you have only a single camera, the video stream should be terminated
    immediately.

### Share a second camera

* Share a video camera as in the test "Share video camera".
* Click on the camera icon again. Share another camera.
* Other users should see both of your camera.
* Other users should see both of your cameras highlighted if you speak.
* Unshare one camera. You and other users should see only the remaining of your cameras
* Share the second camera again
* Unshare all cameras. Non of your cameras should be visible

## Screen share tests

### Share a window/screen/browser tab

* The presenter should see the screen share icon in the action bar. All other
  users should not see the screen share icon
* The presenter should click on the screen share icon.
* The browser asks the presenter for sharing something.
* Abort the share dialog in the browser
* The presenter should click on the screen share icon again.
* The browser should ask for something to share again.
* Select a window for sharing
* Do something in that window. Other users should see what you are doing
* Resize the window. Other users should see that.
* Stop screensharing by pressing on the screen share icon again
* Repeat the test by 
  * sharing the entire screen
  * sharing only one screen if you have more than one screen
  * share a browser tab, if your browser supports that
* If you browser supports sharing audio with screen sharing test this as well.
  Support for this feature heavily depends on browser capabilities.
  * On Windows with Chrome: Audio sharing should work for screen, window and tab
  * On Linux and MacOS with Chrome: Audio sharing should work for browser tabs
  * All other combinations are not known yet to work
  
### Switching presenter during screen share

* Start some screen sharing
* Some moderator should switch presenter to another user
* The screen sharing should terminate automatically

## Slide and whiteboard tests

### slide navigation

* The presenter should see buttons for slide navigation. All other users should
  not see these buttons
* Switch to another page in the slides
* Other users should see your curson on the slides
* Draw something on the whiteboard. Other users should see that
* Switch to another slide
* The drawing should disappear
* Switch back to the slide where you had drawn something before
* You and all other users shoud see what you had drawn before

### Whiteboard access for individual users

* Grant whiteboard access to a user which is not presenter. Only the presenter
  should be able to do this
* On the whiteboard users should see two cursors. Each cursor should have a
  label with the name of the user who this cursor belongs to
* Each user with whiteboard access should be able to draw
* Revoke whiteboard access from a user which is not presenter. Only the
  presenter should be able to do this. It must not be possible to revoke 
  whiteboard access from the presenter
* The presenter should see the number of users with whiteboard access in the
  toolbar

### Whiteboard access for all users

* Grant whiteboard access to all users. Each user should have a cursor and
  should be able to draw
* New users joining the meeting should not get whiteboard access
* The presenter should be able to revoke whiteboard access from individual users

### Upload slides

* Upload slides in PDF format
* Upload slides in some office format
* Both should work
* You should be able to upload multiple documents at once
* Documents should be converted in background

### Share an external Youtube/Vimeo video

### Share an external mp4 video

## Polls

### Manual polls

* Do some manual polls of all available types
* If you enter a question, users should see the question as well as the answers
* If you start a poll of type user response, the question should be mandatory
* Finish the poll. The results should be drawn on the whiteboard and published
  as a message in the public chat

### Switch presenter during poll

* Start some poll (type does not matter)
* Start the polling (users should be able to give answers)
* Switch the presenter
* The poll should be aborted

### Polls with individual answers

* Start a poll with user response
* Type in something with a colon ':' in the answer.
* In the poll results, the answer should not be cut at the colon
* Type in somethin with unicode characters (emojis for example)
* Similar answers should be grouped together

## Chat

## Shared notes

## Lock settings

## Closed captions
