---
layout: page
title: "HTML5 Coding Practices"
category: html
date: 2016-05-26 14:39:42
---

When making a new component there is a certain structure to implement and existing components to utilize to make your life easier.

## Accessibility


To be added

## Buttons


There is a standard button component we use in the client. It is located inside of <b>/imports/ui/shared/Button.jsx</b>. It should be used for every button.

## Font Size


Inside of <b>/client/stylesheets</b> there is a stylesheet <b>fontSizing.css</b>.

It will contain style classes such as extraSmallFont, smallFont, mediumFont, etc. Every piece of html with text to display to the client should be assigned one of these classes. This will allow text to scale responsively and still maintain relative size. You can set the class of an element to one of these classes, and have everything inside the container element inherit the font size rather than assign it to each individual child to save some work.

## Localization


As some of you may know the client is capable of localization now, here is how you do it:

where you want to have the localized text you just


`<FormattedMessage `

`id="app.userlist.participantsTitle" `

`description="Title of participants list" `

`defaultMessage="Participants" `

`/>`
 

and in your <b>imports/locales/\<language\>.json</b> you need


`{ `

`... `

`"app.userlist.participantsTitle": "Participants "`

`... `

`} `



## Server Calls


To make a call to the server from the client, you should refer to the <b>callServer</b> function in <b>/imports/ui/services/api/index.js</b>.

Always use this in favor of <b>Meteor.call</b>. The <b>callServer</b> function should operate the same way in that you pass the name of the method to call as a string, and then the arguments just like normal.

[Meteor.call()](http://docs.meteor.com/#/full/meteor_call)
