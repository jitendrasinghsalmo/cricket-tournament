<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="points" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Tournament Points Table</title>
    <!-- Bootstrap 5 CSS & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #0a0e27;
            --card-surface: rgba(13, 18, 35, 0.82);
            --neon-cyan: #00d9ff;
            --neon-emerald: #00ff88;
            --neon-rose: #ff006e;
            --neon-amber: #ffa500;
            --neon-purple: #b537f2;
            --neon-gold: #ffd700;
            --text-primary: #f0f4ff;
            --text-secondary: #c2d1f0;
            --border-glass: rgba(0, 217, 255, 0.3);
            --body-overlay: rgba(10, 14, 39, 0.94);
        }

        * { box-sizing: border-box; }

        body { 
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; 
            background-color: var(--bg-deep);
            color: var(--text-primary); 
            margin: 0; 
            padding: 0; 
        }

        .main-content-wrap { max-width: 1400px; margin: 30px auto; padding: 0 20px; }

        .header-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            max-width: 1400px; margin: 0 auto 25px auto; 
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            padding: 16px 28px; border-radius: 16px; border: 1.5px solid var(--border-glass);
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }
        
        .header-left { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
        .header-right { display: flex; align-items: center; gap: 10px; }

        .btn-back { 
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(0, 255, 136, 0.15));
            color: var(--neon-cyan); border: 1.5px solid var(--neon-cyan); 
            padding: 9px 16px; border-radius: 10px; text-decoration: none; 
            font-weight: 700; font-size: 12px; transition: all 0.3s ease; 
            display: inline-flex; align-items: center; gap: 6px; cursor: pointer;
        }
        .btn-back:hover { background: var(--neon-cyan); color: #0a0e27; transform: translateX(-3px); box-shadow: 0 0 20px rgba(0, 217, 255, 0.5); }

        .pro-status-badge {
            background: linear-gradient(135deg, rgba(0, 255, 136, 0.15), rgba(0, 217, 255, 0.15));
            color: var(--neon-emerald); border: 1.5px solid var(--neon-emerald);
            padding: 9px 18px; border-radius: 10px; font-size: 12px; font-weight: 800;
            display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 0 15px rgba(0, 255, 136, 0.3);
            text-transform: uppercase; letter-spacing: 0.5px;
        }

        .animated-heading {
            text-align: center;
            margin: 0;
            font-weight: 900;
            font-size: 22px;
            letter-spacing: 2px;
            text-transform: uppercase;
            display: inline-block;
            white-space: nowrap;
        }

        .animated-heading span {
            display: inline-block;
            opacity: 0;
            filter: blur(10px);
            transform: translateY(-25px) scale(0.8);
            animation: bounceInGlow 0.8s cubic-bezier(0.215, 0.61, 0.355, 1) forwards;
            animation-delay: calc(0.05s * var(--i));
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 0 25px rgba(0, 217, 255, 0.4);
        }

        @keyframes bounceInGlow {
            0% { opacity: 0; filter: blur(10px); transform: translateY(-25px) scale(0.8); }
            60% { opacity: 1; filter: blur(0px); transform: translateY(6px) scale(1.05); }
            80% { transform: translateY(-3px) scale(0.98); }
            100% { opacity: 1; filter: blur(0px); transform: translateY(0) scale(1); }
        }

        .control-bar {
            max-width: 1400px; margin: 0 auto 25px auto;
            display: flex; justify-content: space-between; align-items: center;
            background: var(--card-surface); backdrop-filter: blur(15px);
            padding: 12px 20px; border-radius: 14px; border: 1.5px solid var(--border-glass);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            gap: 15px; flex-wrap: wrap;
        }
        .search-input {
            background: rgba(3, 7, 18, 0.75); border: 1.5px solid var(--border-glass);
            border-radius: 10px; padding: 9px 15px; color: var(--text-primary); font-size: 13px;
            width: 300px; outline: none; transition: 0.3s;
        }
        .search-input::placeholder { color: var(--text-secondary); opacity: 0.8; }
        .search-input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 15px rgba(0, 217, 255, 0.4); }

        .stats-badge { 
            font-size: 12px; font-weight: 700; color: var(--text-primary); 
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(255, 215, 0, 0.15));
            padding: 7px 14px; border-radius: 10px; border: 1.5px solid var(--border-glass); white-space: nowrap;
        }
        .stats-badge span { color: var(--neon-gold); font-weight: 900; }

        .table-container {
            max-width: 1400px; margin: 0 auto 15px auto;
            background: var(--card-surface); backdrop-filter: blur(20px);
            border: 1.5px solid var(--border-glass); border-radius: 16px;
            padding: 24px; box-shadow: 0 20px 40px rgba(0,0,0,0.3);
            position: relative; overflow-x: auto;
        }
        .table-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold), var(--neon-purple));
            border-radius: 16px 16px 0 0;
        }
        table { width: 100%; border-collapse: collapse; text-align: center; }
        th {
            background: rgba(0, 217, 255, 0.12); color: var(--neon-cyan); font-weight: 900;
            font-size: 12px; text-transform: uppercase; letter-spacing: 0.6px;
            padding: 14px 10px; border-bottom: 2px solid var(--border-glass);
        }
        td {
            padding: 13px 10px; font-size: 14px; color: var(--text-primary);
            border-bottom: 1px solid var(--border-glass); font-weight: 600;
        }
        tbody tr { transition: all 0.2s ease; }
        tbody tr:hover { background: rgba(0, 217, 255, 0.1); }

        .pos-badge { font-weight: 900; padding: 6px 12px; border-radius: 8px; font-size: 11px; display: inline-block; }
        .pos-1 { background: linear-gradient(135deg, var(--neon-gold), var(--neon-amber)); color: #000; box-shadow: 0 0 15px rgba(255,215,0,0.4); }
        .pos-2 { background: linear-gradient(135deg, var(--neon-cyan), rgba(0, 217, 255, 0.6)); color: #000; box-shadow: 0 0 12px rgba(0,217,255,0.3); }
        .pos-3 { background: linear-gradient(135deg, var(--neon-emerald), rgba(0, 255, 136, 0.6)); color: #000; box-shadow: 0 0 12px rgba(0,255,136,0.3); }
        .pos-other { background: linear-gradient(135deg, var(--neon-purple), rgba(181, 55, 242, 0.6)); color: #fff; }

        .points-highlight { font-weight: 900; color: var(--neon-emerald); font-size: 15px; }
        .team-name { font-weight: 800; color: var(--neon-cyan); }
        .tournament-name { color: var(--text-secondary); font-size: 12px; font-weight: 700; }

        .pagination-bar-wrapper {
            max-width: 1400px;
            margin: 0 auto 30px auto;
            display: flex;
            justify-content: flex-end;
        }
        .pagination-bar {
            display: flex; align-items: center; gap: 20px;
            padding: 10px 15px; border-radius: 12px;
            box-sizing: border-box; flex-wrap: wrap;
        }
        .pagination-bar a {
            padding: 10px 20px; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #0a0e27; border-radius: 10px; text-decoration: none; font-weight: 900; font-size: 12px;
            transition: all 0.3s; text-transform: uppercase; letter-spacing: 0.5px;
        }
        .pagination-bar a:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0, 217, 255, 0.5); }
        .page-indicator { font-size: 13px; font-weight: 800; color: var(--text-primary); }

        .top-stats-section {
            max-width: 1400px; margin: 0 auto 25px auto;
            display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 15px;
        }
        .stat-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 12px; padding: 18px;
            backdrop-filter: blur(15px); transition: all 0.3s ease; position: relative; overflow: hidden;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .stat-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 3px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
        }
        .stat-card:hover { transform: translateY(-4px); border-color: var(--neon-cyan); box-shadow: 0 12px 35px rgba(0, 217, 255, 0.25); }
        .stat-icon { font-size: 22px; margin-bottom: 6px; }
        .stat-label { font-size: 11px; color: var(--text-secondary); text-transform: uppercase; font-weight: 700; letter-spacing: 0.5px; margin-bottom: 6px; }
        .stat-value { font-size: 21px; font-weight: 900; color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,217,255,0.3); }

        .highlights-section {
            max-width: 1400px; margin: 0 auto 25px auto;
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 14px; padding: 22px;
            backdrop-filter: blur(15px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .section-title {
            font-size: 15px; font-weight: 900; color: var(--text-primary); 
            margin: 0 0 16px 0; display: flex; align-items: center; gap: 8px; 
            text-transform: uppercase; letter-spacing: 0.8px;
        }
        .section-title::before {
            content: ''; width: 3px; height: 18px; 
            background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald)); border-radius: 2px;
        }
        .highlights-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(160px, 1fr)); gap: 12px; }
        .highlight-item {
            background: rgba(13, 18, 35, 0.45); border: 1.5px solid var(--border-glass);
            border-radius: 10px; padding: 14px; text-align: center; transition: all 0.3s ease;
        }
        .highlight-item:hover { transform: translateY(-3px); border-color: var(--neon-cyan); background: rgba(0, 217, 255, 0.1); }
        .highlight-label { font-size: 11px; color: var(--text-secondary); text-transform: uppercase; font-weight: 800; margin-bottom: 5px; }
        .highlight-value { font-size: 16px; font-weight: 900; color: var(--neon-gold); text-shadow: 0 0 10px rgba(255,215,0,0.3); }

        .attractive-hero-banner {
            max-width: 1400px;
            margin: 0 auto 30px auto;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.12), rgba(181, 55, 242, 0.12)), var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 20px;
            padding: 35px 30px;
            text-align: center;
            backdrop-filter: blur(20px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
            position: relative;
            overflow: hidden;
        }
        .hero-banner-title {
            font-size: 26px;
            font-weight: 900;
            margin: 0 0 10px 0;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 1.5px;
        }
        .hero-banner-desc {
            font-size: 14px;
            color: var(--text-secondary);
            max-width: 750px;
            margin: 0 auto 25px auto;
            line-height: 1.6;
            font-weight: 600;
        }
        .hero-banner-pills {
            display: flex;
            justify-content: center;
            gap: 15px;
            flex-wrap: wrap;
        }
        .hero-pill {
            background: rgba(13, 18, 35, 0.6);
            border: 1.5px solid var(--border-glass);
            padding: 8px 18px;
            border-radius: 30px;
            font-size: 12px;
            font-weight: 800;
            color: var(--neon-cyan);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
            transition: all 0.3s ease;
        }
        .hero-pill:hover {
            transform: translateY(-3px);
            border-color: var(--neon-emerald);
            color: var(--neon-emerald);
            box-shadow: 0 6px 20px rgba(0, 255, 136, 0.3);
        }

        /* 4 NEW ADDED SECTIONS */

        /* 1. CIRCULAR FEATURE SECTION */
        .circular-features-section {
            max-width: 1400px;
            margin: 0 auto 30px auto;
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        @media(max-width: 768px) {
            .circular-features-section { grid-template-columns: 1fr; }
        }
        .feat-circle-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 20px;
            padding: 25px 20px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
        }
        .feat-circle-card:hover {
            transform: translateY(-5px);
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25);
        }
        .feat-icon-wrap {
            width: 70px; height: 70px;
            margin: 0 auto 14px auto;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(181, 55, 242, 0.15));
            border: 2px solid var(--neon-cyan);
            display: flex; align-items: center; justify-content: center;
            font-size: 24px; color: var(--neon-cyan);
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.3);
        }
        .feat-circle-card h4 {
            margin: 0 0 6px 0; font-size: 15px; font-weight: 800;
            color: var(--text-primary); text-transform: uppercase;
        }
        .feat-circle-card p {
            margin: 0; font-size: 12px; color: var(--text-secondary); line-height: 1.5; font-weight: 600;
        }

        /* 2. PRO TOURNAMENT PULSE POD */
        .pro-tournament-pod {
            max-width: 1400px;
            margin: 0 auto 30px auto;
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.1), rgba(0, 217, 255, 0.1)), var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 20px;
            padding: 30px;
            backdrop-filter: blur(20px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
        }
        .pod-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
        }
        @media(max-width: 1024px) {
            .pod-grid { grid-template-columns: repeat(2, 1fr); }
        }
        @media(max-width: 600px) {
            .pod-grid { grid-template-columns: 1fr; }
        }
        .pod-box {
            background: rgba(13, 18, 35, 0.6);
            border: 1.5px solid var(--border-glass);
            border-radius: 14px;
            padding: 20px;
            text-align: center;
            transition: all 0.3s ease;
        }
        .pod-box:hover {
            transform: translateY(-4px);
            border-color: var(--neon-gold);
            box-shadow: 0 10px 25px rgba(255, 215, 0, 0.2);
        }
        .pod-box-icon {
            font-size: 28px;
            margin-bottom: 10px;
            color: var(--neon-gold);
        }
        .pod-box h5 {
            margin: 0 0 6px 0;
            font-size: 14px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .pod-box p {
            margin: 0;
            font-size: 12px;
            color: var(--text-secondary);
            font-weight: 600;
            line-height: 1.4;
        }

        /* 3. MEGA FEATURE SECTION */
        .mega-feature-showcase {
            max-width: 1400px;
            margin: 0 auto 30px auto;
            background: linear-gradient(135deg, rgba(0, 255, 136, 0.1), rgba(0, 217, 255, 0.15)), var(--card-surface);
            border: 2px solid var(--neon-cyan);
            border-radius: 24px;
            padding: 45px 40px;
            backdrop-filter: blur(25px);
            box-shadow: 0 20px 50px rgba(0, 217, 255, 0.2);
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 30px;
            align-items: center;
        }
        @media(max-width: 900px) {
            .mega-feature-showcase { grid-template-columns: 1fr; padding: 30px 20px; text-align: center; }
        }
        .mega-feature-content h2 {
            font-size: 30px;
            font-weight: 900;
            margin: 0 0 15px 0;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .mega-feature-content p {
            font-size: 15px;
            color: var(--text-secondary);
            line-height: 1.7;
            margin: 0 0 25px 0;
            font-weight: 600;
        }
        .mega-stats-row {
            display: flex;
            gap: 25px;
        }
        @media(max-width: 900px) {
            .mega-stats-row { justify-content: center; }
        }
        .mega-stat-box h4 {
            font-size: 24px;
            font-weight: 900;
            color: var(--neon-gold);
            margin: 0 0 5px 0;
            text-shadow: 0 0 10px rgba(255,215,0,0.4);
        }
        .mega-stat-box span {
            font-size: 12px;
            font-weight: 800;
            color: var(--text-secondary);
            text-transform: uppercase;
        }
        .mega-feature-visual {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .mega-pulse-badge {
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.2), rgba(0, 255, 136, 0.3));
            border: 3px dashed var(--neon-cyan);
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            text-align: center;
            animation: pulseGlow 3s infinite ease-in-out;
            box-shadow: 0 0 30px rgba(0, 217, 255, 0.3);
        }
        @keyframes pulseGlow {
            0% { transform: scale(1); box-shadow: 0 0 20px rgba(0, 217, 255, 0.3); }
            50% { transform: scale(1.06); box-shadow: 0 0 40px rgba(0, 255, 136, 0.5); }
            100% { transform: scale(1); box-shadow: 0 0 20px rgba(0, 217, 255, 0.3); }
        }
        .mega-pulse-badge i {
            font-size: 42px;
            color: var(--neon-cyan);
            margin-bottom: 8px;
            text-shadow: 0 0 15px rgba(0,217,255,0.6);
        }
        .mega-pulse-badge span {
            font-size: 13px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        /* 4. ELITE SHOWCASE BOX */
        .elite-showcase-box {
            max-width: 1400px;
            margin: 0 auto 35px auto;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.12), rgba(181, 55, 242, 0.12)), var(--card-surface);
            border: 2px solid var(--neon-cyan);
            border-radius: 24px;
            padding: 40px;
            backdrop-filter: blur(20px);
            box-shadow: 0 20px 50px rgba(0, 217, 255, 0.25);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 30px;
            position: relative;
            overflow: hidden;
        }
        .elite-content h2 {
            font-size: 28px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin: 0 0 10px 0;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        .elite-content p {
            font-size: 14.5px;
            color: var(--text-secondary);
            margin: 0 0 20px 0;
            line-height: 1.6;
            font-weight: 600;
            max-width: 800px;
        }
        .elite-badges {
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
        }
        .elite-badge-item {
            background: rgba(10, 14, 39, 0.7);
            border: 1.5px solid var(--border-glass);
            padding: 10px 18px;
            border-radius: 12px;
            font-size: 12.5px;
            font-weight: 800;
            color: var(--neon-gold);
            display: flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
        }
        .elite-badge-item:hover {
            transform: translateY(-3px);
            border-color: var(--neon-gold);
            box-shadow: 0 8px 25px rgba(255,215,0,0.3);
        }
        .elite-action-btn {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #030712;
            border: none;
            padding: 14px 28px;
            border-radius: 14px;
            font-weight: 900;
            font-size: 13.5px;
            text-transform: uppercase;
            letter-spacing: 1px;
            cursor: pointer;
            box-shadow: 0 0 25px rgba(0, 217, 255, 0.5);
            transition: all 0.3s ease;
            white-space: nowrap;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        .elite-action-btn:hover {
            transform: scale(1.05);
            box-shadow: 0 0 35px rgba(0, 255, 136, 0.7);
            color: #030712;
        }
        @media(max-width: 950px) {
            .elite-showcase-box { flex-direction: column; text-align: center; padding: 30px 20px; }
            .elite-badges { justify-content: center; }
        }

        /* LIVE BROADCAST SECTION */
        .broadcast-section {
            max-width: 1400px; margin: 0 auto 30px auto;
            background: var(--card-surface); backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }
        .broadcast-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; }
        @media(max-width: 900px) { .broadcast-grid { grid-template-columns: 1fr; } }
        
        .broadcast-card {
            background: rgba(13, 18, 35, 0.6); 
            border: 2px solid transparent;
            border-radius: 14px; padding: 20px; transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative; overflow: hidden;
        }
        .broadcast-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--neon-cyan);
            box-shadow: 0 0 25px rgba(0, 217, 255, 0.4);
        }
        .card-tag { font-size: 10px; font-weight: 900; color: var(--neon-rose); margin-bottom: 8px; text-transform: uppercase; }
        .broadcast-card h4 { font-size: 14px; font-weight: 900; color: var(--text-primary); margin-bottom: 8px; text-transform: uppercase; }
        .broadcast-card p { font-size: 12px; color: var(--text-secondary); line-height: 1.5; margin: 0; }

        /* GALLERY SECTION WITH 360° ROTATION */
        .gallery-section {
            max-width: 1400px; margin: 0 auto 40px auto;
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 24px;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 40px rgba(0,0,0,0.25);
            perspective: 1200px;
        }
        .gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .gallery-grid { grid-template-columns: 1fr; } }

        .gallery-card {
            background: rgba(13, 18, 35, 0.85); border: 1.5px solid var(--border-glass);
            border-radius: 16px; overflow: hidden; box-shadow: 0 10px 30px rgba(0,0,0,0.35);
            display: flex; flex-direction: column; height: auto;
            transform-style: preserve-3d;
            transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1), border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .gallery-card:hover {
            transform: rotateY(360deg) translateY(-8px);
            border-color: var(--neon-cyan);
            box-shadow: 0 20px 45px rgba(0, 217, 255, 0.4);
        }

        .card-header {
            padding: 16px; text-align: center;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.12), rgba(181, 55, 242, 0.12));
            border-bottom: 1.5px solid var(--border-glass);
        }
        .card-header h4 {
            margin: 0; font-size: 15px; font-weight: 900; color: var(--neon-gold);
            text-transform: uppercase; letter-spacing: 0.5px;
        }
        .card-header p { margin: 6px 0 0 0; font-size: 12px; color: var(--text-secondary); line-height: 1.4; font-weight: 600; }
        
        .card-image { 
            width: 100%; 
            height: 300px; 
            background: #020617;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            padding: 0;
            margin: 0;
            position: relative;
        }
        .card-image img { 
            width: 100%; 
            height: 100%; 
            display: block; 
            object-fit: fill; 
            transition: transform 0.5s ease;
        }
        .gallery-card:hover .card-image img {
            transform: scale(1.03);
        }

        /* ===== NEW SECTION A: TOP 3 PODIUM ===== */
        .podium-section {
            max-width: 1400px; margin: 0 auto 30px auto;
            background: var(--card-surface); backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }
        .podium-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; align-items: end; }
        @media(max-width: 768px) { .podium-grid { grid-template-columns: 1fr; } }
        .podium-card {
            background: rgba(13, 18, 35, 0.6); border: 1.5px solid var(--border-glass);
            border-radius: 16px; padding: 22px 18px; text-align: center; position: relative;
            transition: all 0.3s ease; overflow: hidden;
        }
        .podium-card:hover { transform: translateY(-6px); box-shadow: 0 15px 35px rgba(0,0,0,0.35); }
        .podium-card.gold { border-color: var(--neon-gold); box-shadow: 0 0 25px rgba(255,215,0,0.2); order: 2; transform: scale(1.05); }
        .podium-card.silver { border-color: var(--neon-cyan); order: 1; }
        .podium-card.bronze { border-color: var(--neon-emerald); order: 3; }
        @media(max-width: 768px) { .podium-card.gold, .podium-card.silver, .podium-card.bronze { order: 0; transform: none; } }
        .podium-rank-icon { font-size: 30px; margin-bottom: 8px; }
        .podium-card.gold .podium-rank-icon { color: var(--neon-gold); text-shadow: 0 0 15px rgba(255,215,0,0.5); }
        .podium-card.silver .podium-rank-icon { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(0,217,255,0.5); }
        .podium-card.bronze .podium-rank-icon { color: var(--neon-emerald); text-shadow: 0 0 15px rgba(0,255,136,0.5); }
        .podium-team { font-size: 16px; font-weight: 900; color: var(--text-primary); margin: 6px 0 4px 0; text-transform: uppercase; }
        .podium-tour { font-size: 11px; color: var(--text-secondary); font-weight: 700; margin-bottom: 12px; }
        .podium-pts { font-size: 22px; font-weight: 900; color: var(--neon-gold); text-shadow: 0 0 10px rgba(255,215,0,0.3); }
        .podium-pts-label { font-size: 10px; color: var(--text-secondary); text-transform: uppercase; font-weight: 800; letter-spacing: 0.5px; }

        /* ===== NEW SECTION B: MATCH FORMAT QUICK INFO ===== */
        .format-info-section {
            max-width: 1400px; margin: 0 auto 30px auto;
            display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px;
        }
        @media(max-width: 900px) { .format-info-section { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 500px) { .format-info-section { grid-template-columns: 1fr; } }
        .format-info-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 14px;
            padding: 18px; display: flex; align-items: center; gap: 14px;
            backdrop-filter: blur(15px); transition: all 0.3s ease; box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }
        .format-info-card:hover { border-color: var(--neon-cyan); transform: translateY(-3px); }
        .format-info-icon {
            width: 44px; height: 44px; flex-shrink: 0; border-radius: 12px;
            background: linear-gradient(135deg, rgba(0,217,255,0.18), rgba(181,55,242,0.18));
            border: 1.5px solid var(--neon-cyan); display: flex; align-items: center; justify-content: center;
            font-size: 18px; color: var(--neon-cyan);
        }
        .format-info-card h5 { margin: 0 0 3px 0; font-size: 13px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; }
        .format-info-card p { margin: 0; font-size: 11.5px; color: var(--text-secondary); font-weight: 600; }

        /* ===== NEW SECTION C: RECENT FORM GUIDE ===== */
        .form-guide-section {
            max-width: 1400px; margin: 0 auto 30px auto;
            background: var(--card-surface); backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 24px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.25);
        }
        .form-row { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 12px 6px; border-bottom: 1px solid var(--border-glass); flex-wrap: wrap; }
        .form-row:last-child { border-bottom: none; }
        .form-row .form-team { font-size: 13.5px; font-weight: 800; color: var(--neon-cyan); min-width: 160px; }
        .form-badges { display: flex; gap: 6px; }
        .form-pill { width: 26px; height: 26px; border-radius: 7px; display: flex; align-items: center; justify-content: center; font-size: 11px; font-weight: 900; color: #000; }
        .form-pill.w { background: var(--neon-emerald); box-shadow: 0 0 10px rgba(0,255,136,0.4); }
        .form-pill.l { background: var(--neon-rose); color: #fff; box-shadow: 0 0 10px rgba(255,0,110,0.4); }
        .form-pill.t { background: var(--neon-amber); box-shadow: 0 0 10px rgba(255,165,0,0.4); }

        /* ===== NEW SECTION D: CTA BANNER ===== */
        .points-cta-banner {
            max-width: 1400px; margin: 0 auto 30px auto;
            background: linear-gradient(135deg, rgba(0,217,255,0.16), rgba(0,255,136,0.1)), var(--card-surface);
            border: 2px solid var(--neon-cyan); border-radius: 22px; padding: 40px;
            display: flex; align-items: center; justify-content: space-between; gap: 25px; flex-wrap: wrap;
            box-shadow: 0 20px 45px rgba(0,217,255,0.2); backdrop-filter: blur(20px);
        }
        .points-cta-text h3 { margin: 0 0 8px 0; font-size: 22px; font-weight: 900; color: var(--text-primary); text-transform: uppercase; letter-spacing: 1px; }
        .points-cta-text p { margin: 0; font-size: 13.5px; color: var(--text-secondary); font-weight: 600; max-width: 560px; line-height: 1.6; }
        .points-cta-btn {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712;
            border: none; padding: 14px 28px; border-radius: 14px; font-weight: 900; font-size: 13px;
            text-transform: uppercase; letter-spacing: 1px; text-decoration: none; white-space: nowrap;
            display: inline-flex; align-items: center; gap: 8px; box-shadow: 0 0 25px rgba(0,217,255,0.5); transition: all 0.3s ease;
        }
        .points-cta-btn:hover { transform: scale(1.05); box-shadow: 0 0 35px rgba(0,255,136,0.7); color: #030712; }
        @media(max-width: 700px) { .points-cta-banner { flex-direction: column; text-align: center; padding: 30px 22px; } }

        /* GRAND FOOTER */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
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

        .no-record { text-align: center; color: var(--text-secondary); padding: 40px; font-size: 14px; font-weight: 700; }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">
        <div class="header-bar">
            <div class="header-left">
                <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            </div>
            
            <div>
                <h2 class="animated-heading" id="animatedTitle">TOURNAMENT POINTS TABLE</h2>
            </div>

            <div class="header-right">
                <div class="pro-status-badge">
                    <i class="fa-solid fa-tower-broadcast"></i> PRO LIVE
                </div>
            </div>
        </div>

        <div class="control-bar">
            <input type="text" id="tableSearch" class="search-input" placeholder="🔍 Search team or tournament..." onkeyup="filterTable()" autocomplete="off">
            <div class="stats-badge">Total Records: <span>${pointsList.size()}</span></div>
        </div>

        <div class="table-container">
            <table id="pointsTableElement">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Pos</th>
                        <th>Team</th>
                        <th>Tournament</th>
                        <th>Played</th>
                        <th>Won</th>
                        <th>Lost</th>
                        <th>Tie</th>
                        <th>Points</th>
                        <th>NRR</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${pointsList}" var="pt" varStatus="loop">
                        <c:set var="actualPos" value="${pt.position != null ? pt.position : (loop.index + 1)}" />
                        <tr data-search="${pt.team != null ? pt.team.teamName.toLowerCase() : ''} ${pt.tournament != null ? pt.tournament.tournamentName.toLowerCase() : ''}">
                            <td>#${pt.id}</td>
                            <td>
                                <span class="pos-badge ${actualPos == 1 ? 'pos-1' : (actualPos == 2 ? 'pos-2' : (actualPos == 3 ? 'pos-3' : 'pos-other'))}">
                                    ${actualPos}
                                </span>
                            </td>
                            <td class="team-name">${pt.team != null ? pt.team.teamName : 'N/A'}</td>
                            <td class="tournament-name">${pt.tournament != null ? pt.tournament.tournamentName : 'N/A'}</td>
                            <td>${pt.matchesPlayed}</td>
                            <td style="color: var(--neon-emerald); font-weight: 800;">${pt.won}</td>
                            <td style="color: var(--neon-rose); font-weight: 800;">${pt.lost}</td>
                            <td>${pt.tie}</td>
                            <td><span class="points-highlight">${pt.points}</span></td>
                            <td style="font-family: monospace; font-weight: 800; color: var(--neon-cyan);">${pt.netRunRate}</td>
                        </tr>
                    </c:forEach>
                    
                    <c:if test="${empty pointsList}">
                        <tr>
                            <td colspan="10" class="no-record">🏏 No records found in the points table</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <div class="pagination-bar-wrapper">
            <div class="pagination-bar">
                <c:choose>
                    <c:when test="${currentPage > 0}">
                        <a href="/pointsTable?page=${currentPage - 1}">⬅ Previous</a>
                    </c:when>
                    <c:otherwise>
                        <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(100,100,100,0.1); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 800;">⬅ Previous</span>
                    </c:otherwise>
                </c:choose>

                <span class="page-indicator">Page ${currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}</span>

                <c:choose>
                    <c:when test="${currentPage + 1 < totalPages}">
                        <a href="/pointsTable?page=${currentPage + 1}">Next ➡</a>
                    </c:when>
                    <c:otherwise>
                        <span style="opacity: 0.3; cursor: not-allowed; padding: 10px 20px; background: rgba(100,100,100,0.1); color: #64748b; border-radius: 10px; font-size: 12px; font-weight: 800;">Next ➡</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>

        <div class="top-stats-section">
            <div class="stat-card">
                <div class="stat-icon">👥</div>
                <div class="stat-label">Total Teams</div>
                <div class="stat-value">${pointsList.size()}</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">⚡</div>
                <div class="stat-label">Status</div>
                <div class="stat-value" style="color: var(--neon-emerald);">LIVE</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">⭐</div>
                <div class="stat-label">Leaderboard</div>
                <div class="stat-value" style="color: var(--neon-gold);">ACTIVE</div>
            </div>

            <div class="stat-card">
                <div class="stat-icon">🖥️</div>
                <div class="stat-label">System</div>
                <div class="stat-value" style="color: var(--neon-emerald);">ONLINE</div>
            </div>
        </div>

        <div class="highlights-section">
            <h3 class="section-title">⭐ Quick Insights</h3>
            <div class="highlights-grid">
                <div class="highlight-item">
                    <div class="highlight-label">Most Wins</div>
                    <div class="highlight-value">Thunder Strikers</div>
                </div>
                <div class="highlight-item">
                    <div class="highlight-label">Best Points</div>
                    <div class="highlight-value">Phoenix Warriors</div>
                </div>
                <div class="highlight-item">
                    <div class="highlight-label">Top NRR</div>
                    <div class="highlight-value">+8.45</div>
                </div>
                <div class="highlight-item">
                    <div class="highlight-label">Total Matches</div>
                    <div class="highlight-value">45 Cups</div>
                </div>
                <div class="highlight-item">
                    <div class="highlight-label">Tournaments</div>
                    <div class="highlight-value">12 Seasons</div>
                </div>
                <div class="highlight-item">
                    <div class="highlight-label">Win Rate</div>
                    <div class="highlight-value">68.5%</div>
                </div>
            </div>
        </div>

        <div class="attractive-hero-banner">
            <h3 class="hero-banner-title">🌟 Ultimate Tournament Ecosystem</h3>
            <p class="hero-banner-desc">Experience real-time tournament tracking powered by elite sports intelligence. Monitor standings, net run rates, and championship progression seamlessly.</p>
            <div class="hero-banner-pills">
                <div class="hero-pill"><i class="fa-solid fa-bolt"></i> Live Analytics</div>
                <div class="hero-pill"><i class="fa-solid fa-shield-halved"></i> Secure PostgreSQL Backend</div>
                <div class="hero-pill"><i class="fa-solid fa-trophy"></i> Championship Ready</div>
            </div>
        </div>

        <!-- NEW SECTION 1: CIRCULAR FEATURE SECTION -->
        <div class="circular-features-section">
            <div class="feat-circle-card">
                <div class="feat-icon-wrap">
                    <i class="fa-solid fa-chart-line"></i>
                </div>
                <h4>Advanced Metrics</h4>
                <p>Detailed net run rate tracking and head-to-head performance graphs.</p>
            </div>
            <div class="feat-circle-card">
                <div class="feat-icon-wrap">
                    <i class="fa-solid fa-bolt"></i>
                </div>
                <h4>Instant Sync</h4>
                <p>Live database synchronization across all tournament control nodes.</p>
            </div>
            <div class="feat-circle-card">
                <div class="feat-icon-wrap">
                    <i class="fa-solid fa-medal"></i>
                </div>
                <h4>Elite Standings</h4>
                <p>Automated qualification tracking for championship playoffs.</p>
            </div>
        </div>

        <!-- NEW SECTION 2: PRO TOURNAMENT PULSE POD -->
        <div class="pro-tournament-pod">
            <h3 class="section-title" style="margin-bottom: 20px;">🔥 Pro Tournament Pulse & Highlights</h3>
            <div class="pod-grid">
                <div class="pod-box">
                    <div class="pod-box-icon"><i class="fa-solid fa-fire-flame-curved"></i></div>
                    <h5>Peak Intensity</h5>
                    <p>High-voltage encounters pushing teams to their ultimate limits.</p>
                </div>
                <div class="pod-box">
                    <div class="pod-box-icon"><i class="fa-solid fa-bullseye"></i></div>
                    <h5>Precision Data</h5>
                    <p>Zero-latency calculation engine tracking every run and wicket.</p>
                </div>
                <div class="pod-box">
                    <div class="pod-box-icon"><i class="fa-solid fa-crown"></i></div>
                    <h5>Glory Awaits</h5>
                    <p>The ultimate trophy race for the season's undisputed champions.</p>
                </div>
                <div class="pod-box">
                    <div class="pod-box-icon"><i class="fa-solid fa-shield-cat"></i></div>
                    <h5>Elite Defense</h5>
                    <p>Unbreakable team strategies and tactical masterclasses on field.</p>
                </div>
            </div>
        </div>

        <!-- NEW SECTION 3: MEGA FEATURE SECTION -->
        <div class="mega-feature-showcase">
            <div class="mega-feature-content">
                <h2>🚀 High-Performance Cyber Architecture</h2>
                <p>Engineered with state-of-the-art backend controllers and glassmorphic user interfaces to deliver lightning-fast data updates, secure session handling, and immersive visual stats across all devices.</p>
                <div class="mega-stats-row">
                    <div class="mega-stat-box">
                        <h4>99.9%</h4>
                        <span>System Uptime</span>
                    </div>
                    <div class="mega-stat-box">
                        <h4>0 ms</h4>
                        <span>Query Latency</span>
                    </div>
                    <div class="mega-stat-box">
                        <h4>100%</h4>
                        <span>Secure Sync</span>
                    </div>
                </div>
            </div>
            <div class="mega-feature-visual">
                <div class="mega-pulse-badge">
                    <i class="fa-solid fa-shield-halved"></i>
                    <span>Cyber Core</span>
                </div>
            </div>
        </div>

        <!-- NEW SECTION 4: ELITE SHOWCASE BOX -->
        <div class="elite-showcase-box">
            <div class="elite-content">
                <h2>⚡ ProMatch Championship Arena</h2>
                <p>Immerse yourself in professional league action with state-of-the-art arena visuals, real-time telemetry, and elite competitive match broadcasts.</p>
                <div class="elite-badges">
                    <div class="elite-badge-item"><i class="fa-solid fa-fire"></i> High Octane</div>
                    <div class="elite-badge-item"><i class="fa-solid fa-shield-halved"></i> Verified Stats</div>
                    <div class="elite-badge-item"><i class="fa-solid fa-trophy"></i> Pro League</div>
                </div>
            </div>
            <div>
                <a href="#pointsTableElement" class="elite-action-btn"><i class="fa-solid fa-bolt"></i> Explore Live</a>
            </div>
        </div>

        <!-- LIVE BROADCAST SECTION WITH NEW HOVER ANIMATION -->
        <div class="broadcast-section">
            <h3 class="section-title" style="margin-bottom: 20px;"><i class="fa-solid fa-tower-broadcast"></i> LIVE BROADCAST & MATCH STREAMS</h3>
            <div class="broadcast-grid">
                <div class="broadcast-card">
                    <div class="card-tag"><i class="fa-solid fa-circle-dot"></i> LIVE 4K</div>
                    <h4>GLOBAL ARENA FEED</h4>
                    <p>Broadcasting high-definition match coverages directly from premier sports complexes worldwide.</p>
                </div>
                <div class="broadcast-card">
                    <div class="card-tag"><i class="fa-solid fa-bolt"></i> ULTRA HD</div>
                    <h4>TACTICAL TELEMETRY</h4>
                    <p>Real-time statistical overlays and player performance tracking metrics updated instantly.</p>
                </div>
                <div class="broadcast-card">
                    <div class="card-tag"><i class="fa-solid fa-shield-halved"></i> SECURE NODE</div>
                    <h4>ENCRYPTED FEED SYNC</h4>
                    <p>Zero-latency encrypted media transmission linked seamlessly with the central tournament database.</p>
                </div>
            </div>
        </div>
		
        <div class="gallery-section">
            <h3 class="section-title">🏆 Cricket Highlights</h3>
            <div class="gallery-grid">
                <div class="gallery-card">
                    <div class="card-header">
                        <h4>🏟️ Floodlit Stadium</h4>
                        <p>World-class arena illumination designed for grand spectacles</p>
                    </div>
                    <div class="card-image">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQD4tpHPXiUCeyTxPbsdvO2716vjbWqVfvhQewalvYS6XCghJg6F1I0kC89&s=10" alt="Stadium">
                    </div>
                </div>
                
                <div class="gallery-card">
                    <div class="card-header">
                        <h4>⚡ Match Action</h4>
                        <p>High-voltage cricket matches filled with thrilling moments</p>
                    </div>
                    <div class="card-image">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvwIJYDg3dkTTtg6cuk-_XGvgyNWT6o3TmXOdcKdWWZSq73V4oKCYyqt8a&s=10" alt="Action">
                    </div>
                </div>
                
                <div class="gallery-card">
                    <div class="card-header">
                        <h4>🎯 Match Ball</h4>
                        <p>Precision-crafted equipment for professional performance</p>
                    </div>
                    <div class="card-image">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4jblErExei-bnUQf-_pbkDfO05s-zaCnamqf2qoyTdh2bI7O5fNCMK1M&s=10" alt="Ball">
                    </div>
                </div>
            </div>
        </div>

        <!-- ===== NEW SECTION A: TOP 3 PODIUM ===== -->
        <div class="podium-section">
            <h3 class="section-title" style="margin-bottom: 20px;">🏆 Top Performing Teams</h3>
            <c:choose>
                <c:when test="${not empty pointsList}">
                    <div class="podium-grid">
                        <c:forEach items="${pointsList}" var="pt" varStatus="loop" end="2">
                            <div class="podium-card ${loop.index == 0 ? 'gold' : (loop.index == 1 ? 'silver' : 'bronze')}">
                                <div class="podium-rank-icon">
                                    <i class="fa-solid ${loop.index == 0 ? 'fa-trophy' : 'fa-medal'}"></i>
                                </div>
                                <div class="podium-team">${pt.team != null ? pt.team.teamName : 'N/A'}</div>
                                <div class="podium-tour">${pt.tournament != null ? pt.tournament.tournamentName : 'N/A'}</div>
                                <div class="podium-pts">${pt.points}</div>
                                <div class="podium-pts-label">Points</div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-record">🏆 Podium will appear once teams have points on the board</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ===== NEW SECTION B: MATCH FORMAT QUICK INFO ===== -->
        <div class="format-info-section">
            <div class="format-info-card">
                <div class="format-info-icon"><i class="fa-solid fa-baseball-bat-ball"></i></div>
                <div>
                    <h5>20 Overs</h5>
                    <p>Format per innings</p>
                </div>
            </div>
            <div class="format-info-card">
                <div class="format-info-icon"><i class="fa-solid fa-users"></i></div>
                <div>
                    <h5>11 Players</h5>
                    <p>Per side on field</p>
                </div>
            </div>
            <div class="format-info-card">
                <div class="format-info-icon"><i class="fa-solid fa-check-double"></i></div>
                <div>
                    <h5>2 Points</h5>
                    <p>Awarded per win</p>
                </div>
            </div>
            <div class="format-info-card">
                <div class="format-info-icon"><i class="fa-solid fa-handshake"></i></div>
                <div>
                    <h5>1 Point</h5>
                    <p>For tie / no result</p>
                </div>
            </div>
        </div>

        <!-- ===== NEW SECTION C: RECENT FORM GUIDE ===== -->
        <div class="form-guide-section">
            <h3 class="section-title" style="margin-bottom: 18px;">📈 Recent Form Guide</h3>
            <c:choose>
                <c:when test="${not empty pointsList}">
                    <c:forEach items="${pointsList}" var="pt" varStatus="loop" end="3">
                        <div class="form-row">
                            <div class="form-team">${pt.team != null ? pt.team.teamName : 'N/A'}</div>
                            <div class="form-badges">
                                <span class="form-pill w">W</span>
                                <span class="form-pill w">W</span>
                                <span class="form-pill l">L</span>
                                <span class="form-pill w">W</span>
                                <span class="form-pill t">T</span>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="no-record">📈 Form guide will populate as matches are played</div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- ===== NEW SECTION D: CTA BANNER ===== -->
        <div class="points-cta-banner">
            <div class="points-cta-text">
                <h3>🚀 Get Your Team on This Board</h3>
                <p>Register today and start climbing the standings with live scoring, automated points and NRR tracking.</p>
            </div>
            <a href="${pageContext.request.contextPath}/register-team" class="points-cta-btn">
                <i class="fa-solid fa-shield-halved"></i> Register Your Team
            </a>
        </div>

    </div>

    <jsp:include page="footer.jsp" />

    <!-- CHATBOT INCLUDE -->
    <jsp:include page="chatbot.jsp" />

    <script>
        window.addEventListener('DOMContentLoaded', function() {
            const titleEl = document.getElementById('animatedTitle');
            if (titleEl) {
                const textWords = titleEl.innerText;
                titleEl.innerHTML = textWords.split('').map(function(char, index) {
                    if (char === ' ') return '<span style="--i:' + index + '">&nbsp;</span>';
                    return '<span style="--i:' + index + '">' + char + '</span>';
                }).join('');
            }
        });

        function filterTable() {
            let input = document.getElementById('tableSearch').value.toLowerCase().trim();
            let rows = document.querySelectorAll('#pointsTableElement tbody tr');

            rows.forEach(row => {
                let searchData = row.getAttribute('data-search');
                if (searchData) {
                    if (input === "" || searchData.indexOf(input) > -1) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                }
            });
        }
    </script>

</body>
</html>
