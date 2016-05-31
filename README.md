Builds a vagrant machine image
* Local
* openstack

install vagrant, and openstack vagrant provider

download files from git:

Local:
* vagrant up

remote:
* download openstackRC file from dashboard:
* $ source project-openrc.sh
* download a ssh key, store locally
* edit vagrant to add 
  config.vm.provider "openstack" do |os, override|

  [snip]
    override.ssh.private_key_path = "~/.ssh/cinergi_2016.pem" 
  end
* $ vagrant up --provider openstack 