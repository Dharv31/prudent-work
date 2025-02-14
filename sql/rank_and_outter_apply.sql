use demo


--Rank 

CREATE TABLE rank_trial (Name VARCHAR(10) );
drop table rank_trial;
INSERT INTO rank_trial (Name)
VALUES ('A'), ('B'), ('B'), ('C'), ('C'), ('D'), ('E');
SELECT * FROM rank_trial; 

SELECT Name,  Rank() OVER (ORDER BY Name) AS Rank_no 
FROM rank_trial;

--dense rank
SELECT Name,  Dense_Rank() OVER (ORDER BY Name) AS Rank_no 
FROM rank_trial;


--rowno 

SELECT ROW_NUMBER() OVER ( ORDER BY Name) row_num,Name
FROM rank_trial;

--outer apply

create table MASTER(
ID int primary key,
name varchar(100)
);
insert into MASTER values(3,'C'); 


create table DETAIL(
ID int ,
 PERIOD date ,
 QTY int )
 drop table DETAIL
 insert into DETAIL values(2,'2001-01-10',35)

 select * from MASTER;
 select * from DETAIL;

 SELECT T1.ID,T1.NAME,TAB.PERIOD,TAB.QTY 
FROM MASTER T1
OUTER APPLY
(
   SELECT top 1 ID,PERIOD,QTY 
   FROM DETAIL T2
   WHERE T1.ID=T2.ID
)TAB

 SELECT T1.ID,T1.NAME,TAB.PERIOD,TAB.QTY 
FROM MASTER T1
OUTER APPLY
(
   SELECT top 1 ID,PERIOD,QTY 
   FROM DETAIL T2
   WHERE T1.ID=T2.ID order by T1.ID desc
)TAB

--scalar function
create table Products
(productID int primary key,
ProductName varchar(50),
price decimal ,
Quantity int)

insert into Products(productID,
ProductName,price,Quantity)
Values(1,'Chai',40,20),
(2,'Biscut',5.50,200),
(3,'Rust',10,150),
(4,'sugar',24.50,20),
(5,'Coffee',78.20,10);


CREATE FUNCTION CalculateTotal
(@Price decimal(10,2),@Quantity int)
RETURNS decimal(10,2)
AS
BEGIN
   RETURN @Price * @Quantity
END


select * from Products

SELECT ProductName,Quantity,price, 
dbo.CalculateTotal(Price, Quantity) 
AS Total
FROM Products