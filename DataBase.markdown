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

##### AWS RDS

**add ssl**

1. download pem http://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem

2. put this file to config/

3. database.yml

  ```
  sslmode: 'verify-full'
  sslrootcert: 'config/amazon-rds-ca-cert.pem'
  ```

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
----------------
##### Test Datebase Restruct(Very useful when table columns in test is different from development)

```
rake db:test:clone_structure
```

##### PG Restore and Backup

```
PGPASSWORD=password pg_restore --verbose --clean --no-acl --no-owner -h hostname -U username -d gopeso gopeso_20150508.dump                                                                                                                                            
PGPASSWORD=password pg_dump -Fc --no-acl --no-owner -h hostname -U username gopeso > gopeso_20150508.dump  
```
----------

### My SQL

You can dump the database into a file using: 
 
```
  mysqldump -h hostname -u user --password=password databasename > filename 
```
 
You can restore the info to the database again using: 

```
  mysql -h hostname -u user --password=password databasename < filename
```

--------

### Syntax error in Mysql 5.7 and above

add a my.cnf file into home directory

```
[mysqld]
sql_mode = STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION
secure-file-priv = ""
```
