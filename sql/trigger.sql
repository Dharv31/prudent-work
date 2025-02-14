use demo

-- table demo_table
create table demo_table (id int primary key,Dname varchar(100),Dsalaray numeric(18,2));

select * from demo_table;
drop table demo_table
insert into demo_table values(2,'dev',100000)
delete from demo_table where id = 2 ; 
update demo_table
set Dsalaray = 500000 
where id = 1;

-- create table demo_backup

create table demo_backup (id int  , Dname varchar(100),Dsalary numeric(18,2),Date_deleted date);
drop table demo_backup
select * from demo_backup;

--trigger for backup on delete

create trigger demo_backup_trigger 
on demo_table 
for delete
as begin 
declare @id int
select @id =id from deleted
declare  @Dname varchar(100)
declare @Dsalary numeric(18,2)
select @Dname =Dname from deleted
select @Dsalary =Dsalaray from deleted
insert into demo_backup values(@id,@Dname,@Dsalary,getdate());
select * from demo_backup;
end

drop trigger demo_backup_trigger;

-- create table demo_added

create table demo_added(id int identity primary key , text_area text);
drop table demo_added;
select * from demo_added;

--trigger for added in  demo_added

create trigger demo_added_trigger
on demo_table
for insert 
as begin 
      declare @id int
	  select @id  = id from inserted
	  insert into demo_added
	  values('new data id ='+cast(@id as varchar(10))+'is added at '+cast(getdate() as varchar(25)));
	  select * from demo_added;
	  end
drop trigger demo_added_trigger

-- create demo_update_salary table

 create table demo_update_salary (id int  , oldsalary numeric(18,2), newsalary numeric(18,2),Udate datetime default getdate());
 drop table demo_update_salary

 
 -- trigger for update in demo salary


 create trigger demo_upddate_salary_trigger on demo_table


 for update
 as begin
 declare @id int
 declare @oldsalary numeric(18,2)
 declare @newsalary numeric(18,2)

 select @id = id from inserted
 select @oldsalary = Dsalaray from deleted
 select @newsalary  = Dsalaray from inserted

 insert into demo_update_salary (id,oldsalary,newsalary) values (@id,@oldsalary,@newsalary) ;
 
 select * from demo_update_salary;
 end

 drop trigger demo_upddate_salary_trigger





 Begin transaction t1
 begin try 
 insert into demo_table values(7,'Jay der',100000);
 select * from demo_table;
 commit Transaction t1;
 end try
 begin catch
 rollback transaction t1;

 end catch 