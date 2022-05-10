#!/bin/bash

exec 3>&1 4>&2
trap 'exec 2>&4 1>&3' 0 1 2 3
exec 1>/tmp/log.out 2>&1

# IoT Edge configuration file
CONFIGFILE="/etc/aziot/config.toml"

# Check if it exists
if [[ ! -f "$CONFIGFILE" ]]; then
    echo "Configuration file could not be found."
    exit 1
fi

echo "Starting..."

# Create a copy of the configuration file in case things break
cp $CONFIGFILE ${CONFIGFILE}.bak

# Find the line containing "connection_string" and replace it with a new line entirely: "connection_string=..."
if [[ $? -eq 0 ]]; then
    sed -i '/connection_string/c\connection_string="CONNSTRING_PLACEHOLDER"' $CONFIGFILE
    echo "Connection string has been changed."
else
    echo "Could not create a backup file. Aborting."
    exit 1
fi

# Apply the new configuration
if [[ $? -eq 0 ]]; then
    echo "Applying new configuration..."
    iotedge config apply

    if [[ $? -ne 0 ]]; then
        echo "Something went wrong with applying... rolling back."
        cp ${CONFIGFILE}.bak $CONFIGFILE

        iotedge config apply
    fi

    exit 0
else
    echo "Error replacing connection string."
    exit 1
fi