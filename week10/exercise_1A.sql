CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name TEXT,
  credit NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  currency TEXT NOT NULL DEFAULT 'RUB'
);

-- Insert 3 accounts with 1000 RUB credit each
INSERT INTO accounts (name, credit) VALUES
  ('Account 1', 1000.00),
  ('Account 2', 1000.00),
  ('Account 3', 1000.00);

-- Create Transactions
BEGIN;

-- T1: Account 1 send 500 RUB to Account 3
UPDATE accounts SET credit = credit - 500.00 WHERE id = 1;
UPDATE accounts SET credit = credit + 500.00 WHERE id = 3;

-- T2: Account 2 send 700 RUB to Account 1
UPDATE accounts SET credit = credit - 700.00 WHERE id = 2;
UPDATE accounts SET credit = credit + 700.00 WHERE id = 1;

-- T3: Account 2 send to 100 RUB to Account 3
UPDATE accounts SET credit = credit - 100.00 WHERE id = 2;
UPDATE accounts SET credit = credit + 100.00 WHERE id = 3;

-- Return Credit for all Account
SELECT * FROM accounts;

ROLLBACK; -- Rollback all transactions

