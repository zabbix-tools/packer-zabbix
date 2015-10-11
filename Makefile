all: zabbix-2.4_x86_64_virtualbox.box

# Zabbix 2.4
zabbix-2.4_x86_64_virtualbox.box: packer-zabbix.json provisioners/* files/*
	packer build \
		-var 'ver_major=2' \
		-var 'ver_minor=4' \
		-var 'ver_patch=6' \
		packer-zabbix.json

install-2.4: zabbix-2.4_x86_64_virtualbox.box
	vagrant box add \
		--force \
		--name zabbix/2.4/centos-7 \
		zabbix-2.4_x86_64_virtualbox.box

# Zabbix 2.2
zabbix-2.2_x86_64_virtualbox.box: packer-zabbix.json provisioners/* files/*
	packer build \
		-var 'ver_major=2' \
		-var 'ver_minor=2' \
		-var 'ver_patch=10' \
		packer-zabbix.json

install-2.2: zabbix-2.2_x86_64_virtualbox.box
	vagrant box add \
		--force \
		--name zabbix/2.2/centos-7 \
		zabbix-2.2_x86_64_virtualbox.box

# delete all box files
clean:
	rm -f zabbix-*_x86_64_virtualbox.box

# aliases
2.4: zabbix-2.4_x86_64_virtualbox.box
2.2: zabbix-2.2_x86_64_virtualbox.box

.PHONY: all clean install-2.2 install-2.4 2.2 2.4
