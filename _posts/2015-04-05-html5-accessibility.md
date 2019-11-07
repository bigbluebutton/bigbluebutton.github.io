---
layout: page
title: "Accessibility"
category: 2.2
redirect_from: "/dev/accessibility.html"
date: 2015-04-05 11:41:36
order: 1
---

The BigBlueButton HTML5 client is WCAG 2.0 AA accessible (with exceptions) and Section 508 compliant.  See our [official accessibility statement](https://bigbluebutton.org/accessibility/).

# Overview 

Based on the scope of the project, focus has been placed on disabilities related to visual, auditory and motor impairments. 
We have designed the BigBlueButton HTML5 client to be accessible to as many users as possible regardless of any underlying disability.

The client follow the WCAG 2.0 color contrast guidelines for all visual elements, in addition to an aesthetically pleasing inclusive design. 
Keyboard and screen reader support has been implemented, in particular for the open source NVDA screen reader. JAWS, the markets leading paid screen reader software is also compatible with the client.

***Note:
There are a few minor controls within the client that are not fully accessible, The colour picker in the closed caption settings for example.***

# Accessibility

When dealing with web accessibility there are a few key factors we must keep in mind while developing

  1. Tab Order
  2. Color Contrast
  3. Focus
  4. Semantics
  5. Testing

## Tab Order

The goal when implementing the tab order is ensuring the elements in the  tab sequence are logical and simple.

When a user presses the tab key focus should move to the next interactable element. If the user continues to press the tab key, focus should move in a logical order through all the interactable elements on the page. The tab focus should be visually identified, currently the HTML5 client adds a thin border to the field, when tab is pressed focus is seen to visibly move.

***Note: A number of users including the following.***

  * ***Those with visual impairments, who rely on screen readers or screen magnifiers.***
  * ***Those with limited dexterity, who depend on the use of the keyboard to using a mouse.***
  * ***Those who can only utilize a single switch to control a computer.***

***will all navigate through a page by using the tab button.***


The order of elements in the DOM determine their place in the tab order, for elements that should receive focus. Elements that don’t natively receive focus can be inserted into the tab order by adding a tabindex=”0” property.

***Caution:***
***When using the tabindex property, positive values should generally be avoided because it places elements outside of the natural tab order, this can present issues for screen reader users who rely on navigating the DOM through a linear manner.***

The following extension gives a visual representation of the tab order of a current web document.

### ChromeLens
offered by ngzhian

![Contrast Ratio Calculator](/images/accessibility_chromelense.jpg)
https://chrome.google.com/webstore/detail/chromelens/idikgljglpfilbhaboonnpnnincjhjkd?hl=en


## Focus


## Color Contrast

When dealing with color contrast we are talking about finding colors for a scheme that not only implement maximum contrast, but gives the appropriate contrast between the content and its background for those who experience low visual impairments, color deficiencies or the loss of contrast typically accompanied by aging.

The HTML5 client ensures that all visual designs meet the minimum color-contrast ratio for both normal as well as large text on a background, described by the WCAG 2.0 AA standards.  “Contrast (Minimum): Understanding Success Criterion 1.4.3.” 

To make sure that we have met these guidelines, there are numerous tools available online which allow the comparison of foreground and background colors using hex values, to see if they fall within the appropriate contrast ratio.

![Contrast Ratio Calculator](/images/accessibility_colorchecker.jpg)
http://webaim.org/resources/contrastchecker/


### Currently implemented colors:

![Currently implemented element colors](/images/accessibility_colors1.jpg)
![Currently implemented typography colors](/images/accessibility_colors2.jpg)
 
* Blue - primary color - action buttons
* Red - closing audio, indicators and error alerts
* Green - audio indicator, success alert, check marks
* Orange - warning alerts
* Dark Blue - Headings
* Grey - base typography color


***Note:***
***The ChromeLense extension also provides the ability to view your browser using different personas of users who may view web content with various different visual impairments. This is particularly useful when deciding on appropriate color schemes to best suit a wider range of users.***


## Semantics

Users with visual disabilities can miss out on visual affordances. We need to make sure the information we are trying to express, is expressed in a way that flexible enough so assistive technology can pick up on it; creating an alternative interface for our users. we refer to this as expressing the semantics of an element.

The HTML5 client uses the WAI-ARIA (Web Accessibility Initiative – Accessible Rich Internet Applications) to provide access to screen readers. The following list of commonly used aria attributes:

  * aria-role
  * aria-label
  * aria-labelledby
  * aria-describedby
  * aria-hidden
  * aria-live
  * aria-expanded
  * aria-haspopup

#### Links
  
  HTML5 ARIA spec - http://www.w3.org/TR/aria-in-html/

  ARIA spec - http://www.w3.org/WAI/PF/aria/
  
  Roles - http://www.w3.org/TR/wai-aria/roles
  
  States and Properties - http://www.w3.org/TR/wai-aria/states_and_properties
  
  Design Patterns - http://www.w3.org/TR/wai-aria-practices/#aria_ex


### Testing

Testing for accessibility can be a somewhat painful process, if you try to manually find and fix all the issues. While it is good practice to go through a checklist and ensure all elements in the HTML5 client meet their accessibility requirements, this process can be very slow and time consuming. For this reason it is suggested to use an automated accessibility auditor first.

#### aXe
offered by Deque Systems

![aXe](/images/accessibility_axe.jpg)
https://chrome.google.com/webstore/detail/axe/lhdoppojpmngadmnindnejefpokejbdd

#### Accessibility Developer Tools
offered by Google Accessibility

![Accessibility Developer Tools](/images/accessibility_audit.jpg)
https://chrome.google.com/webstore/detail/accessibility-developer-t/fpkknkljclfencbdbgkenhalefipecmb

Both of these extensions provide the ability to scan the DOM and report on any accessibility issues based on levels which can be set, weather AA or AAA standards. For the purposes of the HTML5 client we follow the AA guidelines. Any reported errors also come with a listing of potential fixes.

***Note:***
***Once these extensions are installed to the browser they must be run from inside the console.***


## Training

We recommenbd checking out this [free online accessibility course](http://www.udacity.com/course/web-accessibility--ud891) which can provide a very good understanding of the basics of dealing with web accessibility for both developers and designers. 

In the event you do not need to take the course but would still like access to the information as reference, the course is also found in [full document form](https://developers.google.com/web/fundamentals/accessibility) . It is a live document which is updated by the developers over at Google.
