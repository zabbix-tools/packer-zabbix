#!/bin/bash
echo "Installing Vagrant user account..."

useradd -c "Vagrant" -d /home/vagrant -m -s /bin/bash vagrant
echo 'vagrant' | passwd vagrant --stdin

# Configure sudoers
cat >> /etc/sudoers <<EOL
Defaults env_keep="SSH_AUTH_SOCK"

Defaults:vagrant !requiretty
vagrant    ALL=NOPASSWD: ALL
EOL

# Prevent any user from requiring TTY for sudo
sed -i 's/^Defaults\s*requiretty/# Defaults    requiretty/'  /etc/sudoers

# Add vagrant insecure private key for key auth
# Make your own if this is private.
# See http://vagrantup.com/docs/base_boxes.html
mkdir /home/vagrant/.ssh

# Authorize Vagrant insecure key
cat > /home/vagrant/.ssh/authorized_keys <<RSA
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key
RSA

# Common private key
cat > /home/vagrant/.ssh/id_rsa <<RSA
-----BEGIN RSA PRIVATE KEY-----
MIIEpAIBAAKCAQEAw1A/Z2Rlfpo8FW780PMPA0ZeVdLflun2fvPC97/uqG9uXWLM
Nil51ElHrkg0ZEgxyk6SVQh+x5EYAwavZ/fi33SJ6t7ydv0g6MV3KKiybme/okAr
yFRGvJqu6V8TqTtug9VW5dxOPHFH3n1NA2kOmzZiNFaxi4tyEAEAk5pzJnsaLsYs
mibQfGmHI46haZwzwzVRV78XNhz4Q1e97Kf0TbBAoOMQbN4Juf5gjq6dCFuWzbVJ
DUXvAro3BAhIO0mMJ5g0p+tlgjuda6x4ieGbbUv3Jg811IXxPpyqZj8UzE17ki27
+PLdxrMd+8bO5ayDYWX4tVPF9y+1V+NCrl8vEwIDAQABAoIBACDoSmZ/MeKM1ga+
dnY2HZdtqcNIDkf9D30AUR8xBWL3s16koMeXYWF1H1Cr9bfXuhvd9SXCkqnJNoR8
Ad3AlEcV+Y7LFYsaxwqxCoydL8MOU+lgaoAMQwbQARxs2oEu9EXeEhAUeFISvAsu
jWU/tChOl2k+Ghfq3ML5iEFWSoR2+bUDTNe87Z3VhWTEYEd56aap14TAnJmNqEJ2
ur+EaB9D3DxyAeuY153lCtZT5S7dI4eINh2PUVvbO6XCNYUtkGBTWgv+zWulhV/6
RakbApG0s146exj8erU4xcW7MyKv/gYXcG0PV6xrSj9JxbIFTe3pExbKhbl8KJNh
WoCJq0ECgYEA8ZZXfOXTzMpNKUlfwdh+O58BcmQhoM4tqhwAWCmzWKOnpAoHtYum
9mwj2dmbVAHih9sIJMEjFi35AVTg8d3DzC9yLXIn2tGaaWlo1puNQ82hn9lkDB/X
B7CUCyvm/amcZDfqewxeTeXqZFoVS53N1F6SNkBPH3ydh4qgVFxWpNECgYEAzvcv
oO9nJz4d9gbXWhNcil/AXOu6vGsg1MIkgNXBGeL5dfUSYsWD+PMkSAgmihvjO6Gt
PiFCK7Xn8FcmVX+f3ZnvKms0+PGR7Jz1F8R9VulcmkfBzmsy+gXE2sy05lvKn6x8
gbByI8Cg4RPl+qNJAe+bfdXAbi/3ifJPuzmX3qMCgYEA2UL1ZxNhSJjej7S28yN5
UrEKog8+1tjU5FjOTnsiGSMEjlee2zu+aXqTO0WhlQkk6jymtDclELtDZlko+xsP
DL/WlNxGz1kU3pu3dtjpUALLyW+9s9GmlfnNCcbvs0wno1FOBF75KGEOTDVfVWOT
SdvK7hMjlROCr/SRf4yTNyECgYEAycvCKMzEa0Lpu6TX/P+7zz+lM/S0Ulqx3ECf
ju7cJP1l9llJ3/xtvSJ1UbaAvVCLsuzlGhsbhbsLtw+CVQLnQQ6CX33AXKpNecNg
RhhTjZZjsBofIcDsJ1PQqPXHvIPrgNyRWXJNGAcN1ees6UCkQrr5hSwRQF6MoXgd
vZNePLkCgYBxegTwH3tF03kR88nsJbXtP4A2S7GVi0WvbZnCnQley7S+90DGGxOR
lBPkBQW5hjVA0GVHfXq5jlmnU1G7g7OGBjeAEZA2aG3vb+GxOivibEQRE2ToYFaJ
BPK68cF6o0276WkbGibMDoh3hnGEDoDUPLNwZ8bc/QlvRrlzUwYvVw==
-----END RSA PRIVATE KEY-----
RSA

# Common public key
cat > /home/vagrant/.ssh/id_rsa.pub <<RSA
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDDUD9nZGV+mjwVbvzQ8w8DRl5V0t+W6fZ+88L3v+6ob25dYsw2KXnUSUeuSDRkSDHKTpJVCH7HkRgDBq9n9+LfdInq3vJ2/SDoxXcoqLJuZ7+iQCvIVEa8mq7pXxOpO26D1Vbl3E48cUfefU0DaQ6bNmI0VrGLi3IQAQCTmnMmexouxiyaJtB8aYcjjqFpnDPDNVFXvxc2HPhDV73sp/RNsECg4xBs3gm5/mCOrp0IW5bNtUkNRe8CujcECEg7SYwnmDSn62WCO51rrHiJ4ZttS/cmDzXUhfE+nKpmPxTMTXuSLbv48t3Gsx37xs7lrINhZfi1U8X3L7VX40KuXy8T vagrant@centos
RSA

# Fix perms
chown -R vagrant.vagrant /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
chmod 600 /home/vagrant/.ssh/authorized_keys
chmod 600 /home/vagrant/.ssh/id_rsa
chmod 644 /home/vagrant/.ssh/id_rsa.pub
restorecon -FRvv /home/vagrant/.ssh
