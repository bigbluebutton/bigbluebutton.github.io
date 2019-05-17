---
layout: page
title: "Install"
category: greenlight
date: 2019-04-16 16:29:25
# redirect_from: "/install/Green Light.html"
---

# Installing on a BigBlueButton Server

To make Green Light as easy to install as possible, we've created a Docker image that wraps the application. It is **highly** recommended that you use Docker when install Green Light on a BigBlueButton server. You can install Green Light without Docker (see [Green Light without Docker](gl-customize.html#customizing-green-light)).

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
mkdir ~/greenlight && cd ~/greenlight
```

Green Light will read its environment configuration from the `.env` file. To generate this file and install the Green Light Docker image, run:

```
docker run --rm bigbluebutton/greenlight:v2 cat ./sample.env > .env
```

## 3. Configure Green Light

If you open the `.env` file you'll see that it contains information for all of the Green Light configuration options. Some of these are mandatory.

When you installed in step two, the `.env` file was generated at `~/greenlight/.env`.

### Generating a Secret Key

Green Light needs a secret key in order to run in production. To generate this, run:

```
docker run --rm bigbluebutton/greenlight:v2 bundle exec rake secret
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
docker run --rm --env-file .env bigbluebutton/greenlight:v2 bundle exec rake conf:check
```

If you have configured an SMTP server in your `.env` file, then all four tests must pass before you proceed. If you have not configured an SMTP server, then only the first three tests must pass before you proceed.

## 4. Configure Nginx to Route To Green Light

Green Light will be configured to deploy at the `/b` subdirectory. This is necessary so it doesn't conflict with the other BigBlueButton components. The Nginx configuration for this subdirectory is stored in the Green Light image. To add this configuration file to your BigBlueButton server, run:

```
docker run --rm bigbluebutton/greenlight:v2 cat ./greenlight.nginx | sudo tee /etc/bigbluebutton/nginx/greenlight.nginx
```

Verify that the Nginx configuration file (`/etc/bigbluebutton/nginx/greenlight.nginx`) is in place. If it is, restart Nginx so it picks up the new configuration.

```
systemctl restart nginx
```

This will routes all requests to `https://<hostname>/b` to the Green Light application. If you wish to use a different relative root, you can follow the steps outlined [here](gl-customize.html#using-a-different-relative-root).

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

Next, you should copy the `docker-compose.yml` file from the Green Light image in to `~/greenlight` directory. To do this, run:

```
docker run --rm bigbluebutton/greenlight:v2 cat ./docker-compose.yml > docker-compose.yml
```

Once you have this file, from the `~/greenlight` directory, start the application using:

```
docker-compose up -d
```

This will start Green Light, and you should be able to access it at `https://<hostname>/b`.

The database is saved to the BigBlueButton server so data persists when you restart. This can be found at `~/greenlight/db`.

All of the logs from the application are also saved to the BigBlueButton server, which can be found at `~/greenlight/logs`.

If you don't wish for either of these to persist, simply remove the volumes from the `docker-compose.yml` file.

To stop the application, run:

```
docker-compose down
```

### Using `docker run`

To run Green Light using `docker run`, from the `~/greenlight` directory, run the following command:

```
docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name Green Light-v2 bigbluebutton/greenlight:v2
```

The database is saved to the BigBlueButton server so data persists when you restart. This can be found at `~/greenlight/db`.

If you wish to extract the logs from the docker container and save them to the BigBlueButton server, add `-v $(pwd)/log:/usr/src/app/log` to the `docker run` command.

Then when you want to stop the docker container, run:

```
docker stop Green Light-v2
```


# Updating Green Light

To update Green Light, all you need to do is pull the latest image from [Dockerhub](https://hub.docker.com/).

```
docker pull bigbluebutton/greenlight:v2
```

Then, [restart Green Light](gl-customize.html#applying-env-changes).

# Troubleshooting Green Light

Sometimes there are missteps and incompatibility issues when setting up applications.

## Checking the Logs

The best way for determining the root cause of issues in your Green Light application is to check the logs.

### If you’re running Ruby on Rails
The logs should be located under `app/log`from the `~/greenlight` directory.

Depending on whether you are running on development or production, you may need to check either:

1. `app/log/development.log`
2. `app/log/production.log`

### If you’re running with Docker
Docker is always running on a production environment, so the logs will be located in `log/production.log` from the `~/greenlight` directory.

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


# Green Light 1.0

## Upgrading from Green Light 1.0

If you have [Green Light 1.0](/greenlight-v1.html) installed on a BigBlueButton server, you don't have to do a complete new install to install Green Light 2.0, although you can if you'd like.

Before upgrading, keep in mind that [you cannot move over your data from Green Light 1.0 to 2.0](#can-i-copy-over-my-old-green-light-data). If you aren't okay with losing this data, do **not** upgrade.

To upgrade to Green Light 2.0 from Green Light 1.0, complete the following steps.

### 1. Setup the 2.0 Environment

Copy the Green Light 2.0 sample environment into your .env file. If you want to save your Green Light 1.0 settings, make a copy of the `.env` file first. This will also pull the Green Light 2.0 image.
```
cd ~/greenlight
docker run --rm bigbluebutton/greenlight:v2 cat ./sample.env > .env
```

Then follow the steps to [configure Green Light](#3-configure-Green Light).

### 2. Remove the Existing Database

Backup your existing database, which is stored at `~/greenlight/db/production/production.sqlite3`.

Then, remove the database directory (`~/greenlight/db`). When you first start Green Light 2.0, it will generate a new database.

```
rm -rf db/
```

### 3. Start Green Light 2.0

Choose to [start Green Light 2.0](#5-start-Green Light-20) with either `docker-compose` or `docker run`.

## Remaining on Green Light 1.0

If you have Green Light 1.0, you may pull the Green Light 2.0 Docker image when updating. If you do, you'll see a page similar to this:

![Green Light Migration Error](/images/greenlight/gl_migration_error.png)

To continue to use Green Light 1.0, all you need to do is to explicitly specify version 1.0 in the run command. You can do this like so:

```
docker run --restart unless-stopped -d -p 5000:80 -v $(pwd)/db/production:/usr/src/app/db/production --env-file .env --name Green Light bigbluebutton/greenlight:v1
```

This will force Green Light to use version 1.0. For any other Docker commands relating to the image, make sure you specify the `v1` tag.

## Looking for the old Green Light 1.0 docs?

The old version of Green Light has been renamed to Green Light Legacy. It is still available on GitHub under the [v1 branch](https://github.com/bigbluebutton/greenlight/tree/v1), although we highly suggest using the latest version of Green Light.

You can find the old documentation for Green Light 1.0 [here](/greenlight-v1.html).

## Can I copy over my old Green Light data?

Green Light Legacy uses a much different database schema than that of the current version, so for this reason, it is **not** possible to copy over the data directly.

However, Green Light does allow administrators to seed accounts. In theory, you could seed new accounts based off the data in your existing Green Light database, but some data may be lost.
