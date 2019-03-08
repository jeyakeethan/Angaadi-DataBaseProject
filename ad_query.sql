select customer.FirstName , orders.order_ID , orders.Order_date, orders.Total_Price
from customer natural join orders ;


---------------------------------------------------

DELIMITER $$

create FUNCTION sales_report(period year) 
returns table
(order_ID int, 
Order_date date,
CustomerName  varchar(255), 
Total_Price  numeric(9,2),
Delivery_Method enum("pay by card","pay on delivery"),
payment_Status enum ( "paid","Not Paid"),
payment_method enum ("pay by card","pay on delivery"),
Address varchar(255),
City varchar(255),
States varchar(255),
Shipping_Status enum ("Processing","delivered")
)
as   
BEGIN
declare table (order_ID,Order_date,CustomerName,Total_Price,Delivery_Method,payment_Status,payment_method,Address,City,States,Shipping_Status)
set table = (SELECT orders.order_ID,orders.Order_date,customer.FirstName ,orders.Total_Price ,orders.Delivery_Method , payment.Payment_status ,payment.Payment_method,orders.Total_Price,shipping_address.Address_Line,shipping_address.City,shipping_address.State,freight_details.Shipping_Status
FROM orders natural join customer natural join shipping_address NATURAL JOIN freight_details Natural JOIN payment;
RETURN table;
end$$
DELIMITER ;



--------------------------------

SELECT category.category_name,count(order_detail.Quantity) as counts
from category natural join category_products NATURAL join product_variant NATURAL join order_detail
group by category.pid;


-------------------------------------------------------------

--have to writrre
DELIMITER $$

create FUNCTION count_stud(course_id varchar(8)) 
returns INT(5) 
BEGIN
declare counts int(5);
set counts = (select count(takes.ID) 
from takes
where takes.course_id=course_id);
RETURN counts;
end$$
DELIMITER ;