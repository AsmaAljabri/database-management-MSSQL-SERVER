/*1. Retrieve all columns from the "Customers" table:*/
--write your query here (3 points)
SELECT * FROM Customers;


/*2. Retrieve the "ProductName" column from the "Products" table:*/
--write your query here (3 points)
SELECT ProductName FROM Products;


/*3. Retrieve the "OrderID" and "OrderDate" columns from the "Orders" table,
ordered by "OrderDate" in descending order:*/
--write your query here (3 points)

SELECT OrderID, OrderDate
FROM Orders
ORDER BY OrderDate DESC;

/*4. Retrieve the "CompanyName" column from the "Suppliers" table, 
where the "Country" is "USA":*/
--write your query here (3 points)
SELECT CompanyName FROM Suppliers
WHERE Country = 'USA';


/*5. Retrieve the "CategoryName" column from the "Categories" table, 
ordered by "CategoryName" in alphabetical order:*/
--write your query here (3 points)
SELECT CategoryName FROM Categories
ORDER BY CategoryName ASC;

/*6. Retrieve the "CompanyName" and "ShipCity" columns from the "Shippers" table, joining it with the Orders
table to obtain the Shipper's city for each order*/
--write your query here (3 points)

SELECT  CompanyName ,ShipCity 
FROM Shippers S,Orders O
WHERE O.ShipVia =S.ShipperID;


/*7. Retrieve the "FirstName" and "LastName" columns from the "Employees" table, 
where the "Country" is not "USA":*/
--write your query here (3 points)

SELECT FirstName, LastName 
FROM Employees
WHERE Country <> 'USA';

/*8. Retrieve the "CustomerID" and "CompanyName" columns from the "Customers" table, 
where the "City" is either "London" or "Paris":*/
--write your query here (3 points)
SELECT CustomerID, CompanyName 
FROM Customers
WHERE City = 'London' OR City = 'Paris';

/*9. Retrieve the "OrderID" and "ProductName" columns from the "Order Details" table, 
where the "Quantity" is greater than 10:*/
--write your query here (3 points)
SELECT OrderID, ProductName 
FROM [Order Details] O,Products P
WHERE O.ProductID = P.ProductID AND O.Quantity > 10;


/*10. Retrieve the "EmployeeID" and "Title" columns from the "Employees" table, 
where the "Title" contains the word "Manager":*/
--write your query here (3 points)

SELECT EmployeeID, Title
FROM Employees
WHERE Title LIKE '%Manager%';


/*11. Retrieve the "SupplierID" and "CompanyName" columns from the "Suppliers" table, 
where the "CompanyName" starts with the letter "A":*/
--write your query here (6 points)

SELECT SupplierID, CompanyName
FROM Suppliers
WHERE CompanyName LIKE 'A%';

/*12. Retrieve the "ProductID" and "UnitPrice" columns from the "Products" table, 
where the "UnitPrice" is between 10 and 20:*/
--write your query here (6 points)
SELECT ProductID, UnitPrice
FROM Products
WHERE UnitPrice BETWEEN 10 AND 20;

/*13. Retrieve the "ShipCountry" and the count of orders shipped to each country from the "Orders" table, 
grouped by "ShipCountry":*/
--write your query here (6 points)
SELECT ShipCountry,COUNT(*) AS[orders shipped to each country ]
FROM Orders
GROUP BY ShipCountry;

/*14. Retrieve the "CustomerID" and the sum of "Quantity" from the "Order Details" table, grouped by "CustomerID", 
ordered by the sum in descending order:*/
--write your query here (6 points)
SELECT CustomerID, SUM(Quantity) AS TotalQuantity
FROM Customers, [Order Details]
GROUP BY CustomerID
ORDER BY TotalQuantity DESC;



/*15. Retrieve the "ProductName" and the average of "UnitPrice" from the "Products" table, grouped by "ProductName", 
ordered by the average in descending order:*/
--write your query here (6 points)

SELECT ProductName, AVG(UnitPrice) AS AverageUnitPrice
FROM Products
GROUP BY ProductName
ORDER BY AverageUnitPrice DESC;


/*16. Retrieve the "OrderID" and "OrderDate" columns from the "Orders" table, 
where the "OrderDate" is in the year 1997 and the "ShipCity" is "Berlin":*/
--write your query here (6 points)

SELECT OrderID, OrderDate
FROM Orders
WHERE YEAR(OrderDate) = 1997 AND ShipCity = 'Berlin';

/*17. Retrieve the "CustomerID" and the minimum "OrderDate" from the "Orders" table, 
grouped by "CustomerID":*/
--write your query here (6 points)

SELECT CustomerID, MIN(OrderDate) AS MinOrderDate
FROM Orders
GROUP BY CustomerID;

/*18. Retrieve the "OrderID" and the maximum "RequiredDate" from the "Orders" table, 
where the "ShipCountry" is either "France" or "Spain":*/
--write your query here (6 points)

SELECT OrderID, MAX(RequiredDate) AS MaxRequiredDate
FROM Orders
WHERE ShipCountry IN ('France', 'Spain')
GROUP BY OrderID;



/*19. Retrieve the "ProductID" and the sum of "Quantity" from the "Order Details" table, grouped by "ProductID", 
where the sum is greater than 100:*/
--write your query here (6 points)
SELECT SUM(Quantity) AS PRODUCTQUALITY , P.ProductID
FROM [Order Details] O, Products P
WHERE P.ProductID =O.ProductID
GROUP BY P.ProductID
HAVING SUM(Quantity) > 100
;

/*20. Retrieve the "EmployeeID" and the count of orders handled by each employee from the "Employees" table, grouped by "EmployeeID", 
ordered by the count in descending order:*/
--write your query here (9 points)
SELECT e.EmployeeID, COUNT(*) AS OrderCount
FROM Employees e,  Orders o
where e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID
ORDER BY OrderCount DESC;


/*21. Retrieve the customer ID, company name, and total revenue for customers who have made at least 5 orders, 
ordered by total revenue in descending order.*/
--write your query here (9 points)
SELECT c.CustomerID, c.CompanyName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Customers c,  [Order Details] od, Orders o 
WHERE c.CustomerID = o.CustomerID AND  o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
HAVING COUNT(o.OrderID) >= 5
ORDER BY TotalRevenue DESC;


/*22. Retrieve the employee ID, first name, last name, and the number of orders they have taken, 
for employees who have taken orders in the year 1996, ordered by the number of orders in descending order.*/
--write your query here (9 points)
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName,
       COUNT(Orders.OrderID) AS NumberOfOrders
FROM Employees, Orders 
WHERE Employees.EmployeeID = Orders.EmployeeID AND YEAR(Orders.OrderDate) = 1996
GROUP BY   Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY  NumberOfOrders DESC;


/*23. Retrieve the product name, unit price, and the number of times each product has been ordered, 
for products that have been ordered more than 100 times, ordered by the number of times ordered in descending order.*/
--write your query here (9 points)
SELECT  Products.ProductName, Products.UnitPrice,
    SUM([Order Details].Quantity) AS TimesOrdered
FROM Products, [Order Details] 
WHERE	Products.ProductID = [Order Details].ProductID
GROUP BY Products.ProductName, Products.UnitPrice
HAVING  SUM([Order Details].Quantity) > 100
ORDER BY TimesOrdered DESC;

/*24. Retrieve the employee ID, first name, last name, and the total revenue generated from the orders they have taken, 
for employees who have generated revenue exceeding $100,000, ordered by total revenue in descending order.*/
--write your query here (9 points)
SELECT Employees.EmployeeID, Employees.FirstName, Employees.LastName,
       SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalRevenue
FROM Employees, Orders,  [Order Details]
WHERE  Employees.EmployeeID = Orders.EmployeeID AND  Orders.OrderID = [Order Details].OrderID
GROUP BY  Employees.EmployeeID, Employees.FirstName, Employees.LastName
HAVING SUM([Order Details].Quantity * [Order Details].UnitPrice) > 100000
ORDER BY TotalRevenue DESC;


/*25. Retrieve the customer ID, company name, and the number of distinct products they have ordered, 
for customers who have ordered products from more than 5 different categories, ordered by the number of distinct products in descending order.*/
--write your query here (9 points)
SELECT
    Customers.CustomerID,
    Customers.CompanyName,
    COUNT(DISTINCT Products.ProductID) AS DistinctProductCount
FROM Customers, [Order Details],Orders, Products,Categories
WHERE  Customers.CustomerID = Orders.CustomerID AND  Orders.OrderID = [Order Details].OrderID AND  [Order Details].ProductID = Products.ProductID
AND Products.CategoryID = Categories.CategoryID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING COUNT(DISTINCT Categories.CategoryID) > 5
ORDER BY DistinctProductCount DESC;


/*26. Retrieve the employee ID, first name, last name, and the number of orders they have taken, 
for employees who have taken orders in the month of February, sorted by the number of orders in descending order.*/
--write your query here (9 points)

SELECT
    Employees.EmployeeID,
    Employees.FirstName,
    Employees.LastName,
    COUNT(Orders.OrderID) AS NumberOfOrders
FROM Employees, Orders
WHERE MONTH(Orders.OrderDate) = 2 AND Employees.EmployeeID = Orders.EmployeeID
GROUP BY Employees.EmployeeID, Employees.FirstName, Employees.LastName
ORDER BY NumberOfOrders DESC;


/*27. Retrieve the product ID, product name, and the total revenue generated from the sales of each product, 
for products that have generated revenue exceeding the average revenue of all products, ordered by total revenue in descending order.*/
--write your query here (9 points)
SELECT  p.ProductID, p.ProductName, SUM(od.Quantity * od.UnitPrice) AS TotalRevenue
FROM Products AS p ,  [Order Details] AS od
WHERE p.ProductID = od.ProductID 
GROUP BY   p.ProductID, p.ProductName
HAVING SUM(od.Quantity * od.UnitPrice) > 
         ( SELECT AVG(TotalRevenue)
           FROM (SELECT ProductID, SUM(Quantity * UnitPrice) AS TotalRevenue
                 FROM [Order Details]
                 GROUP BY ProductID ) AS ProductRevenue )
ORDER BY TotalRevenue DESC;


/*28. Retrieve the category name and the average unit price of products within each category, 
for categories that have at least 10 products, ordered by the average unit price in descending order.*/
--write your query here (9 points)
SELECT Categories.CategoryName,  AVG(Products.UnitPrice) AS AvgUnitPrice
FROM  Categories, Products
WHERE   Categories.CategoryID = Products.CategoryID
GROUP BY  Categories.CategoryName
HAVING   COUNT(Products.ProductID) >= 10
ORDER BY   AvgUnitPrice DESC;


/*29. Retrieve the customer ID, company name, and the total quantity of products ordered by each customer, 
for customers who have ordered a total quantity exceeding 1000, ordered by the total quantity in descending order.*/
--write your query here (9 points)
SELECT Customers.CustomerID, Customers.CompanyName, SUM([Order Details].Quantity) AS TotalQuantity
FROM  Customers, Orders, [Order Details]
WHERE   Customers.CustomerID = Orders.CustomerID AND   Orders.OrderID = [Order Details].OrderID
GROUP BY Customers.CustomerID, Customers.CompanyName
HAVING SUM([Order Details].Quantity) > 1000
ORDER BY  TotalQuantity DESC;


/*30. Retrieve the supplier company name and the number of products supplied by each supplier, 
for suppliers who have supplied more products than the average number of products supplied by all suppliers, ordered by the number of products supplied in descending order.*/
--write your query here (9 points)

SELECT
 s.CompanyName,
COUNT(p.ProductID) AS ProductsSupplied
FROM Suppliers s, Products p
WHERE s.SupplierID = p.SupplierID
GROUP BY s.CompanyName
HAVING COUNT(p.ProductID) > (
        SELECT AVG(ProductCount)
        FROM ( SELECT SupplierID, COUNT(ProductID) AS ProductCount
            FROM Products
            GROUP BY SupplierID) AS AvgSupplierProductCount)
ORDER BY ProductsSupplied DESC;

