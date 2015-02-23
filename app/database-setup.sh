#!/bin/bash

DATABASE=curriculum-data.sqlite3.db

sqlite3 $DATABASE << EOT
DROP TABLE IF EXISTS posts;
EOT

sqlite3 $DATABASE << EOT
CREATE TABLE posts (id INTEGER PRIMARY KEY, title varchar(255));
INSERT INTO posts VALUES ('1', 'A post');
INSERT INTO posts VALUES ('2', 'Another post');
INSERT INTO posts VALUES ('3', 'A third post');
EOT
