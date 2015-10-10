ZBX_VER_MAJ = 2
ZBX_VER_MIN = 4
ZBX_VER_PATCH = 6

ZBX_VERSION = $(ZBX_VER_MAJ).$(ZBX_VER_MIN).$(ZBX_VER_PATCH)
ZBX_VER_MAJ_MIN = $(ZBX_VER_MAJ).$(ZBX_VER_MIN)

ARCH = $(shell uname -m)

BOXFILE = "zabbix-$(ZBX_VERSION)_$(ARCH)_virtualbox.box"

all: $(BOXFILE)

$(BOXFILE): packer-zabbix.json provisioners/* files/*
	packer build \
		-var 'ver_maj=$(ZBX_VER_MAJ)' \
		-var 'ver_min=$(ZBX_VER_MIN)' \
		-var 'ver_patch=$(ZBX_VER_PATCH)' \
		-var 'ver_maj_min=$(ZBX_VER_MAJ_MIN)' \
		packer-zabbix.json

clean:
	rm -f $(BOXFILE)

install: 
	vagrant box add \
		--force \
		--name zabbix-$(ZBX_VER_MAJ).$(ZBX_VER_MIN) \
		$(BOXFILE)

.PHONY: all clean install
