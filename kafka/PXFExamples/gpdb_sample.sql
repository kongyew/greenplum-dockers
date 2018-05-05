CREATE EXTENSION pxf;
GRANT SELECT ON PROTOCOL pxf TO gpadmin;
GRANT INSERT ON PROTOCOL pxf TO gpadmin;

DROP EXTERNAL TABLE IF EXISTS  pxf_jdbc_postgres_table1;
CREATE EXTERNAL TABLE pxf_jdbc_postgres_table1(id int)
            LOCATION ('pxf://postgres_table1?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://postgres:5432/DBNAME&USER=dbuser&PASS=dbuserpass')
            FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');




DROP EXTERNAL TABLE IF EXISTS  pxf_jdbc_postgres_testpxf;
CREATE EXTERNAL TABLE pxf_jdbc_postgres_testpxf(a int, b text)
                        LOCATION ('pxf://testpxf?PROFILE=JDBC&JDBC_DRIVER=org.postgresql.Driver&DB_URL=jdbc:postgresql://postgres:5432/DBNAME&USER=dbuser&PASS=dbuserpass')
                        FORMAT 'CUSTOM' (FORMATTER='pxfwritable_import');


--  psql -U gpadmin -h localhost gpadmin
-- select * from pxf_jdbc_postgres_testpxf;
