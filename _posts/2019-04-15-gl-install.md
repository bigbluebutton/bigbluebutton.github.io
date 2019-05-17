---
layout: page
title: "Install"
category: greenlight
date: 2019-04-16 16:29:25
# redirect_from: "/install/Green Light.html"
---

# Installing on a BigBlueButton Server

To make Green Light as easy to install as possible, we've created a Docker image that wraps the application. It is **highly** recommended that you use Docker when install Green Light on a BigBlueButton server. You can install Green Light without Docker (see [Green Light without Docker](#Green Light-without-docker)).

You should run all commands in this section as `root` on your BigBlueButton server.

## BigBlueButton Server Requirements

Before you install Green Light, you must have a BigBlueButton server to install it on. This server must:

* have a version of BigBlueButton 2.0 (or greater).
* have a fully qualified hostname.
* have a valid SSL certificate (HTTPS).

## 1. Install Docker

The official Docker documentation is the best resource for Docker install steps. To install Docker (we recommend installing Docker CE unless you have a subscription to Docker EE), see [Install Docker on Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/).

Before moving onto the next step, verify that Docker is installed by running:

```
docker -v
```

## 2. Install Green Light

First, create the Green Light directory for its configuration to live in.

```
mkdir ~/Green Light && cd ~/Green Light
```

Green Light will read its environment configuration from the `.env` file. To generate this file and install the Green Light Docker image, run:

```
docker run --rm bigbluebutton/Green Light:v2 cat ./sample.env > .env
```

## 3. Configure Green Light

If you open the `.env` file you'll see that it contains information for all of the Green Light configuration options. Some of these are mandatory.

When you installed in step two, the `.env` file was generated at `~/Green Light/.env`.

### Generating a Secret Key

Green Light needs a secret key in order to run in production. To generate this, run:

```
docker run --rm bigbluebutton/Green Light:v2 bundle exec rake secret
```

Inside your `.env` file, set the `SECRET_KEY_BASE` option to this key. You don't need to surround it in quotations.

### Setting BigBlueButton Credentials

By default, your Green Light instance will automatically connect to [test-install.blindsidenetworks.com](https://test-install.blindsidenetworks.com) if no BigBlueButton credentials are specified. To set Green Light to connect to your BigBlueButton server (the one it's installed on), you need to give Green Light the endpoint and the secret. To get the credentials, run:

```
bbb-conf --secret
```

In your `.env` file, set the `BIGBLUEBUTTON_ENDPOINT` to the URL, and set `BIGBLUEBUTTON_SECRET` to the secret.

### Verifying Configuration

Once you have finished setting the environment variables above in your `.env` file, to verify that you configuration is valid, run:

```
docker run --rm --env-file .env bigbluebutton/Green Light:v2 bundle exec rake conf:check
```

If you have configured an SMTP server in your `.env` file, then all four tests must pass before you proceed. If you have not configured an SMTP server, then only the first three tests must pass before you proceed.

## 4. Configure Nginx to Route To Green Light

Green Light will be configured to deploy at the `/b` subdirectory. This is necessary so it doesn't conflict with the other BigBlueButton components. The Nginx configuration for this subdirectory is stored in the Green Light image. To add this configuration file to your BigBlueButton server, run:

```
docker run --rm bigbluebutton/Green Light:v2 cat ./Green Light.nginx | sudo tee /etc/bigbluebutton/nginx/Green Light.nginx
```

Verify that the Nginx configuration file (`/etc/bigbluebutton/nginx/Green Light.nginx`) is in place. If it is, restart Nginx so it picks up the new configuration.

```
systemctl restart nginx
```

This will routes all requests to `https://<hostname>/b` to the Green Light application. If you wish to use a different relative root, you can follow the steps outlined [here](#using-a-different-relative-root).

Optionally, if you wish to have the default landing page at the root of your BigBlueButton server redirect to Green Light, add the following entry to the bottom of `/etc/nginx/sites-available/bigbluebutton` just before the last `}` character.

```
location = / {
  return 307 /b;
}
```

To have this change take effect, you must once again restart Nginx.

## 5. Start Green Light 2.0

There are two ways to start the Green Light docker container.
* using the `docker run` command.
* running the prebuilt `docker-compose` file.

We suggest using `docker-compose` because it is easy to manage and saves you remembering an extremely long command, but if you don't wish to install `docker-compose`, you can use `docker run`.

### Using `docker-compose`

Install `docker-compose` by following the steps for installing on Linux in the [Docker documentation](https://docs.docker.com/compose/install/). You may be required to run all `docker-compose` commands using sudo. If you wish to change this, check out [managing docker as a non-root user](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

Before you continue, verify that you have `docker-compose` installed by running:

```
docker-compose -v
```

Next, you should copy the `docker-compose.yml` file from the Green Light image in to `~/Green Light` directory. To do this, run:

```
docker run --rm bigbluebutton/Green Light:v2 cat ./docker-compose.yml > docker-compose.yml
```

Once you have this file, from the `~/Green Light` directory, start the application using:

```
docker-compose up -d
```

This will start Green Light, and you should be able to access it at `https://<hostname>/b`.

The database is saved to the BigBlueButton server so data persists when you restart. This can be found at `~/Green Light/db`.

All of the logs from the application are also saved to the BigBlueButton server, which can be found at `~/Green Light/logs`.

If you don't wish for either of these to persist, simply remove the volumes from the `docker-compose.yml` file.

To stop the application, run:

```
docker-compose down
```

### Using `docker run`

To run Green Light using `docker run`, from the `~/Green Light` directory, run the following command:

```
docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name Green Light-v2 bigbluebutton/Green Light:v2
```

The database is saved to the BigBlueButton server so data persists when you restart. This can be found at `~/Green Light/db`.

If you wish to extract the logs from the docker container and save them to the BigBlueButton server, add `-v $(pwd)/log:/usr/src/app/log` to the `docker run` command.

Then when you want to stop the docker container, run:

```
docker stop Green Light-v2
```

# Configuring Green Light 2.0

Green Light is a highly configurable application. The various configuration options can be found below. When making a changes to the `.env` file, in order for them to take effect you must restart you Green Light container. For information on how to do this, see [Applying `.env` Changes](#applying-env-changes).

## User Authentication

Green Light supports three types of user authentication. You can configure any number of these, and Green Light will dynamically adjust to which ones are configured.

### In Application (Green Light)

Green Light has the ability to create accounts on its own. Users can sign up with their name, email and password and use Green Light's full functionality.

By default, the ability for anyone to create a Green Light account is enabled. To disable this, set the `ALLOW_Green Light_ACCOUNTS` option in your `.env` file to false. This will **not** delete existing Green Light accounts, but will prevent new ones from being created.

### Google OAuth2

You can use your own Google account, but since Green Light will use this account for sending out emails, you may want to create a Google account related to the hostname of your BigBlueButton server.  For example, if your BigBlueButton server is called `example.myserver.com`, you may want to create a Google account called `Green Light_notifications_myserver`.

You need a Google account to create an OAuth 2 `CLIENT_ID` and `SECRET`.  The will enable users of Green Light to authenticate with their own Google account (not yours).

Login to your Google account, and click the following link

  [https://console.developers.google.com/](https://console.developers.google.com/)

If you want to see the documentation behind OAuth2 at Google, click the link [https://developers.google.com/identity/protocols/OAuth2](https://developers.google.com/identity/protocols/OAuth2).

![Green Light-google-plus-api](/images/gl-google-plus-api.png)

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

You need a Twitter account to create an OAuth 2 client ID and client secret. The will enable users of Green Light to authenticate with their own Twitter account (not yours).

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

You will need an Office365 account to create an OAuth 2 key and secret. This will allow Green Light users to authenticate with their own Office365 accounts.

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

Green Light is able to authenticate users using an external LDAP server. To connect Green Light to an LDAP server, you will have to provide values for the environment variables under the 'LDAP Login Provider' section in the `.env` file. You need to provide all of the values for LDAP authentication to work correctly.

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

By default Green Light is deployed to the `/b` sub directory. If you are running Green Light on a BigBlueButton server you must deploy Green Light to a sub directory to avoid conflicts.

If you with to use a relative root other than `/b`, you can do the following:

1. Change the `RELATIVE_ROOT_URL` environment variable.
1. Update the `/etc/bigbluebutton/nginx/Green Light.nginx` file to reflect the new relative root.
1. Restart Nginx and the Green Light server.

If you are **not** deploying Green Light on a BigBlueButton server and want the application to run at root, simply set the `RELATIVE_ROOT_URL` to be blank.

## Setting a Custom Branding Image

See [these instructions](#site-branding). 

## Adding Terms and Conditions

Green Light allows you to add terms and conditions to the application. By adding a `terms.md` file to `app/config/` you will enable terms and conditions. This will display a terms and conditions page whenever a user signs up (or logs on without accepting yet). They are required to accept before they can continue to use Green Light.

The `terms.md` file is a [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) file, so you can style your terms and conditions as you wish.

To add terms and conditions to your docker container, create a `terms.md` file in the `~/Green Light` directory. Then, add the following volume to your Green Light run command.

`-v $(pwd)/terms.md:/usr/src/app/config/terms.md`

If you are running Green Light using the `docker-compose.yml` file, add the following volume:

`- ./terms.md:/usr/src/app/config/terms.md`

# Upgrading from Green Light 1.0

If you have [Green Light 1.0](/Green Light-v1.html) installed on a BigBlueButton server, you don't have to do a complete new install to install Green Light 2.0, although you can if you'd like.

Before upgrading, keep in mind that [you cannot move over your data from Green Light 1.0 to 2.0](#can-i-copy-over-my-old-Green Light-data). If you aren't okay with losing this data, do **not** upgrade.

To upgrade to Green Light 2.0 from Green Light 1.0, complete the following steps.

## 1. Setup the 2.0 Environment

Copy the Green Light 2.0 sample environment into your .env file. If you want to save your Green Light 1.0 settings, make a copy of the `.env` file first. This will also pull the Green Light 2.0 image.
```
cd ~/Green Light
docker run --rm bigbluebutton/Green Light:v2 cat ./sample.env > .env
```

Then follow the steps to [configure Green Light](#3-configure-Green Light).

## 2. Remove the Existing Database

Backup your existing database, which is stored at `~/Green Light/db/production/production.sqlite3`.

Then, remove the database directory (`~/Green Light/db`). When you first start Green Light 2.0, it will generate a new database.

```
rm -rf db/
```

## 3. Start Green Light 2.0

Choose to [start Green Light 2.0](#5-start-Green Light-20) with either `docker-compose` or `docker run`.

# Remaining on Green Light 1.0

If you have Green Light 1.0, you may pull the Green Light 2.0 Docker image when updating. If you do, you'll see a page similar to this:

![Green Light Migration Error](/images/Greenlight/gl_migration_error.png)

To continue to use Green Light 1.0, all you need to do is to explicitly specify version 1.0 in the run command. You can do this like so:

```
docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name Green Light bigbluebutton/Green Light:v1
```

This will force Green Light to use version 1.0. For any other Docker commands relating to the image, make sure you specify the `v1` tag.

# Administration

## Applying `.env` Changes

After you edit the `.env` file, you are required to restart Green Light in order for it to pick up the changes. Ensure you are in the Green Light directory when restarting Green Light.

### If you ran Green Light using `docker-compose`

Bring down Green Light using:

```
docker-compose down
```

then, bring it back up.

```
docker-compose up -d
```

### If you ran Green Light using `docker run`

Stop and remove the Green Light container using:

```
docker stop Green Light-v2
docker rm Green Light-v2
```

bring back up Green Light using:

```
docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name Green Light-v2 bigbluebutton/Green Light:v2
```

## Updating Green Light

To update Green Light, all you need to do is pull the latest image from [Dockerhub](https://hub.docker.com/).

```
docker pull bigbluebutton/Green Light:v2
```

Then, [restart Green Light](#applying-env-changes).

# Looking for the old Green Light 1.0 docs?

The old version of Green Light has been renamed to Green Light Legacy. It is still available on GitHub under the [v1 branch](https://github.com/bigbluebutton/Green Light/tree/v1), although we highly suggest using the latest version of Green Light.

You can find the old documentation for Green Light 1.0 [here](/Green Light-v1.html).

# Can I copy over my old Green Light data?

Green Light Legacy uses a much different database schema than that of the current version, so for this reason, it is **not** possible to copy over the data directly.

However, Green Light does allow administrators to seed accounts. In theory, you could seed new accounts based off the data in your existing Green Light database, but some data may be lost.

# Customizing Green Light

You can run Green Light outside of Docker, which also makes it easy to customize Green Light (such as changing the landing page).

## Running Green Light as a Rails application

To run Green Light without Docker requires having server with ruby on rails installed, checking out the source code, and running Green Light at the command line as a rails application.  We recommend using a [GitHub](https://github.com/) account to checkout the source for Green Light.

1. [Install Ruby on Rails](https://gorails.com/setup/ubuntu/16.04) on your server (Note: Skip the step which has you install rvm, the built-in version of ruby works fine).
1. Login to your GitHub account (via the web) and fork the [Green Light repository](https://github.com/bigbluebutton/Green Light).
1. Login to your server (via SSH) clone the forked repository with the following command (replace `<GitHub_Username>` with your GitHub username):

   ~~~
   git clone https://github.com/<GitHub_Username>/Green Light.git
   ~~~

1. Next, enter the `Green Light` directory and copy the `sample.env` file to `.env` (this creates a default configuration file):

   ~~~
   cd Green Light
   cp sample.env .env
   ~~~
  
If you want to modify the default configuration file, such as enabling authentication using OAuth2, see [Configuring Green Light 2.0](#configuring-Green Light-20).  At a minimum you'll need to [Setup the BigBlueButton credentials](#setting-bigbluebutton-credentials).

With rails installed, Green Light source checked out, and an `.env.` file created, you can now run Green Light locally like any other rails application. To run Green Light, use the following command:

~~~
bin/rails server --port=3000
~~~

You can test the application by loading the following URL in your browser: [http://localhost:3000](http://localhost:3000).

## Running Green Light on a Docker container
To set up a docker container which can run a local version of Green Light, there are two options.
To begin, start by [Installing Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/), and ensure you are on an administrative terminal.

### Setting up with Docker
1. Enter the `~/Green Light` directory
2. Run the following command to set up the environment:
  `cp sample.env .env`


3. Create a docker image by running the following (**image name** can be any name of your choosing):
  `docker build -t <image name> .`
  
4. Go to `docker-compose.yml` and edit the entry services->app->image so that it matches <image name>.


### Starting up using `docker compose`

This is the recommended way of running Green Light with a docker image.
Start by [installing docker compose](https://docs.docker.com/compose/install/) if you haven’t installed it yet.

You can verify if you have docker compose installed by running:
`docker-compose -v`


1. Enter the `~/Green Light` directory
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
  docker stop Green Light-v2
  docker rm Green Light-v2
  ```

No matter which method you use to start the container, you should now be able to see the landing page through the endpoint [http://0.0.0.0/b/](http://0.0.0.0/b/)


## Updating Docker with code changes

For each code change, you will have to rebuild the docker image.
To do this, enter the following commands:

    docker image rm <image name>
    docker build -t <image name> .

## Customizing the Landing Page

A common customization is to modify the default landing page. For a simple change, let's rename the welcome banner to say “Welcome to MyServer”.

The welcome banner is generated by [index.html.erb](https://github.com/bigbluebutton/Green Light/blob/master/app/views/main/index.html.erb).  To customize this message, open `app/views/main/index.html.erb` in an editor.

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
        <p class="lead offset-lg-2 col-lg-8 col-sm-12 "><%= t("landing.about", href: link_to(t("Green Light"), "https://bigbluebutton.org/2018/07/09/Green Light-2-0/", target: "_blank")).html_safe %></p>
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

The function `t("landing.welcome")` retrieves the localized version of the label `welcome.message`.  For English, this retrieves the string from [en.yml](https://github.com/bigbluebutton/Green Light/blob/master/config/locales/en.yml).  Edit `config/locales/en.yml` and look for the following section:

~~~yml
  landing:
    about: "%{href} is a simple front-end for your BigBlueButton open-source web conferencing server. You can create your own rooms to host sessions, or join others using a short and convenient link."
    welcome: Welcome to BigBlueButton.
    video: Watch our tutorial on using Green Light
    upgrade: Show me how to upgrade to 2.0!
    version: We've released a new version of Green Light, but your database isn't compatible.
~~~

To change the welcome message, modify the text associated with `landing.welcome` to say "Welcome to MyServer".

~~~yml
    welcome: Welcome to MyServer
~~~

Save the change to `en.yml`.  Refresh the landing page in your browser.  The welcome message should have the new text.

![Updated login](/images/Greenlight/gl-welcome-to-my-server.png)


## Enabling Omniauth

To enable Omniauth, you will require a hostname that ends with a **top level domain** (e.g “.com”, “.ca”, etc).

To do this you can add a hostname to your computer which ends in a **top level domain**:

- [Adding hosts for linux](https://www.cyberciti.biz/faq/ubuntu-change-hostname-command/)
- [Adding hosts for Windows](https://support.rackspace.com/how-to/modify-your-hosts-file/)
- [Adding hosts for Mac](https://www.tekrevue.com/tip/edit-hosts-file-mac-os-x/)

After properly adding the new hostname, run the following:

    bin/rails server --binding=<hostname>

You should see that the URL contains the hostname with the top level domain:

![](https://d2mxuefqeaa7sj.cloudfront.net/s_860B5671A1EBC17AA9B4E38FD1C99F6FBD35D15FD13FAFC83B3C452349A53D30_1538074544244_image.png)


Once everything works, you can [configure Omniauth](http://docs.bigbluebutton.org/install/Green Light-v2.html#user-authentication).

After configuring Omniauth, you should be able to gain full access to Omniauth signup:

![](https://d2mxuefqeaa7sj.cloudfront.net/s_860B5671A1EBC17AA9B4E38FD1C99F6FBD35D15FD13FAFC83B3C452349A53D30_1538074632840_image.png)

# Troubleshooting Green Light

Sometimes there are missteps and incompatibility issues when setting up applications.

## Checking the Logs

The best way for determining the root cause of issues in your Green Light application is to check the logs.

### If you’re running Ruby on Rails
The logs should be located under `app/log`from the `~/Green Light` directory.

Depending on whether you are running on development or production, you may need to check either:

1. `app/log/development.log`
2. `app/log/production.log`

### If you’re running with Docker
Docker is always running on a production environment, so the logs will be located in `log/production.log` from the `~/Green Light` directory.

## Common issues with Running Ruby on Rails

### Address already in use
If you get an error similar to the following:

```
Address already in use - bind(2) for "0.0.0.0" port 3000 (Errno::EADDRINUSE)
```

Then you are trying to start a server on an endpoint that is already in use. If this scenario occurs, there are two solutions:



1. **Use another port.**


    By default, rails servers are always started using localhost and port 3000. If you receive this error statement, it means that you have a process that is currently using that port.


    In this case, you can get your server to start with a different port by running the following:
      ```
      bin/rails server -p <port number>
      ```


    A common port number that isn’t usually in use is **3001**.
    In this case, **the endpoint you use to access the server will also change.**


    For example, if you used to access [http://localhost:3000](http://localhost:3000) and change your new endpoint to 3001, you will need to access [http://localhost:3001](http://localhost:3001).


2. **Kill the existing process that is using the endpoint.**


    Before doing this, make sure that the process you are running isn’t important. Then you can run the following command to kill the server:
      ```
      kill -9 <PID>
      ```

### Development related issues
At this stage, there are no more problems with the “setup” of the app and further troubleshooting requires an understanding of Ruby on Rails.

[Follow this guide](https://guides.rubyonrails.org/debugging_rails_applications.html) to help learn common strategies for debugging Ruby on Rails applications. It will help in the long run!


## Common issues with Docker

### Changes not appearing
If you made changes to the code and are running a docker container from a docker image, you will need to **rebuild** the image to see changes appear.

In the case of environment related changes (modifying the `.env` file), you will only need to restart the container.

See also
  * [Overview](/greenlight/gl-overview.html)
  * [Admin Guide](/greenlight/gl-admin.html)
  * [Customize](/greenlight/gl-customize.html)

