
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