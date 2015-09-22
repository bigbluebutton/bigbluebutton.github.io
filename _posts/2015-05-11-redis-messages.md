---
layout: page
title: "Redis Messages"
category: labs
date: 2015-05-11 17:34:41
---

# Redis Messages 

The following list is an enumeration of the messages sent/received through redis from the perspective of bbb-akka-apps.  These messages are present in BigBlueButton 1.0-beta (or later).  With these messages, you can integrate your own server-side logic for monitoring the messages in a BigBlueButton session.

## meeting_created_message

```
{
    "payload": {
        "duration": 0,
        "create_date": "Mon May 11 19:09:02 UTC 2015",
        "name": "ENGL-2013: Research Methods in English",
        "create_time": 1431371342091,
        "moderator_pass": "prof123",
        "voice_conf": "72013",
        "recorded": false,
        "external_meeting_id": "ENGL-2013: Research Methods in English",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "viewer_pass": "student123"
    },
    "header": {
        "timestamp": 21981478,
        "name": "meeting_created_message",
        "current_time": 1431371342094,
        "version": "0.0.1"
    }
}
```

## user_registered_message

```
{
    "payload": {
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "user": {
            "userid": "stgsriyaa58n",
            "name": "Prof",
            "authToken": "kkuflziytusz",
            "role": "MODERATOR",
            "extern_userid": "stgsriyaa58n"
        }
    },
    "header": {
        "timestamp": 21981542,
        "name": "user_registered_message",
        "current_time": 1431371342157,
        "version": "0.0.1"
    }
}
```

## permisssion_setting_initialized_message

```
{
    "payload": {
        "settings": "Permissions(false,false,false,false,false,true,false)",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26222918,
        "name": "permisssion_setting_initialized_message",
        "current_time": 1431375583534
    }
}
```

## presenter_assigned_message

```
{
    "payload": {
        "new_presenter_id": "stgsriyaa58n_2",
        "recorded": false,
        "new_presenter_name": "Prof",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "assigned_by": "stgsriyaa58n_2"
    },
    "header": {
        "timestamp": 21983081,
        "name": "presenter_assigned_message",
        "current_time": 1431371343697,
        "version": "0.0.1"
    }
}
```

## user_status_changed_message

```
{
    "payload": {
        "status": "presenter",
        "value": true,
        "userid": "qd53ydwfes0p_2",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26423065,
        "name": "user_status_changed_message",
        "current_time": 1431375783680
    }
}
```

## validate_auth_token_reply

```
{
    "payload": {
        "valid": true,
        "auth_token": "2skb0pcntovd",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "eibo1pfjodkx_2"
    },
    "header": {
        "timestamp": 26222953,
        "name": "validate_auth_token_reply",
        "current_time": 1431375583568
    }
}
```

## user_joined_message

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "user": {
            "presenter": false,
            "userid": "eibo1pfjodkx_2",
            "phone_user": false,
            "name": "Student002",
            "has_stream": false,
            "raise_hand": false,
            "listenOnly": false,
            "role": "VIEWER",
            "extern_userid": "eibo1pfjodkx",
            "voiceUser": {
                "web_userid": "eibo1pfjodkx_2",
                "callernum": "Student002",
                "userid": "eibo1pfjodkx_2",
                "talking": false,
                "joined": false,
                "callername": "Student002",
                "locked": false,
                "muted": false
            },
            "locked": true,
            "webcam_stream": {}
        }
    },
    "header": {
        "timestamp": 26222964,
        "name": "user_joined_message",
        "current_time": 1431375583580,
        "version": "0.0.1"
    }
}
```

## get_users_reply

```
{
    "payload": {
        "users": [
            {
                "presenter": false,
                "userid": "kxxcvswxsfxa_2",
                "phone_user": false,
                "name": "Student",
                "has_stream": false,
                "raise_hand": false,
                "listenOnly": false,
                "role": "VIEWER",
                "extern_userid": "kxxcvswxsfxa",
                "voiceUser": {
                    "web_userid": "kxxcvswxsfxa_2",
                    "callernum": "Student",
                    "userid": "kxxcvswxsfxa_2",
                    "talking": false,
                    "joined": false,
                    "callername": "Student",
                    "locked": false,
                    "muted": false
                },
                "locked": true,
                "webcam_stream": {
                    
                }
            },
            {
                "presenter": true,
                "userid": "stgsriyaa58n_2",
                "phone_user": false,
                "name": "Prof",
                "has_stream": false,
                "raise_hand": false,
                "listenOnly": false,
                "role": "MODERATOR",
                "extern_userid": "stgsriyaa58n",
                "voiceUser": {
                    "web_userid": "stgsriyaa58n_2",
                    "callernum": "Prof",
                    "userid": "stgsriyaa58n_2",
                    "talking": false,
                    "joined": false,
                    "callername": "Prof",
                    "locked": false,
                    "muted": false
                },
                "locked": false,
                "webcam_stream": {
                    
                }
            }
        ],
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "requester_id": "kxxcvswxsfxa_2"
    },
    "header": {
        "timestamp": 22009093,
        "name": "get_users_reply",
        "current_time": 1431371369709,
        "version": "0.0.1"
    }
}
```

## get_recording_status_reply

```
{
    "payload": {
        "recording": false,
        "userid": "kxxcvswxsfxa_2",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 22009093,
        "name": "get_recording_status_reply",
        "current_time": 1431371369709,
        "version": "0.0.1"
    }
}
```

## user_raised_hand_message

```
{
    "payload": {
        "userid": "stgsriyaa58n_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "raise_hand": false
    },
    "header": {
        "timestamp": 22018748,
        "name": "user_raised_hand_message",
        "current_time": 1431371379364,
        "version": "0.0.1"
    }
}
```

## user_lowered_hand_message

```
{
    "payload": {
        "lowered_by": "stgsriyaa58n_2",
        "userid": "stgsriyaa58n_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "raise_hand": false
    },
    "header": {
        "timestamp": 22019619,
        "name": "user_lowered_hand_message",
        "current_time": 1431371380235,
        "version": "0.0.1"
    }
}
```

## new_permission_settings

```
{
    "payload": {
        "users": [
            {
                "presenter": false,
                "userid": "kxxcvswxsfxa_2",
                "phone_user": false,
                "name": "Student",
                "has_stream": false,
                "raise_hand": false,
                "listenOnly": false,
                "role": "VIEWER",
                "extern_userid": "kxxcvswxsfxa",
                "voiceUser": {
                    "web_userid": "kxxcvswxsfxa_2",
                    "callernum": "Student",
                    "userid": "kxxcvswxsfxa_2",
                    "talking": false,
                    "joined": false,
                    "callername": "Student",
                    "locked": false,
                    "muted": false
                },
                "locked": true,
                "webcam_stream": {
                    
                }
            },
            {
                "presenter": true,
                "userid": "stgsriyaa58n_2",
                "phone_user": false,
                "name": "Prof",
                "has_stream": false,
                "raise_hand": false,
                "listenOnly": false,
                "role": "MODERATOR",
                "extern_userid": "stgsriyaa58n",
                "voiceUser": {
                    "web_userid": "stgsriyaa58n_2",
                    "callernum": "Prof",
                    "userid": "stgsriyaa58n_2",
                    "talking": false,
                    "joined": false,
                    "callername": "Prof",
                    "locked": false,
                    "muted": false
                },
                "locked": false,
                "webcam_stream": {
                    
                }
            }
        ],
        "disablePrivChat": true,
        "lockOnJoinConfigurable": true,
        "disableCam": false,
        "disableMic": true,
        "lockOnJoin": true,
        "lockedLayout": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "disablePubChat": true
    },
    "header": {
        "timestamp": 22036039,
        "name": "new_permission_settings",
        "current_time": 1431371396655,
        "version": "0.0.1"
    }
}
```

## user_locked_message

```
{
    "payload": {
        "userid": "kxxcvswxsfxa_2",
        "locked": true,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 22039136,
        "name": "user_locked_message",
        "current_time": 1431371399751,
        "version": "0.0.1"
    }
}
```

## user_joined_voice_message

```
{
    "payload": {
        "voice_conf": "72013",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "user": {
            "presenter": true,
            "userid": "stgsriyaa58n_2",
            "phone_user": false,
            "name": "Prof",
            "has_stream": false,
            "raise_hand": false,
            "listenOnly": false,
            "role": "MODERATOR",
            "extern_userid": "stgsriyaa58n",
            "voiceUser": {
                "web_userid": "stgsriyaa58n_2",
                "callernum": "stgsriyaa58n-bbbID-Prof",
                "userid": "1",
                "talking": false,
                "joined": true,
                "callername": "Prof",
                "locked": false,
                "muted": false
            },
            "locked": false,
            "webcam_stream": {
                
            }
        }
    },
    "header": {
        "timestamp": 22052318,
        "name": "user_joined_voice_message",
        "current_time": 1431371412934,
        "version": "0.0.1"
    }
}
```

## user_voice_talking_message

```
{
    "payload": {
        "voice_conf": "72013",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "user": {
            "presenter": true,
            "userid": "stgsriyaa58n_2",
            "phone_user": false,
            "name": "Prof",
            "has_stream": false,
            "raise_hand": false,
            "listenOnly": false,
            "role": "MODERATOR",
            "extern_userid": "stgsriyaa58n",
            "voiceUser": {
                "web_userid": "stgsriyaa58n_2",
                "callernum": "stgsriyaa58n-bbbID-Prof",
                "userid": "1",
                "talking": true,
                "joined": true,
                "callername": "Prof",
                "locked": false,
                "muted": false
            },
            "locked": false,
            "webcam_stream": {
                
            }
        }
    },
    "header": {
        "timestamp": 22065987,
        "name": "user_voice_talking_message",
        "current_time": 1431371426603,
        "version": "0.0.1"
    }
}
```

## send_public_chat_message

```
{
    "payload": {
        "message": {
            "chat_type": "PUBLIC_CHAT",
            "message": "a",
            "to_username": "public_chat_username",
            "from_tz_offset": "240",
            "from_color": "0",
            "to_userid": "public_chat_userid",
            "from_userid": "stgsriyaa58n_2",
            "from_time": "1.431371444032E12",
            "from_username": "Prof"
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 22083444,
        "name": "send_public_chat_message",
        "current_time": 1431371444060,
        "version": "0.0.1"
    }
}
```

## send_private_chat_message

```
{
    "payload": {
        "message": {
            "chat_type": "PRIVATE_CHAT",
            "message": "hi",
            "to_username": "Student",
            "from_tz_offset": "240",
            "from_color": "0",
            "to_userid": "kxxcvswxsfxa_2",
            "from_userid": "stgsriyaa58n_2",
            "from_time": "1.431371453358E12",
            "from_username": "Prof"
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 22092747,
        "name": "send_private_chat_message",
        "current_time": 1431371453363,
        "version": "0.0.1"
    }
}
```

## send_whiteboard_shape_message

```
{
    "payload": {
        "whiteboard_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431371342092/1",
        "shape": {
            "wb_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431371342092/1",
            "shape_type": "pencil",
            "status": "DRAW_START",
            "id": "stgsriyaa58n_2-2-1431371458212",
            "shape": {
                "type": "pencil",
                "status": "DRAW_START",
                "points": [
                    52.3469387755102,
                    28.299319727891156,
                    52.44897959183673,
                    28.707482993197278,
                    52.755102040816325,
                    28.843537414965986,
                    52.857142857142854,
                    29.1156462585034,
                    53.16326530612245,
                    29.387755102040817,
                    53.265306122448976,
                    29.79591836734694,
                    53.46938775510204,
                    29.931972789115648,
                    53.673469387755105,
                    30.34013605442177,
                    53.87755102040816,
                    30.612244897959183,
                    54.08163265306123,
                    31.156462585034014,
                    54.285714285714285,
                    31.700680272108844,
                    54.59183673469388,
                    32.38095238095238,
                    54.795918367346935,
                    33.06122448979592,
                    55,
                    33.605442176870746,
                    55.51020408163265,
                    34.285714285714285,
                    56.02040816326531,
                    34.965986394557824
                ],
                "whiteboardId": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431371342092/1",
                "id": "stgsriyaa58n_2-2-1431371458212",
                "transparency": false,
                "thickness": 1,
                "color": 0
            }
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "requester_id": "stgsriyaa58n_2"
    },
    "header": {
        "timestamp": 22097599,
        "name": "send_whiteboard_shape_message",
        "current_time": 1431371458214,
        "version": "0.0.1"
    }
}
```

## whiteboard_cleared_message

```
{
    "payload": {
        "whiteboard_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431371342092/1",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "requester_id": "stgsriyaa58n_2"
    },
    "header": {
        "timestamp": 22102564,
        "name": "whiteboard_cleared_message",
        "current_time": 1431371463180,
        "version": "0.0.1"
    }
}
```

## user_voice_muted_message

```
{
    "payload": {
        "voice_conf": "72013",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "user": {
            "presenter": true,
            "userid": "stgsriyaa58n_2",
            "phone_user": false,
            "name": "Prof",
            "has_stream": false,
            "raise_hand": false,
            "listenOnly": false,
            "role": "MODERATOR",
            "extern_userid": "stgsriyaa58n",
            "voiceUser": {
                "web_userid": "stgsriyaa58n_2",
                "callernum": "stgsriyaa58n-bbbID-Prof",
                "userid": "1",
                "talking": false,
                "joined": true,
                "callername": "Prof",
                "locked": false,
                "muted": false
            },
            "locked": false,
            "webcam_stream": {
                
            }
        }
    },
    "header": {
        "timestamp": 22112507,
        "name": "user_voice_muted_message",
        "current_time": 1431371473122,
        "version": "0.0.1"
    }
}
```

## eject_voice_user_message

```
{
    "payload": {
        "userid": "stgsriyaa58n_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "requester_id": "stgsriyaa58n_2",
        "mute": true
    },
    "header": {
        "timestamp": 22113311,
        "name": "eject_voice_user_message",
        "current_time": 1431371473926,
        "version": "0.0.1"
    }
}
```

## user_left_message

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091",
        "user": {
            "presenter": false,
            "userid": "kxxcvswxsfxa_2",
            "phone_user": false,
            "name": "Student",
            "has_stream": false,
            "raise_hand": false,
            "listenOnly": false,
            "role": "VIEWER",
            "extern_userid": "kxxcvswxsfxa",
            "voiceUser": {
                "web_userid": "kxxcvswxsfxa_2",
                "callernum": "Student",
                "userid": "kxxcvswxsfxa_2",
                "talking": false,
                "joined": false,
                "callername": "Student",
                "locked": false,
                "muted": false
            },
            "locked": true,
            "webcam_stream": {
                
            }
        }
    },
    "header": {
        "timestamp": 22137061,
        "name": "user_left_message",
        "current_time": 1431371497677,
        "version": "0.0.1"
    }
}
```

## create_meeting_request

```
{
    "payload": {
        "duration": 0,
        "create_date": "Mon May 11 20:19:42 UTC 2015",
        "create_time": 1431375582367,
        "moderator_pass": "prof123",
        "voice_conf": "72013",
        "recorded": false,
        "external_meeting_id": "ENGL-2013: Research Methods in English",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "viewer_pass": "student123",
        "meeting_name": "ENGL-2013: Research Methods in English"
    },
    "header": {
        "timestamp": 26221805,
        "name": "create_meeting_request",
        "current_time": 1431375582420
    }
}
```

## presentation_conversion_update_message

```
{
    "payload": {
        "presentation_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427",
        "code": "CONVERT",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "presentation_name": "default.pdf",
        "message_key": "SUPPORTED_DOCUMENT"
    },
    "header": {
        "timestamp": 26222845,
        "name": "presentation_conversion_update_message",
        "current_time": 1431375583461
    }
}
```

## presentation_conversion_progress_message

```
{
    "payload": {
        "presentation_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427",
        "code": "CONVERT",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "presentation_name": "default.pdf",
        "message_key": "SUPPORTED_DOCUMENT"
    },
    "header": {
        "timestamp": 26222849,
        "name": "presentation_conversion_progress_message",
        "current_time": 1431375583465,
        "version": "0.0.1"
    }
}
```

## presentation_page_generated_message

```
{
    "payload": {
        "presentation_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427",
        "num_pages": 5,
        "code": "CONVERT",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "presentation_name": "default.pdf",
        "message_key": "GENERATED_SLIDE",
        "pages_completed": 2
    },
    "header": {
        "timestamp": 26222896,
        "name": "presentation_page_generated_message",
        "current_time": 1431375583512
    }
}
```

## get_presentation_info_reply

```
{
    "payload": {
        "presentations": [
            
        ],
        "presentation_info": {
            "presenter": {
                "userId": "system",
                "name": "system",
                "assignedBy": "system"
            },
            "presentations": {
                
            }
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "presenter": {
            "name": "system",
            "userid": "system",
            "assigned_by": "system"
        },
        "requester_id": "eibo1pfjodkx_2"
    },
    "header": {
        "timestamp": 26224571,
        "reply_to": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/eibo1pfjodkx_2",
        "name": "get_presentation_info_reply",
        "current_time": 1431375585187,
        "version": "0.0.1"
    }
}
```

## presentation_conversion_completed_message

```
{
    "payload": {
        "presentation_id": {
            "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427",
            "name": "default.pdf",
            "current": false,
            "pages": {
                
            }
        },
        "code": "CONVERT",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "message_key": "CONVERSION_COMPLETED"
    },
    "header": {
        "timestamp": 26232546,
        "name": "presentation_conversion_completed_message",
        "current_time": 1431375593162
    }
}
```

## presentation_conversion_done_message

```
{
    "payload": {
        "presentation": {
            "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427",
            "pages": [
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 3,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/3",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/3",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/3",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/3",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/3"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 1,
                    "x_offset": 0.0,
                    "current": true,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/1",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/1",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/1",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/1",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/1"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 2,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/2",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/2",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/2",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/2",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/2"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 4,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/4",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/4",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/4",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/4",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/4"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 5,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/5",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/5",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/5",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/5",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/5"
                }
            ],
            "name": "default.pdf",
            "current": false
        },
        "code": "CONVERT",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "message_key": "CONVERSION_COMPLETED"
    },
    "header": {
        "timestamp": 26232554,
        "name": "presentation_conversion_done_message",
        "current_time": 1431375593170,
        "version": "0.0.1"
    }
}
```

## presentation_shared_message

```
{
    "payload": {
        "presentation": {
            "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427",
            "pages": [
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 3,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/3",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/3",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/3",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/3",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/3"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 1,
                    "x_offset": 0.0,
                    "current": true,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/1",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/1",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/1",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/1",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/1"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 2,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/2",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/2",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/2",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/2",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/2"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 4,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/4",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/4",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/4",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/4",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/4"
                },
                {
                    "height_ratio": 100.0,
                    "y_offset": 0.0,
                    "num": 5,
                    "x_offset": 0.0,
                    "current": false,
                    "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/5",
                    "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/5",
                    "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/5",
                    "width_ratio": 100.0,
                    "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/5",
                    "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/5"
                }
            ],
            "name": "default.pdf",
            "current": true
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26232559,
        "name": "presentation_shared_message",
        "current_time": 1431375593175,
        "version": "0.0.1"
    }
}
```

## presentation_page_changed_message

```
{
    "payload": {
        "page": {
            "height_ratio": 100.0,
            "y_offset": 0.0,
            "num": 1,
            "x_offset": 0.0,
            "current": true,
            "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/1",
            "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/1",
            "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/1",
            "width_ratio": 100.0,
            "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/1",
            "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/1"
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26232562,
        "name": "presentation_page_changed_message",
        "current_time": 1431375593178,
        "version": "0.0.1"
    }
}
```

## register_user_request

```
{
    "payload": {
        "name": "Prof002",
        "userid": "qd53ydwfes0p",
        "role": "MODERATOR",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "external_user_id": "qd53ydwfes0p"
    },
    "header": {
        "timestamp": 26311972,
        "name": "register_user_request",
        "current_time": 1431375672588
    }
}
```
## init_lock_settings

```
{
    "payload": {
        "settings": "Permissions(false,false,false,false,false,true,false)",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26312849,
        "name": "init_lock_settings",
        "current_time": 1431375673465
    }
}
```

## init_audio_settings

```
{
    "payload": {
        "muted": "false",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26312850,
        "name": "init_audio_settings",
        "current_time": 1431375673465
    }
}
```

## validate_auth_token_request

```
{
    "payload": {
        "userid": "qd53ydwfes0p_2",
        "auth_token": "0jzoxrdumz0u",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26312863,
        "name": "validate_auth_token_request",
        "current_time": 1431375673479
    }
}
```

## get_users_request

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26312979,
        "reply_to": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/qd53ydwfes0p_2",
        "name": "get_users_request",
        "current_time": 1431375673595
    }
}
```
## get_current_layout_request

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26313259,
        "name": "get_current_layout_request",
        "current_time": 1431375673874
    }
}
```
## get_current_layout_reply

```
{
    "payload": {
        "layout_id": "",
        "recorded": false,
        "set_by_user_id": "system",
        "locked": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26313259,
        "name": "get_current_layout_reply",
        "current_time": 1431375673875
    }
}
```

## resize_and_move_slide_request

```
{
    "payload": {
        "y_offset": 0.0,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "height_ratio": 100.0,
        "width_ratio": 100.0,
        "x_offset": 0.0
    },
    "header": {
        "timestamp": 26314570,
        "name": "resize_and_move_slide_request",
        "current_time": 1431375675185
    }
}
```

## get_presentation_info_request

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26314602,
        "name": "get_presentation_info_request",
        "current_time": 1431375675218
    }
}
```

## get_whiteboard_shapes_request

```
{
    "payload": {
        "whiteboard_id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/1",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26315598,
        "name": "get_whiteboard_shapes_request",
        "current_time": 1431375676214
    }
}
```

## get_chat_history_request

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26319504,
        "name": "get_chat_history_request",
        "current_time": 1431375680119
    }
}
```

## get_chat_history_reply

```
{
    "payload": {
        "chat_history": [
            
        ],
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26319504,
        "reply_to": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/qd53ydwfes0p_2",
        "name": "get_chat_history_reply",
        "current_time": 1431375680120,
        "version": "0.0.1"
    }
}
```

## voice_user_joined

```
{
    "payload": {
        "voice_user": {
            "userId": "2",
            "webUserId": "qd53ydwfes0p_2",
            "callerName": "Prof002",
            "callerNum": "qd53ydwfes0p-bbbID-Prof002",
            "joined": true,
            "locked": false,
            "muted": false,
            "talking": false
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26386618,
        "name": "voice_user_joined",
        "current_time": 1431375747234
    }
}
```

## voice_user_talking_message

```
{
    "payload": {
        "talking": false,
        "userid": "qd53ydwfes0p_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26388766,
        "name": "voice_user_talking_message",
        "current_time": 1431375749382
    }
}
```

## mute_voice_user_request

```
{
    "payload": {
        "userid": "qd53ydwfes0p_2",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "mute": true,
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26389139,
        "name": "mute_voice_user_request",
        "current_time": 1431375749755
    }
}
```

## voice_user_muted_message

```
{
    "payload": {
        "muted": false,
        "userid": "qd53ydwfes0p_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26390070,
        "name": "voice_user_muted_message",
        "current_time": 1431375750686
    }
}
```

## user_left_voice_message

```
{
    "payload": {
        "voice_conf": "72013",
        "recorded": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "user": "UserVO(qd53ydwfes0p_2,qd53ydwfes0p,Prof002,MODERATOR,false,false,false,false,ListSet(),false,VoiceUser(qd53ydwfes0p_2,qd53ydwfes0p_2,Prof002,Prof002,false,false,false,false),false)"
    },
    "header": {
        "timestamp": 26391101,
        "name": "user_left_voice_message",
        "current_time": 1431375751717
    }
}
```

## mute_meeting_request

```
{
    "payload": {
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "mute": true,
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26394562,
        "name": "mute_meeting_request",
        "current_time": 1431375755177
    }
}

```

## user_raise_hand_request

```
{
    "payload": {
        "userid": "qd53ydwfes0p_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26400792,
        "name": "user_raise_hand_request",
        "current_time": 1431375761408
    }
}
```

## user_lower_hand_request

```
{
    "payload": {
        "lowered_by": "qd53ydwfes0p_2",
        "userid": "qd53ydwfes0p_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26401559,
        "name": "user_lower_hand_request",
        "current_time": 1431375762175
    }
}
```

## set_lock_settings

```
{
    "payload": {
        "settings": "Permissions(false,true,false,false,false,true,false)",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26406544,
        "name": "set_lock_settings",
        "current_time": 1431375767160
    }
}

```

## broadcast_layout_reply

```
{
    "payload": {
        "layout_id": "",
        "recorded": false,
        "set_by_user_id": "system",
        "locked": false,
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26406548,
        "name": "broadcast_layout_reply",
        "current_time": 1431375767164
    }
}
```

## lock_user_request

```
{
    "payload": {
        "lock": false,
        "userid": "eibo1pfjodkx_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26410521,
        "name": "lock_user_request",
        "current_time": 1431375771136
    }
}
```
## assign_presenter_request

```
{
    "payload": {
        "new_presenter_id": "qd53ydwfes0p_2",
        "new_presenter_name": "Prof002",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "assigned_by": "1"
    },
    "header": {
        "timestamp": 26423063,
        "name": "assign_presenter_request",
        "current_time": 1431375783679
    }
}
```

## presentation_page_resized_message

```
{
    "payload": {
        "page": {
            "height_ratio": 100.0,
            "y_offset": 0.0,
            "num": 1,
            "x_offset": 0.0,
            "current": true,
            "png_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/png/1",
            "txt_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/textfiles/1",
            "id": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/1",
            "width_ratio": 100.0,
            "swf_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/slide/1",
            "thumb_uri": "http://192.168.0.119/bigbluebutton/presentation/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367/d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/thumbnail/1"
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26423093,
        "name": "presentation_page_resized_message",
        "current_time": 1431375783709,
        "version": "0.0.1"
    }
}
```

## mute_user_request

```
{
    "payload": {
        "userid": "eibo1pfjodkx_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "mute": true,
        "requester_id": "eibo1pfjodkx_2"
    },
    "header": {
        "timestamp": 26423413,
        "name": "mute_user_request",
        "current_time": 1431375784029
    }
}

```

## send_whiteboard_annotation_request

```
{
    "payload": {
        "annotation": {
            "id": "qd53ydwfes0p_2-5-1431375792376",
            "status": "textPublished",
            "shapeType": "text",
            "shape": {
                
            },
            "wbId": "d2d9a672040fbde2a47a10bf6c37b6a4b5ae187f-1431375582427/1"
        },
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367",
        "requester_id": "qd53ydwfes0p_2"
    },
    "header": {
        "timestamp": 26434928,
        "name": "send_whiteboard_annotation_request",
        "current_time": 1431375795543
    }
}

```

## disconnect_user_message

```
{
    "payload": {
        "userid": "eibo1pfjodkx_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26445750,
        "name": "disconnect_user_message",
        "current_time": 1431375806366
    }
}

```

## user_leaving_request

```
{
    "payload": {
        "userid": "eibo1pfjodkx_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431375582367"
    },
    "header": {
        "timestamp": 26445752,
        "name": "user_leaving_request",
        "current_time": 1431375806367
    }
}
```

