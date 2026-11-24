

# Q1 Find the product that has been ordered the most times.

select p.pid, p.name, COUNT(*) AS times_ordered
from Product p
join OrderItem oi
using(pid)
join Contain c
using(itemid)
group by p.pid, p.name
order by times_ordered DESC
limit 1;


#Q2 Find all the orders that were placed for products that are sold by stores in the city of Toronto.

select p.pid,p.name, city 
from product as p
join store as s
using(sid)
where s.city='toronto';

#Q3 Find all the details of the buyers who have a phone number that starts with the contact number 91.
select *
from Users 
join Buyer 
using(userid)
where phoneNumber LIKE '91%';

#Q4 Display the address, starttime and endtime of the service points in the same city as that of  userid 5
SELECT sp.streetaddr AS address,
       sp.startTime,
       sp.endTime
FROM ServicePoint sp
WHERE sp.city = (
    SELECT city
    FROM Address
    WHERE userid = 5
);

#Q5 Display the total quantity of products from store with storeid 8 in the shopping cart

select p.name ,SUM(sc.quantity) AS total_quantity
from Save_to_Shopping_Cart sc
join Product p
using(pid)
where p.sid = 8
group by p.name;

#Q6 Update the payment state of orders to unpaid which were created after year 2017 and with a total amount greater than 50.

update Orders
set paymentState = 'Unpaid'
where creationTime >= '2018-01-01' and totalAmount > 50;
  
#Q7 Update the name and contact phone number of the address where the province is Quebec and city is Montreal.

update Address
set name = 'peter parker', contactPhoneNumber = '495-472-7274'
where province = 'Quebec' and city = 'Montreal';

#Q8 Delete the store which opened before year 2017
delete from Store
where startTime < '2017-01-01';

#Q9 Create a report of all products whose price is above average price using subquery.

select pid,name,brand,type,price
from Product
where price > (select avg(price) from Product);

#Q10 Create a view of all product sales in 201
CREATE VIEW Product_Sales_2016 AS
SELECT p.pid, p.name AS product_name,
	SUM(c.quantity) AS total_quantity_sold,
	SUM(oi.price * c.quantity) AS total_sales
FROM Orders o
JOIN Contain c
    ON o.orderNumber = c.orderNumber
JOIN OrderItem oi
    ON c.itemid = oi.itemid
JOIN Product p
    ON oi.pid = p.pid
WHERE YEAR(o.creationTime) = 2016
GROUP BY p.pid, p.name;

SELECT *
FROM Product_Sales_2016;

#Q11 Retrieve all credit card payments and their associated order information

select *
from Payment p
join CreditCard cc
on p.creditcardNumber = cc.cardNumber
JOIN Orders o
on p.orderNumber = o.orderNumber;

#Q12 Retrieve all stores and their associated managers
SELECT s.sid,
       s.name AS store_name,
       u.userid AS manager_id,
       u.name AS manager_name
FROM Store s
LEFT JOIN Manage m
    ON s.sid = m.sid
LEFT JOIN Seller se
    ON m.userid = se.userid
LEFT JOIN Users u
    ON se.userid = u.userid;
    
#Q13 Query the total quantity of products from store with storeid 8 in the shopping cart using a subquery.

SELECT SUM(quantity) AS total_quantity
FROM Save_to_Shopping_Cart
WHERE pid IN (
    SELECT pid
    FROM Product
    WHERE sid = 8
);
#Q14 Find all sellers who manage more than one store
select u.userid, u.name AS seller_name, COUNT(m.sid) AS stores_managed
from Seller as s
join Users as u
using(userid)
join Manage m
using(userid)
group by u.userid, u.name
having COUNT(m.sid) > 1;

#Q15 Retrieve the names of buyers who have made at least one order and have also left a comment on a product.

select distinct u.userid, u.name 
from buyer as b
join Users as u
using(userid)
join comments as c
using(userid);

# 1 . Display product name, brand, type, and price.
SELECT name, brand, type, price
FROM Product;
  
  
# 2.Find all products manufactured by Asus.
SELECT *
FROM Product
where brand='asus' ;

# 3.Display products whose price is greater than 500.
SELECT name,price 
FROM Product
where price > 500 ;


# 4.Display the five most expensive products.
SELECT price, name 
FROM Product
order by price desc
limit 5 ;


#5.Find users who are both buyers and sellers.
select userid,name 
from users
join seller
using(userid)
join buyer
USING(userid);

#6.Find the maximum and minimum product prices.

select 
min(price) as min_price,
max(price) as max_price
from product;



#7.Find products whose available stock is less than 100.
SELECT name, amount
FROM product
WHERE amount < 100;


#8. Count the number of products available under each brand.
select brand,count(*) as total_product
from product
group by brand;


#9.Find the average product price for each brand.
SELECT brand, avg(price) AS avg_product
FROM product
GROUP BY brand;


# 10 Find the total stock quantity available for each brand.
SELECT brand ,sum(price) AS total_product
FROM product
GROUP BY brand;

#11 Display product categories along with the number of products in each category.
SELECT type,count(*) as total_categories
FROM product
GROUP BY type;


#12Find brands having more than 10 products.
SELECT brand ,count(*) AS total_product
FROM product
GROUP BY brand
having count(*)>10;


#13 Find the brand with the highest average product price.
SELECT brand, avg(price) AS avg_product
FROM product
GROUP BY brand
order by avg(price)
limit 1;



#14 Display all users who are registered as buyers.
select userid, name
from users
join buyer
using(userid);

#15 Display all users who are registered as sellers.
select userid, name
from users
join seller
using(userid);



#16 Display product names along with customer ratings and review comments.
select name ,grade , content
from product
join comments
using(pid);

#17 Find the average rating received by each product.
select pid,name ,avg(grade) as avg_rating 
from product
join comments
using(pid)
group by name,pid ;


#18 Find products that have never received any customer reviews.
SELECT p.pid, p.name
FROM product as  p
LEFT JOIN comments  as c
USING (pid)
WHERE c.pid IS NULL;



#19 Find products whose price is greater than the overall average product price.
select name,price
from product
where price >  (SELECT avg(price) 
FROM product);


#20 Display each order number along with the products included in that order and their quantities.

select o.orderNumber,p.pid,p.name ,c.quantity    
from orders as o
join contain as c
  using(orderNumber)
join orderitem as oi
  using(itemid)
join product as p
  using(pid);



SELECT
    o.orderNumber,
    p.name AS product_name,
    ci.quantity
FROM Orders o
INNER JOIN Contain ci
    ON o.orderNumber = ci.orderNumber
INNER JOIN OrderItem oi
    ON ci.itemid = oi.itemid
INNER JOIN Product p
    ON oi.pid = p.pid;


#21Find the total quantity of products sold for each product.
select  p.pid,  p.name , sum(quantity) as total_quintity
from product as p
join orderitem as oi
on p.pid = oi.pid
join contain as c
on oi.itemid = c.itemid
group by p.pid, p.name;

#22 Rank all products within each brand based on their prices, from highest to lowest, using DENSE_RANK().
select  pid , name , brand ,DENSE_RANK() OVER 
        (PARTITION BY brand 
        ORDER BY price DESC
    ) AS rank_alias
from product;

#23 Find the top three most expensive products in each brand using window functions.
WITH ecpensive_product AS (
	SELECT pid ,name ,brand , price,
	DENSE_RANK() OVER (
	PARTITION BY brand
	ORDER BY price DESC) as top_three
	FROM Product
)
SELECT *
FROM ecpensive_product
WHERE top_three <= 3;

#24 Find the percentage contribution of each brand to the total number of products.
select name ,  pid,count(*) as total_product ,
OVER (  PARTITION BY brand
	ORDER BY price DESC
from product);

#25 Identify products whose prices are higher than the average price of their respective product categories.
select p.name ,p.pid,p.type,p.price
from product as p
where p.price> (select avg(price) as avg_price
from product as p2
where p2.type=p.type);


#26 Find the most reviewed product using the Comments table.
select p.name ,p.pid,count(*) as total_product
from product as p
join comments as c
using(pid)
group by p.pid,p.name 
order by total_product desc;


#27 Calculate the total order value for each payment status and display the percentage contribution of each status to the overall order value. 
select sum(totalamount) as total_order,paymentstate
from orders
group by paymentstate;

#28 Find orders containing products from more than one brand.
select o.orderNumber,count(DISTINCT  p.brand) as total_order,GROUP_CONCAT(DISTINCT p.name) AS product_names
from product as p
join orderitem as oi
using(pid)
join contain as c
using(itemid)
join orders as o
using(ordernumber)
group by  o.ordernumber
having count(distinct p.brand)> 1;





#29 Find the store with the highest total inventory value.
select s.sid,s.name ,sum(p.amount*p.price) as highest_price
from store as s 
join product as p
using(sid)
group by s.sid
order by highest_price desc
limit 1;


#30 Using a CTE, calculate the average product price for each brand and 
# display only brands whose average price is above the overall average product price.

with avrage_product_price as  
       (select brand, avg(price) as avg_price 
		from product
		group by brand)
select  brand, avg_price
from avrage_product_price
    where avg_price > (select avg(price) as avg_price 
		from product)
;



#31 Find the total revenue generated by each product category.
SELECT p.type, SUM(c.quantity * p.price) AS total_revenue
FROM product AS p
JOIN orderitem AS oi
ON p.pid = oi.pid
JOIN contain AS c
ON oi.itemid = c.itemid
GROUP BY p.type;

#32 Find the total number of products available in each color.
SELECT color,COUNT(pid) AS total_products
FROM product
GROUP BY color;

#33 Find the highest-priced product under each brand.
SELECT brand, name, price
FROM product AS p
WHERE price = (
    SELECT MAX(price)
    FROM product
    WHERE brand = p.brand);

#34 Display all products along with their review counts, including products without reviews.
SELECT p.pid, p.name, COUNT(c.pid) AS total_reviews
FROM product AS p
LEFT JOIN comments AS c
USING (pid)
GROUP BY p.pid, p.name;

#35 Display each order with its products and payment status.
SELECT o.orderNumber, p.name,pay.paymentStatus
FROM orders AS o
JOIN contain AS c
  USING (orderNumber)
JOIN orderitem AS oi
  USING (itemid)
JOIN product AS p
  USING (pid)
LEFT JOIN payments AS pay
 USING (orderNumber);

#36 Display buyers who have saved at least one product in their shopping cart.
SELECT DISTINCT b.userid,b.name
FROM buyer AS b
JOIN cart AS c
USING (userid);

#37 Find the second most expensive product in each category.
WITH product_rank AS (SELECT name, type,price,
        DENSE_RANK() OVER ( PARTITION BY type ORDER BY price DESC ) AS price_rank
    FROM product )
SELECT name,type,price
FROM product_rank
WHERE price_rank = 2;

#38 Find customers whose total quantity of cart items is greater than the average cart quantity per buyer.
WITH buyer_cart AS (SELECT userid, SUM(quantity) AS total_quantity
FROM cart
GROUP BY userid)
SELECT userid, total_quantity
FROM buyer_cart
WHERE total_quantity > (
    SELECT AVG(total_quantity)
    FROM buyer_cart
);

#39 Display each order with its total number of items and calculated order value.
SELECT c.orderNumber, SUM(c.quantity) AS total_items, SUM(c.quantity * p.price) AS order_value
FROM contain AS c
JOIN orderitem AS oi
USING (itemid)
JOIN product AS p
USING (pid)
GROUP BY c.orderNumber;

#40 Find buyers who have reviewed products from at least two different brands.
SELECT c.userid,COUNT(DISTINCT p.brand) AS total_brands
FROM comments AS c
JOIN product AS p
USING (pid)
GROUP BY c.userid
HAVING COUNT(DISTINCT p.brand) >= 2;

#41 Find stores whose total inventory value is greater than the average inventory value of all stores.
WITH store_inventory AS ( 
    SELECT sid,SUM(amount * price) AS inventory_value
    FROM Product
    GROUP BY sid)
SELECT sid,
    inventory_value
FROM store_inventory
WHERE inventory_value > (
    SELECT AVG(inventory_value)
    FROM store_inventory
);

#42 Display payment details with the buyer's name, bank name, and payment date.
SELECT
    pay.*,
    b.name AS buyer_name,
    pay.bankName,
    pay.paymentDate
FROM Payments AS pay
JOIN Buyer AS b
    ON pay.userid = b.userid;

#43 Calculate the number of days taken to deliver each order.
SELECT
    orderNumber,
    DATEDIFF(deliveryDate, orderDate) AS delivery_days
FROM Orders;

#44 Calculate monthly revenue using order-item creation dates.
SELECT
    YEAR(oi.creationTime) AS sales_year,
    MONTH(oi.creationTime) AS sales_month,
    SUM(oi.price * c.quantity) AS monthly_revenue
FROM OrderItem oi
JOIN Contain c ON oi.itemid = c.itemid
GROUP BY YEAR(oi.creationTime), MONTH(oi.creationTime)
ORDER BY sales_year, sales_month;


#45 Calculate cumulative revenue over time, based on order dates.
WITH daily_revenue AS (
    SELECT
        o.creationTime,
        SUM(oi.price * c.quantity) AS revenue
    FROM Orders AS o
    JOIN Contain AS c
        ON o.orderNumber = c.orderNumber
    JOIN OrderItem AS oi
        ON c.itemid = oi.itemid
    GROUP BY o.creationTime
)
SELECT
    creationTime,
    revenue,
    SUM(revenue) OVER (
        ORDER BY creationTime
    ) AS cumulative_revenue
FROM daily_revenue
ORDER BY creationTime;

#46 Find the highest-revenue product in each category using a CTE and window function
WITH product_revenue AS (
    SELECT
        p.pid,
        p.name,
        p.type,
        SUM(oi.price * c.quantity) AS total_revenue
    FROM Product AS p
    JOIN OrderItem AS oi
        ON p.pid = oi.pid
    JOIN Contain AS c
        ON oi.itemid = c.itemid
    GROUP BY
        p.pid,
        p.name,
        p.type
),
ranked_products AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY type
            ORDER BY total_revenue DESC
        ) AS revenue_rank
    FROM product_revenue
)
SELECT
    pid,
    name,
    type,
    total_revenue
FROM ranked_products
WHERE revenue_rank = 1;

#47 Find each brand's highest-priced product and display its rank using window function
SELECT
    brand,
    name,
    price,
    RANK() OVER (
        PARTITION BY brand
        ORDER BY price DESC
    ) AS price_rank
FROM Product;

#48 Find the total revenue generated by each product.
SELECT
    p.pid,
    p.name,
    SUM(oi.price * c.quantity) AS total_revenue
FROM Product AS p
JOIN OrderItem AS oi
    ON p.pid = oi.pid
JOIN Contain AS c
    ON oi.itemid = c.itemid
GROUP BY
    p.pid,
    p.name;

#49 Calculate total inventory value for each store and display stores with inventory value above 50,000.
SELECT
    sid,
    SUM(amount * price) AS inventory_value
FROM Product
GROUP BY sid
HAVING SUM(amount * price) > 50000;

#50 Create a comprehensive product performance report.
WITH product_sales AS (
    SELECT
        oi.pid,
        SUM(c.quantity) AS total_sold,
        SUM(oi.price * c.quantity) AS total_revenue
    FROM OrderItem AS oi
    JOIN Contain AS c
        ON oi.itemid = c.itemid
    GROUP BY oi.pid
),
product_reviews AS (
    SELECT
        pid,
        COUNT(*) AS total_reviews
    FROM Comments
    GROUP BY pid
)
SELECT
    p.pid,
    p.name,
    p.brand,
    p.type,
    p.price,
    p.amount AS available_stock,
    COALESCE(ps.total_sold, 0) AS total_sold,
    COALESCE(ps.total_revenue, 0) AS total_revenue,
    COALESCE(pr.total_reviews, 0) AS total_reviews
FROM Product AS p
LEFT JOIN product_sales AS ps
    ON p.pid = ps.pid
LEFT JOIN product_reviews AS pr
    ON p.pid = pr.pid;
    
    # 51 Create a trigger to prevent inserting a product with a negative price.
DELIMITER //
CREATE TRIGGER check_product_price
BEFORE INSERT ON Product
FOR EACH ROW
BEGIN
    IF NEW.price < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Product price cannot be negative';
    END IF;
END //
DELIMITER ;


# 52 Ensure that a comment's grade is between 1 and 5.

DELIMITER //

CREATE TRIGGER validate_comment_grade
BEFORE INSERT ON Comments
FOR EACH ROW
BEGIN
    IF NEW.grade < 1 OR NEW.grade > 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Grade must be between 1 and 5';
    END IF;
END //

DELIMITER ;
