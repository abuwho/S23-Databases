-- Exercise 1

CREATE TABLE records (
  orderId INT,
  itemId INT,
  quantity INT,
  PRIMARY KEY (orderId)
);

CREATE TABLE items (
  itemId INT,
  itemName VARCHAR(15),
  price NUMERIC(10,2),
  PRIMARY KEY (itemId)
);

CREATE TABLE customers (
  customerId INT,
  customerName VARCHAR(15),
  city VARCHAR(15),
  PRIMARY KEY (customerId)
);

CREATE TABLE orders (
  orderId INT,
  customerId INT,
  date DATE,
  PRIMARY KEY (orderId),
  FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

INSERT INTO records VALUES 
  ('2301', '3786', '3'),
  ('2301', '4011', '6'),
  ('2301', '9132', '8'),
  ('2302', '5794', '4'),
  ('2303', '4011', '2'),
  ('2303', '3141', '2');

INSERT INTO items VALUES 
  ('3786', 'Net', 35.00),
  ('4011', 'Racket', 65.00),
  ('9132', 'Pack-3', 4.75),
  ('5794', 'Pack-6', 5.00),
  ('3141', 'Cover', 10.00);

INSERT INTO customers VALUES 
  ('101', 'Martin', 'Prague'),
  ('107', 'Herman', 'Madrid'),
  ('110', 'Pedro', 'Moscow');

INSERT INTO orders VALUES 
  ('2301', '101', '2011-02-23'),
  ('2302', '107', '2011-02-25'),
  ('2303', '110', '2011-02-27');


-- Exercise 2

CREATE TABLE loan_books
	(school VARCHAR(50),
    teacher VARCHAR(30),
    course VARCHAR(40),
    room VARCHAR(10),
    grade VARCHAR(15),
    book VARCHAR(60),
    publisher VARCHAR(30),
    loanDate DATE,
	PRIMARY KEY (school)
	);
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Logical Thinking', '1.A01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Writing', '1.A01', '1st grade', 'Preschool, N56', 'Taylor & Francis Publishing', '2010-05-05');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Chad Russell', 'Numerical thinking', '1.A01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-05');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'E.F.Codd', 'Spatial, Temporal and Causal Thinking', '1.B01', '1st grade', 'Early Childhood Education N9', 'Prentice Hall', '2010-05-06');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'E.F.Codd', 'Numerical thinking', '1.B01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Jones Smith', 'Writing', '1.A01', '2nd grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-09-09');
INSERT INTO loan_books VALUES ('Horizon Education Institute', 'Jones Smith', 'English', '1.A01', '2nd grade', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-05-05');
INSERT INTO loan_books VALUES ('Bright Institution', 'Adam Baker', 'Logical Thinking', '2.B01', '1st grade', 'Know how to educate: guide for Parents and Teachers', 'McGraw Hill', '2010-12-18');
INSERT INTO loan_books VALUES ('Bright Institution', 'Adam Baker', 'Numerical Thinking', '2.B01', '1st grade', 'Learning and teaching in early childhood education', 'BOA Editions', '2010-05-06');

