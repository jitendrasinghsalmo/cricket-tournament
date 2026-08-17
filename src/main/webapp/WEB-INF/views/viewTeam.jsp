<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="teams" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Teams Directory</title>
    <!-- Bootstrap 5 CSS & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #0a0e27;
            --card-surface: #0e1428;
            --neon-cyan: #00d9ff;
            --neon-emerald: #00ff88;
            --neon-rose: #ff006e;
            --neon-amber: #ffa500;
            --neon-purple: #b537f2;
            --neon-gold: #ffd700;
            --text-primary: #f0f4ff;
            --text-secondary: #a8b8d8;
            --border-glass: #1e294b;
            --body-overlay: #080b1e;
        }

        body.light-mode {
            --bg-deep: #f5f7ff;
            --card-surface: #ffffff;
            --neon-cyan: #0099cc;
            --neon-emerald: #00aa44;
            --neon-rose: #dd0055;
            --neon-amber: #ff8800;
            --neon-purple: #8800ff;
            --neon-gold: #cc8800;
            --text-primary: #1a2550;
            --text-secondary: #556688;
            --border-glass: #cbd5e1;
            --body-overlay: #f1f5f9;
        }

        * { box-sizing: border-box; }

        body { 
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; 
            background: var(--body-overlay);
            color: var(--text-primary); 
            margin: 0; 
            padding: 0 0 60px 0; 
            transition: background 0.3s ease, color 0.3s ease;
        }
        
        /* 🌟 STICKY NAVBAR STYLING */
        nav {
            background: #0d1222;
            border-bottom: 1.5px solid var(--border-glass);
            padding: 14px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
        }
        .logo-box { display: flex; align-items: center; gap: 12px; text-decoration: none; }
        .logo-icon { 
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); 
            color: #030712; width: 38px; height: 38px; border-radius: 10px; 
            display: flex; align-items: center; justify-content: center; 
            font-weight: 900; font-size: 19px; 
            box-shadow: 0 0 15px rgba(0,217,255,0.6); 
        }
        .logo-text { font-weight: 900; font-size: 18px; color: var(--text-primary); letter-spacing: 0.8px; }
        .logo-text span { display: block; font-size: 9.5px; color: var(--neon-cyan); letter-spacing: 2px; text-transform: uppercase; font-weight: 700; }

        .nav-links { list-style: none; margin: 0; padding: 0; display: flex; gap: 8px; align-items: center; }
        .nav-links a { 
            color: var(--text-secondary); text-decoration: none; font-size: 13.5px; font-weight: 700; 
            padding: 8px 16px; border-radius: 10px; transition: all 0.3s ease; text-transform: uppercase; letter-spacing: 0.5px;
        }
        .nav-links a:hover { color: var(--neon-cyan); background: rgba(0, 217, 255, 0.08); }
        .nav-links a.active { 
            color: #030712; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); 
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.5); font-weight: 800; 
        }

        .main-content-wrap { max-width: 1400px; margin: 30px auto; padding: 0 20px; }
        
        .header-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            margin-bottom: 30px; padding: 18px 30px; border-radius: 18px;
            background: var(--card-surface);
            border: 1px solid var(--border-glass);
        }
        
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-right { display: flex; align-items: center; gap: 12px; }

        .btn-back {
            background: rgba(0, 217, 255, 0.1);
            color: var(--neon-cyan);
            border: 1.5px solid var(--neon-cyan);
            padding: 10px 18px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: all 0.3s ease;
        }
        .btn-back:hover {
            background: var(--neon-cyan);
            color: #030712;
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.5);
        }
        
        .btn-theme-toggle {
            background: rgba(181, 55, 242, 0.15);
            color: var(--neon-purple);
            border: 1.5px solid var(--neon-purple); 
            padding: 10px 18px;
            border-radius: 10px; 
            font-weight: 700; 
            font-size: 13px;
            cursor: pointer; 
            display: inline-flex; 
            align-items: center; 
            gap: 6px;
            transition: all 0.3s ease;
        }
        .btn-theme-toggle:hover { 
            background: var(--neon-purple);
            color: #fff;
            box-shadow: 0 0 20px rgba(181, 55, 242, 0.5);
        }

        .btn-top-add {
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1.5px solid rgba(0, 217, 255, 0.6);
            padding: 10px 18px;
            border-radius: 10px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            transition: all 0.3s ease;
        }
        .btn-top-add:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(0, 217, 255, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .btn-delete-all {
            background: linear-gradient(135deg, rgba(255, 0, 110, 0.15), rgba(255, 106, 0, 0.15));
            color: var(--neon-rose);
            border: 1.5px solid var(--neon-rose); 
            padding: 10px 20px;
            border-radius: 10px; 
            text-decoration: none; 
            font-weight: 700; 
            font-size: 13px;
            transition: all 0.3s ease;
        }
        .btn-delete-all:hover { 
            background: var(--neon-rose); 
            color: #fff; 
            box-shadow: 0 0 20px rgba(255, 0, 110, 0.5);
            transform: translateX(3px);
        }

        .jumping-title {
            text-align: center; 
            margin: 0; 
            font-weight: 900; 
            font-size: 22px; 
            letter-spacing: 2px; 
            text-transform: uppercase;
            display: inline-block;
            overflow: visible;
        }
        .jumping-title span {
            display: inline-block;
            color: var(--neon-cyan);
            text-shadow: 0 0 15px rgba(0, 217, 255, 0.8), 0 0 30px rgba(0, 255, 136, 0.6);
            transform: translateY(-30px);
            opacity: 0;
            animation: dropInChar 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.05s * var(--i));
        }

        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-30px) scale(0.5); }
            60% { opacity: 1; transform: translateY(10px) scale(1.1); }
            100% { opacity: 1; transform: translateY(0) scale(1); }
        }

        .control-bar {
            margin-bottom: 35px;
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            background: var(--card-surface); 
            padding: 14px 24px; 
            border-radius: 14px; 
            border: 1px solid var(--border-glass);
        }
        .search-input {
            background: #030712; 
            border: 1.5px solid var(--border-glass);
            border-radius: 10px; 
            padding: 10px 16px; 
            color: var(--text-primary); 
            font-size: 13px;
            width: 320px; 
            outline: none; 
            transition: 0.3s;
        }
        .search-input::placeholder { color: var(--text-secondary); opacity: 0.7; }
        .search-input:focus { 
            border-color: var(--neon-cyan); 
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.4);
        }
        .stats-badge { 
            font-size: 13px; 
            font-weight: 700; 
            color: var(--text-secondary); 
            background: #111827;
            padding: 8px 16px; 
            border-radius: 10px; 
            border: 1px solid var(--border-glass); 
        }
        .stats-badge span { color: var(--neon-gold); font-weight: 800; }

        .league-stats-section { max-width: 1400px; margin: 40px auto; }
        .section-title {
            font-size: 18px; font-weight: 800; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1.2px;
            margin-bottom: 24px; display: flex; align-items: center; gap: 12px;
        }
        .section-title::before { content: ''; width: 4px; height: 24px; background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald)); border-radius: 2px; }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        @media(max-width: 1024px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .stats-grid { grid-template-columns: 1fr; } }

        .stat-box {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 18px;
            padding: 24px; text-align: center; transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .stat-box:hover { border-color: var(--neon-cyan); transform: translateY(-5px); }
        .stat-number { font-size: 32px; font-weight: 900; color: var(--neon-cyan); margin-bottom: 6px; }
        .stat-label { font-size: 13px; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; }

        .top-teams-section { max-width: 1400px; margin: 40px auto; }
        .top-teams-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 1024px) { .top-teams-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .top-teams-grid { grid-template-columns: 1fr; } }

        .top-team-card {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(0, 255, 136, 0.08));
            border: 1.5px solid var(--border-glass); border-radius: 20px;
            padding: 28px; text-align: center; transition: all 0.3s ease;
        }
        .top-team-card:hover { border-color: var(--neon-cyan); transform: translateY(-6px); }
        .rank-badge {
            width: 45px; height: 45px; border-radius: 50%;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #030712; font-weight: 900; font-size: 18px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 15px auto;
        }
        .top-team-name { font-size: 17px; font-weight: 800; color: var(--text-primary); margin-bottom: 8px; text-transform: uppercase; }
        .team-win-rate { font-size: 26px; font-weight: 900; color: var(--neon-emerald); margin-bottom: 4px; }
        .team-metric { font-size: 12px; color: var(--text-secondary); text-transform: uppercase; font-weight: 700; }

        .tournament-status-section {
            max-width: 1400px; margin: 40px auto;
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 20px;
            padding: 32px; box-shadow: 0 15px 40px rgba(0,0,0,0.3);
        }
        .tournament-grid { display: grid; grid-template-columns: 2fr 1fr 1fr; gap: 24px; align-items: center; }
        @media(max-width: 968px) { .tournament-grid { grid-template-columns: 1fr; } }
        .tournament-info h3 { font-size: 18px; font-weight: 800; color: var(--text-primary); margin: 0 0 10px 0; text-transform: uppercase; }
        .tournament-info p { font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; margin: 0 0 16px 0; font-weight: 500; }
        .tournament-badges { display: flex; gap: 10px; flex-wrap: wrap; }
        .tournament-badge {
            background: rgba(0, 217, 255, 0.15); color: var(--neon-cyan);
            border: 1px solid rgba(0, 217, 255, 0.3); border-radius: 20px;
            padding: 6px 14px; font-size: 11px; font-weight: 700; text-transform: uppercase;
        }
        .tournament-badge.emerald { background: rgba(0, 255, 136, 0.15); color: var(--neon-emerald); border-color: rgba(0, 255, 136, 0.3); }
        .tournament-badge.amber { background: rgba(255, 165, 0, 0.15); color: var(--neon-amber); border-color: rgba(255, 165, 0, 0.3); }

        .tournament-stat { background: #080b1e; border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 20px; text-align: center; }
        .tournament-stat-value { font-size: 28px; font-weight: 900; color: var(--neon-cyan); }
        .tournament-stat-label { font-size: 12px; color: var(--text-secondary); text-transform: uppercase; margin-top: 6px; font-weight: 700; }

        .activity-section { max-width: 1400px; margin: 40px auto; }
        .activity-feed { display: grid; grid-template-columns: 1fr; gap: 16px; }
        .activity-item {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 16px;
            padding: 20px; display: flex; gap: 20px; transition: all 0.3s ease;
        }
        .activity-item:hover { border-color: var(--neon-cyan); }
        .activity-icon {
            width: 50px; height: 50px; border-radius: 14px;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.2), rgba(0, 255, 136, 0.2));
            display: flex; align-items: center; justify-content: center; font-size: 22px; flex-shrink: 0;
            border: 1.5px solid var(--neon-cyan);
        }
        .activity-title { font-size: 15px; font-weight: 800; color: var(--text-primary); margin: 0 0 6px 0; }
        .activity-desc { font-size: 13px; color: var(--text-secondary); margin: 0 0 8px 0; font-weight: 500; }
        .activity-time { font-size: 11px; color: var(--neon-cyan); font-weight: 700; text-transform: uppercase; }

        /* TEAMS GRID */
        .teams-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; max-width: 1400px; margin: 40px auto; }
        @media(max-width: 1024px) { .teams-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .teams-grid { grid-template-columns: 1fr; } }
        
        .team-card {
            background: var(--card-surface);
            border-radius: 20px; border: 1.5px solid var(--border-glass);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); position: relative; overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex; flex-direction: column;
        }
        .team-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
        }
        .team-card:hover { transform: translateY(-10px) scale(1.02); border-color: var(--neon-cyan); box-shadow: 0 25px 50px rgba(0, 217, 255, 0.3); }

        .card-banner {
            height: 80px; background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(0, 255, 136, 0.15));
            border-bottom: 1.5px solid var(--border-glass); display: flex; justify-content: space-between; align-items: flex-start; padding: 14px 20px;
        }
        .team-id-badge {
            font-size: 10px; font-weight: 800; color: var(--neon-cyan);
            background: rgba(3, 7, 18, 0.8); padding: 4px 12px; border-radius: 8px; border: 1.5px solid var(--neon-cyan);
        }

        .card-body-section { padding: 0 24px 24px 24px; margin-top: -42px; display: flex; flex-direction: column; gap: 18px; }
        .logo-title-row { display: flex; align-items: flex-end; gap: 16px; }
        .team-logo-avatar {
            width: 85px; height: 85px; border-radius: 18px; object-fit: cover;
            border: 3px solid var(--card-surface); background: #020617;
            box-shadow: 0 10px 25px rgba(0,0,0,0.4); transition: transform 0.3s ease;
        }
        .team-card:hover .team-logo-avatar { transform: scale(1.05); border-color: var(--neon-cyan); }
        .team-title-wrap { flex: 1; padding-bottom: 4px; }
        .team-name { font-size: 18px; font-weight: 900; color: var(--text-primary); letter-spacing: 0.5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .team-city { font-size: 12.5px; font-weight: 700; color: var(--neon-cyan); margin-top: 3px; }

        .info-pods { display: grid; grid-template-columns: 1fr 1fr; gap: 12px; }
        .pod { background: #080b1e; border: 1.5px solid var(--border-glass); border-radius: 12px; padding: 12px; display: flex; flex-direction: column; gap: 3px; }
        .pod-label { font-size: 10px; text-transform: uppercase; font-weight: 800; color: var(--text-secondary); }
        .pod-val { font-size: 13px; font-weight: 700; color: var(--text-primary); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }

        .card-actions { display: grid; grid-template-columns: 1.4fr 1fr 1fr; gap: 10px; padding-top: 5px; }
        .card-actions a {
            text-align: center; text-decoration: none; padding: 10px; border-radius: 10px;
            font-size: 11px; font-weight: 800; transition: all 0.2s ease; text-transform: uppercase; letter-spacing: 0.5px; white-space: nowrap;
        }
        .btn-view { background: rgba(0, 255, 136, 0.15); color: var(--neon-emerald); border: 1.5px solid var(--neon-emerald); }
        .btn-view:hover { background: var(--neon-emerald); color: #030712; box-shadow: 0 0 15px rgba(0, 255, 136, 0.4); }
        .btn-edit { background: rgba(0, 217, 255, 0.15); color: var(--neon-cyan); border: 1.5px solid var(--neon-cyan); }
        .btn-edit:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(0, 217, 255, 0.4); }
        .btn-delete { background: rgba(255, 0, 110, 0.15); color: var(--neon-rose); border: 1.5px solid var(--neon-rose); }
        .btn-delete:hover { background: var(--neon-rose); color: #fff; box-shadow: 0 0 15px rgba(255, 0, 110, 0.4); }

        .pagination-bar {
            display: flex; justify-content: flex-end; align-items: center; gap: 20px;
            max-width: 1400px; margin: 40px auto; padding: 16px 30px; border-radius: 14px;
        }
        .pagination-bar a {
            padding: 10px 20px; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #030712; border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 12px; text-transform: uppercase;
        }
        .pagination-bar a:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0, 217, 255, 0.5); }
        .page-indicator { font-size: 13px; font-weight: 700; color: var(--text-secondary); padding: 0 15px; border-left: 2px solid var(--border-glass); border-right: 2px solid var(--border-glass); }

        /* 🌟 NEW UNIQUE LEADERBOARD SPOTLIGHT SECTION */
        .unique-spotlight-section { max-width: 1400px; margin: 40px auto; }
        .spotlight-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .spotlight-grid { grid-template-columns: 1fr; } }
        .spotlight-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 20px;
            padding: 25px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); transition: all 0.3s ease; position: relative; overflow: hidden;
            display: flex; flex-direction: column; gap: 12px;
        }
        .spotlight-card:hover { transform: translateY(-5px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }
        .spotlight-card::before { content: ''; position: absolute; top: 0; left: 0; width: 4px; height: 100%; background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald)); }
        .spotlight-header { display: flex; justify-content: space-between; align-items: center; }
        .spotlight-rank { font-size: 12px; font-weight: 900; color: var(--neon-gold); background: rgba(255, 215, 0, 0.1); padding: 4px 10px; border-radius: 6px; border: 1px solid rgba(255, 215, 0, 0.3); text-transform: uppercase; }
        .spotlight-badge-icon { font-size: 20px; color: var(--neon-cyan); }
        .spotlight-team-name { font-size: 17px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; letter-spacing: 0.5px; }
        .spotlight-progress-wrap { background: #030712; border: 1px solid var(--border-glass); border-radius: 10px; padding: 10px; display: flex; justify-content: space-between; align-items: center; }
        .spotlight-stat-title { font-size: 11px; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; }
        .spotlight-stat-value { font-size: 16px; font-weight: 900; color: var(--neon-emerald); }

        /* 🌟 NEW UNIQUE MATCH FORMATION & TACTICAL INSIGHTS SECTION (ADDED ABOVE RECENT ACTIVITY) */
        .tactical-insights-section { max-width: 1400px; margin: 40px auto; }
        .tactical-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px; }
        @media(max-width: 768px) { .tactical-grid { grid-template-columns: 1fr; } }
        .tactical-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 20px; padding: 30px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); transition: all 0.3s ease; position: relative; overflow: hidden;
            display: flex; gap: 20px; align-items: flex-start;
        }
        .tactical-card:hover { transform: translateY(-5px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }
        .tactical-card::after { content: ''; position: absolute; top: 0; right: 0; width: 100%; height: 3px; background: linear-gradient(90deg, var(--neon-purple), var(--neon-cyan)); }
        .tactical-icon-wrap {
            width: 55px; height: 55px; background: rgba(181, 55, 242, 0.12); border: 1.5px solid var(--neon-purple); border-radius: 14px;
            display: flex; align-items: center; justify-content: center; font-size: 24px; color: var(--neon-purple); flex-shrink: 0;
            box-shadow: 0 0 15px rgba(181, 55, 242, 0.3);
        }
        .tactical-content h4 { margin: 0 0 8px 0; font-size: 16.5px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; letter-spacing: 0.5px; }
        .tactical-content p { margin: 0; font-size: 13px; color: var(--text-secondary); line-height: 1.6; font-weight: 500; }

        /* PRO EXTRA HIGHLIGHTS SECTION */
        .pro-extra-highlights { max-width: 1400px; margin: 40px auto; }
        .extra-highlights-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .extra-highlights-grid { grid-template-columns: 1fr; } }
        .extra-highlight-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 18px; padding: 25px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); transition: all 0.3s ease; position: relative; overflow: hidden;
        }
        .extra-highlight-card:hover { transform: translateY(-5px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }
        .extra-highlight-card::after { content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 3px; background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald)); }
        .extra-icon { width: 45px; height: 45px; background: rgba(0, 217, 255, 0.1); border: 1px solid var(--neon-cyan); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--neon-cyan); margin-bottom: 15px; }
        .extra-highlight-card h4 { margin: 0 0 8px 0; font-size: 16px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; }
        .extra-highlight-card p { margin: 0; font-size: 13px; color: var(--text-secondary); line-height: 1.6; }

        /* GALLERY SECTION */
        .gallery-section { max-width: 1400px; margin: 40px auto; }
        .footer-gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .footer-gallery-grid { grid-template-columns: 1fr; } }

        .gallery-card-item {
            background: var(--card-surface); border-radius: 16px; overflow: hidden;
            border: 1.5px solid var(--border-glass);
            display: flex; flex-direction: column; text-align: center;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .gallery-card-content { padding: 20px; order: 1; }
        .gallery-card-content h4 { margin: 0 0 6px 0; font-size: 14.5px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; }
        .gallery-card-content p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.5; }

        .gallery-img-container {
            width: 100%; height: 180px; overflow: hidden; order: 2;
            display: flex; align-items: center; justify-content: center; background: #020617;
        }
        .gallery-img-container img { 
            width: 100%; height: 100%; object-fit: cover; transition: transform 0.6s ease;
        }
        .gallery-card-item:hover .gallery-img-container img {
            transform: rotate(360deg);
        }

        /* 🌟 GRAND CYBER FOOTER STYLING */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,217,255,0.5); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        @media(max-width: 650px) { .footer-socials { justify-content: center; } }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(0, 217, 255, 0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #030712; transform: translateY(-3px); box-shadow: 0 0 15px rgba(0,217,255,0.6); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(0,217,255,0.3); }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; transition: 0.3s; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }

        .no-team { text-align: center; color: var(--text-secondary); grid-column: 1 / -1; padding: 60px; font-size: 15px; font-weight: 700; background: var(--card-surface); border: 1px dashed var(--border-glass); border-radius: 16px; text-transform: uppercase; }
    </style>
</head>
<body>

    <!-- 🌟 NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">
        <div class="header-bar">
            <div class="header-left">
                <a href="/home" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Dashboard</a>
            </div>
            
            <div>
                <h2 class="jumping-title" id="animatedTitle">TEAMS DIRECTORY</h2>
            </div>

            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
                <a href="/register-team" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Team</a>
                <a href="/deleteAllTeams" class="btn-delete-all" onclick="return confirm('⚠️ Warning: Delete ALL teams permanently?')">🗑 Delete All</a>
            </div>
        </div>

        <div class="control-bar">
            <input type="text" id="teamSearch" class="search-input" placeholder="🔍 Search team by name or city..." onkeyup="filterTeams()" autocomplete="off">
            <div class="stats-badge">Total Teams: <span>${totalItems}</span></div>
        </div>

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
                            <a href="/edit/${t.id}" class="btn-edit">✏️ Edit</a>
                            <a href="/delete/${t.id}" class="btn-delete" onclick="return confirm('⚠️ Terminate this team permanently?');">🗑 Delete</a>
                        </div>
                    </div>

                </div>
            </c:forEach>
            
            <c:if test="${empty teams}">
                <div class="no-team">🏏 No active teams registered in the system database.</div>
            </c:if>
        </div>

        <!-- PAGINATION -->
        <div class="pagination-bar">
            <c:choose>
                <c:when test="${currentPage > 0}">
                    <a href="/viewTeam?page=${currentPage - 1}">⬅ Previous</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 700;">⬅ Previous</span>
                </c:otherwise>
            </c:choose>

            <span class="page-indicator">Page ${currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}</span>

            <c:choose>
                <c:when test="${currentPage + 1 < totalPages}">
                    <a href="/viewTeam?page=${currentPage + 1}">Next ➡</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 700;">Next ➡</span>
                </c:otherwise>
            </c:choose>
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

        <!-- 🌟 UNIQUE LEADERBOARD SPOTLIGHT SECTION -->
        <div class="unique-spotlight-section">
            <h3 class="section-title">⚡ Leaderboard Power Spotlight</h3>
            <div class="spotlight-grid">
                <div class="spotlight-card">
                    <div class="spotlight-header">
                        <span class="spotlight-rank">Tier 1 Leader</span>
                        <i class="fa-solid fa-crown spotlight-badge-icon" style="color: var(--neon-gold);"></i>
                    </div>
                    <div class="spotlight-team-name">Thunder Strikers</div>
                    <div class="spotlight-progress-wrap">
                        <span class="spotlight-stat-title">Dominance Index</span>
                        <span class="spotlight-stat-value">94.8 PT</span>
                    </div>
                </div>
                <div class="spotlight-card">
                    <div class="spotlight-header">
                        <span class="spotlight-rank">Tier 2 Challenger</span>
                        <i class="fa-solid fa-fire spotlight-badge-icon" style="color: var(--neon-rose);"></i>
                    </div>
                    <div class="spotlight-team-name">Phoenix Rising</div>
                    <div class="spotlight-progress-wrap">
                        <span class="spotlight-stat-title">Dominance Index</span>
                        <span class="spotlight-stat-value">88.2 PT</span>
                    </div>
                </div>
                <div class="spotlight-card">
                    <div class="spotlight-header">
                        <span class="spotlight-rank">Tier 3 Contender</span>
                        <i class="fa-solid fa-bolt spotlight-badge-icon" style="color: var(--neon-cyan);"></i>
                    </div>
                    <div class="spotlight-team-name">Eagle Warriors</div>
                    <div class="spotlight-progress-wrap">
                        <span class="spotlight-stat-title">Dominance Index</span>
                        <span class="spotlight-stat-value">81.5 PT</span>
                    </div>
                </div>
            </div>
        </div>

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

        <!-- 🌟 NEW UNIQUE MATCH FORMATION & TACTICAL INSIGHTS SECTION (ADDED ABOVE RECENT ACTIVITY) -->
        <div class="tactical-insights-section">
            <h3 class="section-title">⚡ Tactical Match Formations & Insights</h3>
            <div class="tactical-grid">
                <div class="tactical-card">
                    <div class="tactical-icon-wrap"><i class="fa-solid fa-chess-knight"></i></div>
                    <div class="tactical-content">
                        <h4>Aggressive Powerplay Strategy</h4>
                        <p>Top franchises are maximizing field restrictions by deploying hard-hitting openers in the first 6 overs to build a formidable run cushion.</p>
                    </div>
                </div>
                <div class="tactical-card">
                    <div class="tactical-icon-wrap"><i class="fa-solid fa-shield-cat"></i></div>
                    <div class="tactical-content">
                        <h4>Middle-Over Defensive Control</h4>
                        <p>Spinners and tight line-and-length seamers are dominating the middle phase, restricting scoring rates and forcing high-pressure mistakes.</p>
                    </div>
                </div>
            </div>
        </div>

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

        <!-- PRO EXTRA HIGHLIGHTS SECTION -->
        <div class="pro-extra-highlights">
            <h3 class="section-title">⚡ Tournament Core Pillars</h3>
            <div class="extra-highlights-grid">
                <div class="extra-highlight-card">
                    <div class="extra-icon"><i class="fa-solid fa-users-gear"></i></div>
                    <h4>Roster Management</h4>
                    <p>Seamlessly organize player rosters, track coach strategies, and manage franchise ownership details.</p>
                </div>
                <div class="extra-highlight-card">
                    <div class="extra-icon"><i class="fa-solid fa-shield-halved"></i></div>
                    <h4>Verified Franchises</h4>
                    <p>Secure database records ensuring complete authenticity and compliance across all registered teams.</p>
                </div>
                <div class="extra-highlight-card">
                    <div class="extra-icon"><i class="fa-solid fa-chart-pie"></i></div>
                    <h4>Performance Analytics</h4>
                    <p>Get comprehensive insights into team win rates, match outcomes, and historical statistics.</p>
                </div>
            </div>
        </div>

        <!-- GALLERY SECTION (NORMAL RECTANGULAR CARDS, 360 HOVER ROTATION) -->
        <div class="gallery-section">
            <div class="footer-gallery-grid">
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏟️ Grand Stadium Arena</h4>
                        <p>World-class arena illumination designed for grand cricket spectacles.</p>
                    </div>
                    <div class="gallery-img-container">
                        <img src="https://media.istockphoto.com/id/991168190/vector/vector-abstract-illustration-of-cricket-sport-from-colored-liquid-splashes-and-brush-strokes.jpg?s=612x612&w=0&k=20&c=_6_pY7ltO8S62aIX2q5EfQrB68KZRi8JWZci7Amcl3k=" alt="Stadium Arena">
                    </div>
                </div>
                
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>💡 Floodlit Atmosphere</h4>
                        <p>Witness raw power-hitting, fierce bowling spells, and epic night matches.</p>
                    </div>
                    <div class="gallery-img-container">
                        <img src="https://img.magnific.com/free-photo/sports-tools_53876-138077.jpg?semt=ais_hybrid&w=740&q=80" alt="Stadium Lights">
                    </div>
                </div>
                
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏆 Victory Celebration</h4>
                        <p>United by passion, discipline, and the pursuit of ultimate tournament glory.</p>
                    </div>
                    <div class="gallery-img-container">
                        <img src="https://t4.ftcdn.net/jpg/03/12/20/21/360_F_312202176_MDuakmxjtPflvPKcBuEbiBl27eA1tTK5.jpg" alt="Trophy Lift">
                    </div>
                </div>
            </div>
        </div>

        <!-- 🌟 GRAND CYBER FOOTER INCLUDE -->
        <jsp:include page="footer.jsp" />

    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const titleEl = document.getElementById('animatedTitle');
        if (titleEl) {
            const textWords = titleEl.innerText;
            titleEl.innerHTML = textWords.split('').map(function(char, index) {
                if (char === ' ') return '<span style="--i:' + index + '">&nbsp;</span>';
                return '<span style="--i:' + index + '">' + char + '</span>';
            }).join('');
        }

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