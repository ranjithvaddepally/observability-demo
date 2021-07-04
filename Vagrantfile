Vagrant.configure("2") do |config|
  config.vm.box = "geerlingguy/centos7"
  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 80, host: 80
  config.vm.network "forwarded_port", guest: 9441, host: 9441
  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
   vb.name = "observability-demo"

  #
  #   # Customize the amount of memory on the VM:
   vb.memory = "1024"
  end
  config.vm.hostname = "observability-demo"
  config.vm.provision :shell, :path => "metric_logs.sh"
  config.vm.provision :shell, :path => "apm.sh"
end

