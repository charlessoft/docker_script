sed -i 's/PermitRootLogin.*/PermitRootLogin\ no/g' /etc/ssh/sshd_config
service sshd restart


