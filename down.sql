DROP TABLE IF EXISTS movies;
-- 1

ALTER TABLE movies DROP CONSTRAINT IF EXISTS movies_runtime_check;
ALTER TABLE movies DROP CONSTRAINT IF EXISTS movies_year_check;
ALTER TABLE movies DROP CONSTRAINT IF EXISTS genres_length_check;
-- 2

DROP INDEX IF EXISTS movies_title_idx;
DROP INDEX IF EXISTS movies_genres_idx;
-- 3

DROP TABLE IF EXISTS users;
--4
DROP TABLE IF EXISTS tokens;
--5

DROP TABLE IF EXISTS users_permissions;
DROP TABLE IF EXISTS permissions;
--6
