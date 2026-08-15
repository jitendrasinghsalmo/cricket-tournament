<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ProMatch Arena | Teams Directory</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.78);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.85);
        }

        body.light-mode {
            --bg-deep: #f8fafc;
            --card-surface: rgba(255, 255, 255, 0.85);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: rgba(2, 132, 199, 0.25);
            --body-overlay: rgba(241, 245, 249, 0.85);
        }

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
        
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-right { display: flex; align-items: center; gap: 10px; }

        .btn-back { background: rgba(56, 189, 248, 0.08); color: var(--neon-cyan); border: 1px solid var(--border-glass); padding: 9px 18px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s ease; }
        .btn-back:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }
        
        .btn-theme-toggle {
            background: var(--card-surface); color: var(--text-primary);
            border: 1px solid var(--border-glass); padding: 9px 15px;
            border-radius: 10px; font-weight: 700; font-size: 13px;
            cursor: pointer; display: inline-flex; align-items: center; gap: 6px;
            transition: all 0.2s ease;
        }
        .btn-theme-toggle:hover { border-color: var(--neon-cyan); color: var(--neon-cyan); }

        .btn-top-add {
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            padding: 9px 16px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            transition: all 0.2s ease;
        }
        .btn-top-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .btn-delete-all {
            background: rgba(244, 63, 94, 0.1); color: var(--neon-rose);
            border: 1px solid rgba(244, 63, 94, 0.3); padding: 9px 18px;
            border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px;
            transition: all 0.2s ease;
        }
        .btn-delete-all:hover { background: var(--neon-rose); color: #fff; box-shadow: 0 0 15px rgba(244, 63, 94, 0.4); }

        .jumping-title {
            text-align: center; color: var(--text-primary); margin: 0; font-weight: 900; font-size: 20px; letter-spacing: 1.5px; text-transform: uppercase;
            display: inline-block;
            white-space: nowrap;
        }
        .jumping-title span {
            display: inline-block;
            opacity: 0;
            transform: translateY(-25px);
            animation: dropInChar 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.04s * var(--i));
        }
        .jumping-title span.highlight {
            color: var(--neon-cyan);
            text-shadow: 0 0 15px rgba(56, 189, 248, 0.6);
        }

        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-25px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .control-bar {
            max-width: 1250px; margin: 0 auto 30px auto;
            display: flex; justify-content: space-between; align-items: center;
            background: var(--card-surface); backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 12px 20px; border-radius: 14px; border: 1px solid var(--border-glass);
        }
        .search-input {
            background: rgba(3, 7, 18, 0.45); border: 1px solid var(--border-glass);
            border-radius: 8px; padding: 8px 14px; color: #fff; font-size: 13px;
            width: 280px; outline: none; transition: 0.2s;
        }
        .search-input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(56,189,248,0.3); }
        .stats-badge { font-size: 12px; font-weight: 700; color: var(--text-secondary); background: rgba(255,255,255,0.04); padding: 6px 12px; border-radius: 8px; border: 1px solid var(--border-glass); }

        .league-stats-section { max-width: 1250px; margin: 40px auto; }
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
        .stat-box:hover { border-color: var(--neon-cyan); transform: translateY(-5px); }
        .stat-icon { font-size: 28px; margin-bottom: 10px; }
        .stat-number { font-size: 28px; font-weight: 800; color: var(--neon-cyan); margin-bottom: 6px; }
        .stat-label { font-size: 12px; font-weight: 600; color: var(--text-secondary); text-transform: uppercase; }

        .top-teams-section { max-width: 1250px; margin: 40px auto; }
        .top-teams-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        @media(max-width: 1024px) { .top-teams-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .top-teams-grid { grid-template-columns: 1fr; } }

        .top-team-card {
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.08), rgba(16, 185, 129, 0.08));
            border: 1.5px solid var(--border-glass); border-radius: 18px;
            padding: 24px; text-align: center; transition: all 0.3s ease;
        }
        .top-team-card:hover { border-color: var(--neon-cyan); transform: translateY(-6px); }
        .rank-badge {
            display: inline-block; width: 40px; height: 40px; border-radius: 50%;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #030712; font-weight: 900; font-size: 18px;
            display: flex; align-items: center; justify-content: center;
            margin-bottom: 12px;
        }
        .top-team-name { font-size: 16px; font-weight: 800; color: var(--text-primary); margin-bottom: 8px; text-transform: uppercase; }
        .team-win-rate { font-size: 24px; font-weight: 800; color: var(--neon-emerald); margin-bottom: 4px; }
        .team-metric { font-size: 11px; color: var(--text-secondary); text-transform: uppercase; font-weight: 600; }

        .tournament-status-section {
            max-width: 1250px; margin: 40px auto;
            background: var(--card-surface); backdrop-filter: blur(12px);
            border: 1px solid var(--border-glass); border-radius: 20px;
            padding: 32px; box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        .tournament-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 24px; align-items: center; }
        @media(max-width: 968px) { .tournament-grid { grid-template-columns: 1fr; } }
        .tournament-info h3 { font-size: 18px; font-weight: 800; color: var(--text-primary); margin: 0 0 10px 0; }
        .tournament-info p { font-size: 13px; color: var(--text-secondary); line-height: 1.6; margin: 0 0 16px 0; }
        .tournament-badges { display: flex; gap: 10px; flex-wrap: wrap; }
        .tournament-badge {
            background: rgba(56, 189, 248, 0.15); color: var(--neon-cyan);
            border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 20px;
            padding: 6px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase;
        }
        .tournament-badge.emerald { background: rgba(16, 185, 129, 0.15); color: var(--neon-emerald); border-color: rgba(16, 185, 129, 0.3); }
        .tournament-badge.amber { background: rgba(245, 158, 11, 0.15); color: var(--neon-amber); border-color: rgba(245, 158, 11, 0.3); }

        .tournament-stat { background: rgba(3, 7, 18, 0.55); border: 1px solid var(--border-glass); border-radius: 12px; padding: 16px; text-align: center; }
        .tournament-stat-value { font-size: 26px; font-weight: 800; color: var(--neon-cyan); }
        .tournament-stat-label { font-size: 11px; color: var(--text-secondary); text-transform: uppercase; margin-top: 6px; font-weight: 600; }

        .activity-section { max-width: 1250px; margin: 40px auto; }
        .activity-feed { display: grid; grid-template-columns: 1fr; gap: 16px; }
        .activity-item {
            background: var(--card-surface); backdrop-filter: blur(12px);
            border: 1px solid var(--border-glass); border-radius: 14px;
            padding: 18px; display: flex; gap: 16px; transition: all 0.3s ease;
        }
        .activity-item:hover { border-color: var(--neon-cyan); }
        .activity-icon {
            width: 44px; height: 44px; border-radius: 12px;
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.2), rgba(16, 185, 129, 0.2));
            display: flex; align-items: center; justify-content: center; font-size: 20px; flex-shrink: 0;
        }
        .activity-title { font-size: 14px; font-weight: 700; color: var(--text-primary); margin: 0 0 4px 0; }
        .activity-desc { font-size: 12px; color: var(--text-secondary); margin: 0 0 6px 0; }
        .activity-time { font-size: 10px; color: var(--neon-cyan); font-weight: 600; text-transform: uppercase; }

        .quick-stats-section { max-width: 1250px; margin: 40px auto; }
        .quick-stats-row { display: grid; grid-template-columns: repeat(5, 1fr); gap: 14px; }
        @media(max-width: 1024px) { .quick-stats-row { grid-template-columns: repeat(3, 1fr); } }
        @media(max-width: 768px) { .quick-stats-row { grid-template-columns: 1fr; } }
        .quick-stat-card {
            background: var(--card-surface); backdrop-filter: blur(12px);
            border: 1px solid var(--border-glass); border-radius: 14px;
            padding: 16px; text-align: center; transition: all 0.3s ease;
        }
        .quick-stat-card:hover { border-color: var(--neon-cyan); transform: translateY(-4px); }
        .quick-stat-icon { font-size: 24px; margin-bottom: 8px; }
        .quick-stat-value { font-size: 20px; font-weight: 800; color: var(--neon-cyan); margin-bottom: 4px; }
        .quick-stat-name { font-size: 10px; color: var(--text-secondary); text-transform: uppercase; font-weight: 600; }

        .teams-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 35px 30px; max-width: 1250px; margin: 40px auto; }
        @media(max-width: 1024px) { .teams-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .teams-grid { grid-template-columns: 1fr; } }
        
        .team-card {
            background: var(--card-surface); backdrop-filter: blur(15px);
            border-radius: 22px; border: 1px solid var(--border-glass);
            box-shadow: 0 20px 40px rgba(0,0,0,0.35); position: relative; overflow: hidden;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex; flex-direction: column;
        }
        .team-card:hover { transform: translateY(-8px); border-color: var(--neon-cyan); box-shadow: 0 25px 50px rgba(56, 189, 248, 0.25); }

        .card-banner {
            height: 75px; background: linear-gradient(135deg, rgba(56, 189, 248, 0.25), rgba(16, 185, 129, 0.2));
            border-bottom: 1px solid var(--border-glass); display: flex; justify-content: space-between; align-items: flex-start; padding: 12px 18px;
        }
        .team-id-badge {
            font-size: 10px; font-weight: 800; color: var(--neon-cyan);
            background: rgba(3, 7, 18, 0.7); padding: 4px 10px; border-radius: 20px; border: 1px solid rgba(56, 189, 248, 0.3);
        }

        .card-body-section { padding: 0 22px 22px 22px; margin-top: -38px; display: flex; flex-direction: column; gap: 16px; }
        .logo-title-row { display: flex; align-items: flex-end; gap: 16px; }
        .team-logo-avatar {
            width: 82px; height: 82px; border-radius: 20px; object-fit: cover;
            border: 3px solid var(--card-surface); background: #0b0f19;
            box-shadow: 0 10px 25px rgba(0,0,0,0.4); transition: transform 0.3s ease;
        }
        .team-card:hover .team-logo-avatar { transform: scale(1.05); border-color: var(--neon-cyan); }
        .team-title-wrap { flex: 1; padding-bottom: 4px; }
        .team-name { font-size: 18px; font-weight: 900; color: var(--text-primary); letter-spacing: 0.5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .team-city { font-size: 12px; font-weight: 700; color: var(--neon-cyan); margin-top: 2px; }

        .info-pods { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .pod { background: rgba(3, 7, 18, 0.4); border: 1px solid var(--border-glass); border-radius: 12px; padding: 10px 12px; display: flex; flex-direction: column; gap: 2px; }
        .pod-label { font-size: 9.5px; text-transform: uppercase; font-weight: 700; color: var(--text-secondary); }
        .pod-val { font-size: 12px; font-weight: 700; color: var(--text-primary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

        .card-actions { display: grid; grid-template-columns: 1.4fr 1fr 1fr; gap: 8px; padding-top: 5px; }
        .card-actions a {
            text-align: center; text-decoration: none; padding: 9px 4px; border-radius: 10px;
            font-size: 10.5px; font-weight: 700; transition: all 0.2s ease; text-transform: uppercase; letter-spacing: 0.2px; white-space: nowrap;
        }
        .btn-view { background: rgba(16, 185, 129, 0.1); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3); }
        .btn-view:hover { background: var(--neon-emerald); color: #030712; }
        .btn-edit { background: rgba(56, 189, 248, 0.1); color: var(--neon-cyan); border: 1px solid rgba(56, 189, 248, 0.3); }
        .btn-edit:hover { background: var(--neon-cyan); color: #030712; }
        .btn-delete { background: rgba(244, 63, 94, 0.1); color: var(--neon-rose); border: 1px solid rgba(244, 63, 94, 0.3); }
        .btn-delete:hover { background: var(--neon-rose); color: #fff; }

        .pagination-bar {
            display: flex; justify-content: flex-end; align-items: center; gap: 20px;
            background: transparent; border: none; max-width: 1250px;
            margin: 50px auto 25px auto; padding: 14px 28px; box-sizing: border-box;
        }
        .pagination-bar a {
            padding: 8px 18px; background: var(--neon-cyan); color: #030712;
            border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 12px; transition: all 0.2s;
        }
        .pagination-bar a:hover { transform: translateY(-2px); box-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }
        .page-indicator { font-size: 13px; font-weight: 700; color: var(--text-secondary); }

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

        .gallery-card-item {
            background: rgba(20, 25, 40, 0.85);
            border-radius: 16px; overflow: hidden;
            border: 1px solid var(--border-glass);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: transform 0.6s cubic-bezier(0.4, 0, 0.2, 1), box-shadow 0.6s ease;
            transform-style: preserve-3d;
            animation: fastSpinThreeTimes 1.5s cubic-bezier(0.4, 0, 0.2, 1) 1;
            display: flex; flex-direction: column;
        }
        @keyframes fastSpinThreeTimes {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(1080deg); }
        }
        .gallery-card-item:hover { transform: rotateY(180deg) scale(1.03); border-color: var(--neon-cyan); }
        .gallery-card-content { padding: 16px; text-align: center; background: rgba(13, 18, 30, 0.5); order: 1; }
        .gallery-card-content h4 { margin: 0 0 6px 0; font-size: 14.5px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; }
        .gallery-card-content p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.5; }
        .gallery-card-img-wrapper { width: 100%; height: 170px; overflow: hidden; background: #020617; order: 2; }
        .gallery-card-img-wrapper img { width: 100%; height: 100%; object-fit: cover; object-position: top; display: block; }

        /* GRAND FOOTER SECTION */
        .grand-footer-section {
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
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
        .no-team { text-align: center; color: var(--text-secondary); grid-column: 1 / -1; padding: 60px; font-size: 15px; background: var(--card-surface); border-radius: 18px; border: 1px solid var(--border-glass); }
    </style>
</head>
<body>

    <div class="header-bar">
        <div class="header-left">
            <a href="/home" class="btn-back">⬅ Dashboard</a>
            <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
        </div>
        
        <div>
            <h2 class="jumping-title" id="animatedTitle">Teams Directory</h2>
        </div>

        <div class="header-right">
            <a href="/register-team" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Team</a>
            <a href="/deleteAllTeams" class="btn-delete-all" onclick="return confirm('⚠️ Warning: Delete ALL teams permanently?')">🗑 Delete All</a>
        </div>
    </div>

    <div class="control-bar">
        <input type="text" id="teamSearch" class="search-input" placeholder="🔍 Search team by name or city..." onkeyup="filterTeams()" autocomplete="off">
        <div class="stats-badge">Total Teams: <span style="color: var(--neon-cyan); font-weight: 800;">${totalItems}</span></div>
    </div>

    <!-- SECTION 1: LEAGUE STATISTICS -->
    <c:if test="${not empty teams}">
        <div class="league-stats-section">
            <h3 class="section-title">📊 League Overview</h3>
            <div class="stats-grid">
                <div class="stat-box">
                    <div class="stat-number">${teams.size()}</div>
                    <div class="stat-label">Total Teams</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">42</div>
                    <div class="stat-label">Total Players</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">15</div>
                    <div class="stat-label">Matches Played</div>
                </div>
                <div class="stat-box">
                    <div class="stat-number">3</div>
                    <div class="stat-label">Tournaments</div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- SECTION 2: TOP PERFORMING TEAMS -->
    <c:if test="${not empty teams}">
        <div class="top-teams-section">
            <h3 class="section-title">🏅 Top Performing Teams</h3>
            <div class="top-teams-grid">
                <div class="top-team-card">
                    <div class="rank-badge">1</div>
                    <div class="top-team-name">Thunder Strikers</div>
                    <div class="team-win-rate">75%</div>
                    <div class="team-metric">Win Rate</div>
                </div>
                <div class="top-team-card">
                    <div class="rank-badge">2</div>
                    <div class="top-team-name">Phoenix Rising</div>
                    <div class="team-win-rate">68%</div>
                    <div class="team-metric">Win Rate</div>
                </div>
                <div class="top-team-card">
                    <div class="rank-badge">3</div>
                    <div class="top-team-name">Eagle Warriors</div>
                    <div class="team-win-rate">62%</div>
                    <div class="team-metric">Win Rate</div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- SECTION 3: TOURNAMENT STATUS -->
    <c:if test="${not empty teams}">
        <div class="tournament-status-section">
            <h3 class="section-title">🎪 Current Tournament Status</h3>
            <div class="tournament-grid">
                <div class="tournament-info">
                    <h3>🔥 Season 2026 - Championship Mode</h3>
                    <p>The grand tournament is in full swing with all teams competing at their peak performance. Intense matches, strategic plays, and championship dreams are being realized across the league.</p>
                    <div class="tournament-badges">
                        <span class="tournament-badge">Active Season</span>
                        <span class="tournament-badge emerald">Round 3/4</span>
                        <span class="tournament-badge amber">8 Days Left</span>
                    </div>
                </div>
                <div class="tournament-stat">
                    <div class="tournament-stat-value">${teams.size()}</div>
                    <div class="tournament-stat-label">Teams Playing</div>
                </div>
                <div class="tournament-stat">
                    <div class="tournament-stat-value">87%</div>
                    <div class="tournament-stat-label">Season Complete</div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- SECTION 4: RECENT ACTIVITY -->
    <c:if test="${not empty teams}">
        <div class="activity-section">
            <h3 class="section-title">📢 Recent Activity</h3>
            <div class="activity-feed">
                <div class="activity-item">
                    <div class="activity-icon">⚡</div>
                    <div>
                        <div class="activity-title">Thunder Strikers Won Against Eagles</div>
                        <div class="activity-desc">Epic match with amazing all-round performance securing the victory</div>
                        <div class="activity-time">2 hours ago</div>
                    </div>
                </div>
                <div class="activity-item">
                    <div class="activity-icon">🏆</div>
                    <div>
                        <div class="activity-title">New Team Registered: Phoenix Rising</div>
                        <div class="activity-desc">Welcome to the league - roster finalized with 11 players</div>
                        <div class="activity-time">1 day ago</div>
                    </div>
                </div>
            </div>
        </div>
    </c:if>

    <!-- TEAMS GRID -->
    <div class="teams-grid" id="teamsGrid">
        <c:forEach items="${teams}" var="t">
            <div class="team-card" data-name="${t.teamName.toLowerCase()} ${t.city.toLowerCase()}">
                
                <div class="card-banner">
                    <span class="team-id-badge">#TEAM-${t.id}</span>
                </div>

                <div class="card-body-section">
                    <div class="logo-title-row">
                        <c:choose>
                            <c:when test="${not empty t.logoUrl}">
                                <img src="${t.logoUrl}" alt="Logo" class="team-logo-avatar">
                            </c:when>
                            <c:otherwise>
                                <div class="team-logo-avatar" style="display:flex; align-items:center; justify-content:center; font-size:10px; font-weight:800; color:var(--neon-cyan);">LOGO</div>
                            </c:otherwise>
                        </c:choose>
                        <div class="team-title-wrap">
                            <div class="team-name" title="${t.teamName}">${t.teamName}</div>
                            <div class="team-city">📍 ${t.city}</div>
                        </div>
                    </div>

                    <div class="info-pods">
                        <div class="pod">
                            <span class="pod-label">Coach</span>
                            <span class="pod-val" title="${t.coachName}">${t.coachName}</span>
                        </div>
                        <div class="pod">
                            <span class="pod-label">Owner</span>
                            <span class="pod-val" title="${t.ownerName}">${t.ownerName}</span>
                        </div>
                    </div>
                    
                    <div class="card-actions">
                        <a href="/viewPlayers/${t.id}" class="btn-view">View Player</a>
                        <a href="/edit/${t.id}" class="btn-edit">Edit</a>
                        <a href="/delete/${t.id}" class="btn-delete" onclick="return confirm('⚠️ Terminate this team permanently?');">Delete</a>
                    </div>
                </div>

            </div>
        </c:forEach>
        
        <c:if test="${empty teams}">
            <div class="no-team">No active teams registered in the system database.</div>
        </c:if>
    </div>

    <!-- PAGINATION -->
    <div class="pagination-bar">
        <c:choose>
            <c:when test="${currentPage > 0}">
                <a href="/viewTeam?page=${currentPage - 1}">⬅ Previous</a>
            </c:when>
            <c:otherwise>
                <span style="opacity: 0.3; cursor: not-allowed; padding: 8px 18px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px;">⬅ Previous</span>
            </c:otherwise>
        </c:choose>

        <span class="page-indicator">Page ${currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}</span>

        <c:choose>
            <c:when test="${currentPage + 1 < totalPages}">
                <a href="/viewTeam?page=${currentPage + 1}">Next ➡</a>
            </c:when>
            <c:otherwise>
                <span style="opacity: 0.3; cursor: not-allowed; padding: 8px 18px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px;">Next ➡</span>
            </c:otherwise>
        </c:choose>
    </div>

    <!-- GALLERY SECTION (ABOVE FOOTER) -->
    <div class="gallery-section">
        <div class="footer-gallery-grid">
            <div class="gallery-card-item">
                <div class="gallery-card-content">
                    <h4>🏟️ Grand Stadium Arena</h4>
                    <p>World-class arena illumination designed for grand cricket spectacles.</p>
                </div>
                <div class="gallery-card-img-wrapper">
                    <img src="https://media.istockphoto.com/id/991168190/vector/vector-abstract-illustration-of-cricket-sport-from-colored-liquid-splashes-and-brush-strokes.jpg?s=612x612&w=0&k=20&c=_6_pY7ltO8S62aIX2q5EfQrB68KZRi8JWZci7Amcl3k=" alt="Stadium Arena">
                </div>
            </div>
            
            <div class="gallery-card-item">
                <div class="gallery-card-content">
                    <h4>💡 Floodlit Atmosphere</h4>
                    <p>Witness raw power-hitting, fierce bowling spells, and epic night matches.</p>
                </div>
                <div class="gallery-card-img-wrapper">
                    <img src="https://img.magnific.com/free-photo/sports-tools_53876-138077.jpg?semt=ais_hybrid&w=740&q=80" alt="Stadium Lights">
                </div>
            </div>
            
            <div class="gallery-card-item">
                <div class="gallery-card-content">
                    <h4>🏆 Victory Celebration</h4>
                    <p>United by passion, discipline, and the pursuit of ultimate tournament glory.</p>
                </div>
                <div class="gallery-card-img-wrapper">
                    <img src="https://t4.ftcdn.net/jpg/03/12/20/21/360_F_312202176_MDuakmxjtPflvPKcBuEbiBl27eA1tTK5.jpg" alt="Trophy Lift">
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
                    let highlightClass = (index < 5) ? 'highlight' : '';
                    return '<span class="' + highlightClass + '" style="--i:' + index + '">' + char + '</span>';
                }).join('');
            }
        });

        const bodyElement = document.body;
        const themeToggleBtn = document.getElementById('themeToggleBtn');

        if (localStorage.getItem('matchTheme') === 'light') {
            bodyElement.classList.add('light-mode');
            if(themeToggleBtn) themeToggleBtn.innerHTML = '☀️ Light Mode';
        }

        function toggleTheme() {
            if (bodyElement.classList.contains('light-mode')) {
                bodyElement.classList.remove('light-mode');
                localStorage.setItem('matchTheme', 'dark');
                if(themeToggleBtn) themeToggleBtn.innerHTML = '🌙 Dark Mode';
            } else {
                bodyElement.classList.add('light-mode');
                localStorage.setItem('matchTheme', 'light');
                if(themeToggleBtn) themeToggleBtn.innerHTML = '☀️ Light Mode';
            }
        }

        function filterTeams() {
            let input = document.getElementById('teamSearch').value.toLowerCase().trim();
            let cards = document.getElementsByClassName('team-card');
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