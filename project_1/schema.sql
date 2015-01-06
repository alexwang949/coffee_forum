CREATE DATABASE project_1;

CREATE TABLE posts (id serial primary key, user_name text, entry text, category text, date date, photo text, votes integer, post_title text);

CREATE TABLE comments (id serial primary key, user_name text, entry text, post_id integer, date date);

CREATE TABLE categories (id serial primary key, title text, votes integer, description text);


INSERT INTO categories (title, votes, description) VALUES ('v60 brew method', 20, 'discussing a popular brew method');
INSERT INTO categories (title, votes, description) VALUES ('East Village Coffee', 2, 'great coffee shops in the neighborhood');
INSERT INTO categories (title, votes, description) VALUES ('Espresso Extraction', 9, 'techniques and experiences with pulling shots');
INSERT INTO categories (title, votes, description) VALUES ('Latte Art', 9, 'creating amazing art');
INSERT INTO categories (title, votes, description) VALUES ('All Brew Methods', 30, 'experience with any brew method');

INSERT INTO posts (user_name, entry, category, votes, post_title) VALUES ('alexwang38', 'which grind size do you use?', 'v60 methods', 8, 'v60 is the best brew method.');
INSERT INTO posts (user_name, entry, category, votes, post_title) VALUES ('alexwang38', 'which grind size do you use?', 'v60 methods', 8, 'v60 is the best brew method.');





