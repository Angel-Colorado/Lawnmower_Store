﻿INSERT INTO receipt
	(ordNumber,	ordDate, ordPaid, paymentID, custID, empID)
VALUES
	('4', '2022-01-29', 1, 5, 1, 1),
	('5', '2022-02-02', 0, 1, 2, 3),
	('6', '2021-12-24', 1, 2, 3, 4),
	('7', '2020-08-28', 1, 3, 8, 5),
	('8', '2020-01-19', 1, 4, 4, 7),
	('9', '2021-05-01', 1, 4, 7, 6),
	('10', '2022-03-06', 1, 1, 3, 4),
	('11', '2022-09-01', 0, 2, 4, 2),
	('12', '2022-02-05', 0, 3, 4, 2)



INSERT INTO order_line
	(orlPrice, orlQuantity, orlOrderReq, orlNote, inventoryID, receiptID)
VALUES
	(	4.95,	1,	0,	'None',		1,	28),
	(	8.95,	2,	0,	'None',		2,	28),
	(	12.95,	6,	0,	'None',		3,	28),
	(	5.00,	4,	0,	'None',		4,	28),
	(	7.45,	3,	0,	'None',		5,	29),
	(	37.95,	8,	0,	'None',		6,	29),
	(	25.00,	7,	0,	'None',		7,	29),
	(	1.00,	8,	0,	'None',		8,	29),
	(	4.50,	9,	0,	'None',		9,	29),
	(	2.95,	1,	0,	'None',		10,	1),
	(	4.95,	2,	0,	'None',		11,	2),
	(	6.99,	3,	0,	'None',		2,	3),
	(	38.50,	4,	0,	'None',		3,	1),
	(	19.29,	5,	0,	'None',		5,	27)
