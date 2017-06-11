---
layout: default
title: "Docker"
---

# BigBlueButton in Docker

This document describes how to run BigBlueButton 2.0-dev (or later) using Docker.  

Given a Docker container for BigBlueButton, anyone with an operating system capable of running Docker, such as Mac OS X or Windows 10, can run a BigBlueButton server with a single `docker run` command.  This should expand the interest in trying out BigBlueButton as well as enable developers to experiment with different builds of BigBlueButton and easily start/restart them for development/testing.

By design, Docker creates an isolated runtime environment that limits an application's ability to access host resources, such as files, network, and privileged commands.  In designing the Docker image for BigBlueButton, the goal was to open just enough permissions to run BigBlueButton.  This keeps BigBlueButton isolated from the host computer and minimized resource conflicts.

Running BigBlueButton in Docker has the following limitations: 

  * Nginx does not have a SSL certificate, so you'll need to use FireFox to use WebRTC audio
  * Due to the overhead of mapping ports from the host to the container's network, the default UDP port range for WebRTC is 38 ports (but this is configurable)
  * Processes are started using `supervisord` (instead of `systemd`)
  * HTML5 client is not installed (we'll do this once it's working with 2.0-dev)

Our goal is to have an official BigBlueButton Docker container hosted at Docker Hub once we release BigBlueButton 2.0-beta. 


# Getting Started

First, install [Docker](https://docs.docker.com/engine/installation/) on your computer.   Next, checkout the source files from [BigBlueButton Docker](https://github.com/bigbluebutton/docker) (contact us if you don't have permission to access this repository).

If you have a local `apt-get` caching server (such as using `apt-cacher-ng`), then in the Docker uncomment the line

~~~
# RUN echo 'Acquire::http::Proxy "http://192.168.0.130:3142";'  > /etc/apt/apt.conf.d/01proxy
~~~

and replace `192.168.0.130` with the IP address/hostname of your `apt-get` caching server.  Doing this will speed up repeated builds of the Docker container.

## Build the Docker image


and give it the value of your proxy.  Next, build the BigBlueButton docker image

~~~
docker build -t bigbluebutton/docker .
~~~

After Docker has finished building the BigBlueButton image, you can check it using the `docker images` command.

~~~
$ docker images
REPOSITORY                TAG      IMAGE ID         CREATED             SIZE
bigbluebutton/docker      latest   ca5ab0317d11     18 hours ago        2.68 GB
~~~


## Run BigBlueButton in Docker

To run BigBlueButton in Docker, use the following command and pass the IP address of your computer via the parameter `-h <HOSTIP>`.  Here we are running BigBlueButton on the host with IP address `192.168.0.130`.

~~~
docker run -p 80:80/tcp -p 1935:1935/tcp -p 5066:5066/tcp -p 32730-32768:32730-32768/udp --cap-add=NET_ADMIN bigbluebutton/docker -h 192.168.0.130
~~~

The parameter `--cap-add=NET_ADMIN` gives the `startup.sh` script the ability to setup a dummy network interface card (NIC) to enable FreeSWITCH to bind to the host's IP address for receiving the RTP stream for a WebRTC audio connection.  

BigBlueButton takes about 10 seconds to startup.  After that, you can login with FireFox using `http://<HOSTIP>` and launch BigBlueButton.

![Install](/images/docker.png)

The Docker image installs the package `bbb-demo` so all the API demos are available.

# Administration

## Login to the container

You can directly login to the running container. First, determine the name of the container (Docker randomly assigns a name)

~~~
$ docker ps
CONTAINER ID        IMAGE                COMMAND                  CREATED             STATUS              PORTS                                                                              NAMES
4dd41ad9bba0        bigbluebutton/docker  "/root/setup.sh -h..."  53 seconds ago      Up 52 seconds       0.0.0.0:80->80/tcp, 0.0.0.0:1935->1935/tcp, 0.0.0.0:32750-32768->32750-32768/udp   stupefied_keller
~~~

Here it's called `stupefied_keller`.  To login to this container, execute the command

~~~
$ docker exec -it stupefied_keller /bin/bash
root@4dd41ad9bba0:/# 
~~~

You can now view BigBlueButton's log files and restart BigBlueButton (see next section).

## Restart BigBlueButton

The container uses [supervisord](http://supervisord.org/) to start all the individual processes (A Docker container can not run `systemd` support in the Ubuntu 16.04 docker image).

To see the status of all the processes, login to the Docker container (see previous section) and enter the command
`supervisorctl status`.

~~~
# supervisorctl status
bbb-apps-akka                    RUNNING   pid 78, uptime 0:28:21
bbb-fsesl-akka                   RUNNING   pid 71, uptime 0:28:21
bbb-rap-publish-worker           FATAL     Exited too quickly (process log may have details)
freeswitch                       RUNNING   pid 82, uptime 0:28:21
libreoffice                      RUNNING   pid 85, uptime 0:28:21
nginx                            RUNNING   pid 77, uptime 0:28:21
rap-archive-worker               FATAL     Exited too quickly (process log may have details)
rap-process-worker               FATAL     Exited too quickly (process log may have details)
rap-sanity-worker                FATAL     Exited too quickly (process log may have details)
red5                             RUNNING   pid 69, uptime 0:28:21
redis-server                     EXITED    Jun 10 08:25 PM
tomcat7                          RUNNING   pid 76, uptime 0:28:21
~~~

The record and playback scripts are exiting as soon as they run.  This is the expected behaviour.  `supervisord` will simply run them again.

You can restart BigBlueButton using the command `supervisorctl restart all`

~~~
# supervisorctl restart all
nginx: stopped
libreoffice: stopped
bbb-apps-akka: stopped
bbb-fsesl-akka: stopped
tomcat7: stopped
red5: stopped
freeswitch: stopped
red5: started
bbb-fsesl-akka: started
tomcat7: started
nginx: started
bbb-apps-akka: started
freeswitch: started
redis-server: started
libreoffice: started
bbb-rap-publish-worker: ERROR (spawn error)
rap-sanity-worker: ERROR (spawn error)
rap-process-worker: ERROR (spawn error)
rap-archive-worker: ERROR (spawn error)
~~~

Again, you can ignore the `(spawn error)` for the record and playback scripts as they exit if there is not recording to process.

## Troubleshooting

### Windows 10 Pro automatically binds to port 80 

Have not yet figured out how to run BigBlueButton on Windows 10 pro as Windows seems to already have an application binding to port 80.

### The recordings are currently not displaying

It looks like the recordings are processed, but not published.  This appears to be a bug with BigBlueButton 2.0-dev.





