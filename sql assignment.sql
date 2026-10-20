-- CRUD operations
-- 1.Create a students table with student_id, student_name, age, department, and marks.
create database project_students;
use project_students;
drop database project_students;
create table students(student_id int(10) primary key auto_increment,student_name varchar(255) not null,
age int(10) not null,department varchar(255) not null,marks decimal(10,2)not null , check(marks>=40));
-- 2.Insert 10 student records into the table.
insert into students(student_id,student_name,age,department,marks) values (1,"Rahul",19,"EEE",84),(2,"Nikil",19,"ECE",80),
(3,"Rohith",18,"CSE",87),(4,"Rasi",19,"Civil",68),(5,"Soni",19,"Mech",75),(6,"Shanthi",19,"EEE",56),(7,"Chandra",19,"ECE",74),
(8,"Rohan",20,"Civil",74),(9,"Roshan",19,"EEE",56),(10,"Keerthi",19,"CSE",84);
drop table students;
-- 3.Display all students whose marks are greater than 80 
select marks from students where marks>80;
-- 4. Update the marks of a student using student_id.
update students set marks = 65 where student_id = 6;
select * from students;
-- 5. Delete students whose marks are below 60.
set sql_safe_updates = 0;
delete from students where marks<60;
-- 6.Display the second-highest salary from an employees table.
-- create database project_employees;
-- drop database project_employees;
-- use project_employees;
create table employees(employ_id int(10) primary key, employ_name varchar(255)not null, department varchar(255)not null ,
salary decimal(10,2)not null, status varchar(255) default "inactive",check (status in("active","inactive")));
insert into employees(employ_id,employ_name,department,salary,status) values (10,"rahul","IT",100000,"active"),(20,"rohith","IT",150000,"active"),
(30,"roshan","NON-IT",100000,"inactive"),(40,"suresh","IT",250000,"inactive"),(50,"keerthi","IT",280000,"active");
select * from employees where salary = (select max(salary) from employees where salary < (select max(salary) from employees));
-- 2. joins
create table courses(course_id int(10) primary key auto_increment, course_name varchar(255) not null, 
course_fee decimal(10,2) not null, duration_months int(10)not null,check (course_fee >10000));
insert into courses(course_id, course_name, course_fee, duration_months) values (1,"python",20000,3),(2,"java",25000,4),
(3,"data science",30000,5),(4,"data analyst",26000,4),(5,"c lang",21000,3),(6,"web development",40000,2),(7,"DSA",30000,5),
(8,"SQL",30000,1),(9,"Full stack development",30000,5),(10,".net",30000,4);
create table enrollments(enroll_id int(10) primary key auto_increment,student_id int(10)not null, 
foreign key(student_id) references students(student_id),course_id int(10)not null ,foreign key(course_id) references courses(course_id),
 enroll_date date,status varchar(255),fee_paid decimal(10,2)default 0.00,check (status in ("Active","inactive","dropped")));
desc enrollments;
drop table enrollments;
insert into enrollments(enroll_id,student_id,course_id,enroll_date,status,fee_paid) values (1,1,1,"2026-02-15","Active",22000),
(2,2,2,"2026-02-17","dropped",20000.00),(3,3,3,"2026-02-05","inactive",2200.00),(4,4,4,"2026-03-15","Active",32000.00),
(5,5,5,"2026-02-06","inactive",42000.00),(6,6,6, "2026-01-10", "Active", 5000.00),(7,7,7, "2026-01-12", "inactive", 7500.00),
(8,8,8, "2026-01-15", "Active", 3000.00),(9,9,9, "2026-01-18", "inactive", 5000.00),(10,10,10, "2026-01-20", "dropped", 2500.00);
select * from enrollments;
select * from courses;
select * from students;
-- 7.Explain the difference between INNER JOIN, LEFT JOIN, RIGHT JOIN, and CROSS JOIN using queries.
select * from students s  inner join enrollments e on s.student_id = e.student_id;
-- left join 
select * from students s  left join enrollments e on s.student_id = e.student_id;
-- right join  
select s.student_id,s.student_name,s.department from students s right join enrollments e on s.student_id = e.student_id;
-- right join 
select e.enroll_id , e.student_id , e.status,e.fee_paid from enrollments e right join students s on e.student_id = s.student_id;
-- cross join 
select s.student_name,c.course_name from students s cross join courses c;
-- cross join
select s.student_id,s.student_name, e.status from students s cross join enrollments e;
-- 8.Display student names along with their course names using INNER JOIN.
select s.student_name, c.course_name from students s inner join enrollments e on s.student_id = e.student_id inner join courses c 
on e.course_id = c.course_id;
-- 9.Display all students, including students who have not enrolled in any course.
update courses set course_name = "-" where course_id = 3;
select s.student_id,s.student_name ,c.course_name from students s inner join enrollments e on s.student_id = e.student_id 
inner join courses c on c.course_id = e.course_id;
-- 10.Display all courses, including courses with no enrolled students.
select s.student_id,s.student_name ,c.course_name from students s inner join enrollments e on s.student_id = e.student_id 
inner join courses c on c.course_id = e.course_id;
-- 11.Find students who have not enrolled in any course.
select s.student_id,c.course_id,s.student_name ,c.course_name from students s inner join enrollments e on s.student_id = e.student_id 
inner join courses c on c.course_id = e.course_id where s.student_id = 3 order by s.student_id;
-- 12.Display employee names along with their department names using JOINS.
create table employ_department(employ_id int(10) primary key , employ_department varchar(255) not null);
insert into employ_department(employ_id,employ_department) values (10,"IT"),(20,"IT"),(30,"core mech"),(40,"non-it"),(50,"non-it");
select * from employ_department;
select e.employ_name , ed.employ_department from employees e inner join employ_department ed on e.employ_id = ed.employ_id;
-- 13.Join three tables: students, enrollments, and courses to display student names, course names, and enrollment dates.
select s.student_id,s.student_name ,c.course_name,c.course_id,e.enroll_id,e.status,e.fee_paid from students s inner join enrollments e 
on s.student_id = e.student_id inner join courses c on c.course_id = e.course_id;
--  3. Subqueries
-- 14.Find employees whose salary is greater than the average salary of all employees.
select * from employees;
select avg(salary) from employees;
select employ_name,salary from employees where salary > (select avg(salary) from employees);
-- 15.Find the employee who receives the second-highest salary using a subquery.
select employ_name,salary from employees where salary = (select max(salary) from employees where salary< (select max(salary) from employees));
-- 16.Find employees who earn more than the highest-paid employee in the IT department.
select employ_name,salary from employees where salary = (select max(salary) from employees where department="IT");
-- 17.Display students who scored more than the average marks of all students.
select * from students;
select avg(marks) from students;
select * from students where marks > (select avg(marks) from students);
-- 18.Find the department with the highest average salary.
select avg(salary) from employees where department = "IT";
select employ_name,department,salary from employees where salary = (select max(salary) from employees where salary
>(select avg(salary) from employees where department = "IT"));
-- 19.Find employees who earn the same salary as at least one other employee.
select employ_id ,employ_name,salary from employees where salary in (select salary from employees group by salary having count(salary)>1);
-- 20.Find courses whose fees are greater than the average course fee.
select avg(course_fee) from courses;
select course_name, course_fee from courses where course_fee > (select avg(course_fee) from courses);
--  4. Aggregate Functions, WHERE, GROUP BY and HAVING
-- 21.Find the total, average, maximum, and minimum salary of employees.
select sum(salary) from employees;
select avg(salary) from employees;
select min(salary) from employees;
select max(salary) from employees;
-- 22.Count the number of employees in each department.
select department,count(department) as total_employ from employees group by department;
-- 23.Display departments whose average salary is greater than ₹50,000.
select department,salary from employees where salary > 50000;
-- 24.Find departments having more than three employees.
select department,count(department) as total_employ from employees group by department having count(department)>3;
-- 25.Display the total salary paid by each department in descending order.
select department , salary from employees order by salary desc;
-- 26.Find the department with the highest number of employees.
select department,count(department) as total_employ from employees group by department having count(department);
-- 27.Explain the difference between WHERE and HAVING with examples
select department,salary  from employees where salary >100000;
select department ,min(salary) as min_salary from employees group by department having min(salary); 
-- 28.Write a query to count students department-wise who scored more than 70 marks.
select * from students;
select department,count(department) as total_stu from students where marks > 70 group by department;
-- 29.Display departments where the total salary exceeds ₹2,00,000.
select department , salary  from employees where salary > 200000;
-- 5. Views
-- 30. What is a view in MySQL, and why do we use it?
-- A View in MySQL is a virtual table created using a SQL query. 
-- It displays data from one or more existing tables. A view usually stores the query definition, not a separate copy of the table's data.
-- Why do we use Views?
-- 1. Simplicity: Simplifies complex SQL queries.
-- 2. Security: Allows users to access only selected columns or rows.
-- 3. Reusability: Lets us use the same query multiple times.
-- 4. Data presentation: Displays only the information we need.
-- 5. Maintainability: Makes frequently used queries easier to manage.
-- 31.Create a view that displays only employee names and salaries.
create view employee_view as select employ_name,salary from employees;
select * from employee_view;
drop view employee_view;
-- 32.Retrieve data from a view using a WHERE condition.
select * from employee_view where salary > 100000;
-- 33.Update employee details through a view.
set sql_safe_updates = 0;
update employee_view set salary = 180000 where employ_name = "rohith";
-- 34.Drop a view from the database.
drop view employee_view;
-- 35.What is the difference between a view and a table?
-- A table stores data in rows and columns, whereas a view is a virtual table based on a SQL query 
-- that retrieves data from one or more tables.
-- 6. Indexes
-- 36. What is an index in MySQL, and why is it used?
-- An index in MySQL is a data structure that helps retrieve records from a table faster without scanning every row in the table.
-- Think of a book: instead of reading every page to find a topic, you use the index at the back to locate it quickly. 
-- A database index works similarly.
-- Why do we use indexes?
-- Faster searching: Speeds up queries that use WHERE.
-- Faster sorting: Can help with ORDER BY.
-- Faster joining: Can improve queries that use JOIN.
-- Enforce uniqueness: A UNIQUE index prevents duplicate values in the indexed column or column combination.
-- 37.Create an index on the employee_name column.
create index index_employ_name on employees(employ_name);
-- 38.Create a composite index on department and salary.
create index department_salary_index on employees(department,salary);
-- 39.Drop an index from a table.
drop index index_employ_name on employees;
drop index department_salary_index on employees;
-- 40.Explain the difference between PRIMARY KEY, UNIQUE KEY, and a normal index.
-- In MySQL, PRIMARY KEY, UNIQUE KEY, and a normal INDEX are used to identify records, 
-- enforce uniqueness, and improve query performance. The main difference is how they handle duplicate values and NULL.
-- primary key(Uniquely identifies each row),unique key(Prevents duplicate indexed values),normal index(Improves data retrieval speed)
-- 41.What are the advantages and disadvantages of indexes?
-- In MySQL, an index is a database object that helps retrieve records faster from a table, similar to an index in a book.
-- Advantages of Indexes
-- 1. Faster data retrieval: Indexes speed up searching for records using WHERE conditions.
-- 2. Improved query performance: They can make queries using SELECT execute faster.
-- 3. Faster sorting: Indexes can improve the performance of ORDER BY.
-- 4. Efficient joins: Indexes on join columns can improve the performance of joins between tables.
-- 5. Enforce uniqueness: UNIQUE indexes prevent duplicate values in a column or combination of columns.
-- 6. Efficient grouping: Indexes can sometimes improve queries using GROUP BY.
-- Disadvantages of Indexes
-- 1. Extra storage: Indexes require additional disk space.
-- 2. Slower INSERT operations: MySQL must update relevant indexes when new records are inserted.
-- 3. Slower UPDATE operations: Changing indexed column values requires index maintenance.
-- 4. Slower DELETE operations: MySQL must remove deleted records from the relevant indexes.
-- 5. Too many indexes: Creating unnecessary indexes increases storage requirements and maintenance overhead.
-- 6. Not always useful: Indexes may provide little benefit for small tables or columns with few distinct values.
-- 7. Transactions
-- 42. What is a transaction in MySQL?
-- What is a Transaction in MySQL?
-- A transaction in MySQL is a group of SQL statements executed as a single unit of work. 
-- Either all the operations are completed successfully, or the changes can be rolled back if something goes wrong.
-- Transactions help maintain data consistency and integrity in a database.
-- 43.Explain COMMIT, ROLLBACK, and SAVEPOINT with examples.
-- COMMIT: Saves transaction changes permanently.
-- ROLLBACK: Undoes uncommitted transaction changes.
-- SAVEPOINT: Creates a checkpoint that allows partial rollback within a transaction.
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
-- 44.Transfer ₹5,000 from one bank account to another using a transaction.
create table bank_account(account_id int(10) primary key auto_increment, account_name varchar(255)not null , balance decimal(10,2));
insert into bank_account(account_id,account_name,balance) values (101,"rahul",25000),(102,"rohith",35000),(103,"sony",26000);
select * from bank_account;
start transaction;
update bank_account set balance = balance - 5000 where account_id = 102 and balance > 2000;
update bank_account set balance = balance + 5000 where account_id = 101;
commit;
-- 45.Insert a record, create a SAVEPOINT, make another change, and roll back to the savepoint.
insert into bank_account(account_id,account_name,balance) values (104,"kiran",28500);
start transaction;
set sql_safe_updates = 0;
update bank_account set balance = 50000 where account_name = "rohith";
savepoint bank1;
update bank_account set balance = 52000 where account_name = "rohith";
rollback to savepoint bank1;
commit;
select * from bank_account;
-- 46.What happens if an error occurs before COMMIT?
-- If an error occurs before COMMIT, the transaction's changes are not necessarily rolled back automatically. 
-- With InnoDB, a statement error generally rolls back only that statement, while earlier successful changes remain uncommitted. 
-- We should use ROLLBACK to undo the entire transaction if the operation fails.
-- 47.What are the ACID properties of transactions?
-- ACID stands for Atomicity, Consistency, Isolation, and Durability.
-- These are four important properties that help ensure database transactions are reliable and maintain data integrity.
-- 48.Explain the difference between DELETE, TRUNCATE, and DROP in relation to transactions.
-- Delete(Purpose	Removes selected rows or all rows)
-- Truncate(Removes all rows)
-- drop(Removes the entire table)
-- 8. Constraints
-- 49. Explain PRIMARY KEY, FOREIGN KEY, UNIQUE, NOT NULL, CHECK, and DEFAULT constraints.
-- PRIMARY KEY
-- Definition: A PRIMARY KEY uniquely identifies each row in a table. It does not allow duplicate values or NULL values.
-- FOREIGN KEY
-- Definition: A FOREIGN KEY creates a relationship between two tables.
-- It ensures that a value in one table refers to an existing key in another table
-- UNIQUE
-- Definition: The UNIQUE constraint ensures that values in a column, or a combination of columns, are not duplicated. 
-- NOT NULL
-- Definition: The NOT NULL constraint ensures that a column must have a value and cannot store NULL.
-- CHECK
-- Definition: The CHECK constraint ensures that inserted or updated values satisfy a specified condition.
-- DEFAULT
-- Definition: The DEFAULT constraint provides a predefined value when an INSERT statement does not specify a value for that column.
-- 50.Create a table with a PRIMARY KEY and a NOT NULL constraint.
create table department(depart_id int(10) primary key ,depart_name varchar(255)not null, status varchar(255)not null);
insert into department(depart_id,depart_name,status) values (101,"IT","Enrolled"),(102,"HR","Enrolled"),(103,"Finance","Not enrolled");
select * from department;
-- 51.Create a student table with a UNIQUE constraint on email.
create table student_table(student_id int(10) primary key , student_name varchar(255)not null,email varchar(255)unique);
insert into student_table(student_id,student_name,email) values(1,"A","deepadeepu@gmail.com"),(2,"B","abcdefgh@gmail.com"),
(3,"C","deepuworld@gmail.com");
-- 52.Create departments and employees tables with a FOREIGN KEY relationship.
create table departments(employ_id int(10) primary key,depart_id int(10) not null,
status varchar(255)not null,salary int(10)not null, check(salary>25000));
create table employees_table(employ_id int(10) not null , constraint fk_employee foreign key(employ_id) references 
departments(employ_id) on update cascade ,employ_name varchar(255)not null);
drop table employees_table;
drop table departments;
insert into departments(employ_id,depart_id,status,salary) values (101,1,"Active",35000),(102,2,"Not active",40000);
insert into employees_table(employ_id,employ_name) values(101,"Rahul"),(102,"Rohith");
select et.employ_id,et.employ_name,d.depart_id,d.salary from employees_table et inner join departments  d 
on d.employ_id  = et.employ_id;
-- 53.Add a constraint to an existing table using ALTER TABLE.
alter table departments add column email varchar(255)unique;
set sql_safe_updates = 0;
update departments set email = "abcdefrg@gmail.com" where depart_id = 1;
update departments set email = "abfgttyhh@gmail.com" where depart_id = 2;
select * from departments;
select * from employees_table;
-- 54.Remove a foreign key constraint from a table.
alter table employees_table drop foreign key fk_employee;
-- 55.What happens when you try to insert a duplicate primary key?
-- In MySQL, when you try to insert a duplicate PRIMARY KEY, MySQL returns an error and rejects the 
-- new row because a primary key must contain unique, non-NULL values.
-- 56.Explain the difference between PRIMARY KEY and UNIQUE.
-- In MySQL, both PRIMARY KEY and UNIQUE constraints prevent duplicate values, but they differ 
-- in how they handle NULL values and how many constraints a table can have.
-- 57.How do ON DELETE CASCADE and ON UPDATE CASCADE
-- Definition: When a record in the parent table is deleted, MySQL automatically deletes the related records in the child table.
-- Example: A college has departments and students. When a department is deleted, its related student records are also deleted.
delete from departments where employ_id = 101;
-- Definition: When a referenced key value in the parent table is updated, MySQL automatically updates the corresponding 
-- foreign key values in the child table.
update departments set depart_id = 20 where depart_id = 2;





