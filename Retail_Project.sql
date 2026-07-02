-- Creation of tables for Retail Analysis
-- Stores: the actual physical store locations
-- Products: items sold
-- Sales: individual sale transactions

CREATE TABLE stores(
 store_id INT PRIMARY KEY,
 store_name VARCHAR(50),
 city VARCHAR(50),
 region VARCHAR(50)
 
);

CREATE TABLE products(
     product_id INT PRIMARY KEY,
	 product_name VARCHAR(50),
	 category VARCHAR(50),
	 price NUMERIC
);

CREATE TABLE sales(
  sale_id INT PRIMARY KEY,
  store_id INT,
  product_id INT,
  quantity INT,
  sale_date DATE
);

-- Inserting stores: 3 cities, 2 stores each = 6 stores
INSERT INTO stores (store_id, store_name, city, region) VALUES
(1, 'Durban Central', 'Durban', 'KwaZulu-Natal'),
(2, 'Durban North', 'Durban', 'KwaZulu-Natal'),
(3, 'Sandton City', 'Johannesburg', 'Gauteng'),
(4, 'Soweto Mall', 'Johannesburg', 'Gauteng'),
(5, 'Cape Town CBD', 'Cape Town', 'Western Cape'),
(6, 'Bellville', 'Cape Town', 'Western Cape');

-- Inserting products: across 4 categories
INSERT INTO products (product_id, product_name, category, price) VALUES
(1, 'Maize Meal 5kg', 'Groceries', 65.00),
(2, 'Cooking Oil 2L', 'Groceries', 89.50),
(3, 'Rice 5kg', 'Groceries', 95.00),
(4, 'Bread Loaf', 'Groceries', 18.50),
(5, 'Samsung TV 43"', 'Electronics', 6999.00),
(6, 'Bluetooth Speaker', 'Electronics', 450.00),
(7, 'Phone Charger', 'Electronics', 150.00),
(8, 'Men T-Shirt', 'Clothing', 199.00),
(9, 'Women Dress', 'Clothing', 349.00),
(10, 'Kids Sneakers', 'Clothing', 299.00),
(11, 'Shampoo 400ml', 'Health & Beauty', 75.00),
(12, 'Toothpaste', 'Health & Beauty', 35.00);

-- Inserting sales: transactions across stores, products and dates
INSERT INTO sales (sale_id, store_id, product_id, quantity, sale_date) VALUES
(1, 1, 1, 10, '2026-01-05'),
(2, 1, 5, 1, '2026-01-06'),
(3, 2, 2, 5, '2026-01-06'),
(4, 3, 5, 2, '2026-01-07'),
(5, 3, 6, 4, '2026-01-07'),
(6, 4, 1, 15, '2026-01-08'),
(7, 4, 8, 6, '2026-01-08'),
(8, 5, 9, 3, '2026-01-09'),
(9, 5, 3, 8, '2026-01-09'),
(10, 6, 10, 5, '2026-01-10'),
(11, 6, 11, 7, '2026-01-10'),
(12, 1, 12, 12, '2026-01-11'),
(13, 2, 5, 1, '2026-01-11'),
(14, 3, 7, 9, '2026-01-12'),
(15, 4, 4, 20, '2026-01-12'),
(16, 5, 6, 3, '2026-01-13'),
(17, 6, 2, 6, '2026-01-13'),
(18, 1, 9, 2, '2026-01-14'),
(19, 2, 3, 10, '2026-01-14'),
(20, 3, 1, 18, '2026-01-15'),
(21, 4, 11, 5, '2026-01-15'),
(22, 5, 8, 4, '2026-01-16'),
(23, 6, 5, 1, '2026-01-16'),
(24, 1, 6, 2, '2026-01-17'),
(25, 2, 10, 3, '2026-01-17'),
(26, 3, 12, 9, '2026-01-18'),
(27, 4, 9, 1, '2026-01-18'),
(28, 5, 4, 25, '2026-01-19'),
(29, 6, 7, 6, '2026-01-19'),
(30, 1, 2, 8, '2026-01-20');


--- Confirmation of all stores raw data
SELECT * 
FROM stores;

-- Confirmation of all products raw  data
SELECT *
FROM products;

-- Confirmation of all sales raw data
SELECT * 
FROM sales;

--=====================================================================================================
--BUSINESS QUESTION POSED BY MANAGEMENT TO GUIDE UPCOMING DECISIONS.
--=====================================================================================================

--=====================================================================================================
--Q1: SHOW EVERY SALE WITH THE STORE NAME,PRODUCT NAME,QUANTITY AND SALES DATE
--=====================================================================================================

SELECT stores.store_name,
       products.product_name,
	   sales.quantity,
	   sales.sale_date
FROM sales
INNER JOIN stores
   ON sales.store_id = stores.store_id
   INNER JOIN products
     ON sales.product_id = products.product_id
ORDER BY sales.sale_date;

--======================================================================================
--Q2: CALCULATE THE TOTAL REVENUE PER STORE(QUANTITY * PRICE) ORDERED FROM HIGH TO LOW
--=====================================================================================

SELECT stores.store_name,
    SUM(sales.quantity * products.price) AS total_revenue
FROM sales
   INNER JOIN stores
     ON sales.store_id = stores.store_id
	 INNER JOIN products
	    ON sales.product_id = products.product_id
		GROUP BY stores.store_name
		ORDER BY total_revenue DESC;

--========================================================================================================
--Q3: WHICH PRODUCT GENERATED THE MOST REVENUE OVERALL, SHOW THE PRODUCT NAME, CATEGORY AND TOATL REVENUE
--=========================================================================================================

SELECT SUM(sales.quantity * products.price) AS total_revenue, 
          products.product_name , products.category
   FROM sales
   INNER JOIN products
     ON sales.product_id = products.product_id
	 GROUP BY products.product_name, products.category
	 ORDER BY total_revenue DESC
	 LIMIT 1;

--============================================================
--Q4: WHICH CITY GENERATED THE MOST TOTAL REVENUE
--============================================================

SELECT SUM(sales.quantity * products.price) AS total_revenue, stores.city
    FROM sales
	INNER JOIN products
	   ON sales.product_id = products.product_id
	INNER JOIN stores
	     ON sales.store_id = stores.store_id
	GROUP BY stores.city 
	ORDER BY total_revenue DESC;
	
--====================================================================================================
--Q5:SHOW THE NUMBER OF TRANSACTIONS AND TOTAL REVENUE PER STORE. ORDER BY NUMNER OF TRANSACTIONS
-- HIGH TO LOW
--===================================================================================================

SELECT COUNT(sales) AS num_of_trans, SUM(sales.quantity * products.price) AS total_revenue,
        stores.store_name
		FROM sales
		 INNER JOIN products
		   ON sales.product_id = products.product_id
		    INNER JOIN stores
			 ON sales.store_id = stores.store_id
			 GROUP BY stores.store_name
			 ORDER BY num_of_trans DESC;

--=================================================================================================================
--Q6: CATERGORISE EACH STORES TOTAL REVENUE INTO HIGJ PERFOMANCE BANDS (USE CASES) 
-- ABOVE 15K > HIGH PERFORMER
-- BETWEEN 8K TO 15K > MID
-- BELOW 8K > LOW PERFORMER
--=======================================================================================================

SELECT SUM(sales.quantity * products.price) AS total_revenue, stores.store_name,
     CASE 
    WHEN SUM(sales.quantity * products.price) > 15000 THEN 'HIGH PERFORMER'
	WHEN  SUM(sales.quantity * products.price) BETWEEN 8000 AND  15000 THEN 'MID'
	ELSE 'LOW PERFORMER'
	END AS performance_band
     FROM sales
	  INNER JOIN products   
	    ON sales.product_id = products.product_id
		 INNER JOIN stores
		  ON sales.store_id = stores.store_id
		  GROUP BY stores.store_name
		  ORDER BY total_revenue DESC;

---==================================================================================================
--Q7: SHOW ALL STORES THAT GENERATED MORE REVENUE THAN THE AVERAGE STORE REVENUE.
--===================================================================================================
SELECT SUM(sales.quantity * products.price) AS total_revenue, stores.store_name
FROM sales
 INNER JOIN products
   ON sales.product_id = products.product_id
      INNER JOIN stores
	    ON sales.store_id = stores.store_id
		GROUP BY stores.store_name
HAVING SUM(quantity * price) > (SELECT AVG(store_total) FROM 
            (SELECT SUM(sales.quantity * products.price) AS store_total
			  FROM sales
			     INNER JOIN products
				   ON sales.product_id = products.product_id
				   GROUP BY sales.store_id) AS store_revenue)
ORDER BY total_revenue DESC;
         
--===================================================================================================
--Q8: RANK STORES BY REVENUE WITHIN EACH REGION. SHOW ONLY THE TOP STORE PER REGION
-- NB(USE CTEs)
--==================================================================================================

WITH ranked_stores AS (
      SELECT SUM(sales.quantity * products.price) AS store_revenue,
	  stores.region,
	  stores.store_name,
 RANK() OVER(PARTITION BY stores.region ORDER BY SUM(sales.quantity * products.price)DESC) AS region_rank
		FROM sales
		  INNER JOIN products
		    ON sales.product_id = products.product_id
			  INNER JOIN stores
			   ON sales.store_id = stores.store_id
			   GROUP BY stores.region , stores.store_name
)
 SELECT region,store_name , store_revenue , region_rank
 FROM ranked_stores
 WHERE region_rank = 1
 ORDER BY store_revenue DESC;













		  






