Vagrant.configure("2") do |config|

    config.vm.box = "bento/ubuntu-16.04"

    config.vm.provider "virtualbox" do |v|
        v.memory = 4096
        v.cpus = 2
    end

    # Provision for testing builds in local environment
    config.vm.provision :shell, path: "scripts/provision.sh"
end
