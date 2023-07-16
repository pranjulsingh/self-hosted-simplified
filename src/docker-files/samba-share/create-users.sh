#!/bin/bash
pos=1
echo $credentials
for temp_cred in $credentials
do
if [ "$(($pos%2))" -eq "1" ]; then
  user=$temp_cred
else
  adduser --disabled-password "$user"
  (echo $temp_cred; echo $temp_cred) | smbpasswd -a $user
fi
pos=$(($pos+1))
done
smbd