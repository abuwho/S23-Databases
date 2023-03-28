CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  name TEXT,
  credit NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  currency TEXT NOT NULL DEFAULT 'RUB',
  bank_name TEXT NOT NULL DEFAULT ''
);

CREATE TABLE fees (
  id SERIAL PRIMARY KEY,
  amount NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  transaction_type TEXT NOT NULL DEFAULT '',
  bank_name TEXT NOT NULL DEFAULT ''
);

-- Insert 3 accounts with 1000 RUB credit each
INSERT INTO accounts (name, credit, bank_name) VALUES
  ('Account 1', 1000.00, 'SberBank'),
  ('Account 2', 1000.00, 'Tinkoff'),
  ('Account 3', 1000.00, 'SberBank');

-- Create Transactions
BEGIN;

-- T1: Account 1 send 500 RUB to Account 3 (internal transaction)
UPDATE accounts SET credit = credit - 500.00 WHERE id = 1;
UPDATE accounts SET credit = credit + 500.00 WHERE id = 3;
INSERT INTO fees (amount, transaction_type, bank_name) VALUES (0.00, 'internal', 'SberBank');

-- T2: Account 2 send 700 RUB to Account 1 (external transaction)
UPDATE accounts SET credit = credit - 700.00 WHERE id = 2;
UPDATE accounts SET credit = credit + 670.00 WHERE id = 1; -- deduct 30 RUB fee for external transaction
INSERT INTO fees (amount, transaction_type, bank_name) VALUES (30.00, 'external', 'Tinkoff');

-- T3: Account 2 send to 100 RUB to Account 3 (external transaction)
UPDATE accounts SET credit = credit - 100.00 WHERE id = 2;
UPDATE accounts SET credit = credit + 70.00 WHERE id = 3; -- deduct 30 RUB fee for external transaction
INSERT INTO fees (amount, transaction_type, bank_name) VALUES (30.00, 'external', 'Tinkoff');

-- Return Credit and Fees for all Accounts
SELECT * FROM accounts;
SELECT * FROM fees;

ROLLBACK; -- Rollback all transactions
