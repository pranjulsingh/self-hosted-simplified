# Samba-Share

Alpine based docker image for Samba Share file server which enables file sharing accross different operating systems over a network.

- [Docker Hub](https://hub.docker.com/r/prpranjul/samba-share)


### Usage
Create a smb.conf file following the standard samba config structure and mount the smb.conf file to the container location /etc/samba/smb.conf
<br>
- [Samba Configruation Structure](https://www.samba.org/samba/docs/using_samba/ch06.html)

### smb.conf
Below is an example smb.conf file
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

Here are some example snippets to help you get started creating a container.

### docker-compose.yml
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
Container images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate <external>:<internal> respectively. For example, -p 8080:80 would expose port 80 from inside the container to be accessible from the host's IP on port 8080 outside the container.
Parameters | Function
--- | ---
-p 445 | Active Directory TCP
-p 139 | NetBIOS TCP
-v /etc/samba/smb.conf | samba share config file
-v /data | shared directory
-e credentials='user1 password1' | user credentials


## To build image locally
```bash
git clone https://github.com/pranjulsingh/self-hosted-simplified.git
cd self-hosted-simplified/src/docker-files/samba-share
docker build . --tag samba-share
```