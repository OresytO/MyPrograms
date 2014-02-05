CREATE DATABASE drinks;
USE drinks;
CREATE TABLE easyDrinks
(
	drinkName VARCHAR(30) NOT NULL,
	main VARCHAR(30) NOT NULL,
	amount1 DEC(3,2) NOT NULL,
	second VARCHAR(30) NOT NULL,
	amount2 DEC(3,2) NOT NULL,
	direction BLOB
);
INSERT INTO easyDrinks
VALUES
('Ternovnik', 'Tonic', 1.5, 'peanapple juice', 1, 'shake whith ice, put into glasess, decore with lemon'),
('Blue moon', 'Soda', 1.5, 'blackbeary juice', 0.75, 'shake whith ice, put into glasess, decore with lemon'),
('Take that', 'Pearch juice', 1, 'peanapple juice', 1, 'shake whith ice, put into glasess'),
('Lime fizz', 'Sprit', 1.5, 'lime juice', 0.75, 'shake whith ice, put into glasess'),
('The kiss', 'Cherry', 2, 'abrucos juice', 7, 'put with ice and piepe'),
('Hot gold', 'Pearch juice', 3, 'orange juice', 6, 'put hot orange juice into the glass, add pearche juice'),
('Loenly tree', 'Soda', 1.5, 'cherry juice', 0.75, 'shake whith ice, put into glasess'),
('Dog', 'Soda', 1.5, 'greapfruit juice', 5, 'shake whith ice, acuratly shake'),
('Autumn', 'apple juice', 2, 'hot tea', 6, 'put the juice in glass, add hot tea'),
('Frog', 'Cold tea', 1.5, 'Lemonad', 5, 'give on ice with slice of lime'),
('Soda plus', 'Soda', 2, 'vine juice', 1, 'shake into glass, give without ice'); 

SELECT * FROM easyDrinks;

SELECT * FROM easyDrinks WHERE main = 'Sprit';
SELECT * FROM easyDrinks WHERE main = 'Soda';
SELECT * FROM easyDrinks WHERE amount2 = 6;
SELECT * FROM easyDrinks WHERE second = 'orange juice';
SELECT * FROM easyDrinks WHERE amount1 < 1.5;
SELECT * FROM easyDrinks WHERE amount2 < '1';
SELECT * FROM easyDrinks WHERE main > 'Soda';
SELECT * FROM easyDrinks WHERE amount1 = '1.5';

SELECT drinkName, main, second FROM easyDrinks WHERE main = 'Soda';