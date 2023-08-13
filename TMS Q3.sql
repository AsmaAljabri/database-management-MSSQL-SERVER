SELECT FirstName ,LastName FROM Customer WHERE FirstName = 'Thomas'and LastName= 'Hardy';

-- select do a full scan in all tables
-- where index scan will be faster when scan

-- to create index
--CREATE INDEX IN_CUSTOMER_FN
--ON Customer (FirstName);

drop index IN_CUSTOMER_FN on Customer;

CREATE INDEX IN_CUSTOMER_FN_Ls
ON Customer (FirstName, LastName);

drop index IN_CUSTOMER_FN_Ls on Customer;

CREATE INDEX CUSTOMER_FN_cc
ON Customer (FirstName) include (City);

drop index IN_CUSTOMER_FN_cc on Customer;

SELECT FirstName  FROM Customer WHERE FirstName = 'Thomas';

-- view 

CREATE OR ALTER VIEW CUST_VIEW AS
SELECT FirstName, LastName, Country, Phone
FROM Customer;

CREATE OR ALTER VIEW ORDER_VI AS
	SELECT OrderNumber,OrderDate ,TotalAmount
	FROM "Order"
	WHERE TotalAmount <1000;

SELECT * FROM ORDER_VI;


SELECT CONCAT(FirstName ,'  ', LastName) AS FULLNAME
FROM Customer;--CONCAT(X,Y)

SELECT ASCII('A') AS AsciiValue;

SELECT CHAR(65) AS Characte_r;

SELECT CONVERT (VARCHAR(10),GETDATE(),120);
--TABLE NAME PUT BETWEEN [ ] IF THERE IS SPACE 