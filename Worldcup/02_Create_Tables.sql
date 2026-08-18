CREATE TABLE team(
  id       CHAR(3)      PRIMARY KEY,
  teamname VARCHAR(50),
  coach    VARCHAR(60)
);

CREATE TABLE game(
  id     INT          PRIMARY KEY,
  played DATE,
  city   VARCHAR(30),
  team1  CHAR(3),
  team2  CHAR(3)
);

CREATE TABLE goal(
  game    INT,
  team    CHAR(3),
  player  VARCHAR(100),
  gtime   INT
);

CREATE TABLE card(
  game         INT,
  team         CHAR(3),
  player       VARCHAR(100),
  booking_time INT,
  card_type    CHAR(1)
);
