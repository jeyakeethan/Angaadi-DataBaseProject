drop database if exists angaadi_users;
CREATE database angaadi_users ;
use angaadi_users;

CREATE TABLE users(
username VARCHAR(20) PRIMARY KEY,
password VARCHAR(256) NOT NULL,
image BLOB
);

drop database if exists angaadi;
CREATE database angaadi ;
use angaadi;

CREATE TABLE `Customer` (
  `customer_ID` int NOT NULL AUTO_INCREMENT,
  `Email_ID` varchar(255),
  `UserName` varchar(255) ,
  `Street_name` varchar(255),
  `City` varchar(255),
  `FirstName` varchar(255),
  `LastName` varchar(255),
  PRIMARY KEY (`customer_ID`) 
);

CREATE TABLE `Orders` (
  `order_ID` int,
  `Total_Price` numeric(9,2),
  `Order_date` datetime,
  `Delivery_Method` enum("Home Delivery","Store Pickup"),
  `customer_ID` int,
  PRIMARY KEY (`order_ID`),
  Foreign KEY (`customer_ID`) references `Customer`(`customer_ID`)
);

CREATE TABLE `Shipping_Address` (
  `order_ID` int,
  `City` varchar(255),
  `Zip_Code` varchar(255),
  `Address_Line1` varchar(255),
  `Address_Line2` varchar(255),
  Primary KEY (`order_ID`),
  Foreign KEY (`order_ID`) references `Orders`(`order_ID`)
);

CREATE TABLE `Payment` (
  `Payment_ID` int,
  `order_Id` int,
  `Payment_method` enum("pay by card","pay on delivery"),
  `Payment_Date` datetime,
  `Payment_status` enum("paid","Not Paid"),
  PRIMARY KEY (`Payment_ID`),
  Foreign KEY (`order_ID`) references `Orders`(`order_ID`)
);

CREATE TABLE `Product` (
  `product_ID` int,
  `product_name` varchar(255),
  `brand` varchar(255),
  PRIMARY KEY (`product_ID`)
);
insert into Product values(10000,'xiaomi Redmi Note 5','Xiaomi');
insert into Product values(10001,'xiaomi Redmi S2','Xiaomi');
insert into Product values(10002,'ASUS FX63VD Notebook','ASUS');
insert into Product values(10003,'ASUS ROG GFX72VM6700','ASUS');
insert into Product values(10004,'Teclast F6 Pro','TECLAST');
insert into Product values(10005,'Xiaomi Mi Notebook Pro','Xiaomi');
insert into Product values(10006,'Y1 M1 Mirrorless Digital Camera','Y1');
insert into Product values(10007,'SONY DSC-W800 20 MP Digital Camera','SONY');
insert into Product values(10008,'PROTAX D7100 33MP Professional DSLR Shape Digital Camera','PROTAX');
insert into Product values(10009,'New Canon EOS 1300D Rebel T6 DSLR Wi-Fi Camera','Canon');
insert into Product values(10010,'HARO BMX Intermediate Street Performance Bike','HARO');
insert into Product values(10011,'X-Front Downhill off-road Bicycle','X-Front');
insert into Product values(10012,'Running Leopard mountain bike','Running Leopard');
insert into Product values(10013,'HONHX Sports Watch','HONHX');
insert into Product values(10014,'SPRAOI 2018 Luxury Sport Watch','SPRAOI');
insert into Product values(10015,'shshd Business Skeleton Watch','shshd');
insert into Product values(10016,'contena 2018 Women Watches Romantic Stainless Steel','contena');
insert into Product values(10017,'PAUL VALENTINE Luxury Quartz Wrist watch','PAUL VALENTINE');
insert into Product values(10018,'Daniel Sabrina 2018 Women Quartz  wrist Watch men Style','Daniel Sabrina');
insert into Product values(10019,'OTOKY 2018 Dress Watches Faux Chronograph Quartz Casual','OTOKY');


CREATE TABLE `Product_Variant` (
  `SKU` int,
  `product_ID` int,
  `order_ID` int,
  `stock` int,
  `unit_Price` numeric(9,2),
  `weight` numeric(5,2),
   `Image` blob,
  PRIMARY KEY (`SKU`),
   Foreign KEY (`product_ID`) references `Product`(`product_ID`)
);



CREATE TABLE `Variant_Detail` (
  `SKU` int,
  `Attribute_Name` varchar(255),
  `Attribute_Value` varchar(255),
  Primary KEY(`SKU`),
  Foreign KEY (`SKU`) references `Product_Variant`(`SKU`)
);


CREATE TABLE `Category` (
  `category_name` varchar(255),
  `sub_category_name` varchar(255),
  PRIMARY KEY (`category_name`,`sub_category_name`)
);

insert into Category values('Cellphones & Telecommunications','Mobile Phones');
insert into Category values('Computer & Office','Gaming Laptops');
insert into Category values('Computer & Office','Laptops');
insert into Category values('Consumer Electronics','Digital Cameras');
insert into Category values('Sports & Entertainment','Bicycle');
insert into Category values('Watches','Men Watches');
insert into Category values('Watches','Women Watches');


CREATE TABLE `Category_Products` (
  `sub_category_name` varchar(255),
  `product_ID`int,
  PRIMARY KEY  (`sub_category_name`, `product_ID`),
  Foreign KEY (`sub_category_name`) references `Category` (`sub_category_name`) ,
  Foreign KEY (`product_ID`) references `Product`(`product_ID`)
);

insert into Category_Products values('Mobile Phones',10000);
insert into Category_Products values('Mobile Phones',10001);
insert into Category_Products values('Gaming Laptops',10002);
insert into Category_Products values('Gaming Laptops',10003);
insert into Category_Products values('Laptops',10004);
insert into Category_Products values('Laptops',10005);
insert into Category_Products values('Digital Cameras',10006);
insert into Category_Products values('Digital Cameras',10007);
insert into Category_Products values('Digital Cameras',10008);
insert into Category_Products values('Digital Cameras',10009);
insert into Category_Products values('Bicycle',10010);
insert into Category_Products values('Bicycle',10011);
insert into Category_Products values('Bicycle',10012);
insert into Category_Products values('Men Watches',10013);
insert into Category_Products values('Men Watches',10014);
insert into Category_Products values('Men Watches',10015);
insert into Category_Products values('Women Watches',10016);
insert into Category_Products values('Women Watches',10017);
insert into Category_Products values('Women Watches',10018);
insert into Category_Products values('Women Watches',10019);


CREATE TABLE `Cart` (
  `Date_Added` datetime,
  `Quantity` int,
  `SKU` int,
  `customer_ID` int,
  Primary KEY(`customer_ID`),
  Foreign KEY(`SKU`) references 'Product_Variant'('SKU'),
  Foreign KEY (`customer_ID`) references `Customer`(`customer_ID`)
);

CREATE TABLE `Freight_Details` (
  `Tracking_ID` int,
  `order_ID` int,
  `Shipping_Status` enum ("Processing","delivered"),
  `Shipping_date` datetime,
  PRIMARY KEY (`Tracking_ID`),
  Foreign KEY (`order_ID`) references `Orders`(`order_ID`)
);




CREATE TABLE `Order_Detail` (
  `SKU` int,
  `order_id` int,
  `Quantity` int,
  Primary KEY  (`SKU`, `order_id`),
  Foreign KEY (`SKU`) references `Product_Variant`(`SKU`)
);

CREATE TABLE `Guest` (
`customer_ID` int NOT NULL AUTO_INCREMENT,
  `Email_ID` varchar(255),
  `UserName` varchar(255) ,
  `FirstName` varchar(255),
  `LastName` varchar(255),
  `Street_name` varchar(255),
  `City` varchar(255),
  `Date_logged_In` datetime,
  PRIMARY KEY (`customer_ID`) 
);


CREATE TABLE `Customer_Telephone` (
  `customer_ID` int,
  `telephone` int,
  PRIMARY KEY `customer_ID`,
   FOREIGN KEY (`customer_ID`) references `Customer`(customer_ID`)
);