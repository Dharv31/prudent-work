create database task2

use task2



CREATE TABLE CUSTOMERS (
	CUSTOMER_ID INT PRIMARY KEY,
	CUSTOMER_NAME VARCHAR(100),
	EMAIL VARCHAR(255),
	PHONE_NUMBER VARCHAR(255),
	ADDRESS VARCHAR(255)
);


CREATE TABLE PRODUCTS (
	PRODUCT_ID INT PRIMARY KEY,
	PRODUCT_NAME VARCHAR(100),
	DESCRIPTION VARCHAR(255),
	PRICE DECIMAL(10, 2),
	STOCK_QUANTITY INT,
	CATEGORY VARCHAR(100),
	DATE_ADDED DATE
);

CREATE TABLE ORDERS (
	ORDER_ID INT PRIMARY KEY,
	CUSTOMER_ID INT FOREIGN KEY REFERENCES CUSTOMERS(CUSTOMER_ID),
	ORDER_DATE DATE,
	TOTAL_AMOUNT INT,
	STATUS VARCHAR(255),
);


CREATE TABLE ORDERITEMS (
	ORDER_ITEM_SET INT PRIMARY KEY,
	ORDER_ID INT FOREIGN KEY REFERENCES ORDERS(ORDER_ID),
	PRODUCT_ID INT FOREIGN KEY REFERENCES PRODUCTS(PRODUCT_ID),
	QUANTITY INT,
	PRICE DECIMAL(10, 2),
);

SELECT * FROM CUSTOMERS
SELECT * FROM PRODUCTS
SELECT * FROM ORDERS
SELECT * FROM ORDERITEMS

SELECT * FROM ORDERS WHERE ORDER_ID = 3

ALTER TABLE CUSTOMERS
ALTER COLUMN PHONE_NUMBER VARCHAR(255)

ALTER TABLE ORDERS
ALTER COLUMN TOTAL_AMOUNT DECIMAL(10, 2)

INSERT INTO CUSTOMERS 
VALUES
(1,'ABC', 'abc@mail.com', '1234567890', '123 St Ahmedabad'),
(2,'DEF', 'def@mail.com', '9876543210', '456 Lane Mumbai'),
(3,'GHI', 'ghi@mail.com', '4567890123', '789 St Pune'),
(4,'JKL', 'jkl@mail.com', '7890123456', '101 Lane Banglore'),
(5,'MNO', 'mno@mail.com', '1237890456', '202 St Ahmedabad')

INSERT INTO PRODUCTS 
VALUES
(1,'Laptop', 'High performance Laptop', 59999, 50, 'Electronics', '2025-01-01'),
(2,'Smartphone', 'Latest smartphone', 49999, 100, 'Electronics', '2025-01-02'),
(3,'Office Chair', 'office desk chair', 14999, 150, 'Furniture', '2025-01-03'),
(4,'Keyboard', 'Machanical Keyword', 999, 200, 'Electronics', '2025-01-04'),
(5,'Bluetooth Speaker', 'Wireless Bluetooth speaker', 4999, 250, 'Electronics', '2025-01-05')

INSERT INTO ORDERS
VALUES
(1,5, '2025-01-11', 59999, 'Shipped'),
(2,2, '2025-01-12', 49999, 'Delivered'),
(3,3, '2025-01-13', 14999, 'Cancelled'),
(4,4, '2025-01-14', 999, 'Shipped'),
(5,5, '2025-01-15', 4999, 'Delivered')

INSERT INTO ORDERITEMS 
VALUES
(1,1, 1, 1, 59999),
(2,1, 5, 1, 4999),
(3,2, 2, 1, 49999),
(4,2, 3, 1, 14999),
(5,3, 1, 2, 59999)


-- 1. Retrieve all customer details.

SELECT * FROM CUSTOMERS

-- 2. Retrieve all products with a price greater than 100.

SELECT PRODUCT_ID, PRODUCT_NAME 
FROM PRODUCTS
WHERE PRICE > 100;

-- 3. Retrieve the names of customers along with the products they ordered.

SELECT CUSTOMER_NAME, PRODUCT_NAME
FROM CUSTOMERS
JOIN ORDERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
JOIN ORDERITEMS ON ORDERITEMS.ORDER_ID = ORDERS.ORDER_ID
JOIN PRODUCTS ON PRODUCTS.PRODUCT_ID = ORDERITEMS.PRODUCT_ID

-- 4. Retrieve the total number of orders placed by each customer.

SELECT COUNT(O.ORDER_ID) AS TOTAL_ORDERS, C.CUSTOMER_NAME, C.CUSTOMER_ID
FROM ORDERS O
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_NAME, C.CUSTOMER_ID

-- 5. Retrieve the total amount spent by each customer.

SELECT SUM(TOTAL_AMOUNT) AS TOTAL_AMOUNT_SPENT, C.CUSTOMER_NAME, C.CUSTOMER_ID
FROM ORDERS O
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_NAME, C.CUSTOMER_ID

 -- 6.Retrieve products sorted by their price in descending order.

SELECT PRODUCT_NAME, PRICE
FROM PRODUCTS
ORDER BY PRICE DESC


-- 7.Find the customers who have placed an order totaling more than 200.

SELECT CUSTOMER_NAME, TOTAL_AMOUNT
FROM CUSTOMERS
JOIN ORDERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.CUSTOMER_ID
WHERE TOTAL_AMOUNT > 200


-- 8. Retrieve products that have less than 10 units available in stock.

INSERT INTO PRODUCTS
VALUES(6, 'Smartwatch', 'Smartwatch with bluetooth calling', 1999, 5, 'Wearable', '2025-01-25' )

SELECT PRODUCT_NAME, PRODUCT_ID
FROM PRODUCTS
WHERE STOCK_QUANTITY < 10

-- 9. Retrieve orders where the total amount is between 100 and 500.

SELECT ORDER_ID 
FROM ORDERS
WHERE TOTAL_AMOUNT BETWEEN 100 AND 500

-- 10. Retrieve products that have been ordered in the last 30 days, including product name and quantity ordered.

SELECT PRODUCT_NAME, QUANTITY
FROM PRODUCTS
JOIN ORDERITEMS ON ORDERITEMS.PRODUCT_ID = PRODUCTS.PRODUCT_ID
JOIN ORDERS ON ORDERS.ORDER_ID = ORDERITEMS.ORDER_ID
WHERE ORDERS.ORDER_DATE >= GETDATE() - 30

-- 11. Retrieve customers who have placed more than 1 order.

SELECT C.CUSTOMER_ID, C.CUSTOMER_NAME, COUNT(ORDER_ID) AS PLACED_ORDER
FROM CUSTOMERS C
JOIN ORDERS ON ORDERS.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME
HAVING COUNT(ORDER_ID) > 1

-- 12. Calculate the average order value for each customer.

SELECT AVG(TOTAL_AMOUNT) AS AVERAGE_ORDER_VALUE, C.CUSTOMER_ID, C.CUSTOMER_NAME
FROM ORDERITEMS OI
JOIN ORDERS O ON O.ORDER_ID = OI.ORDER_ID
JOIN CUSTOMERS C ON C.CUSTOMER_ID = O.CUSTOMER_ID
GROUP BY C.CUSTOMER_ID, C.CUSTOMER_NAME

-- 13. Retrieve orders that contain more than one product.

SELECT COUNT(P.PRODUCT_ID) AS TOTAL_PRODUCT
FROM PRODUCTS P
JOIN ORDERITEMS O ON O.PRODUCT_ID = P.PRODUCT_ID
GROUP BY ORDER_ID
HAVING COUNT(P.PRODUCT_ID) > 1


-- 14. Find Orders with Discounts Greater Than 20% (Using a Function)

CREATE FUNCTION GreaterDiscount(@order_id INT)
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @total_amount DECIMAL(10, 2);
	DECLARE @order_items_total DECIMAL(10, 2);

	SELECT @total_amount = TOTAL_AMOUNT
	FROM ORDERS
	WHERE ORDER_ID = @order_id
	
	SELECT @order_items_total = sum(OI.QUANTITY * OI.PRICE)
	FROM ORDERITEMS OI
	WHERE OI.ORDER_ID = @order_id

	RETURN ((@total_amount - @order_items_total) / @total_amount) * 100;
END

SELECT O.ORDER_ID, O.TOTAL_AMOUNT, dbo.GreaterDiscount(O.ORDER_ID) AS TOTAL_DISCOUNT
FROM ORDERS O
WHERE dbo.GreaterDiscount(O.ORDER_ID) > 20;


-- 15.Create a stored procedure to add a new product.

CREATE PROCEDURE AddingNewProduct
@productid int ,
	@product_name VARCHAR(255),
	@price DECIMAL(10, 2),
	@stockquantity INT
AS
BEGIN
	INSERT INTO PRODUCTS( PRODUCT_ID ,PRODUCT_NAME, PRICE, STOCK_QUANTITY)
	VALUES( @productid ,@product_name, @price, @stockquantity)
END

EXEC dbo.AddingNewProduct 10,'Mouse', 899, 10;


-- 16.Create a trigger to update product stock when an order is placed.

CREATE TRIGGER UpdateProductStock
ON ORDERITEMS
AFTER INSERT
AS
BEGIN
	DECLARE @product_id INT,  @ordered_quantity INT

	SELECT @product_id = PRODUCT_ID
	FROM inserted

	UPDATE PRODUCTS
	SET STOCK_QUANTITY = STOCK_QUANTITY - @ordered_quantity
	FROM PRODUCTS
	WHERE PRODUCT_ID = @product_id
END


-- 17.Create a function to calculate a discount based on the total order amount.

CREATE FUNCTION calculateDiscount(@TOTAL_ORDER DECIMAL(10, 2))
RETURNS DECIMAL(10, 2)
AS
BEGIN
	DECLARE @DISCOUNT DECIMAL(10, 2);

	IF @TOTAL_ORDER > 50000
		SET @DISCOUNT = @TOTAL_ORDER * 0.2;
	ELSE 
		IF @TOTAL_ORDER > 30000
		SET @DISCOUNT = @TOTAL_ORDER * 0.1;
	ELSE 
		SET @DISCOUNT = 0;

	RETURN @DISCOUNT;
END


SELECT ORDER_ID, TOTAL_AMOUNT, dbo.calculateDiscount(TOTAL_AMOUNT) AS DISCOUNT
FROM ORDERS;


-- 18.Create a Stored procedure to update the order status to "Shipped" once the order is shipped.

CREATE PROCEDURE UpdateOrderStatus
	@order_id INT
AS
BEGIN
	UPDATE ORDERS
	SET STATUS = 'SHIPPED'
	WHERE ORDER_ID = @order_id
END

EXEC dbo.UpdateOrderStatus 3;


-- 19.Create a trigger that prevents order if stock_quantity is 0.

CREATE TRIGGER preventOrder
ON ORDERITEMS
FOR INSERT
AS
BEGIN
	DECLARE @PRODUCT_ID INT;
	DECLARE @QUANTITY INT;

	SELECT @PRODUCT_ID = PRODUCT_ID, @QUANTITY = QUANTITY
	FROM INSERTED

	IF(SELECT STOCK_QUANTITY 
		FROM PRODUCTS
		WHERE PRODUCT_ID = @PRODUCT_ID) < @QUANTITY
		BEGIN 
			RAISERROR('OUT OF STOCK',16,1)
			ROLLBACK;
		END
END;


-- 20.Delete Products with No Orders.

DELETE P
FROM PRODUCTS P
LEFT JOIN ORDERITEMS ON ORDERITEMS.PRODUCT_ID = P.PRODUCT_ID
WHERE ORDER_ID IS NULL

