#!/bin/bash

if [ $(dpkg-query -W -f='${Status}' software-properties-common 2>/dev/null | grep -c "ok installed") -eq 0 ]; then
  echo -n "Updating sources . . . "
  sudo apt-get -y install software-properties-common &> /dev/null
  echo "deb http://httpredir.debian.org/debian stretch main" | sudo tee -a /etc/apt/sources.list &> /dev/null
  echo "APT::Default-Release \"jessie\";" | sudo tee -a /etc/apt/apt.conf.d/default-release &> /dev/null
  sudo apt-get update &> /dev/null
  echo "done!"

  echo -n "Installing ansible . . . "
  sudo apt-get -y -t stretch install ansible &> /dev/null
  sudo apt-get -y install sshpass &> /dev/null
  echo "done!"
fi

grep -q '\/ansible$' /home/vagrant/.bashrc
if [ $? -ne 0 ]; then
  echo -n "Setting default PWD to /ansible ... "
  echo -e "\ncd /ansible" >> /home/vagrant/.bashrc
  echo "done!"
fi

echo -n "Installing ansible roles . . . "
sudo ansible-galaxy install -r /ansible/playbooks/requirements.txt --ignore-errors &> /dev/null
echo "done!"
