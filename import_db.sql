CREATE TABLE users (
  id INTEGER PRIMARY KEY NOT NULL,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY NOT NULL,
  title VARCHAR(255) NOT NULL,
  body TEXT,
  author_id INTEGER NOT NULL,
  FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  ord INTEGER PRIMARY KEY NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY NOT NULL,
  question_id INTEGER NOT NULL,
  parent_reply INTEGER,
  author_id INTEGER,
  body TEXT,
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(parent_reply) REFERENCES replies(id),
  FOREIGN KEY(author_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  ord INTEGER PRIMARY KEY NOT NULL,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
   users(fname, lname)
VALUES
   ("Justin", "Bieber"),
   ("Michael", "Jackson"),
   ("Adrian", "Jewell"),
   ("Priya", "Gurung");

INSERT INTO
  questions (title, body, author_id)
VALUES
  ("WHAT IS THE MEANING OF LIFE?","I've always wondered...", 3),
  ("TITLE","how can i get a job and afford to survive here?", 4),
  ("self improvement", "how can I be BETTER than I am?", 2),
  ("dude", "check out my lamborghini", 1);

INSERT INTO
    question_follows(user_id, question_id)
VALUES
  (1, 2),
  (2, 3),
  (3, 4),
  (4, 1);

INSERT INTO
  replies(question_id, parent_reply, author_id, body)
VALUES
  (1, NULL, 2, "Blah blah blah");

INSERT INTO
  question_likes(user_id, question_id)
VALUES
  (3, 4);
