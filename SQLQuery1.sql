----INSERT INTO EmployeeDemographics VALUES
----(1001, 'UZER', 'KHATRI',21,'MALE'),
----(1002, 'GULAMNABI', 'KHATRI', 44, 'FEMALE'),
----(1003, 'HUMAN', 'SAPIENS', 44, 'MALE'),
----(1004, 'ASWASD', 'ASDWASD', 44, 'FEMALE'),
----(1005, 'JAY', 'PATEL', 44, 'MALE'),
----(1006, 'UBAID', 'DARSOT', 44, 'MALE')

--INSERT INTO EmployeeSalary Values
--(1001, 'SALESMAN', 45000),
--(1002, 'MANAGER', 40000),
--(1003, 'POST', 65000),
--(1004, 'ANALYST', 30000),
--(1005, 'ASDW', 44000),
--(1006, 'SHOPKEEPER', 23000)

--SELECT * 
--FROM EmployeeDemographics
--WHERE EmployeeName IN ('Uzer','Gulamnabi')

--SELECT Gender , Age ,COUNT(Gender) 
--FROM EmployeeDemographics
--GROUP BY Gender , Age
--ORDER BY Gender

--CREATE TABLE WAREHOUSEDEMO(
--EmployeeId int,
--EmployeeName varchar(50),
--LastName varchar(50),
--Age int,
--Gender varchar(50))

--INSERT INTO WAREHOUSEDEMO VALUES
--(1015, 'Mahammad', 'Shaikh', 35, 'Male'),
--(1016, 'Saidur', 'Rahman', 29, 'Male'),
--(1017, 'GulamNabi', 'Multani', 59, 'Male'),
--(1018, 'Ashiya' , 'Shaikh', 28, 'Female')

--SELECT * 
--FROM SQL_Tutorial.dbo.EmployeeDemographics

--UNION

--SELECT * 
--FROM SQL_Tutorial.dbo.WAREHOUSEDEMO

--SELECT EmployeeName, LastName, Age,
--CASE 
--	WHEN Age > 30 THEN 'Old'
--	WHEN Age BETWEEN 27 AND 30 THEN 'YOUNG'
--	ELSE 'BABY'
--END
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--WHERE Age is NOT NULL
--ORDER BY Age

--SELECT EmployeeName, LastName, JobType, Salary,
--CASE 
--	WHEN JobType = 'Salesman' THEN Salary + (Salary * 0.10)
--	WHEN JobType = 'Manager' THEN Salary + (Salary * 0.05)
--	WHEN JobType = 'Post'THEN Salary+ (Salary*0.025 )
--	ELSE Salary+ (Salary*0.03)
--END AS SALARYAFTER 
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--JOIN SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId

--SELECT JobType, AVG(Salary)
--FROM SQL_Tutorial.dbo.EmployeeDemographics
--join SQL_Tutorial.dbo.EmployeeSalary
--	ON EmployeeDemographics.EmployeeId = EmployeeSalary.EmployeeId
--GROUP BY JobType
--HAVING AVG(Salary) > 40000
--ORDER BY AVG(Salary)

--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeDemographics

--UPDATE SQL_Tutorial.dbo.EmployeeDemographics
--SET Age = 31 , Gender = 'Female'
--Where EmployeeId = 1003

--DELETE FROM SQL_Tutorial.dbo.EmployeeDemographics
--WHERE EmployeeId = 1003

--SELECT EmployeeName + ' ' + LastName AS FullName
--FROM SQL_Tutorial.dbo.EmployeeDemographics

--SELECT Demo.EmployeeId, Sal.Salary
--FROM SQL_Tutorial.dbo.EmployeeDemographics AS Demo
--JOIN SQL_Tutorial.dbo.EmployeeSalary AS Sal
--	ON Demo.EmployeeID = Sal.EmployeeId

--SELECT EmployeeName, LastName, Salary, Gender
--, COUNT(Gender) OVER (Partition By Gender) as TotalGender
--FROM SQL_Tutorial.dbo.EmployeeDemographics dmo
--join SQL_Tutorial.dbo.EmployeeSalary sal
--	ON dmo.EmployeeId = sal.EmployeeId

--WITH CTE_Employee AS(SELECT EmployeeName, LastName, Salary, Gender
--, COUNT(Gender) OVER (Partition By Gender) as TotalGender
--, AVG(Salary) OVER(Partition by Gender) as AvgSalary
--FROM SQL_Tutorial.dbo.EmployeeDemographics dmo
--join SQL_Tutorial.dbo.EmployeeSalary sal
--	ON dmo.EmployeeId = sal.EmployeeId
--WHERE Salary > '40000'
--)
--SELECT *
--From CTE_Employee

--CREATE TABLE #temp_Employee(
--EmployeeId int,
--JobTitle varchar(50),
--Salary int)

--SELECT * 
--FROM #temp_Employee

--INSERT INTO #temp_Employee VALUES(
--1001 , 'HR', 50000)

--INSERT INTO #temp_Employee 
--SELECT *
--FROM SQL_Tutorial.dbo.EmployeeSalary


--DROP TABLE IF EXISTS #temp_Employee2
--CREATE TABLE #temp_Employee2(
--JobTitle varchar(50),
--EmployeesPerJob  int,
--AvgAge int,
--AvgSalary int)

--INSERT INTO #temp_Employee2
--SELECT JobType, Count(JobType), Avg(age), AVG(Salary)
--FROM SQL_Tutorial..EmployeeDemographics emp
--JOIN SQL_Tutorial..EmployeeSalary sal
--	ON emp.EmployeeId = sal.EmployeeId
--group by JobType

--Select*
--From #temp_Employee2

CREATE TABLE EmployeeErrors (
EmployeeID varchar(50)
,FirstName varchar(50)
,LastName varchar(50)
)

Insert into EmployeeErrors Values 
('1001  ', 'Jimbo', 'Halbert')
,('  1002', 'Pamela', 'Beasely')
,('1005', 'TOby', 'Flenderson - Fired')

--Select* 
--From EmployeeErrors

--Select EmployeeID, TRIM(EmployeeID) as IDTRIM
--From EmployeeErrors


--Select LastName, REPLACE(LastName, '-Fired' ,'') as LASTNAMEFIXED
--From EmployeeErrors

--Select FirstName, UPPER(FirstName)
--From EmployeeErrors

CREATE PROCEDURE temp_Employee
AS
BEGIN
IF OBJECT_ID('tempdb..#temp_employee') IS NOT NULL
DROP TABLE IF EXISTS #temp_employee
Create table #temp_employee (
JobTitle varchar(100),
EmployeesPerJob int ,
AvgAge int,
AvgSalary int
)


Insert into #temp_employee(JobTitle, EmployeesPerJob,AvgAge,AvgSalary) 
SELECT JobType, Count(JobType), Avg(Age), AVG(Salary)
FROM SQL_Tutorial..EmployeeDemographics emp
JOIN SQL_Tutorial..EmployeeSalary sal
	ON emp.EmployeeId = sal.EmployeeID
group by JobType
END;
EXEC temp_Employee;