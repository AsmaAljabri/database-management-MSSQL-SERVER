-- INSTEAD TRIGGER VIEW FOR ORDER TABLE
-- WE DID NOT ADD THE CUSTOMER ID BC IN THIS DATASET THE CUSTOMER ID IS ID AUTO INCREMENT 

CREATE OR ALTER VIEW CUSVIEW AS
SELECT  o.OrderNumber,o.OrderDate ,c.FirstName, c.LastName
FROM "Order" o , Customer c
WHERE o.CustomerId = c.Id;



create OR ALTER trigger TIG_CUSVIEW ON CUSVIEW INSTEAD OF INSERT AS
BEGIN
	DECLARE @NUM_ORDER NVARCHAR (10);
	DECLARE @ORDERDATE DATETIME;
	DECLARE @CUSTid INT;

	
	SELECT @NUM_ORDER = OrderNumber
        , @CUSTid = Id
		, @ORDERDATE = OrderDate
    FROM Customer C, inserted
    WHERE C.FirstName = inserted.FirstName AND C.LastName = inserted.LastName;

   IF @CUSTid IS NULL
    BEGIN
        PRINT 'Invalid order';
        ROLLBACK;
        RETURN; 
    END;
	INSERT INTO "Order" (OrderDate,OrderNumber, CustomerId) VALUES (@ORDERDATE,@NUM_ORDER,@CUSTid);
end;

-- Insert data into the CUSVIEW
INSERT INTO CUSVIEW 
VALUES ('12345', '2023-08-16', 'X', 'Y');

DROP VIEW CUSVIEW;

SELECT * FROM CUSVIEW;
SELECT * FROM "Order";
SELECT * FROM Customer;