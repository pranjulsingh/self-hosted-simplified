# self-hosted-simplified
The goal of this project is to provide a simple deployment of common self hosted application from single line of command.

Like!!! (to quickly deploy applications with default config)
```bash
wget https://raw.githubusercontent.com/pranjulsingh/self-hosted-simplified/main/env_setup.sh
sudo sh env_setup.sh
cd self-hosted-simplified
sh deploy.sh
```

## List of applications ready for deployment
- cloudflared
- duplicati
- filebrowser
- firefly
- heimdall
- jellyfin
- nextcloud
- portainer
- samba-share
- syncthing
- wallabag

## How to configure
<i>
configs/conf.env
</i> file contains default parameters required for the deployment of all the applications.
<br>
Update the required parameters that you want to change.
A one line comment is mentioned above each parameter that can help you identify the use of particular parameter
<br>

## Folder structure
Add folder structure here

## How docker volumes are maintained
Add docker volume information here

## Backup
Add backup details and strategy here

## Restore
Add restore details and procedure here

## Future plans
- Add more applications
- Improve security
- Make fault taulrent
- Implement container orchestration
- Make it more simple installation
- Make installation process interactive