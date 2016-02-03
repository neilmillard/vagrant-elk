# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Use VM Memory size if set as Env variable, otherwise default to 2GB
  if ENV['vm_mem']
    $vm_mem = ENV['vm_mem']
  else
    puts "Environment variable: 'vm_mem' is not set, defaulting to '2048'"
    $vm_mem = '2048'
  end

  config.vm.box = "centos70-x86_64-20150116"
  config.vm.box_url = "https://github.com/holms/vagrant-centos7-box/releases/download/7.1.1503.001/CentOS-7.1.1503-x86_64-netboot.box"
  config.vm.provider "virtualbox" do |v|
    v.customize ["modifyvm", :id, "--memory", "#{$vm_mem}"]
  end

  config.ssh.forward_agent = true
  config.vm.network "private_network", ip: "192.168.200.201"
  config.vm.network :forwarded_port, guest: 5601, host: 5601
  config.vm.network :forwarded_port, guest: 9200, host: 9200
  config.vm.network :forwarded_port, guest: 9300, host: 9300

  # Use a proxy if environment variables are set.
  if ENV['internet_proxy_host']
    config.proxy.http = "http://#{ENV['internet_proxy_host']}:#{ENV['internet_proxy_port']}"
    config.proxy.https = "http://#{ENV['internet_proxy_host']}:#{ENV['internet_proxy_port']}"
    config.proxy.no_proxy = "localhost,127.0.0.1"

    puts "Using proxy http://#{ENV['internet_proxy_host']}:#{ENV['internet_proxy_port']}"
  else
    puts "Not using a proxy"
  end
  
  config.vm.provision "shell", path: 'setup.sh'
  config.vm.provision "puppet" do |puppet|
    puppet.manifests_path    = "puppet/manifests"
    puppet.module_path       = "/etc/puppet/modules"
    puppet.hiera_config_path = "puppet/hiera/hiera.yaml"
    puppet.working_directory = "/etc/puppet"
    puppet.manifest_file: "default.pp"
  end
end
