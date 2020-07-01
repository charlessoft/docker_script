# mysql 启动脚本

默认设置 ut8bm4 字符集

客户端也需要同样设置,

python 写法
```
DATABASE_URL=mysql+mysqldb://root:root@114.115.238.1:3306/wxcrawl?charset=utf8mb4
```



增量回滚
```
mysqlbinlog --start-position=154 /tmp/mysql-bin/mysql-bin.000001 | mysql -u root -p
```


设置运行ip访问
需要填写ip和密码
```
GRANT ALL PRIVILEGES ON *.* TO 'root'@'172.17.%.%' IDENTIFIED BY 'pa44w0rd' WITH GRANT OPTION;
flush privileges;
```
