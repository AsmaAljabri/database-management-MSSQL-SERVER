/*
create table teacher(
t_id int primary key,
t_name varchar (50),
t_address varchar (50));
*/
--insert into teacher (t_id, t_name, t_address) values (11, 'sam','USA');

-- select * from student;
select * from teacher;
-- alter database MakeenDB modify name = makeen;
-- EXEC sp_renamedb MakeenDB, DBmakeen;

ALTER TABLE teacher ADD t_phone numeric(8);-- adding new column to a table 

UPDATE dbo.teacher
SET t_phone=99885544
Where t_id = 11

insert into teacher (t_id, t_name, t_address, t_phone) values (22, 'well','UK',99337744);

ALTER TABLE teacher ALTER COLUMN t_phone numeric (10); --change the chararctistc of the columns


CREATE TABLE COSTUME
(
    cus_id CHAR(5),
    Price4 DECIMAL(12,2), 
    Price2 DECIMAL(12,2),
    price  DECIMAL(12,2),  
    
 );

 alter table COSTUME alter column cus_id char not null;
 alter table COSTUME add constraint cus_pk primary key (cus_id);
