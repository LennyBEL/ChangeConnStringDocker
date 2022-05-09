#Based on: https://github.com/kekru/docker-ssh-server-commands-on-host
FROM ubuntu:20.04
LABEL org.opencontainers.image.authors="lenny.vandewinkel@delaware.pro"

RUN apt-get update && apt-get install ssh -y && apt-get install sshpass -y

COPY resources /data/resources

EXPOSE 22

ENTRYPOINT [ "/data/resources/entrypoint.sh" ]