<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="players" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Squad Roster</title>
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
        
        /* 🌟 STICKY CLEAN NAVBAR STYLING (No Button Effects) */
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

        .nav-links { list-style: none; margin: 0; padding: 0; display: flex; gap: 24px; align-items: center; }
        .nav-links a { 
            color: var(--text-secondary); text-decoration: none; font-size: 13.5px; font-weight: 700; 
            padding: 4px 0; transition: color 0.2s ease; text-transform: uppercase; letter-spacing: 0.5px;
            background: none !important; border: none !important; box-shadow: none !important; border-radius: 0 !important;
        }
        .nav-links a:hover { color: var(--neon-cyan) !important; background: none !important; box-shadow: none !important; }
        .nav-links a.active { color: var(--neon-cyan) !important; background: none !important; box-shadow: none !important; border: none !important; }

        .main-content-wrap { max-width: 1400px; margin: 40px auto; padding: 0 25px; }
        
        .header-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            margin-bottom: 40px; padding: 22px 35px; border-radius: 18px;
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            flex-wrap: wrap;
            gap: 20px;
        }
        
        .header-left { display: flex; align-items: center; gap: 15px; }
        .header-right { display: flex; align-items: center; gap: 15px; flex-wrap: wrap; }

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
            cursor: pointer;
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
            padding: 10px 18px;
            border-radius: 10px; 
            text-decoration: none; 
            font-weight: 700; 
            font-size: 13px;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
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
            margin-bottom: 45px;
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            background: var(--card-surface); 
            padding: 16px 28px; 
            border-radius: 14px; 
            border: 1.5px solid var(--border-glass);
            flex-wrap: wrap;
            gap: 15px;
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
            border: 1.5px solid var(--border-glass); 
        }
        .stats-badge span { color: var(--neon-gold); font-weight: 800; }

        .team-stats-section { max-width: 1400px; margin: 55px auto; }
        .section-title {
            font-size: 18px; font-weight: 800; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1.2px;
            margin-bottom: 28px; display: flex; align-items: center; gap: 12px;
        }
        .section-title::before { content: ''; width: 4px; height: 24px; background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald)); border-radius: 2px; }

        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 25px; }
        @media(max-width: 1024px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .stats-grid { grid-template-columns: 1fr; } }

        .stat-box {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 18px;
            padding: 28px; text-align: center; transition: all 0.3s ease;
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .stat-box:hover { border-color: var(--neon-cyan); transform: translateY(-5px); }
        .stat-number { font-size: 32px; font-weight: 900; color: var(--neon-cyan); margin-bottom: 6px; }
        .stat-label { font-size: 13px; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; }

        /* PLAYERS GRID - Increased Gaping */
        .players-grid { 
            display: grid; 
            grid-template-columns: repeat(3, 1fr); 
            gap: 35px; 
            max-width: 1400px; 
            margin: 45px auto; 
        }
        @media(max-width: 1024px) { .players-grid { grid-template-columns: repeat(2, 1fr); gap: 25px; } }
        @media(max-width: 768px) { .players-grid { grid-template-columns: 1fr; gap: 20px; } }
        
        .player-card {
            background: linear-gradient(145deg, #0e1428 0%, #060917 100%);
            border-radius: 22px; 
            border: 1.5px solid rgba(0, 217, 255, 0.2);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4), inset 0 1px 0 rgba(255, 255, 255, 0.05); 
            position: relative; 
            overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            display: flex; 
            flex-direction: column; 
            justify-content: space-between;
            padding: 30px;
        }
        
        .player-card::before {
            content: ''; 
            position: absolute; 
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 5px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-purple));
        }

        .player-card:hover { 
            transform: translateY(-8px) scale(1.02); 
            border-color: var(--neon-cyan); 
            box-shadow: 0 20px 45px rgba(0, 217, 255, 0.25), 0 0 20px rgba(0, 255, 136, 0.15); 
        }

        .player-card-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 18px;
        }

        .player-id-badge {
            font-size: 11.5px; 
            font-weight: 800; 
            color: var(--neon-cyan); 
            background: rgba(0, 217, 255, 0.12); 
            border: 1px solid rgba(0, 217, 255, 0.3);
            padding: 4px 10px; 
            border-radius: 8px;
            letter-spacing: 0.5px;
        }

        .jersey-badge {
            font-size: 12px; 
            font-weight: 900; 
            color: var(--neon-gold); 
            background: rgba(255, 215, 0, 0.12); 
            border: 1px solid rgba(255, 215, 0, 0.3);
            padding: 4px 10px; 
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .player-name {
            margin: 0 0 20px 0; 
            font-size: 20px; 
            font-weight: 900; 
            color: var(--text-primary); 
            text-transform: uppercase; 
            letter-spacing: 0.8px;
            border-bottom: 1.5px dashed var(--border-glass);
            padding-bottom: 14px;
        }

        .player-info-grid {
            display: flex;
            flex-direction: column;
            gap: 12px;
            font-size: 13px;
            color: var(--text-secondary);
            margin-bottom: 25px;
        }

        .player-info-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            background: rgba(255, 255, 255, 0.02);
            padding: 10px 14px;
            border-radius: 10px;
            border: 1px solid rgba(30, 41, 75, 0.5);
        }

        .player-info-item strong {
            color: var(--text-primary);
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
        }

        .card-actions { 
            display: grid; 
            grid-template-columns: 1fr 1fr; 
            gap: 14px; 
            margin-top: auto; 
        }
        
        .card-actions a {
            text-align: center; 
            text-decoration: none; 
            padding: 12px; 
            border-radius: 12px;
            font-size: 11.5px; 
            font-weight: 800; 
            text-transform: uppercase; 
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
            letter-spacing: 0.5px;
        }

        .btn-edit { 
            background: rgba(0, 217, 255, 0.1); 
            color: var(--neon-cyan); 
            border: 1.5px solid var(--neon-cyan); 
        }
        .btn-edit:hover { 
            background: var(--neon-cyan); 
            color: #030712; 
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.5);
            transform: translateY(-2px);
        }

        .btn-delete { 
            background: rgba(255, 0, 110, 0.1); 
            color: var(--neon-rose); 
            border: 1.5px solid var(--neon-rose); 
        }
        .btn-delete:hover { 
            background: var(--neon-rose); 
            color: #fff; 
            box-shadow: 0 0 15px rgba(255, 0, 110, 0.5);
            transform: translateY(-2px);
        }

        /* EXTRA LARGE BOLD HIGHLIGHT SECTIONS STYLING - Increased Gaping */
        .highlight-sections-wrapper {
            max-width: 1400px;
            margin: 60px auto;
            display: flex;
            flex-direction: column;
            gap: 35px;
        }

        .hl-row {
            display: flex;
            gap: 35px;
            width: 100%;
        }
        @media(max-width: 900px) { .hl-row { flex-direction: column; gap: 20px; } }

        /* BIG BOLD CARDS BASE */
        .hl-box-large {
            background: linear-gradient(145deg, var(--card-surface) 0%, #060917 100%);
            border: 1.5px solid var(--border-glass);
            border-radius: 24px;
            padding: 40px 45px;
            box-shadow: 0 15px 40px rgba(0,0,0,0.4);
            display: flex;
            align-items: center;
            position: relative;
            overflow: hidden;
            transition: all 0.4s ease;
            width: 100%;
        }
        .hl-box-large:hover {
            border-color: var(--neon-cyan);
            box-shadow: 0 20px 50px rgba(0, 217, 255, 0.25);
            transform: translateY(-5px);
        }

        .hl-big-icon {
            width: 85px;
            height: 85px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 34px;
            flex-shrink: 0;
            margin-right: 30px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }

        .hl-content-large h3 { 
            margin: 0 0 10px 0; 
            font-size: 20px; 
            font-weight: 900; 
            color: var(--text-primary); 
            text-transform: uppercase; 
            letter-spacing: 0.8px; 
        }
        .hl-content-large p { 
            margin: 0; 
            font-size: 14.5px; 
            color: var(--text-secondary); 
            line-height: 1.6; 
        }

        .hl-grand-wide {
            width: 100%;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.1) 0%, rgba(181, 55, 242, 0.1) 100%);
            border: 1.5px solid var(--neon-cyan);
            border-left: 8px solid var(--neon-cyan);
            box-shadow: 0 20px 50px rgba(0, 217, 255, 0.18);
            padding: 45px 50px;
        }

        /* MASTER HERO BANNER */
        .master-hero-banner {
            width: 100%;
            background: linear-gradient(135deg, rgba(14, 20, 40, 0.98) 0%, rgba(10, 14, 39, 0.99) 100%);
            border: 2px solid var(--neon-purple);
            border-radius: 30px;
            padding: 55px 65px;
            box-shadow: 0 25px 60px rgba(181, 55, 242, 0.25), inset 0 0 30px rgba(0, 217, 255, 0.05);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 30px;
            margin-bottom: 35px;
        }
        .master-hero-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 6px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-purple), var(--neon-emerald), var(--neon-gold));
        }
        .master-hero-header {
            display: flex;
            align-items: center;
            gap: 25px;
        }
        .master-hero-icon {
            width: 95px;
            height: 95px;
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-cyan));
            border-radius: 22px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
            color: #030712;
            flex-shrink: 0;
            box-shadow: 0 0 30px rgba(181, 55, 242, 0.6);
        }
        .master-hero-title h2 {
            margin: 0 0 8px 0;
            font-size: 26px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            text-shadow: 0 0 15px rgba(0, 217, 255, 0.4);
        }
        .master-hero-title span {
            font-size: 13.5px;
            color: var(--neon-cyan);
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 2px;
        }
        .master-hero-desc {
            font-size: 15.5px;
            color: var(--text-secondary);
            line-height: 1.8;
            margin: 0;
        }
        .master-hero-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            margin-top: 15px;
            border-top: 1.5px dashed var(--border-glass);
            padding-top: 30px;
        }
        @media(max-width: 900px) { .master-hero-grid { grid-template-columns: 1fr; gap: 15px; } .master-hero-banner { padding: 35px 25px; } }
        
        .hero-mini-box {
            background: rgba(255, 255, 255, 0.02);
            border: 1.5px solid var(--border-glass);
            border-radius: 16px;
            padding: 24px;
            transition: 0.3s;
        }
        .hero-mini-box:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-3px);
            background: rgba(0, 217, 255, 0.04);
        }
        .hero-mini-box h4 {
            margin: 0 0 8px 0;
            font-size: 15px;
            font-weight: 800;
            color: var(--neon-emerald);
            text-transform: uppercase;
        }
        .hero-mini-box p {
            margin: 0;
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* PROFESSIONAL ELITE PRO-ARENA EXECUTIVE SHOWCASE */
        .pro-executive-showcase {
            width: 100%;
            background: linear-gradient(135deg, #090e21 0%, #121936 100%);
            border: 2px solid rgba(0, 255, 136, 0.3);
            border-radius: 28px;
            padding: 60px 65px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.5), inset 0 0 40px rgba(0, 255, 136, 0.03);
            position: relative;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            gap: 35px;
            margin-bottom: 35px;
        }
        .pro-executive-showcase::after {
            content: '';
            position: absolute;
            bottom: 0;
            right: 0;
            width: 300px;
            height: 300px;
            background: radial-gradient(circle, rgba(0, 255, 136, 0.07) 0%, transparent 70%);
            pointer-events: none;
        }
        .pro-exec-top {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 20px;
            border-bottom: 1.5px solid var(--border-glass);
            padding-bottom: 25px;
        }
        .pro-exec-title-group h2 {
            margin: 0 0 6px 0;
            font-size: 28px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 1.2px;
        }
        .pro-exec-title-group p {
            margin: 0;
            font-size: 14px;
            color: var(--neon-emerald);
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        .pro-exec-badge {
            background: rgba(0, 255, 136, 0.1);
            border: 1.5px solid var(--neon-emerald);
            color: var(--neon-emerald);
            padding: 10px 20px;
            border-radius: 12px;
            font-weight: 800;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 0 15px rgba(0, 255, 136, 0.2);
        }
        .pro-exec-content-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 35px;
        }
        @media(max-width: 900px) { .pro-exec-content-grid { grid-template-columns: 1fr; gap: 20px; } .pro-executive-showcase { padding: 35px 25px; } }
        
        .pro-exec-card {
            background: rgba(255, 255, 255, 0.02);
            border: 1.5px solid var(--border-glass);
            border-radius: 18px;
            padding: 30px;
            display: flex;
            gap: 20px;
            align-items: flex-start;
            transition: 0.3s;
        }
        .pro-exec-card:hover {
            border-color: var(--neon-emerald);
            transform: translateY(-4px);
            background: rgba(0, 255, 136, 0.03);
            box-shadow: 0 10px 30px rgba(0, 255, 136, 0.1);
        }
        .pro-exec-card-icon {
            width: 60px;
            height: 60px;
            background: rgba(0, 255, 136, 0.12);
            border: 1.5px solid var(--neon-emerald);
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--neon-emerald);
            flex-shrink: 0;
        }
        .pro-exec-card-text h4 {
            margin: 0 0 8px 0;
            font-size: 17px;
            font-weight: 800;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .pro-exec-card-text p {
            margin: 0;
            font-size: 13.5px;
            color: var(--text-secondary);
            line-height: 1.6;
        }

        /* GALLERY SECTION - 360 FULL CARD ROTATION ON HOVER */
        .gallery-section { max-width: 1400px; margin: 60px auto; }
        .footer-gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 35px; }
        @media(max-width: 768px) { .footer-gallery-grid { grid-template-columns: 1fr; gap: 20px; } }

        .gallery-clean-card {
            background: var(--card-surface); border-radius: 16px; overflow: hidden; border: 1.5px solid var(--border-glass);
            display: flex; flex-direction: column; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            transition: transform 0.5s cubic-bezier(0.4, 0, 0.2, 1);
            transform-origin: center center;
        }
        .gallery-card-content { padding: 25px; order: 1; }
        .gallery-card-content h4 { margin: 0 0 8px 0; font-size: 14.5px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; }
        .gallery-card-content p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.5; }
        
        .gallery-card-img-wrapper {
            width: 100%; height: 180px; overflow: hidden; order: 2;
            background: #020617; border-top: 1.5px solid var(--border-glass);
        }
        .gallery-card-img-wrapper img { width: 100%; height: 100%; object-fit: cover; object-position: top; display: block; }
        
        .gallery-clean-card:hover {
            transform: rotate(360deg) scale(1.03);
            border-color: var(--neon-cyan);
            box-shadow: 0 0 30px rgba(0, 217, 255, 0.5);
        }

        /* GRAND CYBER FOOTER STYLING */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; }
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

        .no-player { text-align: center; color: var(--text-secondary); grid-column: 1 / -1; padding: 60px; font-size: 15px; font-weight: 700; background: var(--card-surface); border: 1.5px dashed var(--border-glass); border-radius: 16px; text-transform: uppercase; }
    </style>
</head>
<body>

    <!-- 🌟 NAVBAR -->
    <nav>
        <a href="/home" class="logo-box">
            <div class="logo-icon">P</div>
            <div class="logo-text">ProMatch Arena<span>Control Center</span></div>
        </a>
        <ul class="nav-links">
            <li><a href="/home" class="${page == 'home' ? 'active' : ''}">Home</a></li>
            <li><a href="/teams" class="${page == 'teams' ? 'active' : ''}">Teams</a></li>
            <li><a href="#" class="${page == 'players' ? 'active' : ''}">View Players</a></li>
            <li><a href="/matches" class="${page == 'matches' ? 'active' : ''}">Matches</a></li>
            <li><a href="/pointsTable" class="${page == 'points' ? 'active' : ''}">Points Table</a></li>
            <li><a href="/tournaments" class="${page == 'tournaments' ? 'active' : ''}">Tournaments</a></li>
        </ul>
    </nav>

    <div class="main-content-wrap">
        <div class="header-bar">
            <div class="header-left">
                <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            </div>
            
            <div>
                <h2 class="jumping-title" id="animatedTitle">SQUAD ROSTER</h2>
            </div>

            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
                <a href="${pageContext.request.contextPath}/addPlayer/${teamId}" class="btn-top-add"><i class="fa-solid fa-plus"></i> Add Player</a>
                <c:if test="${not empty players}">
                    <a href="${pageContext.request.contextPath}/deleteAllPlayers/${teamId}" class="btn-delete-all" onclick="return confirm('⚠️ DANGER: Delete all players from this squad permanently?');">
                        <i class="fa-solid fa-trash-can"></i> Delete All
                    </a>
                </c:if>
            </div>
        </div>

        <div class="control-bar">
            <input type="text" id="playerSearch" class="search-input" placeholder="🔍 Search player by name..." onkeyup="filterPlayers()" autocomplete="off">
            <div class="stats-badge">Total Squad: <span>${players.size()}</span></div>
        </div>

        <!-- PLAYERS GRID WITH PREMIUM DESIGN -->
        <div class="players-grid" id="playersGrid">
            <c:forEach items="${players}" var="p">
                <div class="player-card" data-name="${p.playerName.toLowerCase()}">
                    <div>
                        <div class="player-card-header">
                            <span class="player-id-badge"><i class="fa-solid fa-id-badge"></i> #PL-${p.id}</span>
                            <span class="jersey-badge"><i class="fa-solid fa-shirt"></i> #${p.jerseyNumber}</span>
                        </div>
                        
                        <h4 class="player-name" title="${p.playerName}">${p.playerName}</h4>
                        
                        <div class="player-info-grid">
                            <div class="player-info-item">
                                <span>📍 Role</span>
                                <strong style="color: var(--neon-emerald);">${p.role}</strong>
                            </div>
                            <div class="player-info-item">
                                <span>📅 Age</span>
                                <strong>${p.age} Years</strong>
                            </div>
                            <div class="player-info-item">
                                <span>🏏 Batting</span>
                                <strong>${p.battingStyle}</strong>
                            </div>
                            <div class="player-info-item">
                                <span>⚡ Bowling</span>
                                <strong>${p.bowlingStyle}</strong>
                            </div>
                        </div>
                    </div>

                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/editPlayer/${p.id}" class="btn-edit"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                        <a href="${pageContext.request.contextPath}/deletePlayer/${p.id}?teamId=${teamId}" class="btn-delete" onclick="return confirm('⚠️ Delete this player permanently?');"><i class="fa-solid fa-trash"></i> Delete</a>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty players}">
                <div class="no-player">🏏 No active players registered in this squad yet.</div>
            </c:if>
        </div>

        <!-- SQUAD STATISTICS -->
        <c:if test="${not empty players}">
            <div class="team-stats-section">
                <h3 class="section-title">📊 Squad Overview</h3>
                <div class="stats-grid">
                    <div class="stat-box">
                        <div class="stat-number">${players.size()}</div>
                        <div class="stat-label">Squad Strength</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">3</div>
                        <div class="stat-label">Active Roles</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">100%</div>
                        <div class="stat-label">Readiness</div>
                    </div>
                    <div class="stat-box">
                        <div class="stat-number">A+</div>
                        <div class="stat-label">Rating</div>
                    </div>
                </div>
            </div>
        </c:if>

        <!-- EXTRA LARGE BOLD HIGHLIGHT SECTIONS -->
        <div class="highlight-sections-wrapper">
            
            <!-- Row 1 -->
            <div class="hl-row">
                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712;">
                        <i class="fa-solid fa-shield-halved"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Elite Squad Defense</h3>
                        <p>Engineered with high-end tactical balance, securing ultimate protection across all multi-format tournament challenges and playoff stages.</p>
                    </div>
                </div>

                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: linear-gradient(135deg, var(--neon-purple), var(--neon-rose)); color: #fff;">
                        <i class="fa-solid fa-bolt-lightning"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Powerplay Dominance</h3>
                        <p>Aggressive opening strike-rates designed to maximize early powerplay run-chases and put maximum pressure on opposing bowling units.</p>
                    </div>
                </div>
            </div>

            <!-- Row 2 -->
            <div class="hl-row">
                <div class="hl-box-large hl-grand-wide">
                    <div class="hl-big-icon" style="background: linear-gradient(135deg, var(--neon-cyan), var(--neon-purple)); color: #fff; box-shadow: 0 0 25px rgba(0, 217, 255, 0.5);">
                        <i class="fa-solid fa-chart-line"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3 style="font-size: 22px; color: var(--neon-cyan);">Advanced Analytics & Momentum Engine</h3>
                        <p style="font-size: 15px;">Empowered by real-time player telemetry, tactical strike-rate tracking, and high-pressure middle-order stability metrics to completely dominate every single phase of a high-stakes match night.</p>
                    </div>
                </div>
            </div>

            <!-- Row 3 -->
            <div class="hl-row">
                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: rgba(255,215,0,0.15); border: 2px solid var(--neon-gold); color: var(--neon-gold);">
                        <i class="fa-solid fa-medal"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Champion Mentality</h3>
                        <p>Unshakable mental toughness, unwavering focus, and supreme hunger for securing trophies on grand match nights.</p>
                    </div>
                </div>

                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: rgba(0,255,136,0.15); border: 2px solid var(--neon-emerald); color: var(--neon-emerald);">
                        <i class="fa-solid fa-people-group"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Seamless Synergy</h3>
                        <p>Flawless on-field communication, coordination, and team bonding across all active playing eleven squad members.</p>
                    </div>
                </div>

                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: rgba(255,0,110,0.15); border: 2px solid var(--neon-rose); color: var(--neon-rose);">
                        <i class="fa-solid fa-fire-flame-curved"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Clutch Performance</h3>
                        <p>Delivering peak efficiency and decisive match-winning spells under immense pressure during crunch death overs.</p>
                    </div>
                </div>
            </div>

            <!-- Row 4 -->
            <div class="hl-row">
                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: rgba(255,165,0,0.15); border: 2px solid var(--neon-amber); color: var(--neon-amber);">
                        <i class="fa-solid fa-arrows-spin"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Tactical Rotations</h3>
                        <p>Seamless player substitutions, smart batting order shuffles, and expert spin-bowling variations tailored for turning pitches.</p>
                    </div>
                </div>

                <div class="hl-box-large" style="flex: 1;">
                    <div class="hl-big-icon" style="background: rgba(0,255,136,0.15); border: 2px solid var(--neon-emerald); color: var(--neon-emerald);">
                        <i class="fa-solid fa-bullseye"></i>
                    </div>
                    <div class="hl-content-large">
                        <h3>Precision Execution</h3>
                        <p>Clinical delivery execution in crunch-game situations and flawless boundary-stopping defensive fielding drills.</p>
                    </div>
                </div>
            </div>

            <!-- MASTER HERO BANNER -->
            <div class="master-hero-banner">
                <div class="master-hero-header">
                    <div class="master-hero-icon">
                        <i class="fa-solid fa-crown"></i>
                    </div>
                    <div class="master-hero-title">
                        <span>ProMatch Arena Exclusive</span>
                        <h2>Ultimate Championship Legacy & Grand Arena Mastery</h2>
                    </div>
                </div>
                <p class="master-hero-desc">
                    Welcome to the pinnacle of competitive sports management. Our squad roster is built upon rigorous data-driven performance metrics, unmatched athletic discipline, and psychological resilience under extreme match pressure. Every player, from opening batsmen to death-over specialists, is trained to operate at peak efficiency on world-class floodlit stages.
                </p>
                <div class="master-hero-grid">
                    <div class="hero-mini-box">
                        <h4><i class="fa-solid fa-shield-halved"></i> Strategic Defense</h4>
                        <p>Fortified tactical frameworks designed to absorb pressure and stifle opposition momentum during critical middle overs.</p>
                    </div>
                    <div class="hero-mini-box">
                        <h4><i class="fa-solid fa-fire"></i> High-Voltage Attack</h4>
                        <p>Explosive batting line-ups and lethal bowling spells engineered to dictate terms from the very first ball of the game.</p>
                    </div>
                    <div class="hero-mini-box">
                        <h4><i class="fa-solid fa-trophy"></i> Championship Glory</h4>
                        <p>An unwavering commitment to lifting silverware, backed by seamless team chemistry and legendary match-winning performances.</p>
                    </div>
                </div>
            </div>

            <!-- PROFESSIONAL ELITE EXECUTIVE SHOWCASE -->
            <div class="pro-executive-showcase">
                <div class="pro-exec-top">
                    <div class="pro-exec-title-group">
                        <p><i class="fa-solid fa-shield-cat"></i> Executive Control & Core Architecture</p>
                        <h2>Pro-Arena High Performance Governance</h2>
                    </div>
                    <div class="pro-exec-badge">
                        <i class="fa-solid fa-circle-check"></i> Verified Elite Standards
                    </div>
                </div>
                <div class="pro-exec-content-grid">
                    <div class="pro-exec-card">
                        <div class="pro-exec-card-icon">
                            <i class="fa-solid fa-microchip"></i>
                        </div>
                        <div class="pro-exec-card-text">
                            <h4>Telemetry & Real-Time Analytics</h4>
                            <p>Continuous evaluation of player workload, strike efficacy, and ball-by-ball impact metrics to optimize tactical line-ups instantly.</p>
                        </div>
                    </div>
                    <div class="pro-exec-card">
                        <div class="pro-exec-card-icon">
                            <i class="fa-solid fa-chess-rook"></i>
                        </div>
                        <div class="pro-exec-card-text">
                            <h4>Dynamic Pitch Adaptation</h4>
                            <p>Advanced tactical protocols designed to adjust spin variations and batting aggression dynamically according to pitch degradation.</p>
                        </div>
                    </div>
                    <div class="pro-exec-card">
                        <div class="pro-exec-card-icon">
                            <i class="fa-solid fa-heart-pulse"></i>
                        </div>
                        <div class="pro-exec-card-text">
                            <h4>Player Wellness & Recovery</h4>
                            <p>State-of-the-art sports science protocols ensuring optimal physical endurance and injury prevention throughout long tournament calendars.</p>
                        </div>
                    </div>
                    <div class="pro-exec-card">
                        <div class="pro-exec-card-icon">
                            <i class="fa-solid fa-handshake-angle"></i>
                        </div>
                        <div class="pro-exec-card-text">
                            <h4>Synergy & Leadership Core</h4>
                            <p>Fostering an ecosystem of mutual trust, accountability, and veteran mentorship to steer the franchise toward unprecedented silverware.</p>
                        </div>
                    </div>
                </div>
            </div>

        </div>

        <!-- GALLERY SECTION -->
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