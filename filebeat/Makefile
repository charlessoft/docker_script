run:
	sh stop_service.sh && \
		rm -fr ./ret/zls_filebeat.txt && \
		touch ./ret/zls_filebeat.txt && \
		sh start_service.sh 

tail:
	tail -f ./ret/zls_filebeat.txt 
