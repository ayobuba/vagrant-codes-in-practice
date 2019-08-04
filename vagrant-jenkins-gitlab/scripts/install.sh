#!/usr/bin/env bash
yum clean all && yum update -y
yum -y install epel-release && yum -y install bash-completion net-tools bind-utils wget telnet vim expect gcc-c++ make jq unzip nfs-utils sshpass java-1.8.0-openjdk.x86_64 java-1.8.0-openjdk-devel.x86_64 curl policycoreutils-python openssh-server postfix
sed -i.bak -e 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i.bak -e 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
sed -i.bak -e 's/keepcache=0/keepcache=1/' /etc/yum.conf

systemctl start postfix && systemctl enable postfix
systemctl restart sshd
systemctl stop firewalld && sudo systemctl disable firewalld

echo "export JAVA_HOME=/usr/lib/jvm/$(ls /usr/lib/jvm/ | grep java-1.8.0-openjdk-)" >> ~/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/$(ls /usr/lib/jvm/ | grep java-1.8.0-openjdk-)" >> /home/vagrant/.bashrc