--database objects
--procedures  can be used by EXEC OR EXECUTE
/*
SYNTAX
CREATE OR ALTER PROCEDURE PROCEDUER_NAME[( PARAMETER_NAME TYPE [..........] [OUTPUT])]

@PARAMETER1 DATATYPE
@PARAMETER2 DATATYPE = DEFAULT VALUE

AS

BEGIN
	SQL STATEMENT TO DEFINE THE FUNCTIONALITY OF THE PROCEDURE
END

TYPER OF PARAMETERS
	NORMAL PARAMETER OR OUTPUT PARAMETER

*/
--EXAMPLES  OF PROCEDURE WITH ONE PARAMETERS 

CREATE OR ALTER PROCEDURE READ_PRODUCTS_PROC -- USING ALTER ALLOW NE TO RUN THE CODE MANY TIMES WITHOUT CHANGING IT 
@PCITY AS NVARCHAR (40) AS
BEGIN
	DECLARE @CITY_NAME NVARCHAR(40) = @PCITY;
	SELECT * FROM Supplier WHERE City = @CITY_NAME;
END

EXEC READ_PRODUCTS_PROC 'New Orleans';
-----------------------------------------------------------------------------------------------------
--EXAMPLES  OF PROCEDURE WITH ONE PARAMETERS 
-- This code snippet defines a stored procedure named READ_CUSTOMER_PROC.
-- The procedure takes an input parameter @pcountry of type NVARCHAR with a maximum length of 40 characters.

CREATE OR ALTER PROCEDURE READ_CUSTOMER_PROC
    @pcountry AS NVARCHAR(40)
AS
BEGIN
    -- Within the procedure:
    -- Declare a local variable @country_name of type NVARCHAR(40) and assign it the value of the input parameter @pcountry.
    DECLARE @country_name NVARCHAR(40) = @pcountry;

    -- Select all columns from the 'Customer' table where the 'Country' column matches the value stored in @country_name.
    SELECT * FROM Customer WHERE Country = @country_name;
END

-- Execute the stored procedure 'READ_CUSTOMER_PROC' with the input parameter 'USA'.
EXEC READ_CUSTOMER_PROC 'USA';

-- The above code creates a stored procedure that retrieves customer data from the 'Customer' table based on the provided country name.
-- The stored procedure takes an input parameter, @pcountry, which is used to filter the results by the 'Country' column.
-- The procedure then declares a local variable @country_name to hold the value of the input parameter.
-- It performs a SELECT query on the 'Customer' table, fetching all columns, and filtering by the 'Country' column using the @country_name variable.
-- Finally, the procedure is executed with the parameter 'USA', retrieving customer data for the USA.

-- Note: The "EXEC" statement is used to execute the stored procedure with the specified parameter value.
-- The procedure returns the result set containing customer data for the specified country.


------------------------------------------------------------------------------------------------------
-- WRITE A PROCEDURE THAT PRINT PRODUCT NAME AND THE PRICE WITH A GIVEN ID
CREATE OR ALTER PROCEDURE READ_PRODUCT_PROC
@ID  AS INT,  @PRODUCT_NAME NVARCHAR(50) OUTPUT , @UNITPRICE DECIMAL(12,2) OUTPUT
AS --- TO OPEN THE PROCEDUER

BEGIN
	
	SELECT @PRODUCT_NAME= ProductName,  @UNITPRICE= UnitPrice 
	FROM Product WHERE Id = @ID ;
END;

BEGIN
	DECLARE @NAME NVARCHAR(50);
	DECLARE @PRICE DECIMAL(12,2);
	EXEC READ_PRODUCT_PROC 11, @NAME OUTPUT, @PRICE OUTPUT;
	PRINT @NAME + ' '+CAST( @PRICE AS NVARCHAR );
END
------------------------------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE READ_CUSTOMER_PROC
@ID  AS INT,  @CUSTOMER_FNAME NVARCHAR(40) OUTPUT, @CUSTOMER_LNAME NVARCHAR(40) OUTPUT, @PHONE NVARCHAR(20) OUTPUT
AS --- TO OPEN THE PROCEDUER

BEGIN
	
	SELECT @CUSTOMER_FNAME= FirstName, @CUSTOMER_LNAME= LastName , @PHONE= Phone
	FROM Customer WHERE Id = @ID ;
END;

BEGIN
	DECLARE @FNAME NVARCHAR(40);
	DECLARE @LNAME NVARCHAR(40);
	DECLARE @CPHONE NVARCHAR(20);

	EXEC READ_CUSTOMER_PROC 11, @FNAME OUTPUT, @LNAME OUTPUT, @CPHONE OUTPUT ;
	PRINT @FNAME + ' '+ @LNAME +' ' + @CPHONE ;
END
---------------------------------------------
-- This code snippet defines a stored procedure named READ_CUSTOMER_PROC.
-- The procedure takes input parameters @ID of type INT with a default value of 10,
-- and @CUSTOMER_FNAME, @CUSTOMER_LNAME, and @PHONE of type NVARCHAR as OUTPUT parameters.

CREATE OR ALTER PROCEDURE READ_CUSTOMER_PROC
    @ID AS INT = 10,
    @CUSTOMER_FNAME NVARCHAR(40) OUTPUT,
    @CUSTOMER_LNAME NVARCHAR(40) OUTPUT,
    @PHONE NVARCHAR(20) OUTPUT
AS
BEGIN
    -- Within the procedure:
    -- Select the FirstName, LastName, and Phone columns from the 'Customer' table
    -- where the 'Id' column matches the value of the input parameter @ID.
    SELECT @CUSTOMER_FNAME = FirstName, @CUSTOMER_LNAME = LastName, @PHONE = Phone
    FROM Customer WHERE Id = @ID;
END;

BEGIN
-- Declare local variables to hold the output values.
DECLARE @FNAME NVARCHAR(40);
DECLARE @LNAME NVARCHAR(40);
DECLARE @CPHONE NVARCHAR(20);

-- Execute the stored procedure 'READ_CUSTOMER_PROC' with the local variables as OUTPUT parameters.
EXEC READ_CUSTOMER_PROC DEFAULT, @FNAME OUTPUT,  @LNAME OUTPUT,  @CPHONE OUTPUT;

-- Print the concatenated output values.
PRINT @FNAME + ' ' + @LNAME + ' ' + @CPHONE;
END;

-------------------------------------------------------------------
-- CREATE OR ALTER PROCEDURE TO READ IF THE NUMBER IS EVEN OR ODD

CREATE OR ALTER PROCEDURE CHECK_EVEN_ODD_PROC
    @number INT,
    @result NVARCHAR(50) OUTPUT
AS
BEGIN
    IF @number % 2 = 0
        SET @result = 'THE NUMBER IS '+'[ '+CAST(@number AS nvarchar(50) ) + ' ]'+' even';
    ELSE
        SET @result = 'THE NUMBER IS '+'[ '+CAST(@number AS nvarchar(50) ) + ' ]'+' odd';
END;

BEGIN
DECLARE @outputResult NVARCHAR(50);

EXEC CHECK_EVEN_ODD_PROC @number = 2, @result = @outputResult OUTPUT;

PRINT @outputResult;

END
----------------------------------------------------------------------------------------------------
