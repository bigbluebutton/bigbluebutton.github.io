---
layout: page
title: "Green Light"
category: labs
date: 2016-12-08 16:29:25
---

## Overview

Green Light is a simple front-end for your BigBlueButton server.  At it's core, Green Light provides a minmialistic web-based interface to let users
  
   * Create a meeting
   * Invite others to the meeting

 In the meeting all users are moderators, which means anyone can make themselves presenter and share slides with others.  

Green Light is build on rails 5.  The steps below show how to install Green Light on an existing BigBlueButton 1.1 (or above) server using Docker.  Docker enables Green Light to within it's own container and not install any dependencies on BigBlueButton.  Nginx will proxy all requests to Green Light.

It provides you (the developer) a reference implementation of how to create a front-end for BigBlueButton.  All strings are localized, so it's easy to extend to other languages.

 Green Light supports an authenticated user via OAuth (Twitter or Facebook).  An authenticated user can create a meeting where only they are the moderator and other users are viewers.

  configure Green Light to authentical via OAuth or Twitter, then an authenticated user can also create recorded meetings and view the recordings when processed.



## Architecture

![Architecture Overview](/images/deskshare_tls.png)

You can also setup stunnel to terminate an RTMPS connection

## Client Changes

In the client `config.xml` file, locate the `DeskShareModule` module block
First change `useTLS` to be equal to `true`. Then make the `publishURI` parameter point to your stunnel server ip. We will go over how to install the stunnel and configure it later in this page. 

## Stunnel

Stunnel is an open-source multi-platform computer program, used to provide universal TLS/SSL tunneling service.

### Installing Stunnel

```
apt-get update
apt-get upgrade
```

Then install the actual server

```
apt-get install stunnel4 -y
```

### Configuring Stunnel Server

To enable automatic startup

```
nano /etc/default/stunnel4
```

And change ENABLED to 1

```
ENABLED=1
```


Navigate to the stunnel directory

```
cd /etc/stunnel/
```

Then create the config file

```
touch stunnel.conf
```

We then edit the file and make it look like this.
Don't worry about the cert for now, we will get to that later.

```
; Log level: info = 6, debug = 7
debug = 7
output = stunnel.log

[deskShare-01]
accept=STUNNEL_HOST:443
connect=BIGBLUEBUTTON_HOST:9123
cert = /etc/stunnel/stunnel.pem
```

The first 3 line will enable your logging.
`accept` should point the stunnel server it self and `connect` should point to your BigBlueButton server. Do not change the ports if you did not change them on your BigBlueButton server.

### Keys and Certs

If you have your own key and cert, then please use that and you will need to start stunnel then you will be ready, else jump to Starting Stunnel

Start by creating the private key for your stunnel.

```
openssl genrsa -out key.pem 2048
```

Then using that cert, we will create a pubic cert

```
openssl req -new -x509 -key key.pem -out cert.pem -days 1095
```

Then we need to combine the content of these 2 files into one that stunnel will use.

```
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem
```

You might have a permission issue, in that case just copy the files manually.

```
touch stunnel.pem
cat key.pem cert.pem
```

Then past the output in to the file stunnel.pem

### Starting Stunnel

To start the Stunnel

```
/etc/init.d/stunnel4 restart
```

### Adding the keystore to our machine

First we convert the cert.pem to a cert.crt

```
openssl x509 -outform der -in cert.pem -out bbb-deskshare.crt
```

And move the output vert to your personal machine.

Now we need to add this cert to the JAVA key store on every machine that wants to share deskshare over TLS.

For a windows machine. Navigate to you keytools

```
cd C:\Program Files (x86)\Java\jre1.8.0_45\bin
```
Please note that you might be using a different java version.

And add the cert to your cacerts

```
keytool -import -alias "DeskshareCert" -file CERT_LOCATION -keystore ..\lib\security\cacerts
```

Replace `CERT_LOCATION` with the location of the cert on your machine

