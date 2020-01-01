build:
	echo "build"
push:
	# rsync -auvz --progress  . basin@node1.huawei:/home/basin/BasinSpace/gitlab_mgr
	rsync -auvz --progress  . chenqian@gw1.csp.ali:/mnt/tmp/gitlab_mgr

namespace_list:
	python gitlabmgr.py namespace_list
project_list:
	python gitlabmgr.py project_list

create_proj:
	python gitlabmgr.py  project_create --namespace=basin --name=ggzy
	
job_list:
	python jenkinsmgr.py jobs_list

job_create:
	python jenkinsmgr.py job_create --name=test1 --gitlab_url=ssh://git@gitlab.basin.server:10023/base/helloworld.git

job_delete:
	python jenkinsmgr.py job_delete --name=test1

clean:
	rm -fr gitrepo
	rm -fr *.csv
	rm -fr nohup.out
	rm -fr __pycache__
