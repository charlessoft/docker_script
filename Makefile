docker_build:
	mv docker docker_${TRAVIS_BRANCH}
	tar zcvf docker_script_${TRAVIS_BRANCH}.tar.gz docker_${TRAVIS_BRANCH}
mysql_build:
	mv mysql mysql_${TRAVIS_BRANCH}
	tar zcvf mysql_script_${TRAVIS_BRANCH}.tar.gz mysql_${TRAVIS_BRANCH}
mongo_build:
	mv mongo mongo_${TRAVIS_BRANCH}
	tar zcvf mongo_script_${TRAVIS_BRANCH}.tar.gz mongo_${TRAVIS_BRANCH}
redis_build:
	mv redis redis_${TRAVIS_BRANCH}
	tar zcvf redis_script_${TRAVIS_BRANCH}.tar.gz redis_${TRAVIS_BRANCH}
gitlab_build:
	cp -r ./lib ./gitlab
	mv gitlab gitlab_${TRAVIS_BRANCH}
	tar zcvf gitlab_script_${TRAVIS_BRANCH}.tar.gz gitlab_${TRAVIS_BRANCH}
nginx_build:
	cp -r ./lib ./nginx
	mv nginx nginx_${TRAVIS_BRANCH}
	tar zcvf nginx_script_${TRAVIS_BRANCH}.tar.gz nginx_${TRAVIS_BRANCH}
zabbix_build:
	mv zabbix zabbix_${TRAVIS_BRANCH}
	tar zcvf zabbix_script_${TRAVIS_BRANCH}.tar.gz zabbix_${TRAVIS_BRANCH}
	
firewall_build:
	mv firewall firewall_${TRAVIS_BRANCH}
	tar zcvf firewall_script_${TRAVIS_BRANCH}.tar.gz firewall_${TRAVIS_BRANCH}

es_build:
	mv elasticsearch elasticsearch_${TRAVIS_BRANCH}
	tar zcvf elasticsearch_script_${TRAVIS_BRANCH}.tar.gz elasticsearch_${TRAVIS_BRANCH}

logstash_build:
	mv logstash logstash_${TRAVIS_BRANCH}
	tar zcvf logstash_script_${TRAVIS_BRANCH}.tar.gz logstash_${TRAVIS_BRANCH}

kibana_build:
	mv kibana kibana_${TRAVIS_BRANCH}
	tar zcvf kibana_script_${TRAVIS_BRANCH}.tar.gz kibana_${TRAVIS_BRANCH}

filebeat_build:
	mv filebeat filebeat_${TRAVIS_BRANCH}
	tar zcvf filebeat_script_${TRAVIS_BRANCH}.tar.gz filebeat_${TRAVIS_BRANCH}

ci_build:
	cp -r ./lib ./jenkins
	cp -r jenkins ./ci
	cp -r ./lib ./gitlab
	cp -r gitlab ./ci
	mv ci ci_${TRAVIS_BRANCH}
	tar zcvf ci_script_${TRAVIS_BRANCH}.tar.gz ci_${TRAVIS_BRANCH}
jenkins_build:
	cp -r ./lib ./jenkins
	mv jenkins jenkins_${TRAVIS_BRANCH}
	tar zcvf jenkins_script_${TRAVIS_BRANCH}.tar.gz jenkins_${TRAVIS_BRANCH}
wordpress_build:
	cp -r ./lib ./wordpress
	mv wordpress wordpress_${TRAVIS_BRANCH}
	tar zcvf wordpress_script_${TRAVIS_BRANCH}.tar.gz wordpress_${TRAVIS_BRANCH}
build_tar_gz: ci_build mongo_build redis_build gitlab_build jenkins_build nginx_build mysql_build wordpress_build docker_build \
	zabbix_build \
	firewall_build \
	es_build \
	logstash_build \
	kibana_build \
	filebeat_build 


ci:
	curl -v -X POST "http://jenkins:c253a297a64fbf61269ea19b37bdc58c@114.116.83.37:9090/job/docker_script/buildWithParameters/" -d TRAVIS_BRANCH=latest
push:
	rsync -auvz --progress  . chenqian@106.14.227.239:/tmp/docker_script
