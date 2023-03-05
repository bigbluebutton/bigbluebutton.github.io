---
layout: page
title: 'Customize'
category: 2.6
date: 2022-01-30 19:06:09
order: 3
---

BigBlueButton has many configuration files that offer you opportunities to customize your installation. This document covers common customizations of BigBlueButton 2.6. For customizations that apply to multiple versions of BigBlueButton, including 2.6, check out the [admin customizations page](/admin/customize.html).

# Preserving customizations using apply-conf.sh

Whenever you upgrade a server to the latest version of BigBlueButton, either using the [manual upgrade steps](/2.6/install.html#upgrading-from-bigbluebutton-25) or the [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) script, if you have made custom changes to BigBlueButton's configuration files, the packaging scripts may overwrite these changes.

To make it easier to apply your configuration changes, you can create a BASH script at `/etc/bigbluebutton/bbb-conf/apply-config.sh` that contains commands to apply your changes. The `bbb-conf` script, which is run as part of the last steps in a manual upgrade steps or using `bbb-install.sh`, will detect `apply-config.sh` and invoke it just before starting all of BigBlueButton's components.

In this way, you can use `apply-conf.sh` to apply your custom configuration changes after all packages have updated but just before BigBlueButton starts.

For example, if you create `/etc/bigbluebutton/bbb-conf/apply-config.sh` with the following contents and make it executable with `chmod +x /etc/bigbluebutton/bbb-conf/apply-config.sh`

```sh
#!/bin/bash

# Pull in the helper functions for configuring BigBlueButton
source /etc/bigbluebutton/bbb-conf/apply-lib.sh

enableUFWRules

echo " - Disable screen sharing"
yq w -i $HTML5_CONFIG public.kurento.enableScreensharing false
chown meteor:meteor $HTML5_CONFIG
```

then when called by `bbb-conf`, the above `apply-conf.sh` script will

- use the helper function `enableUFWRules` to [restrict access to specific ports](#restrict-access-to-specific-ports), and
- set `enableScreensharing` to `false` in the HTML5 configuration file at `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml`.

Notice that `apply-conf.sh` includes a helper script [apply-lib.sh](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-config/bin/apply-lib.sh). This helper script contains some functions to make it easy to apply common configuration changes, along with some helper variables, such as `HTML5_CONFIG`.

The contents of `apply-config.sh` are not owned by any package, so it will never be overwritten.

# General

## Adjust the number of processes for nodejs

BigBlueButton uses 2 "frontend" and 2 "backend" processes by default to handle live meetings. See the description of the [Scalability of HTML5 server component](/2.4/architecture.html#scalability-of-html5-server-component) for details.

Depending on the resources available on your system, increasing the number of processes may allow you to support more concurrent users or concurrent meetings on the server. You can update the following settings in `/etc/bigbluebutton/bbb-html5-with-roles.conf`:

```sh
# Default = 2; Min = 1; Max = 4
# On powerful systems with high number of meetings you can set values up to 4 to accelerate handling of events
NUMBER_OF_BACKEND_NODEJS_PROCESSES=2
# Default = 2; Min = 0; Max = 8
# If 0 is set, bbb-html5 will handle both backend and frontend roles in one process (default until Feb 2021)
# Set a number between 1 and 4 times the value of NUMBER_OF_BACKEND_NODEJS_PROCESSES where higher number helps with meetings
# stretching the recommended number of users in BigBlueButton
NUMBER_OF_FRONTEND_NODEJS_PROCESSES=2
```

Changing these values requires restarting BigBlueButton (`bbb-conf --restart`). This configuration is preserved during updates.

# Video

## Run three parallel Kurento media servers

Kurento media server handles three different types of media streams: listen only, webcams, and screen share.

Running three parallel Kurento media servers (KMS) -- one dedicated to each type of media stream -- should increase the stability of media handling as the load for starting/stopping media streams spreads over three separate KMS processes. Also, it should increase the reliability of media handling as a crash (and automatic restart) by one KMS will not affect the two.

To configure your BigBlueButton server to run three KMS processes, add the following line to [apply-conf.sh](https://docs.bigbluebutton.org/admin/customize.html#apply-confsh)

```sh
enableMultipleKurentos
```

and run `sudo bbb-conf --restart`, you should see

```
  - Configuring three Kurento Media Servers: one for listen only, webcam, and screeshare
Generating a 2048 bit RSA private key
....................+++
......+++
writing new private key to '/tmp/dtls-srtp-key.pem'
-----
Created symlink from /etc/systemd/system/kurento-media-server.service.wants/kurento-media-server-8888.service to /usr/lib/systemd/system/kurento-media-server-8888.service.
Created symlink from /etc/systemd/system/kurento-media-server.service.wants/kurento-media-server-8889.service to /usr/lib/systemd/system/kurento-media-server-8889.service.
Created symlink from /etc/systemd/system/kurento-media-server.service.wants/kurento-media-server-8890.service to /usr/lib/systemd/system/kurento-media-server-8890.service.
```

After BigBlueButton finishes restarting, you should see three KMS processes running using the `netstat -antp | grep kur` command.

```
# netstat -antp | grep kur
tcp6       0      0 :::8888                 :::*                    LISTEN      5929/kurento-media-
tcp6       0      0 :::8889                 :::*                    LISTEN      5943/kurento-media-
tcp6       0      0 :::8890                 :::*                    LISTEN      5956/kurento-media-
tcp6       0      0 127.0.0.1:8888          127.0.0.1:49132         ESTABLISHED 5929/kurento-media-
tcp6       0      0 127.0.0.1:8890          127.0.0.1:55540         ESTABLISHED 5956/kurento-media-
tcp6       0      0 127.0.0.1:8889          127.0.0.1:41000         ESTABLISHED 5943/kurento-media-
```

Each process has its own log file (distinguished by its process ID).

```
# ls -alt /var/log/kurento-media-server/
total 92
-rw-rw-r--  1 kurento kurento 11965 Sep 13 17:10 2020-09-13T170908.00000.pid5929.log
-rw-rw-r--  1 kurento kurento 10823 Sep 13 17:10 2020-09-13T170908.00000.pid5943.log
-rw-rw-r--  1 kurento kurento 10823 Sep 13 17:10 2020-09-13T170908.00000.pid5956.log
```

Now, if you now join a session and choose listen only (which causes Kurento setup a single listen only stream to FreeSWITCH), share your webcam, or share your screen, you'll see updates occuring independently to each of the above log files as each KMS process handles your request.

To revert back to running a single KMS server (which handles all three meida streams), change the above line in `/etc/bigbluebutton/bbb-conf/apply-config.sh` to

```sh
disableMultipleKurentos
```

and run `sudo bbb-conf --restart` again.

# Recordings

## Delete raw data from published recordings

When a meeting finishes, the BigBlueButton server [archives the meeting data](/dev/recording.html#archive) (referred to as the "raw" data).

Retaining the raw data lets you [rebuild](/dev/recording.html#rebuild-a-recording) a recording if there was a processing issue, to enabled a new recording format, or if it was accidentally deleted by a user; however, the tradeoff is the storage of raw data will consume more disk space over time.

By default, BigBlueButton server automatically remove the raw data for a recording after 14 days of its being published. You can adjust this by editing the file `/etc/cron.daily/bigbluebutton`. Look for this line near the top of the file:

```bash
published_days=14
```

And adjust it to the desired number of days. If you would instead like to completely disable the cleanup of raw recording data, comment out the following line, near the bottom of the file:

```bash
remove_raw_of_published_recordings
```

## Always record every meeting

By default, the BigBlueButton server will produce a recording when both of the following are true:
1. the meeting has been created with `record=true` in the create API call, and
2. a moderator has clicked the Start/Stop Record button (at least once) during the meeting.

However, you can configure a BigBlueButton server to record every meeting and disable the ability for a moderator to stop the recording. Edit `/etc/bigbluebutton/bbb-web.properties` and set the following properties:

```properties
# Start recording when first user joins the meeting.
# For backward compatibility with 0.81 where whole meeting
# is recorded.
autoStartRecording=true

# Allow the user to start/stop recording.
allowStartStopRecording=false
```

To apply the changes, restart the BigBlueButton server using the command

```bash
$ sudo bbb-conf --restart
```

## Migrate recordings from a previous version

If you have recordings made with a previous version of BigBlueButton, you might need to run some migration scripts in order to adapt them to the current BigBlueButton version. These scripts are normally run during the upgrade process, but can be re-run manually if recordings are copied to the server after BigBlueButton is installed.

To manually run the scripts,

```bash
$ cd /usr/local/bigbluebutton/core/scripts
$ sudo ./bbb-0.9-beta-recording-update
$ sudo ./bbb-0.9-recording-size
$ sudo ./bbb-1.1-meeting-tag
```

Each script indicates the version of BigBlueButton that it applies to. For example, if you have a recording from BigBlueButton 0.8 you should run all of the scripts. If you have a recording from BigBlueButton 1.1 you only need to run `./bbb-1.1-meeting-tag`. If you have a recording from a later BigBlueButton version (e.g. 2.0), you do not need to run any migration scripts.

If the scripts have previously been run, you can add the `--force` command line option to re-run the scripts. This might be needed if you copy additional recordings to an existing BigBlueButton server.

## Transfer recordings

When setting up BigBlueButton on a server, you may want to transfer recordings from an older server. If your old server has all of the original recording files in the `/var/bigbluebutton/recording/raw` directory, then you can transfer these files to the new server using `rsync`.

For example, running this `rsync` command new server will copy over the recording file from the old server.

```bash
$ rsync -rP root@old-bbb-server.example.com:/var/bigbluebutton/recording/raw/ /var/bigbluebutton/recording/raw/
```

Alternatively, you could create a tar archive of the `/var/bigbluebutton/recording/raw` directory, and copy it with scp, or use a shared NFS mount.

After you copy over the files (either through rsync or tar-and-copy), you will then need to fix the permissions on the new server using the following `chown` command.

```bash
$ chown -R bigbluebutton:bigbluebutton /var/bigbluebutton/recording/raw
```

If the recordings made on your old server used the `slides` recording format from BigBlueButton 0.8 or earlier, you will also have to install the playback support files:

```bash
$ sudo apt-get install bbb-playback-slides
```

After copying the recordings over, you might also have to [manually run the recording migration scripts](#migrate-recordings-from-a-previous-version).

## Increase the number of recording workers

<!-- TODO remove when 12403 is resolved -->
> **Warning**
>
> If the `defaultKeepEvents` or `meetingKeepEvents` setting in bbb-web is enabled, you must not increase the number of BigBlueButton recording workers. Doing so could result in data loss, as meeting events will not be correctly archived.
> 
> For more information, see [BigBlueButton issue #12503](https://github.com/bigbluebutton/bigbluebutton/issues/12503).

Run `systemctl edit bbb-rap-resque-worker.service`, and insert the following into the editor, replacing the number with the desired number of recordings to process concurrently.

```
[Service]
Environment=COUNT=3
```

Then restart the worker process: `systemctl restart bbb-rap-resque-worker.service`

If you run `systemctl status bbb-rap-resque-worker.service` now, you will see that it has the desired number of workers ready to process recordings in parallel:

```
● bbb-rap-resque-worker.service - BigBlueButton resque worker for recordings
   Loaded: loaded (/usr/lib/systemd/system/bbb-rap-resque-worker.service; disabled; vendor preset: enabled)
  Drop-In: /etc/systemd/system/bbb-rap-resque-worker.service.d
           └─override.conf
   Active: active (running) since Sat 2021-01-09 12:19:22 UTC; 6s ago
 Main PID: 23630 (sh)
    Tasks: 15 (limit: 4915)
   CGroup: /system.slice/bbb-rap-resque-worker.service
      ├─23630 /bin/sh -c /usr/bin/rake -f ../Rakefile resque:workers >> /var/log/bigbluebutton/bbb-rap-worker.log
      ├─23631 /usr/bin/ruby /usr/bin/rake -f ../Rakefile resque:workers
      ├─23650 resque-2.0.0: Waiting for rap:archive,rap:publish,rap:process,rap:sanity,rap:captions
      ├─23651 resque-2.0.0: Waiting for rap:archive,rap:publish,rap:process,rap:sanity,rap:captions
      └─23652 resque-2.0.0: Waiting for rap:archive,rap:publish,rap:process,rap:sanity,rap:captions
```

## Install additional recording processing formats

In addition to the `presentation` format that is installed and enabled by default, there are several optional recording formats available for BigBlueButton 2.6:

- `notes`: Makes the shared notes from the meeting available as a document.
- `screenshare`: Generate a single video file from the screensharing and meeting audio.
- `podcast`: Generate an audio-only recording.
- `video`: Generate a recording containing the webcams, presentation area, and screensharing combined into a single video file.

The processing scripts and playback support files for these recording formats can be installed from the packages named `bbb-playback-<formatname>` (e.g. `sudo apt install bbb-playback-video`)

In order to enable the recording formats manually, you need to edit the file `/usr/local/bigbluebutton/core/scripts/bigbluebutton.yml`. Look for the section named `steps:`. In this section, the recording processing workflow is defined, including what recording processing steps are performed, and what order they need to be performed in.

To enable a new recording format, you need to add a new step named `process:<formatname>` that runs after the step named captions, and a new step named `publish:<formatname>` that runs after `process:<formatname>`. You may have to convert some of the steps to list format.

For example, in BigBlueButton 2.6, here are the stock workflow in `/usr/local/bigbluebutton/core/scripts/bigbluebutton.yml` with the default `presentation` format enabled:

```yml
steps:
  archive: 'sanity'
  sanity: 'captions'
  captions: 'process:presentation'
  'process:presentation': 'publish:presentation'
```

If you install `bbb-playback-video`, you need to modify the file as follows to enable processing of the new video format in the recording workflow.

```yml
steps:
  archive: 'sanity'
  sanity: 'captions'
  captions:
    - 'process:presentation'
    - 'process:video'
  'process:presentation': 'publish:presentation'
  'process:video': 'publish:video'
```

After you edit the configuration file, you must restart the recording processing queue and nginx using `systemctl restart bbb-rap-resque-worker nginx` in order for the recording workflow to pick up the changes for the new format.

This pattern of modifications can be repeated for additional recording formats. Note that it's very important to put the step names containing a colon (`:`) in quotes.

Ideally, installing the `bbb-playback-video` package would automatically enable the processing workflow.  There is currently an issue where the recording formats are not automatically enabled when they are installed - see [#12241](https://github.com/bigbluebutton/bigbluebutton/issues/12241) for details.

## Enable generating mp4 (H.264) video output

By default, BigBlueButton generates recording videos as `.webm` files using the VP9 video codec. These are supported in most desktop web browsers, but might not work on iOS mobile devices. You can additionally enable the H.264 video codec in some recording formats:

**`video`**

Edit the file `/usr/local/bigbluebutton/core/scripts/video.yml` and uncomment the lines under the `formats:` label for the mimetype `video/mp4`.

<!-- TODO: The default for the video recording format is currently mp4; this needs to be updated with the correct steps -->

The encoding options can be adjusted to speed up encoding or increase quality of video generation as desired.

**`presentation`**

Edit the file `/usr/local/bigbluebutton/core/scripts/presentation.yml` and uncomment the entry for `mp4`:

```yml
video_formats:
  - webm
  - mp4
```

**`screenshare`**

Edit the file `/usr/local/bigbluebutton/core/scripts/screenshare.yml` and uncomment the lines under the `:formats:` label for the mime type `video/mp4`:

```yml
  - :mimetype: 'video/mp4; codecs="avc1.640028, mp4a.40.2"'
    :extension: mp4
    :parameters:
      - [ '-c:v', 'libx264', '-crf', '21', '-preset', 'medium', '-profile:v', 'high', '-level', '40', '-g', '240',
          '-c:a', 'aac', '-b:a', '96K',
          '-threads', '2', '-f', 'mp4', '-movflags', 'faststart' ]
```

The encoding options can be adjusted to speed up encoding or increase quality of video generation as desired.
