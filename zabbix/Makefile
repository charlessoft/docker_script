scp:
	rsync -auvz --progress . root@192.168.31.100:/tmp/zabbix
stop:
	sh stop_zabbix.sh

start:
	sh start_zabbix.sh

restart:
	sh stop_zabbix.sh
	sh start_zabbix.sh

log_agent:
	tail -f /var/log/zabbix/zabbix_agentd.log
