---
layout: page
title: "BigBlueButton Install Script"
date: 2018-02-15 17:44:54
---

This BigBlueButton install script will install BigBlueButton 2.0-beta (referred hereafter as simply BigBlueButton) on a server that meets the required pre-requisits (see below).

This script performs the same steps as outlined in the [install documentation](http://docs.bigbluebutton.org/install/install.html).  We (the core developers) created this script to make it easy for us to test builds of BigBlueButton.  

# Prerequeisits

You need to run this command on a Ubuntu 16.04 64-bit serverthat meets the [minimal requirements](http://docs.bigbluebutton.org/install/install.html#minimum-server-requirements) outlined in the install documentation.  If the server is behind a firewall, you'll need to do the additional steps outlined in [configuring your firewall](http://docs.bigbluebutton.org/install/install.html#configure-the-firewall-if-required).

Also, if you have setup your server with a fully qualified domain name (FQDN), then you can have the BigBlueButton install script take advantage of Lets Encrypt to install a secure socket layers (SSL) certificate (recommended) on your server.  Doing this will serve all web content via HTTPS.

The install script supports installation of BigBlueButton following iany of these combintaions
  * Installation with only IP address (if you do this, use FireFox for WebRTC audio as Chrome will not work without HTTPS)
  * Installtion with a FQDN
  * Installtion of the latest developer build of the HTML5 client
  * Installtion of GreenLight

## Usage

To install BigBlueButton on a server with a public IP address (not behind NAT), do the following

~~~
wget -qO- https://ubuntu.bigbluebutton.org/bbb-install.sh | bash -s -- -v xenial-200
~~~

That's it.  After about 10 minutes (depending on the server's network connection and speed of downloading packages), you'll have the latest build of BigBlueButton running on your server.  You'll see a messge at the end saying you can run the API demos using the server's IP address.

~~~
** Potential problems described below **

......
# Warning: The API demos are installed and accessible from:
#
#    http://xxx.xxx.xxx.xxx/demo/demo1.jsp
#
# These API demos allow anyone to access your server without authentication
# to create/manage meetings and recordings. They are for testing purposes only.
# If you are running a production system, remove them by running:
#
#    sudo apt-get purge bbb-demo
~~~

If you want to remove the API demos, do the command

~~~
sudo apt-get purge bbb-demo
~~~

If you want to use this server with a front-end, such as Moodle, you can get the server's URL and shared secret with the command `sudo bbb-conf --secret`.

~~~
# bbb-conf --secret

       URL: http://xxx.xxx.xxx.xxx4/bigbluebutton/
    Secret: fd17e1d5744a903769459b90ba633761

      Link to the API-Mate:
      http://mconf.github.io/api-mate/#server=http://xxx.xxx.xxx.xxx/bigbluebutton/&sharedSecret=fd17e1d5744a903769459b90ba633761
~~~

Later on, if you want to update your server with newer packages, simply run the above command again (it always installs the latest version).

While it's quick to test with an IP address, you really want to have the server configured with a SSL certificate.  To do this, 

  * Setup a FQDN to resolve to the IP address of your server
  * Have a valid e-mail address to receive updates from Let's Encrypt

Let's say you configure your server with the FQDN `bbb.my-server.com`.  That is, this domain name resolves to the external IP address of your server.  You also have the e-mail address `info@my-server.com`.

With the above two pieces of informaiton, you can configure your BigBlueButton server with an SSL certificate by using the following command.

~~~
wget -qO- https://ubuntu.bigbluebutton.org/bbb-install.sh | bash -s -- -v xenial-200 -s bbb.my-server.com -e info@my-server.com
~~~

You can then access GreenLight via the hostname of the server `https://bbb.my-server.com/`.

This script will also install a cron job to automatically renew the certifcate so it doesn't expire.

Later on, you want try out the latest developer build of the HTML5 client.  To do this, run 

~~~
wget -qO- https://ubuntu.bigbluebutton.org/bbb-install.sh | bash -s -- -v xenial-200 -t
~~~

After it is installed, you can use an Android or iOS (iOS 11+) device and access your BigBlueButton server at `https://bbb.my-server.com/demo/demo1.jsp`

Also, you may want to install GreenLight (GreenLight needs SSL installed).

~~~
wget -qO- https://ubuntu.bigbluebutton.org/bbb-install.sh | bash -s -- -v xenial-200 -g
~~~

Lastly, using the FQDN and e-mail address in this example, you can install BigBlueButton, configure it with a SSL certificate, install Greenlight, and install the latest developer build of the HTML5 client on a new server that has a valid FQDN with a single command:

~~~
wget -qO- https://ubuntu.bigbluebutton.org/bbb-install.sh | bash -s -- -v xenial-200 -s bbb.my-server.com -e info@my-server.com -t -g
~~~

# Limitations

This script has the following limitations:

  * It will not configure your firewall 
  * You can not (currently) launch the HTML5 client from GreenLight

