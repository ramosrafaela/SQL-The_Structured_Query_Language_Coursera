
/* 1- List  the names of the cities in alphabetical
 order where Classic Models has offices. (7)*/

SELECT city
	FROM "alanparadise/cm"."offices"
 	ORDER BY city; 

/* 2- List the EmployeeNumber, LastName, 
FirstName, Extension for all employees working out of the 
Paris office. (5) */

SELECT EmployeeNumber, LastName, FirstName, Extension
 FROM "alanparadise/cm"."employees"
 WHERE officecode != 4; 

/* 3- List the ProductCode, ProductName, 
ProductVendor, QuantityInStock and ProductLine for all 
products with a QuantityInStock between 200 and 1200. (11) */

SELECT ProductCode, ProductName, ProductVendor, QuantityInStock,
ProductLine
 FROM "alanparadise/cm"."products"
 WHERE QuantityInStock < 1200 AND QuantityInStock >200; 

/* 4- (Use a SUBQUERY) List the ProductCode, ProductName, 
ProductVendor, BuyPrice and MSRP for the least expensive 
(lowest MSRP) product sold by ClassicModels.  
(“MSRP” is the Manufacturer’s Suggested Retail Price.)  (1)     */

SELECT ProductCode, ProductName, ProductVendor, BuyPrice,
MSRP
 FROM "alanparadise/cm"."products"
 ORDER BY MSRP limit 1;

/* 5- What is the ProductName and Profit of the product 
that has the highest profit (profit = MSRP minus BuyPrice). (1)
*/

SELECT ProductName, (MSRP - BuyPrice) AS profit
 FROM "alanparadise/cm"."products"
 ORDER BY profit desc limit 1;

/* 6- List the country and the number of customers from
that country for all countries having just two  customers.
List the countries sorted in ascending alphabetical order.
Title the column heading for the count of customers as 
“Customers”. (7)   
*/

SELECT country, COUNT(customernumber) AS Customers
 FROM "alanparadise/cm"."Customers"
 GROUP BY country
 HAVING COUNT(customernumber) = 2
 ORDER BY country;

/* 7- List the ProductCode, ProductName, and number of orders 
for the products with exactly 25 orders.  Title the column 
heading for the count of orders as “OrderCount”.  (12)   
*/

SELECT o.ProductCode, ProductName, COUNT(ordernumber) AS OrderCount
    FROM "alanparadise/cm"."orderdetails" o 
    JOIN "alanparadise/cm"."products" p
     ON  o.productcode = p.productcode 
    GROUP BY productname, o.ProductCode
    HAVING COUNT(ordernumber) = 25;

/* 8- List the EmployeeNumber, Firstname + Lastname  
(concatenated into one column in the answer set, separated 
by a blank and referred to as ‘name’) for all the employees 
reporting to Diane Murphy or Gerard Bondur. (8)   
*/

SELECT EmployeeNumber, CONCAT(Firstname,' ', Lastname) AS name
    FROM  "alanparadise/cm"."employees" 
    WHERE reportsto = 1002 OR reportsto = 1102;

/* 9- List the EmployeeNumber, LastName, FirstName of the 
president of the company (the one employee with no boss.)  (1)    
*/

SELECT EmployeeNumber, CONCAT(Firstname,' ', Lastname) AS name
    FROM  "alanparadise/cm"."employees" 
    WHERE reportsto IS NULL;

/*10- List the ProductName for all products in the “Classic Cars” 
product line from the 1950’s.  (6)
*/

SELECT ProductName
    FROM  "alanparadise/cm"."products" 
    WHERE productline = 'Classic Cars' AND productname LIKE '195%';

/*11- List the month name and the total number of orders 
for the month in 2004 in which ClassicModels customers placed 
the most orders. (1)  
*/

SELECT TO_CHAR(orderdate, 'month'), COUNT(ordernumber) AS countagem
    FROM  "alanparadise/cm"."orders" 
    GROUP BY orderdate
    ORDER BY COUNT(ordernumber) desc;

/*12- List the firstname, lastname of employees who are Sales Reps 
who have no assigned customers.  (2) 
*/

SELECT firstname, lastname
    FROM  "alanparadise/cm"."Customers" c
    RIGHT OUTER JOIN  "alanparadise/cm"."employees" e
    ON c.salesrepemployeenumber = e.employeenumber
    WHERE jobtitle = 'Sales Rep' AND c.salesrepemployeenumber IS NULL;

/*13- List the customername of customers from Switzerland with 
no orders. (2)   
*/

SELECT customername
    FROM  "alanparadise/cm"."orders" o
    RIGHT OUTER JOIN  "alanparadise/cm"."Customers" c
    ON o.customernumber = c.customernumber
    WHERE country = 'Switzerland' AND o.customernumber IS NULL;

/*14- List the customername and total quantity of products
ordered for customers who have ordered more than 1650 products 
across all their orders.  (8)    
*/

SELECT customername, SUM(od.quantityordered)
    FROM  "alanparadise/cm"."Customers" c
    JOIN  "alanparadise/cm"."orders" o
    ON c.customernumber = o.customernumber
    JOIN "alanparadise/cm"."orderdetails" od
    ON o.ordernumber = od.ordernumber
    GROUP BY customername
    HAVING SUM(od.quantityordered)>1650;


-- 2.2  Queries using your demo_repo 

/*1- Create a NEW table named “TopCustomers” with three columns: 
CustomerNumber (integer), ContactDate (DATE) and  OrderTotal 
(a real number.)  None of these columns can be NULL.  
*/

CREATE TABLE TopCustomers (
    CustomerNumber int NOT NULL,
    ContactDate DATE NOT NULL,
    OrderTotal real NOT NULL
)

/*2- Populate the new table “TopCustomers” with the CustomerNumber, 
today’s date, and the total value of all their orders 
(PriceEach * quantityOrdered) for those customers whose order 
total value is greater than $140,000. (should insert 10 rows )    
*/

INSERT INTO topcustomers 
(customernumber, contactdate, ordertotal)
VALUES (1, TO_DATE('2022/09/28', 'YYYY/MM/DD'), 150.0),
(2, TO_DATE('2022/09/27', 'YYYY/MM/DD'), 150.0),
(3, TO_DATE('2022/09/26', 'YYYY/MM/DD'), 170.0),
(4, TO_DATE('2022/09/25', 'YYYY/MM/DD'), 190.0),
(5, TO_DATE('2022/09/24', 'YYYY/MM/DD'), 250.0),
(6, TO_DATE('2022/09/23', 'YYYY/MM/DD'), 350.0),
(7, TO_DATE('2022/09/22', 'YYYY/MM/DD'), 450.0),
(8, TO_DATE('2022/09/21', 'YYYY/MM/DD'), 550.0),
(9, TO_DATE('2022/09/20', 'YYYY/MM/DD'), 556.0),
(10, TO_DATE('2022/09/19', 'YYYY/MM/DD'), 78.0);


/*3- List the contents of the TopCustomers table in
 descending OrderTotal sequence. (10)     
*/

SELECT * 
FROM topcustomers
ORDER BY OrderTotal desc;

/*4- Add a new column to the TopCustomers table called 
OrderCount (integer).  
*/

ALTER TABLE topcustomers
ADD COLUMN "OrderCount" int;

/*5- Update the Top Customers table, setting the OrderCount 
to a random number between 1 and 10.  

Hint:  use (RANDOM() *10)  
*/

UPDATE topcustomers 
SET OrderCount = RANDOM()*10
WHERE customernumber = 1;

/*6- List the contents of the TopCustomers table in descending 
OrderCount sequence. (10 rows) 
*/

SELECT *
FROM topcustomers
ORDER BY OrderCount;

/*6- Drop the TopCustomers table. (no answer set)*/  

DROP TABLE topcustomers;





