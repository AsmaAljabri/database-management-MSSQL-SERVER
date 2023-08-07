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

-- or
insert into student VALUES (2,'ali','qatar','ali332@gmail.com' ):



create table employee(
e_id int , --PK is constraints 
e_name varchar(15) not null,
constraint  Pk_id_emp primary key(e_id)

);

