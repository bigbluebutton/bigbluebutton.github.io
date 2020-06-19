---
layout: page
title: "Configure"
category: scalelite
date: 2020-06-19 22:13:44
order: 3
---

This section outlines how you may further configure your Scalelite server as well as set up your frontends to talk to Scalelite.

## Configure your frontend to use Scalelite

To switch your frontend application to use Scalelite instead of a single BigBlueButton server, there are 2 changes that need to be made:

* The BigBlueButton server URL should be set to the URL of your Scalelite deployment http(s)://<scalelite-hostname>/bigbluebutton/
* The BigBlueButton shared secret should be set to the LOADBALANCER_SECRET value that you set in /etc/default/scalelite

## Further configuration

### Environment Variables

#### Required

* `URL_HOST`: The hostname that the application API endpoint is accessible from. Used to protect against DNS rebinding attacks. Should be left blank if deploying Scalelite behind a Network Loadbalancer.
* `SECRET_KEY_BASE`: A secret used internally by Rails. Should be unique per deployment. Generate with `bundle exec rake secret` or `openssl rand -hex 64`.
* `LOADBALANCER_SECRET`: The shared secret that applications will use when calling BigBlueButton APIs on the load balancer. Generate with `openssl rand -hex 32`
* `DATABASE_URL`: URL for connecting to the PostgreSQL database, see the [Rails documentation](https://guides.rubyonrails.org/configuring.html#configuring-a-database). The URL should be in the form of `postgresql://username:password@connection_url`. Note that instead of using this environment variable, you can configure the database server in `config/database.yml`.
* `REDIS_URL`: URL for connecting to the Redis server, see the [Redis gem documentation](https://rubydoc.info/github/redis/redis-rb/master/Redis#initialize-instance_method). The URL should be in the form of `redis://username:password@connection_url`. Note that instead of using this environment variable, you can configure the redis server in `config/redis_store.yml` (see below).

#### Docker-Specific

These variables are used by the service startup scripts in the Docker images, but are not used if you are deploying the application in a different way.

* `NGINX_SSL`: Set this variable to "true" to enable the "nginx" image to listen on SSL. If you enable this, then you must bind mount the files `/etc/nginx/ssl/live/$URL_HOST/fullchain.pem` and `/etc/nginx/ssl/live/$URL_HOST/privkey.pem` (containing the certificate plus intermediates and the private key respectively) into the Docker image. Alternately, you can mount the entire `/etc/letsencrypt` directory from certbot to `/etc/nginx/ssl` instead.
* `BEHIND_PROXY`: Set to true if scalelite is behind a proxy or load balancer.
* `POLL_INTERVAL`: Used by the "poller" image to set the interval at which BigBlueButton servers are polled, in seconds. Defaults to 60.
* `RECORDING_IMPORT_POLL`: Whether or not to poll the recording spool directory for new recordings. Defaults to "true". If the recording poll directory is on a local filesystem where inotify works, you can set this to "false" to reduce CPU overhead.
* `RECORDING_IMPORT_POLL_INTERVAL`: How often to check the recording spool directory for new recordings, in seconds (when running in poll mode). Defaults to 60.

#### Optional

* `PORT`: Set the TCP port number to listen on. Defaults to 3000.
* `BIND`: Instead of setting a port, you can set a URL to bind to. This allows using a Unix socket. See [The Puma documentation](https://puma.io/puma/Puma/DSL.html#bind-instance_method) for details.
* `INTERVAL`: Adjust the polling interval (in seconds) for updating server statistics and meeting status. Defaults to 60. Only used by the "poll" task.
* `WEB_CONCURRENCY`: The number of processes for the puma web server to fork. A reasonable value is 2 per CPU thread or 1 per 256MB ram, whichever is lower.
* `RAILS_MAX_THREADS`: The number of threads to run in the Rails process. The number of Redis connections in the pool defaults to match this value. The default is 5, a reasonable value for production.
* `RAILS_ENV`: Either `development`, `test`, or `production`. The Docker image defaults to `production`. Rails defaults to `development`.
* `BUILD_NUMBER`: An additional build version to report in the BigBlueButton top-level API endpoint. The Docker image has this preset to a value determined at image build time.
* `RAILS_LOG_TO_STDOUT`: Log to STDOUT instead of a file. Recommended for deployments with a service manager (e.g. systemd) or in Docker. The Docker image sets this by default.
* `REDIS_POOL`: Configure the Redis connection pool size. Defaults to `RAILS_MAX_THREADS`.
* `MAX_MEETING_DURATION`: The maximum length of any meeting created on any server. If the `duration` is passed as part of the create call, it will only be overwritten if it is greater than `MAX_MEETING_DURATION`.
* `RECORDING_SPOOL_DIR`: Directory where transferred recording files are placed. Defaults to `/var/bigbluebutton/spool`
* `RECORDING_WORK_DIR`: Directory where temporary files from recording transfer/import are extracted. Defaults to `/var/bigbluebutton/recording/scalelite`
* `RECORDING_PUBLISH_DIR`: Directory where published recording files are placed to make them available to the web server. Defaults to `/var/bigbluebutton/published`
* `RECORDING_UNPUBLISH_DIR`: Directory where unpublished recording files are placed to make them unavailable to the web server. Defaults to `/var/bigbluebutton/unpublished`
* `SERVER_HEALTHY_THRESHOLD`: The number of times an offline server needs to responds successfully for it to be considered online. Defaults to **1**. If you increase this number, you should decrease `POLL_INTERVAL`
* `SERVER_UNHEALTHY_THRESHOLD`: The number of times an online server needs to responds unsuccessfully for it to be considered offline. Defaults to **2**. If you increase this number, you should decrease `POLL_INTERVAL`

### Redis Connection (`config/redis_store.yml`)

For a deployment using docker, you should configure the Redis Connection using the `REDIS_URL` environment variable instead, see above.

The `config/redis_store.yml` allows specifying per-environment configuration for the Redis server.
The file is similar in structure to the `config/database.yml` file used by ActiveRecord.
By default, a minimal configuration is shipped which will connect to a Redis server on localhost in development, and use "fakeredis" (an in-memory Redis emulator) to run tests without requiring a Redis server.
The default production configuration allows specifying the Redis server connection to use via an environment variable, see below.
You may use this configuration file to set any of the options listed in the [Redis initializer](https://rubydoc.info/github/redis/redis-rb/master/Redis#initialize-instance_method).
Additionally, these options can be set:

* `pool`: The number of connections in the pool (should match number of threads). Defaults to `RAILS_MAX_THREADS` environment variable, otherwise 5.
* `pool_timeout`: Amount of time (seconds) to wait if all connections in the pool are in use. Defaults to 5.
* `namespace`: An optional prefix to apply to all keys stored in Redis.