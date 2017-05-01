---
layout: page
title: "HTML5 Coding Practices"
category: html
date: 2016-05-26 14:39:42
---

When making a new component there is a certain structure to implement and existing components to utilize to make your life easier.

## Accessibility

The HTML5 client is currently keyboard and screen reader accessible, in particular the open source NVDA screen reader.  

The use of the React-Intl allows the HTML5 client to have fully localized messages which are uploaded to Transifex for translating. As a result of this we have added the ability within the HTML5 client to switch the language of the application.

When using NVDA with the HTML5 client we can utilize native shortcut keys to navigate through the application.

NVDA navigation keys:

~~~
Stop Reading                    -  Ctrl
Activate Link                   -  Enter
Activate Button                 -  Enter or Space
Go to next Heading              -  H
Go to next landmark/region      -  D
Go to next list                 -  L
Go to next list item            -  I
~~~

A more comprehensive list of NVDA short cuts can be found at :
http://webaim.org/resources/shortcuts/nvda

Due to browser limitations the dialog box to join Mic audio is currently not keyboard accessible.
The colour picker in the closed caption settings is also currently not keyboard accessible.
There are a few other minor controls yet to be made accessible.

## Buttons


There is a standard button component we use in the client. It is located inside of <b>/imports/ui/shared/Button.jsx</b>. It should be used for every button.

## Font Size


Inside of <b>/client/stylesheets</b> there is a stylesheet <b>fontSizing.css</b>.

It will contain style classes such as extraSmallFont, smallFont, mediumFont, etc. Every piece of html with text to display to the client should be assigned one of these classes. This will allow text to scale responsively and still maintain relative size. You can set the class of an element to one of these classes, and have everything inside the container element inherit the font size rather than assign it to each individual child to save some work.

## Localization

The HTML5 client supports localizations. The main language file is `en.json`. When there is a new field to localize, we update `en.json`, and then the new field string becomes available for crowdsourced translation on Transifex.com

When declaring formatted messages we use  defineMessages and  injectIntl in place of FormattedMessage.

~~~
Import { injectIntl } from ‘react-intl’;          //pass’s messages as prop to the component
import { defineMessages } from 'react-intl';      //import so we can group together all messages inside a component.

const intlMessages = defineMessages({             //all messages can be defined in intlMessages
  title: {
	id: 'app.about.title', 	                        //id corresponds to the id in the locale file
	description: 'About title label in Settings menu', //gives developers additional context about the element/item
  },
});
~~~

We omit the default message prop because it is the same as the string located in the locale file. By doing this we keep context of what the id’s mean while eliminating duplication.  Once the messages are defined we then add the following to use the `injectIntl`:

~~~
export default injectIntl(ComponentName);
~~~

From this point we can use the messages directly as they are passed down as props.

~~~
const { intl } = this.props;     //defined messages get passed as props

<Button
    role="button"
    label={intl.formatMessage(intlMessages.title)}   	  //gets rendered to the screen
    aria-label={intl.formatMessage(intlMessages.title)}    //voiced by screen reader
/>
~~~

If the browser is requesting a locale file that does not contain all the translations, all the available strings will be merged with the locale file set as the default. In this case all messages will be displayed but may have a mixture of languages.

If message id’s are missing from the locale file set as the default, and the browser requests the default or another locale containing a portion of the translated strings; there is potential for the missing id’s to not render a message and in this care default to the id of the message. To ensure this does not occur we make sure that the locale specified as the default always contains 100% of the used messages.

## Server Calls


To make a call to the server from the client, you should refer to the <b>callServer</b> function in <b>/imports/ui/services/api/index.js</b>.

Always use this in favor of <b>Meteor.call</b>. The <b>callServer</b> function should operate the same way in that you pass the name of the method to call as a string, and then the arguments just like normal.

[Meteor.call()](http://docs.meteor.com/#/full/meteor_call)
