---
layout: page
title: "BigBlueTutor"
category: labs
date: 2017-12-21 14:58:25
---

# Overview:
BigBlueTutor is a mobile social platform for BigBlueButton that aims to connect students with tutors and various subject experts. BigBlueTutor aims to help students:
Find a Tutor
Ask for help when needed
Engage with different professionals through BigBlueButton

BigBlueTutor is a software designed for everyone to learn new things. As such we believe everyone is a student and allow tutors to engage with different tutors to learn new things.

The BigBlueTutor server uses NodeJs and Deepstream as its backend and supports a variety of mobile and web clients for communication.
The steps below cover usage,  features, installation and future development

# User Experience:
This shows the steps to use BigBlueTutor from a user’s perspective in the Ionic Client

![](https://lh3.googleusercontent.com/uariST4fUUMLolOd_7sVdNHNZ26b27HEKA3bj5exePgLmqd0Piue6xgyNCVwl7kT1CQ=h900-rw)

**Sign in** with your Google account. BigBlueTutor will use your Google account to create your profile.

![](https://lh3.googleusercontent.com/-yylb5-Ler-5aFVnKm8h-_yT0AE6riQU0tu2Z4Na6Z7HUu4KAPIzYVUc5ERHB6Uekg=h900-rw)

**Search** for tutors or subjects simply by typing in the searchbar. You can find tutors by name or subjects taught and pick the tutor that is most suitable to you!

**Browse** categories for category-specific tutors. Looking for only Math Tutors? BigBlueTutor groups the tutors into specific categories for you to browse through.

![](https://lh3.googleusercontent.com/efl4qQ-SQzjctBXG8pv0lpLrWy_7Mwr-MO1RlY-iavJS1k8Wlb_V-hORrYo_QxFqOzAs=h900-rw)

**Engage** with other tutors directly through BigBlueButton. BigBlueTutor creates a BigBlueButton meeting for you and the tutor. You can enjoy all the benefits of the BigBlueButton HTML client to enhance your learning.

# Features:
* Google Authentication
* Subject Categories
* User Search
* User Messaging
* Push Notifications

# Current Clients:

### Ionic:
Supports: **Android**
Status: Released ([app](https://play.google.com/store/apps/details?id=com.blindsidenetworks.bigbluetutor&hl=en))

### React-Native:
Supports: **Android**, **iOS**
Status: In Development

# Technical Overview:
BigBlueTutor uses Deepstream.io and NodeJS for it's backend server. It uses RethinkDB to integrate with Deepstream.
Deepstream allows us to focus our development efforts towards BigBlueTutor specific features.
BigBueTutor have two mobile client implementations, Ionic and React-Native. The Ionic client was made to demonstrate a quick working version of BigBlueTutor while the React-Native client is used for long-term development. 

# Before You Install:
BigBlueTutor requires a pre-existing BigBlueButton server with the HTML5 client. You will need a BigBlueButton 2.0 server with the HTML5 client.
The BigBlueButton server is separate from BigBlueTutor and does not have to be hosted together.

See [BigBlueButton HTML5 Overview](/html/html5-overview.html) for the HTML5 client

**Note:** Keep the URL and shared secret of the server on hand during install as you will need it for the environment file.


# Installation
## Server:

### 1. Install NodeJS
BigBlueTutor Server uses **Node** to communicate with the client. To install NodeJS, do the following

~~~
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install build-essential nodejs
~~~

### 2. Install Docker
**TODO**

## Database:

### 1. install RethinkDB
BigBlueTutor integrates **Deepstream** with **RethinkDB** to store its data. To install RethinkDB, do the following

~~~
source /etc/lsb-release && echo "deb http://download.rethinkdb.com/apt $DISTRIB_CODENAME main" | sudo tee /etc/apt/sources.list.d/rethinkdb.list
sudo apt-get install wget
wget -qO- https://download.rethinkdb.com/apt/pubkey.gpg | sudo apt-key add -
sudo apt-get update
sudo apt-get install rethinkdb
~~~

### 2. setup RethinkDB

Create a new config file using the sample in /etc/rethinkdb:
~~~
sudo cp /etc/rethinkdb/default.conf.sample /etc/rethinkdb/instances.d/instance1.conf
~~~
Start RethinkDB with:
~~~
sudo /etc/init.d/rethinkdb restart.
~~~
This will allow RethinkDB to start automatically when you start your system

### 3. install RethinkDB Python driver (Recommended)
RethinkDB uses **Python** to run scripts and access the database. Installing this will allow you to access the RethinkDB database.
~~~
sudo apt-get install python python3 python3-pip
pip3 install rethinkdb python-dotenv
~~~


## Android Client:

### 1. Install Java and Gradle
Android uses **Java** and **Gradle** to build and run apps
~~~
sudo add-apt-repository ppa:webupd8team/java
sudo apt-get update
sudo apt-get install oracle-java8-installer
sudo apt-get install oracle-java8-set-default
sudo apt-get install gradle
~~~

### 2. Install Android Studio and SDK
1. Install **Android Studio** from ([https://developer.android.com/studio/index.html])
2. Extract the .zip file to your home directory. When you are done, you should have a directory named “android-studio” in your home directory.
3. Navigate to ~/android-studio/bin and edit the permissions of studio.sh to allow execution, then run ./studio.sh
4. From the Welcome screen, go to Configure->SDK Manager. Under SDK Platforms, install Android 6.0 (Marshmallow) (API Level 23) or later.

## Installing the BigBlueTutor client:

### Ionic Client:

#### 1. install Ionic
~~~
npm install -g ionic cordova
~~~
#### 2. set up the client
You will need to install all node dependencies and Ionic/Cordova plugins. Do the following:
~~~
npm install
ionic cordova prepare
~~~
#### 3. Running
You can now run the application
~~~
ionic cordova run android
~~~

### React-Native

#### 1. install React-Native
~~~
npm install -g react-native-cli
~~~
#### 2. set up the client
You will need to install node dependencies and link them with react-native
~~~
npm install
react-native link
~~~

#### 3. Running
You can now run the application
~~~
react-native run-android
~~~



## Google OAuth
BigBlueTutor uses Google Sign-in to authenticate users. The following libraries are used for OAuth

[Ionic](https://github.com/EddyVerbruggen/cordova-plugin-googleplus)

[React-Native](https://github.com/devfd/react-native-google-signin)

[Server](https://github.com/google/google-auth-library-nodejs)

### General Idea
1. If you have not created a google console project for BigBlueTutor Follow these instructions and create a google console project.
[google console project](https://developers.google.com/identity/sign-in/web/devconsole-project)
2. Obtain a configuration file
3. Go through the form and enable Google Sign-In
4. download the configuration file and use the keys in your keystore for client and the authentication keys for server

## Push Notifications
BigBlueTutor uses Google Cloud Messaging to send Push Notifications. The following libraries are used for Push Notifications

[Ionic](https://github.com/phonegap/phonegap-plugin-push)

[React-Native](https://github.com/zo0r/react-native-push-notification)

[Server for Ionic](https://github.com/appfeel/node-pushnotifications)

[Server React-Native GCM](https://github.com/ToothlessGear/node-gcm)

[Server React-Native APN](https://github.com/node-apn/node-apn)

### General Idea
1. If you have not created a google console project for BigBlueTutor Follow these instructions and create a google console project.
[google console project](https://developers.google.com/identity/sign-in/web/devconsole-project)
2. Obtain a configuration file
3. Go through the form and enable Push Notifications
4. download the configuration file and use the keys in your keystore for client and the keys for server

## Future Development:

The BigBlueTutor server uses Deepstream for it’s authentication and connection. It supports all of the integrations supported by Deepstream. Currently we have built an Ionic mobile client and a partial React-Native client.

Since BigBlueTutor may have many new use cases, we encourage that you add extensions and extra features to BigBlueTutor.

# More Information/ Troubleshooting

[Linking keystore to application](https://stackoverflow.com/questions/16965058/where-is-debug-keystore-in-android-studio)

[Configuring google sign-in](https://github.com/devfd/react-native-google-signin/) (OAuth, React-Native)

[Using Environment Files](https://github.com/luggit/react-native-config) (React-Native)

[Ionic](https://ionicframework.com/docs/intro/installation/)

[React Native](https://facebook.github.io/react-native/docs/getting-started.html)
