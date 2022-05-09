#!/bin/bash

# IoT Edge configuration file
CONFIGFILE="/etc/aziot/config.toml"


# Check if it exists
if [[ ! -f "$CONFIGFILE" ]]; then
    echo "Configuration file could not be found."
    exit 1
fi

# Create a copy of the configuration file in case things break
cp $CONFIGFILE ${CONFIGFILE}.bak

# Find the line containing "connection_string" and replace it with a new line entirely: "connection_string=..."
sed -i '/connection_string/c\connection_string="CONNSTRING_PLACEHOLDER"' $CONFIGFILE

# Apply the new configuration
if [[ $? -eq 0 ]]; then
    echo "Configuration successfully changed. Applying..."
    iotedge config apply
    exit 0
else
    echo "Error replacing connection string."
    exit 1
fi