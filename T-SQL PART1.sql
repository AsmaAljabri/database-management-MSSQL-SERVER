/*
BEGIN   END STATEMENT

DECLARE -->DECLEARATION STATEMENTS


BEGIN
	PRINT' WELCOME TO T-SQL';
END

VARIABLES  IN DATABASE TYPE

@NAME		INT;
@VAR		VARCHAR(23);
2QUANTITY		NUMERIC;
DECLEAR @NAME VARCHAR(15) = 'ASMA'; 

*/
-------------------------------------------------------------------
BEGIN
	PRINT' WELCOME TO T-SQL';
	DECLARE @VAR1 INT = 5;
	DECLARE @VAR2 INT ;
	SET @VAR2 =5
	PRINT @VAR1;
END
----------------------------------------------------------------
BEGIN
	DECLARE @NAME VARCHAR(20);
	DECLARE @SAL NUMERIC(8,2);
	SET @NAME = 'ALI';
	SET @SAL = 700;
	PRINT @NAME;
	PRINT @SAL;
	PRINT @NAME +' ' +CAST( @SAL AS VARCHAR); -- CAST TO CONVERT THE DATA TYPE 
END
---------------------------------------------------------------------
BEGIN 
	DECLARE @WID NUMERIC(8,2);
	DECLARE @HIG NUMERIC(8,2);
	DECLARE @AREA NUMERIC(8,2);
	SET @HIG = 22;
	SET @WID = 44;
	SET @AREA = @WID * @HIG;
	PRINT 'THIS AREA IS = ' + CAST( @AREA AS VARCHAR);
END
----------------------------------------------------------------------------------
BEGIN
	DECLARE @FIRST_NAME VARCHAR(20);
	DECLARE @LAST_NAME VARCHAR(20);

	SELECT @FIRST_NAME=FirstName, @LAST_NAME=LastName
	FROM Customer
	WHERE Id = 4;

	PRINT 'CUSTOMER WITH ID = 4 : ' + @FIRST_NAME + ' '+ @LAST_NAME;
END
----------------------------------------------------------------------------
BEGIN
	DECLARE @AVG NUMERIC(5,2);
	
	SELECT  @AVG = AVG(UnitPrice) 
	FROM Product;

	PRINT 'THE AVERGE OF THE PRICE = ' + CAST(@AVG AS VARCHAR);
END
----------------------------------------------------------------------------
/*
IF STATEMENT
*/
---------------------------------------------------
BEGIN
	DECLARE @PRICE NUMERIC(12,2);

	SELECT  @PRICE = UnitPrice
	FROM Product
	WHERE Id =35;

	IF @PRICE >= 100
		PRINT 'THE PRODUCT IS EXPENSIVE';
	ELSE
		PRINT 'THE PRODUCT IS NOT EXPENSIVE';
END

---------------------------------------------------------------------
BEGIN
	DECLARE @PRICEE NUMERIC(12,2) = 60;

	SELECT  @PRICEE = UnitPrice
	FROM Product;

	IF @PRICEE >= 50
		 SELECT  * FROM Product
		 WHERE UnitPrice >=50;
	ELSE
		SELECT  * FROM Product
		WHERE UnitPrice < 50;
END
---------------------------------
BEGIN
SELECT CompanyName, Country =
	CASE Country
	WHEN  'UK' THEN 'UNITED KINGDOM'  
	WHEN 'USA' THEN 'UNITED STATE OF AMIRICA'
	ELSE Country
	END
FROM Supplier S ;
END
-----------------------------------
SELECT CompanyName, Fax=
       CASE 
	   WHEN Fax IS NULL THEN 'NOT FOUND' 
	   ELSE Fax 
	   END 
FROM Supplier S;

---------------------------------
/*
while loop 

while condition
begin 
	statement
end
*/

BEGIN 
	DECLARE @PrICE NUMERIC(12,2);
	DECLARE @ID INT = 30

	WHILE @ID <= 40
		BEGIN 
			SELECT @PrICE = UnitPrice
			FROM Product
			WHERE Id = @ID;
			IF @PrICE >=100
				PRINT CAST(@ID AS VARCHAR) + '- THE PRODUCT IS EXPENSIVE';
			ELSE 
				PRINT CAST(@ID AS VARCHAR) + '-THE PRODUCT IS NOT EXPENSIVE';
			SET @ID = @ID + 1
		END
END

--------------------------------------------------------------------
BEGIN 
    DECLARE @CITY VARCHAR(25); 
    DECLARE @COUN INT = 1;

    WHILE @COUN <= 10
    BEGIN 
        SELECT @CITY = City
        FROM Customer
        WHERE Id = @COUN;

        IF @CITY = 'London' 
            PRINT 'THE CUSTOMER IS FROM London';
        ELSE 
            PRINT 'THE CUSTOMER IS NOT FROM London';

        SET @COUN = @COUN + 1;
    END
END

SELECT * FROM Customer;

----------------------------------------------------------------------------
BEGIN
DECLARE @COUNTER INT =1;
DECLARE @MAXCOUNT INT = 10;

WHILE @COUNTER <=  @MAXCOUNT

	BEGIN 
	IF @COUNTER % 3 <> 0 
	 PRINT 'COUNTER = ' + CAST (@COUNTER AS VARCHAR );

	 SET @COUNTER=@COUNTER+1
	END

END
-----------------------------------------------------

-- EXCEPTION HANDLING

BEGIN TRY

	SELECT 1/0

END TRY 
BEGIN CATCH

SELECT 
@@ERROR AS ERROR,
ERROR_NUMBER() AS ERRORNUMBER,
ERROR_SEVERITY() AS ERRORSEVERITY,
ERROR_STATE() AS ERRORSTATE,
ERROR_PROCEDURE() AS ERRORPROCEDURE,
ERROR_LINE() AS ERRORLINE,
ERROR_MESSAGE() AS ERRORMESSAGE;
END CATCH

-------------------------------------------------------------------

BEGIN TRY
BEGIN
	DECLARE @AVG NUMERIC(5,2);
	
	SELECT  @AVG = AVG(UnitPrice) 
	FROM Product;

	PRINT 'THE AVERGE OF THE PRICE = ' + @AVG ;
END

END TRY 
BEGIN CATCH

SELECT 
@@ERROR AS ERROR,
ERROR_NUMBER() AS ERRORNUMBER,
ERROR_SEVERITY() AS ERRORSEVERITY,
ERROR_STATE() AS ERRORSTATE,
ERROR_PROCEDURE() AS ERRORPROCEDURE,
ERROR_LINE() AS ERRORLINE,
ERROR_MESSAGE() AS ERRORMESSAGE;
END CATCH




