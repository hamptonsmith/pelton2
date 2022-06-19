Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-22.04"
    config.ssh.forward_agent = true

    config.vm.provision "shell", inline: <<-'PROVISION'
        apt update -yqq
        apt install -yqq git
        
        
    PROVISION
    
    
    config.vm.provision :shell, :inline =>
    "sudo mkdir -p /root/.ssh && sudo cp /home/vagrant/.ssh/authorized_keys /root/.ssh/"

  # config.vm.network :forwarded_port, guest: 80, host: 8080
  # config.vm.synced_folder "../data", "/vagrant_data"
end
