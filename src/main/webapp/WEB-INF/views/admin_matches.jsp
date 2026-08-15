<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Match Command Center</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #07090e;
            --card-surface: #0e121c;
            --card-hover: #141a28;
            --accent-red: #ff3366;
            --accent-green: #00ffcc;
            --accent-blue: #00d2ff;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --border-color: #1e293b;
        }

        body.light-theme {
            --bg-deep: #f1f5f9;
            --card-surface: #ffffff;
            --card-hover: #f8fafc;
            --accent-red: #e11d48;
            --accent-green: #059669;
            --accent-blue: #0284c7;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border-color: #cbd5e1;
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background-color: var(--bg-deep);
            color: var(--text-main); 
            margin: 0; 
            min-height: 100vh;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* TOP COMMAND BAR */
        .command-bar {
            background: var(--card-surface);
            border-bottom: 1px solid var(--border-color);
            padding: 12px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .command-left {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .command-link {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: color 0.2s;
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 0;
        }

        .command-link:hover, .command-link.active {
            color: var(--text-main);
        }

        .command-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* CONTAINER */
        .container {
            max-width: 1400px;
            margin: 25px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        /* HEADER SECTION */
        .section-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .page-title-area h1 {
            font-size: 26px;
            font-weight: 900;
            letter-spacing: 1.5px;
            margin: 0;
            text-transform: uppercase;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-green), var(--accent-red), var(--accent-blue));
            background-size: 300% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: waveShimmer 6s linear infinite;
        }

        @keyframes waveShimmer {
            0% { background-position: 0% center; }
            100% { background-position: 300% center; }
        }

        .header-actions-right {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .total-badge {
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 600;
        }

        .btn-danger-outline {
            background: rgba(255, 51, 102, 0.1);
            color: var(--accent-red);
            border: 1px solid rgba(255, 51, 102, 0.3);
            padding: 8px 16px;
            border-radius: 10px;
            font-size: 12px;
            font-weight: 700;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .btn-danger-outline:hover {
            background: var(--accent-red);
            color: #fff;
        }

        /* CONTROLS ROW */
        .controls-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            gap: 15px;
            flex-wrap: wrap;
        }

        .search-box-wrapper {
            position: relative;
            flex: 1;
            max-width: 380px;
        }

        .search-box-wrapper i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            font-size: 13px;
        }

        .search-input-field {
            width: 100%;
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 10px 15px 10px 40px;
            color: var(--text-main);
            font-size: 13px;
            outline: none;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }
        .search-input-field:focus {
            border-color: var(--accent-blue);
        }

        .btn-primary-glow {
            background: var(--accent-blue);
            color: #07090e;
            border: none;
            padding: 10px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13px;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.3);
            transition: transform 0.2s;
        }
        .btn-primary-glow:hover {
            transform: translateY(-2px);
        }

        /* ENHANCED MATCH CARDS GRID LAYOUT */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(370px, 1fr));
            gap: 22px;
            margin-bottom: 35px;
        }

        .match-card {
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 24px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
            transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 16px;
        }

        .match-card:hover {
            transform: translateY(-4px);
            border-color: var(--accent-blue);
            box-shadow: 0 15px 35px rgba(0, 210, 255, 0.15);
            background: var(--card-hover);
        }

        .match-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid var(--border-color);
            padding-bottom: 12px;
        }

        .match-id-tag {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 700;
            background: var(--bg-deep);
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
        }

        .status-badge {
            font-size: 11px;
            font-weight: 700;
            padding: 4px 10px;
            border-radius: 6px;
            display: inline-block;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .status-upcoming {
            background: rgba(0, 210, 255, 0.1);
            color: var(--accent-blue);
            border: 1px solid rgba(0, 210, 255, 0.2);
        }
        .status-ongoing {
            background: rgba(0, 255, 204, 0.1);
            color: var(--accent-green);
            border: 1px solid rgba(0, 255, 204, 0.2);
        }
        .status-completed {
            background: rgba(100, 116, 139, 0.1);
            color: var(--text-muted);
            border: 1px solid var(--border-color);
        }

        .match-tournament-name {
            font-size: 12px;
            text-transform: uppercase;
            color: var(--accent-blue);
            font-weight: 700;
            letter-spacing: 0.5px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .teams-versus-box {
            background: var(--bg-deep);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 18px;
            text-align: center;
            box-shadow: inset 0 2px 4px rgba(0,0,0,0.2);
        }

        .teams-match-text {
            font-size: 16px;
            font-weight: 900;
            color: var(--text-main);
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 14px;
        }

        .vs-badge {
            font-size: 10px;
            color: var(--text-muted);
            font-weight: 800;
            background: var(--card-surface);
            padding: 3px 8px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
            letter-spacing: 1px;
        }

        .match-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            font-size: 12.5px;
            background: rgba(30, 41, 59, 0.2);
            padding: 12px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
        }

        .info-item {
            color: var(--text-muted);
            font-size: 11.5px;
            text-transform: uppercase;
            font-weight: 700;
        }
        .info-item strong {
            color: var(--text-main);
            display: block;
            margin-top: 4px;
            font-size: 12.5px;
            text-transform: none;
            font-weight: 600;
        }

        .score-section-box {
            background: var(--bg-deep);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 10px 14px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .score-label {
            font-size: 11px;
            font-weight: 700;
            color: var(--text-muted);
            text-transform: uppercase;
        }

        .score-box-card {
            font-family: monospace;
            font-size: 13.5px;
            font-weight: 700;
            color: var(--accent-green);
        }

        .winner-display {
            font-size: 12px;
            color: var(--text-muted);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: rgba(0, 255, 204, 0.05);
            padding: 8px 12px;
            border-radius: 8px;
            border: 1px solid rgba(0, 255, 204, 0.15);
        }
        .winner-display strong {
            color: var(--accent-green);
            font-weight: 700;
        }

        .card-actions {
            display: flex;
            gap: 10px;
            margin-top: 4px;
            padding-top: 14px;
            border-top: 1px solid var(--border-color);
        }

        .btn-card-edit {
            flex: 1;
            color: var(--accent-blue);
            background: rgba(0, 210, 255, 0.1);
            border: 1px solid rgba(0, 210, 255, 0.25);
            padding: 9px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
        }
        .btn-card-edit:hover {
            background: var(--accent-blue);
            color: #07090e;
        }

        .btn-card-delete {
            flex: 1;
            color: var(--accent-red);
            background: rgba(255, 51, 102, 0.1);
            border: 1px solid rgba(255, 51, 102, 0.25);
            padding: 9px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            transition: all 0.2s;
            display: inline-flex;
            justify-content: center;
            align-items: center;
            gap: 6px;
        }
        .btn-card-delete:hover {
            background: var(--accent-red);
            color: #fff;
        }

        /* FOOTER SECTION */
        .dashboard-footer {
            border-top: 1px solid var(--border-color);
            padding: 35px 0 20px 0;
            margin-top: 50px;
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            flex-wrap: wrap;
            gap: 30px;
        }

        .footer-col-left h4 {
            font-size: 15px;
            font-weight: 800;
            color: var(--text-main);
            margin: 0 0 8px 0;
            letter-spacing: 0.5px;
        }

        .footer-col-left p {
            font-size: 12px;
            color: var(--text-muted);
            margin: 0;
            max-width: 420px;
            line-height: 1.5;
        }

        .footer-col-right h5 {
            font-size: 12px;
            text-transform: uppercase;
            color: var(--text-muted);
            margin: 0 0 10px 0;
            letter-spacing: 1px;
            font-weight: 700;
        }

        .footer-links-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .footer-links-list a {
            color: var(--text-main);
            text-decoration: none;
            font-size: 12px;
            font-weight: 600;
            transition: color 0.2s;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }
        .footer-links-list a:hover {
            color: var(--accent-blue);
        }

        .footer-bottom-bar {
            text-align: center;
            font-size: 11px;
            color: var(--text-muted);
            border-top: 1px solid var(--border-color);
            padding-top: 20px;
            margin-top: 25px;
        }

        @media(max-width: 768px) {
            .dashboard-footer { flex-direction: column; }
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                let btnText = document.getElementById('themeBtnText');
                if(btnText) btnText.innerText = 'Light Mode';
            }
        });

        function toggleTheme() {
            document.body.classList.toggle('light-theme');
            let btnText = document.getElementById('themeBtnText');
            if (document.body.classList.contains('light-theme')) {
                localStorage.setItem('promatch_theme', 'light');
                if(btnText) btnText.innerText = 'Light Mode';
            } else {
                localStorage.setItem('promatch_theme', 'dark');
                if(btnText) btnText.innerText = 'Dark Mode';
            }
        }
    </script>
</head>
<body>

    <!-- TOP COMMAND BAR WITH THEME TOGGLE & BACK BUTTON -->
    <div class="command-bar">
        <div class="command-left">
            <a href="/admin/home" class="command-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
        <div class="command-right">
            <button onclick="toggleTheme()" class="command-link"><i class="fa-solid fa-circle-half-stroke"></i> <span id="themeBtnText">Dark Mode</span></button>
        </div>
    </div>

    <div class="container">

        <!-- HEADER TITLE SECTION WITH WAVING SHIMMER EFFECT & DELETE ALL -->
        <div class="section-header-flex">
            <div class="page-title-area">
                <h1>Match Command Center</h1>
            </div>
            <div class="header-actions-right">
                <div class="total-badge">
                    Total Matches: <strong>${matches.size()}</strong>
                </div>
                <c:if test="${not empty matches}">
                    <a href="/admin/deleteAllMatches" class="btn-danger-outline" onclick="return confirm('DANGER: Are you sure you want to delete all matches?');">
                        <i class="fa-solid fa-trash-can"></i> Delete All Matches
                    </a>
                </c:if>
            </div>
        </div>

        <!-- SEARCH & CONTROLS -->
        <div class="controls-row">
            <div class="search-box-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" class="search-input-field" placeholder="Search match by venue or team...">
            </div>
            <div>
                <a href="/admin/addMatchPage" class="btn-primary-glow"><i class="fa-solid fa-plus"></i> Schedule New Match</a>
            </div>
        </div>

        <!-- ENHANCED MATCH CARDS GRID -->
        <div class="cards-grid">
            <c:forEach items="${matches}" var="m">
                <div class="match-card">
                    <div class="match-card-header">
                        <span class="match-id-tag">#M-${m.id}</span>
                        <span class="status-badge ${m.status.name() == 'UPCOMING' ? 'status-upcoming' : (m.status.name() == 'ONGOING' ? 'status-ongoing' : 'status-completed')}">
                            ${m.status}
                        </span>
                    </div>

                    <div class="match-tournament-name">
                        <i class="fa-solid fa-trophy" style="font-size: 11px;"></i> 
                        ${m.tournament != null ? m.tournament.tournamentName : 'N/A'}
                    </div>

                    <div class="teams-versus-box">
                        <div class="teams-match-text">
                            <span>${m.teamA != null ? m.teamA.teamName : 'TBD'}</span>
                            <span class="vs-badge">VS</span>
                            <span>${m.teamB != null ? m.teamB.teamName : 'TBD'}</span>
                        </div>
                    </div>

                    <div class="match-info-grid">
                        <div class="info-item">
                            Venue
                            <strong><i class="fa-solid fa-location-dot" style="color: var(--accent-red); font-size: 11px; margin-right: 2px;"></i> ${m.venue}</strong>
                        </div>
                        <div class="info-item">
                            Date & Time
                            <strong><i class="fa-regular fa-calendar" style="color: var(--accent-blue); font-size: 11px; margin-right: 2px;"></i> ${m.matchDateTime}</strong>
                        </div>
                    </div>

                    <div class="score-section-box">
                        <span class="score-label"><i class="fa-solid fa-chart-column" style="margin-right: 4px; color: var(--accent-blue);"></i> Scoreboard</span>
                        <span class="score-box-card">${m.runsScoredA}/${m.oversFacedA} &nbsp;&mdash;&nbsp; ${m.runsScoredB}/${m.oversFacedB}</span>
                    </div>

                    <div class="winner-display">
                        <span><i class="fa-solid fa-award" style="color: var(--accent-green); margin-right: 4px;"></i> Winner</span>
                        <strong>${m.winner != null ? m.winner.teamName : 'Pending'}</strong>
                    </div>

                    <div class="card-actions">
                        <a href="/admin/editMatch/${m.id}" class="btn-card-edit"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                        <a href="/admin/deleteMatch/${m.id}" class="btn-card-delete" onclick="return confirm('WARNING: Are you sure you want to delete this match?');"><i class="fa-solid fa-trash"></i> Delete</a>
                    </div>
                </div>
            </c:forEach>
        </div>

        <!-- FOOTER BRANDING SECTION WITH ADMIN QUICK LINKS -->
        <footer class="dashboard-footer">
            <div class="footer-col-left">
                <h4>PROMATCH ARENA</h4>
                <p>Advanced Enterprise Cricket Tournament & Match Control Center. Built with Spring Boot, JSP, and PostgreSQL to deliver high-performance sports analytics and scheduling management.</p>
            </div>
            <div class="footer-col-right">
                <h5>Admin Quick Links</h5>
                <ul class="footer-links-list">
                    <li><a href="/admin/teams"><i class="fa-solid fa-angle-right" style="font-size: 10px; color: var(--accent-blue);"></i> ⚡ View / Edit Teams</a></li>
                    <li><a href="/admin/tournaments"><i class="fa-solid fa-angle-right" style="font-size: 10px; color: var(--accent-blue);"></i> 🏆 View / Edit Tournaments</a></li>
                    <li><a href="/admin/matches"><i class="fa-solid fa-angle-right" style="font-size: 10px; color: var(--accent-blue);"></i> 🏏 View / Edit Matches</a></li>
                    <li><a href="/admin/pointsTable"><i class="fa-solid fa-angle-right" style="font-size: 10px; color: var(--accent-blue);"></i> 📊 View Points Table</a></li>
                    <li><a href="/admin/users"><i class="fa-solid fa-angle-right" style="font-size: 10px; color: var(--accent-blue);"></i> 👥 Manage Users</a></li>
                </ul>
            </div>
        </footer>
        
        <div class="footer-bottom-bar">
            © 2026 ProMatch Arena • All Rights Reserved. Crafted with High-End Cyber Glassmorphism UI.
        </div>

    </div>
</body>
</html>