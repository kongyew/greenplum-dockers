DROP TABLE IF EXISTS  postgres_table1;
CREATE TABLE postgres_table1(id int);


INSERT INTO postgres_table1 VALUES (1);
INSERT INTO postgres_table1 VALUES (2);
INSERT INTO postgres_table1 VALUES (3);


DROP TABLE IF EXISTS  testpxf;

CREATE TABLE testpxf (a int, b text);
INSERT INTO testpxf VALUES (1, 'Cheese');

INSERT INTO testpxf VALUES (2, 'Fish');

INSERT INTO testpxf VALUES (3, 'Chicken');
