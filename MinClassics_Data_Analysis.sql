-- Imported the data from the Queries.
-- Created the Mint_Classics database.

USE mintclassics;

-- Listing all the tables present in the database.

SELECT *
FROM customers;

SELECT *
FROM employees;

SELECT *
FROM offices;

SELECT *
FROM orderdetails;

SELECT * 
FROM orders;

SELECT *
FROM payments;

SELECT *
FROM productlines;

SELECT *
FROM products;

SELECT * 
FROM warehouses;

-- Cleaning all the tables values
-- Customers Table
UPDATE customers
SET addressLine2 = "NA"
WHERE addressLine2 IS NULL;

UPDATE customers
SET state = "NA"
WHERE state IS NULL;

-- Offices Table
UPDATE offices
SET addressLine2 = "NA"
WHERE addressLine2 IS NULL;

UPDATE offices
SET state = "NA"
WHERE state IS NULL;

-- Orders Tables
UPDATE orders
SET comments = "Not Commented"
WHERE comments IS NULL;

-- Joining two tables "Employees" and "Offices";

SELECT *
FROM employees AS e
INNER JOIN offices AS o
ON e.officeCode = o.officeCode;

-- Searching for duplicate values within the orders table.

SELECT *, count(orderNumber) AS CountNo
FROM orders
GROUP BY orderNumber;

SELECT DISTINCT *
FROM orders;

-- Tallying the status of customers based on whether their orders have been shipped, placed on hold, or are in dispute.

SELECT o.status, count(*)
FROM customers AS c
INNER JOIN orders AS o
on c.customerNumber = o.customerNumber
GROUP BY o.status;

-- Evaluating the country of origin for each employee and determining their respective headcounts.

SELECT o.country, count(*) AS Count
FROM employees AS e
INNER JOIN offices AS o
on e.officeCode = o.officeCode
GROUP BY country;

-- Examining the names of customers with a credit limit of zero.

SELECT c.customerName,
e.jobTitle,
c.creditLimit
FROM customers AS c
INNER JOIN employees AS e
ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE c.creditLimit = 0;

-- Reviewing customer payments received and their credit limits.

SELECT p.customerNumber,
customerName,
p.paymentDate,
c.creditLimit,
p.Amount
FROM customers AS c
INNER JOIN payments AS p
ON c.customerNumber = p.customerNumber;

-- Identifying the top five best-selling products and the subsequent five top-selling products.

SELECT p.productName,
o.quantityOrdered,
p.productLine,
sum(o.priceEach) AS Price
FROM orderdetails AS o
INNER JOIN products AS p
ON o.productCode = p.productCode
GROUP BY p.productName
ORDER BY o.quantityOrdered DESC
LIMIT 5;

SELECT p.productName,
o.quantityOrdered,
p.productLine,
sum(o.priceEach) AS Price
FROM orderdetails AS o
INNER JOIN products AS p
ON o.productCode = p.productCode
GROUP BY p.productName
ORDER BY o.quantityOrdered DESC
LIMIT 5
OFFSET 5;


-- Assessing the leading product based on its quantity or sales figures.
-- Ferrari is both the priciest and top-selling car, and it's also the most widely available in stock.

SELECT p.productName,
sum(o.quantityOrdered) AS Quantity,
p.productLine
FROM orderdetails AS o
INNER JOIN products AS p
ON o.productCode = p.productCode
GROUP BY p.productName
ORDER BY Quantity DESC;