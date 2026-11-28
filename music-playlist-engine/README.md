# Music Playlist Engine
Java 17, Maven, JSP/Servlets (Tomcat 10.1), JDBC and MySQL.

1. Run `database.sql` in MySQL Workbench.
2. Set credentials in `DBConnection.java` (defaults: music_app / MpeTemp2026).
3. From this folder run `mvn package`.
4. Copy `target/MusicPlaylistEngine.war` to Tomcat's `webapps` folder.
5. Start Tomcat and open `http://localhost:8080/MusicPlaylistEngine/`.

Features: registration/login, song search, add songs, create playlists, add/remove playlist songs. Player controls are a visual demo only; no audio streaming. Passwords are BCrypt hashed. Keep DB credentials out of GitHub.