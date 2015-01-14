### psql

###### restore psql dump file
psql -U username -d database_name -f backup.sql  

###### backup psql 
pg_dump -U username -c -N postgis -N topology  database_name > backup.sql 

### mysql

###### database.yml

```yml
default: &default                                                                                                                                                                      
  adapter: mysql2                                                                                                                                                                      
  pool: 25                                                                                                                                                                             
  timeout: 5000                                                                                                                                                                        
  encoding: utf8                                                                                                                                                                       
  username: root                                                                                                                                                                       
  password: password                                                                                                                                                                   
  host: 127.0.0.1                                                                                                                                                                      
  socket: /tmp/mysql.sock
```
