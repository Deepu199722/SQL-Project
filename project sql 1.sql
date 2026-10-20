-- database
-- schema design 
-- college  database -- course table, students,enrollments table 
-- create database
-- relations -- one to one , one to many, many to many , many to one (create relationships)
create database project_college;
use project_college;
drop database project_college;
show databases;
show tables;
create table students(student_id int(10) primary key auto_increment, name varchar(255)not null ,email varchar(255) unique
 , phone int(10) not null,city varchar(255));
insert into students(student_id,name ,email,phone,city) values(1,"A","abc@gmail.com",948561235,"hyd"),
(2,"B","bcd@gmail.com",954875614,"vizag"),(3,"C","erbc@gmail.com",948561214,"delhi"),(4,"D","bcas@gmail.com",948547214,"kurnool"),
(5,"E","vvgfrt@gmail.com",941461214,"kadapa");
select * from students;
drop table students;
drop table courses;
create table courses(course_id int(10) primary key auto_increment, course_name varchar(255) not null, 
course_fee decimal(10,2) not null, duration_months int(10)not null,check (course_fee >=0));
insert into courses(course_id, course_name, course_fee, duration_months) values (1,"python",20000,3),(2,"java",25000,4),
(3,"data science",30000,5),(4,"data analyst",26000,4),(5,"c lang",21000,3);
create table enrollments(enroll_id int(10) primary key auto_increment,student_id int(10)not null, 
foreign key(student_id) references students(student_id),course_id int(10)not null ,foreign key(course_id) references courses(course_id),
 enroll_date date,status varchar(255) default "Active",fee_paid decimal(10,2)default 0.00,check (status in ("Active","inactive","dropped")));
desc enrollments;
drop table enrollments;
insert into enrollments(enroll_id,student_id,course_id,enroll_date,status,fee_paid) values (1,1,1,"2026-02-15","Active",22000),
(2,2,2,"2026-02-17","dropped",20000),(3,3,3,"2026-02-05","inactive",2200),(4,4,4,"2026-03-15","Active",32000),
(5,5,5,"2026-02-06","inactive",42000);
select * from enrollments;
select * from courses;
select * from students;
-- update operator
update students set city = "vijayawada" where student_id = 3;
set sql_safe_updates = 0;
update courses set duration_months = 6 where course_name = "data science";
update enrollments set status = "active" where enroll_id = 3;
alter table students add column age int(10) check (age >= 18);
update students set age = elt(field(student_id,1,2,3,4,5),19,18,18,19,18);
insert into students(student_id,name ,email,phone,city) values(6,"F","abcesd@gmail.com",984561235,"nellore"),
(7,"G","abcerttg@gmail.com",940561235,"delhi");
update students set age = 19 where student_id = 7;
-- delete operator
delete from students where student_id = 6;
--  inner joins
select s.student_id ,s.name,s.city,c.course_id,c.course_name,e.enroll_id,e.status
 from students s inner join enrollments e on s.student_id = e.student_id
inner join courses c on c.course_id= e.course_id order by s.student_id;
-- left join 
select s.student_id, s.name,s.city from students s left join enrollments e on s.student_id = e.student_id;
-- right join 
select s.student_id, s.name,s.city from students s right join enrollments e on s.student_id = e.student_id;
-- joins specific data
select s.student_id ,s.name,s.city,c.course_id,c.course_name,e.enroll_id,e.status
 from students s inner join enrollments e on s.student_id = e.student_id
inner join courses c on c.course_id= e.course_id where s.student_id = 3 order by c.course_id;
-- group by and having clause 
select course_id , course_fee from courses group by course_id having course_id = 1;
-- find the 2nd max course fees
select course_name,course_fee,course_id from courses where course_fee = (select max(course_fee) from courses where course_fee < 
(select max(course_fee) from courses));
select * from courses where course_fee = (select max(course_fee) from courses where course_fee <
(select avg(course_fee) from courses));
select * from students where student_id in(select student_id from enrollments where course_id = 
(select course_id from courses where course_name = 'data science'));
-- union -- removes duplicates
select student_id,name,email,city from students
union 
select enroll_id, student_id,enroll_date,status from enrollments;
-- union all-- keep duplicates
select student_id,name,email,city from students
union all
select enroll_id, student_id,enroll_date,status from enrollments;
use project_students;
select * from employees;
create view employees_view as select employ_name,salary from employees;
select * from employees_view;
drop view employee_view;
select * from employees_view where salary > 100000;
set sql_safe_updates = 0;
update employees_view set salary = 180000 where employ_name = "rohith";
drop view employee_view;
create index index_employ_id on employees(employ_id);
drop index index_employ_id on employees;
start transaction;
update employees set salary = 150000 where employ_name = "rohith";
savepoint employ1;
update employees set salary = 160000 where employ_name = "rohith";
rollback to savepoint employ1;
select * from employees;
start transaction;
update employees set salary = 240000 where employ_name = "suresh";
rollback;
commit;








