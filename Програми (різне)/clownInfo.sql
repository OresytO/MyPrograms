CREATE DATABASE clown;
USE clown;
CREATE TABLE clown_info(
	name VARCHAR(25) NOT NULL,
	lastSeen VARCHAR(100),
	appearance BLOB,
	activities VARCHAR(50)
)DEFAULT CHARACTER SET = cp1251
COLLATE = cp1251_ukrainian_ci;

INSERT INTO clown_info
VALUES
('Elsy', 'Home Cherry Hill', 'F, red hare, green костюм, huge boots', 'baloons, toy cars'),
('Pickls', 'Jack Green\'s party', 'M, orange hare, blue костюм, huge boots', 'mime'),
('Snagls', 'Ball-mart', 'F, yellow рубашка, red trouses', 'рожок, umbrella'),
('Mister Hobbo', 'BG Circus', 'M, сигара, black hare, small hat', 'скрипка'),
('Clarabell', 'Belmont senior center', 'F, pink hare, big flower, blue платье', 'кричалки, dances'),
('Skooter', 'Oakland hospital', 'M, blue hare, red костюм, big nose', 'baloons'),
('Zippo', 'Millstone mall', 'F, orange костюм, trouses', 'dances'),
('Baib', 'Earl\'s autos', 'F, pink костюм с блестками', 'еквилибристика, toy cars'),
('Bonzo', '', 'M, женское платье в горошек', 'singing, dances'),
('Snifels', 'Tracy\'s', 'M, зелено-фиолетовий костюм, long nose', '');

INSERT INTO clown_info
VALUES
('Zippo', 'Millstone mall', 'F, orange костюм, trouses', 'dances, singing'); 

INSERT INTO clown_info
VALUES
('Snagls', 'Ball-mart', 'F, yellow рубашка, blue trouses', 'рожок, umbrella'); 

INSERT INTO clown_info
VALUES
('Bonzo', 'Dickson park', 'M, женское платье в горошек', 'singing, dances'); 

INSERT INTO clown_info
VALUES
('Snifels', 'Tracy\'s', 'M, зелено-фиолетовий костюм, long nose', 'driving a car'); 

INSERT INTO clown_info
VALUES
('Mister Hobbo', 'Erik\'s Grey party', 'M, сигара, black hare, small hat', 'скрипка'); 