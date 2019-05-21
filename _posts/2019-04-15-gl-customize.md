---
layout: page
title: "Customize"
category: greenlight
date: 2019-04-16 16:29:25
---

# Customizing Greenlight

You can run Greenlight outside of Docker, which also makes it easy to customize Greenlight (such as changing the landing page).

## Running Greenlight as a Rails application

To run Greenlight without Docker requires having server with ruby on rails installed, checking out the source code, and running Greenlight at the command line as a rails application.  We recommend using a [GitHub](https://github.com/) account to checkout the source for Greenlight.

1. [Install Ruby on Rails](https://gorails.com/setup/ubuntu/16.04) on your server (Note: You'll want to use Ruby v2.5.3).
1. Login to your GitHub account (via the web) and fork the [Greenlight repository](https://github.com/bigbluebutton/greenlight).
1. Login to your server (via SSH) clone the forked repository with the following command (replace `<GitHub_Username>` with your GitHub username):

   ~~~
   git clone https://github.com/<GitHub_Username>/greenlight.git
   ~~~

1. Next, enter the `greenlight` directory and copy the `sample.env` file to `.env` (this creates a default configuration file):

   ~~~
   cd greenlight
   cp sample.env .env
   ~~~
  
If you want to modify the default configuration file, such as enabling authentication using OAuth2, see [Configuring Greenlight 2.0](#configuring-green-light-20).  At a minimum you'll need to [Setup the BigBlueButton credentials](gl-install.html#setting-bigbluebutton-credentials).

With rails installed, Greenlight source checked out, and an `.env.` file created, you can now run Greenlight locally like any other rails application. To run Greenlight, use the following command:

~~~
bin/rails server --port=3000
~~~

You can test the application by loading the following URL in your browser: [http://localhost:3000](http://localhost:3000).

## Running Greenlight on a Docker container
To set up a docker container which can run a local version of Greenlight, there are two options.
To begin, start by [Installing Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/), and ensure you are on an administrative terminal.

### Setting up with Docker
1. Enter the `~/greenlight` directory
2. Run the following command to set up the environment:
  `cp sample.env .env`


3. Create a docker image by running the following (**image name** can be any name of your choosing):
  `docker build -t <image name> .`
  
4. Go to `docker-compose.yml` and edit the entry services->app->image so that it matches <image name>.


### Starting up using `docker compose`

This is the recommended way of running Greenlight with a docker image.
Start by [installing docker compose](https://docs.docker.com/compose/install/) if you haven’t installed it yet.

You can verify if you have docker compose installed by running:
`docker-compose -v`


1. Enter the `~/greenlight` directory
2. Run the following command to start the server:
    ```
    docker-compose up -d
    ```
3. Run the following command to take the server down:
    ```
    docker-compose down
    ```


### Starting up using `docker run`
1. Start the server by beginning a docker run (**name** can be any name of your choosing):
  ```
  docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name <name> <image name>
  ```


2. To stop and remove the docker container:
  ```
  docker stop Greenlight-v2
  docker rm Greenlight-v2
  ```

No matter which method you use to start the container, you should now be able to see the landing page through the endpoint [http://0.0.0.0/b/](http://0.0.0.0/b/)


## Updating Docker with code changes

For each code change, you will have to rebuild the docker image.
To do this, enter the following commands:

    docker image rm <image name>
    docker build -t <image name> .




# Applying `.env` Changes

After you edit the `.env` file, you are required to restart Greenlight in order for it to pick up the changes. Ensure you are in the Greenlight directory when restarting Greenlight.

## If you ran Greenlight using `docker-compose`

Bring down Greenlight using:

```
docker-compose down
```

then, bring it back up.

```
docker-compose up -d
```

## If you ran Greenlight using `docker run`

Stop and remove the Greenlight container using:

```
docker stop Greenlight-v2
docker rm Greenlight-v2
```

bring back up Greenlight using:

```
docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name Greenlight-v2 bigbluebutton/greenlight:v2
```

# Configuring Greenlight 2.0

Greenlight is a highly configurable application. The various configuration options can be found below. When making a changes to the `.env` file, in order for them to take effect you must restart you Greenlight container. For information on how to do this, see [Applying `.env` Changes](#applying-env-changes).

## User Authentication

Greenlight supports three types of user authentication. You can configure any number of these, and Greenlight will dynamically adjust to which ones are configured.

### In Application (Greenlight)

Greenlight has the ability to create accounts on its own. Users can sign up with their name, email and password and use Greenlight's full functionality.

By default, the ability for anyone to create a Greenlight account is enabled. To disable this, set the `ALLOW_Greenlight_ACCOUNTS` option in your `.env` file to false. This will **not** delete existing Greenlight accounts, but will prevent new ones from being created.

### Google OAuth2

You can use your own Google account, but since Greenlight will use this account for sending out emails, you may want to create a Google account related to the hostname of your BigBlueButton server.  For example, if your BigBlueButton server is called `example.myserver.com`, you may want to create a Google account called `Greenlight_notifications_myserver`.

You need a Google account to create an OAuth 2 `CLIENT_ID` and `SECRET`.  The will enable users of Greenlight to authenticate with their own Google account (not yours).

Login to your Google account, and click the following link

  [https://console.developers.google.com/](https://console.developers.google.com/)

If you want to see the documentation behind OAuth2 at Google, click the link [https://developers.google.com/identity/protocols/OAuth2](https://developers.google.com/identity/protocols/OAuth2).

![Greenlight-google-plus-api](/images/gl-google-plus-api.png)

First, enable the "Google+ API".

   1. Click Dashboard
   1. Click "+Enable APIs"
   1. Click "Google+ API"
   1. Click "Enable"
   1. Click "Credentials"

 Next,

  1. Click "Create credentials
  1. Select "OAuth client ID
  1. Select "Web application"
  1. Under "Authorized redirect URIs" enter "http://hostname/b/auth/google/callback" where hostname is your hostname
  1. Click "Create"

A window should open with your OAuth credentials. In this window, copy client ID and client secret to the `.env` file so it resembles the following (your credentials will be different).

~~~
GOOGLE_OAUTH2_ID=1093993040802-jjs03khpdl4dfasffq7hj6ansct5.apps.googleusercontent.com
GOOGLE_OAUTH2_SECRET=KLlBNy_b9pvBGasf7d5Wrcq
~~~

The `GOOGLE_OAUTH2_HD` environment variable is optional and can be used to restrict Google authentication to a specific Google Apps hosted domain.

~~~
GOOGLE_OAUTH2_HD=example.com
~~~

### Twitter OAuth2

You need a Twitter account to create an OAuth 2 client ID and client secret. The will enable users of Greenlight to authenticate with their own Twitter account (not yours).

Login to your Twitter account, and click the following link: [https://apps.twitter.com/](https://apps.twitter.com/).

Next,

  1. Click "Create New App"
  1. Under "Callback URL" enter "http://hostname/b/auth/twitter/callback" where hostname is your hostname
  1. Click "Create your Twitter application"
  1. Click "Keys and Access Tokens" tab

You should see a key and secret.  Add the `Consumer Key (API Key)` (not the OwnerID) and `Consumer Secret (API Secret)` to the `.env` file (your values will be different).

~~~
TWITTER_ID=SOj8AkIdeqJuP2asfbbGSBk0
TWITTER_SECRET=elxXJZqPVexBFf9ZJsafd4UTSzpr5AVmcH7Si5JzeHQ9th
~~~

### Office365 OAuth2

You will need an Office365 account to create an OAuth 2 key and secret. This will allow Greenlight users to authenticate with their own Office365 accounts.

To begin, head over to the following site and sign in to your Office365 account:
[https://developer.microsoft.com/en-us/graph](https://developer.microsoft.com/en-us/graph)

Click on the tab that says “My Apps” and you should get redirected to the applications portal:

![](https://d2mxuefqeaa7sj.cloudfront.net/s_862F4C65DCBBF32F66208EA7FF25C153F80CC5FED653F7FCC2E693F7C7577A33_1539186511422_image.png)

From here take the following steps:

1. Click “Add an app”
1. Choose any application name e.g “bbb-endpoint” and click “Create”
1. Under the “Profile Header”, add the url (**must be https**): [](http://hostname/b/auth/microsoft_office365/callback)       “https://hostname/b/auth/microsoft_office365/callback"
  ![](https://d2mxuefqeaa7sj.cloudfront.net/s_862F4C65DCBBF32F66208EA7FF25C153F80CC5FED653F7FCC2E693F7C7577A33_1539200454484_image.png)

1. Under “Platforms”, click “Add Platform”
    ![](https://d2mxuefqeaa7sj.cloudfront.net/s_862F4C65DCBBF32F66208EA7FF25C153F80CC5FED653F7FCC2E693F7C7577A33_1539200371889_image.png)

    Select the option to add a “Web” platform, check the option to “Allow Implicit Flow”, and add the Home page URL as a Redirect URL.

    ![](https://d2mxuefqeaa7sj.cloudfront.net/s_862F4C65DCBBF32F66208EA7FF25C153F80CC5FED653F7FCC2E693F7C7577A33_1539200628951_image.png)

1. Under “Application Secrets”, select the option to “Generate New Password”. 
    ![](https://d2mxuefqeaa7sj.cloudfront.net/s_862F4C65DCBBF32F66208EA7FF25C153F80CC5FED653F7FCC2E693F7C7577A33_1539200880946_image.png)

    This will correspond to the `OFFICE365_SECRET` environment variable.

    The Application Id can be found under “Properties”, and will correspond to the `OFFICE365_KEY` environment variable.

    ![](https://d2mxuefqeaa7sj.cloudfront.net/s_862F4C65DCBBF32F66208EA7FF25C153F80CC5FED653F7FCC2E693F7C7577A33_1539201241095_image.png)

    Copy both values into the `.env` file:

    ```
      OFFICE365_KEY=df99f6f6-2953-4f3c-b9a1-0b407c1373ba
      OFFICE365_SECRET=qenvRYWR5-}(vizOPR7926~
    ```

1. Save the Changes

### LDAP Auth

Greenlight is able to authenticate users using an external LDAP server. To connect Greenlight to an LDAP server, you will have to provide values for the environment variables under the 'LDAP Login Provider' section in the `.env` file. You need to provide all of the values for LDAP authentication to work correctly.

> `LDAP_SERVER` is the server host.

> `LDAP_PORT` is the server port (commonly 389).

> `LDAP_METHOD` is the authentication method, either 'plain' (default), 'ssl' or 'tls'.

> `LDAP_UID` is the name of the attribute that contains the user id. For example, OpenLDAP uses 'uid'.

> `LDAP_BASE` is the location to look up users.

> `LDAP_BIND_DN` is the default account to use for user lookup.

> `LDAP_PASSWORD` is the password for the account to perform user lookup.

Here are some example settings using an [OpenLDAP](http://www.openldap.org/) server.

~~~
LDAP_SERVER=host
LDAP_PORT=389
LDAP_METHOD=plain
LDAP_UID=uid
LDAP_BASE=dc=example,dc=org
LDAP_BIND_DN=cn=admin,dc=example,dc=org
LDAP_PASSWORD=password
~~~

If your server is still running you will need to recreate the container for changes to take effect.

See [Applying env Changes](#applying-env-changes) section to enable your new configuration.

If you are using an ActiveDirectory LDAP server, you must determine the name of your user id parameter to set `LDAP_UID`. It is commonly 'sAMAccountName' or 'UserPrincipalName'.

LDAP authentication takes precedence over all other providers. This means that if you have other providers configured with LDAP, clicking the login button will take you to the LDAP sign in page as opposed to presenting the general login modal.

## Using a Different Relative Root

By default Greenlight is deployed to the `/b` sub directory. If you are running Greenlight on a BigBlueButton server you must deploy Greenlight to a sub directory to avoid conflicts.

If you with to use a relative root other than `/b`, you can do the following:

1. Change the `RELATIVE_ROOT_URL` environment variable.
1. Update the `/etc/bigbluebutton/nginx/greenlight.nginx` file to reflect the new relative root.
1. Restart Nginx and the Greenlight server.

If you are **not** deploying Greenlight on a BigBlueButton server and want the application to run at root, simply set the `RELATIVE_ROOT_URL` to be blank.

## Setting a Custom Branding Image

See [these instructions](gl-admin.html#site-branding). 

## Adding Terms and Conditions

Greenlight allows you to add terms and conditions to the application. By adding a `terms.md` file to `app/config/` you will enable terms and conditions. This will display a terms and conditions page whenever a user signs up (or logs on without accepting yet). They are required to accept before they can continue to use Greenlight.

The `terms.md` file is a [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) file, so you can style your terms and conditions as you wish.

To add terms and conditions to your docker container, create a `terms.md` file in the `~/greenlight` directory. Then, add the following volume to your Greenlight run command.

`-v $(pwd)/terms.md:/usr/src/app/config/terms.md`

If you are running Greenlight using the `docker-compose.yml` file, add the following volume:

`- ./terms.md:/usr/src/app/config/terms.md`

# Customizing the Landing Page

A common customization is to modify the default landing page. For a simple change, let's rename the welcome banner to say “Welcome to MyServer”.

The welcome banner is generated by [index.html.erb](https://github.com/bigbluebutton/greenlight/blob/master/app/views/main/index.html.erb).  To customize this message, open `app/views/main/index.html.erb` in an editor.

~~~erb
<%
# BigBlueButton open source conferencing system - http://www.bigbluebutton.org/.
# Copyright (c) 2018 BigBlueButton Inc. and by respective authors (see below).
# This program is free software; you can redistribute it and/or modify it under the
# terms of the GNU Lesser General Public License as published by the Free Software
# Foundation; either version 3.0 of the License, or (at your option) any later
# version.
#
# BigBlueButton is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
# PARTICULAR PURPOSE. See the GNU Lesser General Public License for more details.
# You should have received a copy of the GNU Lesser General Public License along
# with BigBlueButton; if not, see <http://www.gnu.org/licenses/>.
%>

<% unless flash.empty? %>
  <%= render "shared/error_banner" do %>
    <% flash.each do |key, value| %>
      <%= content_tag :div, value, class: "flash #{key} d-inline" %>
    <% end %>
  <% end %>
<% end %>

<div class="background">
  <div class="container pt-9 pb-8">
    <div class="row">
      <div class="col-md-12 col-sm-12 text-center">
        <h1 id="main-text" class="display-4 mb-4"> <%= t("landing.welcome").html_safe %></h1>
        <p class="lead offset-lg-2 col-lg-8 col-sm-12 "><%= t("landing.about", href: link_to(t("Greenlight"), "https://bigbluebutton.org/2018/07/09/greenlight-2-0/", target: "_blank")).html_safe %></p>
        <%= link_to "https://youtu.be/Hso8yLzkqj8", target: "_blank" do %>
          <h4><%= t("landing.video") %> <i class="far fa-play-circle ml-1"></i></h4>
        <% end %>
      </div>

    </div>
  </div>
</div>

<%= render "shared/features" %>


<script>
var cycleImages = function(){
  var images = $('.img-cycle img');
  var now = images.filter(':visible');
  var next = now.next().length ? now.next() : images.first();
  var speed = 1500;
  now.fadeOut(speed);
  next.fadeIn(speed);
}
$(function() {
  setInterval(cycleImages, 5000);
});
</script>
~~~

This is an Embedded RuBy (ERB) file.   Look for the following line:

~~~html
<h1 id="main-text" class="display-4 mb-4"> <%= t("landing.welcome").html_safe %></h1>
~~~

The function `t("landing.welcome")` retrieves the localized version of the label `welcome.message`.  For English, this retrieves the string from [en.yml](https://github.com/bigbluebutton/greenlight/blob/master/config/locales/en.yml).  Edit `config/locales/en.yml` and look for the following section:

~~~yml
  landing:
    about: "%{href} is a simple front-end for your BigBlueButton open-source web conferencing server. You can create your own rooms to host sessions, or join others using a short and convenient link."
    welcome: Welcome to BigBlueButton.
    video: Watch our tutorial on using Greenlight
    upgrade: Show me how to upgrade to 2.0!
    version: We've released a new version of Greenlight, but your database isn't compatible.
~~~

To change the welcome message, modify the text associated with `landing.welcome` to say "Welcome to MyServer".

~~~yml
    welcome: Welcome to MyServer
~~~

Save the change to `en.yml`.  Refresh the landing page in your browser.  The welcome message should have the new text.

![Updated login](/images/greenlight/gl-welcome-to-my-server.png)


# Enabling Omniauth

To enable Omniauth, you will require a hostname that ends with a **top level domain** (e.g “.com”, “.ca”, etc).

To do this you can add a hostname to your computer which ends in a **top level domain**:

- [Adding hosts for linux](https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/)
- [Adding hosts for Windows](https://support.rackspace.com/how-to/modify-your-hosts-file/)
- [Adding hosts for Mac](https://www.tekrevue.com/tip/edit-hosts-file-mac-os-x/)

After properly adding the new hostname, run the following:

    bin/rails server --binding=<hostname>

You should see that the URL contains the hostname with the top level domain:

![](https://d2mxuefqeaa7sj.cloudfront.net/s_860B5671A1EBC17AA9B4E38FD1C99F6FBD35D15FD13FAFC83B3C452349A53D30_1538074544244_image.png)


Once everything works, you can [configure Omniauth](#user-authentication).

After configuring Omniauth, you should be able to gain full access to Omniauth signup:

![](https://d2mxuefqeaa7sj.cloudfront.net/s_860B5671A1EBC17AA9B4E38FD1C99F6FBD35D15FD13FAFC83B3C452349A53D30_1538074632840_image.png)

