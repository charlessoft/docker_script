// 设置数据库账号密码
var db_user='pyspider'
var db_password = 'pyapss'
var dbs=['taskdb','projectdb','resultdb','totaldb','spider','invalidsitelogdb','totalstarturldb']
//========================================
dbs.forEach(function(db_name){
    print(db_name)
    var cur_db=db.getSiblingDB(db_name);
    var bexist=cur_db.getUser(db_user)
    if (bexist == null){
        print(db_name+ " 不存在用户,创建用户" + db_user);
        cur_db.createUser({user: db_user, pwd: db_password, roles: [{role: "readWrite", db: db_name}] })

    }
    else{
        print(db_name +  " 已存在用户" + db_user )
    }
}
)

