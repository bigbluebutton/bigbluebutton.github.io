---
layout: page
title: "HTML5 Project Structure"
category: html
date: 2016-05-26 14:39:42
---


## Meteor Structure


![Meteor Structure Diagram](https://sc-cdn.scaleengine.net/i/f688f5a9d82e0d2bdae4b6a23f2a814f.png)

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

Inside <b>/modifiers</b> we will have a file named eventHandlers.js. This file will import the server object where we register Redis event handlers for. Currently we use a our eventEmitter from <b>/imports/startup/server</b>. This file will contain all the event handlers for the collection. Every event will have a function registered to a string message. Each function handler must receive a callback object. Each function handler must end by returning and invoking the callback like so `return arg.callback();`

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
