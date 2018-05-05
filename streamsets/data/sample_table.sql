DROP TABLE IF EXISTS streamsets_example;
CREATE TABLE streamsets_example (
   lastname text,
   age int,
   firstname text
);


INSERT INTO streamsets_example(lastname, age, firstname) VALUES 
('james',  25, 'jim'),
('alex',  75, 'jack'),('brad',  51, 'john');

