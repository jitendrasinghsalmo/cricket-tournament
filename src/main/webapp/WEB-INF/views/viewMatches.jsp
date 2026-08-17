<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="matches" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Match Control Center</title>
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

        /* 🌟 NAVBAR STYLING */
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
        
        .main-content-area { max-width: 1400px; margin: 30px auto; padding: 0 20px; }
        
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

        /* MATCHES MAIN SECTION */
        .matches-grid { 
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; max-width: 1400px; margin: 0 auto 40px auto;
        }

        @media(max-width: 1024px) { .matches-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 768px) { .matches-grid { grid-template-columns: 1fr; } }
        
        .match-card {
            background: var(--card-surface); 
            border-radius: 18px; border: 1px solid var(--border-glass);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3); display: flex; overflow: hidden; position: relative;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .match-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
        }
        .match-card:hover {
            transform: translateY(-10px) scale(1.02); border-color: var(--neon-cyan);
            box-shadow: 0 25px 50px rgba(0, 217, 255, 0.3);
        }

        .card-details-side {
            flex: 1; padding: 20px; display: flex; flex-direction: column; justify-content: space-between; gap: 12px;
        }

        .match-header-row { display: flex; justify-content: space-between; align-items: center; }
        .tournament-title { font-size: 10.5px; color: var(--neon-cyan); text-transform: uppercase; font-weight: 800; background: rgba(0,217,255,0.1); padding: 4px 10px; border-radius: 6px; border: 1px solid var(--border-glass); }
        
        .status-badge-pro { padding: 4px 10px; border-radius: 12px; font-size: 10px; font-weight: 800; text-transform: uppercase; }
        .status-upcoming { background: rgba(255,165,0,0.15); color: var(--neon-amber); border: 1px solid var(--neon-amber); }
        .status-completed { background: rgba(0,255,136,0.15); color: var(--neon-emerald); border: 1px solid var(--neon-emerald); }

        .teams-display { font-size: 16px; font-weight: 800; color: var(--text-primary); letter-spacing: 0.5px; }
        .vs-text { color: var(--neon-rose); font-weight: 900; margin: 0 6px; font-size: 13px; }

        .match-meta-info { font-size: 12px; color: var(--text-secondary); line-height: 1.6; border-top: 1px solid var(--border-glass); padding-top: 8px; }
        .match-meta-info strong { color: var(--text-primary); }

        .card-actions-row { display: grid; grid-template-columns: 1fr 1fr; gap: 8px; padding-top: 6px; }
        .card-actions-row a { text-align: center; text-decoration: none; padding: 8px; border-radius: 8px; font-size: 11.5px; font-weight: 700; text-transform: uppercase; }
        .btn-edit-pro { background: rgba(0, 217, 255, 0.15); color: var(--neon-cyan); border: 1.5px solid var(--neon-cyan); }
        .btn-edit-pro:hover { background: rgba(0, 217, 255, 0.3); color: #fff; }
        .btn-delete-pro { background: rgba(255, 0, 110, 0.15); color: var(--neon-rose); border: 1.5px solid var(--neon-rose); }
        .btn-delete-pro:hover { background: rgba(255, 0, 110, 0.3); color: #fff; }

        .card-image-side {
            flex: 0.6;
            background: url('https://t3.ftcdn.net/jpg/00/77/80/30/360_F_77803034_gH61aEkhTgUS6F2X8Bpne2HRMdCXa7M6.jpg') no-repeat center center;
            background-size: cover; 
            display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end;
            padding: 12px; border-left: 1px solid var(--border-glass); position: relative;
        }
        .arena-tag { background: rgba(0,0,0,0.8); color: var(--neon-cyan); font-size: 9.5px; font-weight: 800; padding: 3px 8px; border-radius: 6px; border: 1px solid var(--border-glass); }
        .match-id-badge { background: rgba(0,0,0,0.8); color: var(--neon-gold); font-size: 10px; font-weight: 800; padding: 3px 8px; border-radius: 6px; border: 1px solid var(--neon-gold); }

        /* PAGINATION */
        .pagination-bar {
            display: flex; justify-content: flex-end; align-items: center; gap: 20px;
            max-width: 1400px; margin: 0 auto 50px auto; padding: 16px 30px; border-radius: 14px;
        }
        .pagination-bar a {
            padding: 10px 20px; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #000; border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 12px; text-transform: uppercase;
        }
        .page-indicator { font-size: 13px; font-weight: 700; color: var(--text-secondary); padding: 0 15px; border-left: 2px solid var(--border-glass); border-right: 2px solid var(--border-glass); }

        /* MEGA SHOWCASE BANNER */
        .mega-showcase-banner {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            background: #0e1428;
            border: 2px solid var(--neon-cyan);
            border-radius: 24px;
            padding: 45px 40px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 30px;
            box-shadow: 0 15px 45px rgba(0, 217, 255, 0.15);
        }
        @media(max-width: 768px) {
            .mega-showcase-banner { flex-direction: column; text-align: center; padding: 30px 20px; }
        }
        .mega-banner-left h2 {
            margin: 0 0 12px 0; font-size: 28px; font-weight: 900; color: var(--neon-cyan);
            text-transform: uppercase; letter-spacing: 1.5px; text-shadow: 0 0 10px rgba(0, 217, 255, 0.4);
        }
        .mega-banner-left p {
            margin: 0; font-size: 15px; color: var(--text-secondary); line-height: 1.7; max-width: 800px; font-weight: 600;
        }
        .mega-banner-right { display: flex; gap: 15px; flex-shrink: 0; }
        .mega-stat-box {
            background: #080b1e; border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 20px 25px; text-align: center; min-width: 130px;
        }
        .mega-stat-box h3 { margin: 0 0 5px 0; font-size: 24px; font-weight: 900; color: var(--neon-gold); }
        .mega-stat-box span { font-size: 11px; font-weight: 800; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 0.5px; }

        /* DUAL PRO ARENA FEATURE CARDS */
        .dual-pro-cards-section {
            max-width: 1400px; margin: 0 auto 40px auto; display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px;
        }
        @media(max-width: 768px) { .dual-pro-cards-section { grid-template-columns: 1fr; } }
        .pro-feature-card {
            background: #0e1428; border: 1.5px solid var(--border-glass); border-radius: 20px; padding: 30px; position: relative; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.3); transition: all 0.4s ease;
        }
        .pro-feature-card:hover { transform: translateY(-6px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }
        .pro-feature-card::after { content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 3px; background: linear-gradient(90deg, var(--neon-cyan), var(--neon-purple)); }
        .pro-feature-icon {
            width: 60px; height: 60px; background: rgba(0, 217, 255, 0.12); border: 1.5px solid var(--neon-cyan); border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 24px; color: var(--neon-cyan); margin-bottom: 20px; box-shadow: 0 0 15px rgba(0, 217, 255, 0.3);
        }
        .pro-feature-card h4 { font-size: 17px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 10px; }
        .pro-feature-card p { font-size: 13.5px; color: var(--text-secondary); line-height: 1.6; margin: 0; }

        /* CIRCULAR BADGE STATS SECTION */
        .circular-stats-section {
            max-width: 1400px; margin: 0 auto 40px auto; display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px;
        }
        @media(max-width: 768px) { .circular-stats-section { grid-template-columns: 1fr; } }
        .circle-badge-card {
            background: #0e1428; border: 1.5px solid var(--border-glass); border-radius: 20px; padding: 30px 20px; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.3); transition: all 0.3s ease;
        }
        .circle-badge-card:hover { transform: translateY(-5px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }
        .circle-icon-wrap {
            width: 75px; height: 75px; margin: 0 auto 15px auto; border-radius: 50%; background: rgba(0, 217, 255, 0.15); border: 2px solid var(--neon-cyan); display: flex; align-items: center; justify-content: center; font-size: 26px; color: var(--neon-cyan); box-shadow: 0 0 15px rgba(0, 217, 255, 0.3);
        }
        .circle-badge-card h4 { margin: 0 0 8px 0; font-size: 15px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; }
        .circle-badge-card p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.5; }

        /* 🌟 NAYA BADA MASTER HERO SHOWCASE SECTION (ADDED JUST ABOVE HIGHLIGHTS) */
        .master-hero-showcase {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            background: #0e1428;
            border: 2px solid var(--border-glass);
            border-radius: 24px;
            padding: 50px 40px;
            display: flex;
            flex-direction: column;
            gap: 25px;
            box-shadow: 0 15px 45px rgba(0,0,0,0.4);
            position: relative;
            overflow: hidden;
        }
        .master-hero-showcase::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 5px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-purple), var(--neon-emerald));
        }
        .master-hero-header {
            display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 20px;
        }
        .master-hero-title-area h3 {
            margin: 0 0 8px 0; font-size: 24px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; letter-spacing: 1px;
        }
        .master-hero-title-area p {
            margin: 0; font-size: 14px; color: var(--text-secondary); line-height: 1.6; font-weight: 500; max-width: 750px;
        }
        .master-hero-badge {
            background: rgba(0, 217, 255, 0.1); border: 1.5px solid var(--neon-cyan); color: var(--neon-cyan);
            font-size: 12px; font-weight: 800; padding: 8px 18px; border-radius: 12px; text-transform: uppercase; letter-spacing: 1px;
        }
        .master-hero-metrics-grid {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-top: 10px;
        }
        @media(max-width: 768px) { .master-hero-metrics-grid { grid-template-columns: 1fr; } }
        .master-metric-item {
            background: #080b1e; border: 1px solid var(--border-glass); border-radius: 16px; padding: 20px; display: flex; align-items: center; gap: 15px;
        }
        .master-metric-icon {
            width: 45px; height: 45px; background: rgba(0, 217, 255, 0.1); border: 1px solid var(--neon-cyan); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--neon-cyan); flex-shrink: 0;
        }
        .master-metric-info h5 { margin: 0 0 4px 0; font-size: 14px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; }
        .master-metric-info span { font-size: 12px; color: var(--text-secondary); line-height: 1.4; display: block; }

        /* PRO MATCH HIGHLIGHTS & QUICK ANALYTICS SECTION */
        .pro-highlights-section { max-width: 1400px; margin: 0 auto 40px auto; }
        .section-title { font-size: 18px; font-weight: 800; color: var(--text-primary); margin-bottom: 24px; text-transform: uppercase; letter-spacing: 1.2px; display: flex; align-items: center; gap: 12px; }
        .section-title::before { content: ''; width: 4px; height: 24px; background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald)); border-radius: 2px; }
        
        .highlights-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .highlights-grid { grid-template-columns: 1fr; } }

        .highlight-card {
            background: #0e1428; border: 1.5px solid var(--border-glass); border-radius: 18px; padding: 25px; transition: all 0.3s ease; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            position: relative; overflow: hidden;
        }
        .highlight-card::after {
            content: ''; position: absolute; bottom: 0; left: 0; width: 100%; height: 3px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-purple));
        }
        .highlight-card:hover { transform: translateY(-5px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }
        .highlight-icon { width: 50px; height: 50px; background: rgba(0, 217, 255, 0.1); border: 1px solid var(--neon-cyan); border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 22px; color: var(--neon-cyan); margin-bottom: 16px; }
        .highlight-card h4 { margin: 0 0 8px 0; font-size: 16px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; }
        .highlight-card p { margin: 0; font-size: 13px; color: var(--text-secondary); line-height: 1.6; }

        /* CRICKET SECTIONS */
        .cricket-section { max-width: 1400px; margin: 0 auto 40px auto; }
        .cricket-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(320px, 1fr)); gap: 25px; }

        .performer-card {
            background: #0e1428; border: 1.5px solid var(--border-glass); border-radius: 18px; padding: 26px 20px; text-align: center; transition: all 0.3s ease; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .performer-card:hover { transform: translateY(-5px); border-color: var(--neon-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25); }

        .yellow-highlight-banner {
            max-width: 1400px; margin: 40px auto;
            background: #1e1b18;
            border: 2px solid var(--neon-gold); border-radius: 20px; padding: 40px; text-align: center;
            box-shadow: 0 15px 40px rgba(255, 215, 0, 0.2);
        }
        .yellow-highlight-banner h3 { font-size: 24px; font-weight: 900; color: var(--neon-gold); text-transform: uppercase; margin-bottom: 12px; }
        .yellow-highlight-banner p { font-size: 14.5px; color: var(--text-primary); max-width: 800px; margin: 0 auto; line-height: 1.7; font-weight: 600; }

        /* CIRCULAR ROTATING GALLERY STYLING */
        .footer-gallery-section { max-width: 1400px; margin: 0 auto 40px auto; }
        .footer-gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .footer-gallery-grid { grid-template-columns: 1fr; } }

        .gallery-card-item {
            background: #0e1428;
            border-radius: 16px; overflow: hidden; border: 1.5px solid var(--border-glass);
            display: flex; flex-direction: column; align-items: center; text-align: center; padding: 25px; height: 100%;
        }
        .gallery-card-content { margin-bottom: 18px; width: 100%; }
        .gallery-card-content h4 { margin: 0 0 6px 0; font-size: 14.5px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; }
        .gallery-card-content p { margin: 0; font-size: 12px; color: var(--text-secondary); line-height: 1.4; }
        
        .gallery-item-circle {
            width: 140px; height: 140px; border-radius: 50%;
            overflow: hidden; border: 3px solid var(--neon-cyan);
            background: #020617; box-shadow: 0 0 20px rgba(0, 217, 255, 0.4);
            animation: spinContinuous 6s linear infinite;
        }
        .gallery-item-circle img { width: 100%; height: 100%; object-fit: cover; display: block; }
        
        .gallery-card-item:hover .gallery-item-circle {
            animation: spinFastHover 0.8s linear infinite;
            border-color: var(--neon-gold);
        }

        @keyframes spinContinuous {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes spinFastHover {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* 🌟 GRAND CYBER FOOTER STYLING */
        .grand-footer-section { background: #0d1222; border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; }
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
        .footer-newsletter input { flex: 1; background: #030712; border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(0,217,255,0.3); }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; transition: 0.3s; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }

        .no-match { text-align: center; color: var(--text-secondary); grid-column: 1 / -1; padding: 60px; font-size: 15px; font-weight: 700; background: var(--card-surface); border: 1px dashed var(--border-glass); border-radius: 16px; text-transform: uppercase; }
    </style>
</head>
<body>

    <!-- 🌟 NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-area">
        <div class="header-bar">
            <div class="header-left">
                <a href="/home" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</a>
            </div>
            <div>
                <h2 class="jumping-title" id="animatedTitle">MATCH COMMAND CENTER</h2>
            </div>
            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
                <a href="addMatch" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Match</a>
                <a href="/deleteAllMatches" class="btn-delete-all" onclick="return confirm('⚠️ Warning: Delete ALL matches permanently?')">🗑 Delete All</a>
            </div>
        </div>

        <div class="control-bar">
            <input type="text" id="matchSearch" class="search-input" placeholder="🔍 Search match by team..." onkeyup="filterMatches()" autocomplete="off">
            <div class="stats-badge">Total Matches: <span>${matches.size()}</span></div>
        </div>

        <!-- ============ MATCHES MAIN SECTION ============ -->
        <div class="matches-grid" id="matchesGrid">
            <c:forEach items="${matches}" var="m">
                <div class="match-card" data-name="${m.teamA != null ? m.teamA.teamName.toLowerCase() : ''} ${m.teamB != null ? m.teamB.teamName.toLowerCase() : ''}">
                    <div class="card-details-side">
                        <div>
                            <div class="match-header-row">
                                <span class="tournament-title" title="${m.tournament != null ? m.tournament.tournamentName : 'Tournament'}">🏆 ${m.tournament != null ? m.tournament.tournamentName : 'Tournament'}</span>
                                <span class="status-badge-pro ${m.status == 'COMPLETED' ? 'status-completed' : 'status-upcoming'}">
                                    ${m.status}
                                </span>
                            </div>
                            
                            <div class="teams-display" style="margin: 12px 0;" title="${m.teamA != null ? m.teamA.teamName : 'TBD'} vs ${m.teamB != null ? m.teamB.teamName : 'TBD'}">
                                ${m.teamA != null ? m.teamA.teamName : 'TBD'} <span class="vs-text">VS</span> ${m.teamB != null ? m.teamB.teamName : 'TBD'}
                            </div>
                            
                            <div class="match-meta-info">
                                📍 <strong>Venue:</strong> ${m.venue}<br>
                                📅 <strong>Date:</strong> ${m.matchDateTime}<br>
                                ⭐ <strong>Winner:</strong> <span style="color: var(--neon-emerald); font-weight: 700;">${m.winner != null ? m.winner.teamName : 'TBD'}</span>
                            </div>
                        </div>
                        
                        <div class="card-actions-row">
                            <a href="editMatch/${m.id}" class="btn-edit-pro">✏️ Edit</a>
                            <a href="deleteMatch/${m.id}" class="btn-delete-pro" onclick="return confirm('⚠️ Terminate this match permanently?');">🗑 Delete</a>
                        </div>
                    </div>

                    <div class="card-image-side">
                        <span class="arena-tag">Live Arena</span>
                        <span class="match-id-badge">#${m.id}</span>
                    </div>
                </div>
            </c:forEach>
            
            <c:if test="${empty matches}">
                <div class="no-match">🏏 No Active Matches Deployed In The System Matrix</div>
            </c:if>
        </div>

        <!-- PAGINATION -->
        <div class="pagination-bar">
            <c:choose>
                <c:when test="${currentPage > 0}">
                    <a href="/matches?page=${currentPage - 1}">⬅ Previous</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 700;">⬅ Previous</span>
                </c:otherwise>
            </c:choose>
            <span class="page-indicator">Page ${currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}</span>
            <c:choose>
                <c:when test="${currentPage + 1 < totalPages}">
                    <a href="/matches?page=${currentPage + 1}">Next ➡</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(255,255,255,0.02); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 700;">Next ➡</span>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- MEGA SHOWCASE BANNER -->
        <div class="mega-showcase-banner">
            <div class="mega-banner-left">
                <h2>⚡ ProMatch Arena Operations</h2>
                <p>Command every fixture with precision telemetry, automated real-time standings synchronization, and enterprise-grade security protocols designed for professional sports leagues.</p>
            </div>
            <div class="mega-banner-right">
                <div class="mega-stat-box">
                    <h3>${matches.size()}</h3>
                    <span>Fixtures</span>
                </div>
                <div class="mega-stat-box">
                    <h3>100%</h3>
                    <span>Secure</span>
                </div>
            </div>
        </div>

        <!-- DUAL PRO ARENA FEATURE CARDS -->
        <div class="dual-pro-cards-section">
            <div class="pro-feature-card">
                <div class="pro-feature-icon"><i class="fa-solid fa-bolt"></i></div>
                <h4>Instant Ball Tracking</h4>
                <p>Real-time ball by ball scoring and tracking across all active grounds with zero latency.</p>
            </div>
            <div class="pro-feature-card">
                <div class="pro-feature-icon"><i class="fa-solid fa-shield-halved"></i></div>
                <h4>Verified Secure Data</h4>
                <p>Enterprise-grade security and robust data storage backed by PostgreSQL infrastructure.</p>
            </div>
        </div>

        <!-- CIRCULAR BADGE STATS SECTION -->
        <div class="circular-stats-section">
            <div class="circle-badge-card">
                <div class="circle-icon-wrap"><i class="fa-solid fa-bolt"></i></div>
                <h4>Instant Updates</h4>
                <p>Real-time ball by ball scoring and tracking across all active grounds.</p>
            </div>
            <div class="circle-badge-card">
                <div class="circle-icon-wrap"><i class="fa-solid fa-shield-halved"></i></div>
                <h4>Verified Data</h4>
                <p>Enterprise-grade security and storage backed by PostgreSQL.</p>
            </div>
            <div class="circle-badge-card">
                <div class="circle-icon-wrap"><i class="fa-solid fa-trophy"></i></div>
                <h4>Championship Ready</h4>
                <p>Optimized tournament control center designed for elite sports management.</p>
            </div>
        </div>

        <!-- 🌟 NAYA BADA MASTER HERO SHOWCASE SECTION (ADDED JUST ABOVE HIGHLIGHTS) -->
        <div class="master-hero-showcase">
            <div class="master-hero-header">
                <div class="master-hero-title-area">
                    <h3>⚡ Advanced Match Telemetry & Control Suite</h3>
                    <p>Designed for absolute tournament command, real-time fixture synchronization, and high-performance sports data orchestration.</p>
                </div>
                <div class="master-hero-badge">Enterprise v2.6</div>
            </div>
            <div class="master-hero-metrics-grid">
                <div class="master-metric-item">
                    <div class="master-metric-icon"><i class="fa-solid fa-server"></i></div>
                    <div class="master-metric-info">
                        <h5>Core Database</h5>
                        <span>PostgreSQL Relational Engine</span>
                    </div>
                </div>
                <div class="master-metric-item">
                    <div class="master-metric-icon"><i class="fa-solid fa-bolt"></i></div>
                    <div class="master-metric-info">
                        <h5>Execution Speed</h5>
                        <span>Sub-millisecond latency</span>
                    </div>
                </div>
                <div class="master-metric-item">
                    <div class="master-metric-icon"><i class="fa-solid fa-shield-halved"></i></div>
                    <div class="master-metric-info">
                        <h5>Security Matrix</h5>
                        <span>End-to-end encrypted telemetry</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- PRO MATCH HIGHLIGHTS & QUICK ANALYTICS SECTION -->
        <div class="pro-highlights-section">
            <h3 class="section-title">⚡ Pro Match Highlights & Analytics</h3>
            <div class="highlights-grid">
                <div class="highlight-card">
                    <div class="highlight-icon"><i class="fa-solid fa-chart-line"></i></div>
                    <h4>Real-Time Telemetry</h4>
                    <p>Track fixture progress, venue logistics, and team match outcomes instantly through automated sync.</p>
                </div>
                <div class="highlight-card">
                    <div class="highlight-icon"><i class="fa-solid fa-shield-halved"></i></div>
                    <h4>Match Integrity</h4>
                    <p>Ensure foolproof match recordkeeping with structured database constraints and validation protocols.</p>
                </div>
                <div class="highlight-card">
                    <div class="highlight-icon"><i class="fa-solid fa-bolt"></i></div>
                    <h4>Lightning Control</h4>
                    <p>Execute edits, terminations, and rapid search filtering with zero latency across the control grid.</p>
                </div>
            </div>
        </div>

        <!-- TOP PERFORMERS SECTION -->
        <div class="cricket-section">
            <h3 class="section-title">🌟 Top Performers This Season</h3>
            <div class="cricket-grid">
                <div class="performer-card">
                    <div style="width: 80px; height: 80px; margin: 0 auto 15px; border-radius: 50%; background: linear-gradient(135deg, var(--neon-emerald) 0%, var(--neon-cyan) 100%); display: flex; align-items: center; justify-content: center; font-size: 34px;">🏏</div>
                    <div style="color: var(--text-primary); font-weight: 900; font-size: 16px; margin-bottom: 6px;">Virat Kohli</div>
                    <div style="color: var(--neon-cyan); font-size: 12px; font-weight: 700; margin-bottom: 10px; text-transform: uppercase;">Highest Run Scorer</div>
                    <div style="color: var(--text-primary); font-weight: 800; font-size: 17px; margin-bottom: 6px;">825 Runs</div>
                    <div style="color: var(--text-secondary); font-size: 11px; font-weight: 600;">Avg: 68.75 | SR: 92.40</div>
                </div>

                <div class="performer-card">
                    <div style="width: 80px; height: 80px; margin: 0 auto 15px; border-radius: 50%; background: linear-gradient(135deg, var(--neon-rose) 0%, var(--neon-cyan) 100%); display: flex; align-items: center; justify-content: center; font-size: 34px;">⚡</div>
                    <div style="color: var(--text-primary); font-weight: 900; font-size: 16px; margin-bottom: 6px;">Jasprit Bumrah</div>
                    <div style="color: var(--neon-rose); font-size: 12px; font-weight: 700; margin-bottom: 10px; text-transform: uppercase;">Best Bowler</div>
                    <div style="color: var(--text-primary); font-weight: 800; font-size: 17px; margin-bottom: 6px;">42 Wickets</div>
                    <div style="color: var(--text-secondary); font-size: 11px; font-weight: 600;">Avg: 18.52 | Econ: 6.12</div>
                </div>

                <div class="performer-card">
                    <div style="width: 80px; height: 80px; margin: 0 auto 15px; border-radius: 50%; background: linear-gradient(135deg, #3b82f6 0%, var(--neon-cyan) 100%); display: flex; align-items: center; justify-content: center; font-size: 34px;">⭐</div>
                    <div style="color: var(--text-primary); font-weight: 900; font-size: 16px; margin-bottom: 6px;">MS Dhoni</div>
                    <div style="color: #3b82f6; font-size: 12px; font-weight: 700; margin-bottom: 10px; text-transform: uppercase;">Master Finisher</div>
                    <div style="color: var(--text-primary); font-weight: 800; font-size: 17px; margin-bottom: 6px;">350 Not Outs</div>
                    <div style="color: var(--text-secondary); font-size: 11px; font-weight: 600;">Stumpings: 120 | SR: 135</div>
                </div>
            </div>
        </div>

        <!-- BANNER -->
        <div class="yellow-highlight-banner">
            <h3>⚡ Experience Ultimate Sports Analytics & Live Control</h3>
            <p>Elevate your tournament management with real-time tracking, seamless roster controls, and dynamic performance telemetry designed for champions.</p>
        </div>

        <!-- 🌟 GALLERY SECTION (CIRCULAR ROTATING & FAST HOVER) -->
        <div class="footer-gallery-section">
            <div class="footer-gallery-grid">
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>⚡ Intensive Action</h4>
                        <p>High-voltage cricket matches filled with thrilling moments</p>
                    </div>
                    <div class="gallery-item-circle">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTclrbY8ONOn4WqyHMsQ2bVoRdEPhBmR1zYHsWWXIkEoA&s=10" alt="Match Action">
                    </div>
                </div>
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏆 Trophy Lift</h4>
                        <p>The ultimate reward for dedication, teamwork, and victory</p>
                    </div>
                    <div class="gallery-item-circle">
                        <img src="https://images.unsplash.com/photo-1579952363873-27f3bade9f55?auto=format&fit=crop&w=500&q=80" alt="Victory Lift">
                    </div>
                </div>
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏏 Pro Equipment</h4>
                        <p>Precision-crafted gear designed for professional performance</p>
                    </div>
                    <div class="gallery-item-circle">
                        <img src="https://image.shutterstock.com/image-photo/cricket-ball-bails-on-green-260nw-2466366787.jpg" alt="Cricket Gear">
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

        function filterMatches() {
            let input = document.getElementById('matchSearch').value.toLowerCase().trim();
            let cards = document.getElementsByClassName('match-card');
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
    </script>
</body>
</html>