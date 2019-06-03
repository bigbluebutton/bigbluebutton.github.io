---
layout: page
title: "Customize"
category: greenlight
date: 2019-04-16 16:29:25
---

# Customizing Greenlight

Greenlight is written in Ruby on Rails.  If you know how Ruby on Rails works, you can easily customize Greenlight to your own needs.

The default install instructions will run Greenlight within docker.  To customize Greenlight, you'll want to checkout the source code and build your own docker image.

## 1. Install Docker

The official Docker documentation is the best resource for Docker install steps. To install Docker (we recommend installing Docker CE unless you have a subscription to Docker EE), see [Install Docker on Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntu/).

Before moving onto the next step, verify that Docker is installed by running:

```
docker -v
```

## 2. Install Greenlight

Using your GitHub account, do the following

1. [Fork](http://help.github.com/fork-a-repo/) the Greenlight repository into your GitHub account
2. Clone your repository onto your local machine

After cloning, you'll have the following directory:

```
~/greenlight
```

Confirm that you are working on the master branch.

```
cd greenlight
git status
```

You should see

```
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

When you first clone the Greenlight git repository, git will place you, by default, on the `master` branch, which is the latest code for Greenlight.  The release branch for v2 is on the `v2` branch.

The first thing we need to do is to add the remote repository to our local clone.

```
git remote add upstream https://github.com/bigbluebutton/greenlight.git
```

You can now check your local list of tracked repositories to verify that the addition worked. You should see at least two results (origin and upstream). The one named "origin" should link to your personal fork and is the repository that you cloned. The second result "upstream" should link to the main Greenlight repository.

```
git remote -v
```

After, we need to fetch the most up to date version of the remote repository.

```
git fetch upstream
```

You are now ready to create a new branch to start your work and base the new branch off v2

```
git checkout -b custom-changes upstream/v2
```

You should now confirm that you are in the correct branch.

```
git status

On branch custom-changes
Your branch is up to date with 'upstream/v2'.

nothing to commit, working tree clean
```

## 3. Configure Greenlight

Greenlight will read its environment configuration from the `.env` file. To generate this file, enter `~/greenlight` directory and run:

```
cp sample.env .env
```

If you open the `.env` file you'll see that it contains information for all of the Greenlight configuration options. Some of these are mandatory.

### Generating a Secret Key

Greenlight needs a secret key in order to run in production. To generate this, run:

```
bundle exec rake secret
```

Inside your `.env` file, set the `SECRET_KEY_BASE` option to this key. You don't need to surround it in quotations.

### Setting BigBlueButton Credentials

By default, your Greenlight instance will automatically connect to `test-install.blindsidenetworks.com` if no BigBlueButton credentials are specified. To set Greenlight to connect to your BigBlueButton server (the one it's installed on), you need to give Greenlight the endpoint and the secret. To get the credentials, run:

```
bbb-conf --secret
```

In your `.env` file, set the `BIGBLUEBUTTON_ENDPOINT` to the URL, and set `BIGBLUEBUTTON_SECRET` to the secret.

### Verifying Configuration

Once you have finished setting the environment variables above in your `.env` file, to verify that you configuration is valid, run:

```
bundle exec rake conf:check
```

If you have configured an SMTP server in your `.env` file, then all four tests must pass before you proceed. If you have not configured an SMTP server, then only the first three tests must pass before you proceed.

## 4. Configure Nginx to Route To Greenlight

Greenlight will be configured to deploy at the `/b` subdirectory. This is necessary so it doesn't conflict with the other BigBlueButton components. The Nginx configuration for this subdirectory is stored in the Greenlight image. To add this configuration file to your BigBlueButton server, run:

```
cat ./greenlight.nginx | sudo tee /etc/bigbluebutton/nginx/greenlight.nginx
```

Verify that the Nginx configuration file (`/etc/bigbluebutton/nginx/greenlight.nginx`) is in place. If it is, restart Nginx so it picks up the new configuration.

```
systemctl restart nginx
```

This will routes all requests to `https://<hostname>/b` to the Greenlight application. If you wish to use a different relative root, you can follow the steps outlined [here](gl-customize.html#using-a-different-relative-root).

Optionally, if you wish to have the default landing page at the root of your BigBlueButton server redirect to Greenlight, add the following entry to the bottom of `/etc/nginx/sites-available/bigbluebutton` just before the last `}` character.

```
location = / {
  return 307 /b;
}
```

To have this change take effect, you must once again restart Nginx.

## 5. Start Greenlight 2.0

To start the Greenlight Docker containter, you must install `docker-compose`, which simplifies the start and stop process for Docker containers.

Install `docker-compose` by following the steps for installing on Linux in the [Docker documentation](https://docs.docker.com/compose/install/). You may be required to run all `docker-compose` commands using sudo. If you wish to change this, check out [managing docker as a non-root user](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).


### Using `docker-compose`

Before you continue, verify that you have `docker-compose` installed by running:

```
docker-compose -v
```

Once you have verified that it is installed correctly, create your Docker image by running (**image name** can be any name of your choosing):

```
./scripts/image_build.sh <image name> release-v2
```

Next, in the `docker-compose.yml` file, replace:

```
services:
  app:
    entrypoint: [bin/start]
    image: bigbluebutton/greenlight:v2
```

With

```
services:
  app:
    entrypoint: [bin/start]
    image: <image name>:release-v2
```

Finally, from the `~/greenlight` directory, start the application using:

```
docker-compose up -d
```

This will start Greenlight, and you should be able to access it at `https://<hostname>/b`.

The database is saved to the BigBlueButton server so data persists when you restart. This can be found at `~/greenlight/db`.

All of the logs from the application are also saved to the BigBlueButton server, which can be found at `~/greenlight/log`.

If you don't wish for either of these to persist, simply remove the volumes from the `docker-compose.yml` file.

To stop the application, run:

```
docker-compose down
```

### Using `docker run`

`docker run` is no longer the recommended way to start Greenlight. Please use `docker-compose`.

If you are currently using `docker run` and want to switch to `docker-compose`, follow these [instructions](#switching-from-docker-run-to-docker-compose).

## Making Code Changes
Using the text editor/IDE of choice, you can edit any of the files in the directory. The majority of Greenlight's code lives in `~/greenlight/app`. 

You can see an example of how to customize the Landing Page [here](#customizing-the-landing-page).

To see your changes reflected in Greenlight, you will need to [restart Greenlight](#5-start-greenlight-20).

# Applying `.env` Changes

After you edit the `.env` file or make any change to the code, you are required to rebuild the Greenlight image in order for it to pick up the changes. Ensure you are in the Greenlight directory when restarting Greenlight. To do this, enter the following commands:

```
docker-compose down
docker image rm <image name>
./scripts/image_build.sh <image name> release-v2
docker-compose up -d
```


# Updating to the Latest Version of Greenlight
If a new version of Greenlight has been released, you'll need to fetch the most up to date version of the remote repository.
```
git fetch upstream
```

To merge the code:
```
git merge upstream/v2
```

Then, [restart Greenlight](#applying-env-changes).


# Switching from `docker run` to `docker-compose`
To switch from using `docker run` to start Greenlight, to using `docker-compose`, run the following commands:
```
docker stop <image name>
docker rm <image name>
```

And then follow the instructions for [Starting Greenlight](#5-start-greenlight-20) 

# Customizing the Landing Page

A common customization is to modify the default landing page. For a simple change, let's rename the welcome banner to say “Welcome to MyServer”.

The welcome banner is generated by [index.html.erb](https://github.com/bigbluebutton/greenlight/blob/master/app/views/main/index.html.erb).  To customize this message, open `app/views/main/index.html.erb` in an editor.

```erb
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

<div class="background">
  <div class="container pt-9 pb-8">
    <div class="row">
      <div class="col-md-12 col-sm-12 text-center">
        <h1 id="main-text" class="display-4 mb-4"> <%= t("landing.welcome").html_safe %></h1>
        <p class="lead offset-lg-2 col-lg-8 col-sm-12 "><%= t("landing.about", href: link_to(t("greenlight"), "https://bigbluebutton.org/2018/07/09/greenlight-2-0/", target: "_blank")).html_safe %></p>
        <%= link_to "https://youtu.be/Hso8yLzkqj8", target: "_blank" do %>
          <h4><%= t("landing.video") %> <i class="far fa-play-circle ml-1"></i></h4>
        <% end %>
      </div>

    </div>
  </div>
</div>

<%= render "shared/features" %>
```

This is an Embedded RuBy (ERB) file.   Look for the following line:

```erb
<h1 id="main-text" class="display-4 mb-4"> <%= t("landing.welcome").html_safe %></h1>
```

The function `t("landing.welcome")` retrieves the localized version of the label `landing.welcome`.  For English, this retrieves the string from [en.yml](https://github.com/bigbluebutton/greenlight/blob/master/config/locales/en.yml).  Edit `config/locales/en.yml` and look for the following section:

```yml
  landing:
    about: "%{href} is a simple front-end for your BigBlueButton open-source web conferencing server. You can create your own rooms to host sessions, or join others using a short and convenient link."
    welcome: Welcome to BigBlueButton.
    video: Watch our tutorial on using Greenlight
    upgrade: Show me how to upgrade to 2.0!
    version: We've released a new version of Greenlight, but your database isn't compatible.
```

To change the welcome message, modify the text associated with `landing.welcome` to say "Welcome to MyServer".

```yml
    welcome: Welcome to MyServer
```

Save the change to `en.yml`, and [restart Greenlight](#applying-env-changes).  The welcome message should have the new text.

![Updated login](/images/greenlight/gl-welcome-to-my-server.png)


# Configuring Greenlight 2.0

Greenlight is a highly configurable application. The various configuration options can be found below. When making a changes to the `.env` file, in order for them to take effect you must restart you Greenlight container. For information on how to do this, see [Applying `.env` Changes](#applying-env-changes).

## Using a Different Relative Root

By default Greenlight is deployed to the `/b` sub directory. If you are running Greenlight on a BigBlueButton server you must deploy Greenlight to a sub directory to avoid conflicts.

If you with to use a relative root other than `/b`, you can do the following:

1. Change the `RELATIVE_ROOT_URL` environment variable.
1. Update the `/etc/bigbluebutton/nginx/greenlight.nginx` file to reflect the new relative root.
1. Restart Nginx and the Greenlight server.

If you are **not** deploying Greenlight on a BigBlueButton server and want the application to run at root, simply set the `RELATIVE_ROOT_URL` to be blank.

## Setting a Custom Branding Image

You can now setup branding for Greenlight through its [Administrator Interface](gl-admin.html#site-branding). 

## Adding Terms and Conditions

Greenlight allows you to add terms and conditions to the application. By adding a `terms.md` file to `app/config/` you will enable terms and conditions. This will display a terms and conditions page whenever a user signs up (or logs on without accepting yet). They are required to accept before they can continue to use Greenlight.

The `terms.md` file is a [Markdown](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) file, so you can style your terms and conditions as you wish.

To add terms and conditions to your docker container, create a `terms.md` file in the `~/greenlight` directory. Then, add the following volume to your `docker-compose.yml` file.

`- ./terms.md:/usr/src/app/config/terms.md`

## User Authentication

Greenlight supports four types of user authentication. You can configure any number of these, and Greenlight will dynamically adjust to which ones are configured.

### In Application (Greenlight)

Greenlight has the ability to create accounts on its own. Users can sign up with their name, email and password and use Greenlight's full functionality.

By default, the ability for anyone to create a Greenlight account is enabled. To disable this, set the `ALLOW_GREENLIGHT_ACCOUNTS` option in your `.env` file to false. This will **not** delete existing Greenlight accounts, but will prevent new ones from being created.

### Google OAuth2

You can use your own Google account, but since Greenlight will use this account for sending out emails, you may want to create a Google account related to the hostname of your BigBlueButton server.  For example, if your BigBlueButton server is called `example.myserver.com`, you may want to create a Google account called `greenlight_notifications_myserver`.

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

```
GOOGLE_OAUTH2_ID=1093993040802-jjs03khpdl4dfasffq7hj6ansct5.apps.googleusercontent.com
GOOGLE_OAUTH2_SECRET=KLlBNy_b9pvBGasf7d5Wrcq
```

The `GOOGLE_OAUTH2_HD` environment variable is optional and can be used to restrict Google authentication to a specific Google Apps hosted domain.

```
GOOGLE_OAUTH2_HD=example.com
```

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

```
LDAP_SERVER=host
LDAP_PORT=389
LDAP_METHOD=plain
LDAP_UID=uid
LDAP_BASE=dc=example,dc=org
LDAP_BIND_DN=cn=admin,dc=example,dc=org
LDAP_PASSWORD=password
```

If your server is still running you will need to recreate the container for changes to take effect.

See [Applying `.env` Changes](#applying-env-changes) section to enable your new configuration.

If you are using an ActiveDirectory LDAP server, you must determine the name of your user id parameter to set `LDAP_UID`. It is commonly 'sAMAccountName' or 'UserPrincipalName'.

LDAP authentication takes precedence over all other providers. This means that if you have other providers configured with LDAP, clicking the login button will take you to the LDAP sign in page as opposed to presenting the general login modal.

# Troubleshooting Greenlight

Sometimes there are missteps and incompatibility issues when setting up applications.

## Changes not appearing

If you made changes to the `.env` file, you will need to [restart Greenlight](#applying-env-changes) to see the changes appear.

## Checking the Logs

The best way for determining the root cause of issues in your Greenlight application is to check the logs.

Docker is always running on a production environment, so the logs will be located in `log/production.log` from the `~/greenlight` directory.
