---
layout: page
title: "Sample Module"
category: dev
date: 2015-04-05 16:12:47
---


## Getting Started
Follow the [instructions](/dev/setup.html) on setting up your development environment.

## Running the Example Code
There is an Example module in the code base. The main module class is in bbb-client/src/ExampleChatModule.mxml. It uses two simple classes which are located in bbb-client/src/org.bigbluebutton.modules.example

To get the ExampleChatModule working:
  * Set up your development environment correctly, making sure you can launch your bbb-client from Flash Builder 4.
  * Right click on your Flex Project, go to Properties>Modules and add src/ExampleChatModule.mxml to the list if it's not already there
  * Add the following code to the src/conf/config.xml file:
```
<module name="ExampleChatModule" url="ExampleChatModule.swf?v=56" 
			uri="rtmp://192.168.0.219/bigbluebutton" 
			host="http://192.168.0.219" 
			onUserJoinedEvent="START" 
			onUserLogoutEvent="STOP"
/>
```
  * In the same config.xml file, make sure the ExampleChatModule is also referenced as the loadNextProperty of the last loaded module (the module not already containing a loadNextModule property).
  * Launch your client and make sure you can see the new example module, and that you can send chat messages and receive them back.

## Examining the Example Code
The ExampleChatModule demonstrates how to create a very simple module in BigBlueButton. The module contains a simple window with two text boxes and a button for sending messages. In total the module has 3 classes.

### ExampleChatModule.mxml
You can use this class as a template for your future modules. The only relevant parts to you as a newbie to creating BigBlueButton modules are the two methods at the bottom - start() and stop(). The start function is called by the Main BigBlueButton Application when the module is loaded. It injects certain properties into the modules, such as the server connection to the red5 back-end of BigBlueButton, as well as the username and unique userid. The start() method here creates a new UI instance for our module - ExampleChatWindow.mxml. It also sends out an event, called OpenWindowEvent, which will get captured by the main application and the window will be displayed. The stop method is called when the user logs out or the application otherwise stops. You may perform any cleanup you need to do here.

### ExampleChatWindow.mxml
The ExampleChatWindow contains the UI for our module. The UI components in the window (such as the text boxes and buttons) are declared as tags on the bottom. When the user clicks the "Send Message" button, the !sendNewMessage() method is executed, which appends whatever text there is in the input text box to the user name of the current user, and sends that message to the ExampleChatProxy class instance.

### ExampleChatProxy.mxml
The ExampleChatProxy class has all the logic for communicating with the server, sending chat messages and receiving them. The class extracts the netConnection object from the attributes passed to it and uses the connection to the server to connect a RemoteSharedObject to the server. When the user clicks the "Send Message" button on the UI, the !sendMessage() method on the Proxy class is called, which updates the [RemoteSharedObject](http://livedocs.adobe.com/flex/3/langref/flash/net/SharedObject.html) on the server with the new message string value. The server then calls back all the client which are connected to that RemoteSharedObject with the updated string. In this case, the server calls the method !serverCallback(). This method updates the UI of our module, and the message appears in the window.

### Compiling bbb-client Modules Under Ubuntu 10.04 using [build.xml](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/build.xml)
As you might know Ubuntu does not support Flash Builder, instead we have ant commands which use mxmlc (Flex SDK) to compile the client components.

In order to make !ant compile the ExampleChatModule you need to edit the build.xml file in the root of bbb-client.

First you need to add a line near the top (line [25](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/build.xml#L25)).

```
<property name="EXAMPLE_CHAT" value="ExampleChatModule" />
```

This line is used throughout the rest of the build process as a shortened name for the module you're building.

You now need to add an entry (line [165](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/build.xml#L165)) that will allow for the ExampleChatModule to actually be built.

```
<target name="build-example-chat" description="Compile Example Chat Module">
	<build-module src="${SRC_DIR}" target="${EXAMPLE_CHAT}" />
</target>
```

Because our ExampleChatModule is very simple and basic you don't need to add any extra information to the build process. You can take a take a look at the other target entries with the name "build-x" for examples of more complex build statements.

Once you've added the previous two entries the build setup is finished.

To now actually build the ExampleChatModule you need to add a final entry near the end of the document that will give a build name for ant to look up.

At the end of the document there should be a target entry with the name "build-custom". You could modify it and make it reference build-example-chat, but we're going to add our own entry instead.

Add the following after the build-custom entry.

```
<target name="build-custom-chat" depends="init-ant-contrib, build-example-chat" description="Build the ExampleChatModule only to reduce build time" />
```

You can now build the module from the terminal.

```
ant build-custom-chat 
```

When you build this way only the module that you specify is built and updated. This method has advantages and disadvantages though. When you only build one module you can reduced the 3-5 minutes of build time down to a couple of seconds.

If you want to be enable rebuilding of the ExampleChatModule when you run just ant as well you need to add a entry to the existing module groupings (line [227](https://github.com/bigbluebutton/bigbluebutton/blob/master/bigbluebutton-client/build.xml#L227)) so that ours is linked in also.

You now have build control over your client module.
