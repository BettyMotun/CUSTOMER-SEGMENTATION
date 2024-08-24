CREATE TABLE 
Retail(InvoiceNo INT,
StockCode INT,
Description VARCHAR (1000),
Quantity INT,
InvoiceDate DATE,
UnitPrice FLOAT,
CustomerID INT,
Country VARCHAR (100)
);

SELECT * FROM Retail;
--Datatype altered to enable dataset load easily
ALTER TABLE retail
ALTER COLUMN StockCode TYPE VARCHAR(100),
ALTER COLUMN invoicedate TYPE VARCHAR(100),
ALTER COLUMN invoiceno TYPE VARCHAR(100);


--Question 1.What is the distribution of order values
--across all customers in the dataset?
-- to get order values

SELECT 
	customerid,
	stockcode,
	description,
	quantity,
	unitprice,
	ROUND(CAST((quantity * unitprice) AS DECIMAL) , 2)  AS ordervalue
FROM retail

WITH
	details AS(
	SELECT 
	customerid,
	stockcode,
	description,
	quantity,
	unitprice,
	ROUND(CAST((quantity * unitprice) AS DECIMAL) , 2)  AS ordervalue
FROM retail
WHERE ROUND(CAST((quantity * unitprice) AS DECIMAL) , 2) >0
	AND customerid IS NOT NULL
),
/*SELECT MIN(ordervalue),
	   MAX(ordervalue)
FROM details*/--to get the range between max and min ordervalue for easy classification

-- to classify the customers
class AS(
	SELECT *,
	CASE
		WHEN ordervalue BETWEEN 0 AND 500 THEN 'a, 0 - 500'
		WHEN ordervalue BETWEEN 501 AND 5000 THEN 'b, 501 - 5k'
		WHEN ordervalue BETWEEN 50001 AND 100000 THEN 'c, 5.1k - 100k'
		ELSE 'd, above 100k'
	END AS orderclass
	FROM details
)
SELECT 
	COUNT(*) AS no_of_customers,
	orderclass
FROM class
GROUP BY orderclass
ORDER BY 2

 -- 2 How many unique products has each customer purchased?
SELECT COUNT(DISTINCT stockcode) AS unique_product_purchased, customerid
FROM retail
GROUP BY customerid

WITH 
	soldproducts AS (
	SELECT 
	COUNT(DISTINCT stockcode) AS unique_product_purchased, 
	customerid
FROM 
	retail
GROUP BY 
	customerid
)
SELECT 
	*
FROM 
	soldproducts
GROUP BY
	customerid, 
	unique_product_purchased

--- 3.Which customers have only made a single purchase from the company?
SELECT 
    customerid, COUNT(DISTINCT invoiceno) AS single_purchase_count
FROM 
    retail
GROUP BY 
    customerid
HAVING 
    COUNT(DISTINCT invoiceno) = 1 AND customerid IS NOT NULL
ORDER BY
		COUNT(DISTINCT invoiceno) DESC


-- Based on quantity,below customers have only made a single purchase from the company?
SELECT SUM(quantity) AS quantity_purchased,
	customerid,
	invoiceno
FROM retail
WHERE quantity = 1 AND customerid IS NOT NULL
GROUP BY invoiceno, customerid
ORDER BY SUM(quantity);
--Purchased goods/products only once by quantity



SELECT customerid, COUNT(DISTINCT invoiceno) AS number_of_purchase
FROM retail
WHERE customerid IS NOT NULL
GROUP BY customerid
ORDER BY COUNT(DISTINCT invoiceno);
--Purchased goods/products only once by invoiceno


SELECT customerid, COUNT(DISTINCT invoiceno) AS number_of_purchase
FROM retail
GROUP BY customerid
HAVING COUNT(DISTINCT invoiceno) = 1 AND customerid IS NOT NULL
ORDER BY COUNT(DISTINCT invoiceno) DESC;


--4.Which products are most commonly purchased together by customers in the
dataset?
--To get most commonly purchased products,retail table would be 
--divided into two tables (a and b) using stockcode or description.
--Products purchased together can then be grouped
--easiliy together with quantity using same invoiceno.
SELECT *
FROM retail

SELECT 
        a.stockcode AS product1,
        b.stockcode AS product2
    FROM 
        retail a
    JOIN 
        retail b 
    ON 
        a.invoiceno = b.invoiceno
    WHERE 
        a.stockcode < b.stockcode	

	
WITH common_products AS (
    SELECT 
        a.stockcode AS product1,
        b.stockcode AS product2
    FROM 
        retail a
    JOIN 
        retail b 
    ON 
        a.invoiceno = b.invoiceno
    WHERE 
        a.stockcode < b.stockcode --to avoid repetition
)

SELECT 
    product1, 
    product2, 
    COUNT(*) AS product_count
FROM 
    common_products
GROUP BY 
    product1, 
    product2
ORDER BY 
	 product_count DESC;

SELECT * FROM Retail;

SELECT customerid, MAX(stockcode) AS products_purchased_together, invoiceno
FROM retail
WHERE customerid IS NOT NULL
GROUP BY customerid, stockcode, invoiceno
ORDER BY MAX(stockcode) DESC;
-
SELECT customerid, COUNT(stockcode) AS products_purchased_together, description, invoiceno
FROM retail
WHERE customerid IS NOT NULL
GROUP BY customerid, description, invoiceno
ORDER BY COUNT(stockcode) DESC;

SELECT DISTINCT description, stockcode, customerid
FROM retail
WHERE customerid IS NOT NULL
GROUP BY description, customerid, stockcode;

SELECT stockcode, description, invoiceno, COUNT(*) AS no_of_products_purchased
FROM retail
WHERE customerid IS NOT NULL
GROUP BY stockcode, description, invoiceno
ORDER BY COUNT(stockcode) DESC;

