/*
	Problem 1: List all workers in department 7 using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        Employee_1.BusinessEntityID
			 ,Employee_1.LoginID
			 ,edh.DepartmentID 
			  
			  
FROM            HumanResources.Employee AS Employee_1
				INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh 
				ON Employee_1.BusinessEntityID = edh.BusinessEntityID 

WHERE edh.DepartmentID = 7					 

ORDER BY  Employee_1.BusinessEntityID;

/*
	Problem 2: Find all Sales representatives that made no sales last year using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        Salesp.BusinessEntityID
			 ,Salesp.SalesLastYear
			 ,Salesp.SalesYTD
			 ,Employee_1.LoginID
			 ,Employee_1.JobTitle
FROM            Sales.SalesPerson AS Salesp INNER JOIN
                         HumanResources.Employee AS Employee_1 ON Salesp.BusinessEntityID = Employee_1.BusinessEntityID
WHERE (Salesp.SalesLastYear = 0 AND Employee_1.OrganizationLevel = 3);

/*
	Problem 3: Find all employees that work in sales using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        Employee_1.BusinessEntityID, Employee_1.LoginID, Employee_1.JobTitle
FROM            Sales.SalesPerson INNER JOIN
                         HumanResources.Employee AS Employee_1 ON Sales.SalesPerson.BusinessEntityID = Employee_1.BusinessEntityID
ORDER BY Employee_1.BusinessEntityID;

/*
	Problem 4: Show all the employees and how frequently they are paid using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT DISTINCT       Employee_1.BusinessEntityID
					, Payh.PayFrequency
					, Employee_1.LoginID
FROM            HumanResources.Employee AS Employee_1 
				INNER JOIN HumanResources.EmployeePayHistory AS Payh ON Employee_1.BusinessEntityID = Payh.BusinessEntityID;

/*
	Problem 5: Show all sales from Pennsylvania with more than 50 item quantity ordered using WideWorldImportersDW.
	
*/
USE WideWorldImportersDW;
GO
SELECT       Fact.[Order].[Order Key]
			, Dimension.City.[City Key]
			, Dimension.City.City
			, Dimension.City.[State Province]
			, Fact.[Order].Description
			, Fact.[Order].Quantity
FROM            Dimension.City INNER JOIN
                         Fact.[Order] ON Dimension.City.[City Key] = Fact.[Order].[City Key]
WHERE		Dimension.City.[State Province] = 'Pennsylvania'
			AND Fact.[Order].Quantity > 50
ORDER BY Fact.[Order].Quantity ASC;


/*
	Problem 06: Find by CustomerID, the number of distinct items and total quantities of all items ever ordered by customer using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        Sales.Customer.CustomerID, 
			  COUNT(*) as DistinctItems, SUM (Sales.SalesOrderDetail.OrderQty) as TotalItems
FROM            Sales.Customer 
				INNER JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID 
				INNER JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
GROUP BY Sales.Customer.CustomerID;


/*
	Problem 07: Find by CustomerID, the number of all orders ever made by customer using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT  Sales.Customer.CustomerID, 
		COUNT(DISTINCT Sales.SalesOrderDetail.SalesOrderID) as OrderQuantity
FROM            Sales.Customer INNER JOIN
                         Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID INNER JOIN
                         Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
GROUP BY Sales.Customer.CustomerID
ORDER BY Sales.Customer.CustomerID;

/*
	Problem 08: Find by CustomerID, all online orders and store orders a customer has ever made using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        Sales.Customer.CustomerID, 
			  COUNT(CASE WHEN Sales.SalesOrderHeader.OnlineOrderFlag = 1 THEN 1 END) as OnlineOrders,
			  COUNT(CASE WHEN Sales.SalesOrderHeader.OnlineOrderFlag = 0 THEN 1 END) as StoreOrders
			  
FROM            Sales.Customer 
				INNER JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID 
				
GROUP BY Sales.Customer.CustomerID
ORDER BY Sales.Customer.CustomerID;

/*
	Problem 09: Find all customers who have ever recieved a discount on an ordered item using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT  Sales.Customer.CustomerID 
		,COUNT(Sales.SalesOrderDetail.SalesOrderID) as OrderQuantity
		,COUNT(CASE WHEN Sales.SalesOrderDetail.UnitPriceDiscount > 0.00 THEN 1 END) as DiscountedItems
FROM            Sales.Customer INNER JOIN
                         Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID INNER JOIN
                         Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID
GROUP BY Sales.Customer.CustomerID
HAVING COUNT(CASE WHEN Sales.SalesOrderDetail.UnitPriceDiscount > 0.00 THEN 1 END) > 0
ORDER BY Sales.Customer.CustomerID;

/*
	Problem 10: Find all customers who have made order before 2012 using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        Sales.Customer.CustomerID,
			  YEAR(Sales.SalesOrderHeader.OrderDate) as OrderYear
			  
FROM            Sales.Customer 
				INNER JOIN Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID 
WHERE YEAR(Sales.SalesOrderHeader.OrderDate) < 2012				
GROUP BY Sales.Customer.CustomerID, YEAR(Sales.SalesOrderHeader.OrderDate)
ORDER BY Sales.Customer.CustomerID;

/*
	Problem 11: Find total number workers in day, evening, and night shifts using AdventureWorks2014.
	
*/
SELECT        HumanResources.Shift.ShiftID 
			  ,COUNT(CASE WHEN HumanResources.Shift.ShiftID = 1 THEN 1 END) AS DayEmployees
			  ,COUNT(CASE WHEN HumanResources.Shift.ShiftID = 2 THEN 1 END) AS EveningEmployees
			  ,COUNT(CASE WHEN HumanResources.Shift.ShiftID = 3 THEN 1 END) AS NightEmployees

FROM            HumanResources.Employee AS Employee_1 INNER JOIN
                         HumanResources.EmployeeDepartmentHistory ON Employee_1.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID 
						 INNER JOIN HumanResources.Shift ON HumanResources.EmployeeDepartmentHistory.ShiftID = HumanResources.Shift.ShiftID
GROUP BY  HumanResources.Shift.ShiftID;


/*
	Problem 12: List all customers that have ordered lightweight bicycles using AdventureWorksDW2014.
	
*/
USE AdventureWorksDW2014;
GO
SELECT        cust.CustomerKey, COUNT(DimProduct.ProductKey) AS LowWeightAmount
FROM            DimProduct INNER JOIN
                         FactInternetSales ON DimProduct.ProductKey = FactInternetSales.ProductKey
						 INNER JOIN DimCustomer AS cust On cust.CustomerKey = FactInternetSales.CustomerKey
WHERE DimProduct.Weight < 20
GROUP BY cust.CustomerKey
ORDER BY LowWeightAmount DESC;

/*
	Problem 13: Find number of distinct currency rate ids per customer using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT Sales.Customer.CustomerID
	   ,COUNT(DISTINCT Sales.SalesOrderHeader.CurrencyRateID) AS RateNums

FROM            Sales.Customer INNER JOIN
                         Sales.SalesOrderHeader ON Sales.Customer.CustomerID = Sales.SalesOrderHeader.CustomerID 
                        
GROUP BY Sales.Customer.CustomerID
HAVING COUNT(DISTINCT Sales.SalesOrderHeader.CurrencyRateID) > 0
ORDER BY RateNums DESC;

/*
	Problem 14: Show all the distinct departments employees belong to within an organization level in AdventureWorks2014
	
*/
USE AdventureWorks2014;
GO
SELECT Emp.OrganizationLevel
		,COUNT(DISTINCT Hist.DepartmentID) AS DistinctDepartments
FROM	HumanResources.Employee AS Emp
		INNER JOIN HumanResources.EmployeeDepartmentHistory AS Hist ON Emp.BusinessEntityID = Hist.BusinessEntityID
GROUP BY Emp.OrganizationLevel;

/*
	Problem 15: Show top 50 customers by Total Spent ever using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO

SELECT TOP(50)	Cust.CustomerID
			,SUM(DISTINCT Sod.LineTotal) AS TotalSpent
			,AVG(DISTINCT Sod.LineTotal) AS AvgSpentPerOrders
			
FROM		Sales.Customer AS Cust 
			INNER JOIN Sales.SalesOrderHeader AS Soh ON Cust.CustomerID = Soh.CustomerID
			INNER JOIN Sales.SalesOrderDetail AS Sod ON Sod.SalesOrderID = Soh.SalesOrderID

GROUP BY	Cust.CustomerID
ORDER BY	TotalSpent DESC;

/*
	Problem 16: Show list of Top 100 Best Selling Products in 2013 using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT   TOP(100)      Sod.ProductID, COUNT(Sod.OrderQty) AS QuantitySold, YEAR(Soh.Orderdate) AS Year 
				
FROM            Sales.Customer As Cust 
                INNER JOIN Sales.SalesOrderHeader AS Soh ON Cust.CustomerID = Soh.CustomerID 
		        INNER JOIN Sales.SalesOrderDetail AS Sod ON Soh.SalesOrderID = Sod.SalesOrderID
WHERE YEAR(Soh.Orderdate) = 2013
GROUP BY Sod.ProductID, YEAR(Soh.Orderdate)
ORDER BY QuantitySold DESC;

/*
	Problem 17: Show list of Employees who have worked the longest with the company using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT          Employee_1.BusinessEntityID
				, YEAR(Employee_1.BirthDate) AS BirthYear
				, YEAR(edh.StartDate) AS Start
				, StartAge = (YEAR(edh.StartDate) - YEAR(Employee_1.BirthDate))
				, WorkYear = (2014 - YEAR(edh.StartDate))
FROM            HumanResources.Employee AS Employee_1 INNER JOIN
                         HumanResources.EmployeeDepartmentHistory AS edh ON Employee_1.BusinessEntityID = edh.BusinessEntityID 
GROUP BY 	    Employee_1.BusinessEntityID, YEAR(Employee_1.BirthDate), YEAR(edh.StartDate)
ORDER BY		WorkYear DESC;

/*
	Problem 18: Show list of total sick leave hours per Department using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT        HR.DepartmentID, SUM(Employee_1.SickLeaveHours) AS TotalLeave
FROM            HumanResources.Employee AS Employee_1 INNER JOIN
                         HumanResources.EmployeeDepartmentHistory AS HR ON Employee_1.BusinessEntityID = HR.BusinessEntityID 
						 
GROUP BY HR.DepartmentID
ORDER BY TotalLeave;	

/*
	Problem 19: Show list of stores with most distinct products sold using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT			Cust.StoreID
				,COUNT(DISTINCT Sod.ProductID) AS ProductsInStore
FROM            Sales.Customer AS Cust INNER JOIN
                         Sales.SalesOrderHeader AS Soh ON Cust.CustomerID = Soh.CustomerID INNER JOIN
                         Sales.SalesOrderDetail AS Sod ON Soh.SalesOrderID = Sod.SalesOrderID
WHERE Cust.StoreID IS NOT NULL
GROUP BY Cust.StoreID
ORDER BY ProductsInStore DESC;

/*
	Problem 20: Show total amount of money made by a store using AdventureWorks2014.
	
*/
USE AdventureWorks2014;
GO
SELECT			Cust.StoreID
				,SUM(Sod.LineTotal) AS TotalMade
FROM            Sales.Customer AS Cust INNER JOIN
                         Sales.SalesOrderHeader AS Soh ON Cust.CustomerID = Soh.CustomerID INNER JOIN
                         Sales.SalesOrderDetail AS Sod ON Soh.SalesOrderID = Sod.SalesOrderID
WHERE Cust.StoreID IS NOT NULL

GROUP BY Cust.StoreID
ORDER BY TotalMade DESC;

/*
	Problem 21: Show whether a worker is management or not using AdventureWorks2014.
	
*/
IF OBJECT_ID (N'dbo.isManager', N'FN') IS NOT NULL  
    DROP FUNCTION isManager;  
GO  
CREATE FUNCTION dbo.isManager(@EID int)  
RETURNS bit   
AS   
BEGIN  
    DECLARE @ret AS bit;  
    
     IF (@EID > 3 )   
        SET @ret = 0;
	 ELSE SET @ret = 1;	  
    RETURN @ret;  
END; 

USE AdventureWorks2014;
GO
SELECT          dbo.isManager(Emp.OrganizationLevel) AS isManager, COUNT(HumanResources.EmployeeDepartmentHistory.BusinessEntityID) AS NumberOfEmployees

FROM            HumanResources.Employee AS Emp
                INNER JOIN HumanResources.EmployeeDepartmentHistory ON  Emp.BusinessEntityID = HumanResources.EmployeeDepartmentHistory.BusinessEntityID 
				INNER JOIN HumanResources.Shift ON HumanResources.EmployeeDepartmentHistory.ShiftID = HumanResources.Shift.ShiftID

GROUP BY		dbo.isManager(Emp.OrganizationLevel);

/*
	Problem 22: Show all customers that ordered a discontinued item using TSQLV4.
	
*/
IF OBJECT_ID (N'dbo.isDiscontinued', N'FN') IS NOT NULL  
    DROP FUNCTION isDiscontinued;  
GO  
CREATE FUNCTION dbo.isDiscontinued(@EID bit)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID > 0 )   
        SET @ret = 1;
	 ELSE SET @ret = 0;	  
    RETURN @ret;  
END; 

USE TSQLV4;
GO
SELECT          Cust.custid
			  , SUM(dbo.isDiscontinued(Pro.discontinued)) AS NumDiscontinued
			  , Cust.contactname
			  , Cust.phone
			  , Cust.fax

FROM            Sales.Customers AS Cust
                INNER JOIN Sales.Orders as So ON Cust.custid = So.custid
				INNER JOIN Sales.OrderDetails as Sod ON Sod.orderid = So.orderid
				INNER JOIN Production.Products AS Pro ON Pro.productid = Sod.productid

GROUP BY		Cust.custid, Cust.contactname, Cust.phone, Cust.fax
HAVING SUM(dbo.isDiscontinued(Pro.discontinued)) > 0
ORDER BY Cust.custid ASC;

/*
	Problem 23: Determine how many expensive orders a customer has made using AdventureWorks2014.
	
*/
IF OBJECT_ID (N'dbo.isExpensive', N'FN') IS NOT NULL  
    DROP FUNCTION isExpensive;  
GO  
CREATE FUNCTION dbo.isExpensive(@EID int)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID > 100 )   
        SET @ret = 1;
	 ELSE SET @ret = 0;	  
    RETURN @ret;  
END; 

USE AdventureWorks2014;
GO
SELECT          Cust.CustomerID, SUM(dbo.isExpensive(Sod.LineTotal)) AS TotalExpensiveOrders

FROM            Sales.Customer AS Cust
                INNER JOIN Sales.SalesOrderHeader as Soh ON Cust.CustomerID = Soh.CustomerID
				INNER JOIN Sales.SalesOrderDetail as Sod ON Sod.SalesOrderID = Soh.SalesOrderID

GROUP BY		Cust.CustomerID

/*
	Problem 24: Determine how many customer orders were picked up using AdventureWorks2014.
	
*/
IF OBJECT_ID (N'dbo.wasPicked', N'FN') IS NOT NULL  
    DROP FUNCTION wasPicked;  
GO  
CREATE FUNCTION dbo.wasPicked(@EID nvarchar)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID = NULL )   
        SET @ret = 0;
	 ELSE SET @ret = 1;	  
    RETURN @ret;  
END; 

USE AdventureWorks2014;
GO
SELECT          Cust.CustomerID, SUM(dbo.wasPicked(Sod.CarrierTrackingNumber)) AS TotalPickedUp

FROM            Sales.Customer AS Cust
                INNER JOIN Sales.SalesOrderHeader as Soh ON Cust.CustomerID = Soh.CustomerID
				INNER JOIN Sales.SalesOrderDetail as Sod ON Sod.SalesOrderID = Soh.SalesOrderID

GROUP BY		Cust.CustomerID

/*
	Problem 25: Determine how much money customers have saved with discounts on orders using TSQLV4.
	
*/
IF OBJECT_ID (N'dbo.saveMon', N'FN') IS NOT NULL  
    DROP FUNCTION saveMon;  
GO  
CREATE FUNCTION dbo.saveMon(@EID numeric(4,3), @qty smallint)  
RETURNS MONEY   
AS   
BEGIN  
    DECLARE @ret AS MONEY;  
    IF (@EID > 0.000)
	   SET @ret = (@EID * @qty);
    ELSE SET @ret = 0;
		  
    RETURN @ret;  
END; 

USE TSQLV4;
GO
SELECT          Cust.custid, SUM(dbo.saveMon(Sod.discount, sod.qty)) AS SavedMoney

FROM            Sales.Customers AS Cust
                INNER JOIN Sales.Orders as Soh ON Cust.custid = Soh.custid
				INNER JOIN Sales.OrderDetails as Sod ON Sod.orderid = Soh.orderid

GROUP BY		Cust.custid
HAVING			SUM(dbo.saveMon(Sod.discount, sod.qty)) > 0
ORDER BY		Cust.custid;

/*
	Problem 26: Determine if a customer order was shipped late using TSQLV4.
	
*/
IF OBJECT_ID (N'dbo.isLate', N'FN') IS NOT NULL  
    DROP FUNCTION isLate;  
GO  
CREATE FUNCTION dbo.isLate(@req date, @shp date)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@shp > @req)   
        SET @ret = 1;
    ELSE SET @ret = 0;
		  
    RETURN @ret;  
END; 

USE TSQLV4;
GO
SELECT          Cust.custid
				, SUM(dbo.isLate(Soh.requireddate, Soh.shippeddate)) AS ShippedLate
				, SUM(Sod.discount) AS CurrentDiscount
				, SUM((dbo.isLate(Soh.requireddate, Soh.shippeddate)) * (Sod.qty * 0.20)) AS AdditionalDiscount
				, SUM((dbo.isLate(Soh.requireddate, Soh.shippeddate)) * (Sod.qty * 0.20) + (Sod.discount)) AS NewDiscount
				
FROM            Sales.Customers AS Cust
                INNER JOIN Sales.Orders as Soh ON Cust.custid = Soh.custid
				INNER JOIN Sales.OrderDetails as Sod ON Sod.orderid = Soh.orderid
WHERE			dbo.isLate(Soh.requireddate, Soh.shippeddate) > 0
GROUP BY		Cust.custid
HAVING			SUM(dbo.isLate(Soh.requireddate, Soh.shippeddate)) > 0 
ORDER BY		Cust.custid;

/*
	Problem 27: Determine how many products need to be chilled using WideWorldImporters.
	
*/
IF OBJECT_ID (N'dbo.needChil', N'FN') IS NOT NULL  
    DROP FUNCTION needChil;  
GO  
CREATE FUNCTION dbo.needChil(@EID int)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID > 0 )   
        SET @ret = 1;
	 ELSE SET @ret = 0;	  
    RETURN @ret;  
END; 

USE WideWorldImporters;
GO
SELECT          Cust.OrderID, SUM(dbo.needChil(Soh.TotalChillerItems)) AS ColdItems

FROM            Sales.Orders AS Cust
                INNER JOIN Sales.Invoices as Soh ON Cust.OrderID = Soh.OrderID
				INNER JOIN Sales.InvoiceLines as Sod ON Sod.InvoiceID = Soh.InvoiceID

GROUP BY		Cust.OrderID
HAVING SUM(dbo.needChil(Soh.TotalChillerItems)) > 0
ORDER BY		Cust.OrderID

/*
	Problem 28: Determine how many products are meant to be surprises using WideWorldImporters.
	
*/
IF OBJECT_ID (N'dbo.surprise', N'FN') IS NOT NULL  
    DROP FUNCTION surprise;  
GO  
CREATE FUNCTION dbo.surprise(@EID int)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID IS NULL )   
        SET @ret = 1;
	 ELSE SET @ret = 0;	  
    RETURN @ret;  
END; 

USE WideWorldImporters;
GO
SELECT          Soh.CustomerID, SUM(dbo.surprise(Cust.PickedByPersonID)) AS SurpriseItems

FROM            Sales.Orders AS Cust
                INNER JOIN Sales.Invoices as Soh ON Cust.OrderID = Soh.OrderID
				INNER JOIN Sales.InvoiceLines as Sod ON Sod.InvoiceID = Soh.InvoiceID

GROUP BY		Soh.CustomerID
ORDER BY		Soh.CustomerID;

/*
	Problem 29: Determine how many customer orders use shipper three using TSQLV4.
	
*/
IF OBJECT_ID (N'dbo.shipThr', N'FN') IS NOT NULL  
    DROP FUNCTION shipThr;  
GO  
CREATE FUNCTION dbo.shipThr(@EID int)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID = 3)   
        SET @ret = 1;
    ELSE SET @ret = 0;
		  
    RETURN @ret;  
END; 

USE TSQLV4;
GO
SELECT          Cust.custid, SUM(dbo.shipThr(Soh.shipperid)) AS ShipperThree

FROM            Sales.Customers AS Cust
                INNER JOIN Sales.Orders as Soh ON Cust.custid = Soh.custid
				INNER JOIN Sales.OrderDetails as Sod ON Sod.orderid = Soh.orderid

GROUP BY		Cust.custid
HAVING			SUM(dbo.shipThr(Soh.shipperid)) > 0
ORDER BY		Cust.custid;

/*
	Problem 30: Determine how many products were packed by person 14 using WideWorldImporters.
	
*/
IF OBJECT_ID (N'dbo.packed', N'FN') IS NOT NULL  
    DROP FUNCTION packed;  
GO  
CREATE FUNCTION dbo.packed(@EID int)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret AS int;  
    IF (@EID = 14 )   
        SET @ret = 1;
	 ELSE SET @ret = 0;	  
    RETURN @ret;  
END; 

USE WideWorldImporters;
GO
SELECT          Cust.OrderID, SUM(dbo.packed(Soh.PackedByPersonID)) AS PackedBy14

FROM            Sales.Orders AS Cust
                INNER JOIN Sales.Invoices as Soh ON Cust.OrderID = Soh.OrderID
				INNER JOIN Sales.InvoiceLines as Sod ON Sod.InvoiceID = Soh.InvoiceID

GROUP BY		Cust.OrderID
ORDER BY		Cust.OrderID;		


