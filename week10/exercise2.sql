CREATE TABLE accounts (
  username TEXT PRIMARY KEY,
  fullname TEXT,
  balance NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  group_id NUMERIC
);


-- Insert 3 accounts with 1000 RUB credit each
INSERT INTO accounts (username, fullname, balance, group_id) VALUES
  ('jones', 'Alice Jones', 82.00, 1),
  ('bitdiddl', 'Ben Bitdiddle', 65.00, 1), 
  ('mike', 'Michael Dole', 73.00, 2), 
  ('alyssa', 'Alyssa P. Hacker', 79.00, 3), 
  ('bbrown', 'Bob Brown', 100.00, 3); 

SELECT * FROM accounts;

