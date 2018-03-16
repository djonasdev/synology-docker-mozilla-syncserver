# Mozilla Firefox Sync Server Docker image
Docker image for [Mozilla Sync Server](https://github.com/mozilla-services/syncserver)

## Introduction
The special feature of this container is to configure the **User and Group ID** of the running docker container. To use the existing user permissions of a `Synology` this is extremely important!

## Quickstart

1. [OPTIONAL] Create a group for all Docker users in Control Panel: **G-Docker**
2. [OPTIONAL] Create a user to run the Docker image: **Docker-FirefoxSync**
3. [OPTIONAL] Adjust folder permissions to the new user
4. Use `Putty` to connect to `Synology`
5. Find `ID` of the user (step 2)
```bash
id -u Docker-FirefoxSync
1000
```
6. Start container once from the `Console`. This will be deposited in the Docker app on the `Synology` (under the tab Image). It is important to use the `ID` (step 5) because of folder permissions.

```bash
docker run -p 5000:5000 -e UID='1000' -e GID='1000' -v /data:/your/custom/path/on/Synology djonasdev/synology-docker-mozilla-syncserver
```
7. A new container has now been created on `Synology` in the Docker app. This can now be renamed and modified.
8. You're done! The container is now always started with the previously used **User and Group ID**.


This image will automatically create a configuration file for
 Mozilla Syncserver with `SQLite Database`.
 
## Detailed description of image and containers

### Used ports

This image uses 1 tcp ports:
* 5000 - Standart port of Mozilla Syncserver 

### Volume
This image uses one volume with internal path `/data`, it will store `configuration file` and `SQLite Database` there.

### Web server configuration

Mozilla Syncserver could work without any web-server, but I'd recommend you to use some web-server of your host machine to add HTTPS support.

For frontend webserver configuration you can read official [Mozilla Syncserver manual](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#running-behind-a-web-server)


## Firefox configuration

To configure desktop Firefox to talk to your new Sync server, go to `about:config`, search for `identity.sync.tokenserver.uri` and change its value to the URL of your server with a path of `token/1.0/sync/1.5`:

    identity.sync.tokenserver.uri: http://sync.example.com/token/1.0/sync/1.5

More details you can find in [Official Manual](https://docs.services.mozilla.com/howtos/run-sync-1.5.html#running-the-server)

## License

This Dockerfile and scripts are released under [MIT License](https://github.com/dojo90/synology-docker-mozilla-syncserver/blob/master/LICENSE).

[Mozilla Syncserver](https://github.com/mozilla-services/syncserver) has its own license.