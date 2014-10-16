# -*- mode: ruby -*-
# vi: set ft=ruby :

# Use vagrant up to setup the box.
# vagrant ssh if you need to edit anything on the server
# vagrant destroy to start over from scratch
# As i standard with vagrant machines, the
# vagrant user has passwordless sudo access on the guest machine

Vagrant.configure("2") do |config|

  # Ubuntu 14.04 Server 64-bit box supporting VirtualBox and VMware providers. 
  # For other boxes, see https://vagrantcloud.com/box-cutter
  config.vm.box = "box-cutter/ubuntu1404"
  config.vm.hostname = "vagrant.example.com"
  config.vm.provision "shell", path: 'setup.sh'
  config.vm.provision "shell", path: 'setup-user.sh', privileged: false

  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.synced_folder '.', '/home/vagrant/setup'

  # https://github.com/smdahlen/vagrant-digitalocean
  # Use "DO_TOKEN=<token> vagrant up --provider=digital_ocean" to setup a
  # droplet on DigitalOcean, not a Virtualbox/Vmware guest.
  config.vm.provider :digital_ocean do |provider, override|
    override.ssh.private_key_path = '~/.ssh/id_rsa'
    override.vm.box = 'digital_ocean'
    override.vm.box_url = "https://github.com/smdahlen/vagrant-digitalocean/raw/master/box/digital_ocean.box"
    # https://cloud.digitalocean.com/settings/applications > Personal Access Tokens
    provider.token = ENV['DO_TOKEN']
    provider.image = 'Ubuntu 14.04 x64'
    provider.region = 'ams1'
    provider.size = '512mb'
  end
end
