<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - PitchOps</title>
    <style>
        :root {
            --bg-main: #07090e;
            --bg-card: #0e121c;
            --bg-card-hover: #141a28;
            --accent-red: #ff3366;
            --accent-green: #00ffcc;
            --accent-blue: #00d2ff;
            --text-main: #f1f5f9;
            --text-muted: #64748b;
            --border-color: #1e293b;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
        }

        /* TOP NAVBAR */
        nav {
            background-color: var(--bg-card);
            border-bottom: 1px solid var(--border-color);
            padding: 12px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-left {
            display: flex;
            align-items: center;
            gap: 40px;
        }

        .logo-box {
            display: flex;
            align-items: center;
            gap: 10px;
            text-decoration: none;
        }

        .logo-icon {
            background: var(--accent-red);
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 6px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 14px;
        }

        .logo-text {
            font-weight: 800;
            font-size: 16px;
            color: var(--text-main);
            letter-spacing: 0.5px;
        }

        .logo-text span {
            display: block;
            font-size: 9px;
            color: var(--text-muted);
            letter-spacing: 1px;
            text-transform: uppercase;
        }

        .nav-links {
            list-style: none;
            margin: 0;
            padding: 0;
            display: flex;
            gap: 25px;
        }

        .nav-links a {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 13px;
            font-weight: 500;
            transition: color 0.2s;
        }

        .nav-links a:hover, .nav-links a.active {
            color: var(--text-main);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 15px;
            position: relative;
        }

        .search-input {
            background: var(--bg-main);
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 6px 15px;
            color: var(--text-main);
            font-size: 12px;
            outline: none;
            width: 180px;
        }

        .search-btn {
            background: var(--accent-blue);
            border: none;
            padding: 6px 12px;
            border-radius: 15px;
            color: #000;
            font-size: 12px;
            font-weight: bold;
            cursor: pointer;
        }

        /* PROFILE DROPDOWN AT TOP RIGHT */
        .profile-menu-container { position: relative; display: inline-block; }
        .user-pill {
            display: flex; align-items: center; gap: 8px; background: var(--bg-main);
            border: 1px solid var(--border-color); padding: 4px 12px 4px 6px; border-radius: 20px; cursor: pointer;
        }
        .user-avatar { width: 24px; height: 24px; background: var(--accent-red); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: bold; color: white; }
        .user-name { font-size: 12px; font-weight: 500; color: var(--text-main); }

        .dropdown-content {
            display: none; position: absolute; right: 0; top: 40px; background: var(--bg-card);
            min-width: 220px; border: 1px solid var(--border-color); border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.5); z-index: 100; padding: 15px;
        }
        .dropdown-content.show { display: block; }
        .dropdown-content p { margin: 6px 0; font-size: 12px; color: var(--text-muted); }
        .dropdown-content p strong { color: var(--text-main); }
        .dropdown-divider { height: 1px; background: var(--border-color); margin: 10px 0; }
        .dropdown-content a { color: var(--accent-blue); text-decoration: none; font-size: 12px; display: block; margin-top: 5px; }
        .dropdown-content a.logout { color: var(--accent-red); }

        /* CONTAINER */
        .container {
            max-width: 1350px;
            margin: 25px auto;
            padding: 0 20px;
        }

        /* HERO BANNER */
        .hero-banner {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 35px 40px;
            margin-bottom: 25px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: relative;
            overflow: hidden;
        }

        .hero-content {
            z-index: 2;
        }

        .season-tag {
            color: var(--accent-red);
            font-size: 11px;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            margin-bottom: 8px;
            display: block;
        }

        .hero-content h1 {
            font-size: 32px;
            margin: 0 0 10px 0;
            font-weight: 800;
        }

        .hero-content p {
            color: var(--text-muted);
            font-size: 13px;
            margin: 0 0 20px 0;
            max-width: 450px;
            line-height: 1.5;
        }

        .hero-btns {
            display: flex;
            gap: 12px;
        }

        .btn-primary {
            background: var(--accent-blue);
            color: #07090e;
            border: none;
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .btn-secondary {
            background: var(--bg-main);
            color: var(--text-main);
            border: 1px solid var(--border-color);
            padding: 10px 18px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
        }

        /* PITCH GRAPHIC RIGHT */
        .pitch-graphic {
            position: absolute;
            right: -20px;
            top: 50%;
            transform: translateY(-50%);
            width: 320px;
            height: 180px;
            background: #0f2d1d;
            border-radius: 120px 0 0 120px;
            border: 1px solid #1e4d30;
            display: flex;
            align-items: center;
            justify-content: center;
            z-index: 1;
            opacity: 0.85;
        }

        .pitch-strip {
            width: 140px;
            height: 60px;
            background: #235c3c;
            border-radius: 6px;
            display: flex;
            justify-content: space-around;
            align-items: center;
            position: relative;
        }

        .stumps {
            width: 4px;
            height: 25px;
            background: white;
            box-shadow: 6px 0 0 white, 12px 0 0 white;
        }

        /* LIVE SCORE TICKER */
        .ticker-bar {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 12px 20px;
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 25px;
            overflow-x: auto;
        }

        .live-badge {
            background: rgba(255, 51, 102, 0.15);
            color: var(--accent-red);
            border: 1px solid var(--accent-red);
            font-size: 10px;
            font-weight: bold;
            padding: 3px 8px;
            border-radius: 4px;
            text-transform: uppercase;
        }

        .ticker-match {
            display: flex;
            align-items: center;
            gap: 15px;
            font-size: 12px;
            font-weight: 500;
            border-right: 1px solid var(--border-color);
            padding-right: 20px;
            white-space: nowrap;
        }

        /* STATS WIDGETS */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 25px;
        }

        .stat-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 20px;
        }

        .stat-card h4 {
            color: var(--text-muted);
            font-size: 11px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin: 0 0 8px 0;
        }

        .stat-card .val {
            font-size: 22px;
            font-weight: 700;
            margin: 0;
            color: var(--text-main);
        }

        /* QUICK NAVIGATION SECTION */
        .card-box {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 25px;
            margin-bottom: 30px;
        }

        .card-box h3 {
            font-size: 16px;
            margin: 0 0 15px 0;
        }

        .quick-nav-grid {
            display: grid;
            grid-template-columns: repeat(5, 1fr);
            gap: 15px;
        }

        .quick-nav-item {
            background: var(--bg-main);
            border: 1px solid var(--border-color);
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            text-decoration: none;
            color: var(--text-main);
            font-size: 13px;
            font-weight: 600;
            transition: all 0.2s;
        }

        .quick-nav-item:hover {
            border-color: var(--accent-blue);
            background: var(--bg-card-hover);
            color: var(--accent-blue);
        }

        /* 8 CARDS MEDIA & HIGHLIGHTS SECTION (Images + Working Videos) */
        .section-title {
            font-size: 18px;
            font-weight: 700;
            margin: 35px 0 15px 0;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .cards-grid-8 {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }

        .media-card {
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            overflow: hidden;
            transition: transform 0.2s, border-color 0.2s;
        }

        .media-card:hover {
            transform: translateY(-4px);
            border-color: var(--accent-green);
        }

        .media-card img, .media-card video {
            width: 100%;
            height: 150px;
            object-fit: cover;
            background: #000;
        }

        .media-body {
            padding: 15px;
        }

        .media-body h5 {
            margin: 0 0 5px 0;
            font-size: 14px;
            font-weight: 600;
        }

        .media-body p {
            margin: 0;
            font-size: 12px;
            color: var(--text-muted);
        }

        @media(max-width: 1100px) {
            .cards-grid-8, .quick-nav-grid, .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
    <script>
        function toggleProfileMenu(event) {
            event.stopPropagation();
            document.getElementById("profileDropdown").classList.toggle("show");
        }
        window.onclick = function(event) {
            if (!event.target.closest('.profile-menu-container')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) {
                        openDropdown.classList.remove('show');
                    }
                }
            }
        }
    </script>
</head>
<body>

    <nav>
        <div class="nav-left">
            <a href="/admin/home" class="logo-box">
                <div class="logo-icon">A</div>
                <div class="logo-text">PitchOps <span>Admin Panel</span></div>
            </a>
            <ul class="nav-links">
                <li><a href="/admin/home" class="active">Dashboard</a></li>
                <li><a href="/admin/teams">Teams</a></li>
                <li><a href="/admin/tournaments">Tournaments</a></li>
                <li><a href="/admin/matches">Matches</a></li>
                <li><a href="/admin/pointsTable">Points Table</a></li>
            </ul>
        </div>

        <div class="nav-right">
            <form action="/admin/search" method="get" style="margin: 0; display: flex; gap: 5px;">
                <input type="text" name="keyword" class="search-input" placeholder="Search system..." required>
                <button type="submit" class="search-btn">Search</button>
            </form>

            <div class="profile-menu-container">
                <div class="user-pill" onclick="toggleProfileMenu(event)">
                    <div class="user-avatar">${sessionScope.user.name != null ? sessionScope.user.name.charAt(0) : 'A'}</div>
                    <div class="user-name">${sessionScope.user.name}</div>
                    <span style="font-size: 10px; color: var(--text-muted);">▼</span>
                </div>

                <div id="profileDropdown" class="dropdown-content">
                    <h4 style="margin: 0 0 10px 0; font-size: 14px; color: var(--text-main);">Admin Profile</h4>
                    <p><strong>Name:</strong> ${sessionScope.user.name}</p>
                    <p><strong>Email:</strong> ${sessionScope.user.email}</p>
                    <p><strong>Role:</strong> <span style="color: var(--accent-red);">${sessionScope.user.role}</span></p>
                    <div class="dropdown-divider"></div>
                    <a href="/change-password">Change Password</a>
                    <a href="/logout" class="logout">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">

        <div class="hero-banner">
            <div class="hero-content">
                <span class="season-tag">● ADMIN CONTROL CENTER • 2026</span>
                <h1>Welcome back, ${sessionScope.user.name}!</h1>
                <p>You have full administrative access to manage teams, schedule fixtures, and monitor tournament standings.</p>
                <div class="hero-btns">
                    <a href="/admin/matches" class="btn-primary">⚡ Manage Matches</a>
                    <a href="/admin/teams" class="btn-secondary">View Teams</a>
                </div>
            </div>
            <div class="pitch-graphic">
                <div class="pitch-strip">
                    <div class="stumps"></div>
                    <div class="stumps"></div>
                </div>
            </div>
        </div>

        <div class="ticker-bar">
            <span class="live-badge">SYSTEM LIVE</span>
            <div class="ticker-match">
                <span>CSK <strong>186/4 (18.2)</strong></span>
                <span style="color:var(--text-muted)">vs</span>
                <span>MI <strong>—</strong></span>
            </div>
            <div class="ticker-match" style="border:none;">
                <span>RCB <strong>142/6 (16.0)</strong></span>
                <span style="color:var(--text-muted)">vs</span>
                <span>GT <strong>98/2 (10.4)</strong></span>
            </div>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h4>Total Matches</h4>
                <p class="val">128</p>
            </div>
            <div class="stat-card">
                <h4>Active Tournaments</h4>
                <p class="val">4</p>
            </div>
            <div class="stat-card">
                <h4>Registered Teams</h4>
                <p class="val">12</p>
            </div>
            <div class="stat-card">
                <h4>System Users</h4>
                <p class="val" style="color: var(--accent-green);">45</p>
            </div>
        </div>

        <div class="card-box">
            <h3>Quick Navigation & Management Hub</h3>
            <div class="quick-nav-grid">
                <a href="/admin/teams" class="quick-nav-item">⚡ View / Edit Teams</a>
                <a href="/admin/tournaments" class="quick-nav-item">🏆 View / Edit Tournaments</a>
                <a href="/admin/matches" class="quick-nav-item">🏏 View / Edit Matches</a>
                <a href="/admin/pointsTable" class="quick-nav-item">📊 View Points Table</a>
                <a href="/admin/users" class="quick-nav-item">👥 Manage Users</a>
            </div>
        </div>

        <div class="section-title">
            <span>Match Moments & Video Highlights Gallery</span>
            <span style="font-size: 12px; color: var(--accent-blue); font-weight: normal;">Live Media Feeds</span>
        </div>

        <div class="cards-grid-8">
            <div class="media-card">
                <img src="https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=600&q=80" alt="Stadium">
                <div class="media-body">
                    <h5>Grand Arena Setup</h5>
                    <p>Packed stadium during opening match.</p>
                </div>
            </div>

            <div class="media-card">
                <img src="https://images.unsplash.com/photo-1531415074968-036ba1b575da?auto=format&fit=crop&w=600&q=80" alt="Batting Action">
                <div class="media-body">
                    <h5>Powerplay Batting</h5>
                    <p>Aggressive stroke play in action.</p>
                </div>
            </div>

            <div class="media-card">
                <img src="https://images.unsplash.com/photo-1517649763962-0c6232660102?auto=format&fit=crop&w=600&q=80" alt="Net Practice">
                <div class="media-body">
                    <h5>Net Practice Session</h5>
                    <p>Batsmen sharpening skills before match.</p>
                </div>
            </div>

            <div class="media-card">
                <img src="https://images.unsplash.com/photo-1508098682722-e99c43a406b2?auto=format&fit=crop&w=600&q=80" alt="Fans Cheering">
                <div class="media-body">
                    <h5>Fan Zone Madness</h5>
                    <p>Supporters cheering with flags.</p>
                </div>
            </div>

            <div class="media-card">
                <img src="https://images.unsplash.com/photo-1624526267942-ab0ff8a3e972?auto=format&fit=crop&w=600&q=80" alt="Trophy">
                <div class="media-body">
                    <h5>Championship Trophy</h5>
                    <p>The silverware up for grabs this season.</p>
                </div>
            </div>

            <div class="media-card">
                <img src="https://images.unsplash.com/photo-1579952363873-27f3bade9f55?auto=format&fit=crop&w=600&q=80" alt="Cricket Gear">
                <div class="media-body">
                    <h5>Kit Room Prep</h5>
                    <p>Professional gear ready for action.</p>
                </div>
            </div>

            <div class="media-card">
                <video autoplay muted loop playsinline>
                    <source src="https://assets.mixkit.co/videos/preview/mixkit-playing-football-in-a-stadium-41624-large.mp4" type="video/mp4">
                </video>
                <div class="media-body">
                    <h5>Six Over Long-On</h5>
                    <p>Massive hit into the stands.</p>
                </div>
            </div>

            <div class="media-card">
                <video autoplay muted loop playsinline>
                    <source src="https://assets.mixkit.co/videos/preview/mixkit-ball-going-into-the-net-of-a-goal-41625-large.mp4" type="video/mp4">
                </video>
                <div class="media-body">
                    <h5>Super Over Thriller</h5>
                    <p>Final ball nail-biting finish.</p>
                </div>
            </div>
        </div>

    </div>

</body>
</html>