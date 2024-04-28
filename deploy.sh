#!/bin/bash
apps_to_deploy="./configs/applications.conf"
while IFS= read -r line
do
  eval "docker compose -f src/docker-compose/$line/docker-compose.yml --env-file configs/conf.env up -d"
done < "$apps_to_deploy"