#!/bin/bash

# Install yum repos
# Don't use the repo release rpm package as it breaks vagrant cachier by not
# including a version number in the repo ids.
cat > /etc/yum.repos.d/zabbix.repo <<CONF
[zabbix-${ZBX_REPO_VER}]
name=Zabbix Official Repository - \$basearch
baseurl=http://repo.zabbix.com/zabbix/${ZBX_REPO_VER}/rhel/7/\$basearch/
enabled=1
gpgcheck=0

[zabbix-non-supported-${ZBX_REPO_VER}]
name=Zabbix Official Repository non-supported - \$basearch 
baseurl=http://repo.zabbix.com/non-supported/rhel/7/\$basearch/
enabled=1
gpgcheck=0
CONF

# install packages
yum install -y --nogpgcheck \
	postgresql-server \
	zabbix-agent-${ZBX_VERSION} \
	zabbix-server-pgsql-${ZBX_VERSION} \
	zabbix-web-pgsql-${ZBX_VERSION} \
	zabbix-get-${ZBX_VERSION} \
	zabbix-sender-${ZBX_VERSION}

# setup database
postgresql-setup initdb
cat > /var/lib/pgsql/data/pg_hba.conf  <<HBA
# TYPE  DATABASE        USER            ADDRESS                 METHOD
local   all             all                                     peer
host    all             all             127.0.0.1/32            md5
host    all             all             ::1/128                 md5
HBA

sudo -u postgres psql -c "CREATE ROLE zabbix WITH PASSWORD 'zabbix' LOGIN;"
sudo -u postgres psql -c "CREATE DATABASE zabbix WITH OWNER zabbix;"
sudo -u zabbix psql -d zabbix -f /usr/share/doc/zabbix-server-pgsql-${ZBX_VERSION}/create/schema.sql
sudo -u zabbix psql -d zabbix -f /usr/share/doc/zabbix-server-pgsql-${ZBX_VERSION}/create/images.sql
sudo -u zabbix psql -d zabbix -f /usr/share/doc/zabbix-server-pgsql-${ZBX_VERSION}/create/data.sql
systemctl enable postgresql

# configure zabbix server
echo > /etc/zabbix/zabbix_server.conf <<CONF
DBPassword=zabbix
CONF

# configure zabbix web server
cat > /etc/zabbix/web/zabbix.conf.php <<PHP
<?php
// Zabbix GUI configuration file.
global $DB;

$DB['TYPE']     = 'POSTGRESQL';
$DB['SERVER']   = '127.0.0.1';
$DB['PORT']     = '0';
$DB['DATABASE'] = 'zabbix';
$DB['USER']     = 'zabbix';
$DB['PASSWORD'] = 'zabbix';

// Schema name. Used for IBM DB2 and PostgreSQL.
$DB['SCHEMA'] = '';

$ZBX_SERVER      = 'localhost';
$ZBX_SERVER_PORT = '10051';
$ZBX_SERVER_NAME = 'Vagrant Zabbix';

$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
PHP

# enable services
systemctl enable zabbix-agent
systemctl enable zabbix-server
systemctl enable httpd
