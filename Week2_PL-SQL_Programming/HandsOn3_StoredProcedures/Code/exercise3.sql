SET SERVEROUTPUT ON;

BEGIN
    BEGIN EXECUTE IMMEDIATE 'DROP TABLE Transactions'; EXCEPTION WHEN OTHERS THEN NULL; END;
    BEGIN EXECUTE IMMEDIATE 'DROP TABLE Loans'; EXCEPTION WHEN OTHERS THEN NULL; END;
    BEGIN EXECUTE IMMEDIATE 'DROP TABLE Accounts'; EXCEPTION WHEN OTHERS THEN NULL; END;
    BEGIN EXECUTE IMMEDIATE 'DROP TABLE Employees'; EXCEPTION WHEN OTHERS THEN NULL; END;
    BEGIN EXECUTE IMMEDIATE 'DROP TABLE Customers'; EXCEPTION WHEN OTHERS THEN NULL; END;

    EXECUTE IMMEDIATE '
    CREATE TABLE Customers (
        CustomerID NUMBER PRIMARY KEY,
        Name VARCHAR2(100),
        DOB DATE,
        Balance NUMBER,
        LastModified DATE
    )';

    EXECUTE IMMEDIATE '
    CREATE TABLE Employees (
        EmployeeID NUMBER PRIMARY KEY,
        Name VARCHAR2(100),
        Position VARCHAR2(50),
        Salary NUMBER,
        Department VARCHAR2(50),
        HireDate DATE
    )';

    EXECUTE IMMEDIATE '
    CREATE TABLE Accounts (
        AccountID NUMBER PRIMARY KEY,
        CustomerID NUMBER,
        AccountType VARCHAR2(20),
        Balance NUMBER,
        LastModified DATE,
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    )';

    EXECUTE IMMEDIATE '
    CREATE TABLE Transactions (
        TransactionID NUMBER PRIMARY KEY,
        AccountID NUMBER,
        TransactionDate DATE,
        Amount NUMBER,
        TransactionType VARCHAR2(10),
        FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
    )';

    EXECUTE IMMEDIATE '
    CREATE TABLE Loans (
        LoanID NUMBER PRIMARY KEY,
        CustomerID NUMBER,
        LoanAmount NUMBER,
        InterestRate NUMBER,
        StartDate DATE,
        EndDate DATE,
        FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
    )';
    DBMS_OUTPUT.PUT_LINE('Schema created successfully.');
END;
/

INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);
INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified) VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate) VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));
INSERT INTO Employees (EmployeeID, Name, Position, Salary, Department, HireDate) VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) VALUES (1, 1, 'Savings', 1000, SYSDATE);
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) VALUES (2, 2, 'Checking', 1500, SYSDATE);
INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified) VALUES (3, 1, 'Checking', 500, SYSDATE);

INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType) VALUES (1, 1, SYSDATE, 200, 'Deposit');
INSERT INTO Transactions (TransactionID, AccountID, TransactionDate, Amount, TransactionType) VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

COMMIT;

BEGIN
    DBMS_OUTPUT.PUT_LINE('Sample data inserted successfully.');
END;
/

CREATE OR REPLACE PROCEDURE ProcessMonthlyInterest AS
BEGIN
    UPDATE Accounts
    SET Balance = Balance + (Balance * 0.01),
        LastModified = SYSDATE
    WHERE AccountType = 'Savings';
    COMMIT;
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 1: Processing Monthly Interest');
    DBMS_OUTPUT.PUT_LINE('Account Balances BEFORE Interest Calculation:');
    DBMS_OUTPUT.PUT_LINE(RPAD('AccountID', 10) || RPAD('AccountType', 15) || RPAD('Balance', 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 9, '-') || ' ' || RPAD('-', 14, '-') || ' ' || RPAD('-', 9, '-'));
    FOR r_acc IN (SELECT AccountID, AccountType, Balance FROM Accounts WHERE AccountType = 'Savings' ORDER BY AccountID) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(r_acc.AccountID, 10) || RPAD(r_acc.AccountType, 15) || RPAD(r_acc.Balance, 10));
    END LOOP;

    ProcessMonthlyInterest;
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Account Balances AFTER Interest Calculation:');
    DBMS_OUTPUT.PUT_LINE('Balances for Savings accounts updated with 1% interest.');
    DBMS_OUTPUT.PUT_LINE(RPAD('AccountID', 10) || RPAD('AccountType', 15) || RPAD('Balance', 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 9, '-') || ' ' || RPAD('-', 14, '-') || ' ' || RPAD('-', 9, '-'));
    FOR r_acc IN (SELECT AccountID, AccountType, Balance FROM Accounts WHERE AccountType = 'Savings' ORDER BY AccountID) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(r_acc.AccountID, 10) || RPAD(r_acc.AccountType, 15) || RPAD(r_acc.Balance, 10));
    END LOOP;
END;
/

-- Scenario 2: Stored Procedure to implement a bonus scheme for employees.
CREATE OR REPLACE PROCEDURE UpdateEmployeeBonus(
    p_department IN VARCHAR2,
    p_bonus_percentage IN NUMBER
) AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * p_bonus_percentage / 100)
    WHERE Department = p_department;
    COMMIT;
END;
/

DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 2: Updating Employee Bonus');
    UpdateEmployeeBonus('IT', 10);
    DBMS_OUTPUT.PUT_LINE('Salary for employees in IT department updated with a 10% bonus.');
    DBMS_OUTPUT.PUT_LINE(RPAD('EmployeeID', 12) || RPAD('Name', 15) || RPAD('Department', 15) || RPAD('Salary', 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 11, '-') || ' ' || RPAD('-', 14, '-') || ' ' || RPAD('-', 14, '-') || ' ' || RPAD('-', 9, '-'));
    FOR r_emp IN (SELECT EmployeeID, Name, Department, Salary FROM Employees ORDER BY EmployeeID) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(r_emp.EmployeeID, 12) || RPAD(r_emp.Name, 15) || RPAD(r_emp.Department, 15) || RPAD(r_emp.Salary, 10));
    END LOOP;
END;
/

-- Scenario 3: Stored Procedure for customers to transfer funds.
CREATE OR REPLACE PROCEDURE TransferFunds(
    p_from_account_id IN NUMBER,
    p_to_account_id IN NUMBER,
    p_amount IN NUMBER
) AS
    v_from_balance NUMBER;
BEGIN
    SELECT Balance INTO v_from_balance
    FROM Accounts
    WHERE AccountID = p_from_account_id;

    IF v_from_balance >= p_amount THEN
        UPDATE Accounts
        SET Balance = Balance - p_amount, LastModified = SYSDATE
        WHERE AccountID = p_from_account_id;

        UPDATE Accounts
        SET Balance = Balance + p_amount, LastModified = SYSDATE
        WHERE AccountID = p_to_account_id;
        
        DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_amount || ' from Account ' || p_from_account_id || ' to ' || p_to_account_id || ' successful.');
        COMMIT;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Transfer failed. Insufficient funds in Account ' || p_from_account_id || '.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Transfer failed. Invalid account ID specified.');
        ROLLBACK;
END;
/

-- Execution and Output for Scenario 3
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE('Scenario 3: Transferring Funds');
    TransferFunds(1, 3, 150); 
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('Account balances after transfer attempt:');
    DBMS_OUTPUT.PUT_LINE(RPAD('AccountID', 10) || RPAD('CustomerID', 12) || RPAD('Balance', 10));
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 9, '-') || ' ' || RPAD('-', 11, '-') || ' ' || RPAD('-', 9, '-'));
    FOR r_acc IN (SELECT AccountID, CustomerID, Balance FROM Accounts ORDER BY AccountID) LOOP
        DBMS_OUTPUT.PUT_LINE(RPAD(r_acc.AccountID, 10) || RPAD(r_acc.CustomerID, 12) || RPAD(r_acc.Balance, 10));
    END LOOP;
END;
/