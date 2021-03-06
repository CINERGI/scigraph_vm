# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.network "forwarded_port", guest: 9000, host:9000
  config.vm.network "forwarded_port", guest: 3333, host:3333
  config.ssh.username = "ubuntu"
  
  config.vm.provider "virtualbox" do |vb, override|
     vb.name = "SciGraph Example Box"
     vb.memory = "4096"
     override.ssh.username = "vagrant"
     vb.gui = true
  end
  

  # Configure the OpenStack provider for Vagrant
  config.vm.provider "openstack" do |os, override|

    # Specify OpenStack authentication information
	# download openstackRC file from dashboard:
	# $ source project-openrc.sh
    os.openstack_auth_url = "#{ENV['OS_AUTH_URL']}"
    os.username = "#{ENV['OS_USERNAME']}"
    os.password = "#{ENV['OS_PASSWORD']}"
    os.tenant_name = "#{ENV['OS_TENANT_NAME']}"
 
    # Specify instance information
    os.server_name = "SciGraphBox"
    os.flavor = "m1.medium"
    os.image = "Ubuntu 14.04 LTS x86_64"
    #os.floating_ip_pool = "ext-net"
	os.floating_ip=132.249.238.138
    #os.networks = "cinergi_network"
    os.keypair_name = "cinergi_2016"
    os.security_groups = ["default"]
   # Specify the default SSH username and private key
    override.ssh.username = "ubuntu"
    override.ssh.private_key_path = "~/.ssh/cinergi_2016.pem" 
  end

  $shell1 = <<-SHELL
	 sudo mkdir -p /var/scigraph-services/graph
	 sudo chmod ugo+rw /var/scigraph-services/graph
	 sudo chown #{config.ssh.username}:#{config.ssh.username} -R /var/scigraph-services/
	 sudo chown #{config.ssh.username}:#{config.ssh.username} -R  ~/
	 mkdir -p ~/resources
	 sudo chmod ugo+rw ~/resources

     sudo add-apt-repository ppa:openjdk-r/ppa
     sudo apt-get update
     sudo apt-get install -y  openjdk-8-jdk xvfb
	 update-java-alternatives -s java-1.8.0-openjdk-amd64
	 sudo apt-get install -y maven git 
     echo "export DISPLAY=localhost:99" >> .profile
     Xvfb :99 &
     wget –q -o /dev/null https://github.com/OpenRefine/OpenRefine/releases/download/2.5/google-refine-2.5-r2407.tar.gz
     tar -zxf google-refine-2.5-r2407.tar.gz
     rm google-refine-2.5-r2407.tar.gz
     echo "sudo google-refine-2.5/refine -i 0.0.0.0" > runOpenRefine.sh
     chmod ugo+x ~/runOpenRefine.sh


	 sudo chown #{config.ssh.username}:#{config.ssh.username} -R ~/
	 git clone https://github.com/CINERGI/SciGraph.git
	 chown #{config.ssh.username}:#{config.ssh.username} -R  ~/
	 cd SciGraph
	 mvn -DskipTests -DskipITs install
   SHELL
   
  config.vm.provision "shell", privileged: false, inline: $shell1
  
  config.vm.provision "file",  run: "always", source: "./resources/cinergiExample.yml", destination: "resources/cinergiExample.yml"
  config.vm.provision "file",  run: "always", source: "./resources/configuration.yml", destination: "resources/configuration.yml"
  config.vm.provision "file",  run: "always", source: "./runScigraph.sh", destination: "runScigraph.sh"
  config.vm.provision "file",  run: "always", source: "./buildCinergiOntology.sh", destination: "buildCinergiOntology.sh"
  config.vm.provision "file",  run: "always", source: "./startServices.sh", destination: "startServices.sh"

  $shell2 = <<-SHELL2
		chmod +x runScigraph.sh buildCinergiOntology.sh startServices.sh
	     export MAVEN_OPTS='-server -d64 -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+AggressiveOpts -XX:+UseFastAccessorMethods -XX:+UseBiasedLocking -XX:NewRatio=2 -Xms4G -Xmx4G -XX:-ReduceInitialCardMarks'
		 cd SciGraph/SciGraph-core
		 mvn exec:java --quiet -Dexec.mainClass="edu.sdsc.scigraph.owlapi.loader.BatchOwlLoader" -Dexec.args="-c ../../resources/cinergiExample.yml"     
		 cd ../SciGraph-services
		 mvn exec:java  -Dexec.mainClass="edu.sdsc.scigraph.services.MainApplication" -Dexec.args="server ../../resources/configuration.yml" &
       SHELL2
  
  config.vm.provision "shell", privileged: false, run: "always" do |s|
     s.inline= $shell2
  end

end
