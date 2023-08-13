select * from Customer;
 

select *  from "Order";

select * from OrderItem;

select * from Product;
select * from Supplier;

select DISTINCT City from Customer;
select DISTINCT  CustomerId  from "Order";
select top 10  FirstName, City  from Customer;



select * from "Order" where TotalAmount > 550;
select DISTINCT top 5 *   from "Order" where TotalAmount > 550;


select * from Product 
where UnitPrice = 18 OR UnitPrice =  20 OR UnitPrice = 22; -- OR UNITPRICE IN (18,22,20)

select COUNT(Id) AS COUNTID FROM Customer

SELECT MIN(TotalAmount) ,MAX(TotalAmount) FROM "Order";

SELECT  FirstName FROM Customer
ORDER BY FirstName ASC;    

-- USING MAX(), MIN(), SUM(), AVG() IN SELECT STATEMENT
-- USING ALSO ORDER BY TO ORDER THE OUTCOME DESC OR ASC

SELECT COUNT(Id ) FROM "Order"  where CustomerId = 2;

SELECT COUNT( CustomerId ) AS COUNT_CUSTOMERid , FirstName 
FROM "Order", Customer  
where "Order".CustomerId = Customer.Id and
"Order".OrderDate < '01.01.2013'
Group by Customer.FirstName
HAVING COUNT( CustomerId ) > 5 -- IT HAVE THE AGREGAET FUNCTIONS USING IN "HAVING" AFTER THE WHERE CONDITION
ORDER BY Customer.FirstName ASC;

SELECT TOP 6 FirstName , LastName ,MAX(TotalAmount) aS MAX_TOTALAMOUNT
FROM Customer C ,"Order" O
WHERE O.CustomerId = C.Id
GROUP BY FirstName , LastName 
ORDER BY MAX_TOTALAMOUNT DESC ;

SELECT TOP 5 AVG(UnitPrice)AS AVERAGE, CompanyName FROM Product p, Supplier s
WHERE p.SupplierId = s.Id
GROUP BY CompanyName
ORDER BY AVERAGE ASC;

SELECT COUNT(CompanyName) as NUM_OF_COM, Country FROM Supplier
GROUP BY Country;

SELECT SUM(TotalAmount) FROM "Order";


SELECT TOP 3 MAX(O.Quantity)AS HIGHEST_Q , FirstName,LastName, ProductName FROM OrderItem O, Customer C,"Order" R,Product P
WHERE P.Id = O.ProductId AND O.OrderId =R.Id AND R.CustomerId = C.Id
GROUP BY FirstName,LastName, ProductName 
ORDER BY HIGHEST_Q DESC;
-- SQL OPERATOR [LIKE WHERE NAME LIKE'_O%' OR NOT LIKE OR %O%, IN , IS NULL, IS NAN, 

select * from Customer
WHERE FirstName LIKE '_O%';

select * from Customer
WHERE Country IN ('uk' ,'MEXICO');

select * from Customer
WHERE Phone LIKE '%555%';

--BETWEEN OPERATOR [1 AND ]

SELECT FirstName + LastName AS FULL_NAME FROM Customer;

-- DATABASE OBJECTS  OBJECT IS ANYTHING THAT HAS NAME AND STRUCTURE
-- INCLUDING TABLE, SEQUENCE ,INDEX, VIEW, SYNONYM

-- CREATE A SEQUENCE THAT INCREACES BY 1 
CREATE SEQUENCE COUNTBY1
	START WITH 1
	INCREMENT BY 1;

-- CREATE A SEQUENCE THAT INCREACES BY 1 
CREATE SEQUENCE COUNTBY2
	START WITH 1
	INCREMENT BY 1
	MAXVALUE 10; 

SELECT * FROM SYS.sequences WHERE NAME = 'COUNTBY2';

CREATE SEQUENCE COUNTBY3 
	AS SMALLINT;

CREATE SEQUENCE DecSeq
	 AS DECIMAL(3,0)
	 START WITH 125
	 INCREMENT BY 25
	 MINVALUE 100
	 MAXVALUE 200
	 CYCLE
	 CACHE 3;

SELECT NEXT VALUE FOR DecSeq;

-- REMOVING A SEQUENCE [DROP SEQ NAME]
DROP SEQUENCE COUNTBY3;

CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    FirstName CHAR(50),
    LastName CHAR(50),
    Phone CHAR(20)
);

INSERT INTO Staff (StaffID, FirstName, LastName, Phone)
VALUES
    (1, 'John', 'Doe', '555-1234'),
    (2, 'Jane', 'Smith', '555-5678'),
    (3, 'Michael', 'Johnson', '555-9876');

insert into Staff (StaffID, FirstName, LastName, Phone)
VALUES (next value for COUNTBY1,'SAM', 'ADFV','123456789');

ALTER SEQUENCE COUNTBY1
RESTART WITH 4;
SELECT * FROM Customer WHERE Id = 5;-- CONTROL+L TO SHOW THE INDEX

CREATE INDEX INDEX1 ON CUSTOMER(FirstName);
SELECT * FROM Customer WHERE FirstName = 'THOMAS'; 