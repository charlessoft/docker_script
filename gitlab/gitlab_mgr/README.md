# gitlab管理


## 前提条件
1. 获取原始gitlab root access token
2. 获取原始gitlab jenins 账号密码
3. 获取目标gitlab root access token
4. 获取目标gitlab jenins 账号密码


## 相关命令
  python gitlabmgr.py namespace_list --获取所有命名空间
  python gitlabmgr.py project_create --namespace_id=xxx --name=hello  --创建工程,namespace_id由**namespace_list**获得
  python gitlabmgr.py project_list  --获取所有项目列表,以表格方式展示
  python gitlabmgr.py project_remove --id=xxx --删除项目,id由**project_list**获得
  
  
## api 返回参数

```
{
	'id': 33,
	'description': '运检crf',
	'name': 'yj-extract',
	'name_with_namespace': 'basin / yj-extract',
	'path': 'yj-extract',
	'path_with_namespace': 'basin/yj-extract',
	'created_at': '2018-10-18T06:27:16.752Z',
	'default_branch': 'master',
	'tag_list': [],
	'ssh_url_to_repo': 'ssh://git@47.100.219.148:10023/basin/yj-extract.git',
	'http_url_to_repo': 'http://47.100.219.148:10000/basin/yj-extract.git',
	'web_url': 'http://47.100.219.148:10000/basin/yj-extract',
	'readme_url': None,
	'avatar_url': None,
	'star_count': 0,
	'forks_count': 0,
	'last_activity_at': '2018-10-18T09:18:11.823Z',
	'namespace': {
		'id': 3,
		'name': 'basin',
		'path': 'basin',
		'kind': 'group',
		'full_path': 'basin',
		'parent_id': None
	},
	'_links': {
		'self': 'http://47.100.219.148:10000/api/v4/projects/33',
		'issues': 'http://47.100.219.148:10000/api/v4/projects/33/issues',
		'merge_requests': 'http://47.100.219.148:10000/api/v4/projects/33/merge_requests',
		'repo_branches': 'http://47.100.219.148:10000/api/v4/projects/33/repository/branches',
		'labels': 'http://47.100.219.148:10000/api/v4/projects/33/labels',
		'events': 'http://47.100.219.148:10000/api/v4/projects/33/events',
		'members': 'http://47.100.219.148:10000/api/v4/projects/33/members'
	},
	'archived': False,
	'visibility': 'internal',
	'resolve_outdated_diff_discussions': None,
	'container_registry_enabled': True,
	'issues_enabled': True,
	'merge_requests_enabled': True,
	'wiki_enabled': True,
	'jobs_enabled': True,
	'snippets_enabled': False,
	'shared_runners_enabled': True,
	'lfs_enabled': True,
	'creator_id': 2,
	'import_status': 'none',
	'open_issues_count': 0,
	'public_jobs': True,
	'ci_config_path': None,
	'shared_with_groups': [],
	'only_allow_merge_if_pipeline_succeeds': False,
	'request_access_enabled': True,
	'only_allow_merge_if_all_discussions_are_resolved': None,
	'printing_merge_request_link_enabled': True,
	'merge_method': 'merge',
	'permissions': {
		'project_access': None,
		'group_access': None
	}
}
```