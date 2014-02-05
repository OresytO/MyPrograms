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
('Elsy', 'Home Cherry Hill', 'F, red hare, green ������, huge boots', 'baloons, toy cars'),
('Pickls', 'Jack Green\'s party', 'M, orange hare, blue ������, huge boots', 'mime'),
('Snagls', 'Ball-mart', 'F, yellow �������, red trouses', '�����, umbrella'),
('Mister Hobbo', 'BG Circus', 'M, ������, black hare, small hat', '�������'),
('Clarabell', 'Belmont senior center', 'F, pink hare, big flower, blue ������', '��������, dances'),
('Skooter', 'Oakland hospital', 'M, blue hare, red ������, big nose', 'baloons'),
('Zippo', 'Millstone mall', 'F, orange ������, trouses', 'dances'),
('Baib', 'Earl\'s autos', 'F, pink ������ � ���������', '��������������, toy cars'),
('Bonzo', '', 'M, ������� ������ � �������', 'singing, dances'),
('Snifels', 'Tracy\'s', 'M, ������-���������� ������, long nose', '');

INSERT INTO clown_info
VALUES
('Zippo', 'Millstone mall', 'F, orange ������, trouses', 'dances, singing'); 

INSERT INTO clown_info
VALUES
('Snagls', 'Ball-mart', 'F, yellow �������, blue trouses', '�����, umbrella'); 

INSERT INTO clown_info
VALUES
('Bonzo', 'Dickson park', 'M, ������� ������ � �������', 'singing, dances'); 

INSERT INTO clown_info
VALUES
('Snifels', 'Tracy\'s', 'M, ������-���������� ������, long nose', 'driving a car'); 

INSERT INTO clown_info
VALUES
('Mister Hobbo', 'Erik\'s Grey party', 'M, ������, black hare, small hat', '�������'); 