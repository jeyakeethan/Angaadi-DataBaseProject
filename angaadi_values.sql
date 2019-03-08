
insert into customer(customer_ID) values (1);

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


insert into Category values(1,'Cell and Telecom','Mobile Phones');
insert into Category values(2,'Computer and Office','Gaming Laptops');
insert into Category values(3,'Computer and Office','Laptops');
insert into Category values(4,'Consumer Electronics','Digital Cameras');
insert into Category values(5,'Sports and Entert','Bicycle');
insert into Category values(6,'Watches','Men Watches');
insert into Category values(7,'Watches','Women Watches');


insert into Category_Products values(1,10000);
insert into Category_Products values(1,10001);
insert into Category_Products values(2,10002);
insert into Category_Products values(2,10003);
insert into Category_Products values(3,10004);
insert into Category_Products values(3,10005);
insert into Category_Products values(4,10006);
insert into Category_Products values(4,10007);
insert into Category_Products values(4,10008);
insert into Category_Products values(4,10009);
insert into Category_Products values(5,10010);
insert into Category_Products values(5,10011);
insert into Category_Products values(5,10012);
insert into Category_Products values(6,10013);
insert into Category_Products values(6,10014);
insert into Category_Products values(6,10015);
insert into Category_Products values(7,10016);
insert into Category_Products values(7,10017);
insert into Category_Products values(7,10018);
insert into Category_Products values(7,10019);

insert into Product_Variant values(20000,10000,10,20000.00,0.30,'https://goo.gl/images/S5mZgE');


insert into Variant_Detail values (20000,'memory','64GB');
insert into Variant_Detail values (20000,'colour','black');

insert into cart values('10-10-10',2,20000,1);

