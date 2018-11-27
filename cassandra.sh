#!/bin/bash
#For Ubuntu 16.04 LTS
clear
echo "Installing cassandra ..."
LOGFILE=script.log
ERRORFILE=script.err

export DEBIAN_FRONTEND=noninteractive

apt-get update -y >>$LOGFILE 2>>$ERRORFILE
add-apt-repository ppa:webupd8team/java -y >>$LOGFILE 2>>$ERRORFILE
apt-get update -y >>$LOGFILE 2>>$ERRORFILE

echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | sudo debconf-set-selections
sudo apt-get install -y oracle-java8-installer >>$LOGFILE 2>>$ERRORFILE

echo "deb http://www.apache.org/dist/cassandra/debian 39x main" |  tee /etc/apt/sources.list.d/cassandra.list

gpg --keyserver pgp.mit.edu --recv-keys 749D6EEC0353B12C
gpg --export --armor 749D6EEC0353B12C | apt-key add -
gpg --keyserver pgp.mit.edu --recv-keys A278B781FE4B2BDA
gpg --export --armor A278B781FE4B2BDA | apt-key add -

apt-get update && apt-get upgrade -yuf >>$LOGFILE 2>>$ERRORFILE
apt-get install oracle-java8-set-default cassandra ntp -y >>$LOGFILE 2>>$ERRORFILE
systemctl enable cassandra
systemctl start cassandra
