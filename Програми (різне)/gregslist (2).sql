-- ----------------------------------------------------------------------------------------
-- gregslist.sql
--
-- See gregslist.doc.
-- ----------------------------------------------------------------------------------------

source c:/Users/russ/dev/sql/delete.sql

CREATE TABLE t_gregslist
(
	id				INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
	last_name	VARCHAR(32),
	first_name	VARCHAR(32),
	email			VARCHAR(64),
	gender		CHAR(1),
	birthday		DATE,
	profession	VARCHAR(64),
	location		VARCHAR(64),
	zipcode		VARCHAR(5),
	status		VARCHAR(32),
	interests	VARCHAR(128),
	seeking		VARCHAR(64),
	prof_id		INTEGER,
	zipcode_id	INTEGER,
	status_id	INTEGER
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- As soon as we create some of the other tables, we'll go in and drop zipcode, status, interests, profession and seeking.

-- We'll create the big table with all the fields, then move some of these fields out
-- into the other tables...
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Anderson','Jillian','jill_anderson@breakneckpizza.com','F','1980-09-05','Technical Writer','Palo Alto, CA','94304','single','kayaking, reptiles','relationship, friends');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Kenton','Leo','lkenton@starbuzzcoffee.com','M','1974-01-10','Manager','San Francisco, CA','94118','divorced','women','women to date');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('McGavin','Darrin', 'captainlove@headfirsttheater.com','M','1966-01-23','Cruise Ship Captain','San Diego, CA','92103','single','sailing, fishing, yachting','women for casual relationships');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Franklin','Joe','joe_franklin@leapinlimos.com','M','1977-04-28','Software Sales','Dallas, TX','75204','married','fishing, drinking','new job');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Hamilton','Jamie','dontbother@starbuzzcoffee.com','F','1964-09-10','System Administrator','Princeton, NJ','08540','married','RPG','nothing');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Chevrolet','Maurice','bookman4u@objectville.net','M','1962-07-01','Bookshop Owner','Mountain View, CA','94041','married','collecting books, scuba diving','friends');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Kroger','Renee','poorrenee@mightygumball.net','F','1976-12-03','Unemployed','San Francisco, CA','94118','divorced','cooking','employment');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Mendoza','Angelina','angelina@starbuzzcoffee.com','F','1979-08-19','UNIX Sysadmin','San Francisco, CA','94118','married','acting, dancing','new job');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Murphy','Donald','padraic@tikibeanlounge.com','M','1967-01-23','Computer Programmer','New York City, NY','10007', 'committed relationship','RPG, anime','friends');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ('Spatner','John','jpoet@objectville.net','M','1963-04-18','Salesman','Woodstock, NY','12498','married','poetry, screenwriting','nothing');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode )
	VALUES ('Toth','Anne','Anne_Toth@leapinlimos.com','F','1969-11-18', 'Artist','San Francisco, CA','94118');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode )
	VALUES ('Manson','Anne','am86@objectville.net','F','1977-08-09', 'Baker','Seattle, WA', '98102');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode )
	VALUES ('Hardy','Anne','anneh@b0tt0msup.com','F','1963-04-18', 'Teacher','San Francisco, CA','94118');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode )
	VALUES ('Parker','Anne','annep@starbuzzcoffee.com','F','1983-01-10', 'Student','San Francisco, CA','94118');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode )
	VALUES ('Blunt','Anne','anneblunt@breakneckpizza.com','F','1959-10-09', 'Web Designer','San Francisco, CA','94118');
INSERT INTO t_gregslist ( last_name, first_name, email, gender, birthday, profession, location, zipcode )
	VALUES ('Jacobs','Anne','anne99@objectville.net','F','1968-02-05', 'Computer Programmer','San Jose, CA', '95118');
INSERT INTO t_gregslist ( last_name, first_name, email, gender,  birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ( 'Everett', 'Joan', 'jeverett@mightygumball.net', 'F', '1978-04-03', 'Artist', 'Salt Lake City UT', '84111', 'single', 'sailing, hiking, cooking', 'single man' );
INSERT INTO t_gregslist ( last_name, first_name, email, gender,  birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ( 'Singh', 'Paul', 'ps@tikibeanlounge.com', 'M', '1980-12-10', 'Professor', 'New York, NY', '10007', 'single', 'dogs, spelunking', 'single woman' );
INSERT INTO t_gregslist ( last_name, first_name, email, gender,  birthday, profession, location, zipcode, status, interests, seeking )
	VALUES ( 'Baldwin', 'Tara', 'tara@breakneckpizza.com', 'F', '1970-09-01', 'Chef', 'Boston, MA', '02111', 'single', 'movies, reading, cooking', 'single man' );

SELECT id, last_name, first_name, gender, birthday, profession, location, zipcode, status, interests, seeking, prof_id, zipcode_id, status_id FROM t_gregslist;

source c:/Users/russ/dev/sql/profession.sql
source c:/Users/russ/dev/sql/zipcode.sql
source c:/Users/russ/dev/sql/status.sql
source c:/Users/russ/dev/sql/interest.sql
source c:/Users/russ/dev/sql/seeking.sql

-- Fix-up is mostly done via Java code:
--  Walk t_gregslist and link each row up to t_profession...
--  Walk t_gregslist and link each row up to t_zip_code...
--  Walk t_gregslist and link each row up to t_status...
--  Walk t_gregslist and set up a row in t_contract_interest to point into a t_gregslist row...
--  Walk contact_interest rows and point them to rows in t_interests...
--  Walk t_gregslist and set up a row in t_contract_seeking to point into a t_gregslist row...
--  Walk contact_seeking rows and point them to rows in t_seeking...
source c:/Users/russ/dev/sql/create-other.sql

SELECT * from t_gregslist;
