---
layout: page
title: "API Updates"
category: labs
date: 2015-05-07 11:42:28
---

Updates for BigBlueButton 1.0
---------------------------------

List of changes in the API for 1.0.

### getMeetings

What changed: Parameters were added to the response.

Response:

| Change | Param Name | When Returned | Type | Description |
|:------:|:----------:|:-------------:|:----:|:------------|
| Added | voiceBridge (within `<meeting>`) | Always | Number | The voice bridge configured when the meeting was created (param `voiceBridge`). |
| Added | dialNumber (within `<meeting>`) | Always | String | The dial number configured when the meeting was created (param `dialNumber`). |
| Added | participantCount (within `<meeting>`) | Always | Number | Number of *participants* in a meeting. It's the same `participantCount` returned in `getMeetingInfo`. |
| Added | listenerCount (within `<meeting>`) | Always | Number | Number of participants listening to a meeting (using the listen only mode). It's the same `listenerCount` returned in `getMeetingInfo`. |
| Added | voiceParticipantCount (within `<meeting>`) | Always | Number | Number of participants *in the audio conference* of a meeting. It's the same `voiceParticipantCount` returned in `getMeetingInfo`. |
| Added | videoCount (within `<meeting>`) | Always | Number | Number of participants *sharing video* in a meeting. |

Example Response:

```xml
<response>
  <returncode>SUCCESS</returncode>
  <meetings>
    <meeting>
      <meetingID>Demo Meeting</meetingID>
      <meetingName>Demo Meeting</meetingName>
      <createTime>1411067830029</createTime>
      <createDate>Thu Sep 18 19:17:10 UTC 2014</createDate>
      <voiceBridge>74518</voiceBridge> <!-- Added -->
      <dialNumber>613-555-1234</dialNumber> <!-- Added -->
      <attendeePW>ap</attendeePW>
      <moderatorPW>mp</moderatorPW>
      <hasBeenForciblyEnded>false</hasBeenForciblyEnded>
      <running>true</running>
      <participantCount>2</participantCount> <!-- Added -->
      <listenerCount>1</listenerCount> <!-- Added -->
      <voiceParticipantCount>1</voiceParticipantCount> <!-- Added -->
      <videoCount>1</videoCount> <!-- Added -->
      <duration>0</duration>
      <hasUserJoined>true</hasUserJoined>
    </meeting>
  </meetings>
</response>
```

### getMeetingInfo

What changed: Parameters were added to the response.

Response:

| Change | Param Name | When Returned | Type | Description |
|:------:|:----------:|:-------------:|:----:|:------------|
| Added | internalMeetingID | Always | String | The internal identifier of this meeting. Can be used to access a video stream directly from Red5, for example. |
| Added | listenerCount | Always | Number | Number of participants listening to a meeting (using the listen only mode). It's the same `listenerCount` returned in `getMeetings`. |
| Added | voiceParticipantCount | Always | Number | Number of participants *in the audio conference*. It's the same `voiceParticipantCount` returned in `getMeetings`. |
| Added | videoCount | Always | Number | Number of participants *sharing video*. It's the same `videoCount` returned in `getMeetings`. |
| Added | isPresenter (within `<attendee>`) | Always | Boolean | True if the attendee is the current presenter. There can only be one presenter at a time in a meeting. |
| Added | isListeningOnly (within `<attendee>`) | Always | Boolean | True if the attendee is listening to the voice conference using the listen only mode. |
| Added | hasJoinedVoice (within `<attendee>`) | Always | Boolean | True if the attendee has joined to the audio conference and shares audio with other attendees. |
| Added | hasVideo (within `<attendee>`) | Always | Boolean | True if the attendee is sharing a webcam. |

Example Response:

```xml
<response>
  <returncode>SUCCESS</returncode>
  <meetingName>Demo Meeting</meetingName>
  <meetingID>Demo Meeting</meetingID>
  <internalMeetingID> <!-- Added -->
    183f0bf3a0982a127bdb8161e0c44eb696b3e75c-1411067830029
  </internalMeetingID>
  <createTime>1411067830029</createTime>
  <createDate>Thu Sep 18 19:17:10 UTC 2014</createDate>
  <voiceBridge>74518</voiceBridge>
  <dialNumber>613-555-1234</dialNumber>
  <attendeePW>ap</attendeePW>
  <moderatorPW>mp</moderatorPW>
  <running>true</running>
  <duration>0</duration>
  <hasUserJoined>true</hasUserJoined>
  <recording>false</recording>
  <hasBeenForciblyEnded>false</hasBeenForciblyEnded>
  <startTime>1411067830152</startTime>
  <endTime>0</endTime>
  <participantCount>2</participantCount>
  <listenerCount>1</listenerCount> <!-- Added -->
  <voiceParticipantCount>1</voiceParticipantCount> <!-- Added -->
  <videoCount>1</videoCount> <!-- Added -->
  <maxUsers>20</maxUsers>
  <moderatorCount>1</moderatorCount>
  <attendees>
    <attendee>
      <userID>r4osda8xzlsg</userID>
      <fullName>stu</fullName>
      <role>VIEWER</role>
      <isPresenter>false</isPresenter> <!-- Added -->
      <isListeningOnly>false</isListeningOnly> <!-- Added -->
      <hasJoinedVoice>true</hasJoinedVoice> <!-- Added -->
      <hasVideo>true</hasVideo> <!-- Added -->
      <customdata/>
    </attendee>
    <attendee>
      <userID>jgkgwilgigcf</userID>
      <fullName>mod</fullName>
      <role>MODERATOR</role>
      <isPresenter>true</isPresenter> <!-- Added -->
      <isListeningOnly>true</isListeningOnly> <!-- Added -->
      <hasJoinedVoice>false</hasJoinedVoice> <!-- Added -->
      <hasVideo>false</hasVideo> <!-- Added -->
      <customdata/>
    </attendee>
  </attendees>
  <metadata/>
  <messageKey/>
  <message/>
</response>
```

### getRecordings

What changed: Parameters were added to the API call.

Parameters:

| Change | Param Name | When Returned | Type | Description |
|:------:|:----------:|:-------------:|:----:|:------------|
| Added | meta | Optional | String | You can pass one or more metadata values to filter the recordings returned. The format of these parameters is the same as the metadata passed to the `create` call. For more information see [the docs for the create call](http://docs.bigbluebutton.org/dev/api.html#create). |

Example Requests:

```bash
http://yourserver.com/bigbluebutton/api/getRecordings?meta_presenter=joe&meta_category=education&checksum=1234
```
