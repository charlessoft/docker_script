sed -i 's/PermitRootLogin.*/PermitRootLogin\ yes/g' /etc/ssh/sshd_config
service sshd restart


