#Based on: https://github.com/kekru/docker-ssh-server-commands-on-host
FROM ubuntu:20.04
LABEL org.opencontainers.image.authors="lenny.vandewinkel@delaware.pro"

# Update the package manager and install both the SSH client and SSHpass client
RUN apt-get update && apt-get install ssh -y && apt-get install sshpass -y

# Copy the local resources folder to the container's /data/resources folder
COPY resources /data/resources

# Open up port 22
EXPOSE 22

# Execute the entrypoint.sh script as entrypoint
ENTRYPOINT [ "/data/resources/entrypoint.sh" ]