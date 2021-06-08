---
layout: page
title: "HTML5 Best Practices"
#category: 2.2
date: 2019-07-26 17:34:41
---

When making a new component there is a recommended structure to follow and existing components to utilize to make your life easier.

## Buttons

There is a standard button component we use in the client. It is located inside of <b>/imports/ui/shared/Button.jsx</b>. It should be used for every button.

## Font Size

Inside of <b>/client/stylesheets</b> there is a stylesheet <b>fontSizing.css</b>.

It will contain style classes such as extraSmallFont, smallFont, mediumFont, etc. Every piece of html with text to display to the client should be assigned one of these classes. This will allow text to scale responsively and still maintain relative size. You can set the class of an element to one of these classes, and have everything inside the container element inherit the font size rather than assign it to each individual child to save some work.

# Localization


The HTML5 client supports localizations by using the React-Intl  which allows the HTML5 client to have fully localized messages which are uploaded to Transifex for translating. As a result of this we have added the ability within the HTML5 client to switch the language of the application.

The main language file is `en.json`. When there is a new field to localize, we update `en.json`, and then the new field string becomes available for crowdsourced translation on [Transifex](https://www.transifex.com)

When declaring formatted messages we use  defineMessages and  injectIntl in place of FormattedMessage.

~~~
Import { injectIntl } from ‘react-intl’;          //pass’s messages as prop to the component
import { defineMessages } from 'react-intl';      //import so we can group together all messages inside a component.

const intlMessages = defineMessages({             //all messages can be defined in intlMessages
  title: {
	id: 'app.about.title', 	                        //id corresponds to the id in the locale file
	description: 'About title label in Settings menu', //gives developers additional context about the element/item
  },
});
~~~

We omit the default message prop because it is the same as the string located in the locale file. By doing this we keep context of what the id’s mean while eliminating duplication.  Once the messages are defined we then add the following to use the `injectIntl`:

~~~
export default injectIntl(ComponentName);
~~~

From this point we can use the messages directly as they are passed down as props.

~~~
const { intl } = this.props;     //defined messages get passed as props

<Button
    role="button"
    label={intl.formatMessage(intlMessages.title)}   	  //gets rendered to the screen
    aria-label={intl.formatMessage(intlMessages.title)}    //voiced by screen reader
/>
~~~

If the browser is requesting a locale file that does not contain all the translations, all the available strings will be merged with the locale file set as the default. In this case all messages will be displayed but may have a mixture of languages.

If message id’s are missing from the locale file set as the default, and the browser requests the default or another locale containing a portion of the translated strings; there is potential for the missing id’s to not render a message and in this care default to the id of the message. To ensure this does not occur we make sure that the locale specified as the default always contains 100% of the used messages.

## Server Calls


To make a call to the server from the client, you should refer to the <b>callServer</b> function in <b>/imports/ui/services/api/index.js</b>.

Always use this in favor of <b>Meteor.call</b>. The <b>callServer</b> function should operate the same way in that you pass the name of the method to call as a string, and then the arguments just like normal.

[Meteor.call()](http://docs.meteor.com/#/full/meteor_call)


# Project Structure

<style type="text/css">
pre
{
white-space: pre;
overflow-x: auto;
font-size: 0.85em;
font-family: Monaco,Menlo,Consolas,"Courier New",monospace;
}

.comments{
color: #A9A9A9;
}
</style>

This section covers the structure for the HTML5 project

## Meteor Structure

<pre>
imports/               
  startup/                
    client/               
      index.js                      <span class="comments"># import client startup through a single index entity</span>
      routes.js                     <span class="comments"># set up all routes in the app</span>
      useraccounts-configuration.js <span class="comments"># configure login templates</span>
    server/  
      fixtures.js                   <span class="comments"># fill the DB with example data on startup</span>
      index.js                      <span class="comments"># import server startup through a single index entity</span>

  api/
    lists/                          <span class="comments"># a unit of domain logic</span>
      server/  
        publications.js             <span class="comments"># all list-related publications</span>
        publications.test.js        <span class="comments"># tests for the lists publications</span>
      lists.js                      <span class="comments"># definition of the Lists collection</span>
      lists.tests.js                <span class="comments"># tests for the behavior of that collection</span>
      methods.js                    <span class="comments"># methods related to lists</span>
      methods.tests.js              <span class="comments"># tests for those methods</span>

  ui/  
    components/                     <span class="comments"># all reusable components in the application</span>
                                    <span class="comments"># can be split by domain if there are many</span>
    layouts/                        <span class="comments"># wrapper components for behavior and visuals</span>
    pages/                          <span class="comments"># entry points for rendering used by the router</span>

client/  
  main.js                           <span class="comments"># client entry point, import all client code</span>

server/
  main.js                           <span class="comments"># server entry point, import all server code</span>
</pre>

Taken from [Meteor Structure](http://guide.meteor.com/structure.html#example-app-structure)

Inside imports is where we store all units of functionality for the HTML5 client.

Inside API is where we store the collection data that we use, sort of like a model.

Inside UI is where we store what would be the view for the models.


## API


Located under <b>/imports/api</b>

Each sub-directory here will either be a data collection, or some service we use in the client.

The name of the subdirectory should be in lower-case representing the name of the Mongo collection, or following typical programming collection it will be PascalCased representing a class name.

Differing from the Meteor Structure is that for security purposes we want the majority of our functionality in the <b>/server</b> directory, which keeps it from loading on the clients.

The main export or class for the API component should be in <b>index.js</b>, which allows for easy importing. So to import the Polling collection for example, we can use the following code `import Polls from 'imports/api/polls/'`.

Since it is <b>index.js</b> we don’t have to specify that file since it is default.

Naming files this way can conflict with certain conventions where the file name is named after the main class inside it. To go about this we simply have a default export for the collections, and in the case of a collection we export the new instance.

Inside the <b>/server</b> directory of every API component we have a named file named publications.js. This is where we put the Meteor publish callback for the collection.

We now have 2 more sub-directories inside the <b>/server</b> directory-- methods and modifiers.

### /methods

Inside <b>/methods</b> we have one file per method. These methods are where we declare the Meteor.Methods for the collection-- which are Meteor server methods that can be invoked from the Meteor client. We have one file per method, and they are named in camelCase. They shouldn’t need an export because of how they are registered in Meteor. They will however have to be imported on the server (at startup) to execute the code.

### /modifiers

Inside <b>/modifiers</b> we have one file per method. These functions that go in here include the functions that modify the <b>collection/data/class</b>, from the server side. We have one file per method, and they are named in camelCase. There should be one export per file. And these will be imported wherever needed. These are almost all functions that will be called from Redis message listeners.

### eventHandlers.js

Inside `imports/api/<collection>/server/` we have a file called `eventHandlers.js`. This file will contain all the event handlers for the collection.

/ui
---

Inside /ui we will have sub-directories for

-   components

-   services

-   stylesheets

### /services

will have <b>/api/index.js</b>. Which is where we will store client-side-wide services and helpers. The functions and data in here will all be exported on the last line of the file in one export statement. This allows someone to just look at the last line of the file and easily see what the file exports.

### /components

Inside this directory each sub-directory will represent a React Component. The name of the sub-directory is what the name of the component is. They are all lowercase, with dashes (-) between words. The standard file are

-   component.jsx

-   container.jsx

-   service.js

-   styles.scss

Example

-&gt; /whiteboard

&emsp; &emsp;-&gt; component.jsx

&emsp; &emsp;-&gt; service.js

&emsp; &emsp;-&gt; container.js

&emsp; &emsp;-&gt; /slide/component.jsx

&emsp; &emsp;-&gt; /cursor/component.jsx

&emsp; &emsp;-&gt; /shape-factory/component.jsx

&emsp; &emsp;-&gt; /shapes

&emsp; &emsp; &emsp; &emsp;-&gt; /ellipse/component.jsx

&emsp; &emsp; &emsp; &emsp;-&gt; /triangle/component.jsx

&emsp; &emsp; &emsp; &emsp;-&gt; ... &lt;the rest of the shape components&gt;

#### Component

All components will be React ES6 style classes (not React Classes). A component should only need to have one export and it should be the default export. Refer to the official React documentation on how to structure a component class. The component file will be named <b>component.jsx</b>.

#### Container

[createContainer()](http://guide.meteor.com/react.html#using-createContainer)

A container is a React ES6 class that will pass data to the component. The container will also be in control of whether or not the component should render. A container should retrieve data from the service and pass it into the container class.

The container file will be named <b>container.jsx</b>. The file should have only one export and should be the default export. The export should be the result of the `createContainer()` function.

#### Service

The service file should be named <b>service.js</b>.

The file can export as many function, objects, or other pieces of data as it needs. The service can interface with other collections as well. There should only be one export statement in the file. The last line of the file should export all the functions and pieces of data in an object. Restrain from wrapping everything inside a function and exporting the function wrapper.

#### Styles.scss

All styles should be written in SASS when possible.