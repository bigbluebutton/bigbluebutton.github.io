---
layout: page
title: "Configure TURN"
category: 2.2
date: 2019-02-14 22:13:42
---

This document covers how to setup a TURN server for BigBlueButton to allow users behind restrictive firewalls to connect.

# Setup a TURN server

BigBlueButton normally requires a wide range of UDP ports to be available for WebRTC communication. In some network restricted sites or development environments, such as those behind NAT or a firewall that restricts outgoing UDP connections, users may be unable to make outgoing UDP connections to your BigBlueButton server.

The [TURN protocol](https://en.wikipedia.org/wiki/Traversal_Using_Relays_around_NAT) is designed to allow UDP-based communication flows like WebRTC to bypass NAT or firewalls by having the client connect to the TURN server, and then have the TURN server connect to the destination on their behalf.

In addition, the TURN server implements the STUN protocol as well, used to allow direct UDP connections through certain types of firewalls which otherwise might not work.

Using a TURN server under your control improves the success of connections to BigBlueButton and also improves user privacy, since they will no longer be sending IP address information to a public STUN server.

## Required Hardware

The TURN protocol is not CPU or memory intensive. Additionally, since it's only used during connection setup (for STUN) and as a fallback for users who would otherwise be unable to connect, the bandwidth requirements aren't particularly high. For a moderate number of BigBlueButton servers, a single small VPS is usually sufficient.

Having multiple IP addresses may improve the results when using STUN with certain types of firewalls, but is not usually necessary.

Having the server behind NAT (for example, on Amazon EC2) is OK, but all incoming UDP and TCP connections on any port must be forwarded and not firewalled.

## Required Software

We recommend using a minimal server installation of Ubuntu 18.04.  The [coturn](https://github.com/coturn/coturn) software requires port 443 for its exclusive use in our recommended configuration, which means the server cannot have any dashboard software or other web applications running.

coturn is already available in the Ubuntu packaging repositories for version 18.04 and later, and it can be installed with apt-get:

```bash
$ sudo apt-get update
$ sudo apt-get install coturn
```

Note: coturn will not automatically start until configuration is applied (see below).

## Required DNS Entry

You need to setup a fully qualified domain name that resolves to the external IP address of your turn server.  You'll used this domain name to generate a TLS certificate using Let's Encrypt (next section).

## Required Ports

On the coturn server, you need to have the following ports (in addition port 22) available for BigBlueButton clients to connect (port 3478 and 443) and for coturn to connect to your BigBlueButton server (49152 - 65535).

| Ports       | Protocol | Description           |
| ----------- | -------- | --------------------- |
| 3478        | TCP/UDP  | coturn listening port |
| 443         | TCP/UDP  | TLS listening port    |
| 49152-65535 | UDP      | relay ports range     |

## Generating TLS certificates

You can use `certbot` from [Let's Encrypt](https://letsencrypt.org/) to easily generate free TLS certificates.   To setup `certbot` enter the following commands on your TURN server (not your BigBlueButton server).

```bash
$ sudo add-apt-repository ppa:certbot/certbot
$ sudo apt-get update
$ sudo apt-get install certbot
```

You can then run a `certbot` command like the following to generate the certificate, replacing `turn.example.com` with the domain name of your TURN server:

```bash
$ sudo certbot certonly --standalone --preferred-challenges http \
    --deploy-hook "systemctl restart coturn" \
    -d turn.example.com
```

Current versions of the certbot command set up automatic renewal by default.  Note that when certbot renews the certificate, it will restart coturn so coturn will start to use the updated certificate files. This will interrupt any ongoing TURN connections. You may wish to change the schedule of certbot renewals or disable automatic renewal if this is a concern.

## Configure coturn

`coturn` configuration is stored in the file `/etc/turnserver.conf`. There are a lot of options available, all documented in comments in that file.  We include a sample configuration below with comments indicating the recommended settings, with some notes in locations where customization is required.

You can repace the contents `/etc/turnserver.conf` with this file and make two changes:

* Replace `turn.example.com` with the hostname of your TURN server, and  
* Replace `<random value>` to a random value for a shared secret (instructions for generating a new secret are in a comment in the file).

```ini
# Example coturn configuration for BigBlueButton

# These are the two network ports used by the TURN server which the client
# may connect to. We enable the standard unencrypted port 3478 for STUN,
# as well as port 443 for TURN over TLS, which can bypass firewalls.
listening-port=3478
tls-listening-port=443

# If the server has multiple IP addresses, you may wish to limit which
# addresses coturn is using. Do that by setting this option (it can be
# specified multiple times). The default is to listen on all addresses.
# You do not normally need to set this option.
#listening-ip=172.17.19.101

# If the server is behind NAT, you need to specify the external IP address.
# If there is only one external address, specify it like this:
#external-ip=172.17.19.120
# If you have multiple external addresses, you have to specify which
# internal address each corresponds to, like this. The first address is the
# external ip, and the second address is the corresponding internal IP.
#external-ip=172.17.19.131/10.0.0.11
#external-ip=172.17.18.132/10.0.0.12

# Fingerprints in TURN messages are required for WebRTC
fingerprint

# The long-term credential mechanism - see note on Kurento below
# lt-cred-mech

# Configure coturn to use the "TURN REST API" method for validating time-
# limited credentials. BigBlueButton will generate credentials in this
# format. Note that the static-auth-secret value specified here must match
# the configuration in BigBlueButton's turn-stun-servers.xml
# You can generate a new random value by running the command:
#   openssl rand -hex 16
use-auth-secret
static-auth-secret=<random value>

# If the realm value is unspecified, it defaults to the TURN server hostname.
# You probably want to configure it to a domain name that you control to
# improve log output. There is no functional impact.
realm=example.com

# Configure TLS support.
# Adjust these paths to match the locations of your certificate files
cert=/etc/letsencrypt/live/turn.example.com/fullchain.pem
pkey=/etc/letsencrypt/live/turn.example.com/privkey.pem
# Limit the allowed ciphers to improve security
# Based on https://hynek.me/articles/hardening-your-web-servers-ssl-ciphers/
cipher-list="ECDH+AESGCM:ECDH+CHACHA20:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:RSA+AESGCM:RSA+AES:!aNULL:!MD5:!DSS"

# Enable longer DH TLS key to improve security
dh2066

# All WebRTC-compatible web browsers support TLS 1.2 or later, so disable
# older protocols
no-tlsv1
no-tlsv1_1

# Log to a single filename (rather than new log files each startup). You'll
# want to install a logrotate configuration (see below)
log-file=/var/log/coturn.log

# To enable single filename logs you need to enable the simple-log flag
simple-log
```

## Configure Log Rotation

To rotate the logs for `coturn`, install the following configuration file to `/etc/logrotate.d/coturn`

```
/var/log/coturn.log
{
    rotate 30
    daily
    missingok
    notifempty
    delaycompress
    compress
    postrotate
    systemctl kill -sHUP coturn.service
    endscript
}
```

## Enabling the coturn service

The ubuntu package for `coturn` requires that you edit a file to enable startup. Edit the file `/etc/default/coturn` and ensure the following line is uncommented:

```ini
TURNSERVER_ENABLED=1
```

You can then start the coturn service by running

```bash
$ systemctl start coturn
```

## Configure BigBlueButton to use the coturn server

You must configure bbb-web so that it will provide the list of turn servers to the web browser. Edit the file `/usr/share/bbb-web/WEB-INF/classes/spring/turn-stun-servers.xml` using the contents below and make edits:

* replace both instances of `turn.example.com` with the hostname of the TURN server, and 
* replace `<random value>` with the secret you configured in `turnserver.conf`.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans-2.5.xsd">

    <bean id="stun0" class="org.bigbluebutton.web.services.turn.StunServer">
        <constructor-arg index="0" value="stun:turn.example.com"/>
    </bean>


    <bean id="turn0" class="org.bigbluebutton.web.services.turn.TurnServer">
        <constructor-arg index="0" value="<random value>"/>
        <constructor-arg index="1" value="turns:turn.example.com:443?transport=tcp"/>
        <constructor-arg index="2" value="86400"/>
    </bean>
    
    <bean id="turn1" class="org.bigbluebutton.web.services.turn.TurnServer">
        <constructor-arg index="0" value="<random value>"/>
        <constructor-arg index="1" value="turn:turn.example.com:443?transport=tcp"/>
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
                <ref bean="turn1"/>
            </set>
        </property>
    </bean>
</beans>
```

Restart your BigBlueButton server to apply the changes. 

Going forward, when users connect behind a restrictive firewall that prevents outgoing UDP connections, the TURN server will enable BigBlueButton to connect to FreeSWITCH and Kurento via the TURN server through port 443 on their firewall.

## Kurento edge case may require a second Turn server 

A complication may affect a small minority of installations where the server is behind an unusual NAT firewall.  The difficulty arises because there are two different Turn authentication protocols - and the solution to some Kurento NAT problems relies on a setting in coturn which is incompatible with the requirements already described above.  

All BBB servers should have a Stun / Turn server configured as shown in the sections above - ```/usr/share/bbb-web/WEB-INF/classes/spring/turn-stun-servers.xml```  This is required to help ensure that the HTML5 web application running in users browsers can negotiate which ports to use, using the webrtc / ICE protocols.   

Kurento may, under exceptional circumstances, require a different configuration. Kurento needs to know its external IP address.  In the configuration file ```/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini``` you can specify the external IP address for Kurento. 

This is the ideal situation - and avoids a great deal of complexity. 

If you do **not **know the external IP address, the next best solution is to provide a Stun server - which can be the Coturn server you have set up, above. 

Under some circumstances, Kurento might also require a Turn server.  The configuration for this is at the bottom of ```/etc/kurento/modules/kurento/WebRtcEndpoint.conf.ini```. 

Importantly, most people do **not** need to configure Turn in this file.  

If you do, however, there is a problem. 

At present, if Kurento needs Turn, it must uses the "lt-cred-mech" authentication mechanism, which consists of a generated username and password formatted in a very particular way.   This requires the lt-cred-mech setting in ```/etc/turnserver.conf```

The problem is that this is a *different* authentication mechanism to that required by Turn for the html5 client (which uses the 'use-auth-secret' mechanism - as shown in the example above)

It appears that a single coturn server cannot provide connections using both authentication mechanisms at the same time.  If you are unable to provide Kurento with an external IP (and Stun does not work) you may need a second Turn server - configured to use ```lt-cred-mech```