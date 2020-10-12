scp:
	rsync -auvz --progress . root@${TESTHOST}:/root/openvpn

getclient:
	mkdir -p client
	rsync root@vpnserver:/root/client/ca.crt ./client
	rsync root@vpnserver:/root/client/client.ovpn ./client
	rsync root@vpnserver:/root/client/hfclient.crt ./client
	rsync root@vpnserver:/root/client/hfclient.key ./client
