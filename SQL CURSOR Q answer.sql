--Write a T-SQL query to fetch book names having total copies greater than 50 and less than or equal to 100.

BEGIN
    -- STEP ONE: DECLARE THE VARIABLES
    DECLARE @bookname VARCHAR(50);
    DECLARE @totalcopies INT;

    -- STEP 2: DECLARE THE CURSOR
    DECLARE totalbook_CURSOR CURSOR FOR
    SELECT bk_title, bk_totalCopies
    FROM book
    WHERE bk_totalCopies > 50 AND bk_totalCopies <= 100;

    -- STEP 3: OPEN THE CURSOR
    OPEN totalbook_CURSOR;

    -- STEP 4: FETCH THE ROW FROM THE CURSOR
    FETCH NEXT FROM totalbook_CURSOR
    INTO @bookname, @totalcopies;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT 'Book Name: ' + @bookname +
              ', Total Copies: ' + CAST(@totalcopies AS VARCHAR);

        -- Fetch the next row
        FETCH NEXT FROM totalbook_CURSOR
        INTO @bookname, @totalcopies;
    END;

    -- STEP 5: CLOSE THE CURSOR
    CLOSE totalbook_CURSOR;

    -- STEP 6: DEALLOCATE THE CURSOR
    DEALLOCATE totalbook_CURSOR;
END;
select * from book;