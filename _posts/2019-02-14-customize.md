---
layout: page
title: "Customize"
category: 2.2
redirect_from: 
  - /admin/client-configuration.html
date: 2019-02-14 22:13:42
---

This document covers common customizations of BigBlueButton 2.2.

# Common Customizations

## Remove the API demos

If you have earlier installed the API demos for testing (which makes it possible for anyone to use your BigBlueButton server without authentication) and want to now remove them, enter the command:

```bash
$ sudo apt-get purge bbb-demo
```

## Make the HTML5 client default

To make the HTML5 client the default client (and no longer load the Flash client), edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and set both `attendeesJoinViaHTML5Client` and `moderatorsJoinViaHTML5Client` to `true`, as in

```properties
# Force all attendees to join the meeting using the HTML5 client
attendeesJoinViaHTML5Client=true

# Force all moderators to join the meeting using the HTML5 client
moderatorsJoinViaHTML5Client=true
```

In BigBlueButton 2.2-beta-10, you can also decrease the slide conversion time by disabling creation of SWF files by setting `swfSlidesRequired=false`.

```properties
#----------------------------------------------------
# Conversion of the presentation slides to SWF to be
# used in the Flash client
swfSlidesRequired=false
```

The SWF files are not needed by the HTML5 client.

## Secure your system -- restrict access to specific ports

Configuring IP firewalling is *essential for securing your installation*. By default, many services are reachable across the network. This allows BigBlueButton operate in clusters and private data center networks -- but if your BigBlueButton server is publicly available on the internet, you need to run a firewall to reduce access to the minimal required ports.

If your server is behind a firewall already -- such as running within your company or on an EC2 instance behind a Amazon Security Group -- and the firewall is enforcing the above restrictions, you don't need a second firewall and can skip this section.

BigBlueButton comes with a [UFW](https://launchpad.net/ufw) based ruleset. It it can be applied on restart (c.f. [Automatically apply configuration changes on restart](#automatically-apply-configuration-changes-on-restart)) and restricts access only to the following needed ports:

* TCP/IP port 22 for SSH
* TCP/IP port 80 for HTTP
* TCP/IP port 443 for HTTPS
* UDP ports 16384 to 32768 for media connections

Note: if you have configured `sshd` (the OpenSSH daemon) to use a different port than 22, then before running the commands below, change `ufw allow OpenSSH` to `ufw allow <port>/tcp` where `<port>` is the port in use by `sshd`.  You can see the listening port for `sshd` using the command `# netstat -antp | grep sshd`.  Here the command shows `sshd` listening to the standard port 22.

```bash
$ netstat -antp | grep sshd
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      1739/sshd       
tcp6       0      0 :::22                   :::*                    LISTEN      1739/sshd       
```

To restrict external access minimal needed ports for BigBlueButton (with [HTML5 client set as default](#make-the-html5-client-default)), use the following commands:

```bash
$ apt-get install -y ufw
ufw allow OpenSSH
ufw allow "Nginx Full"
ufw allow 16384:32768/udp
ufw --force enable
```

These `ufw` firewall rules will be automatically re-applied on server reboot.

Besides IP-based firewalling, you can explore web application firewalls such as [ModSecurity](https://modsecurity.org/) that provide additional security by checking requests to various web-based components.

## Extract the shared secret

Any front-end to BigBlueButton needs two pieces of information: the hostname for the BigBlueButton server and its shared secret (for authenticating API calls).  To print out the hostname and shared secret for you BigBlueButton server, enter the command `bbb-conf --secret`:

```bash
$ bbb-conf --secret

       URL: http://bigbluebutton.example.com/bigbluebutton/
    Secret: 577fd5f05280c10fb475553d200f3322

      Link to the API-Mate:
      http://mconf.github.io/api-mate/#server=http://10.0.3.132/bigbluebutton/&sharedSecret=577fd5f05280c10fb475553d200f3322
```

The last line gives a link API-Mate, an excellent tool provided by [Mconf Technologies](https://mconf.com/) (a company that has made many contributions to the BigBlueButton project over the years) that makes it easy to create API calls.

## Configure guest policy

There is work underway to add the ability for moderators to approve incoming viewers in the HTML5 client (see [#5979](https://github.com/bigbluebutton/bigbluebutton/issues/5979); however, this feature is not yet implemented.

The policy for guest management on the server is is set in the properties file for `bbb-web`, which is at `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties`.

```properties
# Default Guest Policy
# Valid values are ALWAYS_ACCEPT, ALWAYS_DENY, ASK_MODERATOR
#
defaultGuestPolicy=ALWAYS_ACCEPT
```

Currently, if this value is set as `ASK_MODERATOR` (which may occur in some upgrades from 2.0 to 2.2), it will prevent HTML5 users from joining the session.  

For now, to enable HTML5 users to join, change it to `ALWAYS_ACCEPT` and restart BigBlueButton server with `sudo bbb-conf --restart`.

## Modify the default landing page

The default HTML landing page is located in

```
/var/www/bigbluebutton-default/index.html
```

Change this page to create your own landing page (and keep a back-up copy of it as it will be overwritten during package updates to `bbb-conf`).

## Use the Greenlight front-end

BigBlueButton comes with Greenlight, a front-end application written in Ruby on Rails that makes it easy for users to create meetings, invite others, start meetings, and manage recordings.

![greenlight-start](/images/greenlight/room.png)

For more information see [Installing Greenlight](/greenlight/gl-install.html).

## Enable background music when only one person is in a session

FreeSWITCH enables you to have music play in the background when only one users is in the voice conference.  To enable background music, edit `/opt/freeswitch/conf/autoload_configs/conference.conf.xml` (as root) and around line 204 you'll see the music on hold (moh-sound) commented out

```xml
<!--
      <param name="moh-sound" value="$${hold_music}"/>
      <param name="enter-sound" value="tone_stream://%(200,0,500,600,700)"/>
      <param name="exit-sound" value="tone_stream://%(500,0,300,200,100,50,25)"/>
-->
```

Uncomment it and save this file.

```xml
      <param name="moh-sound" value="$${hold_music}"/>
<!--
      <param name="enter-sound" value="tone_stream://%(200,0,500,600,700)"/>
      <param name="exit-sound" value="tone_stream://%(500,0,300,200,100,50,25)"/>
-->
```

The default BigBlueButton installation does not come with any music files.  You'll need to upload a music file in WAV format to the server and change a reference in `/opt/freeswitch/conf/vars.xml`.

For example, to use the file `/opt/freeswitch/share/freeswitch/sounds/en/us/callie/ivr/48000/ivr-to_listen_to_moh.wav` as music on hold, edit `/opt/freeswitch/conf/vars.xml` and change the line

```xml
  <X-PRE-PROCESS cmd="set" data="hold_music=local_stream://moh"/>
```

to

```xml
  <X-PRE-PROCESS cmd="set" data="hold_music=/opt/freeswitch/share/freeswitch/sounds/en/us/callie/ivr/48000/ivr-to_listen_to_moh.wav" />
```

and then restart BigBlueButton

```bash
$ bbb-conf --restart
```

and join an audio session.  You should now hear music on hold if there is only one user in the session.  

## Add a phone number to the conference bridge

The built-in WebRTC-based audio in BigBlueButton is very high quality audio.  Still, there may be cases where you want users to be able to dial into the conference bridge using a telephone number.

Before you can configure FreeSWITCH to route the call to the right conference, you need to first obtain a phone number from a [Internet Telephone Service Providers](https://freeswitch.org/confluence/display/FREESWITCH/Providers+ITSPs) and configure FreeSWITCH accordingly to receive incoming calls via session initiation protocol (SIP) from that provider.

To route the incoming call to the correct BigBlueButton audio conference, you need to create a `dialplan` which, for FreeSWITCH, is a set of instructions that it runs when receiving an incoming call.  When a user calls the phone number, the dialplan will prompt the user to enter a five digit number associated with the conference.  

To create the dialplan, use the XML below and save it to `/opt/freeswitch/conf/dialplan/public/my_provider.xml`.  Replace `EXTERNALDID` with the phone number phone number given to you by your Internet Telephone Service Provider (such as 6135551234).

```xml
<extension name="from_my_provider">
 <condition field="destination_number" expression="^EXTERNALDID">
   <action application="answer"/>
   <action application="sleep" data="500"/>
   <action application="playback" data="conference/conf-pin.wav"/>
   <action application="play_and_get_digits" data="5 5 3 7000 # silence conference/conf-bad-pin.wav pin \d+ 7000 EXTERNALDID"/>
   <action application="transfer" data="SEND_TO_CONFERENCE XML public"/>
 </condition>
</extension>
<extension name="check_if_conference_active">
 <condition field="${conference ${pin} list}" expression="/sofia/g" />
 <condition field="destination_number" expression="^SEND_TO_CONFERENCE$">
   <action application="playback" data="conference/conf-welcome.wav"/>
   <action application="playback" data="tone_stream://%(200,0,500,600,700)" />
   <action application="set" data="bbb_authorized=true"/>
   <action application="transfer" data="${pin} XML default"/>
 </condition>
</extension>
<extension name="check_if_no_conference">
 <condition field="${conference ${pin} list}" expression="/ not found/g" />
 <condition field="destination_number" expression="^SEND_TO_CONFERENCE$">
   <action application="playback" data="conference/conf-bad-pin.wav"/>
   <action application="unset" data="pin"/>
   <action application="transfer" data="EXTERNALDID"/>
 </condition>
</extension>
```

Change ownership of this file to `freeswitch:daemon`

```bash
$ chown freeswitch:daemon /opt/freeswitch/conf/dialplan/public/my_provider.xml
```

and then restart FreeSWITCH:

```bash
$ sudo systemctl restart freeswitch
```

Try calling the phone number.  It should connect to FreeSWITCH and you should hear a voice prompting you to enter the five digit PIN number for the conference.  

To show users the phone number along with the 5-digit PIN number within BigBlueButton, edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and change 613-555-1234 to the phone number provided by your Internet Telephone Service Provider

```properties
#----------------------------------------------------
# Default dial access number
defaultDialAccessNumber=613-555-1234
```

and change `defaultWelcomeMessageFooter` to

```properties
defaultWelcomeMessageFooter=<br><br>To join this meeting by phone, dial:<br>  %%DIALNUM%%<br>Then enter %%CONFNUM%% as the conference PIN number.
```

Save `bigbluebutton.properties` and restart BigBlueButton again.  Each user that joins a session will see a message in the chat similar to.

```
To join this meeting by phone, dial:
   613-555-1234
and enter 12345 as the conference PIN number.
```

Finally, setup the firewall rules so you are only accepting incoming calls from the IP address of your SIP provider.  For example, if your SIP provider forwards incoming calls from 64.2.142.33, then setup the following firewall rules on your server.

```
iptables -A INPUT -i eth0 -p tcp --dport 5060 -s 0.0.0.0/0 -j REJECT
iptables -A INPUT -i eth0 -p udp --dport 5060 -s 0.0.0.0/0 -j REJECT
iptables -A INPUT -i eth0 -p tcp --dport 5080 -s 0.0.0.0/0 -j REJECT
iptables -A INPUT -i eth0 -p udp --dport 5080 -s 0.0.0.0/0 -j REJECT
iptables -I INPUT  -p udp --dport 5060 -s 64.2.142.33 -j ACCEPT
```

With these rules, you won't get spammed by bots scanning for SIP endpoints and trying to connect.

## Change the shared secret

To validate incoming API calls, all external applications making API calls must checksum their API call using the same secret as configured in the BigBlueButton server.

You’ll find the shared secret in `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties`

```properties
beans.dynamicConferenceService.securitySalt=<value_of_salt>
```

To change the shared secret, do the following:

1. Generate a new Universal Unique ID (UUID) from a UUID generator such as at [http://www.somacon.com/p113.php](http://www.somacon.com/p113.php). This will give a long string of random numbers that will be impossible to reverse engineer.
2. Run the command `sudo bbb-conf --setsecret new_secret`.

Note: If you have created you own front-end or are using a [third-party plug-in](http://bigbluebutton.org/support) to connect to BigBlueButton, its shared secret; otherwise, if the shared secrets do not match, the checksum for the incoming API calls will not match and the BigBlueButton server will reject the API call with an error.

## Change the default presentation

When a new meeting starts, BigBlueButton displays a default presentation.  The file for the default presentation is located in `/var/www/bigbluebutton-default/default.pdf`.  You can replace the contents of this file with your presentation.  Whenever a meeting is created, BigBlueButton will automatically load, convert, and display this presentation for all users.

Alternatively, you can change the global default by editing `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and changing the URL for `beans.presentationService.defaultUploadedPresentation`.

```properties
# Default Uploaded presentation file
beans.presentationService.defaultUploadedPresentation=${bigbluebutton.web.serverURL}/default.pdf
```

You'll need to restart BigBlueButton after the change with `sudo bbb-conf --restart`.

If you want to specify the default presentation for a given meeting, you can also pass a URL to the presentation as part of the [create](/dev/api.html#pre-upload-slides) meeting API call.

## Change the default welcome message

The default welcome message is built from three parameters: two system-wide parameters (see below) and the `welcome` parameter from the BigBlueButton `create` API call.  

You'll find the two system-wide welcome parameters `defaultWelcomeMessage` and `defaultWelcomeMessageFooter` in `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties`.

```properties
defaultWelcomeMessage=<default welcome message>
defaultWelcomeMessageFooter=<default welcome message footer>
```

When a front-end creates a BigBlueButton session, it may also pass a `welcome` parameter in the [create](/dev/api.html#create) API call.  

The final welcome message shown to the user (as blue text in the Chat window) is a composite of `welcome` + `defaultWelcomeMessage` + `defaultWelcomeMessageFooter`.

The welcome message is fixed for the duration of a meeting.  If you want to see the effect of changing the `welcome` parameter, you must [end](/dev/api.html#end) the current meeting or wait until the BigBlueButton server removes it from memory (which occurs about two minutes after the last person has left).  If you change the parameters in `bigbluebutton.properties`, you must restart BigBlueButton with `sudo bbb-conf --restart` for the new values to take effect.

## Delete raw data from published recordings

When a meeting finishes, the BigBlueButton server [archives the meeting data](/dev/recording.html#archive) (referred to as the "raw" data).  

Retaining the raw data lets you [rebuild](/dev/recording.html#rebuild-a-recording) a recording if it was accidentally deleted by a user; hHowever, the tradeoff is the storage of raw data will consume more disk space over time.

You an have the BigBlueButton server automatically remove the raw data for a recording after 14 days of its being published by editing the BigBlueButton cron job, located at `/etc/cron.daily/bigbluebutton`, and uncommenting the following line

```bash
#remove_raw_of_published_recordings
```

The default duration (days) 

```bash
published_days=14
```

is defined near the top of the BigBlueButton cron job.

## Delete recordings older than N days

To delete recordings older than 14 days, add the following cron job to `/etc/cron.daily/bbb-recording-cleanup`

```bash
#!/bin/bash

MAXAGE=14

LOGFILE=/var/log/bigbluebutton/bbb-recording-cleanup.log

shopt -s nullglob

NOW=$(date +%s)

echo "$(date --rfc-3339=seconds) Deleting recordings older than ${MAXAGE} days" >>"${LOGFILE}"

for donefile in /var/bigbluebutton/recording/status/published/*-presentation.done ; do
        MTIME=$(stat -c %Y "${donefile}")
        # Check the age of the recording
        if [ $(( ( $NOW - $MTIME ) / 86400 )) -gt $MAXAGE ]; then
                MEETING_ID=$(basename "${donefile}")
                MEETING_ID=${MEETING_ID%-presentation.done}
                echo "${MEETING_ID}" >> "${LOGFILE}"

                bbb-record --delete "${MEETING_ID}" >>"${LOGFILE}"
        fi
done

for eventsfile in /var/bigbluebutton/recording/raw/*/events.xml ; do
        MTIME=$(stat -c %Y "${eventsfile}")
        # Check the age of the recording
        if [ $(( ( $NOW - $MTIME ) / 86400 )) -gt $MAXAGE ]; then
                MEETING_ID="${eventsfile%/events.xml}"
                MEETING_ID="${MEETING_ID##*/}"
                echo "${MEETING_ID}" >> "${LOGFILE}"

                bbb-record --delete "${MEETING_ID}" >>"${LOGFILE}"
        fi
done
```

Change the value for `MAXAGE` to specify how many days to retain the `presentation` format recordings on your BigBlueButton server.

## Enable playback of recordings on iOS

The `presentation` playback format encodes the video shared during the session (webcam and screen share) as `.webm` (VP8) files; however, iOS devices only support playback of `.mp4` (h.264) video files.  To enable playback of the `presentation` recording format on iOS devices, edit `/usr/local/bigbluebutton/core/scripts/presentation.yml` and uncomment the entry for `mp4`.

```
video_formats:
  - webm
  - mp4
```

This change will cause BigBlueButton to generate an additional `.mp4` file for the video components (webcam and screen share) that was shared during the session.   This change only applies to new recordings.  If you want this change to apply to any existing recordings, you need use the `bbb-record` command to [rebuild them](/dev/recording.html#rebuild-a-recording).

This change will increase the processing time and storage size of recordings with video files as it will now generate two videos: `.webm` and `.mp4` for the webcam and screen share videos.

## Automatically apply configuration changes on restart

When you upgrade to the latest build of BigBlueButton using either the [manual steps](/2.2/install.html#upgrading-from-bigbluebutton-22) or [bbb-install.sh](https://github.com/bigbluebutton/bbb-install) script, if you have made manual changes to BigBlueButton's configuration, the packaging scripts may overwrite your changes.

Instead of an error-prone step to manually re-applying any changes after each upgrade, a better approach would be to have your custom configuration changes in a script that gets automatically when BigBlueButton gets restarted.

Whenever you manually update BigBlueButton, the [instructions](/2.2/install.html#upgrading-from-bigbluebutton-22) state to run `sudo bbb-conf --setip <hostname>` to re-apply the `<hostname>` to BigBlueButton's configuration files ([bbb-install.sh](https://github.com/bigbluebutton/bbb-install) does this for you automatically).  

There is now logic in `bbb-conf` to look for a BASH script at `/etc/bigbluebutton/bbb-conf/apply-config.sh` when doing either `--restart` or `--setip <hostname>` and, if found, execute this script before starting up BigBlueButton.

You can then put your configuration changes in `apply-config.sh` to ensure they are automatically applied.  Here's a sample `apply-config.sh` script

```sh
#!/bin/bash

# Pull in the helper functions for configuring BigBlueButton
source /etc/bigbluebutton/bbb-conf/apply-lib.sh

enableUFWRules
```

Notice it includes `apply-lib.sh` which is another BASH script that contains some helper functions (see [apply-lib.sh](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-config/bin/apply-lib.sh) source).  It then calls `enableUFWRules` to apply the settings in [restrict access to specific ports](#restrict-access-to-specific-ports).  
The contents of `apply-config.sh` are not owned by any package, so it will never be overwritten.  

When you create `apply-config.sh`, make it executable (`chmod +x /etc/bigbluebutton/bbb-conf/apply-config.sh`).  Using the above script as an example, whenever you do `bbb-conf` with `--restart` or `--setip`, you'll see the following output

```
Restarting BigBlueButton 2.2.0-xx-x ...
Stopping BigBlueButton

Applying updates in /etc/bigbluebutton/bbb-conf/apply-config.sh: 
  - Enable Firewall and opening 22/tcp, 80/tcp, 443/tcp and 16384:32768/udp
Rules updated
Rules updated (v6)
Rules updated
Rules updated (v6)
Rules updated
Rules updated (v6)
Rules updated
Rules updated (v6)
Firewall is active and enabled on system startup

Starting BigBlueButton
```

The next sections give some examples of customizations you could add to `apply-config.sh`.

### Reduce bandwidth for webcams

If you expect users to share many webcams, to [reduce bandwidth for webcams](#reduce-bandwidth-from-webcams), add the following to `apply-config.sh`.

```bash
echo "  - Setting camera defaults"
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[0].bitrate 50
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[1].bitrate 100
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[2].bitrate 200
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[3].bitrate 300

yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[0].default true
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[1].default false
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[2].default false
yq w -i $HTML5_CONFIG public.kurento.cameraProfiles.[3].default false
```

### Apply lock settings to restrict webcams

To enable lock settings for `Share webcam` by default (viewers are unable to share their webcam), add the following to `apply-config.sh`.

```bash
echo "  - Prevent viewers from sharing webcams"
sed -i 's/lockSettingsDisableCam=.*/lockSettingsDisableCam=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
```

After restart, if you open the lock settings you'll see `Share webcam` lock enabled.

<p align="center">
  <img src="/images/html5-lock-webcam.png"/>
</p><br>

### Apply custom settings for TURN server

If always want a specific TURN server configuration, the following to `apply-config.sh` and modify `aaa.bbb.ccc.ddd` and `secret` with your values.

```bash
echo "  - Update TURN server configuration turn-stun-servers.xml"
  cat <<HERE > /usr/share/bbb-web/WEB-INF/classes/spring/turn-stun-servers.xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">
    <bean id="stun0" class="org.bigbluebutton.web.services.turn.StunServer">
        <constructor-arg index="0" value="stun:aaa.bbb.ccc.ddd"/>
    </bean>
    <bean id="turn0" class="org.bigbluebutton.web.services.turn.TurnServer">
        <constructor-arg index="0" value="secret"/>
        <constructor-arg index="1" value="turns:aaa.bbb.ccc.ddd:443?transport=tcp"/>
        <constructor-arg index="2" value="86400"/>
    </bean>
    <bean id="stunTurnService"
            class="org.bigbluebutton.web.services.turn.StunTurnService">
        <property name="stunServers">
            <set>
                <ref bean="stun0"/>
            </set>
        </property>
        <property name="turnServers">
            <set>
                <ref bean="turn0"/>
            </set>
        </property>
    </bean>
</beans>
HERE
```

### Always record every meeting

To [always record every meeting](#always-record-every-meeting), add the following to `apply-config.sh`. 

```bash
echo "  - Prevent viewers from sharing webcams"
sed -i 's/autoStartRecording=.*/autoStartRecording=true/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
sed -i 's/allowStartStopRecording=.*/allowStartStopRecording=false/g' /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties
```

# Other configuration options

## Increase the file size for an uploaded presentation

The default maximum file upload size for an uploaded presentation is 30 MB.

The first step is to change the size restriction in nginx.  Edit `/etc/bigbluebutton/nginx/web.nginx` and modify the values for `client_max_body_size`.

```nginx
       location ~ "^\/bigbluebutton\/presentation\/(?<prestoken>[a-zA-Z0-9_-]+)/upload$" {
          ....
          # Allow 30M uploaded presentation document.
          client_max_body_size       30m;
          ....
       }

       location = /bigbluebutton/presentation/checkPresentation {
          ....
          # Allow 30M uploaded presentation document.
          client_max_body_size       30m;
          ....
       }
```

Next change the restriction in bbb-web. Edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and modify the value `maxFileSizeUpload`.

```properties
# Maximum file size for an uploaded presentation (default 30MB).
maxFileSizeUpload=30000000
```

The next changes are for the client-side checks and it depends on which clients you have it use. To increase the size for the Flash client, edit `/var/www/bigbluebutton/client/conf/config.xml` and modify `maxFileSize` to the new value (note: if you have the development environment you need to edit `~/dev/bigbluebutton/bigbluebutton-client/src/conf/config.xml` and then rebuild the client). To increase the size for the HTML5 client, edit `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml` and modify `uploadSizeMax`.

Restart BigBlueButton with `sudo bbb-conf --restart`.  You should now be able to upload larger presentations within the new limit.

## Turn off the "comfort noise" when no one is speaking

FreeSWITCH applies a "comfort noise"'" that is a slight background hiss to let users know they are still in a voice conference even when no one is talking (otherwise, they may forget they are connected to the conference bridge and say something unintended for others).  

If you want to remove the comfort noise, edit `/opt/freeswitch/conf/autoload_configs/conference.conf.xml` and change

```xml
<param name="comfort-noise" value="true"/>
```

to

```xml
<param name="comfort-noise" value="false"/>
```

Then restart BigBlueButton

```bash
$ sudo bbb-conf --restart
```


## Transfer published recordings from another server

If you want to do the minimum amount of work to quickly make your existing recordings on an older BigBlueButton server, transfer the contents of the `/var/bigbluebutton/published` and `/var/bigbluebutton/unpublished` directories. In addition, to preserve the backup of the original raw media, you should transfer the contents of the `/var/bigbluebutton/recording/raw` directory.

Here is an example set of rsync commands that would accomplish this; run these on the new server to copy the files from the old server.

```bash
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/published/ /var/bigbluebutton/published/
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/unpublished/ /var/bigbluebutton/unpublished/
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/recording/raw/ /var/bigbluebutton/recording/raw/
```

Other methods of transferring these files can also be used; for example, you could create a tar archive of each of the directories, and transfer it via scp, or use a shared NFS mount.

You will then need to fix the permissions on the newly copied recordings:

```bash
$ chown -R bigbluebutton:bigbluebutton /var/bigbluebutton/published /var/bigbluebutton/unpublished /var/bigbluebutton/recording/raw
```

If the recordings were copied from a server with a different hostname, you will have to run the following command to fix the stored hostnames. (If you don't do this, it'll either return a 404 error, or attempt to load the recordings from the old server instead of the new server!)

Note that this command will restart the BigBlueButton server, interrupting any live sessions.

```bash
$ sudo bbb-conf --setip <ip_address_or_hostname>
```

For example,

```bash
$ sudo bbb-conf --setip bigbluebutton.example.com
```

The transferred recordings should be immediately visible via the BigBlueButton recordings API.

### Re-process raw recordings

After transfer of recordings (see above), view a sampling of the recordings to ensure they playback correctly (they should).  

If you have transferred over the raw content, you can also reprocess the recordings using the newer scripts to rebuild them with the latest playback format (including any bug fixes made in the latest version).  Note: Re-processing can take a long time (around 25% to 50% of the original length of the recordings), and will use a lot of CPU on your new BigBlueButton server while you wait for the recordings to process.

If you are interested in reprocessing the older recordings, try it first with one or two of the larger recordings.  If there is no perceptible difference, you don't need to reprocess the others.

If your old server has all of the original recording files in the `/var/bigbluebutton/recording/raw` directory, then you can transfer these files to the new server, for example with rsync:

This example rsync command could be run on the new server, and will copy the recording file from the old server.

```bash
$ rsync -rP root@old-bbb-server:/var/bigbluebutton/recording/raw/ /var/bigbluebutton/recording/raw/
```

There are other ways of transferring these files; for example, you could create a tar archive of the `/var/bigbluebutton/recording/raw` directory, and copy it with scp, or use a shared NFS mount. Any method should work fine.

You will then need to fix the permissions on the newly copied recordings:

```bash
$ chown -R bigbluebutton:bigbluebutton /var/bigbluebutton/recording/raw
```

And initiate the re-processing of a single recording, you can do

```bash
$ sudo bbb-record --rebuild <recording_id>
```

where `<recording_id>` is the the file name of the raw recording in `/var/bigbluebutton/recording/raw`, such as

```bash
$ sudo bbb-record --rebuild f4ae6fd61e2e95940e2e5a8a246569674c63cb4a-1517234271176
```

If you want to rebuild all your recordings, enter the command

Warning: If you have a large number of recordings, this will rebuild *all* of them, and not process any new recordings until the rebuild process finishes.  Do not do this unless this is you intent.  Do not do this command to troubleshoot recording errors, instead see [Recording Troubleshooting](/dev/recording.html#troubleshooting).

```bash
$ sudo bbb-record --rebuildall
```

The BigBlueButton server will automatically go through the recordings and rebuild and publish them. You can use the `bbb-record --watch` command to see the progress.

### Migrate recordings from a previous version

Depending of the previous version there may be some differences in the metadata generated. In order to fix that it will be necessary to execute the corresponding scripts for updating the migrated recordings.

```bash
$ cd /usr/local/bigbluebutton/core/scripts
```

#### From version 0.9

```bash
$ sudo ./bbb-0.9-beta-recording-update
$ sudo ./bbb-0.9-recording-size
```

#### From version 1.0

```bash
$ sudo ./bbb-1.1-meeting-tag
```

If for some reason the scripts have to be run more than once, use the --force modifier.

```bash
$ sudo ./bbb-x.x-script --force
```

## Install callback for events (webhooks)

Want to receive callbacks to your application when an event occurs in BigBlueButton? BigBlueButton provides an optional web hooks package that installs a node.js application listens for all events on BigBlueButton and sends POST requests with details about these events to hooks registered via an API.  A hook can be any external URL that can receive HTTP POST requests.

To install bbb-webhooks

```bash
$ sudo apt-get install bbb-webhooks
```

For information on cofiguring bbb-webhooks, see [bbb-webhooks](/dev/webhooks.html).

## Change the default locale

XXX - Needs updating

By default, the BigBlueButton client should detect the browser's locale and use that default language accordingly.  The default language is English, but you can change that by editing `bigbluebutton/client/BigBlueButton.html` and change the value

```javascript
localeChain = "en_US";
```

You can see the list of languages installed with BigBlueButton in the directory `/usr/share/meteor/bundle/programs/server/assets/app/locales`.

## Always record every meeting

By default, the BigBlueButton server will produce a recording when (1) the meeting has been created with `record=true` in the create API call and (2) a moderator has clicked the Start/Stop Record button (at least once) during the meeting.

However, you can configure a BigBlueButton server to record every meeting, edit `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and change

```properties
# Start recording when first user joins the meeting.
# For backward compatibility with 0.81 where whole meeting
# is recorded.
autoStartRecording=false

# Allow the user to start/stop recording.
allowStartStopRecording=true
```

to

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

## Increase the 200 page limit for uploads

BigBlueButton, by default, restricts uploads to 200 pages.  To increase this value, open `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and change the `maxNumPages` value:

```properties
#----------------------------------------------------
# Maximum number of pages allowed for an uploaded presentation (default 200).
maxNumPages=200
```

After you save the changes to `bigbluebutton.properties`, restart the BigBlueButton server with

```bash
$ sudo bbb-conf --restart
```

## Turn off "you are now muted"

You can remove this sound for all users by editing `/opt/freeswitch/etc/freeswitch/autoload_configs/conference.conf.xml` and moving the lines containing `muted-sound` and `unmuted-sound` into the commented section.

```xml
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
```

## Reduce bandwidth from webcams

You can use a banwidth usage on your BigBlueButton server using a tool such as `bmon` (`sudo apt-get install bmon`).  You can change the maximum bandwidth settings for each webcam options (low, medium, high, high definition) by editing `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml` and modifying the entries for 

```yaml
    cameraProfiles:
    - id: low
      name: Low quality
      default: false
      bitrate: 100
    - id: medium
      name: Medium quality
      default: true
      bitrate: 200
    - id: high
      name: High quality
      default: false
      bitrate: 500
    - id: hd
      name: High definition
      default: false
      bitrate: 800
```

The settings for `bitrate` are in kbits/sec (i.e. 100 kbits/sec).  After your modify the values, save the file, restart your BigBlueButton server `sudo bbb-conf --restart` to have the settings take effect.  The lowest setting allowed for WebRTC is 30 Kbits/sec.  

If you have sessions that like to share lots of webcams, such as ten or more, then then setting the `bitrate` for `low` to 50 and `medium` to 100 will help reduce the overall bandwidth on the server.  When many webcams are shared, the size of the webcams get so small that the reduction in `bitrate` will not be noticable during the live sessions.

## Disable webcams

You can disable webcams by modifying the `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml` file and setting `enableVideo` to `false`.  To modify this file, run the following commands as root:

```bash
TARGET=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
yq w -i $TARGET public.kurento.enableVideo false
chown meteor:meteor $TARGET
```

Restart BigBlueButton (`sudo bbb-conf --restart`) to apply the change.

## Disable screen sharing

You can disable screen sharing by modifying the `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml` file and setting `enableScreensharing` to `false`.  To modify this file, run the following commands as root:

```bash
TARGET=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
yq w -i $TARGET public.kurento.enableScreensharing false
chown meteor:meteor $TARGET
```

Restart BigBlueButton (`sudo bbb-conf --restart`) to apply the change.

## Change UDP ports

By default, BigBlueButton uses the UDP ports 16384-32768 which are used by FreeSWITCH and Kurento to send real-time packets (RTP).

Specifically, FreeSWITCH uses the range 16384 - 24576, which is defined in `/opt/freeswitch/etc/freeswitch/autoload_configs/switch.conf.xml`

```xml
    <!-- RTP port range -->
    <param name="rtp-start-port" value="16384"/>
    <param name="rtp-end-port" value="24576"/>
```

Kurento uses the range 24577 - 32768, which is defined in `/etc/kurento/modules/kurento/BaseRtpEndpoint.conf.ini`

```ini
    minPort=24577
    maxPort=32768
```

## Mute all users on startup

If you want to have all users join muted, you can modify `/usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties` and set this as a server-wide configuration.  

```properties
# Mute the meeting on start
muteOnStart=false
```

After making them modification, restart your server with `sudo bbb-conf --restart` to apply the changes.

## Change favicon

To change the favicon, overwrite the file `/var/www/bigbluebutton-default/favicon.ico`.  

You'll need to update file each time the `bbb-config` package updates.

## Move recordings to a different partition

Most of BigBlueButton's storage occurs in the `/var/bigbluebutton` directory (this is where all the recordings are stored).  If you want to move this directory to another partition, say to `/mnt/data`, do the following

```
$ sudo bbb-conf --stop
$ mv /var/bigbluebutton /mnt/data
$ ln -s /mnt/data/bigbluebutton /var/bigbluebutton
$ sudo bbb-conf --start
```

# HTML5 client configuration

The configuration file for the HTML5 client is located in `/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml`.  It contains all the settings for the HTML5 client.  

## Change title in the HTML5 client

To change the title, edit `settings.yml` and change the entry for `public.app.clientTitle`

```yaml
public:
  app: 
    ...
    clientTitle: BigBlueButton
```

You'll need to update this entry each time the package `bbb-html5` updates.  The following script can help automate the change

```bash
$ TARGET=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml
$ yq w -i $TARGET public.app.clientTitle "New Title"
$ chown meteor:meteor $TARGET
```

## Send client logs to the server

To assist with monitoring and debugging, the HTML5 client can send its logs to the BigBlueButton server via the `logger` function.  Here's an example of its use:

The client logger accepts three targets for the logs: `console`, `server` and `external`.

| Name   | Default Value | Accepted Values                  | Description                                                                                             |
| ------ | ------------- | -------------------------------- | ------------------------------------------------------------------------------------------------------- |
| target | "console"     | "console", "external", "server"  | Where the logs will be sent to.                                                                         |
| level  | "info"        | "debug", "info", "warn", "error" | The lowest log level that will be sent. Any log level higher than this will also be sent to the target. |
| url    | -             | -                                | The end point where logs will be sent to when the target is set to "external".                          |
| method | -             | "POST", "PUT"                    | HTTP method being used when using the target "external".                                                |

The default values are: 

```yaml
  clientLog:
    server: { enabled: true, level: info }
    console: { enabled: true, level: debug }
    external: { enabled: false, level: info, url: https://LOG_HOST/html5Log, method: POST, throttleInterval: 400, flushOnClose: true }
```

Notice that the `external` option is disabled by default - you can enable it on your own server after a few configuration changes.

When enabling the `external` logging output, the BigBlueButton client will POST the log events to the URL endpoint provided by `url`. To create an associated endpoint on the BigBlueButton server for the POST request, create a file `/etc/bigbluebutton/nginx/html5-client-log.nginx` with the following contents:

```nginx
location /html5Log {
    access_log /var/log/nginx/html5-client.log postdata;
    echo_read_request_body;
}
```

Then create a file in `/etc/nginx/conf.d/html5-client-log.conf` with the following contents:

```nginx
log_format postdata '$remote_addr [$time_iso8601] $request_body';
```

Next, install the full version of nginx.

```bash
$ sudo apt-get install nginx-full
```

You may also need to create the external output file and give it the appropriate permissions and ownership:

```bash
$ sudo touch /var/log/nginx/html5-client.log
$ sudo chown www-data:adm /var/log/nginx/html5-client.log
$ sudo chmod 640 /var/log/nginx/html5-client.log
```

Restart BigBlueButton with `sudo bbb-conf --restart` and launch the BigBlueButton HTML5 client in a new session.  You should see the logs appearing in `/var/log/nginx/html5-client.log` as follows

```
99.239.102.0 [2018-09-09T14:59:10+00:00] [{\x22name: .. }]
```

You can follow the logs on the server with the command

```bash
$ tail -f /var/log/nginx/html5-client.log | sed -u -e 's/\\x22/"/g' -e 's/\\x5C/\\/g'
```

Here's a sample log entry

```json
{  
   "name":"clientLogger",
   "level":30,
   "levelName":"info",
   "msg":"[audio] iceServers",
   "time":"2018-08-27T19:32:57.389Z",
   "src":"https://demo.bigbluebutton.org/html5client/dfe4ad6bfad11b20d1904e76e71d385262781887.js?meteor_js_resource=true:147:782083",
   "v":1,
   "extraInfo":{  
      "sessionToken":"e7boenucj1pwkbfc",
      "meetingId":"183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1535398242909",
      "requesterUserId":"w_klfavdlkumj8",
      "fullname":"Ios",
      "confname":"Demo Meeting",
      "externUserID":"w_klfavdlkumj8"
   },
   "url":"https://demo.bigbluebutton.org/html5client/users",
   "userAgent":"Mozilla/5.0 (iPad; CPU OS 11_3 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/11.0 Mobile/15E148 Safari/604.1",
   "count":1
}
```

## Collect feedback from the users

The BigBlueButton client can ask the user for feedback when they leave a session.  This feedback gives the administrator insight on a user's experiences within a BigBlueButton sessions.

To enable the feedback and it's logging to your server, run the following script.

```bash
#!/bin/bash

HOST=$(cat /usr/share/bbb-web/WEB-INF/classes/bigbluebutton.properties | grep -v '#' | sed -n '/^bigbluebutton.web.serverURL/{s/.*\///;p}')
HTML5_CONFIG=/usr/share/meteor/bundle/programs/server/assets/app/config/settings.yml

apt-get install -y nginx-full

yq w -i $HTML5_CONFIG public.clientLog.external.enabled true
yq w -i $HTML5_CONFIG public.clientLog.external.url     "$PROTOCOL://$HOST/html5log"
yq w -i $HTML5_CONFIG public.app.askForFeedbackOnLogout true
chown meteor:meteor $HTML5_CONFIG

cat > /etc/bigbluebutton/nginx/html5-client-log.nginx << HERE
location /html5log {
        access_log /var/log/nginx/html5-client.log postdata;
        echo_read_request_body;
}

cat > /etc/nginx/conf.d/html5-client-log.conf << HERE
log_format postdata '\$remote_addr [\$time_iso8601] \$request_body';
HERE

# We need nginx-full to enable postdata log_format
if ! dpkg -l | grep -q nginx-full; then
  apt-get install -y nginx-full
fi

touch /var/log/nginx/html5-client.log
chown bigbluebutton:bigbluebutton /var/log/nginx/html5-client.log
```

The feedback will be written to `/var/log/nginx/html5-client.log`, which you would need to extract and parse.  You can also use the following command to monitor the feedback

```bash
tail -f /var/log/nginx/html5-client.log | sed -u 's/\\x22/"/g' | sed -u 's/\\x5C//g'
```
