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

CREATE TABLE ledger (
  id SERIAL PRIMARY KEY,
  from_account INTEGER REFERENCES accounts(id),
  to_account INTEGER REFERENCES accounts(id),
  fee NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  amount NUMERIC(10,2) NOT NULL DEFAULT 0.00,
  transaction_datetime TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
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
INSERT INTO ledger (from_account, to_account, fee, amount) VALUES (1, 3, 0.00, 500.00);

-- T2: Account 2 send 700 RUB to Account 1 (external transaction)
UPDATE accounts SET credit = credit - 700.00 WHERE id = 2;
UPDATE accounts SET credit = credit + 670.00 WHERE id = 1; -- deduct 30 RUB fee for external transaction
INSERT INTO ledger (from_account, to_account, fee, amount) VALUES (2, 1, 30.00, 700.00);

-- T3: Account 2 send to 100 RUB to Account 3 (external transaction)
UPDATE accounts SET credit = credit - 100.00 WHERE id = 2;
UPDATE accounts SET credit = credit + 70.00 WHERE id = 3; -- deduct 30 RUB fee for external transaction
INSERT INTO ledger (from_account, to_account, fee, amount) VALUES (2, 3, 30.00, 100.00);

-- Return Credit and Fees for all Accounts
SELECT * FROM accounts;
SELECT * FROM fees;
SELECT * FROM ledger;

ROLLBACK; -- Rollback all transactions