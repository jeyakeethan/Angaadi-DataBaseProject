drop database if exists angaadi_users;
CREATE database angaadi_users ;
use angaadi_users;

CREATE TABLE users(
customer_ID int,
username varchar(255)not null,
password varchar(255) not null,
image blob,
unique(username),
primary key (username,customer_ID),
foreign key (customer_ID) references Customer(customer_ID)
);

insert into users values('user','27b54f30a9b06e0088912dc786dc3545',null);

drop database if exists angaadi;
CREATE database angaadi ;
use angaadi;

CREATE TABLE Customer (
  customer_ID int NOT NULL AUTO_INCREMENT,
  Email_ID varchar(255) NOT NULL,
  UserName varchar(255) NOT NULL ,
  Street_name varchar(255) NOT NULL,
  City varchar(255) NOT NULL,
  FirstName varchar(255) NOT NULL,
  LastName varchar(255)NOT NULL ,
  PRIMARY KEY (customer_ID)
);

CREATE TABLE Orders (
  order_ID int NOT NULL AUTO_INCREMENT,
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
  ON UPDATE CASCADE,
  
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
  Image blob,
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
  check (Quantity >= 0)
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
  check (Shipping_Status in ("Processing","delivered"))
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

CREATE TABLE Guest (
customer_ID int NOT NULL AUTO_INCREMENT,
  Email_ID varchar(255) not null,
  UserName varchar(255) not null ,
  FirstName varchar(255)not null,
  LastName varchar(255),
  Street_name varchar(255) not null,
  City varchar(255) not null,
  Date_logged_In datetime,
  PRIMARY KEY (customer_ID)
);


CREATE TABLE Customer_Telephone (
  customer_ID int,
  telephone varchar(10),
  PRIMARY KEY (customer_ID,telephone),
   FOREIGN KEY (customer_ID) references Customer(customer_ID)
  ON DELETE CASCADE
   ON UPDATE CASCADE
);





-- =========================================================================
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
---------------------------------------------------

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

-- TRIGGERS
-- ***********************************************************************

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
-----------------------------------------------------------------------

CREATE TRIGGER validate_Stock_insert
BEFORE INSERT ON Product_Variant FOR EACH ROW
BEGIN
	CALL validate_stock(NEW.Stock);
END$$
DELIMITER ;

DELIMITER $$
CREATE TRIGGER validate_Stock_insert
BEFORE UPDATE ON Customer_Telephone FOR EACH ROW
BEGIN
	CALL validate_stock(NEW.Stock);
END$$
DELIMITER ;