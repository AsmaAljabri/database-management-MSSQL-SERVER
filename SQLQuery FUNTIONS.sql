--FUNTIONS
/*
SYNTAX

CREATE FUNCTION SCHEMA_NAME.FUNCTION_NAME {dbo.__} (@PARAMETERS DATATYPE)
RETURN-- RETURN_DATA_TYPE

AS
--BLOCK THE FUNCTION 
BEGIN 
	FUNCTION LOGIC
	RETURN RESULT;

END;

*/
------------------------------------------------------
--CREATE FUNCTION NAMED CIRCLE_AREA() , WHICH RETURN  THE AREA OF THE CIRCLE
--THE RADIUS OF THE CIRCLE AS PARAMETER NAMED P_RADIUS AND CIRCLE_AREA RETURN A NUMERIC VALUE 


-- Create or alter the function named CIRCLE_AREA.
-- The function takes an input parameter @P_RADIUS of type FLOAT.
-- It returns the area of the circle as a NUMERIC value.

-- STEP 1: CREATE THE FUNCTION
CREATE OR ALTER FUNCTION CIRCLE_AREA
    (@P_RADIUS NUMERIC(10,2))
RETURNS NUMERIC(8, 2)
AS
BEGIN
    DECLARE @Area NUMERIC(8, 2);
    DECLARE @PI NUMERIC (8,2) = pi()

    SET @Area = @PI * POWER(@P_RADIUS , 2); -- Formula for the area of a circle: π * r^2
    
    RETURN @Area;
END;

--STEP 2:USE THE FUNCTION
BEGIN
-- Declare a variable to hold the radius
DECLARE @radius NUMERIC(10, 2) = 5.0; -- Replace with the desired radius

-- Call the CIRCLE_AREA function using a SELECT statement to calculate the area
DECLARE @areaResult NUMERIC(8, 2);
SELECT @areaResult = dbo.CIRCLE_AREA(@radius);

-- Print the calculated area
PRINT 'The area of the circle with radius ' + CAST(@radius AS NVARCHAR(20)) + ' is ' + CAST(@areaResult AS NVARCHAR(20));
END;

--------------------------------------------------------------------------------------------------------------------------------------

-- CREATE A SCALAR FUCTION THAT CONCATENATES A FIRST NAME AND LAST NAME AND TAKING THE ID AS A PARAMETER


CREATE OR ALTER FUNCTION FULL_NAME
    (@ID INT)
RETURNS VARCHAR(40)
AS
BEGIN
    DECLARE @FULL_NAME VARCHAR(40);
    DECLARE @FNAME VARCHAR(40);
    DECLARE @LNAME VARCHAR(40);

    SELECT @FNAME = FirstName, @LNAME = LastName
    FROM Customer
    WHERE Id = @ID;

    SET @FULL_NAME = CONCAT(@FNAME, ' ', @LNAME);
    RETURN @FULL_NAME;
END;

BEGIN
-- Declare a variable to hold the ID
DECLARE @ID INT = 1; -- Replace with the desired radius

-- Call the CIRCLE_AREA function using a SELECT statement to calculate the area
DECLARE @FULL_NAME VARCHAR(40);
SELECT @FULL_NAME = dbo.FULL_NAME(@ID);

-- Print THE FULL NAME
PRINT 'The FULL NAME OF THE PERSON WHOM ID  [' + CAST(@ID AS NVARCHAR(20)) + ']  is ' + @FULL_NAME ;
END;

--------------------------------------------------------------------------
--EXAMPLE OF FUNCTION TO RETURNE TABLE
CREATE OR ALTER FUNCTION GETCUSTOMERBYCOUNTRY(@COUNTRY NVARCHAR(50))
RETURNS TABLE
AS 
RETURN
	SELECT Id, FirstName,LastName, City
	FROM Customer
	WHERE Country = @COUNTRY;

--CALL THE TABLE_VALUE FUNCTION
SELECT *
FROM dbo.GETCUSTOMERBYCOUNTRY('USA'); 

---------------------------------------------------------------------------------------------
--CREATE A TABLE VALUED FUNCTION THTA RETURNS A LISTS OF PRODUCTS IN SPECIFI COMPANY

CREATE OR ALTER FUNCTION GETPRODUCTCOMPANY(@COMPANYID INT)
RETURNS TABLE
AS 
RETURN
	SELECT P.Id, P.ProductName, S.CompanyName 
	FROM Supplier S, Product P 
	WHERE S.Id = P.SupplierId AND S.Id = @COMPANYID;

	SELECT * FROM dbo.GETPRODUCTCOMPANY(2);

-----------------------------------------------------------------------------------------------------------
-- Create or alter the function named GETCUSTOMERORDER_YEAR.
-- The function takes an input parameter @YEAR of type DATETIME.
-- It returns a table with the total sales amount for each year and each customer.

CREATE OR ALTER FUNCTION GETCUSTOMERORDER_YEAR
    (@YEAR DATETIME)
RETURNS TABLE
AS
RETURN
(
    SELECT C.Id, C.FirstName, C.LastName,
           SUM(OD.Quantity * OD.UnitPrice) AS TotalAmount,
           YEAR(O.OrderDate) AS SALEYEAR
    FROM Customer C
    JOIN "Order" O ON O.CustomerId = C.Id
    JOIN OrderItem OD ON O.Id = OD.OrderId
    WHERE YEAR(O.OrderDate) = YEAR(@YEAR)
    GROUP BY YEAR(O.OrderDate), C.Id, C.FirstName, C.LastName

);

-- Use the function by selecting from it with a specific year
SELECT * FROM dbo.GETCUSTOMERORDER_YEAR('2013');



SELECT * FROM "Order";

--DROPPING FUNCTION

-- DROP FUNCTION [SCHEMA_NAME] .FUNCTION_NAME