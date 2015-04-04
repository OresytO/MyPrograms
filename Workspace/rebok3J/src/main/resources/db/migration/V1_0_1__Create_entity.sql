CREATE TABLE IF NOT EXISTS "status" (
  id                    BIGSERIAL PRIMARY KEY,
  name                  VARCHAR(255) NOT NULL,
  create_date           DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update_timestamp DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "status" CASCADE;
INSERT INTO "status" (name) VALUES
  ('Platinum'),
  ('Gold'),
  ('Silver');

CREATE TABLE IF NOT EXISTS "visitor" (
  id                    BIGSERIAL PRIMARY KEY,
  last_name             VARCHAR(255) NOT NULL,
  first_name            VARCHAR(255) NOT NULL,
  middle_name           VARCHAR(255) NOT NULL,
  phone                 VARCHAR(255),
  email                 VARCHAR(255),
  status_id             INTEGER REFERENCES "status" (id),
  note                  VARCHAR(255),
  sex                   INTEGER      NOT NULL,
  date_of_birth         DATE         NOT NULL,
  create_date           DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update_timestamp DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "visitor" CASCADE;
INSERT INTO "visitor" (last_name, first_name, middle_name, status_id, sex, date_of_birth) VALUES
  ('lozynskyy', 'orest', 'igorovych', 1, 1, '1986-02-21'),
  ('valko', 'seerhiy', 'mukolayovuch', 2, 1, '1987-03-01');

CREATE TABLE IF NOT EXISTS "service" (
  id                      BIGSERIAL PRIMARY KEY,
  name                    VARCHAR(255) NOT NULL,
  type                    VARCHAR(255) NOT NULL,
  lamp_default_resource   INTEGER,
  lamp_time_worked        INTEGER,
  airing_default_resource INTEGER,
  airing_time_worked      INTEGER,
  create_date             DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update_timestamp   DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "service" CASCADE;
INSERT INTO "service" (name, type, lamp_default_resource, lamp_time_worked, airing_default_resource, airing_time_worked)
VALUES
  ('Solar1', 'Solar', 10000, 5000, 25600, 36980),
  ('Solar2', 'Solar', 20000, 3000, 25600, 36980);

CREATE TABLE IF NOT EXISTS "salon" (
  id                    BIGSERIAL PRIMARY KEY,
  name                  VARCHAR(255) NOT NULL,
  address               VARCHAR(255) NOT NULL,
  create_date           DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update_timestamp DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "salon" CASCADE;
INSERT INTO "salon" (name, address) VALUES
  ('Salon1', 'Lviv'),
  ('Salon2', 'Kyiv');

CREATE TABLE IF NOT EXISTS "visit" (
  id                    BIGSERIAL PRIMARY KEY,
  visitor_id            INTEGER REFERENCES "visitor" (id),
  service_id            INTEGER REFERENCES "service" (id),
  date_of_visit         DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  create_date           DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update_timestamp DATE NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "visit" CASCADE;
INSERT INTO "visit" (visitor_id, service_id) VALUES
  (1, 1),
  (1, 2),
  (1, 2),
  (2, 2),
  (2, 2),
  (2, 1);

CREATE TABLE IF NOT EXISTS "service_load_report" (
  id          BIGSERIAL PRIMARY KEY,
  name        VARCHAR(255) NOT NULL,
  create_date DATE         NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "service_load_report" CASCADE;
INSERT INTO "service_load_report" (name) VALUES
  ('Report1'),
  ('Report2');
