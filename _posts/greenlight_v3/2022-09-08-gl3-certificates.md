---

layout: page
title: "Certificates"
category: greenlight_v3
date: 2022-09-08 16:27:25
order: 2

---

As mentioned in the [Generating SSL certificates](/greenlight_v3/gl3-install.html#generating-ssl-certificates) section of the greenlight v3 install chapter.
Greenlight in its third edition requires to be used through a secure connection via HTTPS.
That dependency may be hard to meet for some organizations that are willing to use the new version of Greenlight.
For that, we've introduced an automated script to simplify the automatic issuing of valid publicly signed and trusted SSL certificates for your system by Letsencrypt.
The deployment was designed to be responsible also for the auto renewal of Greenlight certificates.
However, some deployments may already been having certificates and willing to use it for Greenlight.
This chapter will document the details about SSL certificates on Greenlight v3 and our recommendation on how to meet your environment requirements.
## Prerequisites
Assuming that you're on `greenlight-run` directory and that you've followed the [Installation Steps](/greenlight_v3/gl3-install.html#installation-steps).
The deployment design expects that:
1. All of the certificates data is hosted on **./data/certbot/conf**.
2. For simplicity, there's one SSL certificate for all supported FQDNs and not one per each (a certificate can be a multi-domain (SAN) or a wildcard when having both of Greenlight and Keycloak).
3. The certificate full chain will be hosted on **./data/certbot/conf/live/$GL_HOSTNAME.$DOMAIN_NAME/fullchain.pem**.
4. The certificate private key will be hosted on **./data/certbot/conf/live/$GL_HOSTNAME.$DOMAIN_NAME/privkey.pem**.
5. The certificate file will be hosted on **./data/certbot/conf/live/$GL_HOSTNAME.$DOMAIN_NAME/cert.pem**.
6. The certificate files (**cert.pem**, **fullchain.pem** and **privkey.pem**) can be regular files or symbolic links that points to any file on the **./data/certbot/conf**.

So placing your certificate files in the expected location will enable you to use your custom certificates.
The `init-letencrypt.sh` script itself makes usage of this design and build upon it.
The rest of the sections of this chapter should give more direction and information for some common use cases.

---

## Deploying Custom Certificates
If you don't plan on using Letsencrypt then you'd need to align with the prerequisites.
When issuing the certificate make sure it supports both of Greenlight and Keycloak FQDNs (you can generate a standalone certificate for Greenlight only when followed the guides on [Removing Keycloak](/greenlight_v3/gl3-keycloak.html#removing-keycloak)).

We'd expect you to have a **fullchain.pem**, a **privkey.pem** and a **cert.pem** files that respectively represents the full chain, private key and certificate files.
The files need to be placed in **./data/certbot/conf/live/$GL_HOSTNAME.$DOMAIN_NAME/** directory.

For a `DOMAIN_NAME=xlab.bigbluebutton.org` and a `GL_HOSTNAME=gl`:
- The full chain file should be placed in **./data/certbot/conf/live/gl.xlab.bigbluebutton.org/fullchain.pem**.
- The private key file should be placed in **./data/certbot/conf/live/gl.xlab.bigbluebutton.org/privkey.pem**.
- The certificate file should be placed in **./data/certbot/conf/live/gl.xlab.bigbluebutton.org/cert.pem**.

Please note that the deployment auto renewal feature will not handle the expiry of your certificate and therefore you're required to handle that responsibility on your own.
To disable the renewal feature please go to [Renewing Certificates](#renewing-certificates).

---

## Renewing Certificates

By default, Greenlight has a **certbot** service that is responsible for automatically renewing Letsencrypt certificates hosted on **./data/certbot/conf**.

If you have generated your certificates with the `init-letsencrypt.sh` script or if you have copied the adequate Letsencrypt files to **./data/certbot/conf** this feature will further simplify the management of your certificates by handling the renewal process for you.

However, if you have not used Letsencrypt to issue the certificates or willing to disable this feature.

This section will help achieving that.

To disable the **certbot** service, please make sure to stop Greenlight services if running:

```bash
cd ~/greenlight-run
sudo docker compose down
```

And remove the following lines on **docker-compose.yaml**:

```yaml
  certbot:
    image: certbot/certbot
    container_name: certbot
    ...
    depends_on:
      - nginx
```

**Save** the changes.

Once finished, you can follow the rest of the [Installation Steps](/greenlight_v3/gl3-install.html#starting-greenlight).

---

