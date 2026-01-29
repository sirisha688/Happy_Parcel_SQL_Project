CREATE DATABASE Happy_Parcel;
USE Happy_Parcel;
 ------# CREATED CATEGORIES TABLE ------
CREATE TABLE Categories (
    Category_id INT PRIMARY KEY AUTO_INCREMENT,
    Category_name VARCHAR(50) NOT NULL); 
------# CREATED PRODUCTS TABLE ------
CREATE TABLE Products (
    Product_id INT PRIMARY KEY AUTO_INCREMENT,
    Product_name VARCHAR(100) NOT NULL,
	Category_id INT,
    unit_price DECIMAL(10, 2) ,
    Stock_quantity INT ,
    FOREIGN KEY (Category_id) REFERENCES Categories(Category_id));
------#	CREATED CUSTOMER TABLE ------
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone_number VARCHAR(15));
    
    ------# CREATED ORDER TABLE ------
    CREATE TABLE Orders (
    Order_id INT PRIMARY KEY AUTO_INCREMENT,
    Customer_id INT,
    Product_id INT,
    Order_date DATE NOT NULL,
    Quantity INT,
    Total_amount DECIMAL(10, 2) NOT NULL,
    Order_status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    payment_method varchar(50),
    FOREIGN KEY (Customer_id) REFERENCES Customers(Customer_id),
    FOREIGN KEY (Product_id) REFERENCES Products(Product_id));

ALTER TABLE Categories AUTO_INCREMENT = 1;
ALTER TABLE Products AUTO_INCREMENT = 101;
ALTER TABLE Customers AUTO_INCREMENT = 2001 ;
ALTER TABLE Orders AUTO_INCREMENT = 3001;

INSERT INTO Categories (Category_name) VALUES 
(' Birthday Gifts'),
('Personalized Gifts'),
('valentines Day Gifts'),
('Home Decor'),
('Wedding Gifts');

INSERT INTO Products (Product_name, Category_id, unit_price, Stock_quantity) VALUES
('Chocolate Explosion Box', 1, 500.00, 19),
('Mini Teddy Bear', 1, 249.00, 10),
('Customized Mug', 2, 299.00, 40),
('Scented Candles Set', 4, 750.00, 69),
('Decorative Wall Clock', 4, 1299.00, 40),
('Romantic Couple Figurine', 5, 899.00, 50),
('Heart-Shaped Chocolate Bouquet', 3, 699.00, 80),
('Wedding Gift Hamper', 5, 1599.00, 40),
('Mini Birthday Cupcake Box', 1, 499.00, 10),
('Customized Calendar with Photos', 2, 699.00, 65),
('Wedding Wish Card Set', 5, 149.00, 40),
('Fridge Magnet Quote', 4, 199.00, 110);

INSERT INTO Customers (first_name, last_name, city, email, phone_number)
VALUES
('Aarav', 'Sharma', 'Mumbai', 'aarav.sharma@gmail.com', '9876543210'),
('Priya', 'Mehta', 'Mumbai', 'priya.mehta@gmail.com', '9876501234'),
('Rohit', 'Verma', 'Bangalore', 'rohit.verma@gmail.com', '9867543210'),
('Sneha', 'Patel', 'Ahmedabad', 'sneha.patel@gmail.com', '9898745632'),
('Karan', 'Singh', 'Chennai', 'karan.singh@gmail.com', '9823456789'),
('Ananya', 'Nair', 'Kochi', 'ananya.nair@gmail.com', '9812345678'),
('Rahul', 'Gupta', 'Pune', 'rahul.gupta@gmail.com', '9856743120'),
('Simran', 'Kaur', 'Mumbai', 'simran.kaur@gmail.com', '9876123450'),
('Arjun', 'Reddy', 'Hyderabad', 'arjun.reddy@gmail.com', '9845012345'),
('Neha', 'Kapoor', 'Bangalore', 'neha.kapoor@gmail.com', '9876509876');

INSERT INTO Orders (Customer_id, Product_id, Order_date, Quantity, Total_amount, Order_status, payment_method)
VALUES
(2008, 112, '2025-10-20', 1, 199.00, 'Delivered','UPI'),
(2005, 106, '2025-10-25', 2, 1798.00, 'Pending','UPI'),
(2009, 103, '2025-09-22', 1, 299.00, 'Delivered','COD'),
(2002, 109, '2025-10-21', 1, 499.00, 'Shipped','Net Banking'),
(2007, 103, '2025-10-09', 1, 299.00, 'Delivered','UPI'),
(2001, 108, '2025-08-12', 2, 3198.00, 'Delivered','UPI'),
(2006, 102, '2025-10-15', 1, 249.00, 'Delivered','UPI'),
(2005, 109, '2025-11-05', 1, 499.00, 'Shipped','COD'),
(2004, 111, '2025-10-27', 2, 298.00, 'Shipped','Net Banking'),
(2008, 102, '2025-07-11', 2, 498.00, 'Delivered','UPI'),
(2003, 107, '2025-07-20', 1, 699.00, 'Delivered','UPI'),
(2005, 101, '2025-06-17', 1, 600.00, 'Delivered','UPI'),
(2002, 106, '2025-06-14', 1, 899.00, 'Delivered','UPI'),
(2001, 101, '2025-10-01', 1, 600.00, 'Delivered','COD'),
(2007, 106, '2025-11-10', 1, 899.00, 'Shipped','COD'),
(2008, 107, '2025-11-21', 1, 699.00, 'Pending','UPI'),
(2004, 103, '2025-10-07', 2, 598.00, 'Cancelled','UPI'),
(2003, 104, '2025-09-05', 1, 750.00, 'Delivered','UPI'),
(2001, 111, '2025-08-05', 3, 447.00, 'Delivered','UPI'),
(2002, 101, '2025-11-02', 1, 600.00, 'Pending','COD'),
(2005, 102, '2025-10-29', 2, 498.00, 'Pending','UPI');
 

------#Monthly Sales Trend-----
SELECT DATE_FORMAT(Order_date, '%Y-%M') AS Month,SUM(Total_amount) AS Monthly_Revenue
FROM Orders
WHERE Order_status = 'Delivered'
GROUP BY Month
ORDER BY Month;

------#Top selling products by quantity sold------
SELECT p.Product_name,COUNT(o.Order_id) AS Orders_Count
FROM Orders o
JOIN Products p ON o.Product_id = p.Product_id
GROUP BY p.Product_name
ORDER BY Orders_Count DESC
LIMIT 5;

------# Top 5 Customers by Total Spending------
SELECT c.first_name,c.last_name,SUM(o.Total_amount) AS Total_Spent
FROM Orders o
JOIN Customers c ON o.Customer_id = c.Customer_id
WHERE o.Order_status = 'Delivered'
GROUP BY c.Customer_id
ORDER BY Total_Spent DESC
LIMIT 5;

------# Find Orders Above Average Order Value(AOV) ------
SELECT Order_id,Customer_id,Total_amount
FROM Orders
WHERE Total_amount > (SELECT AVG(Total_amount) FROM Orders);

------#Show category-wise total revenue------
SELECT 
    cat.Category_name, 
    SUM(o.Total_amount) AS Total_Revenue
FROM Orders o
JOIN Products p ON o.Product_id = p.Product_id
JOIN Categories cat ON p.Category_id = cat.Category_id
WHERE o.Order_status = 'Delivered'
GROUP BY cat.Category_name
ORDER BY Total_Revenue DESC;

------#Show products which are out of stock or low in stock (below 20 units)
SELECT * FROM products where stock_quantity<20;

------# Regular customers (more than 2 orders) -------
SELECT c.first_name, c.last_name, COUNT(o.Order_id) AS total_orders
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Customer_id
HAVING COUNT(o.Order_id) > 2
ORDER BY total_orders DESC;

------# most used payment method-----
SELECT payment_method, COUNT(*) AS usage_count
FROM orders
GROUP BY payment_method
ORDER BY usage_count DESC
LIMIT 1;

------# Return Rate (Cancelled Orders %) ------
SELECT ROUND((SUM(CASE WHEN Order_status = 'Cancelled' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),2) AS Return_Rate_Percentage
FROM Orders;

------# City-wise Total Revenue ------
SELECT c.city,SUM(o.Total_amount) AS Total_Revenue,COUNT(o.Order_id) AS Total_Orders
FROM Orders o
JOIN Customers c ON o.Customer_id = c.Customer_id
WHERE o.Order_status = 'Delivered'
GROUP BY c.city
ORDER BY Total_Revenue DESC;

