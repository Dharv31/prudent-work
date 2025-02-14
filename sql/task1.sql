create database task1;
USE task1;


CREATE TABLE MEMBERS (member_id INT IDENTITY(1,1) PRIMARY KEY,
    member_name VARCHAR(150),
    date_of_birth DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    join_date DATE,
    status BIT --return TRUE or FALSE 
	);

	ALTER TABLE MEMBERS
ADD total_payment DECIMAL(18, 2) DEFAULT 0;


CREATE TABLE PAYMENTS (
	payment_id INT IDENTITY(1,1) PRIMARY KEY,
    member_id INT ,
    payment_amount NUMERIC(18,2),
    payment_date DATE,
    payment_type VARCHAR(120),
	FOREIGN KEY(member_id) REFERENCES MEMBERS(member_id)   
);

CREATE TABLE EVENTS(
	event_id INT IDENTITY(1,1)  PRIMARY KEY,
    event_name VARCHAR(150),
    event_date DATE,
    event_location VARCHAR(100),
    event_description VARCHAR(255)
);

CREATE TABLE EventRegistrations (
	registration_id  INT IDENTITY(1,1) PRIMARY KEY,
    member_id  INT ,
    event_id INT ,
    registration_date DATE,
	FOREIGN KEY(member_id) REFERENCES MEMBERS(member_id) ,
	FOREIGN KEY(event_id) REFERENCES EVENTS(event_id) 
);




INSERT INTO MEMBERS VALUES('NIRAV','2003/2/2','	a@gmail.com','134567890','2010/3/6',1);
INSERT INTO MEMBERS VALUES('rajan','2004/12/9','rajan@gmail.com','789567890','2013/9/1',0);
INSERT INTO MEMBERS VALUES('rushik','2006/7/15','rushik@gmail.com','456567890','2015/7/13',1);
INSERT INTO MEMBERS VALUES('dharmik','2003/2/2','dharmik@gmail.com','134567890','2012/5/26',0);
INSERT INTO MEMBERS VALUES('deep','2005/7/12','deep@gmail.com','958967890','2018/1/26',0);
INSERT INTO MEMBERS VALUES('raj','2005/3/1','raj@gmail.com','958967890','2020/1/2',0);
INSERT INTO MEMBERS VALUES('ayush','2005/7/12','ayush@gmail.com','958967890','2020/1/2',0);



INSERT INTO PAYMENTS VALUES(2,15000,'2017/9/23','CASH');
INSERT INTO PAYMENTS VALUES(5,12000,'2019/2/2','ONLINE');
INSERT INTO PAYMENTS VALUES(4,10000,'2020/7/10','credit card');
INSERT INTO PAYMENTS VALUES(1,25000,'2018/2/10','debit card');
INSERT INTO PAYMENTS VALUES(2,10000,'2021/7/18','CASH');
INSERT INTO PAYMENTS VALUES(3,10000,'2022/10/10','CASH');

update PAYMENTS set payment_amount = 350 where payment_id = 2;

INSERT INTO EVENTS (event_name, event_date, event_location, event_description) 
VALUES 
('Concert in the Park', '2025-06-12', 'Central Park', 'A live music concert featuring various local bands.'),
('Art Exhibition', '2025-05-22', 'Gallery One', 'An exhibition showcasing contemporary art from emerging artists.'),
('rubric cube', '2025-07-30', 'Tech Center', 'A competitive event where participants solve the Rubiks Cube in the fastest time possible, showcasing different solving techniques and strategies.'),
('Food Festival', '2025-08-18', 'City Square', 'A festival offering a variety of international cuisines and food trucks.'),
('Marathon Race', '2025-09-10', 'Downtown Streets', 'A marathon race through the city streets with runners from around the world.'),
('Sport Day', '2024-12-25', 'collage', 'A day filled with various sports activities for all ages, including games, competitions, and fun physical challenges.');

update EVENTS set event_date = '2024/9/24' where event_id = 3;

insert into EventRegistrations(member_id,event_id,registration_date ) values
(4,2,'2023/1/10'),
(4,5,'2023/1/12'),
(2,2,'2020/10/10'),
(1,5,'2022/1/25'),
(3,1,'2021/7/1'),
(4,3,'2020/1/27'),
(5,4,'2021/9/15'),
(3,3,'2020/10/10')

update EventRegistrations set event_id = 2 where registration_id = 4 

SELECT * FROM MEMBERS;
SELECT * FROM EVENTS;
SELECT * FROM EventRegistrations;
SELECT * FROM PAYMENTS;

--1. Retrieve all member details from the `Members` table.
SELECT * FROM MEMBERS;


--2. Retrieve all members who joined after January 1, 2020.
select * from MEMBERS where YEAR(join_date) = 2020;

select * from MEMBERS where join_date >= '2020/1/1'

--3. List all events with the name of the members who registered for them.
select e.event_name ,m.member_name 
	from EVENTS e 
			join EventRegistrations er on er.event_id = e.event_id
			join MEMBERS m on m.member_id = er.member_id;

--4. Retrieve the number of events each member has registered for.
select m.member_id, m.member_name, COUNT(er.event_id) AS events_registered
		FROM MEMBERS m
		JOIN EventRegistrations er ON m.member_id = er.member_id
		JOIN EVENTS e ON e.event_id = er.event_id
		GROUP BY m.member_id, m.member_name;


--5. Retrieve the total payment made by each member.
select m.member_name ,sum(p.payment_amount) 
		from MEMBERS m join PAYMENTS p 
		on m.member_id = p.member_id
		group by m.member_name; 


-- 6. Retrieve the average payment made by each member.
select m.member_name ,avg(p.payment_amount) 
		from MEMBERS m join PAYMENTS p 
		on m.member_id = p.member_id
		group by m.member_name; 


--7. List members who have registered for more than 2 events.
select m.member_name,count(er.event_id) as Total_Event from EventRegistrations er 
		join MEMBERS m on m.member_id = er.member_id
		group by m.member_name having count(*) >= 2
			
			
--8. Retrieve events that do not have any registrations.
select e.event_name,e.event_id from EVENTS e 
		left join EventRegistrations er on e.event_id=er.event_id
		where er.registration_id is null;
	
		
--9. Retrieve members who haven’t made any payments.
select m.member_id,m.member_name from MEMBERS m 
		left join PAYMENTS p on p.member_id = m.member_id 
		where p.member_id is null;



--10.Retrieve events that are scheduled for a future date.
select * from EVENTS where event_date > SYSDATETIME();


--11.Find Events with Payments Greater Than 500.
select e.event_name ,sum( p.payment_amount) as Total_payment from EVENTS e 
		join EventRegistrations er on e.event_id = er.event_id
		join PAYMENTS p on p.member_id = er.member_id
		where p.payment_amount > 500 group by e.event_name;




--12.Find the Event with the Most Registrations
select top 1 e.event_name,count(e.event_name) as Total_Event from EventRegistrations er 
		join EVENTS e on er.event_id = e.event_id 
		group by e.event_name  order by Total_Event desc



--13. Find Members Who Registered for the Same Event Twice
----select m.member_name,count(er.event_id) as total_event from EventRegistrations er 
----		join MEMBERS m on er.member_id = m.member_id
----		group by m.member_name having count(er.event_id) >=2

SELECT * FROM MEMBERS;
SELECT * FROM EVENTS;
SELECT * FROM EventRegistrations;
select m.member_name,er.event_id,count(er.event_id) as total_event 
		from EventRegistrations er 
		join MEMBERS m on er.member_id = m.member_id
		group by m.member_name,er.event_id having count(er.event_id) >=2
		go


--14. Create a stored procedure to insert a new payment.
create procedure insert_payment_data(
@member_id int,
@payment_amount NUMERIC(18,2),
@payment_date DATE,
@payment_type VARCHAR(120))
as
begin
	INSERT INTO PAYMENTS (member_id,payment_amount,payment_date,payment_type) 
	VALUES(@member_id,@payment_amount,@payment_date,@payment_type);
	select * from PAYMENTS;
end

exec insert_payment_data  @member_id=6,@payment_amount= 12000,@payment_date ='2019/2/2',@payment_type= 'ONLINE';
go


--15. Create a trigger to automatically update the total payment amount for a member when a new payment is added.
--alter table MEMBERS add total_amount int default 0 with values;
go
create trigger update_total_payment
ON PAYMENTS
after insert,update
as
begin
    DECLARE @member_id INT;
    DECLARE @payment_amounts DECIMAL(18, 2);

    select @member_id = member_id, @payment_amounts = payment_amount
    from inserted;

    update MEMBERS
    set total_payment = total_payment + @payment_amounts
    where member_id = @member_id;
END;

INSERT INTO PAYMENTS VALUES(2,1500,'2017/9/23','CASH');
update PAYMENTS set payment_amount = 100 where payment_id = 8;

select * from MEMBERS;
select * from PAYMENTS;

go



--16. Create a Function to Check if a Member Has Registered for an Event
create FUNCTION Member_has_Registered_or_not (@member_id int)
	returns varchar(50)
	as 
	begin
			DECLARE @Registered varchar(50)
		if exists (
				select 1 from EventRegistrations where member_id = @member_id
			)
			begin 
				set @Registered   = cast(@member_id as varchar(20)) + ' is Registered'
			end
		else
			begin
				set @Registered   =  cast(@member_id as varchar(20)) + 'is Not Registered'
			end
			return @Registered
	end

select dbo.Member_has_Registered_or_not(4) as Member_has_Registered_or_not;




--17.Create a Stored Procedure to Update Member's Status
go
create procedure Update_Member_Status(@member_id int , @Status bit)
as 
begin
	update MEMBERS set status=@Status where member_id = @member_id;
end;

exec Update_Member_Status @member_id = 5  ,@Status = 1
select * from MEMBERS;




--18.Create a Trigger to Log Member Deletions
create table Member_logtable (log_id int identity(1,1) primary key,Deleted_data text );
go 
create TRIGGER deleted_data_log 
on MEMBERS 
for delete
as
	begin
		 DECLARE @member_id int ;
		 select @member_id = member_id from deleted
		 insert into Member_logtable (Deleted_data) 
		 values('Id = ' +CAST(@member_id as varchar(10)) +' is deleted at ' + cast(getdate() as varchar(25)) );
	end;

delete from MEMBERS where member_id = 7;

select * from MEMBERS;
select * from Member_logtable;


--19.Combine Active and Inactive Members using union
select m.member_name, CASE 
           WHEN m.status = 1 THEN 'Active' 
           WHEN m.status = 0 THEN 'Inactive' 
       END AS member_status from MEMBERS m where status = 1  
	   union 
select  m.member_name, CASE 
           WHEN m.status = 1 THEN 'Active' 
           WHEN m.status = 0 THEN 'Inactive'    
       END AS member_status from MEMBERS m where status = 0




--20.Delete All Payments Older Than One Year
select * from PAYMENTS
--update PAYMENTS set payment_date = '2024/10/9' where payment_id = 1;

select * from PAYMENTS
WHERE payment_date < DATEADD(year, -1, SYSDATETIME());

--delete from PAYMENTS
--WHERE payment_date < DATEADD(year, -1, SYSDATETIME());