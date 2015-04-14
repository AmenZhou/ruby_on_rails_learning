### psql

**restore psql dump file**

`psql -U username -d database_name -f backup.sql`

`pg_restore -C -U username -d database -h host -p port -f file.dump`

 http://www.postgresql.org/docs/9.1/static/app-pgrestore.html

**backup psql**

`pg_dump -U username -c -N postgis -N topology  database_name > backup.sql`

**change login user password**

`\password postgres`

**create new user**

`CREATE USER dbuser WITH PASSWORD 'password';`

**create database**

`CREATE DATABASE exampledb OWNER dbuser;`

**privilege**

`GRANT ALL PRIVILEGES ON DATABASE exampledb to dbuser;`

**connect**

`psql -U dbuser -d exampledb -h 127.0.0.1 -p 5432`

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

##### Test Datebase Restruct(Very useful when table columns in test is different from development)

```
rake db:test:clone_structure
```
