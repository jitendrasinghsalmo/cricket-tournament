<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Tournament Command Center</title>
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
            --text-muted: #64748b;
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

        .btn-danger-outline {
            background: rgba(255, 51, 102, 0.1);
            color: var(--accent-red);
            border: 1px solid var(--accent-red);
            padding: 6px 14px;
            border-radius: 8px;
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

        /* CONTAINER */
        .container {
            max-width: 1350px;
            margin: 25px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        /* HEADER SECTION WITH WAVING / SHIMMER TITLE ANIMATION */
        .section-header-flex {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
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

        .total-cups-badge {
            font-size: 12px;
            color: var(--text-muted);
            font-weight: 600;
        }

        /* SEARCH & CONTROLS BAR */
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

        /* TOURNAMENTS GRID CARDS */
        .tournaments-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            margin-bottom: 35px;
        }

        .tournament-card {
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 14px;
            padding: 22px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            position: relative;
            transition: all 0.2s;
        }

        .tournament-card:hover {
            border-color: var(--accent-blue);
            background: var(--card-hover);
            transform: translateY(-3px);
        }

        .card-top-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
        }

        .cup-id-badge {
            font-size: 11px;
            color: var(--text-muted);
            font-weight: 700;
            background: var(--bg-deep);
            padding: 3px 8px;
            border-radius: 6px;
            border: 1px solid var(--border-color);
        }

        .season-label {
            font-size: 11px;
            color: var(--accent-green);
            font-weight: 700;
        }

        .cup-title-area {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .cup-icon-box {
            width: 38px;
            height: 38px;
            background: rgba(0, 210, 255, 0.1);
            border: 1px solid rgba(0, 210, 255, 0.3);
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent-blue);
            font-size: 16px;
        }

        .cup-name {
            font-size: 18px;
            font-weight: 800;
            color: var(--text-main);
            margin: 0;
        }

        .cup-dates-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 12px;
            background: var(--bg-deep);
            padding: 12px;
            border-radius: 10px;
            border: 1px solid var(--border-color);
            margin-bottom: 20px;
        }

        .date-item span {
            display: block;
            font-size: 9.5px;
            text-transform: uppercase;
            color: var(--text-muted);
            font-weight: 700;
            margin-bottom: 3px;
            letter-spacing: 0.5px;
        }

        .date-item strong {
            font-size: 12px;
            color: var(--text-main);
            font-weight: 700;
        }

        .card-actions-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .btn-card-action {
            padding: 8px;
            border-radius: 8px;
            font-size: 12px;
            font-weight: 700;
            text-align: center;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.2s;
            border: 1px solid transparent;
        }

        .btn-edit-cup {
            background: rgba(0, 210, 255, 0.1);
            color: var(--accent-blue);
            border-color: rgba(0, 210, 255, 0.2);
        }
        .btn-edit-cup:hover {
            background: var(--accent-blue);
            color: #07090e;
        }

        .btn-delete-cup {
            background: rgba(255, 51, 102, 0.1);
            color: var(--accent-red);
            border-color: rgba(255, 51, 102, 0.2);
        }
        .btn-delete-cup:hover {
            background: var(--accent-red);
            color: #fff;
        }

        /* FOOTER BRANDING SECTION */
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

        @media(max-width: 1024px) {
            .tournaments-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media(max-width: 768px) {
            .tournaments-grid { grid-template-columns: 1fr; }
            .dashboard-footer { flex-direction: column; }
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                document.getElementById('themeBtnText').innerText = 'Light Mode';
            }
        });

        function toggleTheme() {
            document.body.classList.toggle('light-theme');
            let btnText = document.getElementById('themeBtnText');
            if (document.body.classList.contains('light-theme')) {
                localStorage.setItem('promatch_theme', 'light');
                btnText.innerText = 'Light Mode';
            } else {
                localStorage.setItem('promatch_theme', 'dark');
                btnText.innerText = 'Dark Mode';
            }
        }
    </script>
</head>
<body>

    <!-- TOP COMMAND BAR -->
    <div class="command-bar">
        <div class="command-left">
            <a href="/admin/home" class="command-link"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
            <button onclick="toggleTheme()" class="command-link"><i class="fa-solid fa-circle-half-stroke"></i> <span id="themeBtnText">Dark Mode</span></button>
        </div>
        <div class="command-right">
            <a href="/admin/deleteAllTournaments" class="btn-danger-outline" onclick="return confirm('WARNING: Are you sure you want to delete all tournaments?');"><i class="fa-solid fa-trash-can"></i> Delete All</a>
        </div>
    </div>

    <div class="container">

        <!-- HEADER TITLE SECTION WITH WAVING SHIMMER EFFECT -->
        <div class="section-header-flex">
            <div class="page-title-area">
                <h1>Tournament Command Center</h1>
            </div>
            <div class="total-cups-badge">
                Total Cups: <strong>${tournaments.size()}</strong>
            </div>
        </div>

        <!-- SEARCH & ACTION CONTROLS -->
        <div class="controls-row">
            <div class="search-box-wrapper">
                <i class="fa-solid fa-magnifying-glass"></i>
                <input type="text" class="search-input-field" placeholder="Search tournament by name...">
            </div>
            <div>
                <a href="/admin/addTournamentPage" class="btn-primary-glow"><i class="fa-solid fa-plus"></i> New Tournament</a>
            </div>
        </div>

        <!-- TOURNAMENTS GRID -->
        <div class="tournaments-grid">
            <c:forEach items="${tournaments}" var="t">
                <div class="tournament-card">
                    <div>
                        <div class="card-top-row">
                            <span class="cup-id-badge">#PTC-${t.id}</span>
                            <span class="season-label">Season ${t.season}</span>
                        </div>
                        <div class="cup-title-area">
                            <div class="cup-icon-box">
                                <i class="fa-solid fa-trophy"></i>
                            </div>
                            <h3 class="cup-name">${t.tournamentName}</h3>
                        </div>
                        <div class="cup-dates-grid">
                            <div class="date-item">
                                <span>Starts</span>
                                <strong>${t.startDate}</strong>
                            </div>
                            <div class="date-item">
                                <span>Ends</span>
                                <strong>${t.endDate}</strong>
                            </div>
                        </div>
                    </div>
                    <div class="card-actions-row">
                        <a href="/admin/editTournament/${t.id}" class="btn-card-action btn-edit-cup">EDIT CUP</a>
                        <a href="/admin/deleteTournament/${t.id}" class="btn-card-action btn-delete-cup" onclick="return confirm('Are you sure you want to delete this tournament?');">DELETE</a>
                    </div>
                </div>
            </c:forEach>

            <!-- Fallback Mock Cards if dynamic list is empty -->
            <c:if test="${empty tournaments}">
                <div class="tournament-card">
                    <div>
                        <div class="card-top-row"><span class="cup-id-badge">#PTC-4</span><span class="season-label">Season jpl11</span></div>
                        <div class="cup-title-area"><div class="cup-icon-box"><i class="fa-solid fa-trophy"></i></div><h3 class="cup-name">jpl</h3></div>
                        <div class="cup-dates-grid">
                            <div class="date-item"><span>Starts</span><strong>2026-08-10</strong></div>
                            <div class="date-item"><span>Ends</span><strong>2026-08-12</strong></div>
                        </div>
                    </div>
                    <div class="card-actions-row">
                        <a href="#" class="btn-card-action btn-edit-cup">EDIT CUP</a>
                        <a href="#" class="btn-card-action btn-delete-cup">DELETE</a>
                    </div>
                </div>
            </c:if>
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