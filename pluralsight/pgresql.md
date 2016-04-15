###Some Features of Postgresql
1. Partitioning
    * Partitioning refers to splitting what is logically one large table into smaller physical pieces
2. Collation
3. Search Function and Features
    * `to_tsvector`
    * `to_tsquery`
4. Create a Function
    * `CREATE [ OR REPLACE  ] FUNCTION`
5. Tow Types of Index
    * B-tree indexes can also be used to retrieve data in sorted order
    * Hash indexes can only handle simple equality comparisons.
      * `CREATE INDEX name ON table USING HASH (column);`
6. ANALYZE -- collect statistics about a database
7. Vacuum
8. Copy
    * export a table to CSV format file - `\copy (SELECT * FROM table) to FILE_PATH with csv`
9. A configuration table - pg_settings
