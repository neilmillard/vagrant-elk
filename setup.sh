#!/usr/bin/bash
# this script installs the puppet modules we need

sudo yum install -y wget redhat-lsb-core
# install puppet
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-el-7.noarch.rpm
sudo yum -y install puppet

mkdir -p /etc/puppet/modules
if [ ! -d /etc/puppet/modules/java ]; then
 sudo puppet module install puppetlabs-java
fi
if [ ! -d /etc/puppet/modules/elasticsearch ]; then
 sudo puppet module install elasticsearch-elasticsearch
fi
if [ ! -d /etc/puppet/modules/logstash ]; then
 sudo puppet module install elasticsearch-logstash
fi
if [ ! -d /etc/puppet/modules/kibana4 ]; then
 sudo puppet module install lesaux-kibana4
fi
# get my module from git. puppet module only support forge installs
if [ ! -d /etc/puppet/modules/elk ]; then
  sudo git clone https://github.com/neilmillard/puppet-elk.git /etc/puppet/modules/elk
fi

# This is replace by lesaux-kibana4 puppet module
#if [ ! -f /etc/init.d/kibana ]; then
# sudo cp /vagrant/kibana4_init /etc/init.d/kibana
# sudo sed -i 's/\r//' /etc/init.d/kibana
# sudo chmod +x /etc/init.d/kibana
# sudo update-rc.d kibana defaults
# wget -q http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz http://download.maxmind.com/download/geoip/database/asnum/GeoIPASNum.dat.gz
#fi
