# -*- mode: ruby -*-
# vi: set ft=ruby :

# Use vagrant up to setup the box.
# vagrant ssh if you need to edit anything on the server
# vagrant destroy to start over from scratch
# As i standard with vagrant machines, the
# vagrant user has passwordless sudo access on the guest machine

Vagrant.configure("2") do |config|

  # Ubuntu 14.04 Server 64-bit box supporting VirtualBox and VMware providers. 
  # For other boxes, see https://vagrantcloud.com/boxcutter
  config.vm.box = "boxcutter/ubuntu1404"
  config.vm.hostname = "vagrant.example.com"
  config.vm.provision "shell", path: 'setup.sh'
  config.vm.provision "shell", path: 'setup-user.sh', privileged: false
  config.vm.provision :reload # https://github.com/aidanns/vagrant-reload

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.synced_folder '.', '/home/vagrant/setup'

  # Order of preffered providers
  config.vm.provider "virtualbox"
  config.vm.provider "vmware"
  config.vm.provider "vmware_fusion"
  config.vm.provider "digital_ocean"

  # https://github.com/smdahlen/vagrant-digitalocean/
  # Use "DO_TOKEN=<token> vagrant up --provider=digital_ocean" to setup a
  # droplet on DigitalOcean, not a Virtualbox/Vmware guest.
  # vagrant destroy: Destroys the droplet instance.
  # vagrant halt: Powers off the droplet instance.
  # vagrant provision: Runs the configured provisioners and rsyncs any specified config.vm.synced_folder.
  # vagrant reload: Reboots the droplet instanc.
  # vagrant rebuild: Destroys the droplet instance and recreates it with the 
  #   same IP address is was assigned to previously.
  # vagrant status: Outputs the status (active, off, not created) for the droplet instance.
  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    # https://cloud.digitalocean.com/settings/applications > Personal Access Tokens
    provider.token = ENV['DO_TOKEN']
    # vagrant digitalocean-list images $DIGITAL_OCEAN_TOKEN
    provider.image = 'ubuntu-14-04-x64'
    # vagrant digitalocean-list regions $DIGITAL_OCEAN_TOKEN
    provider.region = 'lon1'
    # vagrant digitalocean-list sizes $DIGITAL_OCEAN_TOKEN
    provider.size = '512mb'
  end
end
