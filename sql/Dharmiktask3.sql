create database test3;
use test3;
create table employee(
employee_id int primary key,
first_name varchar(100),
last_name varchar(100),
department_id int ,
hire_date date,
email varchar(100),
foreign key(department_id) references department(department_id)
)

create table department (
department_id int primary key,
department_name varchar(100)
)

create table salaries(
employee_id int ,
salary numeric(18,2),
effective_date date,
 foreign key(employee_id) references  employee(employee_id)
)

INSERT INTO department VALUES(1,'Finance'),(2,'hr'),(3,'it');

INSERT INTO department VALUES(4,'DESIGN');

INSERT INTO employee VALUES (1,'Dharmik','Vadhia',1,'2025-1-16','Darmik@gmail.com');
INSERT INTO employee VALUES (2,'Mayur','Vadhia',3,'2025-1-16','Mayur@gmail.com');
INSERT INTO employee VALUES (3,'Dev','Vadhia',1,'2025-1-16','Dev@gmail.com');
INSERT INTO employee  VALUES (4,'Ashish','Vadhia',2,'2020-1-16','Ashish@gmail.com');
INSERT INTO employee VALUES (5,'AAA','BBB',3,'2025-1-16','xyz@gmail.com');
INSERT INTO employee  VALUES (7,'kano','AAA',2,'2019-1-16','Kano@gmail.com');
INSERT INTO salaries VALUES (6,50000,'2019-01-17')
insert into salaries values (4,23800,'2019-10-26')
INSERT INTO salaries VALUES(1,25000,'2025-1-16');
INSERT INTO salaries VALUES(5,25000,'2025-1-16');
INSERT INTO salaries VALUES(3,90000,'2025-1-16');
INSERT INTO salaries VALUES(2,21000,'2025-1-16');



--1. Select all columns from Employees:
select * from employee;	

--2. Select first and last names of all employees:
select first_name , last_name from  employee;

--3. Find employees who work in the 'HR' department:

select e.first_name , e.last_name , d.department_id, d.department_name from employee e join department d on 
e.department_id = d.department_id where d.department_name = 'hr';

--4. Find employees hired after January 1, 2020:

select * from  employee where hire_date >'2020-1-1';

--5. Find the total number of employees:
select count(*) as total_employee from employee

--6. Find the average salary of employees in the 'Finance' department:
select AVG(s.salary) as average_salaries from salaries s join employee e on  s.employee_id = e.employee_id join department d
on e.department_id = d.department_id where d.department_name = 'Finance';


--7. Find the highest salary in the company:
select max(salary) as highest_salary from salaries;

--8. Find employees with a salary higher than 70,000:
select salary from salaries where salary > 70000;


--9. List the department names and the number of employees in each department:
select d.department_name , count(*) from department d join employee e on d.department_id=e.department_id
group by d.department_name;

--10. Find the department with the highest average salary:
select top 1 d.department_name , avg(s.salary) as average_salary from salaries s join employee e on 
s.employee_id = e.employee_id join department d on e.department_id = d.department_id
group by d.department_name order by average_salary desc;



--11. Find the employees who do not have a salary record:
select e.first_name , e.last_name from employee e left join salaries s on e.employee_id = s.employee_id where salary is  null;



--12. Update an employee's email address:
update employee set email = 'Kano@gmail.com' where employee_id = 6;


--13. Delete an employee record (for example, employee with ID 4):
delete from employee where employee_id = 7;



--14. Create a subquery to find employees with a salary above the average salary: 
select e.first_name , e.last_name , s.salary from employee e join salaries s on e.employee_id = s.employee_id
where salary >(select avg(salary) from salaries);


--15.Stored Procedure: Adding New Employee
create procedure add_emplyee_procedure 
(@employee_id int ,@first_name varchar(100) ,@last_name varchar(100) , @department_id int , @hire_date date ,@email varchar(100))
as
 begin 
 insert into employee values(@employee_id,@first_name,@last_name,@department_id , @hire_date ,@email);
 end 

 exec add_emplyee_procedure @employee_id=7,@first_name='Kano',@last_name='Vadhia',@department_id='3' , @hire_date='2025-02-10' ,@email='Kano@gmail.com'

 
--16.Create a trigger that prevents salary updates to below 40,000.

create trigger prevent_salary
on salaries
after update
as
begin 
declare @salary numeric(18,2)
select @salary=salary from inserted;
if(@salary<40000)
begin
print 'salary is below 40000 is not allowed  '

end
else
begin
print 'salary updated  '

end 
end 


update Salaries set salary=100000 where employee_id=1;


--17.Create a function that calculates a bonus (10% of the salary) for an employee.

CREATE FUNCTION BONUS(@SALARY NUMERIC(18,2))
RETURNS NUMERIC(18,2)
AS 
BEGIN
DECLARE @RESULT NUMERIC(18,2);
SET @RESULT=@SALARY*10/100;
RETURN @RESULT ;
END

SELECT e.first_name,e.last_name,s.salary, dbo.BONUS(s.salary) AS BONUS FROM
employee e INNER JOIN salaries s ON e.employee_id=s.employee_id;


--18.Create a stored procedure that updates an employee's email.
CREATE PROCEDURE Update_email_emp(@id int ,@email VARCHAR(100))
AS 
BEGIN

UPDATE employee SET email=@email WHERE employee_id=@id;
END 


EXEC Update_email_emp @ID=7,@email='kanoVadhia@gmail.com';


--19.Create a trigger that logs changes to the Salaries table.

create table salaries_logs(
employee_id int ,
salary numeric(30,2),
effective_date date ,
data_change_date datetime default getdate()
);


create trigger log_change
on salaries
after insert ,update ,delete 
as 
begin

declare @id int ;
declare @salary numeric(18,2);
declare @date date ;

if exists(select * from inserted)
begin
select  @id=employee_id,@salary=salary,@date=effective_date from inserted;
end 
if exists(select * from deleted)
begin
select  @id=employee_id,@salary=salary,@date=effective_date from deleted;
end 


insert into salaries_logs(employee_id,salary,effective_date) values (@id,@salary,@date);
end


update Salaries set salary=100000 where employee_id=1;
delete from Salaries where employee_id=7;
insert into Salaries values (7,80000,'2025-1-1');



--20.Delete Department with no employee
    
DELETE FROM department WHERE department_id  NOT IN (SELECT department_id FROM employee );