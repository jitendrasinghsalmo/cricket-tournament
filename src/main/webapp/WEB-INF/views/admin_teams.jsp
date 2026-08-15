<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Team Command Center</title>
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

        .command-left, .command-right {
            display: flex;
            align-items: center;
            gap: 20px;
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

        .command-link:hover {
            color: var(--text-main);
        }

        /* CONTAINER */
        .container {
            max-width: 1400px;
            margin: 25px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        /* TAGDI ANIMATED HEADER SECTION */
        .section-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .page-title-area h1 {
            font-size: 30px;
            font-weight: 900;
            letter-spacing: 2px;
            margin: 0;
            text-transform: uppercase;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-green), var(--accent-red), var(--accent-blue));
            background-size: 300% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: waveShimmer 5s linear infinite;
            filter: drop-shadow(0 2px 10px rgba(0, 210, 255, 0.2));
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

        /* ENHANCED TEAM CARDS GRID LAYOUT */
        .cards-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(370px, 1fr));
            gap: 24px;
            margin-bottom: 35px;
        }

        .team-card {
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 26px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
            transition: transform 0.25s ease, border-color 0.25s ease, box-shadow 0.25s ease;
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .team-card:hover {
            transform: translateY(-5px);
            border-color: var(--accent-blue);
            box-shadow: 0 15px 40px rgba(0, 210, 255, 0.2);
            background: var(--card-hover);
        }

        .team-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .team-id-tag {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 700;
            background: var(--bg-deep);
            padding: 4px 10px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
        }

        /* BADA LOGO CONTAINER */
        .team-logo-container {
            display: flex;
            justify-content: center;
            margin: 5px 0;
        }

        .team-logo-box {
            width: 85px;
            height: 85px;
            background: var(--bg-deep);
            border-radius: 50%;
            border: 2px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            transition: border-color 0.3s;
        }

        .team-card:hover .team-logo-box {
            border-color: var(--accent-blue);
        }

        .team-logo-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .team-name-title {
            font-size: 20px;
            font-weight: 900;
            color: var(--text-main);
            letter-spacing: 0.5px;
            text-align: center;
            text-transform: uppercase;
        }

        .team-info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            font-size: 12.5px;
            background: rgba(30, 41, 59, 0.25);
            padding: 14px;
            border-radius: 12px;
            border: 1px solid var(--border-color);
        }

        .info-item {
            color: var(--text-muted);
            font-size: 11px;
            text-transform: uppercase;
            font-weight: 700;
        }
        .info-item strong {
            color: var(--text-main);
            display: block;
            margin-top: 4px;
            font-size: 13px;
            text-transform: none;
            font-weight: 600;
        }

        .owner-box {
            font-size: 12.5px;
            color: var(--text-muted);
            text-align: center;
            background: var(--bg-deep);
            padding: 8px 12px;
            border-radius: 8px;
            border: 1px solid var(--border-color);
        }
        .owner-box strong {
            color: var(--text-main);
        }

        .card-actions {
            display: flex;
            gap: 10px;
            margin-top: 4px;
            padding-top: 14px;
            border-top: 1px solid var(--border-color);
        }

        .btn-card-players {
            flex: 1.2;
            color: var(--accent-green);
            background: rgba(0, 255, 204, 0.1);
            border: 1px solid rgba(0, 255, 204, 0.25);
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
        .btn-card-players:hover {
            background: var(--accent-green);
            color: #07090e;
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

    <!-- TOP COMMAND BAR -->
    <div class="command-bar">
        <div class="command-left">
            <a href="/admin/home" class="command-link"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
        <div class="command-right">
            <button onclick="toggleTheme()" class="command-link"><i class="fa-solid fa-circle-half-stroke"></i> <span id="themeBtnText">Dark Mode</span></button>
        </div>
    </div>

    <div class="container">

        <!-- TAGDI ANIMATED HEADER SECTION & DELETE ALL BUTTON -->
        <div class="section-header-flex">
            <div class="page-title-area">
                <h1>Team Command Center</h1>
            </div>
            <div class="header-actions-right">
                <div class="total-badge">
                    Total Teams: <strong>${teams.size()}</strong>
                </div>
                <c:if test="${not empty teams}">
                    <a href="/admin/deleteAllTeams" class="btn-danger-outline" onclick="return confirm('DANGER: Are you sure you want to delete all teams?');">
                        <i class="fa-solid fa-trash-can"></i> Delete All Teams
                    </a>
                </c:if>
            </div>
        </div>

        <!-- SEARCH & CONTROLS -->
        <div class="controls-row">
            <div class="search-box-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" class="search-input-field" placeholder="Search team by name or city...">
            </div>
            <div>
                <a href="/admin/addTeamPage" class="btn-primary-glow"><i class="fa-solid fa-plus"></i> Add New Team</a>
            </div>
        </div>

        <!-- ENHANCED TEAM CARDS GRID -->
        <div class="cards-grid">
            <c:forEach items="${teams}" var="t">
                <div class="team-card">
                    <div class="team-card-header">
                        <span class="team-id-tag">#TEAM-${t.id}</span>
                        <i class="fa-solid fa-bolt" style="color: var(--accent-blue); font-size: 14px;"></i>
                    </div>

                    <!-- BADA LOGO DISPLAY -->
                    <div class="team-logo-container">
                        <div class="team-logo-box">
                            <c:choose>
                                <c:when test="${not empty t.logoUrl}">
                                    <img src="${t.logoUrl}" alt="${t.teamName} Logo">
                                </c:when>
                                <c:otherwise>
                                    <i class="fa-solid fa-shield-halved" style="color: var(--text-muted); font-size: 28px;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="team-name-title">
                        ${t.teamName}
                    </div>

                    <div class="team-info-grid">
                        <div class="info-item">
                            City
                            <strong><i class="fa-solid fa-location-dot" style="color: var(--accent-red); font-size: 11px; margin-right: 2px;"></i> ${t.city}</strong>
                        </div>
                        <div class="info-item">
                            Coach
                            <strong><i class="fa-solid fa-user-tie" style="color: var(--accent-green); font-size: 11px; margin-right: 2px;"></i> ${t.coachName}</strong>
                        </div>
                    </div>

                    <div class="owner-box">
                        Owner: <strong>${t.ownerName}</strong>
                    </div>

                    <div class="card-actions">
                        <!-- FIXED: Admin-specific route to prevent 404 error and user session drop -->
                        <a href="/admin/team/${t.id}/players" class="btn-card-players"><i class="fa-solid fa-users"></i> Players</a>
                        <a href="/admin/editTeam/${t.id}" class="btn-card-edit"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                        <a href="/admin/deleteTeam/${t.id}" class="btn-card-delete" onclick="return confirm('WARNING: Are you sure you want to delete this team?');"><i class="fa-solid fa-trash"></i> Delete</a>
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