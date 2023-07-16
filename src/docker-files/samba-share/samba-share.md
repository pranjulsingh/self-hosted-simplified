# Samba-Share

Alpine based docker image for Samba Share file server which enables file sharing accross different operating systems over a network.

- [Docker Hub](https://hub.docker.com/repository/docker/prpranjul/samba-share/)

## To build image locally
Run below command in the current folder
```bash
docker build . --tag samba-share
```


## smb.conf
create a file /path/to/config/file/smb.conf
and paste below content in the file
```
[data]
path = /data/
public = no
valid users = user1
write list = user1
read only = no

[shared-folder2]
path = /data/shared-folder2/
public = no
valid users = user1 user2
write list = user1 user2
read list = user1 user2
read only = no
```


## docker-compose.yml
```yml
---
version: "2.1"
services:
  samba_share:
    container_name: samba_share
    image: prpranjul/samba-share:latest
    hostname: samba-share
    ports:
      - 445:445
      - 139:139
    volumes: 
      - /path/to/config/file/smb.conf:/etc/samba/smb.conf
      - /path/to/shared/folder:/data
    environment:
      - credentials='user1 password1 user2 password2'
    restart: unless-stopped

```

## docker cli
```bash
docker run -d \
  --name=samba-share \
  -p 445:445 \
  -p 139:139 \
  -v /path/to/config/file/smb.conf:/etc/samba/smb.conf \
  -v /path/to/shared/folder:/data \
  -e credentials='user1 password1 user2 password2' \
  --restart unless-stopped \
  prpranjul/samba-share:latest
```

## Parameters

Parameters | Function
--- | ---
-p 445 | Active Directory TCP
-p 139 | NetBIOS TCP
-v /etc/samba/smb.conf | samba share config file
-v /data | shared directory
-e credentials='user1 password1' | user credentials

