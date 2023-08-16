
--excersise (1)
/*
Display the title of the book (from the BOOK table) and the title of the course (from the COURSE table) 
for all books that are assigned to any course.
*/

SELECT DISTINCT b.bk_title AS "Book Title", c.cr_title AS "Course Title"
FROM book AS b,CBlink AS cb,course AS c
WHERE  b.bk_id = cb.li_bkID
AND  cb.li_crCode = c.cr_code;
-------------------------------------------------------------------------------------------------------------------
/*
Write a T-SQL query to fetch book names having total copies greater than 50 and less than or equal to 100.
*/
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
------------------------------------------------------------------------------------------------------------------
/*
Based on the borrower table select the unique department code values that represented for the
borrower from Seeb city and order by the result in descending order by department code.  

*/
SELECT DISTINCT br_dept
FROM borrower
WHERE br_city = 'Seeb'
ORDER BY br_dept DESC;
-----------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------
--Lab_1_2_3_4_QuestionSheet
-- 5)	Using the ‘insert’ statements, add at least 3 rows to each table. 	

-- Inserting data into the 'college' table
INSERT INTO college VALUES('SCIi', 'Science 2', 'Prof. Alex');
INSERT INTO college VALUES('ENG', 'Engineering', 'Prof. Smith');
INSERT INTO college VALUES('BUS', 'Business', 'Dr. Johnson');

-- Inserting data into the 'department' table
INSERT INTO department VALUES('CSE', 'Computer Science and Engineering', 'Dr. Lee', 'ENG');
INSERT INTO department VALUES('BIO', 'Biology', 'Dr. Green', 'SCI');
INSERT INTO department VALUES('MKT', 'Marketing', 'Prof. Brown', 'BUS');

-- Inserting data into the 'borrower' table
INSERT INTO borrower VALUES(20001, 'Ahmed', 'CSE', 94567890, 'Muscat', '25A', 'S');
INSERT INTO borrower VALUES(20002, 'Layla', 'BIO', 99776655, 'Salalah', '10B', 'S');
INSERT INTO borrower VALUES(30001, 'Omar', 'CSE', 91345678, 'Muscat', '19C', 'S');

-- Inserting data into the 'student' table
INSERT INTO student VALUES(20001, 'Computer Science', 2020);
INSERT INTO student VALUES(20002, 'Biology', 2021);
INSERT INTO student VALUES(30001, 'Computer Science', 2022);

-- Inserting data into the 'employee' table
INSERT INTO employee VALUES(40001, 'Office 101', 1701);
INSERT INTO employee VALUES(40002, 'Office 202', 1505);

-- Inserting data into the 'book' table
INSERT INTO book VALUES(2002, 'Algorithms and Data Structures', 4, 600, 100, 50);
INSERT INTO book VALUES(2003, 'Organic Chemistry', 2, 400, 80, 35);
INSERT INTO book VALUES(3004, 'Marketing 101', 1, 200, 50, 25);

-- Inserting data into the 'bookTopic' table
INSERT INTO bookTopic VALUES(2002, 'Algorithm Analysis');
INSERT INTO bookTopic VALUES(2002, 'Data Structures');
INSERT INTO bookTopic VALUES(3004, 'Marketing Strategies');

-- Inserting data into the 'course' table
INSERT INTO course VALUES('CSE101', 'Introduction to Programming', 3, 1, 'CSE');
INSERT INTO course VALUES('BIO201', 'Genetics', 4, 1, 'BIO');
INSERT INTO course VALUES('MKT301', 'Consumer Behavior', 3, 1, 'MKT');

-- Inserting data into the 'CBlink' table
INSERT INTO CBlink VALUES('CSE101', 2002, 'T');
INSERT INTO CBlink VALUES('BIO201', 2003, 'T');
INSERT INTO CBlink VALUES('MKT301', 3004, 'R');

-- Inserting data into the 'regist' table
INSERT INTO regist VALUES(20001, 'CSE101', 'FALL2022');
INSERT INTO regist VALUES(20002, 'BIO201', 'SPRING2023');
INSERT INTO regist VALUES(30001, 'CSE101', 'FALL2022');

-- Inserting data into the 'issuing' table
INSERT INTO issuing VALUES(20001, 2002, '2023-05-15', '2023-06-15');
INSERT INTO issuing VALUES(20002, 2003, '2023-06-01', NULL);
INSERT INTO issuing VALUES(30001, 2002, '2023-05-20', NULL);

INSERT INTO college (cl_code, cl_name, cl_dean) VALUES ('MED', 'Medicine', 'Dr. Smith');
----------------------------------------------------------------------------------------------------------------------------------
-- Write SQL queries to answer the queries from 'a-d' and either 'e' or 'f':
-- (a) Retrieve full information stored in one table.
SELECT * FROM college;
---------------------------------------------------------------------------------------------------------------------------------
--(b) Retrieve from any table the records which satisfy certain criteria.
--To retrieve students from the "student" table who belong to the 'computer science' department:
select * from student;
SELECT * FROM student WHERE st_major = 'Computer Science';

------------------------------------------------------------------------------------------------------------------------------
--c) Using any table which contains a numeric field, retrieve the record which has the maximum value for that field.
--To retrieve the employee with the highest "em_ext#" (extension number) from the "employee" table:

SELECT TOP 1 * 
FROM employee 
ORDER BY em_ext# DESC;
--or 
SELECT * FROM employee 
WHERE em_ext# = (SELECT MAX(em_ext#) FROM employee);

----------------------------------------------------------------------------------------------------------------
--(d) List related information from two tables. The list must contain at least one field from each table.
-- To list the borrower name and the name of the department they belong to:
SELECT b.br_name, d.dp_name 
FROM borrower b, department d
where b.br_dept = d.dp_code;

--------------------------------------------------------------------------------------------------------------------
--(e) Produce a statistical list (Query) of two columns only, which aggregates the records within a table based on the values 
--stored in one textual-field (the 1st column) while the 2nd column lists aggregated information using one of these functions: 
--'COUNT', 'SUM', or 'AVERAGE'.
-- To produce a statistical list of courses (cr_title) along with the count of students registered for each course:
SELECT r.re_crCode, c.cr_title, COUNT(*) AS student_count
FROM regist r, course c 
WHERE r.re_crCode = c.cr_code
GROUP BY r.re_crCode, c.cr_title;


---------------------------------------------------------------------------------------------------------------------------
--(f) Produce a calculated list (Query) based on a single table. The list must have at least two columns, 
--one of them is a textual column, while the 2nd column is calculated (e.g., summed-up) from other fields.
--To produce a list of courses (cr_title) along with the total credit hours (cr_CH) for each course:
SELECT cr_title, SUM(cr_CH) AS total_credit_hours
FROM course
GROUP BY cr_title;

--OR  list of books with the total number of copies (sum of "bk_totalCopies"):
SELECT bk_title, SUM(bk_totalCopies) AS total_copies
FROM book
GROUP BY bk_title;



-------------------------------------------------------------------------------------------------
--LAB 5

/*
1)	For the table ‘regist’ do the following:
a.	Add a new column named ‘re_serial#’ of type Integer.
b.	Create a sequence (named seq_regist_serial#) that generates unique serial’s. The
sequence starts generating numbers from 1, every time increases by 2, and reuses the generated numbers if necessary.
c.	Update the ‘regist’ table to fill the re_serial# column from the created sequence.
d.	Insert at least two new records into the table ‘regist’; keeping in mind that the
table is now having the new column ‘re_serial#’, which it has to be filled from
the sequence seq_regist_serial#.

*/

--(a) Add a new column named 're_serial#' of type Integer to the 'regist' table:

	ALTER TABLE regist
	ADD re_serial# INT;
-- (b) Create a sequence (named seq_regist_serial#) that generates unique serial numbers starting from 1,
--increasing by 2, and reusing numbers if necessary:
	CREATE SEQUENCE seq_regist_serial#
	AS INT
	START WITH 1
	INCREMENT BY 2
	MINVALUE 1
	MAXVALUE 100000
	CYCLE;
-- (c) Update the 'regist' table to fill the 're_serial#' column from the created sequence:
UPDATE regist
SET re_serial# = NEXT VALUE FOR seq_regist_serial#;


--(d) Insert at least two new records into the 'regist' table, ensuring that the 're_serial#' column is filled from the sequence:

INSERT INTO regist (re_brID, re_crCode, re_semester, re_serial#)
VALUES (10021, 'COMP4202', 'FL2023', NEXT VALUE FOR seq_regist_serial#);

INSERT INTO regist (re_brID, re_crCode, re_semester, re_serial#)
VALUES (92120, 'BIOL1000', 'FL2023', NEXT VALUE FOR seq_regist_serial#);
------------------------------------------------------------------------------------
/*
2)	For the table ‘CBlink’ do the following:
a.	Add a new column named li_key of type character and size 8.
b.	Create a sequence (named seq_CBlink_key) that generates unique keys (integers).
The sequence starts generating the numbers from 0, every time increases by 1,
and the generated number can recur when the last generated number reached
9999.
c.	Update the ‘CBlink’ table to fill the li_key column using a textual value that
consists of the 1st four characters from the Course Code (i.e., li_crCode) and the
next integer from the sequence seq_CBlink_key. The length of the composed
textual value MUST be 8 characters, which means that the generated integers
from the sequence must be left-padded with ZEROS before they are
concatenated with the first part; for example: ‘COMP0000’, ‘COMP0001’,
‘BIOL0002.

*/
---------
-- (a) Add a new column named 'li_key' of type character and size 8 to the 'CBlink' table:

		ALTER TABLE CBlink
		ADD li_key CHAR(8);

--(b) Create a sequence (named seq_CBlink_key) that generates unique keys (integers) 
--starting from 0, increasing by 1, and reusing numbers when the last generated number reaches 9999:
	CREATE SEQUENCE seq_CBlink_key
	AS INT
	START WITH 0
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 9999
	CYCLE;
--c) Update the 'CBlink' table to fill the 'li_key' column using a textual value that consists of the
--first four characters from the Course Code (li_crCode) and the next integer from the sequence seq_CBlink_key, 
--left-padded with zeros to make the total length 8 characters
UPDATE CBlink
SET li_key = CONCAT(SUBSTRING(li_crCode, 1, 4), FORMAT(NEXT VALUE FOR seq_CBlink_key, '0000'));

--3)	Insert at least two new records into the table ‘CBlink’ keeping in mind that the table
--is now having the new column ‘li_key’, which it must be filled from the sequence
-- seq_CBlink_key as described in (c).


-- the first record
INSERT INTO CBlink (li_crCode, li_bkId, li_usage, li_key)
VALUES ('COMP4201', 1001, 'T', CONCAT(FORMAT(NEXT VALUE FOR seq_CBlink_key, '0000'), SUBSTRING('COMP4201', 1, 4)));

-- the second record
INSERT INTO CBlink (li_crCode, li_bkId, li_usage, li_key)
VALUES ('COMP4201', 1002, 'R', CONCAT(FORMAT(NEXT VALUE FOR seq_CBlink_key, '0000'), SUBSTRING('COMP4201', 1, 4)));



--4)	For the table ‘Book’, create a UNIQUE index on the book title. Choose a suitable name for the created index.
	CREATE UNIQUE INDEX in_Book_title
	ON Book (bk_title);
