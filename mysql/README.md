# mysql 启动脚本

默认设置 ut8bm4 字符集

客户端也需要同样设置,

python 写法
```
DATABASE_URL=mysql+mysqldb://root:root@114.115.238.1:3306/wxcrawl?charset=utf8mb4
```

需要设置允许登录ip, 参考auth_ip.sh


增量回滚
```
mysqlbinlog --start-position=154 /tmp/mysql-bin/mysql-bin.000001 | mysql -u root -p
```
