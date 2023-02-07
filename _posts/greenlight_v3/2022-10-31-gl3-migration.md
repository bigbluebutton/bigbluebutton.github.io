---

layout: page
title: "Migrating from v2"
category: greenlight_v3
date: 2022-10-31 16:28:25
order: 4

---

As described in the **Install** chapter of this documentation, Greenlight v3 is a completely new software application built from the ground up while keeping the same values of the project, while changing the design and architecture.

Greenlight v3's database design, technology and relational modeling is different to that of v2, making both versions running on the same data tier with the same state impossible to achieve.

To solve this challenge, we have developed a migration system in Greenlight that will migrate the critical resources organizations have from v2 to their newly updated version v3.

## Migration system design & architecture

*The migration system spans both Greenlight v2 and Greenlight v3 and requires both systems to be deployed, running and accessible through a network.*

***Therefore, we kindly invite you to follow the installation steps to deploy Greenlight v3 with our recommended configuration and ensure that it is operational.***

### System Design

The migration system is a collection of prepared **rake tasks** where each task is in charge of migrating all (or a portion) of one class of resources (rooms, users,…) along with a restful API that is in charge of receiving the migrated resources, validating the request and committing the migration into the underlying system.

The **rake tasks** must be hosted and executed on the existing Greenlight v2 deployment where the data lives.

The migration API, on the other hand, will be automatically available on any Greenlight v3 deployment.

For summarization, you’d need to:

1. Set up Greenlight v3.
2. Ensure that both systems (Greenlight v2 and v3) are accessible through the network (that may require configuring the networking infrastructure accordingly).
3. Deploy the **rake tasks** file on your Greenlight v2 instance under **/lib/tasks** (More on this later).
4. Edit Greenlight v2 **.env** file configuring it to point to Greenlight v3 instance (More on this later).
5. Run the migration task(s) that you need (More on this later).
6. The migration system will take the rest, time for a coffee or a tea maybe?

### Architecture

The migration process is intended to migrate confidential resources through a network from a system to another.

That could easily break the level of confidentiality and control over data that Greenlight as an opensource project promotes.

For documentation and transparency purposes, we will be documenting the general architecture of the migration system for administrators to understand the system.

The migration system was built with these goals in mind:

1. Resources (e.g. rooms) are migrated one at a time.
2. Administrators can migrate a maximum of one class of resources (e.g rooms) per task.
3. The migration system should be fail safe, where a failing migration of one resource (e.g. a room) shouldn’t impact the overall migration process (the rest of the rooms migration should be carried).
4. The migration system should be auto repairable. Re-running a migration process (e.g. rooms migration) will migrate any failed resource migrations (e.g. a failed to migrate room because of a network issue can be migrated when re-run).
5. The migration process shouldn’t impact the running system performance.
6. The migration process should preserve the migrated data confidentiality and integrity.
7. The migration process should allow for some level of customization for administrators.
8. The migration process should be simple in design.
9. The migration process can be carried through the plain HTTP protocol on an insecure network without invalidating any of the described points above especially the security constraints.

With those goals in mind we propose the following architecture:

![Network security diagram example (3).png](/images/greenlight/v3/migration/Network_security_diagram_example_(3).png)

All migrated resources data will be cryptographically encrypted and signed using a shared secret between both systems (Greenlight v3's **SECRET_KEY_BASE.**).

*Therefore, after a successful migration we do recommend changing your Greenlight v3 **SECRET_KEY_BASE.***

All of the traffic is encrypted using rails **ActiveSupport::MessageEncryptor** API. 

All migrated resources data will be encrypted using **AES-256-GCM** and be only valid for **10 seconds** counting from the encryption timestamp.

To summarize, as long that the shared secret is secured:

- No one can decrypt nor alter no correlate the data.
- Replaying the same request after the validity period will have no effect on the system.
- Replaying the same request before the elapse of the validity period will have no effect on the system.

We **highly** recommend carrying this process out over HTTPS.

## Running the Migrations

### Prerequisites

The migration system requires:

1. Both Greenlight v3 and v2 instances to be running.
2. Both systems to be accessible to each other through a TCP/IP network via HTTP/HTTPS protocol.
3. Greenlight v3 ingress web traffic allowed on its listening port as defined in **V3_ENDPOINT** (e.g. for [https://v3.greenlight.test:8080/](https://v3.greenlight.test/=), ingress HTTPS traffic to v3 on port 8080 should be allowed from v2).
4. v3 **SECRET_KEY_BASE** to be securely placed in v2 **.env** file using the **V3_SECRET_KEY_BASE** variable.
5. v3 URL (e.g. [https://v3.greenlight.test/](https://v3.greenlight.test/)) that is accessible from v2 to be placed in v2 **.env** file using the **V3_ENDPOINT** variable.
6. The rake tasks file to be placed under the **/lib/tasks** subtree on the running v2 instance directory.

Follow the steps below to ensure that these requirements are met before beginning the migrations. 

### Configuring the Environment

#### .env Changes

So, now we have both systems up, running and accessible to each other from a networking perspective.

We have the URL of the v3 instance, let’s say [https://v3.greenlight.test/](https://v3.greenlight.test/) along with its secret key base.

We’d have to:

1. Edit the **.env** file of v2 and add in two new entries to define two new environmental variables:
    - **V3_ENDPOINT**, which will have the v3 URL.
    - **V3_SECRET_KEY_BASE** , which will have the v3 secret key base (which can be found in v3's  **.env** file).

![Untitled](/images/greenlight/v3/migration/Untitled.png)

2. Save the changes.

#### Deploying the rake tasks

If your deployment is aligned with the official release, simply update Greenlight v2 and skip to [Running the migrations](#running the migrations),


For all other deployments, we need to load the rake migration tasks file into the running system.

For that:

1. First, place ourselves under the Greenlight v2

```bash
cd ~/greenlight
```

2. Download the migration rake tasks to the hosting machine of the running v2 instance.

For that you can do it manually or run this command for your convenience:

```bash
wget -P lib/tasks/migrations https://raw.githubusercontent.com/bigbluebutton/greenlight/master/lib/tasks/migrations/migrations.rake
```

Now we should have the file **migrations.rake** downloaded in **/lib/tasks/migrations** directory.

![Untitled](/images/greenlight/v3/migration/Untitled%203.png)

To include our changes directly in the Docker container:

1. Bind mount the **/lib/tasks/migrations** directory by editting the **docker-compose.yaml** as follow:

Change the volumes list of the **app** service from:

```yaml
services:
  app:
    volumes:
      - ./log:/usr/src/app/log
      - ./storage:/usr/src/app/storage
```

To:

```yaml
services:
  app:
    volumes:
      - ./log:/usr/src/app/log
      - ./storage:/usr/src/app/storage
      - ./lib/tasks/migrations:/usr/src/app/lib/tasks/migrations
```


The result should match:

![Untitled](/images/greenlight/v3/migration/Untitled%204.png)

Save the changes and simply restart Greenlight v2 by running:

```bash
sudo docker-compose down && sudo docker-compose up -d
```

You can verify the deployment by running the command below and verifying that the `migrations.rake` file is returned

```bash
sudo docker exec -it greenlight-v2 ls lib/tasks/migrations
```

![Untitled](/images/greenlight/v3/migration/Untitled%205.png)

### Things to Note

Things to note:

- It’s **required** to run migrations in the following order: Roles > Users > Rooms.
- The migrations tasks will migrate one whole class of resources by default or a portion if configured otherwise.
- The migrations tasks may ignore a portion of resources in the given class (e.g. some roles will be ignored).
- The migrations tasks were designed to be fail safe, so a failing resource to migrate will not be a bottleneck to the whole migration process.
- A migration task that had at least one failed resource migration will be declared as failed and have an **EXIT CODE** of **1.**

The logs will indicate the failing and successfully migrated resources in real-time.

*However, a failed migration does not mean that the process completely failed for all resources.*

- Re-running a migration task will try to resolve any failed resources migration.
- Re-running a migration task is safe and will have less cost of operation as the initial migration and is an expected operation.

### Roles Migration

Important notes:

- V2 default roles (user, admin, …) will **NOT** be migrated since v3 will have its own set of these resources.
- Roles will have only their names (capitalized) migrated, **no color nor permissions will be migrated**.

In other terms, migrated roles will have the v3 default permissions values assigned.

Administrators are then required to create an admin account on v3, login with and go into the administrative panel and make the desired changes manually.

To migrate all of your v2 roles to v3, please run the following command:

```bash
sudo docker exec -it greenlight-v2 bundle exec rake migrations:roles
```

The output should be similar to this when the migration process succeeds:

![Untitled](/images/greenlight/v3/migration/Untitled%206.png)

*It’s expected to have a different output on your system since you’d have different resources.*

An example of a failing migration would be like:

![Untitled](/images/greenlight/v3/migration/Untitled%207.png)

Here, role One failed to be migrated but roles Two and Three successfully propagated to v3.

Re-running the process can help resolve the issue.

### Users Migration

Important notes:

- Pending, denied and deleted users will **NOT** be migrated.
- Administrators on v2 will be administrators on v3.
- Migrated users will be verified on Greenlight v3 by default since they will be requested to reset their passwords through a reset email.
- Both external and local users will be migrated.
- Only users names, email addresses and languages will propagate to v3.
- Migrated users will have their v2 roles assigned (**which requires migrating roles first**).

To migrate all of your v2 users to v3, please run the following command:

```bash
sudo docker exec -it greenlight-v2 bundle exec rake migrations:users
```

The output should be similar to this when the migration process succeeds:

![Untitled](/images/greenlight/v3/migration/Untitled%208.png)

*It’s expected to have a different output on your system since you’d have different resources.*

An example of a failing migration would be like:

![Untitled](/images/greenlight/v3/migration/Untitled%209.png)

Here, users User and User1 failed to migrate to v3 but the rest of users successfully migrated.

Re-running the process can help resolve the issue.

To migrate only a portion of users starting from **START_ID** to **END_ID,** consider running this command instead**:**

```bash
sudo docker exec -it greenlight-v2 bundle exec rake migrations:users[**START_ID, END_ID**]
```

*Note: The partitioning is based on resources id value and not their position in the database, so calling **rake migrations:users[1, 100]** will not migrate the first 100 active users but rather active users having an id of 1 to 100 if existed.*

*Administrators can leverage the current design to migrate resources in parallel, the same migration task can be run in separate processes each migrating a portion of the resources class simultaneously.*

### Rooms Migration

Important notes:

- **Only** rooms for active users will be migrated (e.g. a room of a denied user will be **ignored**) since only active users will be migrated.
- **Migrated rooms will be assigned to their respective migrated users on v3 (which requires migrating users first).**
- Rooms name, uid, bbb_id, last_session will only be migrated.
- Rooms settings, presentations and shared access will not propagate from v2 to v3, so migrated rooms will have v3 the default configurations assigned.

To migrate all of your v2 rooms to v3, please run the following command:

```bash
sudo docker exec -it greenlight-v2 bundle exec rake migrations:rooms
```

The output should be similar to this when the migration process succeeds:

![Untitled](/images/greenlight/v3/migration/Untitled%2010.png)

An example of a failing migration would be like:

![Untitled](/images/greenlight/v3/migration/Untitled%2011.png)

Here, all rooms successfully migrated to v3 except room “**Three”** and “**Admin - room**”.

Re-running the process can help resolve the issue.

To migrate only a portion of users starting from **START_ID** to **END_ID,** consider running this command instead**:**

```bash
sudo docker exec -it greenlight-v2 bundle exec rake migrations:rooms[**START_ID, END_ID**]
```

*Note: The partitioning is based on resources id value and not there position in the database, so calling **rake migrations:rooms[1, 100]** will not migrate the first 100 active users rooms but rather active users rooms having an id of 1 to 100 if existed.*

*Administrators can leverage the current design to migrate resources in parallel, the same migration task can be run in separate processes each migrating a portion of the resources class simultaneously.*
