### psql

###### restore psql dump file
psql -U username -d database_name -f backup.sql  

###### backup psql 
pg_dump -U username -c -N postgis -N topology  database_name > backup.sql 
