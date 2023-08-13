-- create/ alter/drop is DDl commands
/*
create table student( 
studentID int not null primary key,
name [nvarchar](50) not null,
location [nvarchar](50) not null,
Email [nvarchar](50) not null);
*/
-- EXEC sp_help 'student'; 
insert into student(studentID, name, location,Email) values(1,'asma', 'muscat','asma12@gmail.com')
-- CREATE DATABASE YourDatabaseName;
--SELECT CONVERT(VARCHAR(20), GETDATE(), 120) AS FormattedDateTime;
--SELECT GETDATE() AS CurrentDateTime;
--SELECT GETDATE() AS CurrentDateTime;
--SELECT CHAR(65) AS Character;
--SELECT CONCAT(First_Name, ' ', Last_Name) AS Full_Name
--FROM Employees;
-- SELECT CONCAT(expression1, expression2, expression3, ...) AS concatenated_result
--FROM your_table;
/*
create table teacher(
t_id int primary key,
t_name varchar (50),
t_address varchar (50));
*/
--insert into teacher (t_id, t_name, t_address) values (11, 'sam','USA');

-- select * from student;
-- alter database MakeenDB modify name = makeen;
-- EXEC sp_renamedb MakeenDB, DBmakeen;

*/
-- or
insert into student VALUES (2,'ali','qatar','ali332@gmail.com' ):



create table employee(
e_id int , --PK is constraints 
e_name varchar(15) not null,
constraint  Pk_id_emp primary key(e_id)

);

