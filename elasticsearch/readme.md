
# 测试分词
# 安装分词
docker exec -it myes /bin/bash -c "cd plugins;mkdir analysis;cd analysis;wget -q -O tmp.zip https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v5.4.3/elasticsearch-analysis-ik-5.4.3.zip && unzip tmp.zip && rm tmp.zip"
docker restart myes

# 创建中文分词
```
curl -X PUT 'localhost:9200/accounts' -d '
{
  "mappings": {
    "person": {
      "properties": {
        "user": {
          "type": "text",
          "analyzer": "ik_max_word",
          "search_analyzer": "ik_max_word"
        },
        "title": {
          "type": "text",
          "analyzer": "ik_max_word",
          "search_analyzer": "ik_max_word"
        },
        "desc": {
          "type": "text",
          "analyzer": "ik_max_word",
          "search_analyzer": "ik_max_word"
        }
      }
    }
  }
}'
```
# 备份
curl localhost:9200/_snapshot/accountsbackup -d '
{
"type":"fs",
"settings":{
	"location":"accounts",
	"compress":true
}
}'

# 查询备份配置是否完成
curl localhost:9200/_snapshot

# 查看备份配置
curl XGET localhost:9200/_snapshot/accountsbackup

# 执行备份
curl -XPUT localhost:9200/_snapshot/accountsbackup/snapshot_20200707
curl -XPUT localhost:9200/_snapshot/accountsbackup -d '
{
	"indices":"accounts",
	"ignore_unavailable":true,
	"include_global_state":false
}
'

indices: 备份的索引名
ignore_unavailable 是否需要忽略不可用的切片,如果设置为false,当有切片不可用时,备份会自动停止,
include_global_state 是否同步状态,如果原索引状态是黄色恢复出来也会是黄色,false则为忽略状态

# 新建index

curl -X PUT 'localhost:9200/weather'

# 删除index
curl -X DELETE 'localhost:9200/weather'
