#!/bin/bash
clear
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Checking if sudo is installed..."
if dpkg-query -W sudo; then
  sleep 2
  clear
  echo "Done. Installing..."
  sudo apt install apache2 -y > apache2.log 2>&1 &
else
  sleep 2
  clear
  echo "Installing..."
  apt install apache2 -y > apache2.log 2>&1 &
fi

ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
clear
sleep 2
if dpkg-query -W apache2; then
  clear
  echo "Apache2 was successfully installed and is reachable trough http://"$ip4.
else
  clear
  echo "There was a error while the installation. Please contact the support and attach the apache2.log file to your request."
fi

