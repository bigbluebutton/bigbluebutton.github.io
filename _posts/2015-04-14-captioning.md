---
layout: page
title: "Captioning"
category: labs
date: 2015-04-14 16:29:25
---

## Overview

We want to expand our accessibility support to include closed captioning support. We need to support live and recorded captioning.

## Proposed Features

### Client

* Viewer
  * size, color, font, upper/lower case, locale
  * Do we show when the last message was received?
* Operator
    * Input
        * Use a TextBox
        * Type the content and press enter to submit
        * Need to be able to revoke the last line
        * Should revoking put the last line into the text box for editing or just delete?
    * Editing
        * Use a TextArea
        * Use the Text_Input method mainly
        * Need to be able to edit any past text
        * Need to be able to add lines in-between published text
        * Has to handle cut, copy, and paste

### Recording
* Processing
    * Needs to take new messages into consideration somehow if the recording was turned off for that section
    * Needs to take corrections into consideration when building the final file
    * Corrections could be outside of the record start/stop event pairs
    * Corrections will be 0 or more characters and be a substring replace
    * If a new line is added it should push any lines equal or greater down the list
    * A line’s number is not constant through the meeting
* Post-Processing
    * We need a link to download the transcript
        * SRT is the most popular transcript format
        * We could offer a choice
    * We need a way to edit the transcript after the meeting has finished
        * Possibly download and reupload the correctly chunked version
        * Or upload a new transcription for meeting that had no live transcription

## MessageFormat

{% highlight json %}
{"type":"newCaptionLine", "lineNumber":"lineNumber", "locale":"en_US", "startTime":"milliseconds", "text":"string"}
{"type":"deleteCaptionLine", "lineNumber":"lineNumber", "locale":"en_US"}
{"type":"correctCaptionLine", "lineNumber":"lineNumber", "locale":"en_US", "startChar":"uint", "endChar":"uint", "replacementText":"string"}
{"type":"updateTranscriptionList", "userId":"string", "locale":"en_US"}
{% endhighlight %}