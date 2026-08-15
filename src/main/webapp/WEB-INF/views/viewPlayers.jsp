<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Squad Roster</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.88);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.18);
            --body-overlay: rgba(3, 7, 18, 0.95);
            --search-bg: rgba(3, 7, 18, 0.7);
            --meta-box-bg: rgba(3, 7, 18, 0.55);
        }

        body.light-theme {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.95);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --border-glass: rgba(2, 132, 199, 0.22);
            --body-overlay: rgba(241, 245, 249, 0.96);
            --search-bg: rgba(255, 255, 255, 0.9);
            --meta-box-bg: rgba(248, 250, 252, 0.9);
        }

        * { box-sizing: border-box; }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 35px 20px 60px 20px; 
            transition: background 0.3s ease, color 0.3s ease;
        }
        
        .header-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            max-width: 1250px; margin: 0 auto 25px auto; 
            background: transparent;
            backdrop-filter: none;
            -webkit-backdrop-filter: none;
            padding: 16px 28px; border-radius: 18px; border: none; 
            box-shadow: none;
        }
        
        .header-left { display: flex; align-items: center; gap: 10px; }
        .header-right { display: flex; align-items: center; gap: 12px; }

        .btn-back { background: rgba(56, 189, 248, 0.08); color: var(--neon-cyan); border: 1px solid var(--border-glass); padding: 9px 16px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; cursor: pointer; }
        .btn-back:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }

        .btn-dashboard { background: rgba(16, 185, 129, 0.08); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3); padding: 9px 16px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .btn-dashboard:hover { background: var(--neon-emerald); color: #030712; box-shadow: 0 0 15px rgba(16, 185, 129, 0.4); }

        .theme-toggle-btn {
            background: var(--card-surface); color: var(--text-primary);
            border: 1px solid var(--border-glass); padding: 9px 14px;
            border-radius: 10px; font-size: 13px; font-weight: 700; cursor: pointer;
            transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
        }
        .theme-toggle-btn:hover { border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.3); }

        .jumping-title {
            text-align: center; color: var(--text-primary); margin: 0; font-weight: 900; font-size: 20px; letter-spacing: 1.5px; text-transform: uppercase;
            display: inline-block; white-space: nowrap;
        }
        .jumping-title span {
            display: inline-block; opacity: 0; transform: translateY(-25px);
            animation: dropInChar 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.04s * var(--i));
        }
        .jumping-title span.highlight { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.6); }

        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-25px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .control-bar {
            max-width: 1250px; margin: 0 auto 30px auto;
            display: flex; justify-content: space-between; align-items: center;
            background: var(--card-surface); backdrop-filter: blur(12px);
            padding: 12px 20px; border-radius: 14px; border: 1px solid var(--border-glass);
            flex-wrap: wrap; gap: 15px;
        }
        .search-input {
            background: var(--search-bg); border: 1px solid var(--border-glass);
            border-radius: 8px; padding: 9px 15px; color: var(--text-primary); font-size: 13px;
            width: 280px; outline: none; transition: 0.2s;
        }
        .search-input::placeholder { color: var(--text-secondary); }
        .search-input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(56,189,248,0.3); }
        
        .control-right { display: flex; align-items: center; gap: 12px; }
        .stats-badge { font-size: 12px; font-weight: 700; color: var(--text-secondary); background: var(--search-bg); padding: 7px 14px; border-radius: 8px; border: 1px solid var(--border-glass); }

        .btn-delete-all {
            background: rgba(244, 63, 94, 0.12); color: var(--neon-rose);
            border: 1px solid rgba(244, 63, 94, 0.3); padding: 8px 14px;
            border-radius: 8px; font-size: 12px; font-weight: 700; text-decoration: none;
            transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-delete-all:hover {
            background: var(--neon-rose); color: #fff;
            box-shadow: 0 0 15px rgba(244, 63, 94, 0.4);
        }

        .team-stats-section { max-width: 1250px; margin: 40px auto; }
        .section-title {
            font-size: 16px; font-weight: 800; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px;
            margin-bottom: 20px; padding-left: 8px;
            border-left: 4px solid var(--neon-cyan);
        }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
        @media(max-width: 1024px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .stats-grid { grid-template-columns: 1fr; } }

        .stat-box {
            background: var(--card-surface); backdrop-filter: blur(12px);
            border: 1px solid var(--border-glass); border-radius: 16px;
            padding: 20px; text-align: center; transition: all 0.3s ease;
            box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        }
        .stat-box:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-5px);
            box-shadow: 0 12px 30px rgba(56, 189, 248, 0.2);
        }
        .stat-number { font-size: 28px; font-weight: 800; color: var(--neon-cyan); margin-bottom: 6px; }
        .stat-label { font-size: 12px; font-weight: 600; color: var(--text-secondary); text-transform: uppercase; }

        .role-breakdown-section { max-width: 1250px; margin: 40px auto; }
        .role-cards-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 16px; }
        @media(max-width: 1024px) { .role-cards-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .role-cards-grid { grid-template-columns: 1fr; } }

        .role-card {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.08), rgba(16, 185, 129, 0.08));
            border: 1.5px solid var(--border-glass); border-radius: 16px;
            padding: 22px; text-align: center; transition: all 0.3s ease;
        }
        .role-card:hover { border-color: var(--neon-cyan); transform: translateY(-6px); }
        .role-title { font-size: 14px; font-weight: 700; color: var(--text-primary); text-transform: uppercase; margin-bottom: 8px; }
        .role-count { font-size: 24px; font-weight: 800; color: var(--neon-emerald); }

        .squad-highlight-section {
            max-width: 1250px; margin: 40px auto;
            background: var(--card-surface); backdrop-filter: blur(12px);
            border: 1px solid var(--border-glass); border-radius: 20px;
            padding: 32px; box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        .highlight-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 24px; align-items: center; }
        @media(max-width: 968px) { .highlight-grid { grid-template-columns: 1fr; } }
        .highlight-info h3 { font-size: 18px; font-weight: 800; color: var(--text-primary); margin: 0 0 10px 0; }
        .highlight-info p { font-size: 13px; color: var(--text-secondary); line-height: 1.6; margin: 0 0 16px 0; }
        .highlight-badges { display: flex; gap: 10px; flex-wrap: wrap; }
        .badge {
            background: rgba(56, 189, 248, 0.15); color: var(--neon-cyan);
            border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 20px;
            padding: 6px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase;
        }
        .badge.emerald { background: rgba(16, 185, 129, 0.15); color: var(--neon-emerald); border-color: rgba(16, 185, 129, 0.3); }
        .badge.amber { background: rgba(245, 158, 11, 0.15); color: var(--neon-amber); border-color: rgba(245, 158, 11, 0.3); }

        .highlight-stat { background: var(--meta-box-bg); border: 1px solid var(--border-glass); border-radius: 12px; padding: 16px; text-align: center; }
        .highlight-stat-value { font-size: 26px; font-weight: 800; color: var(--neon-cyan); }
        .highlight-stat-label { font-size: 11px; color: var(--text-secondary); text-transform: uppercase; margin-top: 6px; font-weight: 600; }

        /* PLAYERS GRID */
        .players-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 28px; max-width: 1250px; margin: 40px auto 0 auto; }
        @media(max-width: 1024px) { .players-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .players-grid { grid-template-columns: 1fr; } }
        
        .player-card {
            background: var(--card-surface); backdrop-filter: blur(18px);
            border-radius: 22px; border: 1px solid var(--border-glass);
            box-shadow: 0 15px 35px rgba(0,0,0,0.35); position: relative; overflow: hidden;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex; flex-direction: column; justify-content: space-between;
        }
        .player-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }
        .player-card:hover { transform: translateY(-8px); border-color: var(--neon-cyan); box-shadow: 0 22px 50px rgba(56, 189, 248, 0.25); }

        .card-top-banner { padding: 20px 22px 10px 22px; display: flex; align-items: center; justify-content: space-between; }
        .player-avatar-box {
            width: 54px; height: 54px; border-radius: 16px;
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.15), rgba(16, 185, 129, 0.15));
            border: 1px solid var(--border-glass); color: var(--neon-cyan);
            display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 20px;
        }
        .jersey-pill {
            font-size: 13px; font-weight: 800; color: var(--neon-amber);
            background: rgba(245, 158, 11, 0.12); padding: 5px 12px;
            border-radius: 20px; border: 1px solid rgba(245, 158, 11, 0.3);
        }

        .card-body { padding: 10px 22px 22px 22px; display: flex; flex-direction: column; gap: 14px; }
        .player-name-title { font-size: 19px; font-weight: 800; color: var(--text-primary); }
        .player-id-tag { font-size: 11px; font-weight: 700; color: var(--text-secondary); margin-top: 2px; text-transform: uppercase; }

        .specs-matrix { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .spec-cell { background: var(--meta-box-bg); border: 1px solid var(--border-glass); border-radius: 12px; padding: 10px 14px; font-size: 11.5px; color: var(--text-secondary); }
        .spec-cell span { display: block; color: var(--text-primary); font-weight: 700; font-size: 12.5px; margin-top: 3px; }

        .card-actions { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-top: 6px; }
        .card-actions a {
            text-align: center; text-decoration: none; padding: 10px; border-radius: 11px;
            font-size: 12px; font-weight: 700; transition: all 0.2s ease; text-transform: uppercase;
        }
        .btn-edit { background: rgba(56, 189, 248, 0.1); color: var(--neon-cyan); border: 1px solid rgba(56, 189, 248, 0.3); }
        .btn-edit:hover { background: var(--neon-cyan); color: #030712; }
        .btn-delete { background: rgba(244, 63, 94, 0.1); color: var(--neon-rose); border: 1px solid rgba(244, 63, 94, 0.3); }
        .btn-delete:hover { background: var(--neon-rose); color: #fff; }

        .btn-add-player {
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff; border: 1px solid rgba(56, 189, 248, 0.4);
            display: inline-flex; justify-content: center; align-items: center;
            padding: 9px 18px; border-radius: 12px; font-size: 12px; font-weight: 800;
            text-decoration: none; transition: all 0.25s ease; text-transform: uppercase;
        }
        .btn-add-player:hover { transform: translateY(-2px); background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); }

        /* GALLERY SECTION (ABOVE FOOTER) */
        .gallery-section {
            max-width: 1250px;
            margin: 50px auto 30px auto;
        }
        .footer-gallery-grid {
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 25px; 
            perspective: 1000px;
        }
        @media(max-width: 768px) { .footer-gallery-grid { grid-template-columns: 1fr; } }

        .gallery-clean-card {
            background: rgba(20, 25, 40, 0.95);
            border-radius: 16px; overflow: hidden;
            border: 1px solid var(--border-glass);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transform-style: preserve-3d;
            animation: smoothInfiniteSpin 10s linear infinite;
            display: flex; flex-direction: column;
        }
        @keyframes smoothInfiniteSpin {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(360deg); }
        }
        .gallery-clean-card:hover { animation-play-state: paused; border-color: var(--neon-cyan); }
        .gallery-card-content { padding: 16px; text-align: center; background: rgba(13, 18, 30, 0.5); order: 1; }
        .gallery-card-content h4 { margin: 0 0 6px 0; font-size: 14.5px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; }
        .gallery-card-content p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.5; }
        .gallery-card-img-wrapper { width: 100%; height: 170px; overflow: hidden; background: #020617; order: 2; }
        .gallery-card-img-wrapper img { width: 100%; height: 100%; object-fit: cover; object-position: top; display: block; }

        /* GRAND FOOTER SECTION */
        .grand-footer-section {
            background: var(--card-surface);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            max-width: 1250px;
            margin: 0 auto;
        }
        .grand-footer-content {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 30px; align-items: start;
        }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 768px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }

        .footer-brand h3 { margin: 0 0 8px 0; font-size: 18px; font-weight: 800; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1px; }
        .footer-brand h3 span { color: var(--neon-cyan); }
        .footer-brand p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.6; }

        .footer-links h4 { margin: 0 0 12px 0; font-size: 13px; font-weight: 700; text-transform: uppercase; color: var(--text-primary); letter-spacing: 0.5px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 10px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 12.5px; font-weight: 600; transition: color 0.2s; }
        .footer-links a:hover { color: var(--neon-cyan); }

        .footer-bottom-bar { text-align: center; color: var(--text-secondary); font-size: 11.5px; margin-top: 30px; border-top: 1px dashed var(--border-glass); padding-top: 20px; }
        .no-player { text-align: center; color: var(--text-secondary); grid-column: 1 / -1; padding: 60px; font-size: 15px; background: var(--card-surface); border-radius: 18px; border: 1px solid var(--border-glass); }
    </style>
</head>
<body>

    <div class="header-bar">
        <div class="header-left">
            <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            
            <c:choose>
                <c:when test="${sessionScope.user.role.name() == 'ADMIN' || sessionScope.user.role.name() == 'ROLE_ADMIN'}">
                    <a href="${pageContext.request.contextPath}/admin/home" class="btn-dashboard">
                        <i class="fa-solid fa-gauge"></i> Admin Dashboard
                    </a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/home" class="btn-dashboard">
                        <i class="fa-solid fa-house"></i> Home
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
        
        <div>
            <h2 class="jumping-title" id="animatedTitle">Team Players Roster</h2>
        </div>

        <div class="header-right">
            <button class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()">
                🌙 <span id="themeBtnText">Dark</span>
            </button>
            <a href="${pageContext.request.contextPath}/addPlayer/${teamId}" class="btn-add-player"><i class="fa-solid fa-plus"></i> Add Player</a>
        </div>
    </div>

    <div class="control-bar">
        <input type="text" id="playerSearch" class="search-input" placeholder="🔍 Search player by name..." onkeyup="filterPlayers()" autocomplete="off">
        
        <div class="control-right">
            <c:if test="${not empty players}">
                <a href="${pageContext.request.contextPath}/deleteAllPlayers/${teamId}" class="btn-delete-all" onclick="return confirm('⚠️ DANGER: Delete all players from this squad permanently?');">
                    <i class="fa-solid fa-trash-can"></i> Delete All Squad
                </a>
            </c:if>
            <div class="stats-badge">Total Squad: <span style="color: var(--neon-cyan); font-weight: 800;">${players.size()}</span></div>
        </div>
    </div>

    <!-- SECTION 1: TEAM STATS OVERVIEW -->
    <c:if test="${not empty players}">
        <div class="team-stats-section">
            <h3 class="section-title">📊 Squad Overview</h3>
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-number">${players.size()}</div>
                    <div class="stat-label">Total Players</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Active Roles</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">100%</div>
                    <div class="stat-label">Squad Ready</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">A+</div>
                    <div class="stat-label">Performance</div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- SECTION 2: ROLE BREAKDOWN -->
    <c:if test="${not empty players}">
        <div class="role-breakdown-section">
            <h3 class="section-title">🎪 Role Distribution</h3>
            <div class="role-cards-grid">
                <div class="role-card">
                    <div class="role-title">Batsman</div>
                    <div class="role-count">4</div>
                </div>
                <div class="role-card">
                    <div class="role-title">Bowler</div>
                    <div class="role-count">3</div>
                </div>
                <div class="role-card">
                    <div class="role-title">All-Rounder</div>
                    <div class="role-count">2</div>
                </div>
                <div class="role-card">
                    <div class="role-title">Wicket Keeper</div>
                    <div class="role-count">1</div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- SECTION 3: SQUAD HIGHLIGHT -->
    <c:if test="${not empty players}">
        <div class="squad-highlight-section">
            <h3 class="section-title">✨ Squad Highlights</h3>
            <div class="highlight-grid">
                <div class="highlight-info">
                    <h3>🔥 Championship Ready Squad</h3>
                    <p>Your squad is fully equipped with experienced players, strong team chemistry, and strategic depth. Ready to dominate the tournament with aggressive batting, powerful bowling, and solid fielding.</p>
                    <div class="highlight-badges">
                        <span class="badge">Experienced</span>
                        <span class="badge emerald">Balanced</span>
                        <span class="badge amber">Powerful</span>
                    </div>
                </div>
                <div class="highlight-stat">
                    <div class="highlight-stat-value">${players.size()}</div>
                    <div class="highlight-stat-label">Players Active</div>
                </div>
                <div class="highlight-stat">
                    <div class="highlight-stat-value">A+</div>
                    <div class="highlight-stat-label">Squad Rating</div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- PLAYERS GRID -->
    <div class="players-grid" id="playersGrid">
        <c:forEach items="${players}" var="p">
            <div class="player-card" data-name="${p.playerName.toLowerCase()}">
                
                <div class="card-top-banner">
                    <div class="player-avatar-box">
                        ${p.playerName.substring(0,1).toUpperCase()}
                    </div>
                    <span class="jersey-pill">👕 #${p.jerseyNumber}</span>
                </div>

                <div class="card-body">
                    <div>
                        <div class="player-name-title" title="${p.playerName}">${p.playerName}</div>
                        <div class="player-id-tag">Player ID: #PL-${p.id}</div>
                    </div>

                    <div class="specs-matrix">
                        <div class="spec-cell">Role <span>${p.role}</span> &nbsp;</div>
                        <div class="spec-cell">Age <span>${p.age} yrs</span></div>
                        <div class="spec-cell">Batting <span>${p.battingStyle}</span></div>
                        <div class="spec-cell">Bowling <span>${p.bowlingStyle}</span></div>
                    </div>
                    
                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/editPlayer/${p.id}" class="btn-edit">Edit</a>
                        <a href="${pageContext.request.contextPath}/deletePlayer/${p.id}?teamId=${teamId}" class="btn-delete" onclick="return confirm('⚠️ Delete this player?');">Delete</a>
                    </div>
                </div>

            </div>
        </c:forEach>
        
        <c:if test="${empty players}">
            <div class="no-player">
                No active players registered in this squad yet. 
                <br><br>
                <a href="${pageContext.request.contextPath}/addPlayer/${teamId}" style="color: var(--neon-cyan); font-weight: 700; text-decoration: none;">Click here to add the first player ➡</a>
            </div>
        </c:if>
    </div>

    <!-- GALLERY SECTION (ABOVE FOOTER) -->
    <div class="gallery-section">
        <div class="footer-gallery-grid">
            <div class="gallery-clean-card">
                <div class="gallery-card-content">
                    <h4>🏟️ Floodlit Stadium</h4>
                    <p>World-class arena illumination designed for grand cricket spectacles.</p>
                </div>
                <div class="gallery-card-img-wrapper">
                    <img src="https://wallpapers.ipl.com/files/preview/1280x925/465931758006175mirdxujrcngeqt4dbgwhwripvt0dwtcq3ffrkeqcfxxsrjb9nf5iyyjivqvksbmaoivkke3nmrodztmqh1cnaviorxhug3biicag.jpg" alt="Stadium">
                </div>
            </div>
            
            <div class="gallery-clean-card">
                <div class="gallery-card-content">
                    <h4>⚡ High-Voltage Action</h4>
                    <p>Witness raw power-hitting, fierce bowling spells, and epic last-over finishes.</p>
                </div>
                <div class="gallery-card-img-wrapper">
                    <img src="https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_lg_2x/f_auto/primary/ugvcvyuorglkafijaz4x" alt="Action">
                </div>
            </div>
            
            <div class="gallery-clean-card">
                <div class="gallery-card-content">
                    <h4>🎯 Team Spirit</h4>
                    <p>United by passion, discipline, and the pursuit of ultimate tournament glory.</p>
                </div>
                <div class="gallery-card-img-wrapper">
                    <img src="https://c8.alamy.com/comp/2RPC34J/members-of-the-team-india-sings-national-anthem-before-the-asia-cup-cricket-match-between-india-and-nepal-in-pallekele-sri-lanka-on-monday-sep-4-ap-photoeranga-jayawardena-2RPC34J.jpg" alt="Team">
                </div>
            </div>
        </div>
    </div>

    <!-- GRAND FOOTER SECTION (NO IMAGES INSIDE) -->
    <div class="grand-footer-section">
        <div class="grand-footer-content">
            <div class="footer-brand">
                <h3><span>ProMatch</span> Arena</h3>
                <p>Advanced Enterprise Cricket Tournament & Match Control Center. Built with Spring Boot, JSP, and PostgreSQL to deliver high-performance sports analytics.</p>
            </div>
            
            <div class="footer-links">
                <h4>Quick Navigation</h4>
                <ul>
                    <li><a href="/home">🏠 Home Dashboard</a></li>
                    <li><a href="/teams">👥 View Teams</a></li>
                    <li><a href="/register-team">➕ Register Team</a></li>
                    <li><a href="/matches">⚡ Live Matches</a></li>
                    <li><a href="/tournaments">🏆 Tournaments</a></li>
                </ul>
            </div>

            <div class="footer-links">
                <h4>Standings & Stats</h4>
                <ul>
                    <li><a href="/pointsTable">📊 Points Table</a></li>
                    <li><a href="/about">📖 About Architecture</a></li>
                </ul>
            </div>

            <div class="footer-links">
                <h4>Legal & Support</h4>
                <ul>
                    <li><a href="/faq">❓ FAQ Help Center</a></li>
                    <li><a href="/privacy-policy">🔒 Privacy Policy</a></li>
                    <li><a href="/terms-and-conditions">📄 Terms & Conditions</a></li>
                    <li><a href="/contact">📞 Contact Us</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom-bar">
            <p>&copy; 2026 ProMatch Arena &bull; All Rights Reserved. Crafted with high-end Cyber Glassmorphism UI.</p>
        </div>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function() {
            const titleEl = document.getElementById('animatedTitle');
            if (titleEl) {
                const textWords = titleEl.innerText;
                titleEl.innerHTML = textWords.split('').map(function(char, index) {
                    if (char === ' ') return '<span style="--i:' + index + '">&nbsp;</span>';
                    let highlightClass = (index < 4) ? 'highlight' : '';
                    return '<span class="' + highlightClass + '" style="--i:' + index + '">' + char + '</span>';
                }).join('');
            }

            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                document.getElementById('themeToggleBtn').innerHTML = '☀️ <span id="themeBtnText">Light</span>';
            }
        });

        function toggleTheme() {
            document.body.classList.toggle('light-theme');
            let btn = document.getElementById('themeToggleBtn');
            if (document.body.classList.contains('light-theme')) {
                localStorage.setItem('promatch_theme', 'light');
                btn.innerHTML = '☀️ <span id="themeBtnText">Light</span>';
            } else {
                localStorage.setItem('promatch_theme', 'dark');
                btn.innerHTML = '🌙 <span id="themeBtnText">Dark</span>';
            }
        }

        function filterPlayers() {
            let input = document.getElementById('playerSearch').value.toLowerCase().trim();
            let cards = document.getElementsByClassName('player-card');
            let visibleCount = 0;

            for (let i = 0; i < cards.length; i++) {
                let name = cards[i].getAttribute('data-name');
                if (input === "" || name.indexOf(input) > -1) {
                    cards[i].style.display = "";
                    visibleCount++;
                } else {
                    cards[i].style.display = "none";
                }
            }
            
            let statsSpan = document.querySelector('.stats-badge span');
            if(statsSpan) statsSpan.innerText = visibleCount;
        }
    </script>

</body>
</html>