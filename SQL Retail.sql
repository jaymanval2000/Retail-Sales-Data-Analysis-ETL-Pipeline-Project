
Create Database Retail;

Use Retail;

Select * From Orders;
Select * From Customers;

---Using Clauses

---WHERE Clause (Where Clause is used for filter data based on specific conditions)

---Q: List Orders Where City Is 'Delhi'.

SELECT * FROM Orders
WHERE City = 'Delhi';

---AND/OR Clause (Combine multiple conditions)

---Q List Customers Where Category is 'Fashion' And Quantity > 8

Select * from Customers
Where Category = 'Fashion' and Quantity > 8;

---Q List Orders Where Product is 'Watch' Or Sales < 15

Select * from Orders
Where Product = 'Watch' or Sales > 15;

---In Clause(Matches any value from a list)

---Q List Orders Where City Is 'Pune' and 'Mumbai'.

SELECT * FROM Orders
WHERE City in ('Pune','Mumbai');

---Not In Clause(No Matches any value from a list)

---Q List Orders Where City Is 'Bangalore' and 'Chennai'.

SELECT * FROM Orders
WHERE City not in ('Bangalore','Chennai');

---Between Clause (Filters value in a range)

---Q Find Sales between 25 and 30

Select * from Orders
Where Sales Between 25 and 30;

---Not Between Clause (Filters value not in a range)

---Q Find Order Date not between '2025-01-01' and '2025-02-28'

Select * from Orders
Where Order_Date Not Between '2025-01-01' and '2025-02-28';

---Like Clause (Pattern Matching Using Wildcards)

---Q Find product names that start with M

Select * from Customers
where Product LIKE 'M%';

---Q Find city names that end with ne

Select * from Customers
where City LIKE '%ne';

---DISTINCT Clause (Used for removes duplicate values)

---Q: Get distinct product names from Orders.

SELECT DISTINCT Product FROM Orders;

---ORDER BY Clause (Used for sorts result in ascending(ASC) or Descending(DESC) order.)  

---Q: List orders sorted by Quantity descending.

SELECT * FROM Orders
ORDER BY Quantity DESC;

---Using Aggregate functions (GROUP BY,COUNT)

----Group By Clause (Groups rows with same values;used with aggregate function)

---Q Which Product Has Maximum Sales Among All

select PRODUCT,Sum(Sales) as Total_Sales
from Orders
group by Product;

---Count Clause (Used to return the numbers of rows that match a specific condition)

---Q: Count how many orders per City.

SELECT City, COUNT(*) AS Orders_Count
FROM Orders
GROUP BY City
ORDER BY Orders_Count ASC;

---HAVING Clause (Filters groups created by GROUP BY)

---Q: Show cities having more than 200 orders.

SELECT City, COUNT(*) AS Orders_Count
FROM Orders
GROUP BY City
HAVING COUNT(*) > 200;

---Using JOIN Concepts (Combines rows from two or more tables)

--—INNER JOIN (Inner join returns common value between two tables.)

---Q: Show orders with matching customers info (inner join on Order_id).

SELECT O.Order_id,
       O.City, 
       O.Product AS Order_Product,
       O.Category,
       O.Price,
       O.Sales,
       O.Region,
       O.Quantity,
       C.Product AS Customer_Product, 
       C.Category,
       C.Quantity,
       C.Price,
       C.Discount,
       C.Total,
       C.City
       FROM Orders O
       INNER JOIN Customers C
       ON O.Order_id = C.Order_id;

---LEFT JOIN (Left join will give all values from left table & will only give matches from right)

---Q: Show top 10 orders and any customer data if present.

SELECT Top 10
       O.Order_id, 
       O.City, 
       O.Product AS Order_Product, 
       C.Category
       FROM Orders O
       LEFT JOIN Customers C
       ON O.Order_id = C.Order_id;

---RIGHT JOIN (Right join will give all values from right table & will only give matches from left)

---Q: Show all customers and orders if present.

SELECT C.Order_id, 
       C.Product AS Customer_Product,
       C.Category,
       C.Price,
       C.Discount,
       C.City,
       O.City
       FROM Customers C
       RIGHT JOIN Orders O
       ON C.Order_id = O.Order_id;

---Using UPDATE Command

---Q: Update city for a specific order.

UPDATE Orders
SET City = 'Bengaluru'
WHERE Order_id = 101;

Select * From Orders;

---Using DELETE Command

---Q: Delete customers with missing product.

DELETE FROM Customers
WHERE Product IS NULL;

Select * from Customers;

---Using CASE expression

---Q: Categorize cities as 'Metro' or 'Other' (example rule).

SELECT Order_id, City,
  CASE
    WHEN City IN ('Mumbai','Delhi','Bangalore','Chennai') THEN 'Metro'
    ELSE 'Other'
  END AS City_Type
FROM Orders;

---Using Subquery

---Q: Find orders whose Product appears in Customers table.

SELECT * FROM Orders
WHERE Product IN (SELECT Product FROM Customers);

---Using COALESCE

---Q: Show Category, but if NULL show 'Unknown'.

SELECT Order_id, Product, COALESCE(Category, 'Unknown') AS Category
FROM Customers;

---Using Window functions — ROW_NUMBER()

---Q: Assign a row number partitioned by City ordered by Order_id.

SELECT Order_id, City, Product,
       ROW_NUMBER() OVER (PARTITION BY City ORDER BY Order_id) AS rn_in_city
FROM Orders;

---Using Window functions — RANK/DENSE_RANK and aggregates over partition

---Q: Find top product per city by Order_id (example using ROW_NUMBER).

SELECT Order_id, City, Product
FROM (
  SELECT Order_id, City, Product,
         ROW_NUMBER() OVER (PARTITION BY City ORDER BY Order_id DESC) AS rn
  FROM Orders
) t
WHERE rn = 1;

---CREATE VIEW

---Q: Create a view showing order + category (joined).

CREATE VIEW vw_OrderCustomer AS
SELECT o.Order_id, o.City, o.Product AS order_product, c.Category
FROM Orders o
LEFT JOIN Customers c ON o.Order_id = c.Order_id;

Select * From Orders;
Select * From Customers;