<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="tournaments" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Tournament Control Center</title>
    <!-- Bootstrap 5 CSS & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #0a0e27;
            --card-surface: rgba(13, 18, 35, 0.85);
            --neon-cyan: #00d9ff;
            --neon-emerald: #00ff88;
            --neon-rose: #ff006e;
            --neon-amber: #ffa500;
            --neon-purple: #b537f2;
            --neon-gold: #ffd700;
            --text-primary: #f0f4ff;
            --text-secondary: #a8b8d8;
            --border-glass: rgba(0, 217, 255, 0.25);
        }

        body.light-mode {
            --bg-deep: #f5f7ff;
            --card-surface: rgba(255, 255, 255, 0.9);
            --neon-cyan: #0099cc;
            --neon-emerald: #00aa44;
            --neon-rose: #dd0055;
            --neon-amber: #ff8800;
            --neon-purple: #8800ff;
            --neon-gold: #cc8800;
            --text-primary: #1a2550;
            --text-secondary: #556688;
            --border-glass: rgba(0, 153, 204, 0.25);
        }

        * { box-sizing: border-box; }

        body { 
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; 
            background-color: var(--bg-deep);
            color: var(--text-primary); 
            margin: 0; 
            padding: 0; 
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* 🌟 PREMIUM STICKY NAVBAR STYLING */
        nav {
            background: rgba(10, 14, 39, 0.92);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
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
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 30px; 
            padding: 18px 30px; 
            border-radius: 18px;
            background: var(--card-surface);
            backdrop-filter: blur(10px);
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
        /* Poora word ek saath rahe (beech se na tute), line sirf words ke beech se badle */
        .jumping-title .jt-word { display: inline-block; white-space: nowrap; font-weight: inherit; }

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
            backdrop-filter: blur(15px);
            padding: 14px 24px; 
            border-radius: 14px; 
            border: 1px solid var(--border-glass);
        }
        .search-input {
            background: rgba(3, 7, 18, 0.6); 
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
            background: rgba(3, 7, 18, 0.8);
        }
        .stats-badge { 
            font-size: 13px; 
            font-weight: 700; 
            color: var(--text-secondary); 
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.1), rgba(255, 215, 0, 0.1));
            padding: 8px 16px; 
            border-radius: 10px; 
            border: 1px solid var(--border-glass); 
        }
        .stats-badge span { color: var(--neon-gold); font-weight: 800; }

        .alert-message {
            margin-bottom: 25px;
            background: linear-gradient(135deg, rgba(255, 0, 110, 0.15), rgba(255, 106, 0, 0.15));
            color: var(--neon-rose);
            border: 1.5px solid var(--neon-rose); 
            padding: 14px 24px;
            border-radius: 12px; 
            text-align: center; 
            font-weight: 700; 
            font-size: 13px;
        }

        /* ============ TOURNAMENT CARDS GRID ============ */
        .tournaments-grid { 
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 30px; 
            max-width: 1400px; 
            margin: 0 auto 40px auto; 
        }

        @media(max-width: 1024px) { .tournaments-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .tournaments-grid { grid-template-columns: 1fr; } }
        
        .tournament-card {
            background: var(--card-surface); 
            backdrop-filter: blur(15px);
            border-radius: 18px; 
            border: 1px solid var(--border-glass);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); 
            position: relative; 
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .tournament-card::before {
            content: ''; 
            position: absolute; 
            top: 0; 
            left: 0; 
            width: 100%;
            height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
        }

        .tournament-card:hover {
            transform: translateY(-10px) scale(1.02);
            border-color: var(--neon-cyan);
            box-shadow: 0 25px 50px rgba(0, 217, 255, 0.3);
        }

        .card-inner { 
            padding: 24px; 
            display: flex; 
            flex-direction: column; 
            gap: 16px; 
        }

        .card-top-row { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
        }

        .tournament-id-tag { 
            font-size: 10px; 
            font-weight: 800; 
            color: var(--neon-cyan); 
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.2), rgba(0, 255, 136, 0.2));
            padding: 5px 12px; 
            border-radius: 8px; 
            border: 1.5px solid var(--neon-cyan);
            letter-spacing: 0.5px;
        }

        .season-pill { 
            font-size: 11px; 
            font-weight: 700; 
            color: var(--neon-gold); 
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.15), rgba(255, 165, 0, 0.15));
            padding: 5px 12px; 
            border-radius: 20px;
            border: 1.5px solid var(--neon-gold);
            letter-spacing: 0.4px;
        }

        .tournament-title { 
            font-size: 18px; 
            font-weight: 800; 
            color: var(--text-primary); 
            letter-spacing: 0.5px; 
            white-space: nowrap; 
            overflow: hidden; 
            text-overflow: ellipsis;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .timeline-box {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.1), rgba(0, 255, 136, 0.1));
            border: 1px solid var(--border-glass);
            border-radius: 12px; 
            padding: 14px 16px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
        }

        .time-col { 
            display: flex; 
            flex-direction: column; 
            gap: 3px; 
        }

        .time-label { 
            font-size: 10px; 
            text-transform: uppercase; 
            font-weight: 700; 
            color: var(--neon-cyan);
            letter-spacing: 0.5px;
        }

        .time-val { 
            font-size: 13px; 
            font-weight: 700; 
            color: var(--text-primary); 
        }

        .time-divider { 
            width: 2px; 
            height: 28px; 
            background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald));
        }

        .card-actions { 
            display: grid; 
            grid-template-columns: 1fr 1fr; 
            gap: 10px; 
            padding-top: 8px; 
        }

        .card-actions a {
            text-align: center; 
            text-decoration: none; 
            padding: 10px; 
            border-radius: 10px;
            font-size: 12px; 
            font-weight: 700; 
            transition: all 0.3s ease; 
            text-transform: uppercase; 
            letter-spacing: 0.6px;
        }

        .btn-edit { 
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(0, 255, 136, 0.15));
            color: var(--neon-cyan); 
            border: 1.5px solid var(--neon-cyan);
        }
        .btn-edit:hover { 
            background: var(--neon-cyan); 
            color: #030712; 
            box-shadow: 0 0 20px rgba(0, 217, 255, 0.5); 
        }
        
        .btn-delete { 
            background: linear-gradient(135deg, rgba(255, 0, 110, 0.15), rgba(255, 106, 0, 0.15));
            color: var(--neon-rose); 
            border: 1.5px solid var(--neon-rose);
        }
        .btn-delete:hover { 
            background: var(--neon-rose); 
            color: #fff; 
            box-shadow: 0 0 20px rgba(255, 0, 110, 0.5); 
        }

        /* ============ PAGINATION ============ */
        .pagination-bar {
            display: flex; 
            justify-content: flex-end; 
            align-items: center; 
            gap: 20px;
            max-width: 1400px;
            margin: 0 auto 50px auto; 
            padding: 16px 30px; 
            border-radius: 14px;
            box-sizing: border-box;
        }

        .pagination-bar a {
            padding: 10px 20px; 
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #000;
            border-radius: 10px; 
            text-decoration: none; 
            font-weight: 800; 
            font-size: 12px;
            transition: all 0.3s;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .pagination-bar a:hover { 
            transform: translateY(-2px); 
            box-shadow: 0 8px 20px rgba(0, 217, 255, 0.5); 
        }
        .page-indicator { 
            font-size: 13px; 
            font-weight: 700; 
            color: var(--text-secondary);
            padding: 0 15px;
            border-left: 2px solid var(--border-glass);
            border-right: 2px solid var(--border-glass);
        }

        /* ============ CRICKET STATS SECTION ============ */
        .cricket-stats-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .stat-card {
            background: rgba(13, 18, 35, 0.95);
            border: 1.5px solid var(--border-glass);
            border-radius: 16px;
            padding: 24px;
            backdrop-filter: blur(15px);
            transition: all 0.3s ease;
            overflow: hidden;
            position: relative;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }

        .stat-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
        }

        .stat-card:hover {
            transform: translateY(-6px);
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25);
        }

        .stat-icon {
            font-size: 32px;
            margin-bottom: 12px;
        }

        .stat-label {
            font-size: 13px;
            color: #ffffff;
            text-transform: uppercase;
            font-weight: 900;
            letter-spacing: 0.8px;
            margin-bottom: 8px;
        }

        .stat-value {
            font-size: 28px;
            font-weight: 900;
            color: var(--neon-cyan);
            margin-bottom: 8px;
            text-shadow: 0 0 10px rgba(0, 217, 255, 0.4);
        }

        .stat-desc {
            font-size: 13px;
            color: #f0f4ff;
            line-height: 1.5;
            font-weight: 700;
        }

        /* ============ INSIGHTS SECTION ============ */
        .insights-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }
        @media(max-width: 768px) {
            .insights-section { grid-template-columns: 1fr; }
        }
        .insight-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 16px;
            padding: 24px;
            backdrop-filter: blur(15px);
            text-align: center;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: transform 0.3s ease, border-color 0.3s ease;
        }
        .insight-card:hover {
            transform: translateY(-5px);
            border-color: var(--neon-cyan);
        }
        .insight-card i {
            font-size: 32px;
            color: var(--neon-cyan);
            margin-bottom: 12px;
        }
        .insight-card h3 {
            margin: 0 0 8px 0;
            font-size: 16px;
            font-weight: 800;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
        }
        .insight-card p {
            margin: 0;
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* ============ LIVE LEADERBOARD SECTION ============ */
        .leaderboard-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            background: var(--card-surface);
            border: 1px solid var(--border-glass);
            border-radius: 18px;
            padding: 32px;
            backdrop-filter: blur(15px);
        }

        .section-title {
            font-size: 18px;
            font-weight: 800;
            color: var(--text-primary);
            margin: 0 0 24px 0;
            display: flex;
            align-items: center;
            gap: 12px;
            text-transform: uppercase;
            letter-spacing: 1.2px;
        }

        .section-title::before {
            content: '';
            width: 4px;
            height: 24px;
            background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald));
            border-radius: 2px;
        }

        .leaderboard-table {
            width: 100%;
            border-collapse: collapse;
        }

        .leaderboard-table thead tr {
            border-bottom: 2px solid var(--border-glass);
        }

        .leaderboard-table th {
            padding: 12px 16px;
            text-align: left;
            font-size: 12px;
            font-weight: 700;
            color: var(--neon-cyan);
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }

        .leaderboard-table td {
            padding: 14px 16px;
            border-bottom: 1px solid rgba(0, 217, 255, 0.1);
            font-size: 13px;
            color: var(--text-primary);
        }

        .leaderboard-table tbody tr:hover {
            background: rgba(0, 217, 255, 0.08);
            border-left: 3px solid var(--neon-cyan);
        }

        .rank-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 32px;
            height: 32px;
            background: linear-gradient(135deg, var(--neon-gold), var(--neon-amber));
            color: #000;
            border-radius: 50%;
            font-weight: 800;
            font-size: 12px;
        }

        .rank-badge.top-1 { background: linear-gradient(135deg, #ffd700, #ffed4e); }
        .rank-badge.top-2 { background: linear-gradient(135deg, #c0c0c0, #e8e8e8); }
        .rank-badge.top-3 { background: linear-gradient(135deg, #cd7f32, #d4885d); }

        /* ============ 🌟 NEW UNIQUE ALT STYLE SECTION (GLOWING CARDS) ============ */
        .unique-alt-section {
            max-width: 1400px;
            margin: 40px auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 768px) {
            .unique-alt-section { grid-template-columns: 1fr; }
        }
        .alt-feature-box {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.05), rgba(181, 55, 242, 0.05));
            border: 1.5px solid var(--border-glass);
            border-radius: 20px;
            padding: 30px;
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(15px);
            transition: all 0.4s ease;
        }
        .alt-feature-box:hover {
            transform: translateY(-6px);
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25);
        }
        .alt-feature-box::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100%;
            height: 3px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-purple));
        }
        .alt-icon-circle {
            width: 60px;
            height: 60px;
            background: rgba(0, 217, 255, 0.12);
            border: 1.5px solid var(--neon-cyan);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--neon-cyan);
            margin-bottom: 20px;
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.3);
        }
        .alt-feature-box h4 {
            font-size: 16px;
            font-weight: 800;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 10px;
        }
        .alt-feature-box p {
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.6;
            margin: 0;
        }

        /* ============ YELLOW THEME BANNER SECTION ============ */
        .yellow-highlight-banner {
            max-width: 1400px;
            margin: 40px auto;
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.22), rgba(255, 165, 0, 0.22));
            border: 2px solid var(--neon-gold);
            border-radius: 20px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(255, 215, 0, 0.25);
            backdrop-filter: blur(15px);
        }
        .yellow-highlight-banner h3 {
            font-size: 24px;
            font-weight: 900;
            color: var(--neon-gold);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 12px;
            text-shadow: 0 0 15px rgba(255, 215, 0, 0.6);
        }
        .yellow-highlight-banner p {
            font-size: 14.5px;
            color: var(--text-primary);
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.7;
            font-weight: 600;
        }

        /* ============ CIRCULAR STATS SECTION ============ */
        .circular-stats-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 768px) {
            .circular-stats-section { grid-template-columns: 1fr; }
        }
        .circle-badge-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 20px;
            padding: 30px 20px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
        }
        .circle-badge-card:hover {
            transform: translateY(-5px);
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25);
        }
        .circle-icon-wrap {
            width: 75px;
            height: 75px;
            margin: 0 auto 15px auto;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(0, 255, 136, 0.15));
            border: 2px solid var(--neon-cyan);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 26px;
            color: var(--neon-cyan);
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.3);
        }
        .circle-badge-card h4 {
            margin: 0 0 8px 0;
            font-size: 15px;
            font-weight: 800;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .circle-badge-card p {
            margin: 0;
            font-size: 12.5px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* ============ GALLERY SECTION (EQUAL HEIGHT, PERFECT FIT & SPIN ANIMATION) ============ */
        .footer-gallery-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
        }

        .footer-gallery-grid {
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 25px; 
            perspective: 1000px;
        }
        @media(max-width: 768px) { 
            .footer-gallery-grid { grid-template-columns: 1fr; } 
        }

        .gallery-card-item {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(0, 255, 136, 0.08));
            border-radius: 16px;
            overflow: hidden;
            border: 1.5px solid var(--border-glass);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
            height: 100%;
            transform-style: preserve-3d;
            animation: spinFiveSecs 5s linear infinite;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        @keyframes spinFiveSecs {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(360deg); }
        }

        .gallery-card-item:hover {
            animation: spinOnce 0.8s ease forwards;
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.4);
        }

        @keyframes spinOnce {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(360deg); }
        }

        /* Content box ab upar rahega aur saare cards me equal height maintain karega */
        .gallery-card-content {
            padding: 18px 16px;
            text-align: center;
            background: rgba(13, 18, 30, 0.85);
            min-height: 95px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            order: 1;
        }

        .gallery-card-content h4 {
            margin: 0 0 6px 0;
            font-size: 14.5px;
            font-weight: 800;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }

        .gallery-card-content p {
            margin: 0;
            font-size: 12px;
            color: var(--text-secondary);
            line-height: 1.4;
        }

        /* Image wrapper niche rahega aur images exact fit hongi bina gap ke */
        .gallery-card-img-wrapper {
            position: relative;
            width: 100%;
            height: 190px;
            overflow: hidden;
            background: #020617;
            order: 2;
            flex-grow: 1;
        }

        .gallery-card-img-wrapper img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            display: block;
        }

        /* ===== NEW SECTION A: TOURNAMENT JOURNEY TIMELINE ===== */
        .journey-section {
            max-width: 1400px; margin: 0 auto 40px auto;
            background: var(--card-surface); border: 1px solid var(--border-glass);
            border-radius: 18px; padding: 32px; backdrop-filter: blur(15px);
        }
        .journey-track { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; position: relative; }
        @media(max-width: 900px) { .journey-track { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 500px) { .journey-track { grid-template-columns: 1fr; } }
        .journey-step {
            background: rgba(3, 7, 18, 0.5); border: 1.5px solid var(--border-glass); border-radius: 14px;
            padding: 20px; text-align: center; position: relative; transition: all 0.3s ease;
        }
        .journey-step:hover { transform: translateY(-4px); border-color: var(--neon-cyan); box-shadow: 0 10px 25px rgba(0,217,255,0.2); }
        .journey-num {
            width: 36px; height: 36px; margin: 0 auto 12px auto; border-radius: 50%;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #000;
            display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 14px;
            box-shadow: 0 0 15px rgba(0,217,255,0.4);
        }
        .journey-step h5 { margin: 0 0 6px 0; font-size: 13.5px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; letter-spacing: 0.5px; }
        .journey-step p { margin: 0; font-size: 12px; color: var(--text-secondary); line-height: 1.5; }

        /* ===== NEW SECTION B: PRIZE POOL SHOWCASE ===== */
        .prize-pool-section {
            max-width: 1400px; margin: 0 auto 40px auto;
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px;
        }
        @media(max-width: 768px) { .prize-pool-section { grid-template-columns: 1fr; } }
        .prize-pool-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 18px;
            padding: 28px; text-align: center; backdrop-filter: blur(15px); transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); position: relative; overflow: hidden;
        }
        .prize-pool-card::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px; }
        .prize-pool-card.gold { border-color: var(--neon-gold); }
        .prize-pool-card.gold::before { background: linear-gradient(90deg, var(--neon-gold), var(--neon-amber)); }
        .prize-pool-card.silver { border-color: var(--neon-cyan); }
        .prize-pool-card.silver::before { background: linear-gradient(90deg, var(--neon-cyan), #7dd3fc); }
        .prize-pool-card.bronze { border-color: var(--neon-emerald); }
        .prize-pool-card.bronze::before { background: linear-gradient(90deg, var(--neon-emerald), #34d399); }
        .prize-pool-card:hover { transform: translateY(-6px); box-shadow: 0 15px 40px rgba(0,0,0,0.4); }
        .prize-pool-icon { font-size: 34px; margin-bottom: 12px; }
        .prize-pool-card.gold .prize-pool-icon { color: var(--neon-gold); }
        .prize-pool-card.silver .prize-pool-icon { color: var(--neon-cyan); }
        .prize-pool-card.bronze .prize-pool-icon { color: var(--neon-emerald); }
        .prize-pool-card h4 { margin: 0 0 6px 0; font-size: 15px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; letter-spacing: 0.5px; }
        .prize-pool-card p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.5; }

        /* ===== NEW SECTION C: WHY JOIN FEATURES ===== */
        .why-join-section {
            max-width: 1400px; margin: 0 auto 40px auto;
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px;
        }
        @media(max-width: 900px) { .why-join-section { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 500px) { .why-join-section { grid-template-columns: 1fr; } }
        .why-join-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 14px;
            padding: 20px; display: flex; align-items: center; gap: 14px; backdrop-filter: blur(15px);
            transition: all 0.3s ease; box-shadow: 0 10px 25px rgba(0,0,0,0.25);
        }
        .why-join-card:hover { border-color: var(--neon-cyan); transform: translateY(-3px); }
        .why-join-icon {
            width: 44px; height: 44px; flex-shrink: 0; border-radius: 12px;
            background: linear-gradient(135deg, rgba(0,217,255,0.18), rgba(181,55,242,0.18));
            border: 1.5px solid var(--neon-cyan); display: flex; align-items: center; justify-content: center;
            font-size: 18px; color: var(--neon-cyan);
        }
        .why-join-card h5 { margin: 0 0 3px 0; font-size: 13px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; }
        .why-join-card p { margin: 0; font-size: 11.5px; color: var(--text-secondary); font-weight: 600; }

        /* ===== NEW SECTION D: CTA BANNER ===== */
        .tourn-cta-banner {
            max-width: 1400px; margin: 0 auto 40px auto;
            background: linear-gradient(135deg, rgba(0,217,255,0.16), rgba(0,255,136,0.1)), var(--card-surface);
            border: 2px solid var(--neon-cyan); border-radius: 22px; padding: 40px;
            display: flex; align-items: center; justify-content: space-between; gap: 25px; flex-wrap: wrap;
            box-shadow: 0 20px 45px rgba(0,217,255,0.2); backdrop-filter: blur(20px);
        }
        .tourn-cta-text h3 { margin: 0 0 8px 0; font-size: 22px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; letter-spacing: 1px; }
        .tourn-cta-text p { margin: 0; font-size: 13.5px; color: var(--text-secondary); font-weight: 600; max-width: 560px; line-height: 1.6; }
        .tourn-cta-btn {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712;
            border: none; padding: 14px 28px; border-radius: 14px; font-weight: 900; font-size: 13px;
            text-transform: uppercase; letter-spacing: 1px; text-decoration: none; white-space: nowrap;
            display: inline-flex; align-items: center; gap: 8px; box-shadow: 0 0 25px rgba(0,217,255,0.5); transition: all 0.3s ease;
        }
        .tourn-cta-btn:hover { transform: scale(1.05); box-shadow: 0 0 35px rgba(0,255,136,0.7); color: #030712; }
        @media(max-width: 700px) { .tourn-cta-banner { flex-direction: column; text-align: center; padding: 30px 22px; } }

        /* FOOTER CSS STYLING */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
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

        /* "No tournaments" / "No search result" message (pehle inline style tha) */
        .no-tournament { grid-column: 1 / -1; text-align: center; padding: 60px; font-weight: 700; color: var(--text-secondary); background: var(--card-surface); border: 1px dashed var(--border-glass); border-radius: 16px; text-transform: uppercase; }

        /* =====================================================
           FIX 1: DARK + LIGHT MODE  (text hamesha visible)
           ===================================================== */
        :root {
            --pm-nav-bg: rgba(10, 14, 39, 0.92);
            --pm-input-bg: rgba(3, 7, 18, 0.6);
            --pm-input-focus-bg: rgba(3, 7, 18, 0.8);
            --pm-stat-bg: rgba(13, 18, 35, 0.95);
            --pm-stat-label: #ffffff;
            --pm-stat-desc: #f0f4ff;
            --pm-step-bg: rgba(3, 7, 18, 0.5);
            --pm-gal-content-bg: rgba(13, 18, 30, 0.85);
            --pm-img-bg: #020617;
            --pm-newsletter-bg: rgba(3, 7, 18, 0.7);
            --pm-footer-bg: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
        }

        /* Light mode - jo bhi toggle method use ho (data-theme / class) sab cover hai */
        :root[data-theme="light"],
        :root[data-bs-theme="light"],
        :root.light,
        :root.light-mode,
        :root.light-theme,
        :root.theme-light,
        body[data-theme="light"],
        body[data-bs-theme="light"],
        body.light,
        body.light-mode,
        body.light-theme,
        body.theme-light {
            --bg-deep: #f1f5f9;
            --card-surface: #ffffff;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: #cbd5e1;
            --neon-cyan: #0891b2;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --neon-purple: #9333ea;
            --neon-gold: #b45309;
            --pm-nav-bg: #ffffff;
            --pm-input-bg: #ffffff;
            --pm-input-focus-bg: #ffffff;
            --pm-stat-bg: #ffffff;
            --pm-stat-label: #0f172a;
            --pm-stat-desc: #334155;
            --pm-step-bg: #f1f5f9;
            --pm-gal-content-bg: #ffffff;
            --pm-img-bg: #e2e8f0;
            --pm-newsletter-bg: #ffffff;
            --pm-footer-bg: linear-gradient(135deg, #ffffff, #f1f5f9);
        }

        /* Hardcoded dark backgrounds / white text ab variables se chalenge */
        nav { background: var(--pm-nav-bg); }
        .search-input { background: var(--pm-input-bg); }
        .search-input:focus { background: var(--pm-input-focus-bg); }
        .stat-card { background: var(--pm-stat-bg); }
        .stat-label { color: var(--pm-stat-label); }
        .stat-desc { color: var(--pm-stat-desc); }
        .journey-step { background: var(--pm-step-bg); }
        .gallery-card-content { background: var(--pm-gal-content-bg); }
        .gallery-card-img-wrapper { background: var(--pm-img-bg); }
        .grand-footer-section { background: var(--pm-footer-bg); }
        .footer-newsletter input { background: var(--pm-newsletter-bg); }

        /* =====================================================
           FIX 2: FULL RESPONSIVE
           ===================================================== */
        img { max-width: 100%; }
        body { overflow-x: hidden; }
        .control-bar { flex-wrap: wrap; gap: 12px; }
        .search-input { max-width: 100%; }
        .time-col { min-width: 0; }
        .cricket-stats-section { grid-template-columns: repeat(auto-fit, minmax(min(280px, 100%), 1fr)); }
        .leaderboard-section { overflow-x: auto; }
        .leaderboard-table { min-width: 520px; }

        @media (max-width: 900px) {
            nav { padding: 12px 20px; flex-wrap: wrap; gap: 10px; }
            .nav-links { flex-wrap: wrap; justify-content: center; }
            .header-bar { flex-wrap: wrap; gap: 14px; padding: 16px 20px; }
        }

        @media (max-width: 768px) {
            nav { padding: 10px 14px; }
            .nav-links a { padding: 7px 10px; font-size: 12px; }
            .main-content-wrap { padding: 0 12px; margin: 18px auto; }
            .header-bar { flex-direction: column; align-items: stretch; text-align: center; }
            .header-left { justify-content: center; flex-wrap: wrap; }
            .jumping-title { font-size: 18px; letter-spacing: 1px; }

            /* 🌟 FIX: New Tournament + Delete All mobile par ek hi line me */
            .header-right { justify-content: center; flex-wrap: nowrap; gap: 10px; width: 100%; }
            .btn-top-add, .btn-delete-all {
                flex: 1 1 0; min-width: 0;
                display: flex; align-items: center; justify-content: center; gap: 5px;
                text-align: center; padding: 11px 8px; font-size: 12px; line-height: 1.25;
            }

            .control-bar { flex-direction: column; align-items: stretch; padding: 14px; }
            .search-input { width: 100%; }
            .stats-badge { text-align: center; }
            .tournaments-grid { gap: 20px; }
            .pagination-bar { justify-content: center; flex-wrap: wrap; gap: 12px; padding: 12px; }
            .leaderboard-section, .journey-section { padding: 20px 16px; }
            .alt-feature-box { padding: 24px; }
            .yellow-highlight-banner { padding: 26px 18px; }
            .yellow-highlight-banner h3 { font-size: 20px; }
            .grand-footer-section { padding: 36px 20px 24px 20px; width: calc(100% - 24px); }
            .grand-footer-content { gap: 28px; }
            .footer-newsletter form { flex-direction: column; }
            .footer-bottom-links { flex-wrap: wrap; justify-content: center; }
            .tourn-cta-banner { padding: 26px 18px; }
        }

        @media (max-width: 480px) {
            .card-inner { padding: 18px; }
            .timeline-box { padding: 12px; gap: 8px; }
            .stat-value { font-size: 24px; }
            .prize-pool-card { padding: 22px; }
        }

        @media (max-width: 360px) {
            .btn-top-add, .btn-delete-all { font-size: 11px; padding: 10px 6px; }
            .jumping-title { font-size: 16px; letter-spacing: 0.5px; }
        }
    </style>
</head>
<body>

    <!-- 🌟 NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">
        <div class="header-bar">
            <div class="header-left">
                <a href="/home" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</a>
            </div>
            <div>
                <h2 class="jumping-title" id="animatedTitle">TOURNAMENT COMMAND CENTER</h2>
            </div>
            <div class="header-right">
                <a href="/addTournament" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Tournament</a>
                <a href="/deleteAllTournaments" class="btn-delete-all" onclick="return confirm('⚠️ Warning: Delete ALL tournaments permanently?')">🗑 Delete All</a>
            </div>
        </div>

        <div class="control-bar">
            <input type="text" id="tournamentSearch" class="search-input" placeholder="🔍 Search tournament by name..." onkeyup="filterTournaments()" oninput="filterTournaments()" autocomplete="off">
            <div class="stats-badge">Total Tournaments: <span>${tournaments.size()}</span></div>
        </div>
        
        <c:if test="${not empty message}">
            <div class="alert-message">${message}</div>
        </c:if>

        <!-- TOURNAMENT CARDS -->
        <div class="tournaments-grid" id="tournamentsGrid">
            <c:forEach items="${tournaments}" var="t">
                <div class="tournament-card" data-name="${t.tournamentName.toLowerCase()}">
                    <div class="card-inner">
                        <div class="card-top-row">
                            <span class="tournament-id-tag">#TC-${t.id}</span>
                            <span class="season-pill">📅 Season ${t.season}</span>
                        </div>
                        <div class="tournament-title" title="${t.tournamentName}">🏆 ${t.tournamentName}</div>
                        <div class="timeline-box">
                            <div class="time-col"><span class="time-label">Starts</span><span class="time-val">${t.startDate}</span></div>
                            <div class="time-divider"></div>
                            <div class="time-col"><span class="time-label">Ends</span><span class="time-val">${t.endDate}</span></div>
                        </div>
                        <div class="card-actions">
                            <a href="/editTournament/${t.id}" class="btn-edit">✏️ Edit Cup</a>
                            <a href="/deleteTournament/${t.id}" class="btn-delete" onclick="return confirm('⚠️ Terminate this tournament permanently?');">🗑 Delete</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty tournaments}">
                <div class="no-tournament">🏏 No Active Tournaments Deployed In The System Matrix</div>
            </c:if>
        </div>

        <!-- PAGINATION -->
        <div class="pagination-bar">
            <c:choose>
                <c:when test="${currentPage > 0}">
                    <a href="/tournaments?page=${currentPage - 1}">⬅ Previous</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 700;">⬅ Previous</span>
                </c:otherwise>
            </c:choose>
            <span class="page-indicator">Page ${currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}</span>
            <c:choose>
                <c:when test="${currentPage + 1 < totalPages}">
                    <a href="/tournaments?page=${currentPage + 1}">Next ➡</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 700;">Next ➡</span>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- STATISTICS -->
        <div class="cricket-stats-section">
            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-label">Total Tournaments</div>
                <div class="stat-value">${tournaments.size()}</div>
                <div class="stat-desc">Active championship cups running</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">⚡</div>
                <div class="stat-label">Tournament Status</div>
                <div class="stat-value" style="color: var(--neon-emerald);">LIVE</div>
                <div class="stat-desc">Real-time tournament tracking</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">💻</div>
                <div class="stat-label">System Status</div>
                <div class="stat-value" style="color: var(--neon-emerald);">ONLINE</div>
                <div class="stat-desc">All services operational</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">🔗</div>
                <div class="stat-label">Quick Access</div>
                <div class="stat-value" style="font-size: 16px;">→</div>
                <div class="stat-desc"><a href="/matches" style="color: var(--neon-cyan); text-decoration: none; font-weight: 700;">View Live Matches</a></div>
            </div>
        </div>

        <!-- INSIGHTS -->
        <div class="insights-section">
            <div class="insight-card">
                <i class="fa-solid fa-chart-line"></i>
                <h3>Real-Time Performance</h3>
                <p>Track team points and NRR updates instantly as matches conclude across all active leagues.</p>
            </div>
            <div class="insight-card">
                <i class="fa-solid fa-shield-halved"></i>
                <h3>Tournament Integrity</h3>
                <p>Secure and transparent management of every single championship fixture and record.</p>
            </div>
        </div>

        <!-- LEADERBOARD -->
        <div class="leaderboard-section">
            <h3 class="section-title">⭐ Top 5 Points Table Standings</h3>
            <table class="leaderboard-table">
                <thead>
                    <tr>
                        <th>RANK</th>
                        <th>TEAM NAME</th>
                        <th>PLAYED</th>
                        <th>WON</th>
                        <th>POINTS</th>
                        <th>NRR</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pointsList}" var="pt" varStatus="loop">
                        <c:set var="actualPos" value="${pt.position != null ? pt.position : (loop.index + 1)}" />
                        <tr>
                            <td>
                                <span class="rank-badge ${actualPos == 1 ? 'top-1' : (actualPos == 2 ? 'top-2' : (actualPos == 3 ? 'top-3' : ''))}">
                                    ${actualPos}
                                </span>
                            </td>
                            <td><strong>${pt.team != null ? pt.team.teamName : 'N/A'}</strong></td>
                            <td>${pt.matchesPlayed}</td>
                            <td style="color: var(--neon-emerald); font-weight: 700;">${pt.won}</td>
                            <td><span style="color: var(--neon-gold); font-weight: 900;">${pt.points}</span></td>
                            <td><span style="color: var(--neon-cyan); font-weight: 700;">${pt.netRunRate}</span></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty pointsList}">
                        <tr>
                            <td colspan="6" style="text-align: center; color: var(--text-secondary); padding: 20px;">🏏 No Points Table Records Found</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <!-- UNIQUE ALT STYLE SECTION -->
        <div class="unique-alt-section">
            <div class="alt-feature-box">
                <div class="alt-icon-circle"><i class="fa-solid fa-shield-halved"></i></div>
                <h4>Secure Infrastructure</h4>
                <p>End-to-end encrypted tournament metrics and enterprise database security.</p>
            </div>
            <div class="alt-feature-box">
                <div class="alt-icon-circle"><i class="fa-solid fa-gauge-high"></i></div>
                <h4>High Performance</h4>
                <p>Optimized Spring Boot backend architecture ensuring zero latency.</p>
            </div>
            <div class="alt-feature-box">
                <div class="alt-icon-circle"><i class="fa-solid fa-users-gear"></i></div>
                <h4>Squad Management</h4>
                <p>Seamless roster controls and automated player auction mapping tools.</p>
            </div>
        </div>

        <!-- BANNER -->
        <div class="yellow-highlight-banner">
            <h3>⚡ Elevate Your League Management Experience</h3>
            <p>Manage championships, oversee squad player rosters, track fixtures seamlessly, and drive absolute tournament engagement with cutting-edge real-time tools.</p>
        </div>

        <!-- CIRCULAR STATS -->
        <div class="circular-stats-section">
            <div class="circle-badge-card">
                <div class="circle-icon-wrap"><i class="fa-solid fa-shield-cat"></i></div>
                <h4>Elite Competition</h4>
                <p>Battle tested formats designed for maximum team engagement and glory.</p>
            </div>
            <div class="circle-badge-card">
                <div class="circle-icon-wrap"><i class="fa-solid fa-bolt"></i></div>
                <h4>Instant Standings</h4>
                <p>Automated recalculation of run-rates and points after every single ball.</p>
            </div>
            <div class="circle-badge-card">
                <div class="circle-icon-wrap"><i class="fa-solid fa-award"></i></div>
                <h4>Championship Glory</h4>
                <p>Raise the ultimate cyber cup and etch your name in league history.</p>
            </div>
        </div>

        <!-- GALLERY SECTION -->
        <div class="footer-gallery-section">
            <div class="footer-gallery-grid">
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏟️ Grand Stadium Arena</h4>
                        <p>Witness magnificent stadium lights, roaring crowds, massive roars</p>
                    </div>
                    <div class="gallery-card-img-wrapper">
                        <img src="https://www.arabnews.com/sites/default/files/styles/n_670_395/public/2025/07/09/4619556-1034009131.jpg?itok=cdFO0JjU" alt="Stadium">
                    </div>
                </div>
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>⚡ High Voltage Match Action</h4>
                        <p>Witness raw power-hitting, fierce bowling spells, epic finishes</p>
                    </div>
                    <div class="gallery-card-img-wrapper">
                        <img src="https://media.istockphoto.com/id/177427917/photo/close-up-of-red-cricket-ball-and-bat-sitting-on-grass.jpg?s=612x612&w=0&k=20&c=DcorerbBUeDNTfld3OclgHxCty4jih2yDCzipffX6zw=" alt="Action">
                    </div>
                </div>
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🎯 Precision Match Ball</h4>
                        <p>Every match writes a new history with ultimate winning spirit</p>
                    </div>
                    <div class="gallery-card-img-wrapper">
                        <img src="https://cdn.britannica.com/63/211663-050-A674D74C/Jonny-Bairstow-batting-semifinal-match-England-Australia-2019.jpg" alt="Ball">
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== NEW SECTION A: TOURNAMENT JOURNEY TIMELINE ===== -->
        <div class="journey-section">
            <h3 class="section-title">🗺️ Tournament Journey</h3>
            <div class="journey-track">
                <div class="journey-step">
                    <div class="journey-num">1</div>
                    <h5>Registration</h5>
                    <p>Teams submit squad details and pay the entry fee to secure a slot.</p>
                </div>
                <div class="journey-step">
                    <div class="journey-num">2</div>
                    <h5>League Stage</h5>
                    <p>Round-robin matches decide the points table and NRR standings.</p>
                </div>
                <div class="journey-step">
                    <div class="journey-num">3</div>
                    <h5>Playoffs</h5>
                    <p>Top four teams battle it out in high-stakes knockout fixtures.</p>
                </div>
                <div class="journey-step">
                    <div class="journey-num">4</div>
                    <h5>Grand Final</h5>
                    <p>The last two teams face off for the championship trophy.</p>
                </div>
            </div>
        </div>

        <!-- ===== NEW SECTION B: PRIZE POOL SHOWCASE ===== -->
        <div class="prize-pool-section">
            <div class="prize-pool-card gold">
                <div class="prize-pool-icon"><i class="fa-solid fa-trophy"></i></div>
                <h4>Champions</h4>
                <p>Winner's trophy, medals and top billing on the leaderboard.</p>
            </div>
            <div class="prize-pool-card silver">
                <div class="prize-pool-icon"><i class="fa-solid fa-award"></i></div>
                <h4>Runners-Up</h4>
                <p>Runner-up trophy and medals for the finalist squad.</p>
            </div>
            <div class="prize-pool-card bronze">
                <div class="prize-pool-icon"><i class="fa-solid fa-medal"></i></div>
                <h4>Player Awards</h4>
                <p>Player of the Tournament, Best Batter and Best Bowler recognitions.</p>
            </div>
        </div>

        <!-- ===== NEW SECTION C: WHY JOIN FEATURES ===== -->
        <div class="why-join-section">
            <div class="why-join-card">
                <div class="why-join-icon"><i class="fa-solid fa-bolt"></i></div>
                <div>
                    <h5>Live Scoring</h5>
                    <p>Ball-by-ball updates on every fixture</p>
                </div>
            </div>
            <div class="why-join-card">
                <div class="why-join-icon"><i class="fa-solid fa-calculator"></i></div>
                <div>
                    <h5>Auto NRR</h5>
                    <p>Standings calculated with zero manual work</p>
                </div>
            </div>
            <div class="why-join-card">
                <div class="why-join-icon"><i class="fa-solid fa-lock"></i></div>
                <div>
                    <h5>Secure Access</h5>
                    <p>Role-based control for admins and teams</p>
                </div>
            </div>
            <div class="why-join-card">
                <div class="why-join-icon"><i class="fa-solid fa-users-gear"></i></div>
                <div>
                    <h5>Squad Control</h5>
                    <p>Manage rosters and jersey numbers easily</p>
                </div>
            </div>
        </div>

        <!-- ===== NEW SECTION D: CTA BANNER ===== -->
        <div class="tourn-cta-banner">
            <div class="tourn-cta-text">
                <h3>🚀 Ready to Enter the Arena?</h3>
                <p>Register your team for the next tournament and start competing for live standings, automated NRR and championship glory.</p>
            </div>
            <a href="${pageContext.request.contextPath}/register-team" class="tourn-cta-btn">
                <i class="fa-solid fa-shield-halved"></i> Register Your Team
            </a>
        </div>

    </div>

    <!-- 🌟 FOOTER INCLUDE -->
    <jsp:include page="footer.jsp" />

    <!-- CHATBOT INCLUDE -->
    <jsp:include page="chatbot.jsp" />

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        /* Title animation: har word ek <b> me, har letter ek <span> me.
           Isse line sirf words ke beech se tutegi, word ke beech se nahi (CE / NTER wali problem fix) */
        const titleEl = document.getElementById('animatedTitle');
        if (titleEl) {
            var pmCharIndex = 0;
            titleEl.innerHTML = titleEl.innerText.trim().split(/\s+/).map(function (word) {
                var letters = word.split('').map(function (ch) {
                    return '<span style="--i:' + (pmCharIndex++) + '">' + ch + '</span>';
                }).join('');
                pmCharIndex++; /* space ke liye delay slot */
                return '<b class="jt-word">' + letters + '</b>';
            }).join(' ');
        }

        var pmTotalText = null;

        function filterTournaments() {
            var box = document.getElementById('tournamentSearch');
            var input = (box ? box.value : '').toLowerCase().replace(/\s+/g, ' ').trim();
            var grid = document.getElementById('tournamentsGrid');
            var cards = grid ? grid.querySelectorAll('.tournament-card') : [];
            var statSpan = document.querySelector('.stats-badge span');
            var visibleCount = 0;

            if (statSpan && pmTotalText === null) pmTotalText = statSpan.innerText;

            cards.forEach(function (card) {
                var titleNode = card.querySelector('.tournament-title');
                var text = ((card.getAttribute('data-name') || '') + ' ' +
                            (titleNode ? titleNode.textContent : '')).toLowerCase().replace(/\s+/g, ' ');
                var show = (input === '' || text.indexOf(input) > -1);
                card.style.display = show ? '' : 'none';
                if (show) visibleCount++;
            });

            // Koi match na mile to message dikhao
            var emptyMsg = document.getElementById('noSearchResult');
            if (input !== '' && cards.length > 0 && visibleCount === 0) {
                if (!emptyMsg) {
                    emptyMsg = document.createElement('div');
                    emptyMsg.id = 'noSearchResult';
                    emptyMsg.className = 'no-tournament';
                    emptyMsg.textContent = '🔍 No tournaments match your search.';
                    grid.appendChild(emptyMsg);
                }
                emptyMsg.style.display = '';
            } else if (emptyMsg) {
                emptyMsg.style.display = 'none';
            }

            if (statSpan) statSpan.innerText = (input === '') ? pmTotalText : visibleCount;
        }

        const galleryCards = document.querySelectorAll('.gallery-card-item');
        galleryCards.forEach(card => {
            card.addEventListener('mouseenter', () => { card.style.animation = 'spinOnce 0.8s ease forwards'; });
            card.addEventListener('mouseleave', () => {
                setTimeout(() => { card.style.animation = 'spinFiveSecs 5s linear infinite'; }, 800);
            });
        });
    </script>
</body>
</html>
