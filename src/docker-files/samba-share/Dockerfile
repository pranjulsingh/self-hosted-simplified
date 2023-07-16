FROM alpine:latest
COPY create-users.sh /create-users.sh
RUN apk update && apk add samba && chmod +x /create-users.sh
CMD sh /create-users.sh && chmod -R 777 /mnt && sleep infinity
