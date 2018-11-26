#!/bin/bash
LOGFILE=script.log
ERRORFILE=script.err

export DEBIAN_FRONTEND=noninteractive
echo -e "[cassandra] \nname=Apache Cassandra \nbaseurl=https://www.apache.org/dist/cassandra/redhat/311x/ \ngpgcheck=0 \nrepo_gpgcheck=0 \ngpgkey=https://www.apache.org/dist/cassandra/KEYS" > /etc/yum.repos.d/cassandra.repo
yum update -y >>$LOGFILE 2>>$ERRORFILE
yum install java-1.8.0-openjdk.x86_64 -y >>$LOGFILE 2>>$ERRORFILE
yum install cassandra -y >>$LOGFILE 2>>$ERRORFILE
iptables -F
systemctl stop firewalld.service
systemctl disable firewalld.service
systemctl start cassandra
systemctl enable cassandra

ip=ifconfig | sed -n '2 p' | awk '{print $2}'

sed -i '/listen_address:/c\listen_address: '10.0.0.5'' /etc/cassandra/conf/cassandra.yaml

sed -i '/- seeds:/c\      - seeds: "10.0.0.5,10.0.0.6"' /etc/cassandra/conf/cassandra.yaml

systemctl restart cassandra
