PRAGMA foreign_keys = ON;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname TEXT NOT NULL,
  lname TEXT NOT NULL,
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (

  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);


CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  replies_id INTEGER,
  questions_id INTEGER NOT NULL,

  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (replies_id) REFERENCES replies(id),
  FOREIGN KEY (questions_id) REFERENCES questions(id)
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  likes INTEGER,
  questions_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (questions_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES user(id)
);

INSERT INTO 
  users (fname, lname)
VALUES
  ('AJ', 'Ulcena'),
  ('Zi', 'Tan');

INSERT INTO
  questions (title, body)  
VALUES
  ('Lunch?', 'Anyone want to get lunch?'),
  ('study?', 'Anyone want to study?');

INSERT INTO
  replies (body, user_id, questions_id)
VALUES
  ('Yes, let"s grab lunch', (SELECT id FROM users WHERE fname LIKE 'AJ'),(SELECT id FROM questions WHERE title like 'Lunch?'));



