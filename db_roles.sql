CREATE USER IF NOT EXISTS 'public_access'@'localhost' IDENTIFIED BY '0000';
CREATE USER IF NOT EXISTS 'staff'@'localhost' IDENTIFIED BY '1111';
CREATE USER IF NOT EXISTS 'courier_side'@'localhost' IDENTIFIED BY '2222';
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY '3333';
GRANT SELECT,INSERT,DELETE,UPDATE ON *.* TO 'public_access'@'localhost';

GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi_users.* TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.Product_Variant TO 'public_access'@'localhost';
GRANT SELECT ON angaadi.main_city TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.variant_detail TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.Product TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.category TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.category_products TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.customer TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.guest TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.orders TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.payment TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.shipping_address TO 'public_access'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON angaadi.cart TO 'public_access'@'localhost';

GRANT SELECT,INSERT,DELETE,UPDATE ON *.* TO 'staff'@'localhost';
GRANT SELECT,INSERT,DELETE,UPDATE ON *.* TO 'admin'@'localhost';

GRANT SELECT,INSERT,UPDATE ON angaadi.freight_details TO 'courier_side'@'localhost';
GRANT SELECT,UPDATE ON angaadi.orders TO 'courier_side'@'localhost';




