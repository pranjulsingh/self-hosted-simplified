#!/bin/bash
. configs/conf.env
echo "Project Home:"
echo ${PROJECT_HOME_DIR}
running_apps="./configs/applications.conf"

echo "Stopping applications..."
while IFS= read -r line
do
  eval "docker compose -f src/docker-compose/$line/docker-compose.yml --env-file configs/conf.env down"
done < "$running_apps"

echo "Compressing: ${PROJECT_HOME_DIR}/docker-volume"
tar czf ${PROJECT_HOME_DIR}/backups/test_vol_bkp.tar.gz ${PROJECT_HOME_DIR}/docker-volume

echo "Starting applications..."
while IFS= read -r line
do
  eval "docker compose -f src/docker-compose/$line/docker-compose.yml --env-file configs/conf.env up -d"
done < "$running_apps"