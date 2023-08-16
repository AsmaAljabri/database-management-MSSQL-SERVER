/*
steps to use cursors in SQL:

Declare the Cursor: Declare a cursor and define the SELECT statement that retrieves the result set you want to work with.

Open the Cursor: Open the cursor to start processing the result set. This makes the rows in the result set available for fetching.

Fetch Rows: Use a loop to fetch rows from the cursor one by one. You can perform operations on each row as you fetch it.

Process the Row: Within the loop, access the data in the current row and perform the necessary operations.

Check for Completion: Continue fetching rows until there are no more rows to fetch.

Close the Cursor: Close the cursor after you're done processing the result set. This releases resources.

Deallocate the Cursor: In some cases, you may need to deallocate the cursor explicitly, depending on the SQL platform.

*/

 BEGIN

 -- STEP ONE : DECLARE THE VARIABLES
	DECLARE @CUSTOMERID INT;
	DECLARE @FNAME NVARCHAR(40);
	DECLARE @CITY NVARCHAR(40);
-- STEP 2 : DECLARE  THE CURSOR	
	DECLARE V_CUSTOMER_CURSOR CURSOR FOR 
		SELECT  Id, FirstName, City
		FROM Customer
		WHERE Country = 'UK';
-- STEP 3 :OPEN THE CURSOR
	OPEN V_CUSTOMER_CURSOR;
-- STEP 4: FETCH THE ROW FROM THE CURSOR
	FETCH NEXT FROM V_CUSTOMER_CURSOR  
		INTO @CUSTOMERID, @FNAME, @CITY;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT 'CUSTOMER: ' + CAST(@CUSTOMERID AS VARCHAR) + 
			' => ' + @FNAME + ' FROM ' + @CITY;
			FETCH NEXT FROM V_CUSTOMER_CURSOR 
				INTO @CUSTOMERID, @FNAME, @CITY;
		END
-- STEP 5 : CLOSE THE CURSOR
	CLOSE V_CUSTOMER_CURSOR;
-- STEP 6 : DEALLOCATE THE CURSOR
	DEALLOCATE V_CUSTOMER_CURSOR;
END
----------------------------------------------------------------------------------
----------------------------------------------------------------------------------
SELECT * FROM Product;
/*
 BEGIN

 -- STEP ONE : DECLARE THE VARIABLES
	DECLARE @productid INT;
	DECLARE @PRICE NUMERIC(12,2);
	DECLARE @COMPANY_NAME NVARCHAR(40);

-- STEP 2 : DECLARE  THE CURSOR	
	DECLARE PRODUCT_CURSOR CURSOR FOR 
		SELECT  P.Id, UnitPrice, CompanyName
		FROM Product P, Supplier S
		WHERE P.SupplierId = S.Id AND IsDiscontinued = '1' ;
-- STEP 3 :OPEN THE CURSOR
	OPEN PRODUCT_CURSOR;
-- STEP 4: FETCH THE ROW FROM THE CURSOR
	FETCH NEXT FROM PRODUCT_CURSOR  
		INTO @productid, @PRICE, @COMPANY_NAME;
		WHILE @@FETCH_STATUS = 0
		BEGIN
			PRINT 'THE PRODUCTS THAT IS DISCOUNTED: ' + CAST(@productid AS VARCHAR) + 
			'THE PRICE IS => ' + @PRICE + ' FROM THE COMPANY ' + @COMPANY_NAME;
			FETCH NEXT FROM PRODUCT_CURSOR 
				INTO @productid, @PRICE, @COMPANY_NAME;
		END
-- STEP 5 : CLOSE THE CURSOR
	CLOSE PRODUCT_CURSOR;
-- STEP 6 : DEALLOCATE THE CURSOR
	DEALLOCATE PRODUCT_CURSOR;
END
*/


----------------------------------------------------
/*
Q) DECLARE A CURSOR TO FETCH ALL PRODUCTS THAT HAVE  DISCOUNTS, ALONG WITH THE PRICE AND THE NAME OF THE COMPANY

*/
------------------------------------------------------------
BEGIN
    -- STEP ONE: DECLARE THE VARIABLES
    DECLARE @productid INT;
    DECLARE @PRICE NUMERIC(12, 2);
    DECLARE @COMPANY_NAME NVARCHAR(40);

    -- STEP 2: DECLARE THE CURSOR
    DECLARE PRODUCT_CURSOR CURSOR FOR
    SELECT P.Id, UnitPrice, CompanyName
    FROM Product P, Supplier S
    WHERE P.SupplierId = S.Id AND IsDiscontinued = '1';

    -- STEP 3: OPEN THE CURSOR
    OPEN PRODUCT_CURSOR;

    -- STEP 4: FETCH THE ROW FROM THE CURSOR
    FETCH NEXT FROM PRODUCT_CURSOR
    INTO @productid, @PRICE, @COMPANY_NAME;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'THE PRODUCTS THAT ARE DISCOUNTED: ' + CAST(@productid AS VARCHAR) +
            ' THE PRICE IS => ' + CAST(@PRICE AS VARCHAR) + ' FROM THE COMPANY ' + @COMPANY_NAME;

        -- Fetch the next row
        FETCH NEXT FROM PRODUCT_CURSOR
        INTO @productid, @PRICE, @COMPANY_NAME;
    END;

    -- STEP 5: CLOSE THE CURSOR
    CLOSE PRODUCT_CURSOR;

    -- STEP 6: DEALLOCATE THE CURSOR
    DEALLOCATE PRODUCT_CURSOR;
END;
-----------------------------------------------------------
/*

q2) 

update the fax value from suppliers who are from UK by changing the values from null to not found

*/
---------------------------------------
BEGIN
    -- STEP ONE: DECLARE THE VARIABLES
    DECLARE @companyname VARCHAR(255);
    DECLARE @fax NVARCHAR(255);

    -- STEP 2: DECLARE THE CURSOR
    DECLARE fax_update_CURSOR CURSOR FOR
    SELECT CompanyName, Fax
    FROM Supplier
    WHERE Country = 'UK' AND Fax IS NULL;

    -- STEP 3: OPEN THE CURSOR
    OPEN fax_update_CURSOR;

    -- STEP 4: FETCH THE ROW FROM THE CURSOR
    FETCH NEXT FROM fax_update_CURSOR
    INTO @companyname, @fax;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Updating Company: ' + @companyname;

        -- Perform the update
        UPDATE Supplier
        SET Fax = 'NOT FOUND'
        WHERE Country = 'UK' AND Fax IS NULL;

        -- Fetch the next row
        FETCH NEXT FROM fax_update_CURSOR
        INTO @companyname, @fax;
    END;

    -- STEP 5: CLOSE THE CURSOR
    CLOSE fax_update_CURSOR;

    -- STEP 6: DEALLOCATE THE CURSOR
    DEALLOCATE fax_update_CURSOR;
END


select Fax from Supplier where Country = 'UK';


-----------------------------------------------------------------

-- cursor to get the customers that have 555 in their phone number 
-------------------------

BEGIN
    -- STEP ONE: DECLARE THE VARIABLES
    DECLARE @coustomerid INT;
    DECLARE @phone nvarchar(20);
	DECLARE @name nvarchar(40);

    -- STEP 2: DECLARE THE CURSOR
    DECLARE ph_Customer_CURSOR CURSOR FOR
    SELECT Id, FirstName, Phone
    FROM Customer
    WHERE Phone like '%555%';

    -- STEP 3: OPEN THE CURSOR
    OPEN ph_Customer_CURSOR;

    -- STEP 4: FETCH THE ROW FROM THE CURSOR
    FETCH NEXT FROM ph_Customer_CURSOR
    INTO @coustomerid, @phone, @name;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'THE CUSTOMER NAME: ' + @name  +
            ' ID => ' + CAST(@coustomerid AS VARCHAR) + ' THE PHONE NUMBER ' + CAST(@phone AS VARCHAR) ;

        -- Fetch the next row
        FETCH NEXT FROM ph_Customer_CURSOR
        INTO @coustomerid, @phone, @name;
    END;

    -- STEP 5: CLOSE THE CURSOR
    CLOSE ph_Customer_CURSOR;

    -- STEP 6: DEALLOCATE THE CURSOR
    DEALLOCATE ph_Customer_CURSOR;
END;