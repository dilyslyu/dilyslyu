# nginx代理

### Nginx 的配置系统
- 主配置文件 /usr/local/nginx/conf/nginx.conf
- 辅助配置文件 /usr/local/nginx/conf/vhost
由于除主配置文件 nginx.conf 以外的文件都是在某些情况下才使用的，而只有主配置文件是在任何情况下都被使用的。
---
### 示例配置
```
user  nobody;
    worker_processes  1;
    error_log  logs/error.log  info;

    events {
        worker_connections  1024;
    }

    http {  
        server {  
            listen          80;  
            server_name     www.linuxidc.com;  
            access_log      logs/linuxidc.access.log main;  
            location / {  
                index index.html;  
                root  /var/www/linuxidc.com/htdocs;  
            }  
        }  

        server {  
            listen          80;  
            server_name     www.Androidj.com;  
            access_log      logs/androidj.access.log main;  
            location / {  
                index index.html;  
                root  /var/www/androidj.com/htdocs;  
            }  
        }  
    }

    mail {
        auth_http  127.0.0.1:80/auth.php;
        pop3_capabilities  "TOP"  "USER";
        imap_capabilities  "IMAP4rev1"  "UIDPLUS";

        server {
            listen     110;
            protocol   pop3;
            proxy      on;
        }
        server {
            listen      25;
            protocol    smtp;
            proxy       on;
            smtp_auth   login plain;
            xclient     off;
        }
    }

```
nginx 是一种代理服务器，通过conf配置文件将域名和网站绑定在一起，一个server代表一个网站的配置，主要设置server_name、网站及网站访问日志目录、location加载页面及一些规则匹配设置。
