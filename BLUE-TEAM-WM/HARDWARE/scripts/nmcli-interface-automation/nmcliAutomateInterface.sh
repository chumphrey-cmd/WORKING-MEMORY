#!/bin/bash

KIT_NUM="124"

INTERFACE="eno1"
IP_ADDRESS="10.${KIT_NUM}.101.100"
GATEWAY="10.${KIT_NUM}.101.1"
DNS1="10.${KIT_NUM}.101.10"
DNS2="10.${KIT_NUM}.101.11"
SEARCH_DOMAIN="${KIT_NUM}cpt.cpb.mil"


# Check if the script is being run as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# Interface Selection Menu
select_interface() {
    echo "Select the interface to configure:"
    select INTERFACE in $(nmcli con show | grep -v NAME | awk '{print $1}')
    do
        break
    done
}

# Check if the interface is already configured
echo "Checking if interface ${INTERFACE} is already configured..."
if [ "$(nmcli con show ${INTERFACE} | grep -c ${IP_ADDRESS})" -ne 0 ]
  then if [ "$(nmcli con show ${INTERFACE} | grep -c ${GATEWAY})" -ne 0 ]
    then echo "Interface ${INTERFACE} is already configured with IP address ${IP_ADDRESS} and gateway ${GATEWAY}."
    exit
  fi
fi
echo "Interface ${INTERFACE} is not configured with IP address ${IP_ADDRESS} and gateway ${GATEWAY}."

# Configure the interface
echo "Configuring interface ${INTERFACE}..."
sudo nmcli con mod ${INTERFACE} ipv4.addresses ${IP_ADDRESS}/24
sudo nmcli con mod ${INTERFACE} ipv4.gateway ${GATEWAY}
sudo nmcli con mod ${INTERFACE} ipv4.dns "${DNS1} ${DNS2}"
sudo nmcli con mod ${INTERFACE} ipv4.method manual
sudo nmcli con mod ${INTERFACE} connection.autoconnect yes

# Restart the network service
echo "Restarting the network service..."
sudo nmcli con down ${INTERFACE}
sudo nmcli con up ${INTERFACE}

# Verify the interface configuration
echo "Verifying the interface configuration..."
ip addr show ${INTERFACE}
