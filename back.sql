drop database if exists angaadi_users;

CREATE database angaadi_users ;

use angaadi_users;



CREATE TABLE users(

customer_ID int,

username varchar(255)not null,

password varchar(255) not null,

image longblob,

unique(username),

primary key (username,customer_ID)


);



insert into users values(1,'user','27b54f30a9b06e0088912dc786dc3545',null);



drop database if exists angaadi;

CREATE database angaadi ;

use angaadi;



CREATE TABLE Customer (

  customer_ID int NOT NULL AUTO_INCREMENT,

  Email_ID varchar(255) NOT NULL,

  Street_name varchar(255) NOT NULL,

  City varchar(255) NOT NULL,

  FirstName varchar(255) NOT NULL,

  LastName varchar(255)NOT NULL ,
    
  date_joined date NOT NULL,

  Unique (Email_ID),

  PRIMARY KEY (customer_ID)

);



CREATE TABLE Orders (

  order_id int NOT NULL AUTO_INCREMENT,

  Total_Price numeric(9,2) NOT NULL,

  Order_date datetime NOT NULL ,

  Delivery_Method enum("Home Delivery","Store Pickup"),

  customer_ID int,

  PRIMARY KEY (order_ID),

  Foreign KEY (customer_ID) references Customer(customer_ID)

  ON DELETE CASCADE

  ON UPDATE CASCADE,

  check (Total_Price >= 0),

  check (Delivery_Method in ("Home Delivery","Store Pickup"))

);



CREATE TABLE Shipping_Address (

  FirstName varchar(255) NOT NULL,

  LastName varchar(255) NOT NULL,

  order_ID int,

  City varchar(255),

  State varchar(255),

  Zip_Code varchar(255) NOT NULL,

  Address_Line varchar(255) NOT NULL,

  PhoneNumber INT(15) NOT NULL,

  Primary KEY (order_ID),

  Foreign KEY (order_ID) references Orders(order_ID)

  ON DELETE CASCADE

  ON UPDATE CASCADE

  

);



CREATE TABLE Payment (

  Payment_ID int NOT NULL AUTO_INCREMENT,

  order_Id int,

  Payment_method enum("pay by card","pay on delivery"),

  Payment_Date datetime,

  Payment_status enum("paid","Not Paid"),

  PRIMARY KEY (Payment_ID),

  Foreign KEY (order_ID) references Orders(order_ID)

  ON DELETE CASCADE

  ON UPDATE CASCADE,

  check (Payment_method in ("pay by card","pay on delivery"))

);



CREATE TABLE Product (

  product_ID int NOT NULL AUTO_INCREMENT,

  product_name varchar(255) not null,

  brand varchar(255) not null,

  PRIMARY KEY (product_ID)

);





CREATE TABLE Product_Variant (

  SKU int NOT NULL AUTO_INCREMENT,

  product_ID int,

  Stock int ,

  unit_Price numeric(9,2),

  weight numeric(5,2),

  Image longblob,

  PRIMARY KEY (SKU),

   Foreign KEY (product_ID) references Product(product_ID)

  ON DELETE CASCADE

   ON UPDATE CASCADE,

   check (Stock >=0),

   check (unit_Price > 0),

   check (weight >0)

);





CREATE TABLE Variant_Detail (

  SKU int,

  Attribute_Name varchar(255) not null,

  Attribute_Value varchar(255) not null,

  Primary KEY  (SKU,Attribute_Name),

  Foreign KEY (SKU) references Product_Variant(SKU)

  ON DELETE CASCADE

  ON UPDATE CASCADE

);





CREATE TABLE Category (

  pid int NOT NULL AUTO_INCREMENT,

  category_name varchar(255) not null,

  sub_category_name varchar(255)not null,

  PRIMARY KEY (pid)

);









CREATE TABLE Category_Products (

  pid int,

  product_ID int,

  PRIMARY KEY  (pid, product_ID),

  Foreign KEY (pid) references Category(pid) ,

  Foreign KEY (product_ID) references Product(product_ID)

  ON DELETE CASCADE

   ON UPDATE CASCADE

);







CREATE TABLE Cart (

  Date_Added datetime,

  Quantity int,

  SKU int,

  customer_ID int,

  Primary KEY (customer_ID,SKU),

  Foreign KEY(SKU) references Product_Variant(SKU)

  ON DELETE CASCADE

  ON UPDATE CASCADE,

  Foreign KEY (customer_ID) references Customer(customer_ID)

  ON DELETE CASCADE

  ON UPDATE CASCADE,

  check(Quantity > 0 )

);



CREATE TABLE Freight_Details (

  Tracking_ID int NOT NULL AUTO_INCREMENT,

  order_ID int,

  Shipping_Status enum ("Processing","delivered"),

  Shipping_date datetime,

  PRIMARY KEY (Tracking_ID),

  Foreign KEY (order_ID) references Orders(order_ID)

  ON DELETE CASCADE

  ON UPDATE CASCADE,

  CHECK(Shipping_Status in ("Processing","delivered"))

);





CREATE TABLE Order_Detail(

  SKU int,

  order_id int,

  Quantity int,

  Primary KEY  (SKU, order_id),

  Foreign KEY (SKU) references Product_Variant(SKU)

  ON DELETE CASCADE

  ON UPDATE CASCADE,

  check (Quantity >0)

);







CREATE TABLE Customer_Telephone (

  customer_ID int,

  telephone varchar(10),

  PRIMARY KEY (customer_ID,telephone),

   FOREIGN KEY (customer_ID) references Customer(customer_ID)

  ON DELETE CASCADE

   ON UPDATE CASCADE

);





create table main_city(

    mcity varchar(255) not null

);



CREATE INDEX idx_product

ON product (product_name);





DROP PROCEDURE IF EXISTS validate_phone;

DELIMITER $$

CREATE PROCEDURE validate_phone(

  IN telephone varchar(10)

)

DETERMINISTIC

NO SQL

BEGIN

	IF telephone<100000000 OR telephone>9999999999 THEN

  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Phone Noumber Not Valid';

  END IF;

END$$

DELIMITER ;





DROP PROCEDURE IF EXISTS validate_stock;

DELIMITER $$

CREATE PROCEDURE validate_stock(

  IN Stock int 

  )

DETERMINISTIC

NO SQL

BEGIN

	IF Stock <0 THEN

  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid Stock details';

  END IF;

END$$

DELIMITER ;





DELIMITER $$

CREATE TRIGGER validate_phone_insert

BEFORE INSERT ON Customer_Telephone FOR EACH ROW

BEGIN

	CALL validate_phone(NEW.telephone);

END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER validate_phone_update

BEFORE UPDATE ON Customer_Telephone FOR EACH ROW

BEGIN

	CALL validate_phone(NEW.telephone);

END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER validate_Stock_insert

BEFORE INSERT ON Product_Variant FOR EACH ROW

BEGIN

	CALL validate_stock(NEW.Stock);

END$$

DELIMITER ;



DELIMITER $$

CREATE TRIGGER validate_Stock_update

BEFORE UPDATE ON Product_Variant FOR EACH ROW

BEGIN

	CALL validate_stock(NEW.Stock);

END$$

DELIMITER ;





DELIMITER $$

CREATE PROCEDURE `sales_report`(`period` INT)

BEGIN

SELECT orders.order_ID,orders.Order_date,customer.FirstName ,orders.Total_Price ,orders.Delivery_Method , payment.Payment_status ,payment.Payment_method,orders.Total_Price,shipping_address.Address_Line,shipping_address.City,shipping_address.State,freight_details.Shipping_Status

FROM orders natural join customer natural left outer join shipping_address NATURAL left outer JOIN freight_details Natural left outer JOIN payment where year(orders.Order_date)=period;



end$$

DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE desired_product(period1 date, period2 date)

BEGIN

SELECT product.product_name,SUM(order_detail.Quantity) as amount_sold

from  order_detail NATURAL JOIN  orders NATURAL JOIN product_variant NATURAL JOIN product

where date(orders.Order_date ) between period1 and period2

group by product_id

order by SUM(order_detail.Quantity) DESC;

end$$

DELIMITER ;





DELIMITER $$

CREATE  PROCEDURE product_analytics(product1 varchar(255))

BEGIN

SELECT product.product_name,orders.Order_date,order_detail.Quantity

from product NATURAL JOIN product_variant NATURAL JOIN order_detail NATURAL JOIN  orders

where lower(product.product_name) like concat('%',product1,'%')

order BY order_detail.Quantity DESC;



end$$

DELIMITER ;




create view  customer_order_report as select customer.FirstName , orders.order_ID , orders.Order_date, orders.Total_Price from customer natural join orders;

create view mostly_ordered_category_report as SELECT category.category_name,count(order_detail.Quantity) as counts from category natural join category_products NATURAL join product_variant NATURAL join order_detail group by category.pid;
