---

layout: page
title: "Keycloak"
category: greenlight_v3
date: 2022-09-08 16:28:25
order: 3

---

## Connecting to Keycloak

### Configuring Keycloak

At this point you should have already set Greenlight and Keycloak up and running and have both accessible through the web via their FQDNs with HTTPS enabled URLs.

Kindly open your browser and go to your Keycloak URL:

Keycloak landing page:

![Landing](/images/greenlight/v3/keycloak/keycloak-landing.png)

we will select the administration console:

![Admin Console](/images/greenlight/v3/keycloak/admin-console.png)

The default *Username* is **admin** and *password* is whatever you have on **KEYCLOAK_PASSWORD** in the **~/greenlight-run/.env** file**:**

![Credentials](/images/greenlight/v3/keycloak/credentials.png)

we will start by creating a new realm for Greenlight by hovering over the **Master** realm on the top left corner and clicking on **Add realm:**

![Realm](/images/greenlight/v3/keycloak/realm.png)

we will call the realm **greenlight** and click on **create**:

![Add Realm](/images/greenlight/v3/keycloak/add-realm.png)

Now we have our **greenlight** realm created, we will now make a minimal configuration for it to become ready for use:

However, this default configuration is only for testing purposes and shouldn’t be used as is for production environments, we highly recommend checking the official documentations for Keycloak to check the available options and how to change the default configurations to suit your needs and increase security.

![Realm Settings](/images/greenlight/v3/keycloak/realm-settings.png)

You can further configure your realm according to your preferences.

we will create a new client by clicking **Clients:**

![Clients](/images/greenlight/v3/keycloak/clients.png)

And then clicking **Create:**

![Create Clients](/images/greenlight/v3/keycloak/create-client.png)

Fill in the form as follow and click **Save**:

![Create Clients](/images/greenlight/v3/keycloak/create-client-2.png)

Make sure to set Access Type to **Confidential:**

![Access Type](/images/greenlight/v3/keycloak/access-type.png)

And the redirect URI pattern:

Kindly change **<YOUR_GREENLIGHT_FQDN>** to whatever you have as “**$GL_HOSTNAME.$DOMAIN_NAME**”.

So for a **DOMAIN_NAME=xlab.bigbluebutton.org, and GL_HOSTNAME=gl.**

we will type in **https://gl.xlab.bigbluebutton.org/***.

![Valid Redirect](/images/greenlight/v3/keycloak/valid-redirect.png)

All required options should be already set for you, you can still configure the rest of the OpenID client options as you wish - *for that we highly recommend that you check the official documentations.*

After making the changes, we will validate the OpenID client creation by clicking **Save** at the end of the form:

![Save Client](/images/greenlight/v3/keycloak/save-client.png)

Kindly go to **Credentials** and copy the **Secret** key we will use it later:



![Client Creds](/images/greenlight/v3/keycloak/client-credentials.png)

We’re left to create users and roles if we’re willing to use Keycloak local authentication or we can integrate it with an identity provider to act as a broker or with a user federation.

**we will document the steps to connect Keycloak to Google OAuth2 API for authentication - however, feel free to check the official documentations on how to create local accounts if that best suits your case.**

we will start by going to **Configure>Identity Providers:**

![Idp](/images/greenlight/v3/keycloak/idp.png)

Click on **Add provider…** on the select menu and choose the provider you like, we will go with **Google**:

![Google Idp](/images/greenlight/v3/keycloak/google.png)

we will need to have the OpenID client credentials: the **Client ID** and **secret**.

For Google, to obtain those values we will follow this guide [https://developers.google.com/identity/protocols/oauth2/openid-connect](https://developers.google.com/identity/protocols/oauth2/openid-connect).

Feel free to use different providers and refer to their documentations on how to create and obtain OpenID credentials.

You’d need to copy the Redirect URI and paste it when asked for, while configuring your OpenID provider:

This is an example coming from creating the Google OAuth2 credentials:

![Google Auth](/images/greenlight/v3/keycloak/google-auth.png)

After obtaining the credentials we will put them in the form as follow:

![Google Creds](/images/greenlight/v3/keycloak/google-creds.png)

After filling in the credentials, please **save** changes..



![Save](/images/greenlight/v3/keycloak/save.png)

Since we have one Identity provider and we do not want the local authentication, we will make it the default authentication option.

For that we will go to, **Configure>Authentication:**

![Authentication](/images/greenlight/v3/keycloak/auth.png)

Click on **Actions>Config** on the “**Identity Provider Redirector**” row:

![Auth Actions](/images/greenlight/v3/keycloak/actions.png)

Fill the form as follow:

![Default](/images/greenlight/v3/keycloak/default.png)

You’d have something similar to this:

![Default Save](/images/greenlight/v3/keycloak/default-save.png)

![Auth-2](/images/greenlight/v3/keycloak/auth-2.png)

Now Google is the default authentication option to use.

we will now connect Greenlight to Keycloak, for that we will need the realm issuer URL and secret.

We’ve already saved the secret so we will only need the URL.

For that go to **Configure>Realm settings**:

![Realm Creds](/images/greenlight/v3/keycloak/realm-creds.png)

Then select **Endpoints>OpenID Endpoint Configuration:**

![OpenID Config](/images/greenlight/v3/keycloak/openid-config.png)

Copy the **issuer** URL:

![Issuer](/images/greenlight/v3/keycloak/issuer.png)

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

---

### Starting Greenlight

Now we will restart Greenlight:

```bash
sudo docker compose down && sudo docker compose up -d
```

Once Greenlight restarts you should be able to use the Keycloak realm client that you’ve created instead of local authentication:

Open Greenlight in your browser and click **Sign In**, you should be redirected to Google authentication consent screen:

![Signin](/images/greenlight/v3/keycloak/google-signin.png)

After Authenticating on Google, you should be redirected back to Greenlight and have your account created and be logged in.

You can now further configure Keycloak realm to use other social networks (identity providers) or other authentication systems such as SAML, LDAP and many more.

## Connecting to Another OpenID Provider

If you have an OpenID connect provider that you’re willing to use it’s only a matter of filling these environmental variables to match your configuration:

| Variable Name | Description                                                                                          |
| --- |------------------------------------------------------------------------------------------------------|
| OPENID_CONNECT_CLIENT_ID | The client ID of the OpenID issuer.                                                                  |
| OPENID_CONNECT_CLIENT_SECRET | The secret to use to authenticate to the OpenID issuer.                                              |
| OPENID_CONNECT_ISSUER | The URL for the OpenID issuer. It’s required to be HTTPS URL using the default HTTPS port (TCP 443). |
| OPENID_CONNECT_REDIRECT | The Redirect URI after successful authentication. It will be the URL to Greenlight.                  |

The Redirect URI pattern should be: **https://\<YOUR_GREENLIGHT_FQDN\>/*** where **\<YOUR_GREENLIGHT_FQDN\>** is a placeholder for your Greenlight FQDN matching “**$GL_HOSTNAME.$DOMAIN_NAME**”

The only constraint however is to have the OpenID provider accessible through your network via **HTTPS on the default port (TCP 443)**.

***Once you make your changes, you can jump to [Starting Greenlight](#starting-greenlight).***

---

## Removing Keycloak

Some deployments may not require having Keycloak installed on the system.

These steps will document what to change in order to set and run Greenlight v3 without Keycloak.

*Please note that your users will have to authenticate only through Greenlight v3 local accounts.*

You can still connect Greenlight v3 to any OpenID connect provider by updating the OpenID connect environmental variables as documented in **Greenlight with Keycloak.**

Greenlight v3 is a distributed application that has more then a single service running.

One of which is Keycloak so we will start by removing the Keycloak service.

we will start by stopping Greenlight if it’s running:

```bash
cd ~/greenlight-run
sudo docker compose down
```

And then we will remove the Keycloak service from the **docker-compose.yaml** file as follow by removing all of the highlighted lines:

![Remove Compose](/images/greenlight/v3/keycloak/remove-compose.png)

Also we will need to update all of the other services dependencies.

So on the nginx service object remove the highlighted line:

![Remove Compose 2](/images/greenlight/v3/keycloak/remove-compose-2.png)

we will **save** the changes.

And we will also update the nginx templates as follow:

Remove the lines starting from  “**#### For <$KC_HOSTNAME.$NGINX_DOMAIN>”** on **data/nginx/sites.template-docker and data/nginx/sites.template-local**

![Remove Nginx](/images/greenlight/v3/keycloak/remove-nginx.png)

Kindly **save** the changes.

we will also need to remove the **KC_HOSTNAME** value:

```bash
sed -i "s/KC_HOSTNAME=.*/KC_HOSTNAME=/" .env
```

If you have followed the guide **Greenlight with Keycloak** and already set Keycloak and integrated it with Greenlight, you’d have to comment out the OpenID client configuration for Keycloak:

For that please run:

```bash
sed -i "/^OPENID_CONNECT.*/s/OPENID/#OPENID/g" data/greenlight/.env
```

Now we will restart Greenlight:

```bash
sudo docker compose up -d
sudo docker compose restart nginx
```

You can remove any data related to keycloak containers such as the docker image, certificates, etc…

At this point you should have Greenlight services up and running without Keycloak.

You can verify that by running:

```bash
sudo docker container ls
```

![Remove Containers](/images/greenlight/v3/keycloak/remove-containers.png)

You should not have a Keycloak container.

All other services should be up and running with no issues.