---

layout: page
title: "Keycloak"
category: greenlight_v3
date: 2022-09-08 16:28:25
order: 3

---

## Connecting to Keycloak

### Configuring Keycloak

At this point, Greenlight and Keycloak should be up and running and accessible through the web via their FQDNs with HTTPS enabled URLs.

Kindly open your browser and go to your Keycloak URL:

Keycloak landing page:

![Landing](/images/greenlight/v3/keycloak/keycloak-landing.png)

Select the administration console:

![Admin Console](/images/greenlight/v3/keycloak/admin-console.png)

The default *username* is **admin** and *password* is whatever you have on **KEYCLOAK_PASSWORD** in the **~/greenlight-run/.env** file**:**

![Credentials](/images/greenlight/v3/keycloak/credentials.png)

Start by creating a new realm for Greenlight by hovering over the **Master** realm on the top left corner, and clicking on **Add realm:**

![Realm](/images/greenlight/v3/keycloak/realm.png)

Call the realm **greenlight** and click on **create**:

![Add Realm](/images/greenlight/v3/keycloak/add-realm.png)

Now that the **greenlight** realm has been created, make a minimal configuration for it to become ready to use.

However, this default configuration is only for testing purposes and should not be used as is for production environments. 

It is recommended to follow the official documentations from Keycloak to check the available options and change the default configurations to suit your needs and increase security.

![Realm Settings](/images/greenlight/v3/keycloak/realm-settings.png)

You can further configure your realm according to your preferences.

Create a new client by clicking **Clients:**

![Clients](/images/greenlight/v3/keycloak/clients.png)

Click on **Create:**

![Create Clients](/images/greenlight/v3/keycloak/create-client.png)

Fill in the form as follow and click **Save**:

![Create Clients](/images/greenlight/v3/keycloak/create-client-2.png)

Make sure to set Access Type to **Confidential:**

![Access Type](/images/greenlight/v3/keycloak/access-type.png)

And the redirect URI pattern:

Change `<YOUR_GREENLIGHT_FQDN>` to whatever you have as “$GL_HOSTNAME.$DOMAIN_NAME”.

For **DOMAIN_NAME=xlab.bigbluebutton.org**, and **GL_HOSTNAME=gl**, type in **https://gl.xlab.bigbluebutton.org/***.

![Valid Redirect](/images/greenlight/v3/keycloak/valid-redirect.png)

All required options should be already set for you.

You can still configure the rest of the OpenID client options as you wish - *for the configuration, it is recommended that you check the official OpenID documentations.*

After making the changes, validate the OpenID client creation by clicking **Save** at the end of the form:

![Save Client](/images/greenlight/v3/keycloak/save-client.png)

Go to **Credentials** and store the **Secret** key, as **it will be needed later**:


![Client Creds](/images/greenlight/v3/keycloak/client-credentials.png)

We are left to create users and roles if we are willing to use Keycloak local authentication or we can integrate it with an identity provider to act as a broker or with a user federation.

**The steps to connect Keycloak to Google OAuth2 API for authentication will be documented. However, feel free to check the official documentations on how to create local accounts if that best suits your case.**

Start by going to **Configure>Identity Providers:**

![Idp](/images/greenlight/v3/keycloak/idp.png)

Click on **Add provider…** on the select menu and choose the provider you like, for example, with **Google**:

![Google Idp](/images/greenlight/v3/keycloak/google.png)

We need the OpenID client credentials: the **Client ID** and **secret**.

For Google, follow this guide to obtain the credentials: [https://developers.google.com/identity/protocols/oauth2/openid-connect](https://developers.google.com/identity/protocols/oauth2/openid-connect).

Feel free to use different providers and refer to their documentations on how to create and obtain OpenID credentials.

You need to copy the Redirect URI and paste it when asked while configuring your OpenID provider.

This is an example coming from creating the Google OAuth2 credentials:

![Google Auth](/images/greenlight/v3/keycloak/google-auth.png)

After obtaining the credentials, put them in the form as follow:

![Google Creds](/images/greenlight/v3/keycloak/google-creds.png)

After filling in the credentials, please **save** changes.



![Save](/images/greenlight/v3/keycloak/save.png)

Since there is only one Identity provider, and local authentication is not desired, make it the default authentication option.

For that, go to **Configure>Authentication:**

![Authentication](/images/greenlight/v3/keycloak/auth.png)

Click on **Actions>Config** on the “**Identity Provider Redirector**” row:

![Auth Actions](/images/greenlight/v3/keycloak/actions.png)

Fill the form as follow:

![Default](/images/greenlight/v3/keycloak/default.png)

You should have something similar to this:

![Default Save](/images/greenlight/v3/keycloak/default-save.png)

![Auth-2](/images/greenlight/v3/keycloak/auth-2.png)

Google is now the default authentication option to use.

Now, connect Greenlight to Keycloak.

For that, the realm issuer URL and secret is needed.

We already have stored the secret so, we only need the URL.

For that, go to **Configure>Realm settings**:

![Realm Creds](/images/greenlight/v3/keycloak/realm-creds.png)

Then, select **Endpoints>OpenID Endpoint Configuration:**

![OpenID Config](/images/greenlight/v3/keycloak/openid-config.png)

Copy the **issuer** URL:

![Issuer](/images/greenlight/v3/keycloak/issuer.png)

In **data/greenlight/.env** uncomment all OpenID connect variables (those prefixed with OPENID_CONNECT).

And fill in the credentials as follow:

- `<YOUR_SECRET>` is a placeholder for your OpenID client secret.
- `<ISSUER_URL>` is a placeholder for your Keycloak issuer (realm) URL.
- `<YOUR_GREENLIGHT_DOMAIN>` is a placeholder for your Greenlight FQDN. It should match what you have as “**$GL_HOSTNAME.$DOMAIN_NAME**”.

```bash
OPENID_CONNECT_CLIENT_ID=greenlight
OPENID_CONNECT_CLIENT_SECRET=<YOUR_SECRET>
OPENID_CONNECT_ISSUER=<ISSUER_URL>
OPENID_CONNECT_REDIRECT=https://<YOUR_GREENLIGHT_DOMAIN>/
```

---

### Starting Greenlight

Now, restart Greenlight:

```bash
sudo docker compose down && sudo docker compose up -d
```

Once Greenlight restarts, you should be able to use the Keycloak realm client that you have created instead of the local authentication:

1. Open Greenlight in your browser and click on **Sign In**. You should be redirected to Google authentication page.

2. After Authenticating to Google, you should be redirected back to Greenlight and be logged in.

You can now further configure the Keycloak realm to use other identity providers (social networks, ...) and authentication systems (LDAP, SAML, ...).
## Connecting to Another OpenID Provider

If you have an OpenID connect provider that you want to use, fill these environmental variables to match your configuration:

| Variable Name | Description                                                                                           |
| --- |-------------------------------------------------------------------------------------------------------|
| OPENID_CONNECT_CLIENT_ID | The client ID of the OpenID issuer.                                                                   |
| OPENID_CONNECT_CLIENT_SECRET | The secret to use to authenticate to the OpenID issuer.                                               |
| OPENID_CONNECT_ISSUER | The URL for the OpenID issuer. It is required to be HTTPS URL using the default HTTPS port (TCP 443). |
| OPENID_CONNECT_REDIRECT | The Redirect URI after successful authentication. It will be the URL to Greenlight.                   |

The Redirect URI pattern should be: **https://\<YOUR_GREENLIGHT_FQDN\>/*** where **\<YOUR_GREENLIGHT_FQDN\>** is a placeholder for your Greenlight FQDN matching “**$GL_HOSTNAME.$DOMAIN_NAME**”

The only constraint, however, is to have the OpenID provider accessible through your network via **HTTPS on the default port (TCP 443)**.

***Once you make your changes, you can jump to [Starting Greenlight](#starting-greenlight).***

---

## Removing Keycloak

Some deployments do not require having Keycloak installed.

The following steps will indicate what to change in order to set and run Greenlight v3 without Keycloak.

*Please note that your users will have to authenticate through Greenlight v3 local accounts.*

You can still connect Greenlight v3 to any OpenID connect provider by updating the OpenID connect environmental variables, as documented in **Greenlight with Keycloak.**

Greenlight v3 is a distributed application that has more then a single service running.

One of which is Keycloak, so let's start by removing the Keycloak service.

Stop Greenlight if it’s running:

```bash
cd ~/greenlight-run
sudo docker compose down
```

Then, remove the Keycloak service from the **docker-compose.yaml** by removing these lines:

```yaml
keycloak:
    ...
    container_name: keycloak
    restart: unless-stopped
    ...
    depends_on:
      - postgres
```


Also, all of the other services dependencies need to be updated.

On the nginx service object, remove Keycloak from its dependencies list:

```yaml
nginx:
    ...
    container_name: nginx
    restart: unless-stopped
    ...
    depends_on:
      - greenlight
      - keycloak # REMOVE THIS LINE ONLYs
    command: ...
```

**Save** the changes.

And update the nginx templates as follow:

Remove the Keycloak configuration for nginx by deleting the following lines on **data/nginx/sites.template-docker and data/nginx/sites.template-local**:

```nginx
#### For <$KC_HOSTNAME.$DOMAIN_NAME>

upstream keycloak-server {
    ...
}

server {
    ...
}
```

**Save** the changes.

Remove the **KC_HOSTNAME** value:

```bash
sed -i "s/KC_HOSTNAME=.*/KC_HOSTNAME=/" .env
```

If you have Greenlight configured to use Keycloak, you have to comment out the OpenID client configuration:

```bash
sed -i "/^OPENID_CONNECT.*/s/OPENID/#OPENID/g" data/greenlight/.env
```

Then, restart Greenlight:

```bash
sudo docker compose up -d
```

> You can remove any data related to the Keycloak containers such as the docker image, certificates, etc.

At this point, you should have Greenlight services up and running without Keycloak.

You can verify that by running:

```bash
sudo docker container ls
```

You should not have a Keycloak container.

All other services should be up and running with no issues.
