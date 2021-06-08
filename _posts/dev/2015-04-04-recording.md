---
layout: page
title: 'Recording'
category: dev
date: 2015-04-04 22:47:38
---

This document assumes the reader understands the current [BigBlueButton architecture](/overview/architecture.html).

# Overview

BigBlueButton records all the events and media data generated during a BigBlueButton session for later playback.

If you want to see the Record and Playback feature in action there is a [demo](http://demo.bigbluebutton.org/demo/demo10.jsp), you can use it to record a BigBlueButton session and play it after it is listed under "Recorded Sessions" on the same page, you should wait a few minutes after your session ends while the media is processed and published for playback. This demo is also available on your server if you have [installed it](/install/install.html#6.-install-api-demos).

Like BigBlueButton sessions, management of recordings should be handled by [third party software](http://www.bigbluebutton.org/integrations/). Third party software consumes the [BigBlueButton API](/dev/api.html) to accomplish that. As user you may want to use third party software which sets the right value to the parameter "record". As developer you may want to use a (not official) library which implements the api calls in your preferred language, or implement it by yourself.

From a technical point of view, in the BigBlueButton API, when you pass the parameter 'record=true' with [create](/dev/api.html#create), BigBlueButton will create a session that has recording enabled. In this case, it will add a new button to the toolbar at the top of the window with a circle icon which a moderator in the session can use to indicate sections of the meeting to be recorded.

In a session with recording enabled, BigBlueButton will save the slides, chat, audio, desktop, whiteboard events and webcam for later processing. This is the unique way to record a meeting, because it provides the ability for different workflows to create recordings with different properties, combining the media in unique ways.

After the session finishes, the BigBlueButton server will run an archive script that copies all of the related files to a single directory. It then checks to see if the moderator has clicked the "Record" button during the session to indicate a section of the meeting that should be turned into a recording. If the recording button was not clicked during the session, the files are queued to be deleted after a period of time. (You can override this and force a recording to be processed; see the bbb-record --rebuild command below.)

After the recording is archived, BigBlueButton will run one (or more) ingest and processing scripts, named workflows, that will _process_ and _publish_ the captured data into a format for _playback_.

![Record and Playback - Overview](/images/diagrams/Record and Playback Service Diagram-RAP - Overview.png)

# Record and Playback Phases

BigBlueButton processes the recordings in the following :

1. Capture
2. Archive
3. Sanity
4. Process
5. Publish
6. Playback

## Capture

The Capture phase involves enabling the BigBlueButton modules (chat, presentation, video, voice, etc.) to emit events over an event bus for capture on the BigBlueButton server. Components that generate media (webcam, voice, desktop sharing) must also store their data streams on the server as well.

Whiteboard, cursor, chat and other events are stored on Redis. Webcam videos (.flv) and desktop sharing videos (.flv) are recorded by Red5. The audio conference file (.wav) is recorded by FreeSWITCH.

## Archive

The Archive phase involves taking the captured media and events into a **raw** directory. That directory contains ALL the necessary media and files to work with.

![Record and Playback - Archive](/images/diagrams/Record and Playback Service Diagram-RAP - Archive.png)

## Sanity

The Sanity phase involves checking that all the archived files are _valid_ for processing. For example
that media files have not zero length and events were archived.

![Record and Playback - Sanity](/images/diagrams/Record and Playback Service Diagram-RAP - Sanity.png)

## Process

The Process phase involves processing the archived valid files of the recording according to the workflow (e.g. presentation). Usually it involves parsing the archived events, converting media files to other formats or concatenating them, etc.

![Record and Playback - Process](/images/diagrams/Record and Playback Service Diagram-RAP - Process.png)

## Post Scripts

_Post scripts_ allow you to perform site-specific actions after each of the Archive, Process, and Publish steps of the Recording processing.

Some examples of things you might use the post scripts to do:

- Send you an email after a recording is published.
- Backup a recording to another server after your recording is archived or published.
- Send a text message after a recording is published.
- Compress media files and make them public available for download after it is published.
- Delete raw media files after the recording processing complete.

## Publish

The Publish phase involves generating metadata and taking many or all the processed files and placing them in a directory exposed publicly for later playback.

![Record and Playback - Publish](/images/diagrams/Record and Playback Service Diagram-RAP - Publish.png)

## Playback

The Playback phase involves taking the published files (audio, webcam, deskshare, chat, events, metadata) and playing them in the browser.

Using the workflow **presentation**, playback is handled by HTML, CSS and Javascript libraries; it is fully available in Mozilla Firefox and Google Chrome(also in Android devices). In other browsers like Opera or Safari the playback will work without all its functionality , e.g, thumbnails won't be shown. There is not a unique video file for playback, there is not an available button or link to download the recording. We have opened an [issue](https://github.com/bigbluebutton/bigbluebutton/issues/1969) for this enhancement

# Media storage

Some Record and Playback phases store the media they handle in different directories

## Captured files

- AUDIO: `/var/freeswitch/meetings`
- WEBCAM (Flash): `/usr/share/red5/webapps/video/streams`
- WEBCAM (HTML5): `/var/kurento/recordings`
- SCREEN SHARING (Flash): `/var/usr/share/red5/webapps/screenshare/streams`
- SCREEN SHARING (HTML5): `/var/kurento/screenshare`
- SLIDES: `/var/bigbluebutton`
- NOTES: `http://localhost:9001/p`
- EVENTS: `Redis`

### Archived files

The archived file are located in `/var/bigbluebutton/recording/raw/<internal-meeting-id>/`

### Sanity checked files

The sanity files are store in the same place as the archived files

### Processed files

The processed files can be found in `/var/bigbluebutton/recording/process/presentation/<internal-meeting-id>/`

### Published files

The published files are in `/var/bigbluebutton/recording/publish/presentation/<internal-meeting-id>/`

### Playback files

The playback files are found in `/var/bigbluebutton/published/presentation/<internal-meeting-id>/`

# Manage recordings

BigBlueButton does not have an administrator web interface to control the sessions or recordings as in both cases they are handled by 3rd party software, but it has a useful tool to monitor the state and control your recordings through the phases described above.

In the terminal of your server you can execute `bbb-record`, which will show you each option with its description

```
BigBlueButton Recording Diagnostic Utility (BigBlueButton Version 1.0.N)

   bbb-record [options]

Reporting:
   --list                              List all recordings

Monitoring:
   --watch                              Watch processing of recordings
   --watch --withDesc                   Watch processing of recordings and show their description

Administration:
   --rebuild <internal meetingID>       rebuild the output for the given internal meetingID
   --rebuildall                    rebuild every recording
   --delete <internal meetingID>    delete one meeting and recording
   --deleteall                          delete all meetings and recordings
   --debug                              check for recording errors
   --check                              check for configuration errors
   --enable <workflow>                  enable a recording workflow
   --disable <workflow>                 disable a recording workflow
   --tointernal <external meetingId>    get the internal meeting ids for the given external meetingId
   --toexternal <internal meetingId>    get the external meeting id for the given internal meetingId
   --republish <internal meetingID>      republish the recording for meetingID.
```

### Useful terms

- workflow - is the way a recording is processed, published and played . In BigBlueButton 0.81 the unique workflow out of the box is the "presentation".
- internal meetingId - is an alphanumeric string that internally identifies your recorded meeting. It is created internally by BigBlueButton. For example "183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379693236230".
- external meetingID - is the id you set to the meeting, like "English 201" or "My Awesome class", "Chemistry 2". It is passed through the create API call.
- recording - is recorded meeting in BigBlueButton.

In BigBlueButton you can use the same external meeting ID (for example "English 101") in many recordings but each recording will have a different internal meeting id. One external meeting id is associated with **one or many** internal meeting ids.

### List recordings

```bash
$ bbb-record --list
```

will list all your recordings.

### Watch recordings

```bash
$ bbb-record --watch
```

will list your latest 20 recordings, refreshing its output every 2 seconds. Its output is similar to this:

```
Every 2.0s: bbb-record --list20

Internal MeetingID                                               Time                APVD APVDE RAS Slides Processed            Published           External MeetingID
------------------------------------------------------  ---------------------------- ---- ----- --- ------ -------------------- ------------------  -------------------
6e35e3b2778883f5db637d7a5dba0a427f692e91-1379965122603  Mon Sep 23 19:38:42 UTC 2013  X    X  X XXX      1 presentation         presentation        English 101
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379965005759  Mon Sep 23 19:36:45 UTC 2013  X                  1
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379693236230  Fri Sep 20 16:07:16 UTC 2013  XX                 1
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379675205776  Fri Sep 20 11:06:45 UTC 2013  XX                 1
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379541285165  Wed Sep 18 21:54:45 UTC 2013  X                  1
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379523831933  Wed Sep 18 17:03:51 UTC 2013  XX                 1
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379450735750  Tue Sep 17 20:45:35 UTC 2013  XX                 1
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1379450634935  Tue Sep 17 20:43:54 UTC 2013  X                  1

--
--
Last meeting processed (bbb-web.log): 6e35e3b2778883f5db637d7a5dba0a427f692e91-1379965122603
```

_BigBlueButton 1.1_ When using BigBlueButton 1.1, you'll see recording process running as BigBlueButton processes the recording.

```
Every 2.0s: bbb-record --list20                                                                                                                                                                          Fri Dec 16 19:48:10 2016

Internal MeetingID                                               Time                APVD APVDE RAS Slides Processed            Published           External MeetingID
------------------------------------------------------  ---------------------------- ---- ----- --- ------ -------------------- ------------------  -------------------
238ff79fd66331a59274a8f3f05f1c0cd3e278b4-1481917394340  Fri Dec 16 19:43:14 UTC 2016 XX         X       17
b88482332e176943b72de73ec63b69f01f113c85-1481917347334  Fri Dec 16 19:42:27 UTC 2016  X                  6
6e35e3b2778883f5db637d7a5dba0a427f692e91-1481916917964  Fri Dec 16 19:35:17 UTC 2016 XX   XX  X         18                                          English 101 English 101
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1481916628809  Fri Dec 16 19:30:28 UTC 2016  X                  5
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1481915915825  Fri Dec 16 19:18:35 UTC 2016  X                  5
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1481915383857  Fri Dec 16 19:09:43 UTC 2016  X                  5
183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1481915110521  Fri Dec 16 19:05:10 UTC 2016  X                  5

--
NEXT                         LEFT          LAST                         PASSED UNIT                  ACTIVATES
Fri 2016-12-16 19:53:06 UTC  4min 56s left Fri 2016-12-16 19:48:06 UTC  4s ago bbb-record-core.timer bbb-record-core.service

1 timers listed.
--
● bbb-record-core.service - BigBlueButton recording & playback processing
   Loaded: loaded (/usr/lib/systemd/system/bbb-record-core.service; static; vendor preset: enabled)
   Active: inactive (dead) since Fri 2016-12-16 19:48:06 UTC; 3s ago
  Process: 26774 ExecStart=/usr/local/bigbluebutton/core/scripts/rap-worker.rb (code=exited, status=0/SUCCESS)
 Main PID: 26774 (code=exited, status=0/SUCCESS)

Dec 16 19:48:06 XXX-8gb-nyc3-01 systemd[1]: Started BigBlueButton recording & playback processing.
--
```

### Rebuild a recording

It will go through the Process and Publish phases again.

If you run bbb-record --rebuild on a recording where the process and publish script were not run because the moderator of the session did not click the record button, this will force the meeting to be processed. In this case, the entire length of the meeting will be included in the recording.

```bash
$ sudo bbb-record --rebuild 6e35e3b2778883f5db637d7a5dba0a427f692e91-1379965122603
```

### Rebuild every recording

It will go through the Process and Publish phases again for every recording in your server.
This action will take a long time since it processes every recording.

```bash
$ sudo bbb-record --rebuildall
```

### Delete a recording

```bash
$ sudo bbb-record --delete 6e35e3b2778883f5db637d7a5dba0a427f692e91-1379965122603
```

### Delete all recordings

```bash
$ sudo bbb-record --deleteall
```

### Debug recordings

Check recording log files, looking for errors since the Archive phase.

```bash
$ sudo bbb-record --debug
```

### Enable a workflow

```bash
$ sudo bbb-record --enable presentation
```

### Disable a workflow

```bash
$ sudo bbb-record --disable presentation
```

### Get internal meeting ids

```bash
$ sudo bbb-record --tointernal "English 101"
```

will show

```
Internal meeting ids related to the given external meeting id:
-------------------------------------------------------------
6e35e3b2778883f5db637d7a5dba0a427f692e91-1379965122603
```

Use double quotes for the external meeting id.

### Get external meeting ids

```bash
$ sudo bbb-record --toexternal "English 101"
```

Use double quotes for the external meeting id.

### Republish recordings

Republish recordings.

```bash
$ sudo bbb-record --republish 6e35e3b2778883f5db637d7a5dba0a427f692e91-1379965122603
```

## For Developers

Here you will find more details about the Record and Playback.

The way to start a recorded session in BigBlueButton is setting the "record" parameter value to "true" in the [create API](/dev/api.html#create) call, which usually is handled by third party software.

### Capture phase

The Capture phase is handled by many components.

To understand how it works, you should have basic, intermediate or advanced understanding about tools like FreeSWITCH, Flex, Red5 , Redis, dig into the [BigBlueButton source code](https://github.com/bigbluebutton/bigbluebutton). Search for information in the [BigBlueButton mailing list for developers](https://groups.google.com/forum/#!forum/bigbluebutton-dev) if you have more questions.

### Archive, Sanity, Process and Publish

These phases are handled by Ruby scripts. The directory for those files is `/usr/local/bigbluebutton/core/`

```
/usr/local/bigbluebutton/core/
+-- Gemfile
+-- Gemfile.lock
+-- lib
¦   +-- recordandplayback
¦   ¦   +-- audio_archiver.rb
¦   ¦   +-- deskshare_archiver.rb
¦   ¦   +-- edl
¦   ¦   ¦   +-- audio.rb
¦   ¦   ¦   +-- video.rb
¦   ¦   +-- edl.rb
¦   ¦   +-- events_archiver.rb
¦   ¦   +-- generators
¦   ¦   ¦   +-- audio_processor.rb
¦   ¦   ¦   +-- audio.rb
¦   ¦   ¦   +-- events.rb
¦   ¦   ¦   +-- matterhorn_processor.rb
¦   ¦   ¦   +-- presentation.rb
¦   ¦   ¦   +-- video.rb
¦   ¦   +-- presentation_archiver.rb
¦   ¦   +-- video_archiver.rb
¦   +-- recordandplayback.rb
+-- scripts
    +-- archive
    ¦   +-- archive.rb
    +-- bbb-rap.sh
    +-- bigbluebutton.yml
    +-- cleanup.rb
    +-- presentation.yml
    +-- process
    ¦   +-- presentation.rb
    ¦   +-- README
    +-- publish
    ¦   +-- presentation.rb
    ¦   +-- README
    +-- rap-worker.rb
    +-- sanity
        +-- sanity.rb
```

The main file is `rap-worker.rb`, it executes all the Record and Playback phases

1. Detects when new captured media from a session is available.

2. Go through the Archive phase (`/usr/local/bigbluebutton/core/scripts/archive/archive.rb`)

3. Go through the Sanity phase executing (`/usr/local/bigbluebutton/core/scripts/sanity/sanity.rb`)

4. Go through the Process phase executing all the scripts under `/usr/local/bigbluebutton/core/scripts/process/`

5. Go through the Publish phase executing all the scripts under `/usr/local/bigbluebutton/core/scripts/publish/`

- Files ending with "archiver.rb" contain scripts with logic to archive media.

- Files under `/usr/local/bigbluebutton/core/lib/generators/` contains scripts with logic, classes and methods used by other scripts which archive or process media.

- Yml files contain information used by process and publish scripts.

### Writing Post Scripts

In your server, there are separate "drop-in" directories under `/usr/local/bigbluebutton/core/scripts` for each of the `post_archive`, `post_process`, and `post_publish` steps. Each of these directories can contain ruby scripts (`.rb` extension required), which will be run in alphabetical order after the corresponding recording step.

The scripts take the argument `-m`, which takes the meeting id as a parameter.

A set of example scripts is provided to give you a framework to build your custom scripts from.

```
|-- post_archive
|   `-- post_archive.rb.example
|-- post_process
|   `-- post_process.rb.example
`-- post_publish
    `-- post_publish.rb.example
```

The example files give the file paths where the files from the corresponding step are located, and include code for accessing the metadata variables from the meeting. For example, if you passed a variable named

```ruby
meta_postpublishemail=user@example.com
```

when creating the meeting, you can access it by doing

```ruby
email = meeting_metadata['postpublishemail']
```

in the script.

You are free to do anything you like inside the post scripts, including modifying recording files from a previous step before the next step occurs.

### Playback phase

Playback works with the javascript library Popcorn.js which shows the slides, chat and webcam according to the current time played in the audio file. Playback files are located in `/var/bigbluebutton/playback/presentation/` and used to play any published recording.

## Troubleshooting

Apart from the command

```bash
$ sudo bbb-record --debug
```

You can use the output from

```bash
$ sudo bbb-record --watch
```

to detect problems with your recordings.

To investigate the processing of a particular recording, you can look at the following log files:

The bbb-rap-worker log is a general log file that can be used to find which section of the recording processing is failing. It also logs a message if a recording process is skipped because the moderator did not push the record button.

```
/var/log/bigbluebutton/bbb-rap-worker.log
```

To investigate an error for a particular recording, check the following log files:

```
/var/log/bigbluebutton/archive-<recordingid>.log
/var/log/bigbluebutton/<workflow>/process-<recordingid>.log
/var/log/bigbluebutton/<workflow>/publish-<recordingid>.log
```

### Understanding output from bbb-record-watch

![watch](/images/bbb-record-watch-explanation.png)

This section is intended to help you to find and in some cases to solve problems in the
Record and Playback component of BigBlueButton, watching the output of the command

```bash
$ bbb-record --watch
```

#### RAS ( RECORDED - ARCHIVED - SANITY CHECKED )

Below **RAS** you won't see any **_X_** until the meeting has finished.

Once the meeting has finished, an **_X_** under **R** appears, if it does not appear:

- Be sure all users left the meeting.

- Check out that the parameter `defaultMeetingExpireDuration` in `/var/lib/tomcat7/webapps/bigbluebutton/WEB-INF/classes/bigbluebutton.properties` does not have a big value (default to 1).

- Be sure the parameter `record=true` was passed in the `create` api call. If not, you didn't record the meeting.

Once the recording is archived, an **_X_** under **A** appears, if it does not appear:

- Verify this this file exists

`/var/bigbluebutton/recording/status/recorded/<internal meeting id>.done`

that means that the meeting was recorded.

Once the recording passed the sanity check , an **_X_** appears under **S**, if it does not appear:

- A media file was not properly archived, find the cause of the problem in the sanity log

```bash
$ grep <internal meeting id> /var/log/bigbluebutton/sanity.log
```

#### APVD (Audio, Presentation, Video, Deskshare)

This section is related to recorded media. By default Audio and Presentation are recorded, if you don't see any **_X_** under **V** or **D**, then you haven't
shared your webcam or desktop, or you haven't enabled webcam or deskshare to be recorded.

##### APVDE (Audio, Presentation, Video, Deskshare, Events)

This section is related to archived media. If you don't see an **_X_** under a media you are sure that was recorded, check out
the sanity log. Execute this command to find the problem:

```bash
$ grep <internal meeting id> /var/log/bigbluebutton/sanity.log
```

#### Processed

If a script was applied to process your recording, its name should be listed under the column 'Processed', by default you should see
"presentation", if you don't see one of them, find the problem in the log file of the processed recording:

```bash
$ grep -B 3 "status: 1" /var/log/bigbluebutton/presentation/process-<internal meeting id>.log | grep ERROR
```

If there is some output, it should show the problem. If there is no output then tail the file to see which is the
latest executed task. Make sure that is the one that failed and an error message with the problem is described few lines after.

##### Published

If a script is applied to publish your recording, its name should be listed under the column 'Published'.

```bash
$ grep -B 3 "status: 1" /var/log/bigbluebutton/presentation/publish-<internal meeting id>.log | grep ERROR
```

If there is some output then you found the problem, if there is not any output then tail the file to see which is the
last executed task, sure that is the one that failed and an error message with the problem is described few lines after.

# FAQS

## How do I change the Start/Stop recording marks

Sometimes you have a user the clicked the Start/Stop Recording button at the wrong time. As a result, the playback file produced might be missing the first 30 minutes.

You can change the segments processed for a recording by editing the `events.xml` file. Use `bbb-record --list` to find the internal `meetingId` for the recording. For example, to get the last three recordings

```bash
$ sudo bbb-record --list | head -n 5
Internal MeetingID                                               Time                APVD APVDE RAS Slides Processed            Published           External MeetingID
------------------------------------------------------  ---------------------------- ---- ----- --- ------ -------------------- ------------------  -------------------
238ff79fd66331a59274a8f3f05f1c0cd3e278b4-1538942925244  Sun Oct 7 16:08:45 EDT 2018  XX   XX  X          6                      presentation        English 102
6e35e3b2778883f5db637d7a5dba0a427f692e91-1538942881350  Sun Oct 7 16:08:01 EDT 2018   X    X  X          6                      presentation        English 101
6e35e3b2778883f5db637d7a5dba0a427f692e91-1538941988186  Sun Oct 7 15:53:08 EDT 2018  XX   XX  X          6                      presentation        English 101
```

The first recording has an internal `meetingID` of `238ff79fd66331a59274a8f3f05f1c0cd3e278b4-1538942925244`. If this is the recoding you want to edit, you'll find the events.xml in the location `/var/bigbluebutton/recording/raw/238ff79fd66331a59274a8f3f05f1c0cd3e278b4-1538942925244/events.xml`. Edit this file and look for the first `RecordingStatusEvent`, such as

```
  <event timestamp="4585088638" module="PARTICIPANT" eventname="RecordStatusEvent">
    <userId>w_68gpmvhecnng</userId>
    <status>true</status>
  </event>
```

Next, find when the first moderator joined, and thend move the `RecordStatusEvent` after the moderator join event. Also, edit the `timestamp` for `RecordStatusEvent` so it occurs **after** the moderator's `timestamp`. For example:

```xml
  <event timestamp="4585063453" module="PARTICIPANT" eventname="ParticipantJoinEvent">
    <userId>w_68gpmvhecnng</userId>
    <externalUserId>w_68gpmvhecnng</externalUserId>
    <role>MODERATOR</role>
    <name>e2</name>
  </event>
  <event timestamp="4585063454" module="PARTICIPANT" eventname="RecordStatusEvent">
    <userId>w_68gpmvhecnng</userId>
    <status>true</status>
  </event>
```

This is equivalent to the first moderator clicking the Start/Stop Record button. Save the modified `events.xml` and regenerate recording using the `bbb-record --rebuild` command, as in

```bash
$ sudo bbb-record --rebuild 238ff79fd66331a59274a8f3f05f1c0cd3e278b4-1538942925244
```

If there are no other recordings processing, you should see the recording re-process using the `sudo bbb-record --watch` command. After the processing is finished, your users can view the recording and see all the content from the time the first moderator joined.

```xml
 <event timestamp="4584199946" module="PARTICIPANT" eventname="RecordStatusEvent">
    <userId>w_w0mkqqeo8jqc</userId>
    <status>true</status>
  </event>
```

## Is the recording activated automatically?

No, when creating the meeting the parameters must include `record=true` to enable recording. In BigBlueButton 0.9.1, to have a recorded session create a playback file, a moderator must click the Start/Stop Record button during the session. Otherwise, BigBlueButton will not create a playback file and delete the recorded session.

## How to delete recordings before storage device is full?

`/etc/cron.daily/bigbluebutton` deletes the archived media. Edit the file and add more rules if you need to delete others like raw files or processed files.

# Events outline

## Overview

The sections that follow cover the types of events you will encounter in events.xml (in case you want to parse them with your own scripts).

## Chat

| Event           | Attributes                                        |
| :-------------- | :------------------------------------------------ |
| PublicChatEvent | - message<br/>- sender<br/>- senderId<br/>- color |

## Presentation

| Event                    | Attributes                                                          |
| ------------------------ | ------------------------------------------------------------------- |
| AssignPresenterEvent     | - assignedBy<br/>- userid<br/>- name<br/>                           |
| ConversionCompletedEvent | - presentationName<br/>- originalFilename<br/>                      |
| ParticipantJoinEvent     | - userId<br/>- externalUserId<br/>- role<br/>- name                 |
| ResizeAndMoveSlideEvent  | - widthRatio<br/>- yOffset<br/>- id<br/>- heightRatio<br/>- xOffset |
| SharePresentationEvent   | - share<br/>- presentationName<br/>                                 |
| GotoSlideEvent           | - slide<br/>- id<br/>                                               |

## Whiteboard

| Event                     | Attributes                                                                                                                                                                 |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| AddShapeEvent             | - presentation<br/>- shapeId<br/>- type<br/>- dataPoints<br/>- userId<br/>- position<br/>- pageNumber<br/>- status<br/>- whiteboardId<br/>- id<br/>- thickness<br/>- color |
| UndoAnnotationEvent       | - presentation<br/>- shapeId<br/>- userId<br/>- pageNumber<br/>- whiteboardId                                                                                              |
| WhiteboardCursorMoveEvent | - yOffset<br/>- userId<br/>- xOffset                                                                                                                                       |

## User

## Voice

| Event                   | Attributes                                                                               |
| ----------------------- | ---------------------------------------------------------------------------------------- |
| StartRecordingEvent     | - bridge<br/>- filename<br/>- recordingTimestamp                                         |
| ParticipantJoinedEvent  | - muted<br/>- callernumber<br/>- talking<br/>- callername<br/>- bridge<br/>- participant |
| ParticipantTalkingEvent | - talking<br/>- bridge<br/>- participant                                                 |
| ParticipantTalkingEvent | - muted<br/>- bridge<br/>- participant                                                   |
| ParticipantLeftEvent    | - bridge<br/>- participant                                                               |
| RecordStatusEvent       | - userId<br/>- status                                                                    |

### ## Caption

## Screen Share

## Desk Share

### **DeskshareStartedEvent**

| attributes |        |
| :--------- | :----: |
| file       | stream |

### **DeskshareStoppedEvent**

| attributes |        |          |
| :--------- | :----: | :------: |
| file       | stream | duration |

## PARTICIPANT

### **ParticipantStatusChangeEvent**

| attributes |        |        |
| :--------- | :----: | :----: |
| value      | userId | status |

## Poll

### **PollStartedRecordEvent**

| attributes |        |
| :--------- | :----: |
| answers    | pollId |

### **UserRespondedToPollRecordEvent**

| attributes |        |        |
| :--------- | :----: | :----: |
| answerId   | pollId | userId |

### **PollStoppedRecordEvent**

| attributes |
| :--------- |
| pollId     |

## WEBCAM

### **StartWebcamShareEvent**

| attributes |
| :--------- |
| stream     |

### **StopWebcamShareEvent**

| attributes |        |
| :--------- | :----: |
| duration   | stream |
