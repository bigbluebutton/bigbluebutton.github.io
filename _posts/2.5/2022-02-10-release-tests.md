---
layout: page
title: 'Testing a release'
category: 2.5
date: 2022-02-10 21:59:03
order: 6
---

This document is meant to be a combination of manual and (labeled so) automated tests, listed per feature of BigBlueButton.

TODO:

- ensure all test cases from [BigBlueButton's 2.4 test plan](https://docs.bigbluebutton.org/2.4/release-tests.html) are integrated here.
- include the automated tests developed during 2.4 and label as `(automated) ...`
- try to keep this document as useful as possible, even at the expense of it looking polished... (i.e. if you think of an edge case that is good to be tested, let's include it, even if it's not super well defined)

The <b>automated tests</b> are only a portion of the testing done before a release. Ideally they should be triggered often, for example when testing pull requests, or once a day automatically.

The <b>manual tests</b> really help to ensure release quality. They should
be performed by humans using different browsers. It is usefull to have multiple
humans performing these tests together. You should plan at least an hour to perform
all of these tests.

## Presentation

### Uploading a Presentation

1. As a moderator, select Moderator/Presenter Action menu (+)

2. choosing upload Presentation

3. Uploading presentation options:

   - using Drag and Drop
   - Upload presentation using File Explorer(browsing for files.)

4. Presentation should appear on All Clients in sync with updates (PAAC)

### Enabling and Disabling Presentation Download

1. Select Moderator/Presenter Action menu

2. Choose Upload Presentation

3. Set current file as enabled/disabled for download:

   3.1 Setting current file as enabled for download will allow users to download current file.

   3.2 Removing presentation for download will no loner allow users to download current file.

### Deleting Presentation

1. Select Moderator/Presenter Action menu

2. Choose Upload Presentation

3. Selecting trash icon to delete

4. Choose confirm

### Uploading multiple presentations

1. Select Moderator/Presenter Action menu

2. Choose Upload Presentation

3. Upload multiple presentations at once using Browse for files option

4. Set a current presentation

5. select upload

(Note : Current file selected should display to the presentation area)

### Navigation

1. Locate slide navigation bar

2. Select next slide (>)

3. Select previous slide (<)

4. Use drop down to select a specific slide.

5. Presentation should appear on All Clients in sync with updates (PAAC)

### Zoom

1. Zoom in (+) and out (-) by clicking in the buttons or using the scroll

2. Using the Pan tool, move document around while zoomed in.

3. Presentation should appear on All Clients in sync with updates (PAAC)

### Draw and Pan

1. Zoom in by (+)

2. Changing pan tool to pen tool

3. Draw in the whiteboard area

4. Hold down the space while moving mouse to pan.

### Minimizing and Hiding presentation

1. Select Share webcam.

2. Selecting hide presentation icon or Click Minimize presentation area.

3. Presentation is minimized.

(Note : Presentation area will auto expand when the presenter engages Screen Sharing or YouTube Link Share)

### Restore Presentation

1. Clicking on Share webcam.

2. Minimizing presentation.

3. Selecting restore presentation.

4. Presentation should be restored.

### Full Screen option

1. Click on full screen button

2. Draw on the whiteboard

3. select Escape key on local keyboard.

Application should go to full screen, then back to normal screen.

### Make viewer a presenter

1. Click viewer icon from users list

2. Selecting make presenter for the user.

Viewer selected should have all presenter capabilities and presenter Icon should appear over user icon in the users list.

### Taking presenter status back

1. In order to take back the presenter, can be done in following ways:

   1.1

- Click on your user icon in users list.
- choose take presenter

  1.2

- Select Moderator/Presenter Actions menu (+)
- choose take presenter

Selected user or moderator should now have presenter capabilities and presenter icon should appear over user icon in the users list.

## Webcams

### Joining Webcam

1. Click on share webcam icon.

2. Allow browser permissions if prompted.

3. Select your webcam.

4. Choose the video quality from the available option.

5. Click Start sharing.

A small webcam video should show up and the camera share will start highlighting.

### Make webcam full screen

- Click the full screen icon on the desired user will display in full screen.

- Pressing ESC key to exit the full screen mode, will bring back the video to the normal size and will leave the full screen.

### Focus and removing focus option on webcam

A. (Note: There must be 3 (three) or more webcams shared for testing purpose.)

1. Joining with at least 3 webcams.

2. Hover over individual's webcam user name

3. Select drop down and choose focus.

Webcam chosen should enlarge (larger than the other webcams but not full screen), while other shared webcams decrease in size.

B. With an enlarged or focused webcam:

1. Hover over the focused webcam username.

2. Selecting drop down and choose unfocus.

### Maximize webcams

- With webcams shared, click on the Hide Presentation icon to minimize presentation area and maximize webcam.

The presentation will be minimized, and a button will be highlighted to restore the presentation.

### Drag webcams

1. Share webcams

2. Drag to middle, top or bottom.

3. Release webcams in greyed area on screen.

Webcams will be moved when mouse is released. (Note: When only one webcam is shared user can drag and drop webcam anywhere in the presentation area)

### Switching to Default webcam

1. Click the share/stop sharing webcam icon twice (once to remove current webcam connection and again to re-prompt the webcam join modal)

2. Allow browser permissions if applicable

3. Choose webcam (switch from previous default device)

4. choose the video quality

5. click on Start Sharing

### Resizing one or multiple Webcams

A. Resizing one single webcam.

- Share a webcam
- Drag the bottom of the webcam window
- Increase or Decrease the size of the webcam.

The webcam will be resized as per the size we want.

B. Case of more than one webcam.

- Share atleast 2 webcams
- Drag the bottom of the webcams container
- Increase or Decrease the size of the webcams.

The webcams should be resized as per the size we want.

### Stop Sharing webcam

- Click the Share/Stop sharing webcam icon.

The webcam sharing will be unhighlighted and the webcam sharing will stop.

## Screenshare

### Sharing screen in Full Screen mode

1. Clicking on share screen icon

2. select full screen mode or share entire screen (browser dependent)

3. Choose a screen to share

4. select share

The screen is displayed for the presenter/moderator and the viewer,
while the sharescreen button is highlighting and displayed only for the presenter and (for the viewer or the moderator, the presentation will be replaced with the screensharing)

### Sharing screen in Application Mode

1. Click on share screen icon

2. Select application mode

3. choose application to share (note : application must already be open on the desktop)

4. select screen to share

5. select share

The screen is displayed for the presenter and the viewers, the screen share updates for the viewers when the presenter makes changes in the application - no secondary windows or pop ups appear.

Note : When sharing in application mode any secondary windows, pop up messages or search menus are not transmitted to the viewer even if they generate from within the application being shared, and When using microsoft office applications, while using application mode any and all updates to the application are not transmitted by the browser to the viewers

### Stop screen sharing

- Click on stop sharing screen toast message

  OR

- select screen share / stop screen share icon

The screen sharing stops, a sound effect of disconnection is heard and the presentation is restored.

## Breakout rooms

### Moderators creating breakout rooms and assiging users

1. Launching create breakout rooms from Manage users (cog wheel in user lists.)

2. Choosing Number of rooms and duration for the breakout room.

3. Assigning users in 2 different ways:

   3.1 Randomly assigning users to the breakout rooms by clicking on Randomly assign option.

   3.2 Chosing Drag and drop users to the rooms.

4. Breakout rooms are created and accept invite screen is displayed to all the viewers, while only the moderators who were assigned to rooms manually receive the invite.

5. All the configured settings appear exactly as set in the pre-creation settings.

### Moderators creating breakout rooms and users Choosing the breakout rooms

1. Launching create breakout rooms from Manage users (cog wheel in user lists.)

2. Choosing Number of rooms and duration for the breakout room.

3. Selecting allow users to choose a breakout room to join.

4. Breakout rooms are created and accept invite screen is displayed to users, allowing them to chose the room they want to join.

5. All the configured settings appear exactly as set in the pre-creation settings.

### Logout from a Breakout Room

1. In the breakout room, click on the option in the top right corner and selecting logout from breakout room.

2. The Breakout Room Tab should close directly after clicking Logout,
   without getting redirected to the feedback screen.

### Joining Breakout room as a Moderator

1. click on breakout rooms control panel

2. click join room

3. choose audio format to join breakout room OR (2) click join audio to toggle audio only.

4. Onclick on join room, a new window is opened with the name of the room clicked and on onclick on join audio, call icon is highlighting you are now in the audio conferance.
   (Note : The join audio toggle format only works when the main room has an audio source connected)

### Switching Breakout rooms

1. click on breakout rooms control panel and selecting join room and choose audio format to join breakout room.

(Note : In case the free join is enabled)

2. As a viewer:

- click on breakout rooms menu
- click on a room to join
- join any room
- go back to the main presentation screen
- go to BreakoutRooms menu
- click to join another room

(Note : you're able to join other rooms and with one single Viewer by room)

3. Aa a moderator:

- click on breakout rooms menu
  -click on a room to join
  -join any room
  -go back to the main presentation screen
  -go to BreakoutRooms menu
  -click to join another room

(Note : you're able to join other rooms and with one single Viewer by room)

4. In case the free join is disabled, repeating the above steps for both the viewers and moderators.
   (Note: Viewers will not be able to join other rooms but moderators can join any room.)

### End BreakoutRooms

1. Click End all breakoutrooms in the BreakoutRooms control panel.

2. All of the the breakoutrooms end and all of the users are back to
   the main presentation room and if the User has already Audio ON,
   he won't get prompted the Audio modal.

## Audio

### Joining audio

Click microphone and allow for browser permissions if applicable
and Verify if you can hear yourself in the echo test and click Yes.

- You will be directed to the audio bridge and your microphone and avatar in the users list highlights as you speak.

### Mute/unmute

Click on microphone icon several times to mute/unmute yourself.

- User hear you are now muted/your are now unmuted sound and the microphone stops highlighting when you are muted.

#### As a moderator

Select a user joined with microphone in the Users list and click on mute/unmute user.

- You hear you are now muted/your are now unmuted sound and the microphone stops highlighting when you are muted.
  (Note : In production Moderator cannot unmute other users unless enabled at the account level)

### Leaving audio

Click on the phone icon to hang up.

- User hear the disconnect sound and is no longer in the audio.

### Cancel Audio Join

Click on microphone and click 'x' in Audio dialog.

- User will be back to main screen with phone icon unhighlighted.

### Listen Only Mode

Click Listen Only and join another user using the microphone.

- The Listen Only icon will appears and you hear yourself as you speak (microphone will be picked up from other user).

### Testing Microphone

Click on microphone and go through echo test and then click No.

- You should see Change your audio settings dialog

### Choosing different sources

1.  In the Change your audio settings, choose different microphones
2.  choose different speakers
3.  click Play test sound
4.  click Retry and then click Yes.

- You should be able to use different microphones and speakers and hear yourself in the echo test with varying combinations of microphone/speakers. When you click 'Yes', your microphone should be highlighting.

#### Joining with phone

- Joining the audio conference with a phone: The viewer should mute/unmute with the moderator's actions.

- For mute/unmute: Press the '0' key on the phone's keypad to mute/unmute (Note : In production Moderator cannot unmute other users unless enabled at the account level)

- For moderator mute/unmute dial in (select dial in from users list and choose mute/unmute) : The audio state should mute/unmute accordingly. (Note : In production Moderator cannot unmute other users unless enabled at the account level )

- Remove dial in : As a moderator click the phone number in the Users list and choose remove user. The phone hangs up and user no longer appears in the Users list

### Talking Indicator

Enable Microphone : This will cause a user name to appear on left top corner of the Presentation Area whenever a User talks.

#### Muting user from Talking Indicator

1.  As Moderator: Click on the name of User appearing in top left corner of the Presentation area.

- The Talking User gets muted.

2.  As Viewer: Click on the name of User appearing in top left corner of the Presentation area.

- The Talking User should not get muted

## ClosedCaptions

### Start Recording

- Select Start/Stop recording.

### Launching Closed Captions Menu

(Note : Only (Presenter/Moderator) can perform launching Closed Captions Menu)

1. Click on manage users icon (cog wheel in users list)

2. select write closed captions

3. Choose captions language to use

4. select start

5. Type text into closed captions panel

The Closed Captions is loaded in the selected language and Start dictation button will be highlighting.

### ClosedCaptions(CC) formatting tools

(Note : Only (Presenter/Moderator) have the ability to use CC formatting tools)

1. Launching Closed caption.

2. Write text into closed captions panel

3. Testing all of the available formatting tools that are available (for example: bold, Italic,..)

Whatever is typed as text, should be shown exactly as presenter/moderator wants it. An element of list should show as element of list, and returning to normal writing should show without any errors. Every single word typed will be shown instantly.

### Viewing/Hiding Closed captions

1. Presenter/Moderator/Viewer can click on (CC) button appearing in the left bottom of the presentation screen to show the Closed Captions

2. Choose the language, text and font settings.

3. select on start to begin viewing Closed Captions.

The Closed Captions are appearing in the screen and the (CC) button is highlighting.

4. Clicking on (CC) button again will hide the Closed Captions.

The Closed Captions will not be shown anymore in the screen
and the (CC) button will be unhighlighted.

## Whiteboard

### Using Pen tool

1. Choose pen tool option from whiteboard tools.

2. Draw in the whiteboard area.

Presentation should appear on all Clients in sync with updates(PAAC).

### Changing pen tool thickness

1. Choose pen tool

2. Select line thickness from options

3. Draw in the whiteboard area

Presentation should appear on all Clients in sync with updates(PAAC).

### Changing pen tool colour

1. Choose pen tool

2. select colour from options

3. Draw in the whiteboard area

Presentation should appear on all Clients in sync with updates(PAAC).

### Use shape tools

1. Selecting different available shape tools such as rectangle, triangle, ellipse , line.

2. Drawing with each shape tool on the whiteboard area.

Presentation should appear on all Clients in sync with updates(PAAC).

### Changing shape tool thickness and color

1. Once, a shape tool is selected, tool thickness or color can be changed from the given option and drawn in the presentation area.

2. Different available shape tools can be selected and their thickness and color can be varied.

### Using text tool

1. Choose text tool from whiteboard tools

2. create a text box

3. Type text on it.

Presentation should appear on all Clients in sync with updates(PAAC).

### Undo last annotation

1. Make annotations in the whiteboard area

2. choose undo last annotation.

Presentation should appear on all Clients in sync with updates(PAAC).

### Clear all annotations

1. Make annotations in the whiteboard area

2. choose clear all annotations.

Presentation should appear on all Clients in sync with updates(PAAC).

### Multi-user whiteboard

- As a Presenter, enable multi-user whiteboard and drawing with each client.

  A. Viewers can draw too and Presentation Appears on All Clients in sync with updates.

  - As a viewer erase all whiteboard marks.
    (Note : Only viewer's whiteboard marks are erased.)

- As a presenter, disable multi-user whiteboard, viewers can no longer draw.

- As presenter, disable multi-user whiteboard and click on trash icon, all whiteboard marks disappear.

## YouTube Video sharing

(Note: Only Presenter can perform below functions.)

### Starting YouTube Video sharing

1. Click on the moderator/presenter action menu (+) button

2. Insert a Youtube video link in the popup window appearing on screen.

3. click share a new video button.

The Youtube video chosen will be played in the presentation stream.

### Volume/Skipping/Pausing

- Presenter should be available to perform all the available commands/options of the Youtube video such as muting the video, decreasing or increasing the volume and pausing or Resuming the video.

The options should work fine as watching a regular youtube video on the Youtube Website.

### Playing another Video

1. click on the moderator/presenter action menu (+) button

2. Click on stop Sharing Youtube Video

3. Clicking again on the highlighting (+) button

4. Sharing youtube video

5. Insert a youtube video link in the popup window appearing on screen.

6. click share a new video button.

The current playing video will stop, and the presentation returns to show the current slide and after clicking share a new video button, the new video will start playing.

### Stoping Youtube Video Sharing

1. Click on the moderator/presenter action menu (+) button

2. Click stop Sharing Youtube Video.

The current playing video will stop, and the presentation returns
to show the current slide.

## Shared Notes

### Using shared notes panel

(Note: Only Presenter/Moderator can perform this function.)

1. Select shared notes to open panel.

2. Begin writing in the shared notes panel.

Notification appears to indicate share notes is in use, viewers/other users should see content updating when they open and view shared notes from their local interface.

### Using shared notes formatting tools

(Note: Only Presenter/Moderator can perform this function.)

1. Type in the shared notes panel

2. Use the available formatting tools (such as bold, italic, underlined etc.)

3. Make a bulleted list

4. Make a numbered list

Viewers/other users should see content updating when they open or view the shared notes from their local interface

### Use/contribute to shared notes

1. As a viewer, select shared notes to open panel.

2. Begin writing in the shared notes panel.

Shared notes should update with edits or contributions made by viewers/other users.

### Local view

- Viewer and other moderators local view, should see a notification to indicate Shared Notes are in use.

### Exporting Shared notes

1. Selecting "export"

2. Choosing available format, should work with all the formats.

3. Save as to local device

Share notes should export and download in the chosen format.

## Lock Settings

### Webcam

1. As a moderator, click on the manage users list cog

2. Click on ON/OFF Webcam

3. As a Viewer, try to click or enable Webcam(turn ON) and Viewers whose Webcams are ON, automatically turns OFF for all Viewers.

- Once Webcam Lock is turned ON, none of the Viewers is able to turn ON their Webcams and all the Viewers Webcams already turned ON should all turn OFF.

4. As a new Viewer joins, he shouldn't be able to turn
   ON his Webcam

- All the newly joining Viewers should get affected with the Webcam Lock Setting

5. As a moderator, try to turn ON/OFF their Webcams.

- Moderator should be able to turn ON/OFF their webcams.

6. Checking if a demoted Moderator, should not be able to turn
   ON his Webcam, and if already with Webcam turned ON, it should automatically turn OFF.

Note : All the newly joining Moderators should be freely able to turn ON/OFF their Webcams

### See other viewers webcams

1.  Click on the user list cog

2.  click ON/OFF Webcam as a Moderator and as a Viewer

3.  check if a Viewer can see other Viewers Webcams

4.  check if a Viewer can see Moderators Webcams

5.  check if a demoted Moderator Webcam is visible to other Viewers and if he can see other Viewers Webcams

6.  check if a promoted Viewer is now able to see other Viewers Webcams

- Once See other Viewers Webcams is turned ON, none of the Viewers can see other Viewers Webcams

- All the promoted Viewers can see the other Viewers Webcams

- All the demoted Viewers aren't able to see the other Viewers Webcams

- All the newly joining Moderators should be freely able to see other Viewers Webcams

- All the newly joining Viewers should be unable to see other Viewers Webcams.

### Microphone

1. Click on the user list cog

2. Click ON/OFF Webcam as a Moderator and as a Viewer

3. Check if a Viewer can join the audio conferance with
   Microphone or not

4. Check if a Viewer can click to join conferance with
   Microphone or not

5. Check if a demoted Moderator is affected with the Lock of
   the use of the Microphone or not

6. Check if a promoted Viewer is affected with the Lock of
   the use of the Microphone or not.

- Once Microphone Lock is enabled, none of the Viewers can use his Microphone

- All the promoted Viewers can unmute their Microphones

- All the demoted Moderators can't unmute their Microphones

- All the newly joining Moderators should be freely able to mute/unmute their Microphones

- All the newly joining Viewers should be unable to unmute their Microphones.

### Public chat

1. Click on the user list cog

2. Click on Public Chat Tab as a Moderator and as a Viewer

3. Check if a Viewer can write a message in the Public Chat
   box

4. Check if a Viewer can click the Send Message Button

5. Check if a demoted Moderator can send a message in
   Public Chat

6. Check if a promoted Viewer can send a message in Public
   Chat

- Once Public Chat Lock is enabled, none of the Viewers can send a Public Chat
  message

- All the promoted Viewers can send a Public Chat messages

- All the demoted Moderators can't send a Public Chat message

- All the newly joining Moderators should freely be able to send messages in Public Chat

- All the newly joining Viewers should be unable to send Public Chat messages

### Private chat

1. Click on the user list cog

2. Click on a Viewer to Private Chat him

3. Check if a Viewer can send a Private Chat message to
   another Viewer

4. check if on Viewer's click on another Viewer, there will be
   Start Private Chat button displaying or not

5. Check if a demoted Moderator can send Private Chat
   message or not to another Viewer

6. Check if an already open Private Chat Tab with another
   Viewer is still open or not

7. Check if a promoted Viewer is now able to send
   Private Chat message or not

- Once Private Chat Lock is enabled, none of the Viewers can send Private Chat messages to others Viewers anymore

- All the promoted Viewer can send a Private Chat messages to the Viewers

- All the demoted Moderators can not send anymore Private Chat messages to the other Viewers

- All the newly joining Moderators should freely be able to send messages in Private Chat to the Viewers

- All the newly joining Viewers should be unable to send Private Chat messages to the other Viewers

- On a Viewer click on another Viewer, he should not be able to see any available user option

- On a Moderator click on a Viewer, he should be able to see the user options

- If there was an existing open private chat tab between 2 users, they should be unavailable to Viewers when the Lock is enabled.

### Shared notes

1. Click on the user list cog

2. Click on a Shared Notes as a Viewer

3. Check if a Viewer can write in Shared Notes

4. Check if on click on Shared Notes a Viewer can Export
   the Shared Notes

5. Check if a demoted Moderator can write in Shared Notes

6. Check if a Viewer is already able to write in Shared Note at Shared Notes Lock, it should reload for him with avoiding him to write in Shared notes or even see the writing tools

7. Check if at a Viewer promotion to Moderator, the Shared Note should reload for him with granting him access to write in Shared Notes.

- Once Shared Notes Lock is enabled, none of the Viewers is able to write or to modify
  text neither

- All the promoted Viewers can write in Shared Notes

- All the demoted Moderators can not write in Shared Notes

- All the newly joining Moderators should freely be able to write in Shared Notes

- All the newly joining Viewers should be unable to write in Shared Notes or to use the writing tools neither.

### See other viewers in the Users list

1. Click on the user list cog

2. Check if a Viewer can see other Viewers in the Users list

3. Check if a Viewer can see Moderators in the Users list

4. Check if a demoted Moderator is able to see other Viewers
   in the Users list

5. Check if a promoted Viewer is now able to see other
   Viewers in the Users list

- Once See other viewers in the Users list is turned ON, none of the Viewers can see
  other Viewers in Users list

- All the promoted Viewers can see the other Viewers in the Users list

- All the demoted Viewers aren't able to see the other Viewers in the Users list

- All the newly joining Moderators should be freely able to see other Viewers in the Users list

- All the newly joining Viewers should be unable to see other Viewers in the Users list

### Unlock a specific user

1. Click on the user list cog

2. Block some feature

3. Go back to users list

4. Click in a user and select unlock user

- You can completely unlock a specific student and let the others locked yet

- The unlocked user must have all features unlocked and other users must keep locked

## Chat (Public/Private)

### Public message

1. Click on Public Chat Tab

2. Type a message in the text box

3. Press Enter key or click the send button

A message should be sent to the public channel and can be seen by any type of user.

### Private message

1. Click on any available user

2. Click on Start a Private Chat

3. Type a message in private chat text box

4. Press enter or click on send button.

A private message will be sent to the user we chose from the online users, and its been sent in a new message tab with the name of the selected user.

### Chat Character Limit

1. Click on public chat tab

2. Enter max number of characters (max message length is 5000 per single message)

A Warning message should appear to inform user message is over max limit.

### Sending Empty chat message

1. Click on public chat tab

2. Hit enter or select send

3. Type in public chat and erase

4. Press enter or select send button.

Message will not be send and a warning message will be displayed "The message is 1 characters(s) too short"

Note :

- As a Presenter/Moderator(feature):
  "Save Chat/Clear Chat/Copy Chat
  (if Private Chat) += Close Private Chat Tab"

- As a Viewer(feature):
  "Save Chat/Copy Chat
  (if Private Chat) += Close Private Chat Tab"

## Polling

### Starting a Polling

(Presenter feature)

1. As a presenter, click on the presenter menu (+) button in the bottom left corner of the screen

2. click Start Poll

3. Choose one of the Poll options

4. wait for Poll votes by the users.

5. Click on Publish Poll Results

- A Poll will show up for all of the available
  users except the Presenter
- A sound effect notification is heard to notify all of the available Viewers/Moderators that there is a Live Poll and the options to vote
  on it are available.
- A live Poll Results Tab will show up to the presenter.

### Sending Poll votes

(Moderator/viewer feature)

1. As a viewer/user, Click one of the available Poll options
   from the Poll Options Card showing in the Bottom Left corner of the Presentation.

- After hearing the Notification sound effect, Poll Vote Options are shown in the bottom right corner of the screen.

### Publishing Poll Results

(Presenter feature)

1. As a presenter, wait for the submissions of the Poll votes

2. click on Publish polling results.

- Poll Results displays in the live results table will show in the presentation to all of the available Viewers/Moderators in the bottom right corner of the presentation.

### Custom Poll

(Presenter feature)

1. Click on the highlighting (+) button in the bottom left corner of the screen

2. click Start Poll

3. select Custom Poll

4. Fill the desired Poll options which is less than 5 options

5. Click Start custom poll

- A Poll shows up for all of the available users except for the Presenter
- A sound effect notification is heard to notify all of the available Viewers/Moderators that there is a Live Poll and the options to vote
  on it are available
- A live Poll Results Tab will show up to the presenter.

### Loading Poll from files

(Presenter feature)

1. Click on the highlighting (+) button in the bottom left corner of the presentation screen

2. Click upload a Presentation

3. Load your Quick Poll file

4. Click upload

- The custom Quick Poll file uploaded is displaying in the Presentation screen
- A Quick Poll button is highlighting in the bottom left corner of the Presentation screen.

### Quick Poll Option

(Presenter feature : Choosing Quick Poll Options from the current Slide which is loaded from the Quick Poll file)

1. Click on the highlighting (+) button in the bottom left corner of the presentation screen

2. Click upload a Presentation

3. Load your Quick Poll file

4. Click upload

5. Click on the Quick Poll button highlighting in the bottom left corner of the screen next to the (+) button

6. click one of the available quick poll options available in the current presentation screen

- The chosen Poll options shows in the bottom right corner of the screen for all the users except the Presenter.

### Hiding Poll Results

(Presenter feature :Hiding Poll Results from the screen.)

1. Click on the Trash icon.

- The Poll result will disappear from the screen.

## User list settings

### Set status

(Viewer: Set Status/Raise hand)

1. As a viewer, select your user icon from user list

2. From menu options choose set status

3. Set a status/raise hand.

- Icon in the users list will update to display emoticon chosen by the user, when status is set by a user the moderator will see their user icon move to the top of the list.

### Clear status

(Moderator: Clear all status icon)

1. Select manage users icon (cog wheel in users list)

2. choose clear all status icons.

- All status icons in the users list will clear.

### Mute users

(Moderator: Mute all Users)

1. Select manage users icon (cog wheel in users list)

2. In lock viewers, select share microphone is locked.

3. Click apply.

- All users (moderator/presenter included) who are already joined in the client with a functioning mic will be muted (if unmuted) and unable to unmute their mics. All users (moderator/presenter included) who join after setting is applied will be automatically joined listen only with no mic options available.

### Unmute users

(Moderator: Undo mute all users)

1. Select manage users icon (cog wheel in users list)

2. In lock viewers, click share microphone to unlock in the status and click apply.

- All users will remain muted until they unmute themselves. All users who enter after the meeting mute is removed will have the option to join with a mic

### Mute and unmute users except Presenter

(Moderator: Mute all users except for presenter)

1. Select manage users icon (cog wheel in users list)

2. Choose lock viewers and select shared microphone to locked, mute all users except for presenter.

- All users except the current presenter who are already joined in the cliend with a functioning mic will be muted (if unmuted) and unable to unmute their mics. All users who join after the setting is applied will be automatically joined listen only with no mic options available.

(Moderator: Undo mute all users except for presenter)

1. Select manage users icon (cog wheel in users list)

2. Choose lock viewers and selecting shared microphone is unlocked and undo meeting mute.

- All users will remain muted until they unmute themselves. All users who enter after the meeting mute is removed will have the option to join with a mic

### Saving Usernames

(Moderator: Save user names)

1. Select manage users icon (cog wheel in users list)

2. Choose save user names.

- Users list names will download as a TXT based document to local device.

### Shared Notes

As a moderator:

1. Select manage users icon (cog wheel in users list)

2. Choose lock viewers

3. Lock shared notes

4. exit menu

As a viewer:

1. Open shared notes panel

2. Attempt to contribute to shared notes to confirm if it's locked.

## Options menu

### Access Options Menu

1. Clicking on Option Menu in top right (three dots)

- A dropdown list appears with a list of
  available commands.

### Make Full screen

1. Click on Make Full-screen in the Options Menu

- The Presentation goes in Full Screen Mode

### Settings

1. Click on Settings in the Options Menu

- Settings screen appears with serval options.

### Application Settings

#### A. Animations

1.  click on the [On/Off] the switch button
2.  Enable/Disable Animations
3.  click Save to Validate your new Settings

- The Animations is now Disabled/Enabled

#### B. Audio Alerts for Chat

1.  Click on the [On/Off] the switch button to Enable/Disable Audio Alerts for Chat

2.  Click Save to Validate your new Settings.

- The beeps alerts for chat are now Disabled/Enabled

#### C. Popup Alerts for Chat

1.  click on the [On/Off] the switch button to Enable/Disable Popup alerts for Chat

2.  click Save to Validate your new Settings.

- The Popup Alerts for Chat are now Disabled/Enabled.

#### D. Application Language

1.  click on the Application Language Options List

2.  choose a language from the dropdown list

3.  click Save to Validate your new Settings

- The screen quickly reloads to apply the language change action

#### E. Font Size

1.  click on (+) or (-) buttons to increase or decrease the font size of Presentation

2.  click Save to Validate your new Settings

- The font size increases/decreases according to the set percentage

### Data Savings Settings

#### A. Enable/Disable Webcams

1.  click on the [On/Off] the switch button to Enable/Disable Webcams

2.  click Save to Validate your new Settings

- The Webcams are now Disabled/Enabled

#### B. Enable/Disable Desktop Sharing

1.  click on the [On/Off] the switch button to Enable/Disable Desktop Sharing

2.  click Save to Validate your new Settings.

- Desktop Sharing is Disabled/Enabled

### Shortcut keys

#### Keyboard Shortcuts

1. click on the Keyboard Shortcuts in the options menu.

2. Press the below keys to get the desired results.

- Alt + O ------> Open Options
- Alt + U ------> Toggle UserList
- Alt + M ------> Mute / Unmute
- Alt + J ------> Join audio
- Alt + L ------> Leave audio
- Alt + P ------> Toggle Public Chat (User list must be open)
- Alt + H ------> Hide private chat
- Alt + G ------> Close private chat
- Alt + R ------> Toggle Raise Hand
- Alt + A ------> Open actions menu
- Alt + K ------> Open debug window
- Spacebar ------> Activate Pan tool (Presenter)
- Enter ------> Toggle Full-screen (Presenter)
- Right Arrow ------> Next slide (Presenter)
- Left Arrow ------> Previous slide (Presenter)

### Log out

1.  Click on Options Menu in top right (three dots)

2.  Select log out.

- User who selects log out is only user who is disconnected from the meeting and a feedback should prompt to the user

#### (For Moderator) : End meeting on log out

1. Click on Options Menu in top right (three dots)

2. Select end meeting and choose yes.

   - All users kicked from meeting, meeting feedback form appears and meeting ends

## Guest Management

## Custom Parameters

## iFrame
