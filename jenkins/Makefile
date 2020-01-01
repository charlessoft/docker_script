build:
	echo "hello"
push:
	# rsync -auvz --progress  . chenqian@pt4.basin.ali:~/jenkins
#	rsync -auvz --progress  . chenqian@47.100.25.11:/tmp/jenkins
	rsync -auvz --progress  . chenqian@gitlab.basin.site:/tmp/jenkins

clean:
	rm -fr /tmp/opt/lambda
	rm -fr .first
	rm -fr ssh_key
reset: clean
	sh stop_jenkins_service.sh
	sh install_docker_jenkins.sh
	sh start_jenkins_service.sh
