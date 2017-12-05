# Cannot connect to local postgres DB


mac OS version: High Sierra
postgres version: 10.1

After upgrading to postgres 10.1, when I was trying to connect to it, I got this error

```
psql: could not connect to server: No such file or directory
Is the server running locally and accepting
connections on Unix domain socket "/tmp/.s.PGSQL.5432"?
```

**Solution**

rm -rf /usr/local/var/postgres && initdb /usr/local/var/postgres -E utf8