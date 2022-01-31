
 select CONCAT(Fname , ' ' , Lname) as FullName ,
        Salary,
		CASE WHEN Salary <= 1100 THEN 'UNDERPAID'
		     WHEN Salary >= 1200 THEN 'OVERPAID'
			 WHEN Salary BETWEEN 1100 AND 1200 THEN 'OK'
		else 'NO SALARY'
		end as 'Status'

 From Employee


 select *  
 from Employee
 order by NEWID() DESC



 select Distinct Dno ,SEX from Employee
 where Dno is NOT NULL
 order by SEX DESC



 select Fname,Lname,Sex,Address from Employee
 order by SUBSTRING(Lname,len(lname) - 1 , 2 ) DESC

 GO

WITH CTE AS (
select Fname , Salary, Dno,
       CASE 
	       WHEN DNO IS NULL THEN 0 ELSE 1 end as DepartmentNumber
from Employee)
SELECT Fname,Salary,ISNULL(Dno,0) as Department from CTE 
order by DepartmentNumber DESC





select * from Employee
order by case when Salary <= 825 THEN Lname else Fname END


select Fname , SSN from Employee
union all 
select Dname,Dnum from Departments


select Dnum from Departments
EXCEPT 
SELECT DNO FROM Employee

select dnum from Departments 
where dnum not in (SELECT Dno from Employee)

select dnum from Departments 
where NOT EXISTS (SELECT Dno from Employee where Dno = Dnum)


select Fname,
       SSN,
	   Salary,
	   Dno,
	   Salary * CASE 
	        WHEN Dno = 10 THEN Salary * 0.1 
	        WHEN Dno = 20 THEN Salary * 0.2
			Else 0.3
			END AS Bouns
from Employee


select sum(salary) as TotalSalary ,Salary,Dno, sum (Hours) as NumberHours
from Employee
inner join Works_for
on Works_for.ESSn = Employee.SSN
where Dno = 20
group by Salary,Dno

select sum(salary) as TotalSalary from Employee
where Dno = 20


select Dno,SUM(distinct Salary) as TotalSalary,sum(Bouns) as TotalBouns from (
select Fname,Sex,Address,salary,Dno,Hours, 
       case 
	   when Hours <= 25 THEN Salary*0.1
	   when Hours <= 40 THEN Salary*0.5
	   else Salary 
	   end as Bouns
from Employee
inner join Works_for
on Works_for.ESSn = Employee.SSN
where Dno = 20) as X
group by Dno


----------------=======================---------------------------------

Select distinct DNO,total_sal,total_bonus
 from (
 select e.SSN,
 e.Fname,
 sum(distinct e.salary) over (partition by e.dno) as total_sal,
 e.dno,
 sum(e.salary * case 
	   when Hours <= 25 THEN Salary*0.1
	   when Hours <= 40 THEN Salary*0.5
	   else Salary 
	   end) over (partition by dno) as total_bonus
 from Employee e, Works_for eb
 where e.SSN = eb.ESSn
 and e.Dno = 20
 ) x



select * from Works_for

select min(Dnum),Dname
from Departments
group by Dname


select table_name from INFORMATION_SCHEMA.TABLES
where TABLE_SCHEMA = 'dbo'


select column_name,data_type,ORDINAL_POSITION from INFORMATION_SCHEMA.columns
where TABLE_SCHEMA = 'dbo'
and TABLE_NAME = 'Employee'


select a.name table_name,
 b.name index_name,
 d.name column_name,
 c.index_column_id
 from sys.tables a,
 sys.indexes b,
 sys.index_columns c,
 sys.columns d
 where a.object_id = b.object_id
 and b.object_id = c.object_id
 and b.index_id = c.index_id
 and c.object_id = d.object_id
 and c.column_id = d.column_id
 and a.name = 'Employee'


 select a.table_name,
 a.constraint_name,
 b.column_name,
 a.constraint_type
 from information_schema.table_constraints a,
 information_schema.key_column_usage b
 where a.table_name = 'employee'
 and a.table_schema = 'dbo'
 and a.table_name = b.table_name
 and a.table_schema = b.table_schema
 and a.constraint_name = b.constraint_name




 ----------------------------------------------------------------


 
select SUBSTRING(Fname,len(Fname)-1,2) from Employee

select 'Fadw''a'''
select 'G''Day mate'
select ''''
---Single Quate as Parthence
select 'fad''w''a'
select 'fad(w)a'
select 'fadw''a'
select 'fadw)a'

select '''' as quote 

select '('')' as quote 

-----------------------------------------------------------

create table T10 
(ID INT)

insert into T10 (ID) Values(1),(2),(3),(4),(5),(6),(7),(8)

select 'KING' as King

select SUBSTRING('KING',e.ID,1) as C 
from (select id from T10) as e
where e.ID <= len('KING')

----------------------------------------------
select len(',')

--Number of occurnce of comma
select (len('10,CLARK,MANAGER')-
        len(REPLACE('10,CLARK,MANAGER',',','')))/len(',') as cnt

---------------------------------------------------------------
select salary,Fname from Employee

select REPLACE(salary,'0','') as Sal,
       REPLACE(TRANSLATE(Fname,'aaaaa','AIOEU'),'a','') as Name
from Employee


-----------------------------------------------------------
GO
alter view v as 
select Fname as Data
from Employee where Dno = 20  
union all
select Fname + ',$' + CAST(salary as char(10)) as Data
from Employee where Dno = 30
union all
select Fname + CAST(salary as char(10)) as Data
from Employee where Dno = 30

select Data from V
-------------------------------------------------------------------------------------------
select Dname,count(*) over () as Number from Employee
inner join Departments
on Dno = Dnum

----------------------------------------------------------------------------------
select Dname,count(*) as Number from Employee
inner join Departments
on Dno = Dnum
group by Dname
--------------------------------------------------------------------------------

select Fname,Dnum,count(*) over(Partition By Dnum) as Number from Employee
inner join Departments
on Dno = Dnum

select Fname,Dnum,count(*) over() as Number from Employee
inner join Departments
on Dno = Dnum



select * from Employee

select name,
       city,
	   salary,
	   min(salary) over (order by salary) as Min1,
	   max(salary) over (order by salary) as Max1,
	   min(salary) over 
	                   (order by salary 
					   RANGE BETWEEN UNBOUNDED PRECEDING AND 
					                 UNBOUNDED FOLLOWING) AS Min2 ,
       max(salary) over 
	                   (order by salary 
					   RANGE BETWEEN UNBOUNDED PRECEDING AND 
					                 UNBOUNDED FOLLOWING) AS Max2

from Employee





------------------------------------------------
select * from Employee


select name, salary,
       sum(salary) over (order by salary,id) as running_total
from Employee
--group by name,salary


------------------------------------------------------------------------------

select * from Employee

select avg(salary)
 from Employee
 where salary not in (
 (select min(salary) from Employee),
 (select max(salary) from Employee)
 )

 select avg(salary)
 from Employee


 select salary, min(salary)over() min_sal, max(salary)over() max_sal
 from Employee

 select avg(salary)
 from (
 select salary, min(salary) min_sal-- over() min_sal,
              , max(salary) max_sal-- over() max_sal
 from Employee group by salary
 ) x
 where salary not in (min_sal,max_sal)

 --How can i extract Numbers from Text 'Fadwa123456Mousa'

 select REPLACE(TRANSLATE('Fadwa123456Mousa','abcdefghijklmnopqrstuvwxyz',REPEAT('#',26,'#')),'#','') as Number

 Select ABS(DATEDIFF(DAY,FadwaBirthDate,NohaBirthDate)) from (
 select Bdate as FadwaBirthDate from Employee where Fname = 'Fadwa') as X,
 (
 select Bdate as NohaBirthDate from Employee where Fname = 'Noha'
 ) as Y

 select Max(case when Fname = 'Fadwa' Then Bdate end) as FBirthdate ,
        Max(case when Fname = 'Noha'  Then Bdate end) as NBirthdate
 from Employee
 where Fname in ('Fadwa','Noha')

 select DATEDIFF(HOUR,ward_hd,allen_hd) as DateHours,
        DATEDIFF(MINUTE,ward_hd,allen_hd) as Min1,
		DATEDIFF(SECOND,ward_hd,allen_hd) as Sec
 from (
 select max(case when fname = 'Fadwa'
 then Bdate
 end) as ward_hd,
 max(case when Fname = 'Noha'
 then Bdate
 end) as allen_hd
 from Employee ) as x

 ----------------------------------------------------------------------------
 
 select x.* , DATEDIFF(DAY,NextBirthDate,Bdate) from (
 select SSN,Fname,Bdate,lead(Bdate,2)over(order by Bdate) as NextBirthDate from Employee
 ) as X

 SELECT SSN,Fname,Bdate,row_number() over() as NextBirthDate 
 FROM Employee

 select coalesce(day(cast(concat(year(getdate()),'-02-29') as date)),28)

 select DATEPART(day,getdate())+1

 select Dateadd(day,-datepart(day,getdate())+1,getdate())


 select DATENAME(WEEKDAY,getdate())

 -------------------------------------------------------
 select Fname,salary
 from (
 select Fname, salary,
 dense_rank() over (order by salary desc) dr
 from Employee
 ) x
 where dr <= 5

 select top(5) Fname,salary from Employee order by salary desc
 --------------------------------------------------------------------------
 ----------------------------------------------------------------------------------

 select Fname,Salary
 from (
 select Fname, salary,
 min(salary)over() min_sal,
 max(salary)over() max_sal
 from Employee
 ) x
 where salary in (min_sal,max_sal)
 -------------------------------------------------------------------
 -------------------------------------------------------------------
 select Fname,Maxx_Salary,Min_Salary from (
 select Fname,Min(salary) over ()  as Min_Salary,Max(Salary) over() as Maxx_Salary
 from Employee)as x 

 select Dno,count(*) as CNT_Employees from employee
 group by Dno

 select sum(case when dno = 10 Then 1 else 0 end) as D_1,
        sum(case when dno = 20 then 1 else 0 end) as D_2,
		sum(case when dno = 30 then 1 else 0 end) as D_3
		from Employee

select  MAX(case when dno = 10 Then X else NULL end) as D_1,
        MAX(case when dno = 20 then X else NULL end) as D_2,
		MAX(case when dno = 30 then X else NULL end) as D_3
from (
select dno, count(*) as X from Employee group by Dno) Y

------------------------------------------------------------------------

select case when lag(Dno) over (order by Dno) = Dno THEN NULL ELSE Dno end as Department,
		   Fname 
FROM Employee

------------------------------------------------------------------------------
GO
WITH CTE AS (
select sum(case when Dno = 30 then Salary end) as D_30 ,
       sum(case when Dno = 20 then Salary end) as D_20,
	   sum(case when Dno = NULL then Salary end) as D_10
from Employee)
select D_20-D_30 as Diff2030 , D_20-D_10 from CTE


-------------------------------------------------------------------
----------------------------------------------------------------------------
--------------------------------------------------------------------------------------

select x.Fname + ' Works For ' + y.Fname as Manager FROM Employee x join Employee y 
on x.Superssn = y.SSN
-------------------------------------------------------------------------------------

with x (tree,mgr,depth)
as (
select cast(Fname as varchar(100)),
Superssn, 0
from Employee
where Fname = 'Noha'
union all
select cast(x.tree+'-->'+e.fname as varchar(100)),
e.Superssn, x.depth+1
from Employee e,x
where x.mgr = e.SSN
)
select depth, tree
from x
-----------------------------------------------------------------------------
GO
with x (ename,empno)
 as (
 select cast(Fname as varchar(100)),ssn
 from Employee
 where Superssn is null
 union all
 select cast(x.ename + ' - '+ e.Fname as varchar(100)),
 e.SSN
 from Employee e, x
 where e.Superssn = x.empno
 )
 select ename as emp_tree
 from x
 order by 1



 GO
 with x (ename,empno)
 as (
 select Fname,SSN
 from Employee
 where Fname = 'Edward'
 union all
 select e.Fname, e.SSN
 from Employee e, x
 where x.empno = e.Superssn
 )
 select ename
 from x


 --------------------------------------------------------------------------------


















