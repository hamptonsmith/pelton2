Vagrant.configure("2") do |config|
    config.vm.box = "bento/ubuntu-22.04"
    config.ssh.forward_agent = true

    config.vm.provider "virtualbox" do |v|
      v.memory = 4096
    end

    config.vm.network :forwarded_port, guest: 80, host: 8080
    config.vm.network :forwarded_port, guest: 3000, host: 8081

    config.vm.provision "shell",
            path: "https://raw.githubusercontent.com/hamptonsmith/pelton2/main/provision-vagrant.sh"
end
