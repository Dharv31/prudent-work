create database demo;
use demo;

-
--employee table

create table employee  (rollno int  identity(1,1) primary key,
Ename varchar(100) , age int , employee_id int unique ,dob date , salary numeric(18,2));

insert into employee values ('ck',21,10,'2003-06-16',6000);

select * from employee;

insert into employee values 
('Dharmik',21,1,'2003-06-16',120000),
('rushik',20,2,'2004-12-20',20000),
('nirav',22,3,'2002-10-16',40000),
('rajan',21,4,'2004-09-25',90000),
('meet Gojiya',20,5,'2004-05-28',100000),
('jay der',20,6,'2004-08-29',90000),
('vivek gohil',21,7,'2003-09-15',60000),
('tanvir parmar',21,8,'2003-09-25',6000),
('mayank',28,9,'1997-03-19',48000);

truncate table employee;
drop table employee;

exec sp_rename 'employee.Date-of-birth' ,'dob';


go
select age ,
sum(salary) as totalsalary
from employee 
group by age 
order by totalsalary desc ;

--employee_detail table

create table employee_detail( employee_id int unique ,
Ename varchar(100) , gender char(1) ,Eaddress varchar(200) , phone char(10) ,
constraint fk foreign key (employee_id) references employee(employee_id));

drop table employee_detail;

select * from employee_detail;

go
insert into employee_detail values (1,'Dharmik','M','Himdarshan','8200417705'),
 (2,'rushik','M','Himdarshan','7439205085'),
 (3,'nirav','M','Nikol','8335704904'),
 (4,'rajan','M','Rajkort','9245747595'),
 (5,'meet Gojiya','M','Ahirbhavan','8784804856'),
 (6,'jay der','M','Ahirbhavan','9234594759'),
 (7,'vivek gohil','M','sector15','8440509594'),
 (8,'tanvir parmar','M','sector15','7010304060'),
 (9,'mayank','M','Himdarshan','9020334455');


 -- employee_view view
 
 go 
 create view employee_view as
 select e.Ename , age , gender ,Eaddress ,phone ,dob from employee e join employee_detail ed on e.employee_id = ed.employee_id;

 select * from employee_view;

 -- employee_pro procedure to show employee, employee_detail,employee_view
 go
 create procedure employee_pro as
 begin
  select * from employee;
  select * from employee_view;
  select * from employee_detail;

  end;
  exec employee_pro ;


  -- procedure to inert into employee_detail

 go
 create procedure employee_insert 

   @Ename varchar(100),
   @employee_id int,
   @gender char(1),
  @Eaddress varchar(200),
   @phone char(10)
  
   as
   begin
   insert into employee_detail (employee_id,Ename,gender,Eaddress,phone) values (@employee_id,@Ename,@gender,@Eaddress,@phone);
   end;
  drop procedure employee_insert

   exec employee_insert @employee_id=10,@Ename='ck',@gender='M',@Eaddress='theltej',@phone='8756694694';


   --joins

   CREATE TABLE Student (      
  id int PRIMARY KEY IDENTITY,     
  admission_no varchar(45) NOT NULL,  
  first_name varchar(45) NOT NULL,      
  last_name varchar(45) NOT NULL,  
  age int,  
  city varchar(25) NOT NULL      
);    
    
CREATE TABLE Fee (   
  admission_no varchar(45) NOT NULL,  
  course varchar(45) NOT NULL,      
  amount_paid int,    
);  

INSERT INTO Student (admission_no, first_name, last_name, age, city)       
VALUES (3354,'Luisa', 'Evans', 13, 'Texas'),       
(2135, 'Paul', 'Ward', 15, 'Alaska'),       
(4321, 'Peter', 'Bennett', 14, 'California'),    
(4213,'Carlos', 'Patterson', 17, 'New York'),       
(5112, 'Rose', 'Huges', 16, 'Florida'),  
(6113, 'Marielia', 'Simmons', 15, 'Arizona'),    
(7555,'Antonio', 'Butler', 14, 'New York'),       
(8345, 'Diego', 'Cox', 13, 'California');  
  


    
INSERT INTO Fee (admission_no, course, amount_paid)       
VALUES (3354,'Java', 20000),       
(7555, 'Android', 22000),       
(4321, 'Python', 18000),    
(8345,'SQL', 15000),       
(5112, 'Machine Learning', 30000);  

--inner join

SELECT Student.admission_no, Student.first_name, Student.last_name, Fee.course, Fee.amount_paid  
FROM Student  
INNER JOIN Fee  
ON Student.admission_no = Fee.admission_no;  

--self join
SELECT S1.first_name, S1.last_name, S1.city  
FROM Student S1, Fee S2  
WHERE S1.admission_no <> S2.admission_no  
ORDER BY S2.admission_no;  

--cross join

SELECT Student.admission_no, Student.first_name, Student.last_name, Fee.course, Fee.amount_paid  
FROM Student  
CROSS JOIN Fee  
WHERE Student.admission_no = Fee.admission_no;  


--left outer join
SELECT Student.admission_no, Student.first_name, Student.last_name, Fee.course, Fee.amount_paid  
FROM Student  
LEFT OUTER JOIN Fee  
ON Student.admission_no = Fee.admission_no;  

--right outer join

SELECT Student.admission_no, Student.first_name, Student.last_name, Fee.course, Fee.amount_paid  
FROM Student  
RIGHT OUTER JOIN Fee  
ON Student.admission_no = Fee.admission_no;  

--full outer join

SELECT Student.admission_no, Student.first_name, Student.last_name, Fee.course, Fee.amount_paid  
FROM Student  
FULL OUTER JOIN Fee  
ON Student.admission_no = Fee.admission_no;  

