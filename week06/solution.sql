CREATE TABLE records (
  orderId INT,
  itemId INT,
  quantity INT,
  PRIMARY KEY (orderId)
);

CREATE TABLE items (
  itemId INT PRIMARY KEY,
  itemName VARCHAR(15),
  price DECIMAL(5,2)
);

CREATE TABLE customers (
  customerId INT PRIMARY KEY,
  customerName VARCHAR(15),
  city VARCHAR(15)
);

CREATE TABLE orders (
  orderId INT PRIMARY KEY,
  customerId INT,
  date DATE,
  FOREIGN KEY (customerId) REFERENCES customer(customerId)
);

