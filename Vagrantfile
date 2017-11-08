Vagrant.configure("2") do |config|
  #config.vm.hostname = "agt01"
  config.vm.box = "ubuntu/trusty64"
  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.synced_folder 'shared', '/mnt/v'
  config.vm.synced_folder '.aws', '/home/vagrant/.aws'
  config.vm.synced_folder '.ssh', '/home/vagrant/.ssh'
  config.vm.synced_folder '.terraform.d', '/home/vagrant/.terraform.d'
  config.vm.synced_folder 'terraform', '/home/vagrant/terraform'
  config.vm.synced_folder '.config', '/home/vagrant/.config'
  #config.ssh.forward_x11 = true
  config.vm.provider 'virtualbox' do |vb|
     vb.gui = false
     vb.memory = '2048'
  end
end
