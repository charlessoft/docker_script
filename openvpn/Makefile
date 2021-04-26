scp:
	rsync -auvz --progress . root@${TESTHOST}:/root/openvpn

getclient:
	mkdir -p client
	rsync root@vpnserver:/root/client/ca.crt ./client
	rsync root@vpnserver:/root/client/client.ovpn ./client
	rsync root@vpnserver:/root/client/hfclient.crt ./client
	rsync root@vpnserver:/root/client/hfclient.key ./client
remote_install_rsync:
	ssh root@${TESTHOST} ' \
		yum install rsync -y \
		'
sshkey:
	ssh-copy-id -i ~/.ssh/id_rsa.pub root@${TESTHOST}

init: sshkey remote_install_rsync scp
remote_install:
	ssh root@${TESTHOST} ' \
		cd openvpn \
		sh install.sh \
		sh ovpn_config_server.sh \
		'
