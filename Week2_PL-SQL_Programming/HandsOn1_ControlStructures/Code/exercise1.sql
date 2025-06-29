SET SERVEROUTPUT ON;

BEGIN
   DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Creating Schema');
   EXECUTE IMMEDIATE '
     CREATE TABLE Customers (
         CustomerID NUMBER PRIMARY KEY,
         Name VARCHAR2(100),
         DOB DATE,
         Balance NUMBER,
         IsVIP VARCHAR2(5) DEFAULT ''FALSE'',
         LastModified DATE
     )';
   DBMS_OUTPUT.PUT_LINE('Table "Customers" created.');

   EXECUTE IMMEDIATE 'CREATE TABLE Accounts (AccountID NUMBER PRIMARY KEY, CustomerID NUMBER, AccountType VARCHAR2(20), Balance NUMBER, LastModified DATE, FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID))';
   EXECUTE IMMEDIATE 'CREATE TABLE Transactions (TransactionID NUMBER PRIMARY KEY, AccountID NUMBER, TransactionDate DATE, Amount NUMBER, TransactionType VARCHAR2(10), FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID))';
   EXECUTE IMMEDIATE 'CREATE TABLE Loans (LoanID NUMBER PRIMARY KEY, CustomerID NUMBER, LoanAmount NUMBER, InterestRate NUMBER, StartDate DATE, EndDate DATE, FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID))';
   EXECUTE IMMEDIATE 'CREATE TABLE Employees (EmployeeID NUMBER PRIMARY KEY, Name VARCHAR2(100), Position VARCHAR2(50), Salary NUMBER, Department VARCHAR2(50), HireDate DATE)';
   DBMS_OUTPUT.PUT_LINE('All other tables created.');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred during schema creation: ' || SQLERRM);
END;
/

BEGIN
   INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) VALUES (1, 'Senior Sam', TO_DATE('1960-01-15', 'YYYY-MM-DD'), 8000, SYSDATE, 'FALSE');
   INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) VALUES (2, 'Richie Rich', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 25000, SYSDATE, 'FALSE');
   INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) VALUES (3, 'Dorian Dave', TO_DATE('1985-05-15', 'YYYY-MM-DD'), 5000, SYSDATE, 'FALSE');
   INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) VALUES (4, 'Jane Doe', TO_DATE('1992-02-02', 'YYYY-MM-DD'), 1500, SYSDATE, 'FALSE');
   INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (101, 1, 10000, 6.0, SYSDATE, ADD_MONTHS(SYSDATE, 24)); -- Belongs to Senior Sam
   INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (102, 2, 50000, 4.5, SYSDATE, ADD_MONTHS(SYSDATE, 60)); -- Belongs to Richie Rich
   INSERT INTO Loans (LoanID, CustomerID, LoanAmount, InterestRate, StartDate, EndDate) VALUES (103, 3, 2000, 7.0, ADD_MONTHS(SYSDATE, -11), SYSDATE + 25); -- Due in 25 days
   
   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Sample data inserted successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred during data insertion: ' || SQLERRM);
        ROLLBACK;
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 1: Applying Loan Discount');
  FOR rec IN (
    SELECT c.Name, l.LoanID, l.InterestRate
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE FLOOR(MONTHS_BETWEEN(SYSDATE, c.DOB) / 12) > 60
  ) LOOP
    UPDATE Loans
    SET InterestRate = InterestRate - 1
    WHERE LoanID = rec.LoanID;
    
    DBMS_OUTPUT.PUT_LINE('Applied 1% discount to Loan ' || rec.LoanID || ' for customer ' || rec.Name || '. New Rate: ' || (rec.InterestRate - 1) || '%');
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Loan discount process completed.');
END;
/

BEGIN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 2: Updating VIP Status');
  FOR rec IN (
    SELECT CustomerID, Name, Balance
    FROM Customers
    WHERE Balance > 10000 AND IsVIP = 'FALSE'
  ) LOOP
    UPDATE Customers
    SET IsVIP = 'TRUE'
    WHERE CustomerID = rec.CustomerID;
    DBMS_OUTPUT.PUT_LINE('Customer ' || rec.Name || ' (Balance: ' || rec.Balance || ') promoted to VIP.');
  END LOOP;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('VIP status update process completed.');
END;
/

DECLARE
  v_found BOOLEAN := FALSE;
BEGIN
  DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Scenario 3: Sending Loan Reminders');
  FOR rec IN (
    SELECT c.Name, l.LoanID, l.EndDate
    FROM Loans l
    JOIN Customers c ON l.CustomerID = c.CustomerID
    WHERE l.EndDate BETWEEN SYSDATE AND SYSDATE + 30
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('REMINDER: Hello ' || rec.Name || ', your loan (ID: ' || rec.LoanID || ') is due on ' || TO_CHAR(rec.EndDate, 'DD-MON-YYYY') || '.');
    v_found := TRUE;
  END LOOP;
  
  IF NOT v_found THEN
    DBMS_OUTPUT.PUT_LINE('No loans are due in the next 30 days.');
  END IF;
  
  DBMS_OUTPUT.PUT_LINE('Loan reminder process completed.');
END;
/