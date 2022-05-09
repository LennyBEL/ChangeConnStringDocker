#!/bin/bash


# Find the line containing "connection_string" and replace it with a new line entirely: "connetion_string=..."
sed -i '/connection_string/c\connection_string="CONNSTRING_PLACEHOLDER"' /etc/aziot/config.toml

# Apply the new configuration
iotedge config apply