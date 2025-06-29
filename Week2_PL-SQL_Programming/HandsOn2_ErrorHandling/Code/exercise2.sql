SET SERVEROUTPUT ON;

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Accounts';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -942 THEN NULL;
      ELSE RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE Customers';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -942 THEN NULL;
      ELSE RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE '
        CREATE TABLE Customers (
          CustomerID NUMBER PRIMARY KEY,
          Name VARCHAR2(100),
          DOB DATE,
          Balance NUMBER,
          LastModified DATE,
          IsVIP VARCHAR2(5)
        )
      ';
   DBMS_OUTPUT.PUT_LINE('Table "Customers" created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
         DBMS_OUTPUT.PUT_LINE('Table "Customers" already exists.');
      ELSE
         DBMS_OUTPUT.PUT_LINE('Error creating Customers table: ' || SQLERRM);
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE '
        CREATE TABLE Accounts (
          AccountID NUMBER PRIMARY KEY,
          CustomerID NUMBER,
          Balance NUMBER,
          LastModified DATE,
          FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
        )
      ';
   DBMS_OUTPUT.PUT_LINE('Table "Accounts" created successfully.');
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE = -955 THEN
         DBMS_OUTPUT.PUT_LINE('Table "Accounts" already exists.');
      ELSE
         DBMS_OUTPUT.PUT_LINE('Error creating Accounts table: ' || SQLERRM);
      END IF;
END;
/

BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) VALUES (101, 'Alice Wonder', TO_DATE('1990-01-10', 'YYYY-MM-DD'), 2000, SYSDATE, 'Yes');
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified, IsVIP) VALUES (102, 'Bob Builder', TO_DATE('1985-07-22', 'YYYY-MM-DD'), 500, SYSDATE, 'No');
    INSERT INTO Accounts (AccountID, CustomerID, Balance, LastModified) VALUES (1001, 101, 2000, SYSDATE);
    INSERT INTO Accounts (AccountID, CustomerID, Balance, LastModified) VALUES (1002, 102, 500, SYSDATE);
    COMMIT;
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Sample data inserted into Customers and Accounts tables.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error during data insertion: ' || SQLERRM);
        ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE SafeTransferFunds(
  p_fromAcc NUMBER,
  p_toAcc NUMBER,
  p_amount NUMBER
) IS
  v_balance NUMBER;
BEGIN
  SELECT Balance INTO v_balance FROM Accounts WHERE AccountID = p_fromAcc FOR UPDATE;

  IF v_balance < p_amount THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error: Insufficient funds in source account.');
  END IF;

  UPDATE Accounts
  SET Balance = Balance - p_amount,
      LastModified = SYSDATE
  WHERE AccountID = p_fromAcc;

  UPDATE Accounts
  SET Balance = Balance + p_amount,
      LastModified = SYSDATE
  WHERE AccountID = p_toAcc;

  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_amount || ' from ' || p_fromAcc || ' to ' || p_toAcc || ' completed successfully.');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error: One of the accounts does not exist. Transaction rolled back.');
  WHEN OTHERS THEN
    ROLLBACK;
    DBMS_OUTPUT.PUT_LINE('Error during fund transfer: ' || SQLERRM || '. Transaction rolled back.');
END;
/

DECLARE
    v_bal1 NUMBER;
    v_bal2 NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Starting SafeTransferFunds');
    
    SELECT Balance INTO v_bal1 FROM Accounts WHERE AccountID = 1001;
    SELECT Balance INTO v_bal2 FROM Accounts WHERE AccountID = 1002;
    DBMS_OUTPUT.PUT_LINE('Initial Balances => Account 1001: ' || v_bal1 || ' | Account 1002: ' || v_bal2);
    
    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--> Test 1: Performing a valid transfer of 300 from 1001 to 1002...');
    SafeTransferFunds(p_fromAcc => 1001, p_toAcc => 1002, p_amount => 300);
    SELECT Balance INTO v_bal1 FROM Accounts WHERE AccountID = 1001;
    SELECT Balance INTO v_bal2 FROM Accounts WHERE AccountID = 1002;
    DBMS_OUTPUT.PUT_LINE('Balances after Test 1 => Account 1001: ' || v_bal1 || ' | Account 1002: ' || v_bal2);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--> Test 2: Attempting to transfer 2000 from Account 1001 (which has insufficient funds)...');
    SafeTransferFunds(p_fromAcc => 1001, p_toAcc => 1002, p_amount => 2000);
    SELECT Balance INTO v_bal1 FROM Accounts WHERE AccountID = 1001;
    SELECT Balance INTO v_bal2 FROM Accounts WHERE AccountID = 1002;
    DBMS_OUTPUT.PUT_LINE('Balances after Test 2 => Account 1001: ' || v_bal1 || ' | Account 1002: ' || v_bal2 || ' (Should be unchanged)');

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--> Test 3: Attempting to transfer from a non-existent account (9999)...');
    SafeTransferFunds(p_fromAcc => 9999, p_toAcc => 1002, p_amount => 100);

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'Complete');
END;
/