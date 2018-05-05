#!/bin/bash
set -e
[[ ${DEBUG} == true ]] && set -x

export GROUP=gpadmin
export USERNAME=gpadmin
export PASS=pivotal
SUCCESS=0

# Create group
if [ $(getent group $GROUP) ]; then
  echo "group $GROUP exists."
else
  echo "group $GROUP does not exist."
  echo "Groupadd gpadmin"
  sudo groupadd gpadmin
fi


# Check if user already exists.
grep -q "$USERNAME" /etc/passwd
if [ $? -eq $SUCCESS ]
then
  echo "User $USERNAME does already exist."
  echo "please chose another username."
else
  sudo useradd -p `mkpasswd "$PASS"` -d /home/"$USERNAME" -m -g users -s /bin/bash "$USERNAME"
  # Alternative : echo "myuser:password" | sudo chpasswd
  echo "the account: $USERNAME is setup"
fi


echo "Now create a HDFS home directory for this gpadmin user"

hadoop dfsadmin -safemode leave
sudo -u hdfs hadoop fs -mkdir -p /user/gpadmin
sudo -u hdfs hadoop fs -chmod -R 755 /user/gpadmin
sudo -u hdfs hadoop fs -chown -R gpadmin:gpadmin /user/gpadmin
