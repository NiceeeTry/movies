CREATE TABLE IF NOT EXISTS movies (
id bigserial PRIMARY KEY,
created_at timestamp(0) with time zone NOT NULL DEFAULT NOW(),
title text NOT NULL,
year integer NOT NULL,
runtime integer NOT NULL,
genres text[] NOT NULL,
version integer NOT NULL DEFAULT 1
);
-- 1


ALTER TABLE movies ADD CONSTRAINT movies_runtime_check CHECK (runtime >= 0);
ALTER TABLE movies ADD CONSTRAINT movies_year_check CHECK (year BETWEEN 1888 AND date_part('year', now()));
ALTER TABLE movies ADD CONSTRAINT genres_length_check CHECK (array_length(genres, 1) BETWEEN 1 AND 5);
-- 2

CREATE INDEX IF NOT EXISTS movies_title_idx ON movies USING GIN (to_tsvector('simple', title));
CREATE INDEX IF NOT EXISTS movies_genres_idx ON movies USING GIN (genres);
-- 3

CREATE TABLE IF NOT EXISTS users (
id bigserial PRIMARY KEY,
created_at timestamp(0) with time zone NOT NULL DEFAULT NOW(),
name text NOT NULL,
email citext UNIQUE NOT NULL,
password_hash bytea NOT NULL,
activated bool NOT NULL,
version integer NOT NULL DEFAULT 1
);
--4

CREATE TABLE IF NOT EXISTS tokens (
hash bytea PRIMARY KEY,
user_id bigint NOT NULL REFERENCES users ON DELETE CASCADE,
expiry timestamp(0) with time zone NOT NULL,
scope text NOT NULL
);
--5

CREATE TABLE IF NOT EXISTS permissions (
id bigserial PRIMARY KEY,
code text NOT NULL
);
CREATE TABLE IF NOT EXISTS users_permissions (
user_id bigint NOT NULL REFERENCES users ON DELETE CASCADE,
permission_id bigint NOT NULL REFERENCES permissions ON DELETE CASCADE,
PRIMARY KEY (user_id, permission_id)
);
-- Add the two permissions to the table.
INSERT INTO permissions (code)
VALUES
('movies:read'),
('movies:write');
--6