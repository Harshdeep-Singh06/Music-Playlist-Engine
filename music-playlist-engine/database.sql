CREATE DATABASE IF NOT EXISTS music_playlist;
USE music_playlist;
CREATE TABLE IF NOT EXISTS users(id INT PRIMARY KEY AUTO_INCREMENT,username VARCHAR(100) NOT NULL,email VARCHAR(150) UNIQUE NOT NULL,password VARCHAR(255) NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP);
CREATE TABLE IF NOT EXISTS songs(id INT PRIMARY KEY AUTO_INCREMENT,title VARCHAR(150) NOT NULL,artist VARCHAR(150) NOT NULL,album VARCHAR(150),genre VARCHAR(100),added_by INT NULL,FOREIGN KEY(added_by) REFERENCES users(id) ON DELETE SET NULL);
CREATE TABLE IF NOT EXISTS playlists(id INT PRIMARY KEY AUTO_INCREMENT,name VARCHAR(120) NOT NULL,user_id INT NOT NULL,created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE);
CREATE TABLE IF NOT EXISTS playlist_songs(playlist_id INT NOT NULL,song_id INT NOT NULL,PRIMARY KEY(playlist_id,song_id),FOREIGN KEY(playlist_id) REFERENCES playlists(id) ON DELETE CASCADE,FOREIGN KEY(song_id) REFERENCES songs(id) ON DELETE CASCADE);
INSERT INTO songs(title,artist,album,genre) SELECT 'Blinding Lights','The Weeknd','After Hours','Pop' WHERE NOT EXISTS(SELECT 1 FROM songs WHERE title='Blinding Lights' AND artist='The Weeknd');
INSERT INTO songs(title,artist,album,genre) SELECT 'Perfect','Ed Sheeran','Divide','Pop' WHERE NOT EXISTS(SELECT 1 FROM songs WHERE title='Perfect' AND artist='Ed Sheeran');
INSERT INTO songs(title,artist,album,genre) SELECT 'Kesariya','Arijit Singh','Brahmastra','Bollywood' WHERE NOT EXISTS(SELECT 1 FROM songs WHERE title='Kesariya' AND artist='Arijit Singh');