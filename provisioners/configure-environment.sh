#!/bin/sh
PS1="\[\033[01;32m\]\u@\H\[\033[01;34m\] \w $\[\033[00m\]"

echo "Configuring $ENV_FILE..."
cat >> /etc/environment <<EOL
PS1=$PS1
EOL

echo "Configuring message of the day..."
cat > /etc/motd <<EOL

    ______       ______ ______ _____        
    ___  /______ ___  /____  /____(_)___  __
    __/ / _  __ \`/_  __ \_  __ \_  /__  |/_/
    _/ /__/ /_/ /_  /_/ /  /_/ /  / __>  <  
    /____/\__,_/ /_.___/ _.___/ _/  /_/|_|  
                                            
        «-- developмenт vagranт вoх --»

   http://localhost:8080/zabbix (Admin:zabbix)

EOL

# Disable 5 second grub delay
echo "Configuring boot loader..."
sed -i 's/set timeout=[0-9]*/set timeout=0/' /boot/grub2/grub.cfg
