# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "zabbix-2.4"
  config.vm.box_version = "1.0.0"

  config.vm.network "forwarded_port", guest: 80, host: 8080, auto_correct: true
  config.vm.network "forwarded_port", guest: 10050, host: 10050, auto_correct: true
  config.vm.network "forwarded_port", guest: 10051, host: 10051, auto_correct: true
  config.vm.network "forwarded_port", guest: 5432, host: 5432, auto_correct: true
end
