CREATE DATABASE coffee_shop_sales_db;

SELECT * FROM coffee_shop_sales;

##.....DATA CLEANING 

DESCRIBE coffee_shop_sales;

SELECT * FROM coffee_shop_sales;

UPDATE coffee_shop_sales
SET transaction_date =STR_TO_DATE(transaction_date, '%m/%d/%Y');

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_date DATE;

DESCRIBE coffee_shop_sales;

UPDATE coffee_shop_sales
SET transaction_time =STR_TO_DATE(transaction_time, '%H:%i:%s');

ALTER TABLE coffee_shop_sales
MODIFY COLUMN transaction_time TIME;

DESCRIBE coffee_shop_sales;


ALTER TABLE coffee_shop_sales
CHANGE COLUMN ï»¿transaction_id transaction_id INT;

SELECT * FROM coffee_shop_sales;

##...DATA ANALYSIS
##.....................1.Total sales Analysis (Analysis based on month of May)
 -- (a) Calculate the Total sales for each respective month.

SELECT SUM(unit_price* transaction_qty) as Total_Sales
FROM Coffee_shop_sales;

SELECT SUM(unit_price* transaction_qty) as Total_Sales
FROM Coffee_shop_sales
WHERE 
MONTH(transaction_date)= 5; -- may Month;

SELECT ROUND(SUM(unit_price* transaction_qty),1) as Total_Sales ##--Rounded to one decimal
FROM Coffee_shop_sales
WHERE 
MONTH(transaction_date)= 5; -- May Month;

SELECT ROUND(SUM(unit_price* transaction_qty)) as Total_Sales ##--Rounded to zero decimal
FROM Coffee_shop_sales
WHERE 
MONTH(transaction_date)= 5; -- may Month;

SELECT CONCAT((ROUND(SUM(unit_price* transaction_qty)))/1000, "K") as Total_Sales ##--Rounded to zero decimal with 'K'
FROM Coffee_shop_sales
WHERE 
MONTH(transaction_date)= 5; -- May Month;


##....1--(b) Determining the month-on-month inc/dec in sales
-- select Month/ Current Month=5
-- Previous Month- April=4

SELECT
	month(transaction_date)As month,-- Number of month
    ROUND(SUM(unit_price*transaction_qty)) AS total_sale,-- Total sale column
    (SUM(unit_price*transaction_qty)- LAG(SUM(unit_price*transaction_qty), 1)-- Month Sales Difference
    OVER (ORDER BY MONTH (transaction_date)))/LAG (SUM(unit_price * transaction_qty),1) -- Division by previous month sales
    OVER (ORDER BY MONTH (transaction_date))* 100 AS non_increasing_percentage -- percentage
FROM 
	coffee_shop_sales
WHERE
	MONTH (transaction_date) IN (4, 5) -- for months of April (PM) and May (CM)
GROUP BY
	MONTH (transaction_date)
ORDER BY
	MONTH(transaction_date);
    
    ##-----2. Total Order Analysis (Calaculation based on month of March)
    -- (a) Calculate the total number of orders for each respective month.

SELECT COUNT(transaction_id) AS Total_Orders
FROM coffee_shop_sales
WHERE
MONTH(transaction_date) = 3; -- March Month


-- (b) Determine the month-on-month increase or decrease in the number of orders. (calculation based on A pril and May)

SELECT
	month(transaction_date)As month,-- Number of month
    ROUND(SUM(unit_price*transaction_id)) AS total_Orders,-- Total sale column
    (COUNT(transaction_id)- LAG(COUNT(transaction_id), 1)-- Month Sales Difference
    OVER (ORDER BY MONTH (transaction_date)))/LAG (COUNT(transaction_id),1) -- Division by previous month sales
    OVER (ORDER BY MONTH (transaction_date))* 100 AS non_increasing_percentage -- percentage
FROM 
	coffee_shop_sales
WHERE
	MONTH (transaction_date) IN (4, 5) -- for months of April (PM) and May (CM)
GROUP BY
	MONTH (transaction_date)
ORDER BY
	MONTH(transaction_date);

##---- 3.Total Quantity Sold Analysis (Calculation based on month of June)
-- (a) Calculate the total quantity sold for each respective month

SELECT SUM(transaction_qty) AS Total_Quantity_sold
FROM coffee_shop_sales
WHERE
MONTH (transaction_date) = 6; -- June  Month

-- (b) Determine the month-on-month increase or decrease in total quantity  sold. ( Calculation based on Month of April & May)
SELECT
	month(transaction_date) As month,-- Number of month
    ROUND(SUM(transaction_qty)) AS total_quantity_sold,-- Total Quantity column
    (SUM(transaction_qty)- LAG(SUM(transaction_qty), 1)-- Month Sales Difference
    OVER (ORDER BY MONTH (transaction_date)))/LAG (SUM(transaction_qty),1) -- Division by previous month sales
    OVER (ORDER BY MONTH (transaction_date))* 100 AS non_increasing_percentage -- percentage
FROM 
	coffee_shop_sales
WHERE
	MONTH (transaction_date) IN (4, 5) -- for months of April (PM) and May (CM)
GROUP BY
	MONTH (transaction_date)
ORDER BY
	MONTH(transaction_date);
    
    ##-- 4. Calculation of specific date total ordes,total quantity sold and total sales.
    
SELECT * FROM coffee_shop_sales;    

SELECT
	CONCAT(ROUND(SUM(Unit_price *transaction_qty)/1000,1), 'K') AS Total_sales,
    SUM(transaction_qty) AS Total_qty_sold,
    COUNT(transaction_id) AS Total_Orders
FROM Coffee_shop_sales
WHERE
	transaction_date ='2023-05-18';
    
  
    
    
    ## ---- 5. Sales Analysis on weekdays and weekends
    -- (a) Segmenting sales data  into weekdays and weekends and perfoming analysis on various variations
    
     -- Weekends - Sat and Sun
     -- Weekdays - Mon to Fri
     -- Sun =1, Mon=2......Sat=7
     
     -- For Total sales
     SELECT
		CASE WHEN DAYOFWEEK(transaction_date) in (1,7) THEN 'Weekends'
        ELSE 'Weekdays'
        END AS day_type,
       CONCAT(ROUND( SUM(unit_price*transaction_qty)/1000,1), 'K') AS Total_sales
	FROM Coffee_shop_sales
    WHERE MONTH (transaction_date)=5 -- May
    GROUP BY
		CASE WHEN DAYOFWEEK(transaction_date) IN (1,7) THEN 'weekends'
        ELSE 'weekdays'
        END;
        
        
        ##---- 6. Sales analysis  by store Location
        -- (a) Total sales by store location in a descending order
        -- (Calculation for May)
        
	SELECT * FROM coffee_shop_sales;
    
    SELECT
		Store_location,
       CONCAT(ROUND( SUM(Unit_price * transaction_qty)/1000,2), 'K') AS Total_sales
	FROM Coffee_shop_sales
    WHERE MONTH (transaction_date) = 5 -- May
    GROUP BY store_location
    ORDER BY SUM(unit_price * transaction_qty) DESC;
    
    -- (Calculation for June)
        SELECT
		Store_location,
       CONCAT(ROUND( SUM(Unit_price * transaction_qty)/1000,2), 'K') AS Total_sales
	FROM Coffee_shop_sales
    WHERE MONTH (transaction_date) = 6 -- JUN
    GROUP BY store_location
    ORDER BY SUM(unit_price * transaction_qty) DESC;
    
    ## -- -- 7. Daily Sales Analysis 
    -- (a) Average sales for the month of May.
     
     SELECT
		CONCAT(ROUND(AVG(Total_sales)/1000,1),'K') AS Avg_sales -- we do not have Total_sales, therefore we introduce inner Query.
     FROM 
		(
        SELECT SUM(transaction_qty* unit_price) AS total_sales
        FROM coffee_shop_sales
     WHERE MONTH (transaction_date) =5 -- For May
    GROUP BY transaction_date
    ) AS Internal_query;
    
    ##---(b) Daily Sales for the selected month
    -- Daily total sales for the month of May.
    
SELECT 
	DAY(transaction_date) AS day_of_month,
   CONCAT(ROUND( SUM(Unit_price*transaction_qty)/1000,1),'K') AS Total_sales
FROM  coffee_shop_sales
WHERE MONTH (transaction_date)= 5 -- For May
GROUP BY DAY (transaction_date)
ORDER BY DAY (transaction_date);
    
    ##----8. Sales analysis  by Product Category
    -- (a) Sales per category for the month of June.
    
SELECT 
	product_category,
    CONCAT(ROUND(SUM(UNIT_PRICE*transaction_qty)/1000,0), 'K') AS total_sales
FROM coffee_shop_sales
WHERE MONTH (transaction_date) = 6
GROUP BY product_category
ORDER BY SUM(unit_price*transaction_qty) DESC;

##---9. (a)Top 10 Products by sales

SELECT
	product_type,
    SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH (transaction_date) = 5 
GROUP BY product_type
ORDER BY SUM(unit_price* transaction_qty) DESC
LIMIT 10;
    
   ##...(b).Top 10 for Coffee brand specifically  
   
   SELECT
	product_type,
    SUM(unit_price * transaction_qty) AS total_sales
FROM coffee_shop_sales
WHERE MONTH (transaction_date) = 5 AND product_category= 'coffee'
GROUP BY product_type
ORDER BY SUM(unit_price* transaction_qty) DESC
LIMIT 10;

##---10. Sales Analysis by Month, days and hours

SELECT 
	CONCAT(ROUND(SUM(unit_price * transaction_qty)/1000,0),'K') AS total_sales,
    SUM(transaction_qty) AS Total_qty_sold,
    COUNT(*) AS Total_orders
FROM coffee_shop_sales
WHERE MONTH (transaction_date) = 5 -- May
AND DAYOFWEEK(transaction_date) = 2 -- Monday
AND HOUR (transaction_time) = 8; -- Hour No. 8

