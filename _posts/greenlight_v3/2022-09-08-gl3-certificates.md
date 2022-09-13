---

layout: page
title: "Certificates"
category: greenlight_v3
date: 2022-09-08 16:27:25
order: 2

---

## Creating Letsencrypt SSL certificates

***If you ALREADY have valid SSL certificates to your FQDNs or a wildcard certificate that you’re willing to use for your deployment please skip to [Custom Certificates](#custom-certificates).***

Now we have two public FQDNs that points to our system with the web ports opened for inbound traffic one for Greenlight and another for Keycloak.

Now we will run the `init-letsencrypt.sh` script which will automate the issuing of the certificates for our FQDNs:

```bash
sudo ./init-letsencrypt.sh
```

The script will load the environmental variables and  start requesting a certificate from Letsencrypt for each defined FQDN.

If there’s no issues you should be prompted that **Existing data found . Continue and replace existing certificate? (y/N).**

![Lets Encrpyt](/images/greenlight/v3/certificates/init-letsencrypt.png)

Do not worry, this is due to avoiding overwriting any existing certificates by re-running the script, since this is our first time you can overwrite the directory content by typing “**y”.**

After generating the certificates please be aware that accepting the replacement will replace previously created certificates .

After continuing, the script will download required TLS configurations and initiate the generation process for each FQDN.

![Lets Encrpyt](/images/greenlight/v3/certificates/init-letsencrypt-2.png)

Then the script will load required ACME challenges and ask you to complete the challenge by continuing:

![Lets Encrpyt](/images/greenlight/v3/certificates/init-letsencrypt-3.png)

At this step you may notice new files were loaded into your system under the **./data/certbot/www** directory those are the challenge files and it’s part of the process:

![Lets Encrpyt](/images/greenlight/v3/certificates/init-letsencrypt-4.png)

Just press **ENTER** to continue the challenge:

![Lets Encrpyt](/images/greenlight/v3/certificates/init-letsencrypt-5.png)

At this step you have successfully created a valid SSL certificate for your first FQDN.

You will be prompted to replay the same steps for the remaining FQDN.

***If you have removed Keycloak, you will not be prompted to generate a second certificate.***

The certificates files will be placed under **data/certbot/conf/live/** each in a directory named after their FQDN this is required for nginx to work.

In our example for a ***DOMAIN_NAME=xlab.bigbluebutton.org, GL_HOSTNAME=gl and KC_HOSTNAME=kc*** we would have two directories **data/certbot/conf/live/gl.xlab.bigbluebutton.org/** and **data/certbot/conf/live/kc.xlab.bigbluebutton.org/.**

***NOTE: Since you will have different FQDNs, you will have different directory names.
However, the directory names should match their FQDNs.***

You can verify that directories were created by listing them:

```bash
sudo ls -R data/certbot/conf/live
```

![Lets Encrpyt](/images/greenlight/v3/certificates/init-letsencrypt-6.png)

Both of the directories should exist and have their names fully matching the FQDNs otherwise **nginx will fail** due to trying loading inexistent files in the upcoming steps.

We have fully generated SSL certificates for our FQDNs, however - if haven’t changed the **LETSENCRYPT_STAGING** default value those will be staging certificates and not production ones.

***We enable staging by default to avoid reaching rate limits because of any encountered issues.***

To generate valid SSL certificates for the FQDNs after this successful test, kindly change the **LETSENCRYPT_STAGING** default value to **0** and re-run the script while replaying the same steps**.**

```bash
sed -i "s/LETSENCRYPT_STAGING**=1**/LETSENCRYPT_STAGING=0/" .env
sudo ./init-letsencrypt.sh
```

***NOTE:* Replacing existing *staging certificates is expected.***

We now need to update our nginx configuration file to open **HTTPS** traffic, you can do so manually by going to **./data/nginx/sites.template-*** files ****and uncommenting (Removing the **#** prefix on) all lines for the HTTPS binding and SSL certificate files locations.

Or, for your convenience you can run:

```bash
sed -i "/#listen.*/s/#//g" ./data/nginx/sites.template-*
sed -i "/#ssl_certificate.*/s/#//g" ./data/nginx/sites.template-*
sed -i "/#.*\/data\/certbot\/conf\/live\/.*/s/#//g" docker-compose.yml
```

Now we restart the services:

```bash
sudo docker compose down && sudo docker compose up -d
```

Accessing your Greenlight and Keycloak instances through their HTTPS enabled URLs should be possible now.

So for a **DOMAIN_NAME=xlab.bigbluebutton.org, GL_HOSTNAME=gl and KC_HOSTNAME=kc.**

You can access Greenlight through:  [https://gl.xlab.bigbluebutton.org/](http://gl.xlab.bigbluebutton.org/) and Keycloak through [https://kc.xlab.bigbluebutton.org](http://gl.xlab.bigbluebutton.org/).

When encountering any issues with nginx you can restart it by:

```bash
sudo docker compose restart nginx
```

You can verify the validity of your SSL certificates through your browser, when accessing your URLs you should have a valid SSL status:

![HTTPS](/images/greenlight/v3/certificates/https.png)

**Congratulations** on following the steps until this point, now you have a production ready setup with our recommended configuration set and apt for using.

---

**Greenlight is still in its Alpha version.**

For any suggestions, notes or any encountered issues please refer to the official repository and the community group:

***GitHub Repository:*** [https://github.com/bigbluebutton/greenlight/](https://github.com/bigbluebutton/greenlight/)

***Community Group:*** [https://groups.google.com/g/bigbluebutton-greenlight](https://groups.google.com/g/bigbluebutton-greenlight)

---

If have **not** followed **Greenlight without Keycloak** guide, please follow this guide ***Greenlight with Keycloak*** to make a minimal configuration for Keycloak and integrate it with your Greenlight instance.

---
## Custom Certificates
### Custom Letsencrypt certificates

If your custom certificates were generated by letsencrypt (certbot) for each of your FQDNs you can copy your certificates data and cache (renewal configurations, archive files, live files,…) or the whole letsencrypt directory ‘**/etc/letsencrypt/**’ into ‘**~/greenlight-run/data/certbot/conf**’ (if that does not include any other irrelevant certificates).

However, the only constraint is that you had generated two standalone certificates, one for each of your FQDNs matching what you have as “**$GL_HOSTNAME.$DOMAIN_NAME**” **and** “**$KC_HOSTNAME.$DOMAIN_NAME**”.

```bash
cd ~
sudo mkdir -p greenlight-run/data/certbot/conf/live/
sudo cp -r /etc/letsencrypt/ greenlight-run/data/certbot/conf
```

---

#### Renewing Certificates

Greenlight will have by default a **certbot** service that will be responsible for automatically renewing your certificates, placing your existing Letsencrypt certificates to ‘**~/greenlight-run/data/certbot/conf**’ with **certbot** service in place will enable it to manage its renewal.

However, if you have not used Letsencrypt to issue your custom certificates, you will be responsible for their renewal.

For that you may need to remove the certbot service since you won’t need it.

To disable the **certbot** service please remove this highlighted lines on **~/greenlight-run/docker-compose.yaml**:

But before let’s stop Greenlight:

```bash
cd ~/greenlight-run
sudo docker compose down
```

![Certbot Dockercompose](/images/greenlight/v3/certificates/certbot-dockercompose.png)

And **save** the changes.

Once you're finished, you can skip to [Updating NGINX and Starting Greenlight](#updating-nginx-and-starting-greenlight)

---

### Custom External Certficates

we will start by placing our selves under the home directory:

```bash
cd ~
```

Nginx expects two directories named after each FQDN located under **~/greenlight-run/data/certbot/conf/live** having the following certificates files each: the full chain **fullchain.pem** and the private key **privkey.pem**.

Keycloak instance will also expect the certificate file to be present in a **cert.pem** named file under the Keycloak certificate directroy.

***If you have followed Greenlight without Keycloak guide you are required only to create one directory named after Greenlight FQDN containing its fullchain.pem and privkey.pem.***

So for your custom certificates, we will have to create two directories named after each FQDN.

For a **DOMAIN_NAME=xlab.bigbluebutton.org, GL_HOSTNAME=gl and KC_HOSTNAME=kc** we will create two directories **gl.xlab.bigbluebutton.org and kc.xlab.bigbluebutton.org.**

Kindly place the certificates directories under your home directory ****and place in the **fullchain.pem and privkey.pem** of each certificate under its directory along with the **cert.pem** of Keycloak under its certificate directory and make sure that the directories names matches what you have on your **.env as: ‘$GL_HOSTNAME.$DOMAIN_NAME’ and ‘$KC_HOSTNAME.$DOMAIN_NAME’ (required only if Keycloak is enabled)**.

Once you're finished, you can skip to [Updating NGINX and Starting Greenlight](#updating-nginx-and-starting-greenlight)

---

### Multi domain and wildcard certificates

The following guide is expecting two standalone certificates, each targeting one FQDN one for Greenlight and another for Keycloak.

However, those assertions/expectations may be absurd for some deployments who have and willing to use a none standalone certificate for both FQDNs.

For that you’d only need to do this extra step before proceeding:

Kindly copy in the composite certificate files **fullchain.pem, privkey.pem and cert.pem** in your home directory in a directory named after Greenlight FQDN that would match what you have on **.env** file as ‘**$GL_HOSTNAME.$DOMAIN_NAME’**.

Then you’d create a **relative** symbolic link named after Keycloak FQDN that links to the composite certificate directory (As you may have guessed, the directory named after Greenlight FQDN).

For that please edit the following command and run it:

- **<YOUR_GL_FQDN>**: is a placeholder for your Greenlight FQDN, in our example that would be ‘**gl.xlab.bigbluebutton.org**’, for your deployment that should match ‘**$GL_HOSTNAME.$DOMAIN_NAME’**.
- **<YOUR_KC_FQDN>**: is a placeholder for your Keycloak FQDN, in our example that would be ‘**kc.xlab.bigbluebutton.org**’, for your deployment that should match ‘**$KC_HOSTNAME.$DOMAIN_NAME’.**



```bash
sudo ln -s ./**<YOUR_GL_FQDN>** **<YOUR_KC_FQDN>**
```

So following our example, you’d have something similar to:

![Fullchain](/images/greenlight/v3/certificates/fullchain.png)

Now you can follow the rest of the guide and have the expected outcome while using a composite certificate.

---

Following our example we will have something like:

![Fullchain](/images/greenlight/v3/certificates/fullchain-2.png)

*If you’re using a composite certificate, it’s expected that both directories will have the same content.*

Now we will copy the certificates directories in their expected location:

- **<YOUR_GL_FQDN>**: is a placeholder for your Greenlight FQDN, in our example that would be ‘**gl.xlab.bigbluebutton.org**’, for your deployment that should match ‘**$GL_HOSTNAME.$DOMAIN_NAME’**.
- **<YOUR_KC_FQDN>**: is a placeholder for your Keycloak FQDN, in our example that would be ‘**kc.xlab.bigbluebutton.org**’, for your deployment that should match ‘**$KC_HOSTNAME.$DOMAIN_NAME’.**

```bash
sudo mkdir -p greenlight-run/data/certbot/conf/live/
sudo cp -r **<YOUR_GL_FQDN>**/ greenlight-run/data/certbot/conf/live/
sudo cp -r **<YOUR_KC_FQDN>**/ greenlight-run/data/certbot/conf/live/ # Only, if you use Keycloak
```

 ******

You can verify that your certificates were copied by listing them:

```bash
sudo ls -R greenlight-run/data/certbot/conf/live/
```

![Fullchain](/images/greenlight/v3/certificates/fullchain-3.png)

*If you’re using a composite certificate, it’s expected that both directories will have the same content.*

*If you have followed the guides to remove Keycloak it’s expected to not having its certificate directory.*

Once you're finished, you can skip to [Updating NGINX and Starting Greenlight](#updating-nginx-and-starting-greenlight)

---
## Updating NGINX and Starting Greenlight

We now need to update our nginx configuration file to open **HTTPS** traffic, you can do so manually by going to **./data/nginx/sites.template-*** files ****and uncommenting (Removing the **#** prefix) all lines for the HTTPS binding and SSL certificate files locations.

Or, for your convenience you can run:

```bash
cd ~/greenlight-run
sed -i "/#listen.*/s/#//g" ./data/nginx/sites.template-*
sed -i "/#ssl_certificate.*/s/#//g" ./data/nginx/sites.template-*
sed -i "/#.*\/data\/certbot\/conf\/live\/.*/s/#//g" docker-compose.yml
```

Now we restart the services:

```bash
sudo docker compose down && sudo docker compose up -d
```

Accessing your Greenlight and Keycloak instances through their HTTPS enabled URLs should be possible now.

So for a **DOMAIN_NAME=xlab.bigbluebutton.org, GL_HOSTNAME=gl and KC_HOSTNAME=kc.**

You can access Greenlight through:  [https://gl.xlab.bigbluebutton.org/](http://gl.xlab.bigbluebutton.org/) and Keycloak through [https://kc.xlab.bigbluebutton.org](http://gl.xlab.bigbluebutton.org/).

When encountering any issues with nginx you can restart it by:

```bash
sudo docker compose restart nginx
```

You can verify the validity of your SSL certificates through your browser, when accessing your URLs you should have a valid SSL status:

![HTTPS](/images/greenlight/v3/certificates/https.png)

**Congratulations** on following the steps until this point, now you have a production ready setup with our recommended configuration set and apt for using.