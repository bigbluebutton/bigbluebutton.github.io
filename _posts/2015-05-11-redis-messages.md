---
layout: page
title: "Redis Messages"
category: labs
date: 2015-05-11 17:34:41
---


# Redis Messages (from bbb-app's perspective)

## Incomming messages



## Outgoing messages





meeting_created_message:

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

user_registered_message:

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

permisssion_setting_initialized_message:

```
{
    "payload": {
        "settings": "Permissions(false,false,false,false,false,true,false)",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 21983022,
        "name": "permisssion_setting_initialized_message",
        "current_time": 1431371343638,
        "version": "0.0.1"
    }
}
```

presenter_assigned_message:

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

user_status_changed_message:

```
{
    "payload": {
        "status": "presenter",
        "value": "true",
        "userid": "stgsriyaa58n_2",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 21983082,
        "name": "user_status_changed_message",
        "current_time": 1431371343698,
        "version": "0.0.1"
    }
}
```

validate_auth_token_reply:

```
{
    "payload": {
        "valid": "true",
        "reply_to": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091/kxxcvswxsfxa_2",
        "userid": "kxxcvswxsfxa_2",
        "auth_token": "xypktxbjjaqi",
        "meeting_id": "d84a8b82330af852db9af76582276ae84a6ffc33-1431371342091"
    },
    "header": {
        "timestamp": 22009039,
        "name": "validate_auth_token_reply",
        "current_time": 1431371369655,
        "version": "RED5-4HNKFLSCFWCWM-kxxcvswxsfxa_2"
    }
}
```

user_joined_message:

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
        "timestamp": 22009040,
        "name": "user_joined_message",
        "current_time": 1431371369656,
        "version": "0.0.1"
    }
}
```

get_users_reply:

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

get_recording_status_reply:

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

user_raised_hand_message:

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

user_lowered_hand_message:

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

new_permission_settings:

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

user_locked_message:

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

user_joined_voice_message:

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

user_voice_talking_message:

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

send_public_chat_message:

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

send_private_chat_message:

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

send_whiteboard_shape_message:

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

whiteboard_cleared_message:

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

user_voice_muted_message:

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

eject_voice_user_message

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

user_left_message:

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


