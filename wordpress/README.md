# wordpress

链接 mysql ,可以使用mysql目录中脚本


## plugs 
### JWT AUTH
1.  需要在 wp-config.php 中增加以下内容


    ```
     //是否启用 JWT AUTH
     define('JWT_AUTH_CORS_ENABLE', true);
     // JWT AUTH 密钥
     define('JWT_AUTH_SECRET_KEY', '2+H_MtCG?8)kAPYV/iME-M44<og>5|G$EZJNB|<fUUZ>-kFb!3Y%H.F7k.Cu1+R2');

    ```
2. 设置.htaccess
```
 # BEGIN WordPress
 # 在`BEGIN WordPress`与`END WordPress`之间的指令（行）是
 # 动态生成的，只应被WordPress过滤器修改。
 # 任何对标记之间的指令的修改都会被覆盖。
 SetEnvIf Authorization "(.*)" HTTP_AUTHORIZATION=$1

 <IfModule mod_rewrite.c>
 RewriteEngine On
 RewriteBase /
 RewriteRule ^index\.php$ - [L]
 RewriteCond %{REQUEST_FILENAME} !-f
 RewriteCond %{REQUEST_FILENAME} !-d
 RewriteRule . /index.php [L]
 </IfModule>

 # END WordPress

 # BEGIN WP JWT Auth
```
