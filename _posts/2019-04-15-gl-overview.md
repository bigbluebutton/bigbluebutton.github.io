---
layout: page
title: "Overview"
category: greenlight
date: 2019-04-16 16:29:25
# redirect_from: "/install/Greenlight.html"
redirect_from: "/install/greenlight-v2.html"
---

Greenlight 2.0 (referred hereafter as simply "Greenlight") is a Ruby on Rails application that provides a simple interface for users to create rooms, start meetings, and manage recordings.

![Greenlight Landing](/images/greenlight/landing.png)
<center>(the Greenlight home/landing page.)</center><br>

For the end users, Greenlight provides:

  * Authentication via Google, Office365, LDAP, or local accounts
  * A default personal room with a permanent invite URL
  * The ability to create multiple rooms
  * An interface to view, manage, and share recordings

For the developer, Greenlight provides
 
  * A platform that demonstrates best practices for using the BigBlueButton API
  * A Ruby on Rails-based application that you can modify and brand


# Want to try out our demo version?

We host a public, absolutely free, demo version of Greenlight and BigBlueButton over at [demo.bigbluebutton.org](https://demo.bigbluebutton.org/gl). Here you can create an account and experiment with Greenlight before installing it on your own BigBlueButton server.  **Note:** Recordings will only last for 14 days on the public server.

# Features

Greenlight is a feature rich application that aims to address all your BigBlueButton users needs.  We are constantly expanding Greenlight, and if you have any suggestions, you can open one on the [official Greenlight repo](https://github.com/bigbluebutton/Greenlight).

As BigBlueButton and Greenlight are open-source projects, we encourage other developers to contribute. If you want to implement a new feature and submit a pull request, you are more than welcome to do so! For information on contributing to BigBlueButton projects, see [Contributing to BigBlueButton](http://docs.bigbluebutton.org/support/faq.html#contributing-to-bigbluebutton).

## Accounts and Profile

### Sign up / Login

Greenlight has full support for managing user accounts. It currently supports four types of user authentication:

* In-application (Greenlight)
* Google OAuth2
* Office365 OAuth2
* LDAP

![Greenlight Login](/images/greenlight/login.png)

All of these authentication providers are configurable and can be turned on/off individually. Turning off In-application authentication will disable user sign up. This allows you to preconfigure accounts for specific users who you want to have access to your server.

Once you are logged in, you'll see your account appear in the top right corner of the screen. Clicking on the navigation items along side it allows you to traverse Greenlight.

![Greenlight Nav](/images/greenlight/nav.png)

### Profile

Greenlight also allows users to update their account information at any time, including changing their password, profile image, and language for Greenlight.

![Greenlight Settings](/images/greenlight/settings.png)

## Rooms

### Using Your Room

Greenlight is built around the concept of rooms. A room, to the user, is a BigBlueButton session that they "own". A user can add custom room settings, start/stop their room, invite others to their room using a short easily communicable URL, track sessions, and more.

![Greenlight Room](/images/greenlight/room.png)

To invite someone to join your room, all you have to do is give them the invite URL on the room page. Once they follow the URL, they'll be presented with an invitation to join your room. If the user doesn't have a Greenlight account, they'll be prompted to enter a name to join the room. Otherwise, Greenlight will use their account name.

![Greenlight Invitation](/images/greenlight/invitation.png)

If the room is running, they'll be instantly join in. However, if the room is not running they'll be added to the wait list. Once the room starts, they'll be automatically joined into the room with the owner. A user can leave the wait list simply by leaving the page.

![Greenlight Waiting](/images/greenlight/waiting.png)

### Creating New Rooms

When you sign up for Greenlight, the application creates your home room which is named "Home Room". You are free to create as many new rooms as you would like for different purposes. To create a new room, you simply click the "Create a Room" block from your list of rooms. You can configure room specific settings to customize each room. To see what each setting does, see [Room Settings](#room-settings)

![Greenlight Create Room](/images/greenlight/create_room.png)

Your new room will then show under your current room, and you can click to switch between them. Your home room is the one with the home icon. You can delete a room using the room drop-down.

![Greenlight Multiple Rooms](/images/greenlight/multiple_rooms.png)

### Room Settings

**Note:** Room setting changes will not apply to currently running/active meetings

| Setting               | Description |
|:-----------------------|:------------|
| Generate an optional room access code         |           Generates an access code that users must enter before they are allowed to join the room. An access code can be randomly generated by clicking the dice icon the left, and can be removed by clicking the garbage icon on the right. |
| Mute users when they join                     | Automatically mutes the user when they join the BigBlueButton meeting | 
| Require moderator approval before joining     | Prompts the moderator of the BigBlueButton meeting when a user tries to join. If the user is approved, they will be able to join the meeting.|
| Allow any user to start this meeting          | Allows any user to start the meeting. By default, only the Room Owner will join as a moderator. |
| All users join as moderators                  | Gives all users moderator priveleges in BigBlueButton when they join the meeting. |
| Automatically join me into the room           | Automatically joins the user into the room after the room gets created successfully. |

### Renaming Rooms

**Using the header**

If you hover over the room name, you should see an edit icon

![Greenlight Room Header Edit Icon](/images/greenlight/room_header_edit_icon.png)


You can either click the **edit** icon or double click the header to enable **editing mode:**

![Greenlight Room Header Editing Mode](/images/greenlight/room_header_editing_mode.png)


Afterwards, you can change the name by clicking anywhere or pressing the enter key.

**Using the Room block**

If you look at a Room block, you will see 3 ellipsis which you can click to view the options for this room. You can click **Room Settings** to display a modal that will allow you to edit any of the Room's features.

Afterwards, clicking **Update Room** will save the changes.

![Greenlight Room Block Edit Dropdown](/images/greenlight/room_block_edit_dropdown.png)

![Greenlight Room Block Editing Mode](/images/greenlight/room_block_editing_mode.png)

## Recordings

### Viewing Recordings

On your room page, all recordings for that room will be listed at the bottom under the recordings subtitle. This table contains information about the recording, as well as its recorded formats. You can click on any of these formats and you'll open the recording in a new tab.

![Greenlight Recordings](/images/greenlight/recordings.png)

Each recording has a visibility associated with it, which can be changed by clicking on it in the recordings table. By default, it is set to unlisted.

**Public**: everyone can view it if they have the room link.<br>
**Unlisted**: only users who have the recording link can view it.

### Managing Recordings

Using the drop-down in the recordings table, you have the ability to delete a recording or mail a recording to a friend. Keep in mind, emailing an unlisted recording **will** allow the friend access, so if you want a recording to be completely private, don't share the recording link.

Deleted recordings are **not** recoverable, so be sure when deleting a recording.

### Modifying Recordings

**Renaming Recordings directly using the Recording Title**

To edit the recording name directly using the title, you can hover over the title and see an edit icon.

![Greenlight Recording Title Edit Icon](/images/greenlight/recording_title_edit_icon.png)


You can either click the **edit** icon or double click the title to enable **editing mode:**

![Greenlight Recording Title Editing Mode](/images/greenlight/recording_title_editing_mode.png)


Afterwards, you can change the name by clicking anywhere or pressing the enter key.

### Sorting and Searching Recordings
It is possible to **sort** recordings by metrics such as **Name**, **User Number**, and **Length of Recording**.

This can be done by clicking on the headers of the table (cycles through **ascending**, **descending**, and **no particular order**):

![Greenlight Recording Sort Asc](/images/greenlight/recording_sort_asc.png)

![Greenlight Recording Sort Desc](/images/greenlight/recording_sort_desc.png)

There is also a **live search** that may return any part of the recording name:

![Greenlight Recording Search](/images/greenlight/recording_search.png)


**Searching and sorting** can be used in conjunction:

![Greenlight Recording Filter and Search](/images/greenlight/recording_filter_search.png)

See also
  * [Overview](/greenlight/gl-overview.html)
  * [Install](/greenlight/gl-install.html)
  * [Admin Guide](/greenlight/gl-admin.html)
  * [Customize](/greenlight/gl-customize.html)

