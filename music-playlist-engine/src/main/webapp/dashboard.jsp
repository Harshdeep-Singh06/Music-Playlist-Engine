<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login");
        return;
    }

    List<Map<String, Object>> songs =
            (List<Map<String, Object>>) request.getAttribute("songs");

    List<Map<String, Object>> pls =
            (List<Map<String, Object>>) request.getAttribute("playlists");
%>

<!DOCTYPE html>
<html>
<head>
    <title>SoundSpace</title>
    <link rel="stylesheet" href="assets/style.css">
</head>

<body>

    <header>
        <div class="brand">
            ♫ SoundSpace
        </div>

        <div>
            Welcome, <b><%= session.getAttribute("username") %></b>
            ·
            <a href="logout">Sign Out</a>
        </div>
    </header>

    <main>

        <section class="hero">
            <div>
                <small>WELCOME TO YOUR MUSIC WORLD</small>

                <h1>
                    Discover music.<br>
                    <span>Feel every beat.</span>
                </h1>

                <p>
                    Your favourite songs, all in one place.
                </p>
            </div>

            <div class="vinyl">
                ♫
            </div>
        </section>

        <div class="cols">

            <section class="panel">

                <div class="row spread">
                    <h2>Explore Music</h2>

                    <form action="dashboard">
                        <input
                            name="q"
                            placeholder="Search your favourite music"
                            value="<%= request.getAttribute("query") %>"
                        >

                        <button>Search</button>
                    </form>
                </div>

                <%
                    for (Map<String, Object> s : songs) {
                %>

                    <div class="song">

                        <div class="art">
                            ♫
                        </div>

                        <div class="grow">
                            <b><%= s.get("title") %></b>

                            <small>
                                <%= s.get("artist") %>
                                ·
                                <%= s.get("album") == null ? "Single" : s.get("album") %>
                            </small>
                        </div>

                        <button
                            type="button"
                            onclick="playSong(
                                '<%= s.get("title").toString().replace("'", "\\'") %>',
                                '<%= s.get("artist").toString().replace("'", "\\'") %>'
                            )"
                        >
                            ▶
                        </button>

                        <%
                            if (!pls.isEmpty()) {
                        %>

                            <form action="playlists/add-song" method="post">

                                <input
                                    type="hidden"
                                    name="songId"
                                    value="<%= s.get("id") %>"
                                >

                                <select name="playlistId">

                                    <%
                                        for (Map<String, Object> pl : pls) {
                                    %>

                                        <option value="<%= pl.get("id") %>">
                                            <%= pl.get("name") %>
                                        </option>

                                    <%
                                        }
                                    %>

                                </select>

                                <button>+ Add</button>

                            </form>

                        <%
                            }
                        %>

                    </div>

                <%
                    }

                    if (songs.isEmpty()) {
                %>

                    <p>No songs found. Add your first song!</p>

                <%
                    }
                %>

            </section>

            <aside>

                <section class="panel">

                    <h2>My Collections</h2>

                    <form action="playlists/create" method="post">

                        <input
                            name="name"
                            placeholder="Enter playlist name"
                            required
                        >

                        <button>Create Playlist</button>

                    </form>

                    <%
                        for (Map<String, Object> pl : pls) {
                    %>

                        <p>
                            <a href="playlist?id=<%= pl.get("id") %>">
                                ▤ &nbsp;
                                <%= pl.get("name") %>
                                →
                            </a>
                        </p>

                    <%
                        }

                        if (pls.isEmpty()) {
                    %>

                        <small>No playlists yet. Create your first one!</small>

                    <%
                        }
                    %>

                </section>

                <section class="panel">

                    <h2>Add New Music</h2>

                    <form action="songs/add" method="post">

                        <input
                            name="title"
                            placeholder="Song title"
                            required
                        >

                        <input
                            name="artist"
                            placeholder="Artist name"
                            required
                        >

                        <input
                            name="album"
                            placeholder="Album name"
                        >

                        <input
                            name="genre"
                            placeholder="Music genre"
                        >

                        <button>Add Song</button>

                    </form>

                </section>

            </aside>

        </div>

    </main>

    <footer>

        <div>
            <b id="track">Nothing playing</b>
            <small id="artist">Choose a song</small>
        </div>

        <div>
            <button onclick="prevSong()">|◀</button>

            <button onclick="togglePlay()" id="toggle">
                ▶
            </button>

            <button onclick="nextSong()">▶|</button>
        </div>

        <small>SoundSpace Player · Demo controls</small>

    </footer>

    <script src="assets/app.js"></script>

</body>
</html>