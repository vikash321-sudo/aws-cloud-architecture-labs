-- Read-only destination checks
USE cafe_db;
SHOW TABLES;
SELECT COUNT(*) AS total_orders FROM `order`;
SELECT COUNT(*) AS total_order_items FROM order_item;
SELECT * FROM `order` WHERE order_number = 25;
SELECT * FROM `order` WHERE order_number = 26;
-- Expected immediately after cutover: 26 orders, 53 items; order 25 = 12.00, order 26 = 3.00.
