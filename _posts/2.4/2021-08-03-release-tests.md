---
layout: page
title: 'Testing a release'
category: 2.4
date: 2021-08-03 21:59:03
order: 6
---

This document describes manual tests, which ensure release quality. They should
be performed by humans using different browsers. It is usefull to have multiple
humans performing these tests together. You should plan at least an hour to perform
all of these tests.

### This list of tests contains the [list from version 2.3](/2.3/release-tests.html).

## Audio tests

### Join audio by microphone

This test ensures that people can talk to each other in a conference. If this
test works, users can connect to freeswitch.

- Join a meeting. You should see a dialog which lets you choose between joining
  by microphone or listen only
- Choose "join by microphone"
- Speak. Other participants should hear you, you should hear other participants
- You should see the names of the speaking participants above the presentation
  area
- You should see an animation in the users list. Speaking users should be
  animated. Silent users should not be animated.
- Press the micophone button in the action bar below the presentation area. This
  should toggle your muted status. If you are muted the microphone symbol
  should be outlined. If you are not muted the microphone symbol should be
  filled.

### Join audio in listen only mode

- Join a meeting. You should see a dialog which lets you choose between joining
  by microphone or listen only
- Choose "listen only"
- If you are the only participant in the meeting you should hear a voice telling
  you that you are the only participant in this meeting
- If there are other participants in the meeting you should hear them speaking.

### Dial-in to a meeting

For this test you need a server which has phone dialin setup.

- Join a meeting. At least one participant needs to join audio, either by
  micorphone or in listen only mode
- Dial-in to the meeting
- Other participants should be able to hear you, and you should hear the others
- Press '0' on the phone dial pad. This should toggle your muted status

### Mute users

For this test multiple users should speak.

- You should see the names of the speaking users in the activity bar above the
  presentation area. Click on the name of one person in the activity bar.
  - If you are moderator: The person you clicked on should be muted. This is
    visible in the activity bar as well in the users list by a crossed out
    red microphone symbol.
  - If you are regular viewer (not moderator): Nothing should happen
- Choose any user from the users list. Click on the name in the users list. A
  menu should open.
  - If you are moderator: The menu should contain an entry "mute user". Click on
    then menu entry. The user should be muted then.
  - If you are regular viewer (not moderator): There should not be an menu entry
    which allows muting the user.

### Mute all users except presenter

- If you are moderator:
  - Next to the users list there is a gear icon. Click on this icon. A menu
    should open. In this menu there should be an entry which allows you to mute
    all users except of the presenter. Click on that entry.
  - All user except of the presenter should be muted.
- If you are regular viewer (not moderator):
  - there should not be a gear icon next to the users list

## User roles

### Multiple moderators

- moderator status should be indicated by a rectangular icon next to the name
  of each person in the users list. Regular viewers should have a rounded icon
  next to the name
- If you are moderator:
  - in the users list click on a name of a viewer (not moderator)
  - grant other users moderator access
  - verify that moderator status icon has changed in the users list of all participants
  - remvoke moderator access from other users
  - verify that moderator status icon has changed in the users list of all participants
- If you are regular viewer (not moderator)
  - You should not be able to switch moderator status of other users

### Switch presenter

- If you are moderator:
  - in the users list click on a name of someone else
  - click on "Make presenter" in the menu
  - The person you have chosen should be presenter. Verify that:
    - the presenter status is indicated in the users list
    - the person you chose could switch the slides, upload slides and so on
    - Other moderators who are not presenter should have only the "Take presenter" option
      in the (+) Action menu.
- If you are regular user (not moderator):
  - You should not be able to make someon else presenter

## Video tests

For these tests it is advisable to have at least one user with multiple cameras.
You you don't own multiple cameras, you can install a virtual webcam (for
example using OBS Studio).

### Share video camera

- Click on the camera icon in the action bar below the presentation area
- A dialog should open, allowing you to choose your camera and camera quality
- Select one camera to share and choose the quality
- Click on the share camera button in the dialog
- You should see the video stream of your camera
  - If you select one of the backgrounds, both you and others will see the background applied in your video
- Other participants should see your video
- You should see in the Participants list who is sharing their webcam ('webcam' in the user line)
- the video stream element should be highlighted in the UI if you speak
- In the video stream there should be a label with your name. Click on that
  label. You should be able to mirror the camera video.
- Click on the camera icon in the action bar again.
  - If you have multiple cameras, the dialog should open again, allowing you to share another camera or
    to unshare the camera
  - If you have only a single camera, the video stream should be terminated
    immediately.

### Share a second camera

- Share a video camera as in the test "Share video camera".
- Click on the camera icon again. Share another camera.
- Other users should see both of your camera.
- Other users should see both of your cameras highlighted if you speak.
- Unshare one camera. You and other users should see only the remaining of your cameras
- Share the second camera again
- Unshare all cameras. Non of your cameras should be visible

## Screen share tests

### Share a window/screen/browser tab

- The presenter should see the screen share icon in the action bar. All other
  users should not see the screen share icon
- The presenter should click on the screen share icon.
- The browser asks the presenter for sharing something.
- Abort the share dialog in the browser
- The presenter should click on the screen share icon again.
- The browser should ask for something to share again.
- Select a window for sharing
- Do something in that window. Other users should see what you are doing
- Resize the window. Other users should see that.
- Stop screensharing by pressing on the screen share icon again
- Repeat the test by
  - sharing the entire screen
  - sharing only one screen if you have more than one screen
  - share a browser tab, if your browser supports that
- If you browser supports sharing audio with screen sharing test this as well.
  Support for this feature heavily depends on browser capabilities.
  - On Windows with Chrome: Audio sharing should work for screen, window and tab
  - On Linux and MacOS with Chrome: Audio sharing should work for browser tabs
  - All other combinations are not known yet to work
- The presenter sharing screen should see a preview with reduced mirror effect if they are sharing the window (screen) which includes the BigBlueButton session

### Switching presenter during screen share

- Start some screen sharing
- Some moderator should switch presenter to another user
- The screen sharing should terminate automatically

## Slide and whiteboard tests

### slide navigation

- The presenter should see buttons for slide navigation. All other users should
  not see these buttons
- Switch to another page in the slides
- Other users should see your curson on the slides
- Draw something on the whiteboard. Other users should see that
- Switch to another slide
- The drawing should disappear
- Switch back to the slide where you had drawn something before
- You and all other users shoud see what you had drawn before

### Whiteboard access for individual users

- Grant whiteboard access to a user which is not presenter. Only the presenter
  should be able to do this
- On the whiteboard users should see two cursors. Each cursor should have a
  label with the name of the user who this cursor belongs to
- Each user with whiteboard access should be able to draw
- Revoke whiteboard access from a user which is not presenter. Only the
  presenter should be able to do this. It must not be possible to revoke
  whiteboard access from the presenter
- The presenter should see the number of users with whiteboard access in the
  toolbar

### Whiteboard access for all users

- Grant whiteboard access to all users. Each user should have a cursor and
  should be able to draw
- New users joining the meeting should not get whiteboard access
- The presenter should be able to revoke whiteboard access from individual users

### Upload slides

- Upload slides in PDF format
- Upload slides in some office format
- Both should work
- You should be able to upload multiple documents at once
- Documents should be converted in background

### Share an external Youtube/Vimeo video

- choose a video URL from a supported video CDN like Youtube or Vimeo
- as a presenter choose "share external video" from the actions menu
- paste in the selected video URL
- playback of the video should start, ensure that the video starts for all
  participants in the meeting
- pause the video, ensure that it pauses for all participants. Compare the
  playback time of the video. It should be synchronized
- play the video again. All participants should see the video playing
- skip to some point in the timeline of the video. It should skip in the
  timeline for all participants
- terminate sharing of the video. No participant should see the shared
  video anymore
- Share a video again
- switch the presenter
- playback of the external video should be terminated immediately for all
  participants

### Share an external mp4 video

- Choose a video URL for an MP4 or WebM video
- ensure that browsers can play the video. For MP4 videos this depends on
  the settings chosen during video encoding. Not all browser can play all mp4
  videos
- repeat the steps from "Share an external Youtube/Vimeo video"

## Polls

### Manual polls

- Do some manual polls of all available types
- If you enter a question, users should see the question as well as the answers
- If you start a poll of type user response, the question should be mandatory
- Finish the poll. The results should be drawn on the whiteboard and published
  as a message in the public chat

### Switch presenter during poll

- Start some poll (type does not matter)
- Start the polling (users should be able to give answers)
- Switch the presenter
- The poll should be aborted

### Polls with individual answers

- Start a poll with user response
- Type in something with a colon ':' in the answer.
- In the poll results, the answer should not be cut at the colon
- Type in somethin with unicode characters (emojis for example)
- Similar answers should be grouped together

### Polls with 'anonymous' answers

- When starting a poll select Anonymous Poll ON (slider above StartPoll)
  - Meeting participants should see a label on the polling options window indicating that the poll is anonymous
  - The presenter (in fact nobody) should not be able to associate an answer to a person during the polling process
  - After publishing the poll, the results (slide annotation/public chat report) should not allow associating a poll answer to a user

## Chat

### Scrolling

- Type in some random messages in the public chat until there is a scroll bar in the chat panel
- Scroll down to the last message
- when someone else sends a chat message, the new message should appear after the other messages
- The recently typed chat message should be visible without user interaction (it should scroll down)
- scroll up a little bit, so that the last chat message is no longer visible
- let someone else send a chat message
- The messages in the chat panel should _not_ scroll down to the latest chat message

### Message indicator

- Close the chat panel
- let someone else send a chat message
- you should see a new message indicator next to the name of the chat showing the number of unread chat messages
- you shoud see an indicator (red bullet) next to the users and messages toggle
- the indicators should disappear as soon as you read the messages
- repeat this for private chats

## Shared notes

- Open the shared notes
- Type in something
- Multiple users should be able to type at the same time
- Users who did not open the shared notes should see an indicator next to ne shared notes button
- the indicator shoudl disappear as soon as they open the shared notes

## Lock settings

- To open the lock settings dialog open the manage users menu (gear icon next to the users list)
- choose lock viewers
- select the options as described in the following tests. Settings will take effect as soon as the dialog is closed by clicking on the Apply button
- Lock settings apply to regular viewers (not moderators)
- For each test:
  - You should be able to unlock individual users
  - Click to a name of a locked user in the users list. Choose Unlock user from the menu
  - the setting should not be in effect for the chosen user
  - Lock the user again
  - the setting should be in effect for the chosen user again

### Share webcam

- let some regular users (non-moderators) share their webcam
- lock the share webcam setting
- regular users should _not_ be able to share their webcam. If they had shared their webcam before, the webcam share should be terminated
- moderators should be able to share their webcam
- unlock the share webcam setting
- regular users should be able to share their webcam. Cameras from users who had shared their webcam before this test should _not_ start automatically

### See other viewers webcams

- For this test you need at least 3 participants, (better 4):
  - at least 2 regular users
  - at leas 1 moderator (better 2)
- all users should enable their webcams
- lock the see other users webcams setting
- moderators should see the webcam of all users
- regular users should ony see the webcam of moderators and their own camera. They shoud _not_ see the camera of other regular viewers
- unlock the setting again
- regulat users should see the cameras of all participants again. Camera streams should appear automatically without interaction from the regular users

### Share microphone

- lock the setting
- Regular users should be muted and should not be able to unmute themselves. The mute/unmute button should disappear from the action items
- Moderators should be able to allow individual users to unmute themselves:
  - Click to a name of a locked user in the users list. Choose Unlock user from the menu
  - The mute/unmute button should appear for this user
  - Lock the user again
  - The mute/unmute button should disappear and the user should be muted
- unlock the setting
- All users should be able to unmute themselves
- no user should be unmuted automatically

### Send public chat messages

- lock the setting
- regular users should not be able to send chat messages in the public chat. They should be able to send private chat messages
- The input element for chat messages should be unusable. An message below the input element should explain that the public chat is locked
- moderators should be able to send public chat messages
- unlock the setting
- all users should be able to send public chat messages

### Send private chat messages

- for this test you need at least 2 regular users (not moderators)
- lock the setting
- regular users should not be able to send chat messages to other regular users
- regular users should be able to send messages to moderators
- moderators should be able to send messages to all users
- unlock the setting
- everyone should be able to send messages to anymone

### Edit shared notes

- lock the setting
- regular users should not be able to change the content of the shared notes
- they should be able to see changes in the shared notes which are written by moderators (or unlocked users)
- unlock the settings
- everyone should be able to change the content of the shared notes

### See other viewers in the Users list

- for this test you need at least 2 regular users (not moderators)
- lock the settings
- regular users should see only their name and the names of all moderators in the users list
- moderators should see the names of all users in the users list
- unlock the setting
- everyone should see the names of all users again

## Breakout rooms

### Users choose their breakout room

- as a moderator:
  - open the manage users menu (gear icon next to the users list)
  - Choose "Create breakout rooms"
  - check the options "Allow users to choose a breakout room to join"
  - do not assign users to breakout rooms
  - Create breakout rooms
- All users should be able to choose a breakout room
- Breakout rooms should open in a different tab in the browser
- Audio should be disconnected from the main room and connected in the breakout room
- If the breakout room terminates users should be (audio) connected to the main room.
- If you modified the default rooms names, these names should be visible to meeting participants.

### Moderators choose breakout rooms

- as a moderator:
  - open the manage users menu (gear icon next to the users list)
  - Choose "Create breakout rooms"
  - do not check the options "Allow users to choose a breakout room to join"
  - assign users to breakout rooms
  - Create breakout rooms
- All users should be asked to join the specified breakout room
- Breakout rooms should open in a different tab in the browser
- Audio should be disconnected from the main room and connected in the breakout room
- If the breakout room terminates users should be (audio) connected to the main room.
- If you modified the default rooms names, these names should be visible to meeting participants.

### Moderators modify how long the breakouts will remain

- as a moderator:
  - Open the manage users menu (gear icon next to the users list)
  - Choose "Create breakout rooms"
  - Set the duration to 10 minutes
  - Proceed with the breakouts creation
  - After the breakouts are active, use the Breakout Rooms menu and just above the bottom of the panel (where End all breakout rooms is located), you should see a + button beside the Duration countdown. Use the controls to extend the duration of the breakouts. The breakouts duration shold be extended (but should not exceed the pre-configured end of the main room (if any))

## Closed captions

- as a moderator:
  - open the manage users menu (gear icon next to the users list)
  - choose "Write closed captions"
  - Select a language
  - a panel should open with an embedded etherpad
  - You should be able to write in this pad
- as anyone else:

  - A new button (CC) should appear in the actions bar
  - Click on that button
  - You should be able to choose a language. In the captions language select box you shoudl see only those languages for which moderators have started writing closed captions
  - If someone writes closed captions, they should appear in the presentation area as an overlay

## Layout Manager

### Set a layout for yourself

### Push a layout to all participants

## Learning Dashboard

<!-- perhaps not the place for this as it's not achievable via browser

- The Learning Dashboard should only be available if you have `learningDashboardEnabled=true` in `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` or the configuration `/etc/bigbluebutton/bbb-web.properties` (which trumps the setting from `bigbluebutton.properties`)
- The Learning Dashboard should not be available for a meeting created with `learningDashboardEnabled=false` regardless of the server setup.


 -->

- The Learning Dashboard should not be available after `learningDashboardCleanupDelayInMinutes=N` N minutes (check bbb-web configuration)
- Only moderators should have access to the Learning Dashboard. Join a meeting as viewer, try to access the dashboard (via link sent to you from a moderator), you should not be able to view information about the session.
- Join as a viewer, have a moderator promote you to moderator. Try viewing the dashboard (you should be able to). Have the moderator demote you back to viewer. There should be no more live updates for you (every 10s typically) and if you were to refresh the dashboard page, you should no longer be able to access the information.

- ## Recording playback

  ### Recording’s public chat includes polling result

  ### Recording’s public chat includes links to external videos shared in the meeting
