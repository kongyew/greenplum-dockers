DROP TABLE IF EXISTS regr_example;
CREATE TABLE regr_example (
   id int,
   y int,
   x1 int,
   x2 int
);
INSERT INTO regr_example VALUES
   (1,  5, 2, 3),
   (2, 10, 7, 2),
   (3,  6, 4, 1),
   (4,  8, 3, 4);

DROP TABLE IF EXISTS patients;

CREATE TABLE patients( id INTEGER NOT NULL,
                          second_attack INTEGER,
                          treatment INTEGER,
                          trait_anxiety INTEGER);

INSERT INTO patients VALUES
   (1,  1, 1, 70),
   (2,  1, 1, 80),
   (3,  1, 1, 50),
   (4,  1, 0, 60),
   (5,  1, 0, 40),
   (6,  1, 0, 65),
   (7,  1, 0, 75),
   (8,  1, 0, 80),
   (9,  1, 0, 70),
   (10, 1, 0, 60),
   (11, 0, 1, 65),
   (12, 0, 1, 50),
   (13, 0, 1, 45),
   (14, 0, 1, 35),
   (15, 0, 1, 40),
   (16, 0, 1, 50),
   (17, 0, 0, 55),
   (18, 0, 0, 45),
   (19, 0, 0, 50),
   (20, 0, 0, 60);

  
