srtart:stop
	sh ./start-redis.sh
	sh ./start-postgresql-gitlab.sh
	sh ./start-gitlab.sh
stop:
	-docker rm -f gitlab-redis
	-docker rm -f postgresql-gitlab
	-docker rm -f gitlab

push:
	#rsync -auvz --progress  . chenqian@pt4.basin.ali:~/gitlab
	rsync -auvz --progress  . chenqian@106.14.227.239:/tmp/gitlab
clean: stop
	rm -fr  /tmp/opt/lambda/gitlab

