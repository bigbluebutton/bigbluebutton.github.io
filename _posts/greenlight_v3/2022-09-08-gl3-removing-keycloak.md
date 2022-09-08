---

layout: page
title: "Removing Keycloak"
category: greenlight_v3
date: 2022-09-08 16:25:25

---
Some deployments may not require having Keycloak installed on the system.

These steps will document what to change in order to set and run Greenlight v3 without Keycloak.

*Please note that your users will have to authenticate only through Greenlight v3 local accounts.*

You can still connect Greenlight v3 to any OpenID connect provider by updating the OpenID connect environmental variables as documented in **Greenlight with Keycloak.**

Greenlight v3 is a distributed application that has more then a single service running.

One of which is Keycloak so we’d start by removing the Keycloak service.

We’d start by stopping Greenlight if it’s running:

```bash
cd ~/greenlight-run
sudo docker compose down
```

And then we’d remove the Keycloak service from the **docker-compose.yaml** file as follow by removing all of the highlighted lines:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/7a0082f2-3206-400c-ade8-95449586d6a1/Untitled.png)

Also we’d need to update all of the other services dependencies.

So on the nginx service object remove the highlighted line:

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/07e72234-bbb5-407f-a7cb-1a8d56e3043d/Untitled.png)

We’d **save** the changes.

And we’d also update the nginx templates as follow:

Remove the lines starting from  “**#### For <$KC_HOSTNAME.$NGINX_DOMAIN>”** on **data/nginx/sites.template-docker and data/nginx/sites.template-local**

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3c696416-7127-4c77-a56f-58183774f169/Untitled.png)

Kindly **save** the changes.

We’d also need to remove the **KC_HOSTNAME** value:

```bash
sed -i "s/KC_HOSTNAME=.*/KC_HOSTNAME=/" .env
```

If you have followed the guide **Greenlight with Keycloak** and already set Keycloak and integrated it with Greenlight, you’d have to comment out the OpenID client configuration for Keycloak:

For that please run:

```bash
sed -i "/^OPENID_CONNECT.*/s/OPENID/#OPENID/g" data/greenlight/.env
```

Now we’d restart Greenlight:

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

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5dcb80e8-10d1-4c89-ab33-681688499939/Untitled.png)

You should not have a Keycloak container.

All other services should be up and running with no issues.