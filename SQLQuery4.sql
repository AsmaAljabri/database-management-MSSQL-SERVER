create table cources(
c_id char(8) constraint c_corceseID_pk primary key,
c_name varchar(20));

create table student( 
studentID int not null primary key,
name [nvarchar](50) not null,
location [nvarchar](50) not null,
Email [nvarchar](50) not null);

ALTER TABLE student ADD s_firstname varchar(30);
ALTER TABLE student ADD s_lastname varchar(30);
ALTER TABLE student ADD s_mobile_no char(50);
ALTER TABLE student ADD stud_gender char(1);
ALTER TABLE student ADD s_fee numeric(8,2);
ALTER TABLE student ADD cource_id char(8);

select * from student;

alter table student add constraint s_student_cources_FK foreign key (cource_id ) references cources(c_id);
