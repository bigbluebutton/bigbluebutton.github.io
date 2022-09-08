---

layout: page
title: "Configuring Keycloak"
category: greenlight_v3
date: 2022-09-08 16:25:25

---

Greenlight was designed to provide more then a single option to authenticate users.

Like its previous versions Greenlight comes with local authentication where Greenlight itself will handle the process and keep hold of your resources records in its postgres database on your server.

However, Greenlight also enables organizations to leverage and use their existing authentication or AAA systems like LDAP along with the possibility to connect to any identity providers.

This is all done using the OpenID connect standard, so Greenlight by design can be connected to any OpenID connect provider.

Unlike its previous versions Greenlight does not guess the identity providers to use and comes with default support for each, since that with our experience introduces more bad then good.

So how Greenlight will support an unlimited number of providers while it can only use one?

The answer is identity brokers, those systems supports the use of well known industry standards for Authentication (AuthN) and Authorization (AuthZ) like OpenID, SAML and OAuth2,… providing a centralized system that acts as a middleware where applications delegate authentication and authorization to.

The identity broker will connect and use external identity providers of different natures.

By connecting Greenlight to an identity broker like Keycloak using any identity provider is only a matter of configuring the broker to support it without making any changes to Greenlight itself.

So Greenlight truly delegates the authentication concern completely to the broker to manage it.

This helps simplify a lot the work done by Greenlight, maintainers and administrators while enabling the use of new features like Single sign on and sign out…

Keycloak is an open source identity broker that is trusted and used in the industry, however you can use any OpenID connect provider if that best suits your case.

---

## Connecting to an OpenID provider:

If you have an OpenID connect provider that you’re willing to use it’s only a matter of filling these environmental variables to match your configuration:

| Variable Name | Description |
| --- | --- |
| OPENID_CONNECT_CLIENT_ID | The client ID of the OpenID issuer. |
| OPENID_CONNECT_CLIENT_SECRET | The secret to use to authenticate to the OpenID issuer. |
| OPENID_CONNECT_ISSUER | The URL for the OpenID issuer.
It’s required to be HTTPS URL using the default HTTPS port (TCP 443). |
| OPENID_CONNECT_REDIRECT | The Redirect URI after successful authentication.
It will be the URL to Greenlight. |

The Redirect URI pattern should be: **https://<YOUR_GREENLIGHT_FQDN>/*** where **<YOUR_GREENLIGHT_FQDN>** is a placeholder for your Greenlight FQDN matching “**$GL_HOSTNAME.$DOMAIN_NAME**”

The only constraint however is to have the OpenID provider accessible through your network via **HTTPS on the default port (TCP 443)**.

You may also want to follow the guide **Greenlight without Keycloak.**

*You can skip the rest of this guide into **Starting Greenlight**.*

---

## Configuring Keycloak:

At this point you should have already set Greenlight and Keycloak up and running and have both accessible through the web via their FQDNs with HTTPS enabled URLs.

*If not please refer to and follow the installation guides before proceeding.*

Kindly open your browser and go to your Keycloak URL:

So for a **DOMAIN_NAME=xlab.bigbluebutton.org and KC_HOSTNAME=kc.**

You can access Keycloak through:  [https://kc.xlab.bigbluebutton.org/](http://gl.xlab.bigbluebutton.org/).

Keycloak landing page:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/38f360c1-9c5e-4533-8065-a74122497b01/Untitled.png)

We’d select the administration console:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bc86f6dd-7f75-48b3-997e-9ef1d52e2c8a/Untitled.png)

The default *Username* is **admin** and *password* is whatever you have on **KEYCLOAK_PASSWORD** in the **~/greenlight-run/.env** file**:**

*If you had changed the default credentials please fill it in place.*

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5ea3d2ca-ca5a-44d8-80ad-aa78d2ffa61a/Untitled.png)

It’s highly recommended to change the default credentials for the admin account, so once completing this tutorial please kindly follow the guides on how to change the admin credentials.

We’d start by creating a new realm for Greenlight by hovering over the **Master** realm on the top left corner and clicking on **Add realm:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/df63aca0-c791-4e30-8030-1da6011564ed/Untitled.png)

We’d call the realm **greenlight** and click on **create**:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/bc224b7f-bbdb-462a-a8d4-dbc5979ddce3/Untitled.png)

Now we have our **greenlight** realm created, we’d now make a minimal configuration for it to become ready for use:

However, this default configuration is only for testing purposes and shouldn’t be used as is for production environments, we highly recommend checking the official documentations for Keycloak to check the available options and how to change the default configurations to suit your needs and increase security.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/56b89cb8-fa81-4435-98cd-90e8888d67f3/Untitled.png)

You can further configure your realm according to your preferences.

We’d create a new client by clicking **Clients:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ec8a4732-f3de-46e8-867c-5ad75a82a6b3/Untitled.png)

And then clicking **Create:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/87ee3d88-7e94-47c1-9dea-81031624e085/Untitled.png)

Fill in the form as follow and click **Save**:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4a90ad33-1761-4b5a-9902-8a3890c96b23/Untitled.png)

Make sure to set Access Type to **Confidential:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f55a625c-24f8-4b8b-885d-45c3b8c88b97/Untitled.png)

And the redirect URI pattern:

Kindly change **<YOUR_GREENLIGHT_FQDN>** to whatever you have as “**$GL_HOSTNAME.$DOMAIN_NAME**”.

So for a **DOMAIN_NAME=xlab.bigbluebutton.org, and GL_HOSTNAME=gl.**

We’d type in **https://gl.xlab.bigbluebutton.org/***.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/c5c6eda5-d670-4a5a-a3c8-b77a9130d8f2/Untitled.png)

All required options should be already set for you, you can still configure the rest of the OpenID client options as you wish - *for that we highly recommend that you check the official documentations.*

After making the changes, we’d validate the OpenID client creation by clicking **Save** at the end of the form:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/426e7640-9f70-4834-8f28-cf27fff2499e/Untitled.png)

Kindly go to **Credentials** and copy the **Secret** key we’d use it later:



![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/719b36f6-341c-49f8-bcab-333554d57ab4/Untitled.png)

We’re left to create users and roles if we’re willing to use Keycloak local authentication or we can integrate it with an identity provider to act as a broker or with a user federation.

**We’d document the steps to connect Keycloak to Google OAuth2 API for authentication - however, feel free to check the official documentations on how to create local accounts if that best suits your case.**

We’d start by going to **Configure>Identity Providers:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/05f0b815-6c51-4481-b37c-e1d73736d1ab/Untitled.png)

Click on **Add provider…** on the select menu and choose the provider you like, we’d go with **Google**:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f576b07c-3b99-4399-bed0-9ad330734a8d/Untitled.png)

We’d need to have the OpenID client credentials: the **Client ID** and **secret**.

For Google, to obtain those values we’d follow this guide [https://developers.google.com/identity/protocols/oauth2/openid-connect](https://developers.google.com/identity/protocols/oauth2/openid-connect).

Feel free to use different providers and refer to their documentations on how to create and obtain OpenID credentials.

You’d need to copy the Redirect URI and paste it when asked for, while configuring your OpenID provider:

This is an example coming from creating the Google OAuth2 credentials:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/77b8fdb1-a271-4b9c-922c-0529246d58aa/Untitled.png)

After obtaining the credentials we’d put them in the form as follow:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e7dca934-5ea8-4f87-bdfe-b77de67e15b6/Untitled.png)

After filling in the credentials, please **save** changes..



![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b383507b-ba7e-4fdd-8801-5ffa56c64f49/Untitled.png)

Since we have one Identity provider and we do not want the local authentication, we’d make it the default authentication option.

For that we’d go to, **Configure>Authentication:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7b8d4a66-6066-41f7-9b24-c2e1317481c4/Untitled.png)

Click on **Actions>Config** on the “**Identity Provider Redirector**” row:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/98605644-c5f5-44ff-996c-a4ea04c2e84a/Untitled.png)

Fill the form as follow:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/565324af-2f45-4c37-a966-fcf4cd67397e/Untitled.png)

You’d have something similar to this:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b4d998c8-9b36-4cb2-8e3f-7164409bc208/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8f8bbcfe-39d5-46b2-8d9d-62b1daf2a43a/Untitled.png)

Now Google is the default authentication option to use.

We’d now connect Greenlight to Keycloak, for that we’d need the realm issuer URL and secret.

We’ve already saved the secret so we’d only need the URL.

For that go to **Configure>Realm settings**:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/e4fb0b19-c210-4611-8ebb-21fb5d743b6d/Untitled.png)

Then select **Endpoints>OpenID Endpoint Configuration:**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/f57aeaf7-77fa-4dc8-8022-233c86f7eed3/Untitled.png)

Copy the **issuer** URL:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/9e3b0f12-0682-4384-8758-04ed6d551dea/Untitled.png)

In **data/greenlight/.env** uncomment all OpenID connect variables (those prefixed with OPENID_CONNECT).

And fill in the credentials as follow:

- **<YOUR_SECRET>:** is a placeholder for your OpenID client secret.
- **<ISSUER_URL>:** is a placeholder for your Keycloak issuer (realm) URL.
- **<YOUR_GREENLIGHT_DOMAIN>:** is a placeholder for your Greenlight FQDN, this should match what you have as “**$DOMAIN_NAME.$GL_HOSTNAME**”.

```bash
OPENID_CONNECT_CLIENT_ID=greenlight
OPENID_CONNECT_CLIENT_SECRET=**<YOUR_SECRET>**
OPENID_CONNECT_ISSUER=**<ISSUER_URL>**
OPENID_CONNECT_REDIRECT=https://**<YOUR_GREENLIGHT_DOMAIN>**/
```

For you convivence, kindly edit and run these commands:

```bash
cd ~/greenlight-run
sed -i "s/^#OPENID_CONNECT_CLIENT_ID=$/OPENID_CONNECT_CLIENT_ID=greenlight/" data/greenlight/.env
sed -i "s/^#OPENID_CONNECT_CLIENT_SECRET=$/OPENID_CONNECT_CLIENT_SECRET=**<YOUR_SECRET>**/" data/greenlight/.env
sed -i "s|^#OPENID_CONNECT_ISSUER=$|OPENID_CONNECT_ISSUER=**<ISSUER_URL>**|" data/greenlight/.env
sed -i "s|^#OPENID_CONNECT_REDIRECT=$|OPENID_CONNECT_REDIRECT=https://**<YOUR_GREENLIGHT_DOMAIN>**/|" data/greenlight/.env
```

---

## Starting Greenlight:

Now we’d restart Greenlight:

```bash
sudo docker compose down && sudo docker compose up -d
```

Once Greenlight restarts you should be able to use the Keycloak realm client that you’ve created instead of local authentication:

Open Greenlight in your browser and click **Sign In**:

So for a **DOMAIN_NAME=xlab.bigbluebutton.org and GL_HOSTNAME=gl.**

You can access Greenlight through:  [https://gl.xlab.bigbluebutton.org/](http://gl.xlab.bigbluebutton.org/).

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8769466a-eb31-49bb-bb20-9d48dca23736/Untitled.png)

You will be redirected to Google authentication consent screen:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/0715c95a-dff2-495f-8263-6b40ea3de282/Untitled.png)

After Authenticating on Google , you should be redirected back to Greenlight and have your account created and be logged in with:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/8a1fec0e-49b3-4319-9ccb-bada840ce1a9/Untitled.png)

You can now further configure Keycloak realm to use other social networks (identity providers) or other AAA systems like LDAP (User federation), …

There’s no limit to what you can build.