---
layout: page
title: "Accessibility"
category: html
date: 2015-04-05 11:41:36
order: 1
---


# Overview 

The province of Ontario is one of the first in establishing a goal and time-frame for accessibility. The BigBlueButton project aims to comply with the proposed accessibility guidelines, enabling individuals 
with disabilities the ability to use the web application. To be a bit more specific, we ensure that users are able to perceive, understand, navigate, interact and contribute using the HTML5 client.

Based on the scope of the project, focus has been placed on disabilities related to visual, auditory and motor impairments. 
We have designed the BigBlueButton HTML5 client to be accessible to as many users as possible regardless of any underlying disability.

The client follow the WCAG 2.0 color contrast guidelines for all visual elements, in addition to an aesthetically pleasing inclusive design. 
Keyboard and screen reader support has been implemented, in particular for the open source NVDA screen reader. JAWS, the markets leading paid screen reader software is also compatible with the client.

***Note:
There are a few minor controls within the client that are not fully accessible, The colour picker in the closed caption settings for example.***

#### Keyboard Example : Send a Public message when client first loads

* Close audio modal
  1. Tab
  2. Enter
* Open users pane
  1. Tab
  2. Enter
* Focus messages list
  1. Shift + Tab (x2)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Send message
  1. Type message
  2. Enter

## NVDA 

NVDA navigation keys:
Stop Reading                    -  Ctrl
Activate Link                   -  Enter
Activate Button                 -  Enter or Space
Go to next Heading              -  H
Go to next landmark/region      -  D
Go to next list                 -  L
Go to next list item            -  I

A more comprehensive list of NVDA short cuts can be found at : http://webaim.org/resources/shortcuts/nvda
Due to browser limitations the dialog box to join Mic audio is currently not keyboard accessible. The colour picker in the closed caption settings is also currently not keyboard accessible. There are a few other minor controls yet to be made accessible.

***Note: NVDA works best with Mozilla FireFox and users must toggle focus mode off by pressing the ESC key or NVDAKEY + Spacebar to switch to Browse mode.***

#### NVDA Example : Send a Public message when client first loads 

* Close audio modal
  1. b
  2. Shift + b
  2. Enter
* Open users pane
  1. b
  2. Shift + b
  3. Enter
* Focus messages list
  1. Shift + d (x2)
* Open Public chat
  1. Down-Arrow
  2. Enter
* Send message
  1. Type message
  2. Enter


## JAWS

Common Navigation Shortcut keys:

JAWS shortcuts resource

***Note: JAWS users must ensure that cursor mode is toggled off by pressing JAWSKEY + z, in order to interact with users in the userlist. By default, the JAWSKEY is set to the insert key on the keyboard.***

### JAWS Example : Send a Public message when client first loads

* Close audio modal
  1. b
  2. Shift + b
  3. Enter
* Open users pane
  1. Tab
  2. Shift + Enter
* Focus messages list
  1. Shift + Tab (x2)
* Open Public chat
  1. Insert + z
  2. Down arrow
  2. Enter
* Send message
  1. Type message
  2. Enter

The following link provides a listing of JAWS keys and functionality:
[JAWS Keys](https://webaim.org/resources/shortcuts/jaws)