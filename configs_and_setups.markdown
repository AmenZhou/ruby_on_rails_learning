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
