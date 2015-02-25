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

CREATE TABLE relationships (
    id INTEGER PRIMARY KEY,
    subject varchar(255),
    predicate varchar(255),
    object varchar(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP
);

CREATE TRIGGER relationships_trig AFTER UPDATE ON relationships
BEGIN
    update relationships SET updated_at = datetime('now') WHERE id = NEW.id;
END;

INSERT INTO relationships ('subject','predicate','object') VALUES ('http://www.bbc.co.uk/', 'urn:rel:a', 'urn:type:Website');
INSERT INTO relationships ('subject','predicate','object') VALUES ('http://www.bbc.co.uk/', 'url:rel:mentions', 'http://www.bbc.co.uk/news/');
INSERT INTO relationships ('subject','predicate','object') VALUES ('http://www.bbc.co.uk/news/', 'run:rel:about', 'urn:topic:News');

EOT
