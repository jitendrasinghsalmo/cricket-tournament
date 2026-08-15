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
            --body-overlay: rgba(10, 14, 39, 0.92);
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
            --body-overlay: rgba(245, 247, 255, 0.92);
        }

        * { box-sizing: border-box; }

        body { 
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            background-attachment: fixed;
            color: var(--text-primary); 
            margin: 0; 
            padding: 0 0 60px 0; 
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

        /* ============ GALLERY SECTION (GAP FIXED PERFECTLY) ============ */
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
            justify-content: space-between;
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

        .gallery-card-content {
            padding: 16px;
            text-align: center;
            background: rgba(13, 18, 30, 0.7);
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
            font-size: 12.5px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        .gallery-card-img-wrapper {
            position: relative;
            width: 100%;
            height: 200px;
            overflow: hidden;
            background: #020617;
            order: 2;
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

        /* FOOTER CSS STYLING */
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
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
                <a href="/addTournament" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Tournament</a>
                <a href="/deleteAllTournaments" class="btn-delete-all" onclick="return confirm('⚠️ Warning: Delete ALL tournaments permanently?')">🗑 Delete All</a>
            </div>
        </div>

        <div class="control-bar">
            <input type="text" id="tournamentSearch" class="search-input" placeholder="🔍 Search tournament by name..." onkeyup="filterTournaments()" autocomplete="off">
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
                <div style="grid-column: 1 / -1; text-align: center; padding: 60px; font-weight: 700; color: var(--text-secondary); background: var(--card-surface); border: 1px dashed var(--border-glass); border-radius: 16px; text-transform: uppercase;">🏏 No Active Tournaments Deployed In The System Matrix</div>
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
                <div class="stat-icon">🏆</div>
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
                <div class="stat-icon">🌐</div>
                <div class="stat-label">System Status</div>
                <div class="stat-value" style="color: var(--neon-emerald);">ONLINE</div>
                <div class="stat-desc">All services operational</div>
            </div>
            <div class="stat-card">
                <div class="stat-icon">📈</div>
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

        <!-- 🌟 NEW UNIQUE ALT STYLE SECTION (ADDED ABOVE YELLOW BANNER) -->
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

        <!-- GALLERY -->
        <div class="footer-gallery-section">
            <div class="footer-gallery-grid">
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏟️ Grand Stadium Arena</h4>
                        <p>World-class illumination designed for grand spectacles</p>
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

        <!-- 🌟 FOOTER INCLUDE -->
        <jsp:include page="footer.jsp" />

    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        const titleEl = document.getElementById('animatedTitle');
        titleEl.innerHTML = titleEl.innerText.split('').map((char, index) => 
            char === ' ' ? '<span style="--i:' + index + '">&nbsp;</span>' : '<span style="--i:' + index + '">' + char + '</span>'
        ).join('');

        const bodyElement = document.body;
        const themeToggleBtn = document.getElementById('themeToggleBtn');
        if (localStorage.getItem('matchTheme') === 'light') {
            bodyElement.classList.add('light-mode');
            themeToggleBtn.innerHTML = '☀️ Light Mode';
        }
        function toggleTheme() {
            if (bodyElement.classList.contains('light-mode')) {
                bodyElement.classList.remove('light-mode');
                localStorage.setItem('matchTheme', 'dark');
                themeToggleBtn.innerHTML = '🌙 Dark Mode';
            } else {
                bodyElement.classList.add('light-mode');
                themeToggleBtn.innerHTML = '☀️ Light Mode';
            }
        }

        function filterTournaments() {
            let input = document.getElementById('tournamentSearch').value.toLowerCase().trim();
            let cards = document.getElementsByClassName('tournament-card');
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
            document.querySelector('.stats-badge span').innerText = visibleCount;
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