### Change mysql password
```
mysql -u root mysql
```
```
UPDATE user SET Password=PASSWORD('YOURNEWPASSWORD') WHERE User='root'; FLUSH PRIVILEGES; exit;
```

### Setup mysql daily dump by whenever

1 build a task

```ruby
desc "Backup Database"                                                                                                                                                             
task backup_database: :environment do                                                                                                                                              
  system "mysqldump -u root -h localhost newspaper_box > /home/action/workspace/newspaper_db/mysql_dump_#{Time.now.strftime("%d%m%Y-%H:%M")}.sql"                                  
end  
```

2 Set a Schedule

```ruby
every 1.day, at: '11.58 pm' do                                                                                                                                                     
  rake 'backup_database'                                                                                                                                                           
end  
```

3 Add a mysql config file on ~/ path

```
vim ~/.my.cnf
```

```
[mysqldump]
user = mysqluser
password = secret
```

```
chmod 600 ~/.my.cnf
```

##### /usr/bin/env delete problem

```
sudo apt-get install --reinstall coreutils
```

##### Nginx and Puma

1. Add this line to default nginx config file inside the http block
```
include /home/action/.parts/etc/nginx/sites-enabled/*;
```
remove sever block from default nginx conf file

2. Add config/nginx.conf file
```
upstream sales-assistant {
  server 127.0.0.1:5000 fail_timeout=0;
}

server {                       
  listen 3000;                   
  server_name localhost;
      
  root /home/action/workspace/www/sales-assistant/public;
  index /home/action/workspace/www.sales-assistant/index.html;
  access_log /home/action/.parts/logs/nginx/sales-assistant.log;
  rewrite_log on;
      
  client_max_body_size 4G;     
  keepalive_timeout 5;         
      
  location / {                 
    #all requests are sent to the UNIX socket
    proxy_pass  http://sales-assistant;
    proxy_redirect     off;    
      
    proxy_set_header   Host             $host;
    proxy_set_header   X-Real-IP        $remote_addr;  
    proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;
  
    client_max_body_size       10m; 
    client_body_buffer_size    128k;
  
    proxy_connect_timeout      90;  
    proxy_send_timeout         90;  
    proxy_read_timeout         90;  
  
    proxy_buffer_size          4k;  
    proxy_buffers              4 32k;
    proxy_busy_buffers_size    64k; 
    proxy_temp_file_write_size 64k; 
  }
    
  location ~ ^/(assets)/  {    
    root /home/action/workspace/www/sales-assistant/public;
   # gzip_static on;
    expires max;               
    add_header Cache-Control public;
    break;
  }

  location ~ ^/(uploads)/  {    
    root /home/action/workspace/www/sales-assistant/public;
    #gzip_static on;
    expires max;               
    add_header Cache-Control public;
    break;
  }
  
  # Rails error pages          
  error_page 500 502 503 504 /500.html;
  location = /500.html {
    root /home/action/workspace/www/sales-assistant/public;
  }
}
```

3 generate a soft line under /etc/nginx/sites-enabled from config/nginx

```
ln -s config/nginx /etc/nginx/sites-enabled/app_name.conf
```

4 add config/puma.conf under the project path

```
user = "action"
application = "sales-assistant"
path = "/home/#{user}/workspace/www/sales-assistant"
 
port 5000
threads 0, 4
workers 1

pidfile "#{path}/tmp/pids/puma.#{application}.pid"
stdout_redirect "#{path}/log/puma.stdout", "#{path}/log/puma.stderr", true

preload_app!
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end 
end
```

5 Some nginx commands

```
#start server
nginx

#stop server
nginx -s stop

#test configuration
nginx -t
```

6 Start puma daemon

```
puma --config config/puma.rb -e production -d
```

##### SSL config

1. Put ssl .csr and .key file to project path 
2. config nginx.conf to load that keys
3. add ssl configuration on nginx.conf
4. add force_ssl = true on production.rb
5. redirect all the request from 80 to 443

https://github.com/brtr/group/commit/f30bed6e083c4aa476e72453c0ee344f2de27bc7

###### RapidSSL CA key
https://knowledge.rapidssl.com/support/ssl-certificate-support/index?page=content&actp=CROSSLINK&id=SO26459

Go to this url and copy paste the bundle key, and bundle it with server.crt key.
