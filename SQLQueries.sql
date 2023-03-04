UPDATE customer
SET
	custFirst =	'George',
	custLast =	'McKenna',
	custPhone =	'7058843519',
	custCity =	'Guelph',
	custEmail = 'gmckenna@outlook.com'
WHERE id = 5

UPDATE customer
SET
	custAddress = '526 Whitmore Road'
WHERE id = 9

INSERT INTO customer
	(custFirst, custLast, custPhone, custAddress, custCity, custPostal, custEmail)
VALUES
	('Erin',	'Watss',	'4168400268',	'Whitmore Road',		'Edmonton',		'E5E7U3',	'sgray@gmail.com'),
	('Amber',	'Pearce',		'6042037156',	'117 Sussex Drive',	'Victoria',		'L8G5M1',	'apearce@outlook.com'),
	('Sidney',	'Banks',	'4183515729',	'360 Isabella Street',	'Reed Deer',	'E6E1L9',	'sbanks@hotmail.com'),
	('Jude',	'Keller',		'6042093556',	'21 Leslie Street',	'Arctic Bay',	'N0B2E9',	'jkeller@outlook.com'),
	('Quinn',	'Hunter',		'4183457823',	'255 Pearl Street',	'Summerside',	'L8E2S6',	'qhunter@hotmail.com')

