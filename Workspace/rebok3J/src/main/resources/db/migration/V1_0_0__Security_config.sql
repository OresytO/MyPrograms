CREATE TABLE IF NOT EXISTS "user" (
  id                    BIGSERIAL PRIMARY KEY,
  user_name             VARCHAR(255)        NOT NULL,
  user_nickname         VARCHAR(255) UNIQUE NOT NULL,
  password              VARCHAR(255)        NOT NULL,
  enable                BOOLEAN             NOT NULL,
  create_date           DATE                NOT NULL DEFAULT CURRENT_TIMESTAMP,
  last_update_timestamp DATE                NOT NULL DEFAULT CURRENT_TIMESTAMP
);
TRUNCATE "user" CASCADE;
INSERT INTO "user"(user_name, user_nickname, password, enable)  VALUES
  ('admin', 'admin', 'admin', TRUE),
  ('orest', 'director', 'oresyto', TRUE),
  ('orest', 'manager', 'oresyto', TRUE);

CREATE TABLE IF NOT EXISTS "role" (
  id        BIGSERIAL PRIMARY KEY,
  role_name VARCHAR(255) UNIQUE NOT NULL
);
TRUNCATE "role" CASCADE;
INSERT INTO "role"(role_name) VALUES
  ('ROLE_ADMIN'),
  ('ROLE_DIRECTOR'),
  ('ROLE_MANAGER');

CREATE TABLE IF NOT EXISTS "users_roles" (
  id      BIGSERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES "user" (id),
  role_id INTEGER REFERENCES "role" (id)
);
TRUNCATE "users_roles";
INSERT INTO "users_roles" (user_id, role_id) VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 2),
  (2, 3),
  (3, 3);

