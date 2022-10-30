#!/bin/bash
clear
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "
Minecraft Autoinstaller

      ((Menu))

1. Install    2. Update
3. Uninstall  4. Exit"

read Menu
case "$Menu" in
[1] ) clear
# Getting the total RAM
RAM_KB=$(grep MemTotal /proc/meminfo | awk '{print $2}')
RAM_MB=$(expr $RAM_KB / 1024)
      RAM_25=$RAM_MB / 4
      RAM_50=$RAM_MB / 2
      RAM_75=$RAM_MB * 3 / 4
      echo "
                  ((RAM))

      1. 25% ($RAM_25)  2. 50% ($RAM_50)
      3. 50% ($RAM_50)  4. Custom (MB)"

      read RAM
      case "$RAM" in
        [1] ) RAM=$RAM_25;;
        [2] ) RAM=$RAM_50;;
        [3] ) RAM=$RAM_75;;
        [4] ) read RAM;;
      esac
      clear

#Getting the total CPU cores
CPU=$(grep ^cpu\\scores /proc/cpuinfo | uniq |  awk '{print $4}')
      CPU_25=$CPU / 4
      CPU_50=$CPU / 2
      CPU_75=$CPU * 3 / 4
      echo "
                ((CPU))

      1. 25% ($CPU_25)  2. 50% ($CPU_50)
      3. 75% ($CPU_75)  4. Custom (cores)"

      read RAM
      case "$RAM" in
        [1] ) CPU=$CPU_25;;
        [2] ) CPU=$CPU_50;;
        [3] ) CPU=$CPU_75;;
        [4] ) read RAM;;
      esac
      clear

echo "Checking if sudo is installed"
  if dpkg-query -W sudo; then
      echo "Sudo is installed";
  else
      echo "Installing sudo..."
      echo "## Beginning apt install sudo ##" >> MCInstallLog.txt
      apt install sudo -y
  fi
  echo "Checking sudo access"
  sudo echo "Success"
  sleep 1
  echo "CHecking if crontab is installed"
  if dpkg-query -W cron; then
      echo "Cron is installed";
  else
      echo "Installing cron..."
      echo "## Beginning apt install cron ##" >> MCInstallLog.txt
      sudo apt install cron -y
  fi
  sleep 1
  echo "Checking if screen is installed"
  if dpkg-query -W screen; then
      echo "Screen is installed";
  else
      echo "Installing screen"
      echo "## Beginning apt install screen ##" >> MCInstallLog.txt
      sudo apt install screen -y
      echo startup_message off >> /etc/screenrc;
  fi
  sleep 2
  echo "Checking if zip is installed"
  if dpkg-query -W zip; then
      echo "Zip is installed";
  else
      echo "Installing zip"
      echo "## Beginning apt install zip ##" >> MCInstallLog.txt
      sudo apt install zip -y;
  fi
  sleep 1
  echo "Checking if rdiff/rdiff-backup is installed"
  if dpkg-query -W rdiff; then
      echo "rdiff is installed";
  else
      echo "Installing rdiff"
      sudo apt-get install rdiff -y