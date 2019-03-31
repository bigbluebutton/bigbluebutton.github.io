---
layout: page
title: "Customize"
category: 2.2
#redirect_from: "/2.0/20install.html"
date: 2019-02-14 22:13:42
---

This document covers common customizations of BigBlueButton 2.2-beta (referred hereafter as BigBlueButton). 


# Common Customizations

## Remove the API demos
If you have earlier installed the API demos for testing (which makes it possible for anyone to use your BigBlueButton server without authentication) and want to now remove them, enter the command:

~~~
$ sudo apt-get purge bbb-demo
~~~

## Make the HTML5 client default

To make the HTML5 client the default client (and no longer load the Flash client), edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and set both `attendeesJoinViaHTML5Client` and `moderatorsJoinViaHTML5Client` to `true`, as in

~~~
# Force all attendees to join the meeting using the HTML5 client
attendeesJoinViaHTML5Client=true

# Force all moderators to join the meeting using the HTML5 client
moderatorsJoinViaHTML5Client=true
~~~

## Restrict access to specific ports

If your BigBlueButton server is publically available on the internet, for increased security, you should restrict access only to the following ports:

  * TCP/IP port 22 for SSH
  * TCP/IP port 80 for HTTP
  * TCP/IP port 443 for HTTPS
  * TCP/IP port 1935 for RTMP (only needed if Flash client is required)
  * UDP ports 16384 to 32768 for media connections

By default, a Ubuntu 16.04 server does not restrict access.  Using Ubuntu's uncompliated firewall `ufw`, you can restrict access to the above ports using the following commands:

~~~
apt-get install -y ufw
ufw allow OpenSSH
ufw allow "Nginx Full"
ufw allow 1935/tcp           # omit if you don't run the Flash client
ufw allow 16384:32768/udp
ufw --force enable
~~~

Note: If your server is behind a firewall already -- such as running within your company or on an EC2 instance behind a Amazon Security Group -- and the firewall is enforcing the above restrictions, you don't need to run the above `ufw` commands. 

## Extract the shared secret

Any front-end to BigBlueButton needstwo pieces of information: the hostname for the BigBlueButton server and its shared secret (for authenticating API calls).  To print out the hostname and shared secret for you BigBlueButton server, enter the command `bbb-conf --secret`:

~~~
$ bbb-conf --secret

       URL: http://bigbluebutton.example.com/bigbluebutton/
    Secret: 577fd5f05280c10fb475553d200f3322

      Link to the API-Mate:
      http://mconf.github.io/api-mate/#server=http://10.0.3.132/bigbluebutton/&sharedSecret=577fd5f05280c10fb475553d200f3322
~~~

The last line gives a link API-Mate, an excellent tool provided by [Mconf Technologies](https://mconf.com/) (a company that has made many contributions to the BigBlueButton project over the years) that makes it easy to create API calls.

## Configure guest policy

There is work underway to add the ability for moderators to approve incoming viewers in the HTML5 client (see [#5979](https://github.com/bigbluebutton/bigbluebutton/issues/5979); however, this feature is not yet implemented.

The policy for guest management on the server is is set in the properties file for `bbb-web`, which is at `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties`.

~~~
# Default Guest Policy
# Valid values are ALWAYS_ACCEPT, ALWAYS_DENY, ASK_MODERATOR
#
defaultGuestPolicy=ALWAYS_ACCEPT
~~~

Currently, if this value is set as `ASK_MODERATOR` (which may occur in some upgrades from 2.0 to 2.2), it will prevent HTML5 users from joining the session.  

For now, to enable HTML5 users to join, change it to `ALWAYS_ACCEPT` and restart BigBlueButton server with `sudo bbb-conf --restart`.


## Modify the default landing page

The default HTML landing page is located in

~~~
/var/www/bigbluebutton-default/index.html
~~~

Change this page to create your own landing page (and keep a back-up copy of it as it will be overwritten duing package updates to `bbb-conf`).


## Use the Green Light front-end

BigBlueButton comes with Green Light, a front-end application written in Ruby on Rails that makes it easy for users to create meetings, invite others, start meetings, and manage recordings.

![greenlight-start](/images/gl-start.png)

For more information see [Installing GreenLight](/install/greenlight-v2.html).

## Enable background music when only one person is in a session

FreeSWITCH enables you to have music play in the background when only one users is in the voice conference.  To enable background music, edit `/opt/freeswitch/conf/autoload_configs/conference.conf.xml` (as root) and around line 204 you'll see the music on hold (moh-sound) commented out

~~~xml
<!--
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="enter-sound" value="tone_stream://%(200,0,500,600,700)"/>
      <param name="exit-sound" value="tone_stream://%(500,0,300,200,100,50,25)"/>
-->
~~~

Uncomment it and save this file.

~~~xml
      <param name="moh-sound" value="$${hold_music}"/>
<!--
      <param name="enter-sound" value="tone_stream://%(200,0,500,600,700)"/>
      <param name="exit-sound" value="tone_stream://%(500,0,300,200,100,50,25)"/>
-->
~~~

The default BigBlueButton installation does not come with any music files.  You'll need to upload a music file in WAV format to the server and change a reference in `/opt/freeswitch/conf/vars.xml`.

For example, to use the file `/opt/freeswitch/share/freeswitch/sounds/en/us/callie/ivr/48000/ivr-to_listen_to_moh.wav` as music on hold, edit `/opt/freeswitch/conf/vars.xml` and change the line

~~~xml
  <X-PRE-PROCESS cmd="set" data="hold_music=local_stream://moh"/>
~~~

to

~~~xml
  <X-PRE-PROCESS cmd="set" data="hold_music=/opt/freeswitch/share/freeswitch/sounds/en/us/callie/ivr/48000/ivr-to_listen_to_moh.wav" />
~~~

and then restart BigBlueButton

~~~
# bbb-conf --restart
~~~

and join an audio session.  You should now hear music on hold if there is only one user in the session.  


## Add a phone number to the conference bridge

The built-in WebRTC-based audio in BigBlueButton is very high quality audio.  Still, there may be cases where you want users to be able to dial into the conference bridge using a telephone number.

Before you can configure FreeSWITCH to route the call to the right conference, you need to first obtain a phone number from a [Internet Telephone Service Providers](https://freeswitch.org/confluence/display/FREESWITCH/Providers+ITSPs) and configure FreeSWITCH accordingly to receive incoming calls via session initiation protocol (SIP) from that provider.

To route the incoming call to the correct BigBlueButton audio conference, you need to create a `dialplan` which, for FreeSWITCH, is a set of instructions that it runs when receiving an incoming call.  When a user calls the phone number, the dialplan will prompt the user to enter a five digit number associated with the conference.  

To create the dialplan, use the XML below and save it to `/opt/freeswitch/conf/dialplan/public/my_provider.xml`.  Replace `EXTERNALDID` with the phone number phone number given to you by your Internet Telephone Service Provider (such as 6135551234).

~~~xml
<extension name="from_my_provider">
 <condition field="destination_number" expression="^EXTERNALDID">
   <action application="answer"/>
   <action application="sleep" data="500"/>
   <action application="play_and_get_digits" data="5 5 3 7000 # conference/conf-pin.wav ivr/ivr-that_was_an_invalid_entry.wav pin \d+"/>
   <action application="transfer" data="SEND_TO_CONFERENCE XML public"/>
 </condition>
</extension>
<extension name="check_if_conference_active">
 <condition field="${conference ${pin} list}" expression="/sofia/g" />
 <condition field="destination_number" expression="^SEND_TO_CONFERENCE$">
   <action application="set" data="bbb_authorized=true"/>
   <action application="transfer" data="${pin} XML default"/>
 </condition>
</extension>
~~~

Change ownership of this file to `freeswitch:daemon`

~~~
# chown freeswitch:daemon /opt/freeswitch/conf/dialplan/public/my_provider.xml
~~~

and then restart FreeSWITCH:

~~~
# systemctl restart freeswitch
~~~

Try calling the phone number.  It should connect to FreeSWITCH and you should hear a voice prompting you to enter the five digit PIN number for the conference.  

To show users the phone number along with the 5-digit PIN number within BigBlueButton, edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and change 613-555-1234 to the phone number provided by your Internet Telephone Service Provider

~~~properties
#----------------------------------------------------
# Default dial access number
defaultDialAccessNumber=613-555-1234
~~~

and change `defaultWelcomeMessageFooter` to

~~~properties
defaultWelcomeMessageFooter=<br><br>To join this meeting by phone, dial:<br>  %%DIALNUM%%<br>Then enter %%CONFNUM%% as the conference PIN number.
~~~

Save `bigbluebutton.properties` and restart BigBlueButton again.  Each user that joins a session will see a message in the chat similar to.

~~~
To join this meeting by phone, dial:
   613-555-1234
and enter 12345 as the conference PIN number.
~~~


## Change the shared secret

To validate incoming API calls, all external applications making API calls must checksum their API call using the same secret as configured in the BigBlueButton server.

You’ll find the shared secret in `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties`

~~~properties   
beans.dynamicConferenceService.securitySalt=<value_of_salt>
~~~

To change the shared secret, do the following:

  1. Generate a new Universal Unique ID (UUID) from a UUID generator such as at [http://www.somacon.com/p113.php](http://www.somacon.com/p113.php). This will give a long string of random numbers that will be impossible to reverse engineer.
  1. Run the command `sudo bbb-conf --setsecret new_secret`.

Note: If you have created you own front-end or are using a [third-party plug-in](http://bigbluebutton.org/support) to connect to BigBlueButton, its shared secret; otherwise, if the shared secrets do not match, the checksum for the incoming API calls will not match and the BigBlueButton server will reject the API call with an error.


## Change the default presentation

When a new meeting starts, BigBlueButton displays a default presentation.  The file for the default presentation is located in `/var/www/bigbluebutton-default/default.pdf`.  You can replace the contents of this file with your presentation.  Whenever a meeting is created, BigBlueButton will automatically load, convert, and display this presentation for all users.

Alternatively, you can change the global default by editing `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and changing the URL for `beans.presentationService.defaultUploadedPresentation`.

~~~
# Default Uploaded presentation file
beans.presentationService.defaultUploadedPresentation=${bigbluebutton.web.serverURL}/default.pdf
~~~

You'll need to restart BigBlueButton after the change with `sudo bbb-conf --restart`.

If you want to specify the default presentation for a given meeting, you can also pass a URL to the presentation as part of the [create](/dev/api.html#pre-upload-slides) meeting API call.


## Change the default welcome message

The default welcome message is built from three parameters: two system-wide parameters (see below) and the `welcome` parameter from the BigBlueButton `create` API call.  

You'll find the two system-wide welcome parameters `defaultWelcomeMessage` and `defaultWelcomeMessageFooter` in `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties`.

~~~
defaultWelcomeMessage=<default welcome message>
defaultWelcomeMessageFooter=<default welcome message footer>
~~~

When a front-end creates a BigBlueButton session, it may also pass a `welcome` parameter in the [create](/dev/api.html#create) API call.  

The final welcome message shown to the user (as blue text in the Chat window) is a composite of `welcome` + `defaultWelcomeMessage` + `defaultWelcomeMessageFooter`.

The welcome message is fixed for the duration of a meeting.  If you want to see the effect of changing the `welcome` parameter, you must [end](/dev/api.html#end) the current meeting or wait until the BigBlueButton server removes it from memory (which occurs about two minutes after the last person has left).  If you change the parameters in `bigbluebutton.properties`, you must restart BigBlueButton with `sudo bbb-conf --restart` for the new values to take effect.


# Other configuration options

## Increase the file size for an uploaded presentation

The default maximum file upload size for an uploaded presentation is 30 MB.

To increase this size, edit /var/www/bigbluebutton/client/conf/config.xml` and edit `maxFileSize` to the new value (note: if you have the development environment you need to edit ~/dev/bigbluebutton/bigbluebutton-client/src/conf/config.xml and then rebuild the client).

Next, change the corresponding limit in nginx.  Edit `/etc/bigbluebutton/nginx/web.nginx` and modify the value for `client_max_body_size`

~~~
       location /bigbluebutton {
           proxy_pass         http://127.0.0.1:8080;
           proxy_redirect     default;
           proxy_set_header   X-Forwarded-For $proxy_add_x_forwarded_for;

        # Allow 30M uploaded presentation document.
           client_max_body_size       30m;
~~~

Restart BigBlueButton with `sudo bbb-conf --restart`.  You should now be able to upload larger presentations within the new limit.


## Turn off the "comfort noise" when no one is speaking

FreeSWITCH applies a "comfort noise"'" that is a slight background hiss to let users know they are still in a voice conference even when no one is talking (otherwise, they may forget they are connected to the conference bridge and say something unintended for others).  

If you want to remove the comfort noise, edit `/opt/freeswitch/conf/autoload_configs/conference.conf.xml` and change

~~~xml
<param name="comfort-noise" value="true"/>
~~~

to

~~~xml
<param name="comfort-noise" value="false"/>
~~~

Then restart BigBlueButton

~~~
#  bbb-conf --restart
~~~

## Change processing interval for recordings

Normally, the BigBlueButton server begins processing the data recorded in a session soon after the session finishes.  However, you can change the timing for processing by creating an override for the default `bbb-record-core.timer`.


For example, to process recordings between 18:00 to 05:59, enter 

~~~
sudo systemctl edit bbb-record-core.timer
~~~

which will open a text editor.  Copy ad paste in the following contents:

~~~
[Timer]
# Disable the default timer
OnUnitInactiveSec=

# Run every minute from 18:00 to 05:59
OnCalendar=18,19,20,21,22,23,00,01,02,03,04,05:*
~~~

and save the file.  

See the man page `systemd.time` (under CALENDAR EVENTS) for more details about the syntax for `OnCalendar=`.


## Transfer published recordings from another server

If you want to do the minimum amount of work to quickly make your existing recordings on an older BigBlueButton server, transfer the contents of the `/var/bigbluebutton/published` and `/var/bigbluebutton/unpublished` directories. In addition, to preserve the backup of the original raw media, you should transfer the contents of the `/var/bigbluebutton/recording/raw` directory.

Here is an example set of rsync commands that would accomplish this; run these on the new server to copy the files from the old server.

~~~
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/published/ /var/bigbluebutton/published/
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/unpublished/ /var/bigbluebutton/unpublished/
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/recording/raw/ /var/bigbluebutton/recording/raw/
~~~

Other methods of transferring these files can also be used; for example, you could create a tar archive of each of the directories, and transfer it via scp, or use a shared NFS mount.

You will then need to fix the permissions on the newly copied recordings:

~~~
chown -R bigbluebutton:bigbluebutton /var/bigbluebutton/published /var/bigbluebutton/unpublished /var/bigbluebutton/recording/raw
~~~

If the recordings were copied from a server with a different hostname, you will have to run the following command to fix the stored hostnames. (If you don't do this, it'll either return a 404 error, or attempt to load the recordings from the old server instead of the new server!)

Note that this command will restart the BigBlueButton server, interrupting any live sessions.

~~~
$ bbb-conf --setip <ip_address_or_hostname>
~~~

For example,

~~~
$ bbb-conf --setip bigbluebutton.example.com
~~~

The transferred recordings should be immediately visible via the BigBlueButton recordings API.


### Re-process raw recordings

After transfer of recordings (see above), view a sampling of the recordings to ensure they playback correctly (they should).  

If you have transferred over the raw content, you can also reprocess the recordings using the newer scripts to rebuild them with the latest playback format (including any bug fixes made in the latest version).  Note: Re-processing can take a long time (around 25% to 50% of the original length of the recordings), and will use a lot of CPU on your new BigBlueButton server while you wait for the recordings to process.

If you are interested in reprocessing the older recordings, try it first with one or two of the larger recordings.  If there is no perceptible difference, you don't need to reprocess the others.

If your old server has all of the original recording files in the `/var/bigbluebutton/recording/raw` directory, then you can transfer these files to the new server, for example with rsync:

This example rsync command could be run on the new server, and will copy the recording file from the old server.

~~~
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/recording/raw/ /var/bigbluebutton/recording/raw/
~~~

There are other ways of transferring these files; for example, you could create a tar archive of the `/var/bigbluebutton/recording/raw` directory, and copy it with scp, or use a shared NFS mount. Any method should work fine.

You will then need to fix the permissions on the newly copied recordings:

~~~
$ chown -R bigbluebutton:bigbluebutton /var/bigbluebutton/recording/raw
~~~

And initiate the re-processing of a single recording, you can do


~~~
$ bbb-record --rebuild <recording_id>
~~~

where `<recording_id>` is the the file name of the raw recording in `/var/bigbluebutton/recording/raw`, such as

~~~
$ bbb-record --rebuild f4ae6fd61e2e95940e2e5a8a246569674c63cb4a-1517234271176
~~~

If you want to rebuild all your recordings, enter the command
~~~
$ bbb-record --rebuildall
~~~

The BigBlueButton server will automatically go through the recordings and rebuild and publish them. You can use the `bbb-record --watch` command to see the progress.


### Migrate recordings from a previous version

Depending of the previous version there may be some differences in the metadata generated. In order to fix that it will be necessary to execute the corresponding scripts for updating the migrated recordings.

~~~
$ cd /usr/local/bigbluebutton/core/scripts
~~~

#### From version 0.9
~~~
$ sudo ./bbb-0.9-beta-recording-update
$ sudo ./bbb-0.9-recording-size
~~~

#### From version 1.0
~~~
$ sudo ./bbb-1.1-meeting-tag
~~~

If for some reason the scripts have to be run more than once, use the --force modifier.

~~~
$ sudo ./bbb-x.x-script --force
~~~

## Install callback for events (webhooks)

Want to receive callbacks to your application when an event occurs in BigBlueButton? BigBlueButton provides an optional web hooks package that installs a node.js application listens for all events on BigBlueButton and sends POST requests with details about these events to hooks registered via an API.  A hook can be any external URL that can receive HTTP POST requests.

To install bbb-webhooks

~~~
# apt-get install bbb-webhooks
~~~

For information on cofiguring bbb-webhooks, see [bbb-webhooks](/dev/webhooks.html).

## Change the default locale

XXX - Needs updating

By default, the BigBlueButton client should detect the browser's locale and use that default language accordingly.  The default language is English, but you can change that by editing `bigbluebutton/client/BigBlueButton.html` and change the value

~~~
localeChain = "en_US";
~~~

You can see the list of languages installed with BigBlueButton in the directory `/usr/share/meteor/bundle/programs/server/assets/app/locales`.


## Always record every meeting

By default, the BigBlueButton server will produce a recording when (1) the meeting has been created with `record=true` in the create API call and (2) a moderator has clicked the Start/Stop Record button (at least once) during the meeting.

However, you can configure a BigBlueButton server to record every meeting, edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and change

~~~
# Start recording when first user joins the meeting.
# For backward compatibility with 0.81 where whole meeting
# is recorded.
autoStartRecording=false

# Allow the user to start/stop recording.
allowStartStopRecording=true
~~~

to

~~~
# Start recording when first user joins the meeting.
# For backward compatibility with 0.81 where whole meeting
# is recorded.
autoStartRecording=true

# Allow the user to start/stop recording.
allowStartStopRecording=false
~~~

To apply the changes, restart the BigBlueButton server using the command

~~~
sudo bbb-conf --restart
~~~


## Increase the 200 page limit for uploads

BigBlueButton, by default, restricts uploads to 200 pages.  To increase this value, open `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and change the `maxNumPages` value:

~~~
#----------------------------------------------------
# Maximum number of pages allowed for an uploaded presentation (default 200).
maxNumPages=200
~~~

After you save the changes to `bigbluebutton.properties`, restart the BigBlueButton server with

~~~
sudo bbb-conf --restart
~~~

## Restrict webcam sharing to the presenter

You can configure all meetings to restrict sharing of webcam to only the current presenter. To do so, open [config.xml](/admin/client-configuration.html#configxml) in the parameters for videomodule, change the following:

~~~
presenterShareOnly="false"
~~~

to

~~~
presenterShareOnly="true"
~~~


## Turn off "you are now muted"

You can remove this sound for all users by editing `/opt/freeswitch/etc/freeswitch/autoload_configs/conference.conf.xml` and moving the lines containing `muted-sound` and `unmuted-sound` into the commented section.

~~~xml
    <profile name="cdquality">
      <param name="domain" value="$${domain}"/>
      <param name="rate" value="48000"/>
      <param name="interval" value="20"/>
      <param name="energy-level" value="100"/>
      <!-- <param name="sound-prefix" value="$${sounds_dir}/en/us/callie"/> -->
      <param name="muted-sound" value="conference/conf-muted.wav"/>
      <param name="unmuted-sound" value="conference/conf-unmuted.wav"/>
      <param name="alone-sound" value="conference/conf-alone.wav"/>
<!--
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="enter-sound" value="tone_stream://%(200,0,500,600,700)"/>
      <param name="exit-sound" value="tone_stream://%(500,0,300,200,100,50,25)"/>
-->
      <param name="kicked-sound" value="conference/conf-kicked.wav"/>
      <param name="locked-sound" value="conference/conf-locked.wav"/>
      <param name="is-locked-sound" value="conference/conf-is-locked.wav"/>
      <param name="is-unlocked-sound" value="conference/conf-is-unlocked.wav"/>
      <param name="pin-sound" value="conference/conf-pin.wav"/>
      <param name="bad-pin-sound" value="conference/conf-bad-pin.wav"/>
      <param name="caller-id-name" value="$${outbound_caller_name}"/>
      <param name="caller-id-number" value="$${outbound_caller_id}"/>
      <param name="comfort-noise" value="true"/>

      <!-- <param name="conference-flags" value="video-floor-only|rfc-4579|livearray-sync|auto-3d-position|minimize-video-encoding"/> -->

      <!-- <param name="video-mode" value="mux"/> -->
      <!-- <param name="video-layout-name" value="3x3"/> -->
      <!-- <param name="video-layout-name" value="group:grid"/> -->
      <!-- <param name="video-canvas-size" value="1920x1080"/> -->
      <!-- <param name="video-canvas-bgcolor" value="#333333"/> -->
      <!-- <param name="video-layout-bgcolor" value="#000000"/> -->
      <!-- <param name="video-codec-bandwidth" value="2mb"/> -->
      <!-- <param name="video-fps" value="15"/> -->

    </profile>
~~~

## Install client self-check

BigBlueButton provides an end-user self-check application that can help you diagnose networking and configuration issues that may be preventing an end-user from accessing the server using the Flash client.  

To install the end-user self-check application, enter the command

~~~
$ sudo apt-get install bbb-check
~~~

The self-check application is available at your BigBlueButton server's IP address (or hostname) with `/check` appended.  For example, you can try out the self-check application on the BigBlueButton demo server at [http://demo.bigbluebutton.org/check](http://demo.bigbluebutton.org/check).

Later on, if you wish to remove the end-user self-check page, enter the command

~~~
$ sudo apt-get purge bbb-check
~~~


## Mute all users on startup

If you want to have all users join muted, you can modify `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and set this as a server-wide configuration.  

~~~
# Mute the meeting on start
muteOnStart=false
~~~

After making them modification, restart your server with `sudo bbb-conf --restart` to apply the changes.


