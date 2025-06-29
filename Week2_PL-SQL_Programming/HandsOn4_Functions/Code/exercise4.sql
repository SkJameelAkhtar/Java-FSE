BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE Transactions';
    EXECUTE IMMEDIATE 'DROP TABLE Accounts';
    EXECUTE IMMEDIATE 'DROP TABLE Loans';
    EXECUTE IMMEDIATE 'DROP TABLE Customers';
    EXECUTE IMMEDIATE 'DROP TABLE Employees';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

-- Schema Creation
CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
); 

INSERT INTO Customers VALUES (1, 'John Doe', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 1000, SYSDATE);
INSERT INTO Customers VALUES (2, 'Jane Smith', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 1500, SYSDATE);

INSERT INTO Accounts VALUES (1, 1, 'Savings', 1000, SYSDATE);
INSERT INTO Accounts VALUES (2, 2, 'Checking', 1500, SYSDATE);

INSERT INTO Transactions VALUES (1, 1, SYSDATE, 200, 'Deposit');
INSERT INTO Transactions VALUES (2, 2, SYSDATE, 300, 'Withdrawal');

INSERT INTO Loans VALUES (1, 1, 5000, 5, SYSDATE, ADD_MONTHS(SYSDATE, 60));

INSERT INTO Employees VALUES (1, 'Alice Johnson', 'Manager', 70000, 'HR', TO_DATE('2015-06-15', 'YYYY-MM-DD'));
INSERT INTO Employees VALUES (2, 'Bob Brown', 'Developer', 60000, 'IT', TO_DATE('2017-03-20', 'YYYY-MM-DD'));

-- Scenario 1: Calculate Age
CREATE OR REPLACE FUNCTION CalculateAge(dob DATE) RETURN NUMBER IS
    age NUMBER;
BEGIN
    age := TRUNC(MONTHS_BETWEEN(SYSDATE, dob) / 12);
    RETURN age;
END;
/

DECLARE
    age1 NUMBER;
    age2 NUMBER;
BEGIN
    age1 := CalculateAge(TO_DATE('1985-05-15', 'YYYY-MM-DD'));
    age2 := CalculateAge(TO_DATE('1990-07-20', 'YYYY-MM-DD'));
    DBMS_OUTPUT.PUT_LINE('Age of John Doe: ' || age1);
    DBMS_OUTPUT.PUT_LINE('Age of Jane Smith: ' || age2);
END;
/

-- Scenario 2: Calculate Monthly Installment
CREATE OR REPLACE FUNCTION CalculateMonthlyInstallment(
    loanAmount NUMBER,
    interestRate NUMBER,
    years NUMBER
) RETURN NUMBER IS
    r NUMBER := interestRate / (12 * 100);
    n NUMBER := years * 12;
    emi NUMBER;
BEGIN
    IF r = 0 THEN
        emi := loanAmount / n;
    ELSE
        emi := loanAmount * r * POWER(1 + r, n) / (POWER(1 + r, n) - 1);
    END IF;
    RETURN ROUND(emi, 2);
END;
/

DECLARE
    emi NUMBER;
BEGIN
    emi := CalculateMonthlyInstallment(5000, 5, 5);
    DBMS_OUTPUT.PUT_LINE('Monthly Installment: ' || emi);
END;
/

-- Scenario 3: Check Sufficient Balance
CREATE OR REPLACE FUNCTION HasSufficientBalance(accID NUMBER, amt NUMBER) RETURN BOOLEAN IS
    bal NUMBER;
BEGIN
    SELECT Balance INTO bal FROM Accounts WHERE AccountID = accID;
    RETURN bal >= amt;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN FALSE;
END;
/

DECLARE
    result1 BOOLEAN;
    result2 BOOLEAN;
BEGIN
    result1 := HasSufficientBalance(1, 500);
    result2 := HasSufficientBalance(2, 2000);
    IF result1 THEN
        DBMS_OUTPUT.PUT_LINE('Account 1 has sufficient balance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 1 does NOT have sufficient balance');
    END IF;

    IF result2 THEN
        DBMS_OUTPUT.PUT_LINE('Account 2 has sufficient balance');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account 2 does NOT have sufficient balance');
    END IF;
END;
/
