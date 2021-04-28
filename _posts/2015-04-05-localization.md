---
layout: page
title: "Localization"
category: dev
date: 2015-04-05 10:33:37
---

# Localizing BigBlueButton

Thanks to help from our community, BigBlueButton is localized in over twenty languages.

If you would like to help translate BigBlueButton into your language, or you see an error in current localization for your language that you would like to fix, here are the steps to help:

1. Create an account on [transifex.com](https://www.transifex.com/)

2. Choose the project

For helping to translate the HTML5 client, visit [BigBlueButton v2.3 HTML5 client](https://www.transifex.com/bigbluebutton/bigbluebutton-v23-html5-client/).

You'll see a list of languages ready for translation.

3. Click the name of the language you wish to translate  
   
   If you don't find your language, please request to have it added using the Transifex menu.

4. Click 'Join team' to join the localization team for your language
   
   The 'Join team' button is in the upper right-hand corner.
   
   ![join](/images/join.png)
   
   At this point, Transifex will send an e-mail to the coordinator for BigBlueButton localization requesting approval. You should receive approval very quickly.

5. Once approved, click the 'en.json' link
   
   ![bbbResources.properties](/images/image1.png)
   
   You'll see a dialog box where you can begin translation.

6. Click the 'Translate Now' button
   
   ![approved](/images/approved.png)
   
   At this point, you'll see the Transifex localization window for your language.
   
   ![translate](/images/translate.png)
   
   You can now click on a string in the left-hand panel and enter/review the translation for it (see  [intro to web editor](http://support.transifex.com/customer/portal/articles/972120-introduction-to-the-web-editor)).

**Translation tips:**

* You don't need to translate the numbers
* Some strings have variables in them such as `{0}` and `{1}` -- these will be substituted by BigBlueButton with parameters.
* You'll see duplicate strings as many controls have two localizations: one for sighted users, and one for blind users using a screen reader.  Please translate both.

### Getting more help

Finally, if you have any questions or need help, please post to [bigbluebutton-dev](http://groups.google.com/group/bigbluebutton-dev/topics?gvc=2).

Thanks again for your help in localizing BigBlueButton into other languages!



# Technical Background

We use Transifex for crowdsourcing for BigBlueButton Internationalization(i18n). The following steps are not a part of the typical installation and are only required for bringing the language strings in github up to date. There are two ways to pull the translation files; using the transifex.sh script or the transifex client.

## Using transifex.sh

The transifex.sh script aims to make retrieving translation files on the Transifex servers as simple as possible. In order to use the script, you must provide your Transifex credentials which have the appropriate authorization. The script can be used in the following ways.

```
$ ./transifex.sh all
```

Using the all argument will tell the script to download all available translation files.

```
$ ./transifex.sh fr de pt-BR
```

If you only need a specific set of translations, the script can be run with the required locales as argument.

## Setup & Configure Transifex Client

This is an alternative method to using the transifex.sh and is essentially the manual process for retrieving translation files from the Transifex servers.

### 1. Install Transifex Client

To installation the Transifex client we use pip, a package management system designed to manage and install Python packages.

```
$ sudo apt-get install python-pip
```

Next we use Pip to install the Transifex client.

```
$ sudo pip install transifex-client
```

The following command is used to upgrade the client to the most current version.

```
$ pip install --upgrade transifex-client
```

### 2. Transifex Project Initialization

The `tx init` command is used to initialize a project. Run from the root directory of the application.

```
$ tx init
Creating .tx folder. . .
Transifex instance [https://www.transifex.com]:
```

Press Enter (will be prompted for your Transifex username and password)

```
Creating skeleton...
Creating config file...
​Done.
```

This will create a Transifex project file in the current directory containing the project’s configuration file.

### 3. Transifex Client configuration

#### .tx/config

The Transifex client uses a per project configuration file. This is located in .tx/config of your project's root directory and is generated on running the `tx init` command. It should be updated with the following configuration:

```
[main]
host = https://www.transifex.com

[bigbluebutton-html5.enjson]
file_filter = private/locales/<lang>.json
source_file = private/locales/en_US.json
source_lang = en_US
type = KEYVALUEJSON
```

### 4. Set a Project Remote

`tx set` allows you to configure and edit Transifex project files on your local computer.

The following command is used to initialize a local project for the remote project specified by the URL.

`$ tx set --auto-remote https://www.transifex.com/projects/p/bigbluebutton-html5/resources/enjson/`

Next we can pull language files located on the Transifex server.

### 5. Pull: Download Transifex Translations

To pull all translation files from the Transifex server, the following command is used.

`$ tx pull -a bigbluebutton-html5.enjson`

In the event that there are a lot of translations, instead of pulling all, we can specify which translations we want to acquire.

`$ tx pull -r bigbluebutton-html5.enjson -l pt_BR`

Alternatively, simply download a ZIP archive of all languages in the project from the Transifex project page and unarchive it in the `public/locales/` directory.
