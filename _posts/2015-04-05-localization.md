---
layout: page
title: "Localization"
category: dev
date: 2015-04-05 10:33:37
---

# Localizing BigBlueButton

** Note: ** This document refers to the legacy Flash client.  For localization of the HTML5 cient, see [Localization the HTML5 client with Transifex](/2.2/dev.html#localization-with-transifex).

Thanks to help from our community, BigBlueButton is localized in over twenty languages.

If you would like to help translate BigBlueButton into your language, or you see an error in current localization for your language that you would like to fix, here are the steps to help:

1. Create an account on [transifex.com](https://www.transifex.com/)

2. Choose the project

These docs are currently being updated for the HTML5 client.

For helping to translate the HTML5 client, visit [BigBlueButton v2.2 HTML5 client](https://www.transifex.com/bigbluebutton/bigbluebutton-v22-html5-client/).  

For the legacy Flash client, visit the [BigBlueButton project](https://www.transifex.com/bigbluebutton/bigbluebutton-dev/). 

You'll see a list of languages ready for translation.

3. Click the name of the language you wish to translate  
   
   If you don't find your language, please post on the [BigBlueButton Mailing List](http://groups.google.com/group/bigbluebutton-dev/topics?gvc=2) requesting it be added.

4. Click 'Join team' to join the localization team for your language
   
   The 'Join team' button is in the upper right-hand corner.
   
   ![join](/images/join.png)
   
   At this point, Transifex will send an e-mail to the coordinator for BigBlueButton localization requesting approval. You should receive approval very quickly.

5. Once approved, click the 'bbbResource.properties' link
   
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

## Technical Background

Note: This section applies only to the legacy Flash client.

BigBlueButton localization follows the i18n standard. BigBlueButton Client will detect the locale of the language of the browser running it and attempt to load that language file.

Language files are compiled into swf files and loaded dynamically based on the browser locale. This reduces the size of the client. Language codes follow the convention of a two letter lowercase language name, followed by an underscore, followed by two upper-case letters signifying the country code. So, for example, the default English for the United States would be: **en\_US**

![I18N](/images/I18N.png)

## Compiling your own language files into your client

If you created a custom language file but do not wish to contribute back to the project, here are the instructions on how to compile the language files yourself.

1. Put the template file into a new folder. The folder name should follow the language code convention stated above for the language/country the language file is written for.  Put the folder under `bigbluebutton-client/locale`.
2. The file will be loaded whenever the user's browser is set to that language/country code. Optionally, you could overwrite the English language files if you think that most of your users are running english language browsers, but would still like them to load a specific language.

Rebuild the client. Go to the client source directory - on the VM usually `/home/firstuser/dev/bigbluebutton/bigbluebutton-client/`, and run the command

```bash
$ ant locales
```

To have the client load your locale, you need to add it to the locales.xml located in resources/prod folder.

[locales.xml](http://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/resources/prod/locales.xml)

Refer to the [FAQ](/support/faq.html#my-client-fails-at-startup-with-rsl-error;-error-2035:url-not-found) if you have problems with Ant and Flex

## Testing your localization

There is a Firefox plug-in, "Quick Locale Switcher", that can be used for testing the localizations. The plug-in is available [here](https://addons.mozilla.org/en-US/firefox/addon/1333). When this plug-in is installed, you will have a menu at the bottom right hand corner that allows you to change the locale in the browser.

## Overwriting the English Translation with your Language

If you think most of your users are running browsers set for English but would still like BigBlueButton to load with a different language, you can delete the en\_US.swf file from the directory where you deployed the bbb-client. Then rename your localization to en\_US.swf. So for example if you wanted the Spanish language to be the default, just rename the file es\_ES.swf to en\_US.swf.

Or you can edit [bbb_localization.js](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/resources/prod/lib/bbb_localization.js) to force the default to locale to what you want.
