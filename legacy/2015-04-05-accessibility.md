---
layout: page
title: "Accessibility"
# category: dev
date: 2015-04-14 14:56:52
---

## Overview

** Note: ** This document refers to the legacy Flash client.  For accessibility of the new HTML5 cient, see [HTML5 client accessibility](/2.2/html5-accessibility.html).

Accessibility is an important part of BigBlueButton. Not only does it allow users with disabilities to run and participate in meetings, it's also mandated by law that if we CAN make it accessible, we HAVE to. For our purposes, disabilities fall into three main categories: Visual, Auditory, and Motor. This guide focuses mostly on Visual and Motor, simply because of the nature of BigBlueButton and what the team has run into so far.

With Visual and Motor disabilities there is a common concern of the user being able to navigate through the application, since use of a mouse may not be possible. You can accommodate this by including your code in the tab order, and also by providing shortcut keys for all user functionality in your code. The rule is, _if you can do it with a mouse, you need to be able to do it with a keyboard_.

Some Visual disabilities require the user to have a screen reader, which is what it sounds like: an application that reads out the content of the screen to the user. In Flash, this is done mainly through the accessibilityName property. The rule here is, _all relevant data on the screen must have an accessibilityName_.

It may look like a lot of work to develop accessibly, but the majority of the work involved is strictly one-time setup. Once that groundwork is in your code, it becomes a very simple matter to "fill in the blanks" as you add more code.

## Tab Order

This guide will start with the assumption that you are building an entirely new module.

### Linking in your module

BigBlueButton already has an established core tab order, with each module given a baseTabIndex property. The convention is to establish your module's baseTabIndex in an Options class. For an example, examine
the ChatOptions class at dev\bigbluebutton\bigbluebutton-client\src\org\bigbluebutton\modules\chat\model\ChatOptions.as.

Within the Options class, declare the baseTabIndex instance variable like so:
{% highlight as3 %}[Bindable] public var baseTabIndex:int;{% endhighlight %}

In the constructor, make a link to your module's entry in BigBlueButton's config.xml. You can add a baseTabIndex property to the config entry if you want, to allow customization later. This code includes a default value in the event that baseTabIndex is not defined in your module configuration:
{% highlight as3 %}
public function ChatOptions() {
    var cxml:XML =     BBB.getConfigForModule("ChatModule");
    if (cxml != null) {
        if (cxml.@baseTabIndex != undefined) {
            baseTabIndex = cxml.@baseTabIndex;
        } else{
            baseTabIndex = 701;
        }
    }
}

public function getBaseIndex():int {
    return baseTabIndex;
}
{% endhighlight %}

The core BigBlueButton modules have baseTabIndex values 100 elements apart, to accommodate future growth. Replace 701 in the else clause with another, more suitable number that reflects a logical place for your module.

For the existing default baseTabIndex values of the core BigBlueButton client, check \dev\bigbluebutton\bigbluebutton-client\README.

Lastly, determine which MXML file in your module is the "main" file. Continuing with the example of the Chat module, this is dev\bigbluebutton\bigbluebutton-client\src\org\bigbluebutton\modules\chat\views\ChatWindow.mxml. Import your Options class into that MXML with a standard import statement, and declare a baseIndex instance variable just as you did in your Options class, as well as an instance of your Options class, like so:
{% highlight as3 %}
[Bindable] private var baseIndex:int;
[Bindable] public var chatOptions:ChatOptions;
{% endhighlight %}

If your MXML does not already call a method on initialization, add an initialize property to the MDIWindow tag like so:
{% highlight mxml %}
<MDIWindow xmlns="flexlib.mdi.containers.*"
    xmlns:mx="http://www.adobe.com/2006/mxml"
    initialize="init()" >
{% endhighlight %}
Your MDIWindow will likely have far more properties than shown, these have been removed for clarity's sake.

In your initialize method (in this example, init()) initialize baseIndex with the getBaseTabIndex() method from your Options class:
{% highlight as3 %}
private function init():void {
    baseIndex = chatOptions.baseTabIndex;
}
{% endhighlight %}

### Establishing internal tab order

Your module now "knows" where it should sit in the general tab order; you now have to give each Flash component within your module a tabIndex property. This is based on the baseIndex variable in the MXML, so if the file you're working in does not have one, either re-read "Linking in your module" above or find a way to pass the baseIndex from the "main" MXML into the file you're working with.

#### Adding the main controls

If the MDIWindow you are working in doesn't have a creationComplete method, add one:
{% highlight mxml %}
<MDIWindow xmlns="flexlib.mdi.containers.*"
    xmlns:mx="http://www.adobe.com/2006/mxml"
    creationComplete="onCreationComplete()" >
{% endhighlight %}
Your MDIWindow will likely have far more properties than shown, these have been removed for clarity's sake.

Each MDIWindow has a titlebar overlay, also known as the "main bar" of the window, showing the window's title. Generally, there is also a minimize button, maximize button, and close button. These items will come first in the internal tab order of the module, so in the creationComplete method, give each of them a tabIndex property:
{% highlight as3 %}
private function onCreationComplete():void {
    titleBarOverlay.tabIndex = baseIndex;
    minimizeBtn.tabIndex = baseIndex+1;
    maximizeRestoreBtn.tabIndex = baseIndex+2;
    closeBtn.tabIndex = baseIndex+3;
}
{% endhighlight %}
You'll also want to add the accessibilityDescriptions to each item here, but ignore that for now.

#### All other Flash elements

Now that you have put the titlebar and control buttons into the tab order, continue through each element in the module and continue assigning tabIndex properties based on the baseIndex. The tab order within the module is up to your discretion, as long as the order is as sensible to a user who cannot see the screen as it is to a fully-sighted user.

You have already seen how to assign a tabIndex dynamically above. To assign a static tabIndex within the Flash component itself, write the property like so:
{% highlight as3 %}
tabIndex="{baseIndex+4}"
{% endhighlight %}

### Testing

Testing the tab order is very easy, simply focus into the application and continue pressing the Tab key until you see the focus indicator in the general vicinity of your contribution. Continue tabbing, and observe how the movement of the indicator lines up with how you expected it to move.

## Screen Reader Compatibility

According to CDOT's research, there are two main screen-reader applications to be aware of: JAWS and NVDA. JAWS is proprietary software available for a fee; use your own judgment as far as acquiring a license for the software or ignoring it in your testing. NVDA, on the other hand, is the leading open-source screen-reader and completely free to download, use, and test with.

Before you can get any meaningful results from the screen-reader, you'll need to have your tab order sorted out. If you have not done so, please refer to the previous part of this guide.

Adding screen-reader compatibility is relatively simple, and revolves around the accessibilityName property, or in some cases the toolTip property. However, not all Flash components are compatible; for example, Labels are not accessible. Adobe has released a comprehensive guide on the subject; we will focus on BigBlueButton here.

One last thing to consider, is localization. All of your accessibilityNames must be in the locale file, so that the community can translate them to other languages and your module can be used worldwide.

The titlebar component of your MDIWindow needs an accessibilityName, as do the control buttons. See the Tab Order section above for the section were titleBarOverlay is given a tabIndex. In the same place, add this code:
{% highlight as3 %}
titleBarOverlay.accessibilityName = ResourceUtil.getInstance().getString('bbb.exampleModule.titleBar.accessName');
minimizeBtn.accessibilityName = ResourceUtil.getInstance().getString('bbb.exampleModule.minBtn.accessName');
maximizeRestoreBtn.accessibilityName = ResourceUtil.getInstance().getString('bbb.exampleModule.maxBtn.accessName');
closeBtn.accessibilityName = ResourceUtil.getInstance().getString('bbb.exampleModule.closeBtn.accessName');
{% endhighlight %}

Dynamic accessibilityNames can be assigned the same way. For static components, the accessibilityName can be set within the component itself:
{% highlight as3 %}
accessibilityName="{ResourceUtil.getInstance().getString('bbb.exampleModule.exampleComponent.accessName')}"
{% endhighlight %}

If you change an accessibilityName dynamically, be sure to call Accessibility.updateProperties() to force the screen-reader to update it's cached version of the application. The operation is fairly memory-intensive, so use it efficiently.

### Testing

Testing can be done in a very similar manner to testing the tab order. Open your screen-reader of choice, start up the BigBlueButton application, and use the Tab key to navigate to your module. Listen to the reader's description of what is on the screen, and try to put yourself in the position of a blind or partially-sighted user. Turn your monitor off, if it helps. Also listen to the descriptions of established BigBlueButton core modules, and mimic the conventions there in your own accessiblityNames.

## Shortcut Keys

The last main component of adding accessibility to your code is to add shortcut keys. Like hotkeys in any other application, these are key combinations that allow quick access to any feature. In BigBlueButton, there are two distinct sets of hotkeys: global and local. Each of these has it's own "modifier," depending on the browser, and an ASCII keycode. For example, the hotkey to focus the Presentation window has the keyCode 52, which translates to the number 4 key. In Firefox, since it is a global hotkey, the modifier is the Control key. So, Ctrl-4 focuses the Presentation window. The modifiers are in this table:

| Browser  | Global   | Local      |
| -------- | -------- | ---------- |
| Firefox  | Ctrl     | Ctrl-Shift |
| Chrome   | Ctrl     | Ctrl-Shift |
| Explorer | Ctrl-Alt | Ctrl-Shift |

### Deciding what hotkeys to add

Essentially, you want to have a hotkey for each button in your module, as well as a hotkey to focus to each place where the user can provide input or make decisions, such as text input boxes, dropdown lists, or checkboxes. It may be useful for you to map these functions out on a spreadsheet, along with the key you want associated with them and the matching ASCII code.

Because the global and local hotkeys have separate modifiers, each module and the global scope have nearly the entire keyboard to work with. The modifiers were chosen because the major browsers have little or no functions already bound to them, however the W T and N keys are off-limits.

One common requirement for global and local hotkeys is the ShortcutEvent. Open /bigbluebutton-client/src/org/bigbluebutton/main/events/ShortcutEvent.as and add a public static constant for each of your hotkeys. It's not important what you call it, as long as it's unique. This is so that when we later start dispatching ShortcutEvents, the application can differentiate between them based on what we want it to do.

### Shortcut Help Window

The Shortcut Help Window, found at dev/bigbluebutton-client/src/org/bigbluebutton/main/views/ShortcutHelpWindow.mxml, is an in-client guide to all hotkeys in the application. There are several things that need to be done before we can really look at how they all work together, so let's get started.

The first thing you have to do is add your keycodes into the locale files. For each keycode, you want both the ASCII value of the key and a plain-language description of what the hotkey does. For example, these two lines are the English locale entry for the "focus Presentation window" hotkey already mentioned:
{% highlight properties %}
bbb.shortcutkey.focus.presentation = 52
bbb.shortcutkey.focus.presentation.function = Move focus to the Presentation window.
{% endhighlight %}
**NOTE: It is VERY important that it follow the same pattern of bbb.X, bbb.X.function. Otherwise, the Shortcut Window will not process it correctly.**

While you are editing the locale, you also need to add a string to describe your module in the Help window dropdown list. As an example, let's say that you are developing something called the Opinion module:
{% highlight properties %}
bbb.shortcuthelp.dropdown.opinion = Opinion shortcuts
{% endhighlight %}

**REMINDER:** After any change to the locale file, you will need to recompile with ant locales.

Now, we edit the ShortcutWindow.mxml itself. First, in the instance variables you will see a set of ArrayLists (genKeys, presKeys, chatKeys, etc) and a set of corresponding Arrays. You want to create one of each, following the pattern you'll be able to see in the file. For example, let's say that your Opinion module lets a user fill in a text box and then click a button to submit their text. The instance variables in your ShortcutWindow.mxml should look like this:
{% highlight as3 %}
private var genKeys:ArrayList;
private var presKeys:ArrayList;
private var chatKeys:ArrayList;
private var audKeys:ArrayList;
private var viewerKeys:ArrayList;
private var opinionKeys:ArrayList;
private var genResource:Array = ['bbb.shortcutkey.flash.exit', 'bbb.shortcutkey.focus.viewers', 'bbb.shortcutkey.focus.listeners',
'bbb.shortcutkey.focus.video', 'bbb.shortcutkey.focus.presentation', 'bbb.shortcutkey.focus.chat',
'bbb.shortcutkey.share.desktop', 'bbb.shortcutkey.share.microphone', 'bbb.shortcutkey.share.webcam',
'bbb.shortcutkey.shortcutWindow', 'bbb.shortcutkey.logout', 'bbb.shortcutkey.raiseHand',
'bbb.shortcutkey.focus.opinion'];
// Notice that the hotkey to focus to the module is in the global scope

private var presResource:Array = ['bbb.shortcutkey.present.focusslide', 'bbb.shortcutkey.whiteboard.undo',
'bbb.shortcutkey.present.upload', 'bbb.shortcutkey.present.previous', 'bbb.shortcutkey.present.select',
'bbb.shortcutkey.present.next', 'bbb.shortcutkey.present.fitWidth', 'bbb.shortcutkey.present.fitPage'];

private var chatResource:Array = ['bbb.shortcutkey.chat.chatinput', 'bbb.shortcutkey.chat.focusTabs',
'bbb.shortcutkey.chat.focusBox', 'bbb.shortcutkey.chat.changeColour', 'bbb.shortcutkey.chat.sendMessage',
'bbb.shortcutkey.chat.explanation', 'bbb.shortcutkey.chat.chatbox.gofirst',
'bbb.shortcutkey.chat.chatbox.goback', 'bbb.shortcutkey.chat.chatbox.repeat',
'bbb.shortcutkey.chat.chatbox.advance', 'bbb.shortcutkey.chat.chatbox.golatest',
'bbb.shortcutkey.chat.chatbox.goread'];

private var audResource:Array = ['bbb.shortcutkey.listeners.muteme'];

private var viewerResource:Array = ['bbb.shortcutkey.viewers.makePresenter'];

private var opinionResource:Array = ['bbb.shortcutkey.opinion.focusInput', 'bbb.shortcutkey.opinion.submit'];
{% endhighlight %}

Now, look at the reloadKeys() method, and add {% highlight as3 %}opinionKeys = loadKeys(opinionResource);{% endhighlight %}
 Also, in the changeArray() method, add a case to the switch-case clause for your module to add its hotkeys to the shownKeys ArrayCollection:
{% highlight as3 %}
private function changeArray():void {
    shownKeys = new ArrayCollection();
    switch(categories.selectedIndex) {
    case 0: //General
        shownKeys.addAll(genKeys);
        break;
    case 1: //Presentation
        shownKeys.addAll(presKeys);
        break;
    case 2: //Chat
        shownKeys.addAll(chatKeys);
        break;
    case 3: //Audio
        shownKeys.addAll(audKeys);
        break;
    case 4: //Viewers
        shownKeys.addAll(viewerKeys);
        break;
    case 5: //Opinion
        shownKeys.addAll(opinionKeys);
    break;
    }
}
{% endhighlight %}

Finally, at the end of the MXML, there is an ArrayCollection hard-coded with a set of "bbb.shortcuthelp.dropdown.x" strings; add your bbb.shortcuthelp.dropdown.opinion to that set.

Now that everything is in place, we can have a look at how it all fits together. The ArrayCollection we edited at the end populates the Help window's dropdown list with the different categories of hotkeys: General, for the global scope, and then the local hotkeys for each module. The switch-case clause we added to links each category in the dropdown list to one of the Key ArrayLists, and uses them to populate the window's DataGrid. The DataGrid shows the full hotkey sequence and plain-language description for each hotkey, as it takes them from the relevant Resource Array.

But the important thing is, it works, and users can now see which hotkeys do what in your module. Now we actually have to make them do something.

### Global Shortcuts

Before we get into creating global shortcuts within BigBlueButton, first be sure that you have already added the ASCII codes for your hotkeys into the locale file, as described above in the section about the Shortcut Help Window. Also, make sure that you have added constants as necessary to ShortcutEvent.as, as described in "Deciding what hotkeys to add." Once you've done that, we can proceed.

Global shortcuts, in the context of BigBlueButton, are hotkeys that can be used from anywhere within the application, such as the hotkey to focus into the Presentation window. Compare this to local shortcuts which can only be used within the module they affect, such as the hotkey WITHIN the Presentation window to advance to the next slide.

**REMINDER:** As the table in the Shortcut Keys overview shows, global and local shortcut keys also use separate modifiers, to allow the entire keyboard to be used in the global scope and again in each module.

All global shortcuts begin in /bigbluebutton-client/src/BigBlueButton.mxml. The framework for shortcut keys is already present, so all you need to worry about is adding your hotkeys to that framework. Moving forward, we will continue the example from the Shortcut Help Window section of the fictional Opinion module.

In BigBlueButton.mxml, find the loadKeyCombos() method. This collects all available global shortcuts into an object called keyCombos. The Opinion module has only one global shortcut, so the only line we need to add to this method is:
{% highlight as3 %}keyCombos[modifier+(ResourceUtil.getInstance().getString('bbb.shortcutkey.focus.opinion') as String)] = ShortcutEvent.FOCUS_OPINION_MODULE;{% endhighlight %}

**NOTE: Generally, your module's only global shortcut will be to move the applications focus into your module, although this is not a rule by any means.**

That's it, that's all you need to add to BigBlueButton.mxml. The framework for detecting whether the user has pressed the correct keys to dispatch the event and then actually dispatching it is already coded in. If you are curious how it all fits together, we'll get into that in the "Local Hotkeys" section below.

Now, you need to set up a listener for that event you've just dispatched. Assuming that the Opinion module is an MDIWindow like the other main modules, you'll want to open the main MXML file for it. Between the opening 

{% highlight mxml %}<MDIWindow>{% endhighlight %}

 tag and the opening 

{% highlight mxml %}<mx:Script>{% endhighlight %}

 tag, you need to add a 

{% highlight mxml %}<mate:Listener>{% endhighlight %}

 tag like so:
{% highlight mxml %}<mate:Listener type="{ShortcutEvent.FOCUS_OPINION_MODULE}" method="focusWindow" />{% endhighlight %}

Then define the method to be called when the Listener picks up the ShortcutEvent. In this case, the method draws focus to the window's titlebar, from which the user can quickly tab into the module itself. Make sure that you have imported org.bigbluebutton.main.events.ShortcutEvent into the target MXML:
{% highlight as3 %}
private function focusWindow(e:ShortcutEvent):void {
    focusManager.setFocus(titleBarOverlay);
}
{% endhighlight %}

### Local Shortcuts

Adding local shortcuts to your module is a more involved process, as you need to build the framework that is already present for global shortcuts. We'll start in the MDIWindow for your module.

**NOTE: Some modules, like the Chat module, have a more complex structure with specific hotkeys for each one. If your module is built in a similar manner, you will need to repeat this for each MXML in your module which dispatches it's own shortcuts.**

Make sure you've imported org.bigbluebutton.main.events.ShortcutEvent into the MXML file, and declare an instance variable of class Dispatcher. You've already set up a method bound to creationComplete of your MDIWindow when you set up the Tab Order earlier in this guide; instantiate the Dispatcher to new Dispatcher() in that method. Now, make sure that your MXML has a loadKeyCombos method. If not, add one like so: (still working with our example of the Opinion module)
{% highlight as3 %}
private function loadKeyCombos(modifier:String):void {
    keyCombos = new Object(); // always start with a fresh array
    keyCombos[modifier+(ResourceUtil.getInstance().getString('bbb.shortcutkey.opinion.focusInput') as String)] =
                ShortcutEvent.FOCUS_OPINION_INPUT;
    keyCombos[modifier+(ResourceUtil.getInstance().getString('bbb.shortcutkey.opinion.submit') as String)] = 
                ShortcutEvent.OPINION_SUBMIT;
}
{% endhighlight %}

Notice that we are still using the string from the locale file that contains the ASCII code for whichever key is used in the shortcut. Much like how we set up an array to populate the Help window DataGrid to display information about our hotkeys, this sets up this part of your module with an Object full of keycodes to watch out for. Next, add a hotKeyCapture() method which will add a keyDown listener to the module, as well as a locale-change listener in case the user switches the language they're operating in:
{% highlight as3 %}
private function hotkeyCapture():void {
    this.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
    ResourceUtil.getInstance().addEventListener(Event.CHANGE, localeChanged); // Listen for locale changing
}
{% endhighlight %}

Return to your creationComplete method, and after the Dispatcher has been instantiated, call your new hotKeyCapture() method. This makes sure the listeners are in place as soon as the application is done loading.

Finally, one last method to bring everything together: the handleKeyDown() method from the keyDown listener:
{% highlight as3 %}
private function handleKeyDown(e:KeyboardEvent):void {
    var modifier:String = ExternalInterface.call("determineLocalModifier");
    loadKeyCombos(modifier);
    var keyPress:String = (e.ctrlKey  ? "control+" : "") +
                          (e.shiftKey ? "shift+"   : "") +
                           e.altKey   ? "alt+"     : "") + e.keyCode;
    if (keyCombos[keyPress]) {
        disp.dispatchEvent(new ShortcutEvent(keyCombos[keyPress]));
    }
}
{% endhighlight %}

This is where it all comes together. When the user presses a key, the listener catches the event, and determines which modifier it should be looking for with a call to a simple piece of JavaScript which determines which browser the user is running. It then calls the loadKeyCombos method and passes in that modifier; loadKeyCombos brings in the ASCII codes from the locale file and plugs them into the keyCombos object. Control returns to handleKeyDown, which compares the keys being pressed to the key combinations present in keyCombos. If one of those combinations matches, it uses the Dispatcher (disp, in our example) to dispatch the event to the application. Because the keyDown listener was added to the "this" scope rather than to the global "stage," these events are only dispatched when you are in the appropriate scope.

Listening for these events is done the same way as for global shortcuts, with a 

{% highlight mxml %}<mate:Listener>{% endhighlight %}

 tag in the MXML file where the hotkey is meant to take effect.

### Testing

Testing your shortcuts happens in two stages. First, you need to make sure that your hotkey combinations call the correct methods and actually do what they're supposed to do and how they're supposed to do it. Second, you need to make sure that your hotkeys are available in the correct scope. Global hotkeys, of course, should work as long as the Flash application has focus. If you can move focus into the Chat module and still use the local hotkey you set up for your custom module, something has gone wrong.

## Conclusion

With all you've done in this guide, your module is now accessible to users with disabilities, and you have built a strong framework into your code which can expand as needed to suit any future development. Of course, even with the testing guidelines provided here, there is a good chance you may overlook something. There is a large community of users around the world, who have been using technology with disabilities for years and who you can reach out to to perform real-world testing of what you've developed.
