Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-22.04"
    config.ssh.forward_agent = true

    config.vm.network :forwarded_port, guest: 80, host: 8080

    config.vm.provision "shell", inline: <<-'PROVISION'
        set -e
    
        apt-get -yqq update
        apt-get -yqq install git
        
        if [[ -d pelton ]]; then
            cd pelton
            git pull
        else 
            git clone https://github.com/hamptonsmith/pelton2.git pelton
            cd pelton
        fi
     
        APT_CMD='apt-get -yqq' ./bin/pelton-burrow
        
        usermod -a -G microk8s vagrant
        chown -f -R vagrant ~/.kube
    PROVISION
end
