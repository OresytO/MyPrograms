CREATE DATABASE gregs_list;
USE gregs_list;
CREATE TABLE my_contacts
(
	contact_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	last_name VARCHAR(20),
	first_name VARCHAR(30),
	phone VARCHAR(20),
	email VARCHAR(50),
	gender CHAR(1),
	birthday DATE,
	profession VARCHAR(50),
	city VARCHAR(50),
	state CHAR(2),
	status VARCHAR(20),
	interests VARCHAR(100),
	seeking VARCHAR(100)
)ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_ukrainian_ci;
INSERT INTO my_contacts
(last_name, first_name, email, gender, birthday, profession, city, state, status, interests, seeking)
VALUES
(	'Андерсон', 'Джиліан', 'jill_anderson@breakneckpizza.com', 'Ж', '1980-05-09', 'Письменник', 
	'Пало-Альто', 'CA', 'Каяк, тераріум', 'Незаміжня', 'Друзів'
);
INSERT INTO my_contacts
(first_name, email, profession, city, state)
VALUES
('Пет', 'patpost@breakneckpizza.com', 'Листоноша', 'Прінстон', 'NJ');
DESC my_contacts;
SELECT * FROM my_contacts;