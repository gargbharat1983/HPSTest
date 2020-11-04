--====================================================Problem1==========================================================================
CREATE TABLE Student
(
   [Student Id] int NOT NULL PRIMARY KEY,
   [Student Name] varchar(100),
    [Student Class] varchar(10),
    Interests varchar(100),
	Subjects varchar(100)
)
go
CREATE NONCLUSTERED INDEX IX_Student_Name
ON Student([Student Name] ASC)
go
---Adding time series colmun data
ALTER table student add CreatedTime datetime not null
go
ALTER table student add UpdatedTime datetime
go
--For Auditing I am using CDC (change data capture) over other techniques like trigger as CDC apply changes in logs rather than actual data so performance wise they are better
--But CDC is aviliable in standard edition of SQLs server
--this will enable CDC(change data capture) in database.
EXEC sys.sp_cdc_enable_db
go
--Enable CDC(change data capture) on Student Table
EXEC sys.sp_cdc_enable_table
@source_schema = 'dbo',
@source_name = 'Student',
@role_name = NULL,
@supports_net_changes = 1
go
---get the auditing data of student table
SELECT * FROM [cdc].[dbo.Student_CT]
go
--=======================================Problem1 End====================================================================================
--============================Problem2 start============================================================================================
Create table STOCK
(
ContractCode varchar(2),
Ticker varchar(4),
LastTrade date
)
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('ES','ESU0','9/15/2020')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('ES','ESZ0','12/15/2020')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('ES','ESH1','3/15/2021')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('ES','ESM1','6/15/2021')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('ES','ESU1','9/15/2021')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('NK','NK1','9/15/2021')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('NK','NK2','10/15/2020')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('NK','NK3','11/15/2020')
go
Insert into STOCK(ContractCode,Ticker,LastTrade)
values
('NK','NK5','1/15/2021')
go
CREATE procedure usp_GetExpiringContract(
@Date date,
@Depth int
)
as
BEGIN
;with CTE_Results 
as
(
Select ROW_NUMBER() OVER (ORDER BY LastTrade) as srno,Ticker From stock Where LastTrade>convert(date,@Date)
)
select Ticker from CTE_Results where srno=@Depth
END
go
usp_GetExpiringContract '2021-02-28',2
--====================================================Problem2End=====================================================================