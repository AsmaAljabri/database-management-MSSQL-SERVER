CREATE DATABASE EmpDB;
-- Create Department table
CREATE TABLE Department (
    DepartmentId INT PRIMARY KEY,
    DepartmentName NVARCHAR(50)
);
-- Create Employees table
CREATE TABLE Employees (
    EmployeeId INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Position NVARCHAR(50),
    DepartmentId INT,
    Salary DECIMAL(18, 2),
	CONSTRAINT FK_Employees_Department
    FOREIGN KEY (DepartmentId)
    REFERENCES Department(DepartmentId)
);
-- Insert sample data into Department table
INSERT INTO Department (DepartmentId, DepartmentName)
VALUES
    (1, 'Sales'),
    (2, 'IT'),
    (3, 'Finance'),
    (4, 'Marketing'),
    (5, 'HR');

-- Insert sample data
INSERT INTO Employees (EmployeeId, FirstName, LastName, Position, DepartmentId, Salary)
VALUES
    (1, 'John', 'Doe', 'Manager', 1, 60000),
    (2, 'Jane', 'Smith', 'Developer', 2, 75000),
    (3, 'Michael', 'Johnson', 'Analyst', 3, 55000),
    (4, 'Emily', 'Williams', 'Designer', 4, 50000),
    (5, 'David', 'Brown', 'Salesperson', 1, 45000),
    (6, 'Linda', 'Davis', 'Manager', 5, 58000),
    (7, 'Robert', 'Jones', 'Developer', 2, 72000),
    (8, 'Mary', 'Miller', 'Analyst', 3, 56000),
    (9, 'William', 'Anderson', 'Designer', 4, 49000),
    (10, 'Karen', 'Wilson', 'Salesperson', 1, 46000);
--PL/SQL TRIGGERS
--DML TRIGGERS --STATEMENTS INSERT UPDATE DELETE 
--MAGIC TABLES (INTERTED AND DELETED TABLES)
/*
TRIGGER SYNTAX
CREATE [OR ALTER] TRIGGER TRIGGER_NAME ON TABLE_NAME
FOR ACTION_NAME [INSERT , DELETE, OR UPDATE]
AS 
BEGIN
	TRIGGER BODY
END
*/

CREATE OR ALTER TRIGGER EmpSalCheck ON Employees
FOR UPDATE --[INSERT , DELETE, OR UPDATE]
AS 
BEGIN
	DECLARE @OLD_SALARY DECIMAL(18,2);
	DECLARE @NEW_SALARY DECIMAL(18,2);

	SELECT @OLD_SALARY = Salary FROM deleted;
	SELECT @NEW_SALARY = Salary FROM inserted;

	IF @OLD_SALARY >@NEW_SALARY 
	BEGIN
		PRINT 'NEW SALARY CONNTBE LESS THEN OLD SALARY ';
		ROLLBACK;
	END;

END;

update Employees SET Salary = Salary-500;
update Employees SET Salary = Salary+500;

------------------------------------------------------------------------------------------------
CREATE OR ALTER TRIGGER EmpSalCheck ON Employees
FOR DELETE --[INSERT , DELETE, OR UPDATE]
AS 
BEGIN
	DECLARE @COUNT int ;

	select @COUNT = COUNT (*) FROM deleted;
	IF @COUNT >	 1
	BEGIN
		PRINT 'CANNOT DELETE MORE THAN ONE RECORD AT A TIME';
		ROLLBACK;
	END;

END;

DELETE Employees  WHERE EmployeeId = 9;
select * from Employees;

DELETE Employees;
select * from Employees;


------------------------------------------------
--instead of trigger
--create a view bc instead of trigger is applicable only on view

CREATE OR ALTER VIEW EmpVIEW AS
SELECT e.EmployeeId ,e.FirstName, e.Salary, d.DepartmentName
FROM Employees e, Department d
WHERE d.DepartmentId = e.DepartmentId;

create OR ALTER trigger TIG_EMPVIEW ON EmpVIEW INSTEAD OF INSERT AS
BEGIN
	DECLARE @empid INT;
	DECLARE @name NVARCHAR (50);
	DECLARE @sal DECIMAL (18, 2);
	DECLARE @depid INT;
	SELECT @empid = EmployeeId, @name = FirstName, @sal = Salary ,
	@depid = d.DepartmentId
	FROM Department d, inserted
	WHERE d.DepartmentName = inserted.DepartmentName;

	IF @depid IS NULL
	BEGIN
		PRINT 'Invalid Department';
		ROLLBACK;
	END;
INSERT INTO Employees (EmployeeId, FirstName, Salary, DepartmentId)
VALUES (@empid, @name, @sal, @depid);
END;

INSERT INTO EmpVIEW VALUES(9,'ALI',10500,'HR');
SELECT * FROM EmpVIEW;
SELECT * FROM Employees;
SELECT * FROM Department;



