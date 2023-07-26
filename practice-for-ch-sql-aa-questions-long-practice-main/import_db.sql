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

