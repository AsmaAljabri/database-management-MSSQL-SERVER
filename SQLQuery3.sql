
CREATE TABLE mak_students (
    student_id INT not null PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20));

CREATE TABLE course (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    course_credit INT,
    course_instructor VARCHAR(100));
    --department_id INT,
    --FOREIGN KEY (department_id) REFERENCES department(department_id)

	--delete from 
	ALTER TABLE mak_students ADD C_ID int ;

	alter table mak_students add constraint s_student_CID_FK foreign key (C_ID) references course(course_id);
	insert into mak_students (student_id,first_name,last_name,date_of_birth,email,phone_number) values (1, 'asma','aljabri','8/3/2022','asma@gmail','99887766');
	insert into mak_students (student_id,first_name,last_name,date_of_birth,email,phone_number) values (2, 'mana','alshibli','6/3/2002','ma@gmail','99834466');

	insert into course (course_id, course_name, course_credit, course_instructor) values(11, 'cosc',3,'ahmed');
	insert into course (course_id, course_name, course_credit, course_instructor) values(22, 'math',3,'sam');

	select TABLE_NAME,
			CONSTRAINT_TYPE, CONSTRAINT_NAME
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	WHERE TABLE_NAME = 'mak_students'
	select * from  mak_students 
	select * from  course

UPDATE dbo.mak_students
SET C_ID = 22
Where student_id = 2

/* 
to drop constraint
alter table table_name 
drop constraint constraint_name;

*/
SELECT SYSDATETIME()AS TODAY;-- ADD COLUMN NAME USING AS


CREATE TABLE employee1 (
    employee1_id INT PRIMARY KEY,
    employee1_name VARCHAR(100)
);



CREATE TABLE employee2 (
    employee2_id INT PRIMARY KEY,
    employee2_name VARCHAR(100)
);

INSERT INTO employee1 VALUES (100,'ALI');
INSERT INTO employee1 VALUES (200,'SAM');
INSERT INTO employee1 VALUES (300,'HILAL');
INSERT INTO employee1 VALUES (400,'JOHN');

INSERT INTO employee2 (employee2_id,employee2_name)
SELECT  employee1_id , employee1_name from employee1;

select * from employee1;
select * from employee2;

/*
update syntax
UPDATE TABLENAME 
SET COLUMN NAME = COLUMN_NAME,...
[WHERE CONDITION]
	
*/

--DECLARE AND ASSIGN VALUE'
DECLARE @EMPLOYEE_id INT = 100;



CREATE TABLE PRODUCT(
ID INT PRIMARY KEY,
P_NAME VARCHAR (20), 
COUNTITY INT, 
PRICE INT);

INSERT INTO PRODUCT VALUES (1,'BAG',2,100);
INSERT INTO PRODUCT VALUES (2,'CAAR',4,500);
INSERT INTO PRODUCT VALUES (3,'Cat',4,900);
INSERT INTO PRODUCT VALUES (4,'fat',4,700);
INSERT INTO PRODUCT VALUES (5,'dog',4,400);


SELECT COUNTITY * PRICE  AS TOTAL_RESULT FROM PRODUCT;


SELECT * FROM PRODUCT;

UPDATE employee1 SET employee1_name =( SELECT employee1_name FROM employee1
WHERE employee1_name = 'ALI' ) WHERE employee1_name = 'SAM';

UPDATE PRODUCT 
SET COUNTITY = 6
WHERE PRICE = 100;

SELECT * FROM PRODUCT;
EXEC sp_rename 'COUNTITY', 'QUNTITY';

-- Begin a transaction
BEGIN TRANSACTION;
UPDATE PRODUCT 
SET COUNTITY = 3
WHERE PRICE = 500;

SELECT * FROM PRODUCT;

-- Rollback the changes made within the transaction
ROLLBACK TRANSACTION;

SELECT DISTINCT *
FROM PRODUCT;

SELECT COUNT(PRICE)
FROM PRODUCT;

SELECT SUM(PRICE)
FROM PRODUCT;
