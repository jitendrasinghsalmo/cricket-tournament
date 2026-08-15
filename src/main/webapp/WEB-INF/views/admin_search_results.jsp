<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Matrix Search Hub</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(10, 15, 28, 0.92);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --neon-purple: #c084fc;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.2);
            --body-overlay: rgba(3, 7, 18, 0.96);
            --tile-bg: rgba(15, 23, 42, 0.65);
        }

        body.light-theme {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.96);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --neon-purple: #9333ea;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --border-glass: rgba(2, 132, 199, 0.22);
            --body-overlay: rgba(241, 245, 249, 0.96);
            --tile-bg: rgba(248, 250, 252, 0.9);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 45px 20px 70px 20px; 
            box-sizing: border-box;
            position: relative;
            min-height: 100vh;
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* Top Navigation Controls */
        .top-back-btn {
            position: absolute; top: 25px; left: 25px;
            background: var(--card-surface); backdrop-filter: blur(15px);
            color: var(--neon-cyan); border: 1px solid var(--border-glass);
            padding: 10px 18px; border-radius: 12px; text-decoration: none;
            font-weight: 700; font-size: 13px; display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3); transition: all 0.2s ease; z-index: 100;
        }
        .top-back-btn:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }

        .theme-toggle-btn {
            position: absolute; top: 25px; right: 25px;
            background: var(--card-surface); backdrop-filter: blur(15px);
            color: var(--text-primary); border: 1px solid var(--border-glass);
            padding: 10px 16px; border-radius: 12px; font-size: 13px; font-weight: 700;
            cursor: pointer; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3); z-index: 100;
        }
        .theme-toggle-btn:hover { border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.4); }

        .container { max-width: 1300px; margin: 35px auto 0 auto; }

        .header-title-box { text-align: center; margin-bottom: 40px; }
        .matrix-title { color: var(--text-primary); margin: 0 0 6px 0; font-weight: 900; font-size: 28px; letter-spacing: 2px; text-transform: uppercase; }
        .matrix-title span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }
        .matrix-subtitle { color: var(--text-secondary); font-size: 13.5px; margin: 0; font-weight: 500; }

        /* Modern Matrix Bento Grid Layout */
        .matrix-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }
        @media(max-width: 950px) { .matrix-grid { grid-template-columns: 1fr; } }

        .matrix-card {
            background: var(--card-surface);
            backdrop-filter: blur(22px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 28px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
            position: relative;
            overflow: hidden;
        }

        .matrix-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
        }
        .card-teams::before { background: linear-gradient(90deg, var(--neon-emerald), #059669); }
        .card-tournaments::before { background: linear-gradient(90deg, var(--neon-amber), #d97706); }
        .card-matches::before { background: linear-gradient(90deg, var(--neon-rose), #e11d48); }
        .card-players::before { background: linear-gradient(90deg, var(--neon-purple), #9333ea); }

        .matrix-header {
            display: flex; justify-content: space-between; align-items: center;
            margin-bottom: 20px; padding-bottom: 12px; border-bottom: 1px solid var(--border-glass);
        }
        .matrix-header h3 {
            margin: 0; font-size: 16px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.8px; display: flex; align-items: center; gap: 10px; color: var(--text-primary);
        }
        .count-badge {
            background: var(--tile-bg); border: 1px solid var(--border-glass);
            padding: 4px 10px; border-radius: 8px; font-size: 12px; font-weight: 800; color: var(--neon-cyan);
        }

        /* List Items container */
        .items-list {
            display: flex; flex-direction: column; gap: 12px; max-height: 320px; overflow-y: auto; padding-right: 5px;
        }
        .items-list::-webkit-scrollbar { width: 5px; }
        .items-list::-webkit-scrollbar-thumb { background: var(--border-glass); border-radius: 10px; }

        .item-row {
            background: var(--tile-bg);
            border: 1px solid var(--border-glass);
            border-radius: 14px;
            padding: 14px 18px;
            display: flex; justify-content: space-between; align-items: center;
            transition: all 0.2s ease;
        }
        .item-row:hover {
            border-color: var(--neon-cyan);
            transform: translateX(4px);
            background: rgba(56, 189, 248, 0.05);
        }

        .item-main-text { font-weight: 700; font-size: 14px; color: var(--text-primary); display: flex; align-items: center; gap: 10px; }
        .item-sub-text { font-size: 12px; color: var(--text-secondary); font-weight: 600; }

        .tag-pill {
            background: rgba(56, 189, 248, 0.12); color: var(--neon-cyan);
            border: 1px solid rgba(56, 189, 248, 0.25); padding: 4px 10px;
            border-radius: 6px; font-size: 11px; font-weight: 800; text-transform: uppercase;
        }

        .no-record-box {
            text-align: center; color: var(--text-secondary); padding: 30px; font-size: 13.5px; font-style: italic;
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                let btn = document.getElementById('themeBtnText');
                if(btn) btn.innerText = 'Light';
            }
        });

        function toggleTheme() {
            document.body.classList.toggle('light-theme');
            let btnText = document.getElementById('themeBtnText');
            let btn = document.getElementById('themeToggleBtn');
            if (document.body.classList.contains('light-theme')) {
                localStorage.setItem('promatch_theme', 'light');
                if(btn) btn.innerHTML = '☀️ <span id="themeBtnText">Light</span>';
            } else {
                localStorage.setItem('promatch_theme', 'dark');
                if(btn) btn.innerHTML = '🌙 <span id="themeBtnText">Dark</span>';
            }
        }
    </script>
</head>
<body>

    <!-- Top Navigation Controls -->
    <a href="/admin/home" class="top-back-btn"><i class="fa-solid fa-arrow-left"></i> Dashboard</a>
    <button class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()">
        🌙 <span id="themeBtnText">Dark</span>
    </button>

    <div class="container">
        <div class="header-title-box">
            <h2 class="matrix-title">Query <span>Matrix Hub</span></h2>
            <p class="matrix-subtitle">Unified multi-entity structured search analysis system.</p>
        </div>

        <div class="matrix-grid">

            <!-- TEAMS MATRIX CARD -->
            <div class="matrix-card card-teams">
                <div class="matrix-header">
                    <h3><i class="fa-solid fa-shield-cat" style="color: var(--neon-emerald);"></i> Teams</h3>
                    <span class="count-badge">${teams.size()} Found</span>
                </div>
                <div class="items-list">
                    <c:forEach items="${teams}" var="team">
                        <div class="item-row">
                            <span class="item-main-text"><i class="fa-solid fa-flag" style="color: var(--neon-emerald); font-size: 12px;"></i> ${team.teamName}</span>
                            <span class="tag-pill" style="background: rgba(16,185,129,0.12); color: var(--neon-emerald); border-color: rgba(16,185,129,0.3);">Verified</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty teams}">
                        <div class="no-record-box">No matching teams registered.</div>
                    </c:if>
                </div>
            </div>

            <!-- TOURNAMENTS MATRIX CARD -->
            <div class="matrix-card card-tournaments">
                <div class="matrix-header">
                    <h3><i class="fa-solid fa-trophy" style="color: var(--neon-amber);"></i> Tournaments</h3>
                    <span class="count-badge">${tournaments.size()} Found</span>
                </div>
                <div class="items-list">
                    <c:forEach items="${tournaments}" var="t">
                        <div class="item-row">
                            <span class="item-main-text"><i class="fa-solid fa-award" style="color: var(--neon-amber); font-size: 12px;"></i> ${t.tournamentName}</span>
                            <span class="tag-pill" style="background: rgba(245,158,11,0.12); color: var(--neon-amber); border-color: rgba(245,158,11,0.3);">Active</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tournaments}">
                        <div class="no-record-box">No matching tournaments found.</div>
                    </c:if>
                </div>
            </div>

            <!-- MATCHES MATRIX CARD -->
            <div class="matrix-card card-matches">
                <div class="matrix-header">
                    <h3><i class="fa-solid fa-futbol" style="color: var(--neon-rose);"></i> Matches</h3>
                    <span class="count-badge">${matches.size()} Found</span>
                </div>
                <div class="items-list">
                    <c:forEach items="${matches}" var="m">
                        <div class="item-row">
                            <span class="item-main-text"><i class="fa-solid fa-location-dot" style="color: var(--neon-rose); font-size: 12px;"></i> Venue: ${m.venue}</span>
                            <span class="tag-pill" style="background: rgba(244,63,94,0.12); color: var(--neon-rose); border-color: rgba(244,63,94,0.3);">Scheduled</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty matches}">
                        <div class="no-record-box">No matching match fixtures found.</div>
                    </c:if>
                </div>
            </div>

            <!-- PLAYERS MATRIX CARD -->
            <div class="matrix-card card-players">
                <div class="matrix-header">
                    <h3><i class="fa-solid fa-users" style="color: var(--neon-purple);"></i> Players</h3>
                    <span class="count-badge">${players.size()} Found</span>
                </div>
                <div class="items-list">
                    <c:forEach items="${players}" var="p">
                        <div class="item-row">
                            <div>
                                <div class="item-main-text"><i class="fa-solid fa-user-ninja" style="color: var(--neon-purple); font-size: 12px;"></i> ${p.playerName}</div>
                                <div class="item-sub-text" style="margin-top: 2px;">Team: <span style="color: var(--text-primary);">${p.team != null ? p.team.teamName : 'N/A'}</span></div>
                            </div>
                            <span class="tag-pill" style="background: rgba(192,132,252,0.12); color: var(--neon-purple); border-color: rgba(192,132,252,0.3);">${p.role}</span>
                        </div>
                    </c:forEach>
                    <c:if test="${empty players}">
                        <div class="no-record-box">No matching player profiles found.</div>
                    </c:if>
                </div>
            </div>

        </div>
    </div>

</body>
</html>