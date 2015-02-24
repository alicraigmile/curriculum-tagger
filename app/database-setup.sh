#!/bin/bash

DATABASE=curriculum-data.sqlite3.db

sqlite3 $DATABASE << EOT
DROP TABLE IF EXISTS posts;
EOT

sqlite3 $DATABASE << EOT
CREATE TABLE posts (
    id INTEGER PRIMARY KEY,
    title varchar(255),
    body blob,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
);

CREATE TRIGGER your_table_trig AFTER UPDATE ON posts
BEGIN
    update posts SET updated_at = datetime('now') WHERE id = NEW.id;
END;

INSERT INTO posts ('id','title','body') VALUES ('1', 'A post','Blah...');
INSERT INTO posts ('id','title','body') VALUES ('2', 'Another post','Foo bar. Farp.');
INSERT INTO posts ('id','title','body') VALUES ('3', 'A third post','Blah...');

EOT
