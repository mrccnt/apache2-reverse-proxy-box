Vagrant.configure("2") do |config|

  config.vm.define "maria" do |maria|
    maria.vm.box = "ubuntu/xenial64"
    maria.vm.hostname = "maria.dev"
    maria.vm.network "public_network", ip: "192.168.1.124"
    maria.vm.synced_folder "./maria", "/vagrant"
    maria.vm.provision :shell, :path => "maria/provision.sh"
    maria.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--name", "MariaDB Host"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.gui = false
    end
  end

  config.vm.define "app" do |app|
    app.vm.box = "ubuntu/xenial64"
    app.vm.hostname = "app.dev"
    app.vm.network "public_network", ip: "192.168.1.123"
    app.vm.synced_folder "./app", "/var/www/app.dev"
    app.vm.provision :shell, :path => "app/provision.sh"
    app.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--name", "Web App"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.gui = false
    end
  end

  config.vm.define "entry" do |entry|
    entry.vm.box = "ubuntu/xenial64"
    entry.vm.hostname = "entry.dev"
    entry.vm.network "public_network", ip: "192.168.1.122"
    entry.vm.synced_folder "./entry", "/var/www/entry.dev"
    entry.vm.provision :shell, :path => "entry/provision.sh"
    entry.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--name", "Entry Server"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
      vb.customize ["modifyvm", :id, "--memory", "2048"]
      vb.gui = false
    end
  end

end