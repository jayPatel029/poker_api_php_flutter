show databases;

create database poker1;

use poker1;


show tables;

-- Create Users table
CREATE TABLE Users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);

describe users; 


select * from users;



-- CREATE TABLE Games (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     game_id VARCHAR(10) UNIQUE NOT NULL,
--     host_user_id INT NOT NULL,
--     status ENUM('waiting', 'in_progress', 'finished') DEFAULT 'waiting',
--     num_players INT DEFAULT 0
-- );


CREATE TABLE Games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game_id VARCHAR(10) UNIQUE NOT NULL,
    status ENUM('waiting', 'in_progress', 'finished') DEFAULT 'waiting'
);




describe games;

INSERT INTO Games (game_id, status) VALUES ('ABC123', 'waiting');
INSERT INTO Games (game_id, status) VALUES ('DEF456', 'waiting');
INSERT INTO Games (game_id, status) VALUES ('GHI789', 'waiting');
INSERT INTO Games (game_id, status) VALUES ('JKL012', 'waiting');
INSERT INTO Games (game_id,status) VALUES ('MNO345', 'waiting');


-- drop table games;


select * from games;

-- truncate table games; 


ALTER TABLE Users
ADD COLUMN active_game_id INT,
ADD CONSTRAINT fk_active_game_id FOREIGN KEY (active_game_id) REFERENCES Games(id);


-- to maintain record of every game
CREATE TABLE GameInfo (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game_id VARCHAR(10) UNIQUE NOT NULL,
    status ENUM('waiting', 'in_progress', 'finished') DEFAULT 'waiting',
    num_players INT DEFAULT 0,
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

describe GameInfo;

select * from GameInfo;



-- drop table gameinfo;



-- CREATE TABLE Players (
--   id INT AUTO_INCREMENT PRIMARY KEY,
--   game_id INT NOT NULL,
--   user_id INT NOT NULL,
--   player_state ENUM('active', 'folded', 'checked', 'raised') DEFAULT 'active',
--   is_active BOOLEAN DEFAULT true,
--   FOREIGN KEY (game_id) REFERENCES Games(id),
--   FOREIGN KEY (user_id) REFERENCES Users(id)
-- );

-- describe players;

-- select * from players;


CREATE TABLE UserGames (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    game_id INT NOT NULL,
    player_state ENUM('active', 'folded', 'checked', 'raised') DEFAULT 'active',
    is_active BOOLEAN DEFAULT true,
    FOREIGN KEY (user_id) REFERENCES Users(id),
    FOREIGN KEY (game_id) REFERENCES Games(id)
);


DELIMITER //
CREATE TRIGGER max_players_per_game
BEFORE INSERT ON UserGames
FOR EACH ROW
BEGIN
    DECLARE player_count INT;
    SELECT COUNT(*) INTO player_count FROM UserGames WHERE game_id = NEW.game_id;
    IF player_count >= 4 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Maximum number of players reached for this game';
    END IF;
END;
//
DELIMITER ;
 describe UserGames;
select * from UserGames;

-- DROP TABLE IF EXISTS UserGames;




CREATE TABLE UserBets (
    bet_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    game_id INT,
    round_number INT,
    amount DECIMAL(10, 2),
    bet_type ENUM('fold', 'check', 'call', 'raise'),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (game_id) REFERENCES Games(id)
);


describe UserBets;

select * from UserBets;


