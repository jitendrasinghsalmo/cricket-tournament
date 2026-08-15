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
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.78);
            --card-surface-back: #0b0f19;
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-gold: #fbbf24;
            --text-primary: #f8fafc;
            --text-secondary: #cbd5e1;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.85);
        }

        body.light-mode {
            --bg-deep: #f8fafc;
            --card-surface: rgba(255, 255, 255, 0.85);
            --card-surface-back: #ffffff;
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-gold: #d97706;
            --text-primary: #0f172a;
            --text-secondary: #334155;
            --border-glass: rgba(2, 132, 199, 0.25);
            --body-overlay: rgba(241, 245, 249, 0.85);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: #020d1f;
            color: var(--text-primary); 
            margin: 0; 
            padding: 0 0 60px 0; 
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* 🌟 TOP NAVBAR MATCHING REFERENCE */
        nav {
            background: rgba(10, 16, 30, 0.95);
            border-bottom: 2px solid rgba(0, 217, 255, 0.9);
            padding: 18px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 0 30px rgba(0, 217, 255, 0.08);
        }
        .logo-box { display: flex; align-items: center; gap: 16px; text-decoration: none; }
        .logo-icon {
            width: 52px; height: 52px; border-radius: 14px;
            background: linear-gradient(135deg, #1de9ff, #00d9ff);
            color: #03111f; font-size: 30px; font-weight: 900;
            display: flex; align-items: center; justify-content: center;
            box-shadow: 0 0 20px rgba(0, 217, 255, 0.6);
        }
        .logo-text { font-weight: 900; font-size: 28px; color: #00d9ff; letter-spacing: 0.5px; }
        .logo-text span { display: block; font-size: 11px; color: #7bdff9; letter-spacing: 2px; text-transform: uppercase; font-weight: 700; }

        .nav-links { list-style: none; margin: 0; padding: 0; display: flex; gap: 18px; align-items: center; }
        .nav-links a {
            color: #ecf8ff; text-decoration: none; font-size: 17px; font-weight: 800;
            text-transform: uppercase; letter-spacing: 1px; padding: 12px 18px; border-radius: 16px; transition: all 0.3s ease;
        }
        .nav-links a:hover { color: #00d9ff; }
        .nav-links a.active {
            color: #04151f; background: linear-gradient(135deg, #66f4ff, #4ce7bb);
            box-shadow: 0 0 28px rgba(76, 231, 187, 0.6);
        }

        .main-content-area { max-width: 1600px; margin: 35px auto 0 auto; padding: 0 20px; }
        
        .header-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            max-width: 1600px; margin: 0 auto 25px auto;
            background: rgba(9, 18, 35, 0.9);
            padding: 22px 26px; border-radius: 24px; border: 2px solid rgba(0, 217, 255, 0.9); 
            box-shadow: inset 0 0 25px rgba(0, 217, 255, 0.08), 0 0 25px rgba(0, 217, 255, 0.08);
        }
        
        .header-left { display: flex; align-items: center; gap: 18px; }
        .header-right { display: flex; align-items: center; gap: 14px; }

        .btn-back {
            background: rgba(8, 18, 35, 0.1); color: #00d9ff; border: 2px solid rgba(0, 217, 255, 0.9);
            padding: 12px 20px; border-radius: 12px; text-decoration: none; font-weight: 800; font-size: 18px;
            display: inline-flex; align-items: center; gap: 8px; transition: all 0.3s ease;
            box-shadow: 0 0 14px rgba(0, 217, 255, 0.15);
        }
        .btn-back:hover {
            background: rgba(0, 217, 255, 0.12); box-shadow: 0 0 18px rgba(0, 217, 255, 0.3);
        }
        
        .btn-theme-toggle {
            background: linear-gradient(135deg, rgba(157, 78, 255, 0.18), rgba(188, 96, 255, 0.18));
            color: #efc3ff; border: 2px solid rgba(192, 105, 255, 0.95); padding: 12px 24px;
            border-radius: 12px; font-weight: 800; font-size: 18px; cursor: pointer;
            display: inline-flex; align-items: center; gap: 8px; transition: all 0.3s ease;
            box-shadow: 0 0 18px rgba(192, 105, 255, 0.2);
        }
        .btn-theme-toggle:hover { filter: brightness(1.1); }

        .btn-top-add {
            background: linear-gradient(135deg, #2ec5ff 0%, #1f9fe5 100%);
            color: #ffffff; border: 2px solid rgba(0, 217, 255, 0.9);
            padding: 12px 22px; border-radius: 12px; text-decoration: none;
            font-weight: 800; font-size: 18px; box-shadow: 0 0 18px rgba(46, 197, 255, 0.35);
            transition: all 0.3s ease;
        }
        .btn-top-add:hover { filter: brightness(1.08); }

        .btn-delete-all {
            background: linear-gradient(135deg, rgba(255, 78, 134, 0.18), rgba(255, 97, 97, 0.18));
            color: #ff5a8a; border: 2px solid rgba(255, 88, 140, 0.9); padding: 12px 22px; border-radius: 12px;
            text-decoration: none; font-weight: 800; font-size: 18px; transition: all 0.3s ease;
            box-shadow: 0 0 18px rgba(255, 88, 140, 0.2);
        }
        .btn-delete-all:hover { filter: brightness(1.08); }

        .jumping-title {
            text-align: center; color: #00d9ff; margin: 0; font-weight: 900; font-size: 44px; letter-spacing: 2px; text-transform: uppercase;
            display: inline-block; overflow: visible; text-shadow: 0 0 15px rgba(0, 217, 255, 0.8), 0 0 30px rgba(0, 255, 136, 0.5);
        }
        .jumping-title span {
            display: inline-block; opacity: 0; transform: translateY(-20px);
            animation: dropInChar 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.04s * var(--i));
        }
        .jumping-title span.highlight { color: var(--neon-cyan); text-shadow: 0 0 20px rgba(56, 189, 248, 0.4); }

        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-20px); }
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

        /* MATCHES MAIN SECTION */
        .matches-grid { 
            display: grid; grid-template-columns: repeat(auto-fill, minmax(380px, 1fr)); gap: 25px; max-width: 1250px; margin: 0 auto;
        }

        @media(max-width: 1024px) { .matches-grid { grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 20px; } }
        @media(max-width: 768px) { .matches-grid { grid-template-columns: 1fr; gap: 15px; } }
        
        .match-card {
            background: var(--card-surface); backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border-radius: 16px; border: 1px solid var(--border-glass);
            box-shadow: 0 15px 35px rgba(0,0,0,0.15); display: flex; overflow: hidden; min-height: 220px;
            transition: transform 0.3s ease, border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .match-card:hover {
            transform: translateY(-5px); border-color: var(--neon-cyan);
            box-shadow: 0 20px 40px rgba(56, 189, 248, 0.2);
        }

        .card-details-side {
            flex: 1; padding: 18px; display: flex; flex-direction: column; justify-content: space-between; overflow: hidden;
        }

        .match-header-row { display: flex; justify-content: space-between; align-items: center; gap: 5px; }
        .tournament-title { font-size: 11px; color: var(--text-secondary); text-transform: uppercase; font-weight: 700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 130px; }
        
        .status-badge-pro { padding: 4px 10px; border-radius: 20px; font-size: 9.5px; font-weight: 800; text-transform: uppercase; white-space: nowrap; }
        .status-upcoming { background: rgba(234, 179, 8, 0.15); color: #f59e0b; border: 1px solid rgba(234, 179, 8, 0.3); }
        .status-completed { background: rgba(16, 185, 129, 0.15); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3); }

        .teams-display { font-size: 15px; font-weight: 800; color: var(--text-primary); margin: 8px 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; width: 100%; letter-spacing: 0.5px; }
        .vs-text { color: var(--neon-rose); font-weight: 900; margin: 0 4px; font-size: 12px; }

        .match-meta-info { font-size: 11.5px; color: var(--text-secondary); line-height: 1.5; border-top: 1px solid var(--border-glass); padding-top: 8px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .match-meta-info strong { color: var(--text-primary); font-weight: 700; }

        .card-actions-row { display: flex; gap: 8px; border-top: 1px solid var(--border-glass); padding-top: 8px; }
        .card-actions-row a { text-decoration: none; padding: 6px 14px; border-radius: 8px; font-size: 11.5px; font-weight: 700; transition: all 0.2s; }
        .btn-edit-pro { background: rgba(56, 189, 248, 0.12); color: var(--neon-cyan); border: 1px solid rgba(56, 189, 248, 0.3); }
        .btn-edit-pro:hover { background: rgba(56, 189, 248, 0.3); color: #fff; }
        .btn-delete-pro { background: rgba(244, 63, 94, 0.12); color: var(--neon-rose); border: 1px solid rgba(244, 63, 94, 0.3); }
        .btn-delete-pro:hover { background: rgba(244, 63, 94, 0.3); color: #fff; }

        .card-image-side {
            flex: 0.7;
            background: url('https://t3.ftcdn.net/jpg/00/77/80/30/360_F_77803034_gH61aEkhTgUS6F2X8Bpne2HRMdCXa7M6.jpg') no-repeat center center;
            background-size: cover; 
            display: flex; flex-direction: column; justify-content: space-between; align-items: flex-end;
            padding: 14px; border-left: 1px solid var(--border-glass); position: relative;
        }
        .arena-tag { background: rgba(0, 0, 0, 0.75); backdrop-filter: blur(6px); color: #38bdf8; font-size: 10px; font-weight: 800; padding: 4px 10px; border-radius: 6px; border: 1px solid rgba(56, 189, 248, 0.4); text-transform: uppercase; }
        .match-id-badge { background: rgba(0, 0, 0, 0.75); backdrop-filter: blur(6px); color: #ffd700; font-size: 11px; font-weight: 800; padding: 3px 8px; border-radius: 6px; border: 1px solid rgba(255, 215, 0, 0.4); }

        /* PAGINATION ON RIGHT SIDE (JUST ABOVE STATS SECTION) */
        .pagination-bar {
            display: flex; justify-content: flex-end; align-items: center; gap: 20px;
            background: transparent;
            border: none;
            max-width: 1250px;
            margin: 30px auto; padding: 14px 28px; border-radius: 16px;
            box-sizing: border-box;
        }
        .pagination-bar a {
            padding: 9px 20px; background: var(--neon-cyan); color: #ffffff;
            border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s;
        }
        .pagination-bar a:hover { opacity: 0.85; transform: translateY(-2px); }
        .page-indicator { font-size: 14px; font-weight: 700; color: var(--text-primary); }

        /* CIRCULAR BADGE STATS SECTION */
        .circular-stats-section {
            max-width: 1250px;
            margin: 40px auto 10px auto;
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
            padding: 25px 20px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
        }
        .circle-badge-card:hover {
            transform: translateY(-5px);
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(56, 189, 248, 0.25);
        }
        .circle-icon-wrap {
            width: 70px;
            height: 70px;
            margin: 0 auto 12px auto;
            border-radius: 50%;
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.15), rgba(16, 185, 129, 0.15));
            border: 2px solid var(--neon-cyan);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            color: var(--neon-cyan);
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.3);
        }
        .circle-badge-card h4 {
            margin: 0 0 6px 0;
            font-size: 15px;
            font-weight: 800;
            color: var(--text-primary);
            text-transform: uppercase;
        }
        .circle-badge-card p {
            margin: 0;
            font-size: 13px;
            color: var(--text-secondary);
            line-height: 1.5;
        }

        /* CRICKET SECTIONS - RESPONSIVE GRID */
        .cricket-section {
            max-width: 1250px; margin: 50px auto 0 auto;
        }
        .section-title {
            font-size: 22px; font-weight: 900; color: var(--text-primary); 
            margin-bottom: 22px; text-transform: uppercase; letter-spacing: 1.2px;
        }
        .cricket-grid {
            display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); 
            gap: 22px; margin-bottom: 50px;
        }

        .performer-card {
            background: var(--card-surface); 
            backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); 
            border-radius: 20px; 
            padding: 26px 20px; 
            text-align: center; 
            transition: all 0.3s ease;
            box-shadow: 0 12px 35px rgba(0,0,0,0.25);
        }
        .performer-card:hover {
            transform: translateY(-6px);
            border-color: var(--neon-cyan);
            box-shadow: 0 18px 45px rgba(56, 189, 248, 0.3);
        }

        /* 🌟 NAYA EXTRA SHANDAAR BANNER SECTION (IMAGES KE THEEK UPAR) */
        .pro-arena-highlight-banner {
            max-width: 1250px;
            margin: 50px auto 30px auto;
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.18), rgba(16, 185, 129, 0.18));
            border: 2px solid var(--neon-cyan);
            border-radius: 22px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 15px 40px rgba(56, 189, 248, 0.25);
            backdrop-filter: blur(15px);
            position: relative;
            overflow: hidden;
        }
        .pro-arena-highlight-banner::before {
            content: '';
            position: absolute;
            top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.1) 0%, transparent 60%);
            pointer-events: none;
        }
        .pro-arena-highlight-banner h3 {
            font-size: 24px;
            font-weight: 900;
            color: var(--neon-cyan);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 12px;
            text-shadow: 0 0 15px rgba(56, 189, 248, 0.6);
        }
        .pro-arena-highlight-banner p {
            font-size: 14.5px;
            color: var(--text-primary);
            max-width: 800px;
            margin: 0 auto;
            line-height: 1.7;
            font-weight: 600;
        }

        /* INDEPENDENT FOOTER GALLERY SECTION */
        .footer-gallery-section {
            max-width: 1250px;
            margin: 30px auto 30px auto;
        }

        .footer-gallery-grid {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px;
        }
        @media(max-width: 768px) { .footer-gallery-grid { grid-template-columns: 1fr; } }

        .gallery-card-item {
            background: rgba(20, 25, 40, 0.85);
            border-radius: 18px; padding: 22px;
            border: 1.5px solid var(--border-glass);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            display: flex; flex-direction: column; align-items: center; text-align: center;
            transition: border-color 0.3s ease;
        }

        .gallery-card-content { margin-bottom: 18px; width: 100%; }
        .gallery-card-content h4 { margin: 0 0 8px 0; font-size: 16px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; letter-spacing: 0.8px; }
        .gallery-card-content p { margin: 0; font-size: 13px; color: var(--text-secondary); line-height: 1.5; }

        .gallery-item-circle {
            width: 140px; height: 140px; border-radius: 50%;
            overflow: hidden; border: 3px solid var(--neon-cyan);
            box-shadow: 0 0 20px rgba(56, 189, 248, 0.4); background: #020617;
            animation: spinContinuous 5s linear infinite;
        }

        @keyframes spinContinuous {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .gallery-card-item:hover .gallery-item-circle {
            animation: spinFastHover 1s linear infinite;
        }

        @keyframes spinFastHover {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        .gallery-item-circle img { width: 100%; height: 100%; object-fit: cover; display: block; }

        /* 🌟 GRAND CYBER FOOTER SECTION (WITH LINKEDIN & GITHUB) */
        .grand-footer-section {
            background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
            backdrop-filter: blur(25px);
            border-top: 2px solid var(--neon-cyan);
            border-radius: 28px 28px 0 0;
            padding: 60px 40px 30px 40px;
            box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6);
            max-width: 1250px;
            margin: 60px auto 0 auto;
        }
        .grand-footer-content {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1.2fr; gap: 30px; align-items: start;
            border-bottom: 1px solid var(--border-glass); padding-bottom: 30px; margin-bottom: 25px;
        }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 768px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }

        .footer-brand h3 { margin: 0 0 8px 0; font-size: 20px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(56,189,248,0.5); }
        .footer-brand p { margin: 0 0 15px 0; font-size: 13px; color: var(--text-secondary); line-height: 1.6; }
        
        .footer-socials { display: flex; gap: 12px; }
        @media(max-width: 768px) { .footer-socials { justify-content: center; } }
        .footer-socials a {
            width: 38px; height: 38px; border-radius: 50%;
            background: rgba(56, 189, 248, 0.1); border: 1px solid var(--border-glass);
            color: var(--neon-cyan); display: flex; align-items: center; justify-content: center;
            text-decoration: none; transition: all 0.3s ease; font-size: 14px;
        }
        .footer-socials a:hover {
            background: var(--neon-cyan); color: #030712; transform: translateY(-3px);
            box-shadow: 0 0 15px rgba(56,189,248,0.6);
        }

        .footer-links h4 { margin: 0 0 14px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 0.5px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 10px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: color 0.2s; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(3px); }

        .footer-newsletter h4 { margin: 0 0 14px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 0.5px; }
        .footer-newsletter p { font-size: 12.5px; color: var(--text-secondary); margin-bottom: 12px; line-height: 1.5; }
        .footer-newsletter form { display: flex; gap: 6px; }
        .footer-newsletter input {
            flex: 1; background: rgba(3, 7, 18, 0.7); border: 1px solid var(--border-glass);
            border-radius: 8px; padding: 8px 12px; color: var(--text-primary); font-size: 12px; outline: none;
        }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); }
        .footer-newsletter button {
            background: var(--neon-cyan); color: #030712; border: none; border-radius: 8px;
            padding: 8px 14px; font-weight: 800; font-size: 12px; cursor: pointer; transition: 0.3s;
        }
        .footer-newsletter button:hover { opacity: 0.9; box-shadow: 0 0 12px rgba(56,189,248,0.5); }

        .footer-bottom-bar { text-align: center; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }

        .no-match { text-align: center; color: var(--text-secondary); grid-column: 1 / -1; padding: 60px; font-size: 16px; background: var(--card-surface); border-radius: 18px; border: 1.5px solid var(--border-glass); }

        /* CRICKET CARD STYLES */
        .cricket-card {
            background: var(--card-surface); backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); border-radius: 16px; 
            padding: 22px; transition: all 0.3s ease;
        }
        .cricket-card:hover {
            transform: translateY(-4px); border-color: var(--neon-cyan);
            box-shadow: 0 12px 35px rgba(56, 189, 248, 0.25);
        }

        .news-card {
            background: var(--card-surface); backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); border-radius: 16px; 
            overflow: hidden; transition: all 0.3s ease;
        }
        .news-card:hover {
            transform: translateY(-4px); border-color: var(--neon-cyan);
            box-shadow: 0 12px 35px rgba(56, 189, 248, 0.25);
        }
    </style>
</head>
<body>

    <!-- 🌟 NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-area">

        <div class="header-bar" style="max-width:100%;">
            <div class="header-left">
                <a href="/home" class="btn-back">← Back</a>
            </div>
            
            <div>
                <h2 class="jumping-title" id="animatedTitle">TOURNAMENT COMMAND CENTER</h2>
            </div>

            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
                <a href="addMatch" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Tournament</a>
                <a href="/deleteAllMatches" class="btn-delete-all" onclick="return confirm('⚠️ Critical Action: Delete all matches permanently?')"><i class="fa-solid fa-trash"></i> Delete All</a>
            </div>
        </div>

        <div class="control-bar" style="max-width:100%;">
            <input type="text" id="matchSearch" class="search-input" placeholder="🔍 Search match by team..." onkeyup="filterMatches()" autocomplete="off">
            <div class="stats-badge">Total Matches: <span style="color: var(--neon-cyan); font-weight: 800;">${matches.size()}</span></div>
        </div>

        <!-- ============ MATCHES MAIN SECTION ============ -->
        <div class="matches-grid" id="matchesGrid" style="max-width:100%;">
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
                            
                            <div class="teams-display" title="${m.teamA != null ? m.teamA.teamName : 'TBD'} vs ${m.teamB != null ? m.teamB.teamName : 'TBD'}">
                                ${m.teamA != null ? m.teamA.teamName : 'TBD'} <span class="vs-text">VS</span> ${m.teamB != null ? m.teamB.teamName : 'TBD'}
                            </div>
                            
                            <div class="match-meta-info" title="Venue: ${m.venue} | Date: ${m.matchDateTime}">
                                📍 <strong>Venue:</strong> ${m.venue}<br>
                                📅 <strong>Date:</strong> ${m.matchDateTime}<br>
                                ⭐ <strong>Winner:</strong> <span style="color: var(--neon-emerald); font-weight: 700;">${m.winner != null ? m.winner.teamName : 'TBD'}</span>
                            </div>
                        </div>
                        
                        <div class="card-actions-row">
                            <a href="editMatch/${m.id}" class="btn-edit-pro">Edit</a>
                            <a href="deleteMatch/${m.id}" class="btn-delete-pro" onclick="return confirm('Delete this match?')">Delete</a>
                        </div>
                    </div>

                    <div class="card-image-side">
                        <span class="arena-tag">Live Arena</span>
                        <span class="match-id-badge">#${m.id}</span>
                    </div>

                </div>
            </c:forEach>
            
            <c:if test="${empty matches}">
                <div class="no-match">No active matches found in the arena database.</div>
            </c:if>
        </div>

        <!-- PAGINATION ON RIGHT SIDE (JUST ABOVE STATS SECTION) -->
        <div class="pagination-bar" style="max-width:100%; padding:0;">
            <c:choose>
                <c:when test="${currentPage > 0}">
                    <a href="/matches?page=${currentPage - 1}">⬅ Previous</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 9px 20px; background: rgba(100,100,100,0.05); color: #64748b; border-radius: 10px; font-size: 13px;">⬅ Previous</span>
                </c:otherwise>
            </c:choose>

            <span class="page-indicator">Page ${currentPage + 1} of ${totalPages == 0 ? 1 : totalPages}</span>

            <c:choose>
                <c:when test="${currentPage + 1 < totalPages}">
                    <a href="/matches?page=${currentPage + 1}">Next ➡</a>
                </c:when>
                <c:otherwise>
                    <span style="opacity: 0.3; cursor: not-allowed; padding: 9px 20px; background: rgba(100,100,100,0.05); color: #64748b; border-radius: 10px; font-size: 13px;">Next ➡</span>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- CIRCULAR BADGE STATS SECTION -->
        <div class="circular-stats-section" style="max-width:100%;">
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

        <!-- LIVE SCORES SECTION -->
        <div class="cricket-section" style="max-width:100%; padding:0;">
            <h3 class="section-title">⚡ Live Scores</h3>
            <div class="cricket-grid">
                <div class="cricket-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">
                        <span style="color: var(--neon-emerald); font-weight: 800; font-size: 13px;">🔴 LIVE</span>
                        <span style="color: var(--text-secondary); font-size: 11px; font-weight: 600;">Match #101</span>
                    </div>
                    <div style="color: var(--text-primary); font-weight: 800; font-size: 15px; margin-bottom: 10px;">Team Alpha vs Team Beta</div>
                    <div style="color: var(--text-secondary); font-size: 13px; line-height: 1.6; font-weight: 500;">
                        📍 Central Ground | 🏏 ODI Format<br>
                        ⏱️ Over 25.3 | Alpha: 145/2
                    </div>
                </div>

                <div class="cricket-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">
                        <span style="color: #f59e0b; font-weight: 800; font-size: 13px;">⏳ UPCOMING</span>
                        <span style="color: var(--text-secondary); font-size: 11px; font-weight: 600;">Match #102</span>
                    </div>
                    <div style="color: var(--text-primary); font-weight: 800; font-size: 15px; margin-bottom: 10px;">Team Gamma vs Team Delta</div>
                    <div style="color: var(--text-secondary); font-size: 13px; line-height: 1.6; font-weight: 500;">
                        📍 North Arena | 🏏 T20 Format<br>
                        🕐 Starts: 6:00 PM Tomorrow
                    </div>
                </div>

                <div class="cricket-card">
                    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px;">
                        <span style="color: var(--neon-emerald); font-weight: 800; font-size: 13px;">✅ COMPLETED</span>
                        <span style="color: var(--text-secondary); font-size: 11px; font-weight: 600;">Match #100</span>
                    </div>
                    <div style="color: var(--text-primary); font-weight: 800; font-size: 15px; margin-bottom: 10px;">Team Sigma vs Team Omega</div>
                    <div style="color: var(--text-secondary); font-size: 13px; line-height: 1.6; font-weight: 500;">
                        📍 East Ground | 🏏 Test Match<br>
                        🏆 Winner: Team Sigma (245 runs)
                    </div>
                </div>
            </div>
        </div>

        <!-- TOP PERFORMERS SECTION -->
        <div class="cricket-section" style="max-width:100%; padding:0;">
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
                    <div style="width: 80px; height: 80px; margin: 0 auto 15px; border-radius: 50%; background: linear-gradient(135deg, var(--neon-rose) 0%, var(--neon-cyan) 100%); display: flex; align-items: center; justify-content: center; font-size: 34px;">🎯</div>
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

        <!-- 🌟 NAYA EXTRA SHANDAAR BANNER SECTION (IMAGES KE THEEK UPAR) -->
        <div class="pro-arena-highlight-banner">
            <h3>⚡ Experience Ultimate Sports Analytics & Live Control</h3>
            <p>Elevate your tournament management with real-time tracking, seamless roster controls, and dynamic performance telemetry designed for champions.</p>
        </div>

        <!-- INDEPENDENT FOOTER GALLERY SECTION -->
        <div class="footer-gallery-section" style="max-width:100%; padding:0;">
            <div class="footer-gallery-grid">
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>⚡ Intensive Action</h4>
                        <p>High-voltage cricket matches filled with thrilling moments.</p>
                    </div>
                    <div class="gallery-item-circle">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTclrbY8ONOn4WqyHMsQ2bVoRdEPhBmR1zYHsWWXIkEoA&s=10" alt="Match Action">
                    </div>
                </div>
                
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏆 Trophy Lift</h4>
                        <p>The ultimate reward for dedication, teamwork, and victory.</p>
                    </div>
                    <div class="gallery-item-circle">
                        <img src="https://images.unsplash.com/photo-1579952363873-27f3bade9f55?auto=format&fit=crop&w=500&q=80" alt="Victory Lift">
                    </div>
                </div>
                
                <div class="gallery-card-item">
                    <div class="gallery-card-content">
                        <h4>🏏 Pro Equipment</h4>
                        <p>Precision-crafted gear designed for professional performance.</p>
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
        const textWords = titleEl.innerText;
        titleEl.innerHTML = textWords.split('').map(function(char, index) {
            if (char === ' ') return '<span style="--i:' + index + '">&nbsp;</span>';
            return '<span style="--i:' + index + '">' + char + '</span>';
        }).join('');

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