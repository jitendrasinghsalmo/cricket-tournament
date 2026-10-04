<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="home" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <!-- FIX: no-referrer YouTube embed ko block karta tha -->
    <meta name="referrer" content="strict-origin-when-cross-origin">
    <title>ProMatch Arena | User Dashboard</title>
    <!-- Bootstrap 5 CSS & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        html { scroll-behavior: smooth; }
        :root {
            --bg-main: #030712;
            --bg-card: rgba(13, 18, 30, 0.85);
            --bg-card-hover: rgba(20, 26, 40, 0.95);
            --accent-red: #f43f5e;
            --accent-green: #10b981;
            --accent-blue: #38bdf8;
            --accent-amber: #f59e0b;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border-color: rgba(56, 189, 248, 0.22);
            --neon-cyan: #00d9ff;
            --neon-emerald: #00ff88;
            --border-glass: rgba(0, 217, 255, 0.25);
            --text-primary: #f0f4ff;
            --text-secondary: #a8b8d8;
        }

        body.light-mode {
            --bg-main: #f1f5f9;
            --bg-card: rgba(255, 255, 255, 0.94);
            --bg-card-hover: rgba(241, 245, 249, 0.98);
            --accent-red: #e11d48;
            --accent-green: #059669;
            --accent-blue: #0284c7;
            --accent-amber: #d97706;
            --text-main: #0f172a;
            --text-muted: #475569;
            --border-color: #cbd5e1;
            --neon-cyan: #0099cc;
            --neon-emerald: #00aa44;
            --border-glass: rgba(0, 153, 204, 0.25);
            --text-primary: #1a2550;
            --text-secondary: #556688;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, var(--bg-main) 0%, var(--bg-main) 100%);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            overflow-x: hidden;
            transition: background 0.3s ease, color 0.3s ease;
        }

        .container { max-width: 1350px; margin: 30px auto; padding: 0 20px; width: 100%; box-sizing: border-box; }

        /* HERO BANNER - FULLY RESPONSIVE FIX */
        .hero-banner {
            position: relative;
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            border: 1.5px solid var(--border-color);
            border-radius: 28px;
            padding: 45px 50px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
            overflow: hidden;
            flex-wrap: wrap;
            gap: 30px;
        }

        .hero-banner::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.16) 0%, rgba(16, 185, 129, 0.10) 35%, transparent 70%);
            animation: rotateGlow 12s linear infinite; z-index: 1; pointer-events: none;
        }

        @keyframes rotateGlow { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        .hero-content { z-index: 2; max-width: 600px; flex: 1; min-width: 280px; }
        .season-tag { color: var(--accent-green); font-size: 11.5px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px; display: block; text-shadow: 0 0 10px rgba(16,185,129,0.4); }
        .hero-content h1 { font-size: clamp(26px, 3.5vw, 36px); margin: 0 0 12px 0; font-weight: 900; letter-spacing: 0.5px; color: var(--text-main); word-break: break-word; text-shadow: 0 0 20px rgba(56,189,248,0.3); }
        .hero-content p { color: var(--text-muted); font-size: 14px; margin: 0 0 25px 0; line-height: 1.6; }

        .btn-custom-glow {
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); color: #030712; border: none; padding: 12px 24px;
            border-radius: 14px; font-weight: 800; font-size: 13px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 0 25px rgba(56,189,248,0.5); transition: all 0.3s ease; text-transform: uppercase; z-index: 2; white-space: nowrap;
        }
        .btn-custom-glow:hover { transform: translateY(-3px) scale(1.02); box-shadow: 0 0 35px rgba(56,189,248,0.8); color: #030712; }
        body.light-mode .btn-custom-glow { color: #ffffff; }

        .hero-stadium-art {
            position: relative; z-index: 2; width: 380px; max-width: 100%; height: 190px;
            border: 1.5px solid rgba(16, 185, 129, 0.5); border-radius: 20px; overflow: hidden;
            display: flex; align-items: center; justify-content: center; flex-shrink: 0;
            background: radial-gradient(circle at 25% 15%, rgba(16, 185, 129, 0.30), transparent 55%), radial-gradient(circle at 85% 85%, rgba(56, 189, 248, 0.30), transparent 55%), linear-gradient(135deg, rgba(6, 78, 59, 0.55), rgba(3, 7, 18, 0.95));
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.3);
        }

        .live-scoreboard {
            position: relative; z-index: 3; width: 87%;
            background: rgba(3, 7, 18, 0.75); backdrop-filter: blur(8px);
            border: 1px solid rgba(56, 189, 248, 0.4); border-radius: 16px;
            padding: 14px 18px; box-shadow: 0 10px 25px rgba(0,0,0,0.4);
        }
        .live-scoreboard .scoreboard-header {
            display: flex; align-items: center; gap: 7px; font-size: 10.5px; font-weight: 800;
            color: var(--accent-red); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px;
        }
        .live-scoreboard .live-dot {
            width: 7px; height: 7px; border-radius: 50%; background: var(--accent-red);
            box-shadow: 0 0 8px var(--accent-red); animation: pulseDot 1.3s ease-in-out infinite;
        }
        @keyframes pulseDot { 0%,100% { opacity: 1; } 50% { opacity: 0.3; } }
        .team-row {
            display: flex; justify-content: space-between; align-items: center;
            font-size: 13.5px; font-weight: 700; color: #fff; padding: 3px 0;
        }
        .team-score { color: var(--accent-blue); font-weight: 900; }
        .live-scoreboard .scoreboard-progress {
            height: 5px; background: rgba(255,255,255,0.08); border-radius: 4px; overflow: hidden; margin-top: 10px;
        }
        .live-scoreboard .scoreboard-progress-bar {
            height: 100%; background: linear-gradient(90deg, var(--accent-green), var(--accent-blue)); width: 85%;
        }
        .live-scoreboard .scoreboard-footer {
            font-size: 10px; color: var(--text-muted); margin-top: 8px; display: flex; justify-content: space-between;
        }

        /* RUNNING TICKER */
        .running-ticker {
            background: linear-gradient(90deg, #f43f5e, #0284c7, #10b981);
            color: #ffffff; font-size: 13px; font-weight: 800; padding: 9px 0;
            overflow: hidden; white-space: nowrap; box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            text-transform: uppercase; letter-spacing: 1px; border-radius: 12px;
            margin-bottom: 30px;
        }
        .running-ticker marquee span { margin-right: 40px; }

        /* STATS WIDGETS - FULLY RESPONSIVE GRID FIX */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 30px; }
        @media (max-width: 1024px) { .stats-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 576px) { .stats-grid { grid-template-columns: 1fr; } }

        .stat-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; 
            padding: 20px; transition: all 0.3s ease; display: flex; align-items: center; gap: 15px; 
            box-shadow: 0 10px 30px rgba(0,0,0,0.25); position: relative; overflow: hidden; width: 100%; box-sizing: border-box;
        }
        .stat-card:hover { transform: translateY(-5px); border-color: var(--accent-blue); box-shadow: 0 15px 40px rgba(56,189,248,0.25); }
        .stat-icon-badge {
            width: 50px; height: 50px; border-radius: 14px; flex-shrink: 0;
            background: rgba(56, 189, 248, 0.15); border: 1px solid rgba(56, 189, 248, 0.3);
            display: flex; align-items: center; justify-content: center; font-size: 19px; color: var(--accent-blue);
        }
        .stat-card h4 { color: var(--text-muted); font-size: 10.5px; text-transform: uppercase; letter-spacing: 0.8px; margin: 0 0 4px 0; font-weight: 800; word-break: break-word; }
        .stat-card .val { font-size: 14px; font-weight: 800; margin: 0; color: var(--text-main); display: flex; align-items: center; gap: 6px; flex-wrap: wrap; word-break: break-word; }
        .stat-card .live-badge-mini { font-size: 9.5px; background: rgba(16,185,129,0.2); color: var(--accent-green); border: 1px solid rgba(16,185,129,0.4); padding: 1px 6px; border-radius: 8px; font-weight: 700; text-transform: uppercase; }

        /* QUICK ACTION HUB */
        .card-box { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 28px; margin-bottom: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        .card-box h3 { font-size: 17px; margin: 0 0 18px 0; font-weight: 800; color: var(--text-main); display: flex; align-items: center; gap: 10px; }
        .quick-nav-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
        @media (max-width: 700px) { .quick-nav-grid { grid-template-columns: repeat(2, 1fr); } }
        .quick-nav-item {
            background: rgba(3,7,18,0.7); border: 1.5px solid var(--border-color); padding: 20px 15px;
            border-radius: 14px; text-align: center; text-decoration: none; color: var(--text-main); font-size: 13.5px; font-weight: 700; transition: all 0.25s;
        }
        .quick-nav-item:hover { border-color: var(--accent-blue); background: var(--bg-card-hover); color: var(--accent-blue); transform: translateY(-3px); box-shadow: 0 10px 20px rgba(56,189,248,0.15); }
        .quick-nav-item i { font-size: 22px; display: block; margin-bottom: 10px; color: var(--accent-blue); }

        /* SECTION TITLES */
        .section-title { font-size: 19px; font-weight: 800; margin: 40px 0 20px 0; display: flex; justify-content: space-between; align-items: center; border-left: 4px solid var(--accent-blue); padding-left: 12px; text-transform: uppercase; letter-spacing: 0.5px; flex-wrap: wrap; gap: 10px; }

        /* ABOUT PROJECT ARCHITECTURE CARDS */
        .perspective-container { perspective: 1200px; margin-bottom: 45px; }
        .about-project-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media (max-width: 900px) { .about-project-grid { grid-template-columns: 1fr; } }
        .about-card {
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.9), rgba(20, 28, 48, 0.95));
            border: 1.5px solid var(--border-color); border-radius: 20px; padding: 25px;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5); transition: transform 0.5s ease;
        }
        .about-card:hover { transform: translateY(-8px); border-color: var(--accent-blue); box-shadow: 0 25px 50px rgba(56,189,248,0.3); }
        .about-card h5 { margin: 0 0 8px 0; font-size: 17px; font-weight: 900; color: var(--text-main); }
        .about-card p { margin: 0; font-size: 13px; color: var(--text-muted); line-height: 1.5; }

        /* 🌟 ABOUT US */
        .about-us-section {
            position: relative;
            display: grid; grid-template-columns: 1.1fr 1fr; gap: 50px; align-items: center;
            background: transparent; border: none; border-radius: 0;
            padding: 20px 0; margin-bottom: 45px; box-shadow: none; overflow: hidden;
        }
        .about-us-video-wrap {
            position: relative; z-index: 2; width: 100%; height: 450px; border-radius: 20px; overflow: hidden;
            box-shadow: 0 20px 45px rgba(0,0,0,0.55); border: 1.5px solid rgba(56, 189, 248, 0.35); background: #000;
        }
        .about-us-video-wrap video { width: 100%; height: 100%; object-fit: cover; display: block; }
        .about-us-video-wrap .about-us-video-tag {
            position: absolute; top: 16px; left: 16px; z-index: 3;
            background: rgba(3,7,18,0.75); backdrop-filter: blur(10px);
            border: 1px solid var(--accent-blue); color: var(--accent-blue);
            font-size: 11px; font-weight: 800; letter-spacing: 0.5px; text-transform: uppercase;
            padding: 6px 14px; border-radius: 20px; display: flex; align-items: center; gap: 6px;
        }
        .about-us-video-wrap .about-us-video-tag .dot {
            width: 7px; height: 7px; border-radius: 50%; background: var(--accent-red); box-shadow: 0 0 8px var(--accent-red);
            animation: pulseDot 1.4s ease-in-out infinite;
        }
        
        .about-us-text { position: relative; z-index: 2; }
        .about-us-text h2 { font-size: clamp(28px, 3.5vw, 38px); font-weight: 900; margin: 0 0 16px 0; color: var(--text-main); letter-spacing: 0.5px; }
        .about-us-text h2 span { color: var(--accent-blue); text-shadow: 0 0 15px rgba(56,189,248,0.4); }
        .about-us-text p { font-size: 14.5px; line-height: 1.8; color: var(--text-muted); margin: 0 0 16px 0; }
        .about-us-features { list-style: none; margin: 0 0 24px 0; padding: 0; display: flex; flex-direction: column; gap: 12px; }
        .about-us-features li { display: flex; align-items: center; gap: 10px; font-size: 13.5px; font-weight: 600; color: var(--text-main); }
        .about-us-features li i { color: var(--accent-green); font-size: 14px; background: rgba(16,185,129,0.15); width: 26px; height: 26px; border-radius: 8px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        
        .about-us-stats { display: flex; gap: 15px; margin-top: 24px; padding-top: 20px; border-top: 1px solid var(--border-color); flex-wrap: wrap; }
        .about-badge-pill { background: rgba(56,189,248,0.1); border: 1px solid rgba(56,189,248,0.3); color: var(--accent-blue); padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; display: inline-flex; align-items: center; gap: 6px; }

        @media (max-width: 900px) {
            .about-us-section { grid-template-columns: 1fr; padding: 0; gap: 30px; }
            .about-us-video-wrap { height: 280px; }
        }

        /* 🌟 TOURNAMENT SHOWCASE GALLERY */
        .images-showcase-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 45px; }
        @media (max-width: 900px) { .images-showcase-grid { grid-template-columns: 1fr; } }
        .image-showcase-card {
            background: var(--bg-card); 
            border: 1.5px solid var(--border-color); 
            border-radius: 20px; 
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: auto;                     
            box-shadow: 0 15px 35px rgba(0,0,0,0.4); 
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        
        .image-showcase-card:not(.rotate-card):hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-blue);
            box-shadow: 0 25px 50px rgba(56, 189, 248, 0.35);
        }

        .image-showcase-card.rotate-card:hover {
            transform: rotate(360deg) scale(1.02);
            border-color: var(--accent-blue);
            box-shadow: 0 25px 50px rgba(56, 189, 248, 0.35);
            transition: transform 0.8s ease, box-shadow 0.4s ease, border-color 0.4s ease;
        }

        .image-showcase-body { 
            padding: 16px 18px 12px 18px; 
            background: var(--bg-card);
            flex-shrink: 0;
        }
        .image-showcase-body h5 { margin: 0 0 3px 0; font-size: 15px; font-weight: 800; color: var(--text-main); }
        .image-showcase-body p { margin: 0; font-size: 11.5px; color: var(--text-muted); line-height: 1.4; }
        
        .image-showcase-wrapper { 
            width: 100%;
            height: 240px !important;
            background: #030712; 
            margin: 0;
            padding: 0;
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
        }
        .image-showcase-wrapper img {
            width: 100% !important; 
            height: 100% !important;                     
            object-fit: cover !important;              
            display: block;
        }

        /* 🌟 VIDEO HIGHLIGHTS CARDS */
        .video-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-top: 25px; margin-bottom: 60px; }
        @media(max-width: 900px) { .video-grid { grid-template-columns: 1fr; } }
        
        .video-card-item { 
            background: var(--bg-card); 
            border: 1.5px solid var(--border-color); 
            border-radius: 20px; 
            overflow: hidden;
            display: grid;
            grid-template-rows: auto 1fr;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5); 
            cursor: pointer;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .video-card-item:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-blue);
            box-shadow: 0 25px 50px rgba(56, 189, 248, 0.35);
        }
        
        .video-content-top { 
            padding: 14px 18px 10px 18px; 
            background: var(--bg-card); 
        }
        .video-content-top h4 { margin: 0 0 2px 0; font-size: 15px; font-weight: 800; color: var(--accent-blue); }
        .video-content-top p { margin: 0; font-size: 11.5px; color: var(--text-muted); font-weight: 600; }
        
        .video-thumb-wrapper { 
            width: 100%;
            aspect-ratio: 16 / 9;
            background: #000; 
            position: relative; 
            overflow: hidden; 
            border-top: 1px solid var(--border-color);
        }
        .video-thumb-wrapper img { 
            position: absolute; 
            top: 0; 
            left: 0;
            width: 100%; 
            height: 100%; 
            object-fit: cover; 
            object-position: center;
            display: block;
        }
        .play-btn-overlay { 
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); 
            background: rgba(56, 189, 248, 0.9); color: #030712; width: 46px; height: 46px; 
            border-radius: 50%; display: flex; align-items: center; justify-content: center; 
            font-size: 18px; box-shadow: 0 0 25px rgba(56, 189, 248, 0.8); transition: all 0.3s ease; 
            z-index: 2;
        }
        .video-card-item:hover .play-btn-overlay { transform: translate(-50%, -50%) scale(1.12); background: var(--neon-emerald); }

        /* 🌟 VIDEO POPUP MODAL (YouTube Extras Hidden) */
        .video-modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(3, 7, 18, 0.92); backdrop-filter: blur(12px); align-items: center; justify-content: center; padding: 20px; box-sizing: border-box; }
        .video-modal-content { background: #0d1223; border: 1.5px solid var(--border-color); border-radius: 20px; width: 100%; max-width: 850px; padding: 25px; position: relative; box-shadow: 0 25px 60px rgba(0,0,0,0.8); box-sizing: border-box; }
        .close-modal { position: absolute; top: 14px; right: 20px; color: var(--text-muted); font-size: 28px; font-weight: 800; cursor: pointer; transition: 0.2s; z-index: 10; }
        .close-modal:hover { color: var(--accent-red); }
        
        .video-player-box {
            position: relative; width: 100%; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; background: #000;
        }
        .video-player-box iframe {
            position: absolute; top: -15%; left: 0; width: 100%; height: 130%; border: 0; pointer-events: auto;
        }
        .yt-cover-top {
            position: absolute; top: 0; left: 0; width: 100%; height: 60px; z-index: 5; pointer-events: auto; background: transparent;
        }
        .yt-cover-bottom {
            position: absolute; bottom: 0; left: 0; width: 100%; height: 60px; z-index: 5; pointer-events: auto; background: transparent;
        }

        /* TOP PERFORMERS LEADERBOARD */
        .performers-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 45px; }
        @media (max-width: 1024px) { .performers-grid { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 576px) { .performers-grid { grid-template-columns: 1fr; } }
        .performer-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px;
            padding: 24px 18px; text-align: center; position: relative; overflow: hidden;
            box-shadow: 0 12px 30px rgba(0,0,0,0.35); transition: all 0.3s ease;
        }
        .performer-card:hover { transform: translateY(-6px); border-color: var(--accent-amber); box-shadow: 0 20px 40px rgba(245,158,11,0.2); }
        .performer-rank {
            position: absolute; top: 12px; left: 12px; width: 26px; height: 26px; border-radius: 50%;
            background: rgba(245, 158, 11, 0.15); color: var(--accent-amber); font-size: 12px; font-weight: 900;
            display: flex; align-items: center; justify-content: center;
        }
        .performer-avatar {
            width: 64px; height: 64px; border-radius: 50%; margin: 10px auto 14px auto;
            background: linear-gradient(135deg, var(--accent-blue), #0284c7); color: #030712;
            display: flex; align-items: center; justify-content: center; font-size: 22px; font-weight: 900;
            box-shadow: 0 0 20px rgba(56,189,248,0.4);
        }
        .performer-name { font-size: 14px; font-weight: 800; color: var(--text-main); margin: 0 0 2px 0; }
        .performer-role { font-size: 11px; color: var(--accent-blue); font-weight: 600; margin: 0 0 12px 0; text-transform: uppercase; letter-spacing: 0.5px; }
        .performer-stat { font-size: 20px; font-weight: 900; color: var(--accent-green); margin: 0; }
        .performer-stat-label { font-size: 10.5px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }

        /* CTA BANNER */
        .cta-banner {
            position: relative; overflow: hidden;
            background: linear-gradient(135deg, #0284c7 0%, #0f172a 60%, #030712 100%);
            border-radius: 26px; padding: 55px 50px; margin-bottom: 45px;
            display: flex; align-items: center; justify-content: space-between; gap: 30px; flex-wrap: wrap;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        }
        .cta-banner-text { position: relative; z-index: 2; max-width: 550px; flex: 1; }
        .cta-banner-text h2 { font-size: 28px; font-weight: 900; color: #fff; margin: 0 0 10px 0; }
        .cta-banner-text p { font-size: 14px; color: rgba(255,255,255,0.8); margin: 0; line-height: 1.6; }
        .cta-banner .btn-cta-white {
            position: relative; z-index: 2; background: #fff; color: #030712; border: none;
            padding: 14px 30px; border-radius: 14px; font-weight: 800; font-size: 13.5px;
            text-decoration: none; display: inline-flex; align-items: center; gap: 8px;
            text-transform: uppercase; white-space: nowrap; transition: all 0.3s ease;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .cta-banner .btn-cta-white:hover { transform: translateY(-3px); color: #030712; box-shadow: 0 15px 30px rgba(0,0,0,0.4); }

        /* GET THE APP SECTION */
        .get-app-section {
            display: grid; grid-template-columns: 1.2fr 0.8fr; gap: 50px; align-items: center;
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.95), rgba(20, 28, 48, 0.9));
            border: 1.5px solid var(--border-color); border-radius: 28px;
            padding: 50px; margin-bottom: 45px; box-shadow: 0 20px 45px rgba(0,0,0,0.45);
        }
        @media (max-width: 900px) { .get-app-section { grid-template-columns: 1fr; padding: 30px; } }
        .get-app-text h2 { font-size: 32px; font-weight: 900; margin: 0 0 14px 0; color: var(--text-main); }
        .get-app-text h2 span { color: var(--accent-blue); }
        .get-app-text > p { font-size: 14px; color: var(--text-muted); line-height: 1.7; margin: 0 0 22px 0; max-width: 460px; }
        .get-app-features { list-style: none; margin: 0 0 26px 0; padding: 0; display: flex; flex-direction: column; gap: 12px; }
        .get-app-features li { display: flex; align-items: center; gap: 12px; font-size: 14px; font-weight: 600; color: var(--text-main); }
        .get-app-features li .dot-marker { width: 8px; height: 8px; border-radius: 50%; background: var(--accent-blue); box-shadow: 0 0 8px var(--accent-blue); flex-shrink: 0; }
        .get-app-available { font-size: 11px; font-weight: 800; color: var(--text-muted); letter-spacing: 1px; text-transform: uppercase; margin-bottom: 12px; }
        .store-badges { display: flex; gap: 14px; flex-wrap: wrap; }
        .store-badge {
            display: flex; align-items: center; gap: 10px; background: #0d121e; border: 1px solid var(--border-color);
            border-radius: 12px; padding: 10px 18px; text-decoration: none; transition: all 0.25s ease;
        }
        .store-badge:hover { border-color: var(--accent-blue); transform: translateY(-3px); box-shadow: 0 10px 20px rgba(56,189,248,0.2); }
        .store-badge i { font-size: 24px; color: var(--text-main); }
        .store-badge .store-badge-text { display: flex; flex-direction: column; line-height: 1.2; }
        .store-badge .store-badge-text small { font-size: 9.5px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }
        .store-badge .store-badge-text strong { font-size: 14px; color: var(--text-main); font-weight: 800; }

        .qr-card {
            background: #f8fafc; border-radius: 24px; padding: 32px; text-align: center;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4); position: relative; width: 100%; max-width: 320px; margin: 0 auto; box-sizing: border-box;
        }
        .qr-frame {
            border: 2px dashed var(--accent-blue); border-radius: 18px; padding: 16px;
            display: inline-flex; align-items: center; justify-content: center; margin-bottom: 14px;
            position: relative; animation: qrPulse 3s ease-in-out infinite; overflow: hidden;
        }
        @keyframes qrPulse {
            0%, 100% { border-color: rgba(56,189,248,0.5); box-shadow: 0 0 10px rgba(56,189,248,0.2); transform: scale(1); }
            50% { border-color: rgba(16,185,129,0.9); box-shadow: 0 0 25px rgba(16,185,129,0.4); transform: scale(1.02); }
        }
        .qr-svg { width: 100%; max-width: 170px; height: auto; fill: #030712; }
        .qr-card .scan-label { font-size: 13px; color: #64748b; margin: 0 0 2px 0; }
        .qr-card .scan-title { font-size: 16px; font-weight: 900; color: var(--accent-blue); margin: 0 0 6px 0; }
        .qr-hourly-badge {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.4);
            color: #059669; font-size: 11px; font-weight: 800; padding: 4px 12px; border-radius: 20px;
        }
        .qr-hourly-badge .hour-dot { width: 6px; height: 6px; border-radius: 50%; background: #059669; animation: pulseDot 1s infinite; }

        /* TESTIMONIALS SECTION */
        .testimonial-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 45px; }
        @media (max-width: 900px) { .testimonial-grid { grid-template-columns: 1fr; } }
        .testimonial-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px;
            padding: 26px; box-shadow: 0 15px 35px rgba(0,0,0,0.4); transition: all 0.3s ease; position: relative;
        }
        .testimonial-card:hover { transform: translateY(-6px); border-color: var(--accent-blue); box-shadow: 0 20px 40px rgba(56,189,248,0.2); }
        .testimonial-card .quote-icon { color: var(--accent-blue); font-size: 22px; opacity: 0.5; margin-bottom: 10px; }
        .testimonial-card p.quote-text { font-size: 13.5px; color: var(--text-muted); line-height: 1.7; margin: 0 0 18px 0; }
        .testimonial-person { display: flex; align-items: center; gap: 12px; }
        .testimonial-avatar { width: 42px; height: 42px; border-radius: 50%; background: var(--accent-blue); color: #030712; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 14px; flex-shrink: 0; }
        .testimonial-name { font-size: 13.5px; font-weight: 800; color: var(--text-main); margin: 0; }
        .testimonial-role { font-size: 11.5px; color: var(--accent-blue); margin: 0; font-weight: 600; }
        .testimonial-stars { color: var(--accent-amber); font-size: 11px; margin-top: 4px; }

        /* SPONSORS STRIP */
        .sponsors-strip {
            display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 25px;
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px;
            padding: 30px 40px; margin-bottom: 45px; box-shadow: 0 15px 35px rgba(0,0,0,0.35);
        }
        .sponsor-item { display: flex; align-items: center; gap: 10px; color: var(--text-muted); font-weight: 800; font-size: 15px; opacity: 0.7; transition: all 0.25s; letter-spacing: 0.5px; }
        .sponsor-item i { font-size: 20px; color: var(--accent-blue); }
        .sponsor-item:hover { opacity: 1; color: var(--text-main); transform: scale(1.05); }

        @media (max-width: 900px) {
            .sponsors-strip { justify-content: center; }
        }

        /* GRAND FOOTER (Original untouched) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); }
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
    </style>

    <!-- EXTRA CSS FOR NEW SECTIONS -->
    <style>
        .image-showcase-wrapper { height: 240px !important; flex-grow: 0 !important; overflow: hidden; }
        .image-showcase-wrapper img {
            width: 100% !important; height: 100% !important; max-height: none !important;
            object-fit: cover !important; object-position: center; padding: 0 !important;
        }

        .about-us-video-wrap video { pointer-events: none; }
        .about-us-video-wrap video::-webkit-media-controls,
        .about-us-video-wrap video::-webkit-media-controls-enclosure,
        .about-us-video-wrap video::-webkit-media-controls-panel {
            display: none !important; opacity: 0 !important;
        }

        .nx-grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 45px; }
        .nx-grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 22px; margin-bottom: 45px; }
        .nx-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px;
            padding: 24px; box-shadow: 0 15px 35px rgba(0,0,0,0.4); transition: all 0.3s ease;
        }
        .nx-card:hover { transform: translateY(-6px); border-color: var(--accent-blue); box-shadow: 0 20px 40px rgba(56,189,248,0.2); }
        .nx-tag {
            display: inline-block; font-size: 10.5px; font-weight: 800; letter-spacing: 1px; text-transform: uppercase;
            color: var(--accent-green); background: rgba(16,185,129,0.15); border: 1.5px solid rgba(16,185,129,0.35);
            padding: 3px 10px; border-radius: 12px; margin-bottom: 12px;
        }
        .nx-card h5 { font-size: 16px; font-weight: 800; color: var(--text-main); margin: 0 0 8px 0; }
        .nx-card p { font-size: 13px; color: var(--text-muted); line-height: 1.6; margin: 0; }
        .nx-date { font-size: 11.5px; color: var(--accent-blue); font-weight: 700; margin-top: 12px; display: block; }
        .nx-fixture-teams { display: flex; justify-content: space-between; align-items: center; gap: 10px; margin: 6px 0 14px 0; }
        .nx-team { font-size: 14px; font-weight: 800; color: var(--text-main); text-align: center; flex: 1; }
        .nx-vs {
            width: 38px; height: 38px; border-radius: 50%; background: rgba(56,189,248,0.15);
            border: 1px solid rgba(56,189,248,0.4); color: var(--accent-blue); font-weight: 900; font-size: 12px;
            display: flex; align-items: center; justify-content: center; flex-shrink: 0;
        }
        .nx-fixture-meta { display: flex; justify-content: space-between; font-size: 11.5px; color: var(--text-muted); border-top: 1px solid var(--border-color); padding-top: 12px; }
        .nx-fixture-meta i { color: var(--accent-blue); margin-right: 5px; }
        .nx-why { text-align: center; }
        .nx-why .nx-icon {
            width: 56px; height: 56px; border-radius: 16px; margin: 0 auto 14px auto;
            background: rgba(56,189,248,0.15); border: 1.5px solid rgba(56,189,248,0.3);
            display: flex; align-items: center; justify-content: center; font-size: 22px; color: var(--accent-blue);
        }
        .nx-faq { display: flex; flex-direction: column; gap: 14px; margin-bottom: 45px; }
        .nx-faq details {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 16px;
            padding: 18px 22px; transition: border-color 0.25s;
        }
        .nx-faq details[open] { border-color: var(--accent-blue); }
        .nx-faq summary { cursor: pointer; font-size: 14.5px; font-weight: 700; color: var(--text-main); list-style: none; display: flex; justify-content: space-between; align-items: center; }
        .nx-faq summary::-webkit-details-marker { display: none; }
        .nx-faq summary::after { content: '+'; color: var(--accent-blue); font-size: 22px; font-weight: 800; }
        .nx-faq details[open] summary::after { content: '\2212'; }
        .nx-faq details p { margin: 12px 0 0 0; font-size: 13.5px; color: var(--text-muted); line-height: 1.7; }
        @media (max-width: 1024px) { .nx-grid-4 { grid-template-columns: repeat(2, 1fr); } }
        @media (max-width: 900px) { .nx-grid-3 { grid-template-columns: 1fr; } }
        @media (max-width: 600px) { .nx-grid-4 { grid-template-columns: 1fr; } }
    </style>

    <!-- 🌟 NEW CSS: ANIMATED HERO + SIGNUP BUTTON + JOURNEY SECTION -->
    <style>
        /* ---------- HERO: animated background layer ---------- */
        .hero-bg-anim { position: absolute; inset: 0; z-index: 1; pointer-events: none; overflow: hidden; border-radius: inherit; }
        .hero-bg-anim::before {
            content: ''; position: absolute; inset: -60px;
            background-image:
                linear-gradient(rgba(56,189,248,0.10) 1px, transparent 1px),
                linear-gradient(90deg, rgba(56,189,248,0.10) 1px, transparent 1px);
            background-size: 46px 46px;
            -webkit-mask-image: radial-gradient(ellipse at center, #000 30%, transparent 80%);
            mask-image: radial-gradient(ellipse at center, #000 30%, transparent 80%);
            animation: heroGridMove 14s linear infinite;
        }
        @keyframes heroGridMove { 0% { transform: translate(0,0); } 100% { transform: translate(46px,46px); } }

        .hero-ball {
            position: absolute; border-radius: 50%;
            background: radial-gradient(circle at 30% 28%, #ff8fa3 0%, #e11d48 52%, #7f1d1d 100%);
            box-shadow: 0 0 22px rgba(244,63,94,0.45), inset -4px -5px 10px rgba(0,0,0,0.35);
            opacity: 0.6; animation: heroBallFloat var(--d, 9s) ease-in-out infinite; animation-delay: var(--dl, 0s);
        }
        .hero-ball::after {
            content: ''; position: absolute; inset: 0; border-radius: 50%;
            border-top: 2px dashed rgba(255,255,255,0.65); border-bottom: 2px dashed rgba(255,255,255,0.65);
            transform: rotate(25deg) scaleX(0.55);
        }
        .hero-ball.b1 { width: 38px; height: 38px; top: 14%; left: 44%; --d: 9s; }
        .hero-ball.b2 { width: 22px; height: 22px; top: 70%; left: 36%; --d: 11s; --dl: -3s; }
        .hero-ball.b3 { width: 52px; height: 52px; top: 62%; left: 4%; --d: 13s; --dl: -6s; opacity: 0.35; }
        .hero-ball.b4 { width: 18px; height: 18px; top: 18%; left: 8%; --d: 8s; --dl: -2s; }
        .hero-ball.b5 { width: 30px; height: 30px; top: 8%; right: 6%; --d: 10s; --dl: -5s; opacity: 0.45; }
        @keyframes heroBallFloat {
            0%, 100% { transform: translate(0,0) rotate(0deg); }
            25% { transform: translate(16px,-26px) rotate(90deg); }
            50% { transform: translate(-10px,-42px) rotate(180deg); }
            75% { transform: translate(-20px,-16px) rotate(270deg); }
        }

        .hero-ring {
            position: absolute; border-radius: 50%; border: 2px solid rgba(56,189,248,0.35);
            width: 120px; height: 120px; animation: heroRingPulse 5s ease-out infinite;
        }
        .hero-ring.r1 { top: 52%; left: 52%; }
        .hero-ring.r2 { top: 6%; left: 24%; animation-delay: -2.5s; border-color: rgba(16,185,129,0.4); }
        @keyframes heroRingPulse { 0% { transform: scale(0.3); opacity: 0.9; } 100% { transform: scale(2.6); opacity: 0; } }

        .hero-streak {
            position: absolute; height: 2px; width: 160px; left: -200px;
            background: linear-gradient(90deg, transparent, rgba(56,189,248,0.85), transparent);
            animation: heroStreak 6s linear infinite;
        }
        .hero-streak.s1 { top: 26%; }
        .hero-streak.s2 { top: 58%; animation-delay: -2s; animation-duration: 7.5s; }
        .hero-streak.s3 { top: 84%; animation-delay: -4s; animation-duration: 5.5s; background: linear-gradient(90deg, transparent, rgba(16,185,129,0.85), transparent); }
        @keyframes heroStreak { 0% { transform: translateX(0); } 100% { transform: translateX(160vw); } }

        /* Existing hero elements (orbs, particles, ball icon) - animations */
        .hero-glow-orb {
            position: absolute; z-index: 1; width: 260px; height: 260px; border-radius: 50%; pointer-events: none;
            top: -80px; right: 25%; filter: blur(50px);
            background: radial-gradient(circle, rgba(56,189,248,0.38), transparent 70%);
            animation: orbDrift 10s ease-in-out infinite;
        }
        .hero-glow-orb.orb-2 {
            top: auto; right: auto; bottom: -90px; left: 12%;
            background: radial-gradient(circle, rgba(16,185,129,0.34), transparent 70%);
            animation-duration: 13s; animation-delay: -4s;
        }
        @keyframes orbDrift { 0%,100% { transform: translate(0,0) scale(1); } 50% { transform: translate(40px,30px) scale(1.2); } }

        .particle {
            position: absolute; bottom: -10px; width: 5px; height: 5px; border-radius: 50%; z-index: 1;
            background: var(--accent-blue); box-shadow: 0 0 10px var(--accent-blue); opacity: 0;
            animation: particleRise 5s ease-in infinite;
        }
        .particle.p1 { left: 12%; animation-delay: 0s; }
        .particle.p2 { left: 30%; animation-delay: 1s; background: var(--accent-green); box-shadow: 0 0 10px var(--accent-green); }
        .particle.p3 { left: 52%; animation-delay: 2s; }
        .particle.p4 { left: 72%; animation-delay: 3s; background: var(--accent-green); box-shadow: 0 0 10px var(--accent-green); }
        .particle.p5 { left: 90%; animation-delay: 4s; }
        @keyframes particleRise { 0% { transform: translateY(0); opacity: 0; } 15% { opacity: 1; } 100% { transform: translateY(-200px); opacity: 0; } }

        .cricket-ball-icon {
            position: absolute; top: 8px; right: 12px; z-index: 2; font-size: 20px;
            animation: ballBounce 2.4s ease-in-out infinite;
        }
        @keyframes ballBounce { 0%,100% { transform: translateY(0) rotate(0); } 50% { transform: translateY(-8px) rotate(180deg); } }

        .hero-stadium-art { animation: stadiumGlow 4s ease-in-out infinite; }
        @keyframes stadiumGlow {
            0%,100% { box-shadow: 0 15px 35px rgba(16,185,129,0.3); }
            50% { box-shadow: 0 15px 50px rgba(56,189,248,0.55); }
        }
        .live-scoreboard .scoreboard-progress-bar { animation: barPulse 3s ease-in-out infinite; }
        @keyframes barPulse { 0%,100% { width: 82%; } 50% { width: 88%; } }

        /* Hero text polish */
        .hero-content h1 {
            background: linear-gradient(90deg, var(--text-main), var(--accent-blue), var(--accent-green), var(--text-main));
            background-size: 300% 100%;
            -webkit-background-clip: text; background-clip: text;
            -webkit-text-fill-color: transparent; text-shadow: none;
            animation: heroTextFlow 8s linear infinite;
        }
        @keyframes heroTextFlow { 0% { background-position: 0% 50%; } 100% { background-position: 300% 50%; } }

        .hero-content > div:not([class]) { display: flex; flex-wrap: wrap; gap: 12px; align-items: center; }
        .btn-signup-outline {
            background: transparent; color: var(--accent-green); border: 2px solid var(--accent-green);
            padding: 10px 22px; border-radius: 14px; font-weight: 800; font-size: 13px; text-decoration: none;
            display: inline-flex; align-items: center; gap: 8px; text-transform: uppercase; white-space: nowrap;
            transition: all 0.3s ease; z-index: 2; position: relative;
            animation: signupPulse 2.6s ease-in-out infinite;
        }
        .btn-signup-outline:hover { background: var(--accent-green); color: #030712; transform: translateY(-3px); }
        body.light-mode .btn-signup-outline:hover { color: #ffffff; }
        @keyframes signupPulse {
            0%,100% { box-shadow: 0 0 0 0 rgba(16,185,129,0.45); }
            50% { box-shadow: 0 0 0 9px rgba(16,185,129,0); }
        }

        .hero-chips { display: flex; flex-wrap: wrap; gap: 10px; margin-top: 20px; }
        .hero-chip {
            display: inline-flex; align-items: center; gap: 6px; font-size: 11.5px; font-weight: 700;
            color: var(--accent-blue); background: rgba(56,189,248,0.10); border: 1px solid rgba(56,189,248,0.30);
            padding: 5px 12px; border-radius: 20px;
        }
        .hero-chip i { color: var(--accent-green); }

        @media (max-width: 768px) {
            .hero-banner { padding: 30px 20px; gap: 22px; border-radius: 22px; }
            .hero-content { min-width: 0; width: 100%; }
            .hero-content p { margin-bottom: 18px; }
            .hero-content > div:not([class]) { flex-direction: column; align-items: stretch; }
            .btn-custom-glow, .btn-signup-outline { justify-content: center; width: 100%; box-sizing: border-box; }
            .hero-stadium-art { width: 100%; }
            .hero-ball.b1 { left: 70%; }
            .hero-ball.b3 { display: none; }
        }
        @media (max-width: 400px) { .live-scoreboard { padding: 12px 12px; } .team-row { font-size: 12.5px; } }

        /* ---------- NEW SECTION: TOURNAMENT JOURNEY ---------- */
        .jr-wrap { position: relative; display: grid; grid-template-columns: repeat(5, 1fr); gap: 22px; margin-bottom: 25px; padding-top: 6px; }
        .jr-line { position: absolute; top: 36px; left: 10%; right: 10%; height: 3px; background: var(--border-color); border-radius: 3px; overflow: hidden; z-index: 0; }
        .jr-line-fill {
            width: 100%; height: 100%; transform: scaleX(0); transform-origin: left center;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-green), var(--accent-amber));
            transition: transform 2.2s ease;
        }
        .jr-wrap.in-view .jr-line-fill { transform: scaleX(1); }
        .jr-step { position: relative; z-index: 1; display: flex; flex-direction: column; align-items: center; text-align: center; opacity: 0; transform: translateY(30px); transition: opacity 0.7s ease, transform 0.7s ease; transition-delay: calc(var(--i) * 0.25s); }
        .jr-wrap.in-view .jr-step { opacity: 1; transform: translateY(0); }
        .jr-node {
            width: 62px; height: 62px; border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 22px; color: #030712; margin-bottom: 16px; flex-shrink: 0;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-green));
            box-shadow: 0 0 0 6px rgba(56,189,248,0.15), 0 10px 25px rgba(56,189,248,0.35);
            animation: nodePulse 3s ease-in-out infinite; animation-delay: calc(var(--i) * 0.4s);
        }
        body.light-mode .jr-node { color: #ffffff; }
        @keyframes nodePulse {
            0%,100% { box-shadow: 0 0 0 6px rgba(56,189,248,0.15), 0 10px 25px rgba(56,189,248,0.35); }
            50% { box-shadow: 0 0 0 12px rgba(16,185,129,0.10), 0 10px 30px rgba(16,185,129,0.45); }
        }
        .jr-card {
            width: 100%; box-sizing: border-box; background: var(--bg-card); border: 1.5px solid var(--border-color);
            border-radius: 18px; padding: 18px 14px; box-shadow: 0 12px 30px rgba(0,0,0,0.3); transition: all 0.3s ease;
        }
        .jr-card:hover { transform: translateY(-6px); border-color: var(--accent-blue); box-shadow: 0 18px 38px rgba(56,189,248,0.22); }
        .jr-num { display: inline-block; font-size: 10px; font-weight: 800; letter-spacing: 1.2px; color: var(--accent-amber); margin-bottom: 6px; }
        .jr-card h5 { font-size: 15px; font-weight: 800; color: var(--text-main); margin: 0 0 6px 0; }
        .jr-card p { font-size: 12.5px; color: var(--text-muted); line-height: 1.55; margin: 0; }
        .jr-cta { text-align: center; margin-bottom: 45px; }

        @media (max-width: 900px) {
            .jr-wrap { grid-template-columns: 1fr; gap: 18px; }
            .jr-line { top: 30px; bottom: 30px; left: 30px; right: auto; width: 3px; height: auto; }
            .jr-line-fill { transform: scaleY(0); transform-origin: center top; }
            .jr-wrap.in-view .jr-line-fill { transform: scaleY(1); }
            .jr-step { flex-direction: row; align-items: flex-start; text-align: left; gap: 16px; }
            .jr-node { width: 60px; height: 60px; margin-bottom: 0; }
            .jr-card { flex: 1; min-width: 0; }
        }

        @media (prefers-reduced-motion: reduce) {
            .hero-ball, .hero-ring, .hero-streak, .particle, .hero-glow-orb, .hero-bg-anim::before, .jr-node { animation: none !important; }
        }
    </style>

    <!-- 🌟 NEW: DARK + LIGHT MODE SYSTEM (same method as teams.jsp) - all text visible in both modes -->
    <style>
        :root {
            --pm-hero-bg: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            --pm-pod-bg: rgba(3, 7, 18, 0.7);
            --pm-pod-hover-bg: rgba(20, 26, 40, 0.95);
            --pm-card-grad: linear-gradient(135deg, rgba(13, 18, 30, 0.9), rgba(20, 28, 48, 0.95));
            --pm-app-grad: linear-gradient(135deg, rgba(13, 18, 30, 0.95), rgba(20, 28, 48, 0.9));
            --pm-chip-bg: #0d121e;
            --pm-img-bg: #030712;
            --pm-modal-bg: #0d1223;
            --pm-newsletter-bg: rgba(3, 7, 18, 0.7);
            --pm-footer-bg: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
            --pm-on-accent: #030712;
            --pm-shadow: rgba(0, 0, 0, 0.4);
        }

        /* Light mode - jo bhi toggle method use ho, sab cover hai */
        :root[data-theme="light"], :root[data-bs-theme="light"], :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
        body[data-theme="light"], body[data-bs-theme="light"], body.light, body.light-mode, body.light-theme, body.theme-light {
            --bg-main: #f1f5f9;
            --bg-card: rgba(255, 255, 255, 0.94);
            --bg-card-hover: rgba(241, 245, 249, 0.98);
            --accent-red: #e11d48;
            --accent-green: #059669;
            --accent-blue: #0284c7;
            --accent-amber: #d97706;
            --text-main: #0f172a;
            --text-muted: #475569;
            --border-color: #cbd5e1;
            --neon-cyan: #0099cc;
            --neon-emerald: #00aa44;
            --border-glass: rgba(0, 153, 204, 0.25);
            --text-primary: #1a2550;
            --text-secondary: #556688;
            --pm-hero-bg: linear-gradient(135deg, #e0f2fe 0%, #f0fdf4 55%, #ffffff 100%);
            --pm-pod-bg: #ffffff;
            --pm-pod-hover-bg: #e0f2fe;
            --pm-card-grad: linear-gradient(135deg, #ffffff, #f1f5f9);
            --pm-app-grad: linear-gradient(135deg, #ffffff, #e0f2fe);
            --pm-chip-bg: #ffffff;
            --pm-img-bg: #e2e8f0;
            --pm-modal-bg: #ffffff;
            --pm-newsletter-bg: #ffffff;
            --pm-footer-bg: linear-gradient(135deg, #ffffff, #e0f2fe);
            --pm-on-accent: #ffffff;
            --pm-shadow: rgba(15, 23, 42, 0.15);
        }

        /* Hardcoded dark backgrounds ab variables se chalenge */
        .hero-banner { background: var(--pm-hero-bg); }
        .quick-nav-item { background: var(--pm-pod-bg); color: var(--text-main); }
        .quick-nav-item:hover { background: var(--pm-pod-hover-bg); color: var(--accent-blue); }
        .about-card { background: var(--pm-card-grad); }
        .get-app-section { background: var(--pm-app-grad); }
        .store-badge { background: var(--pm-chip-bg); }
        .image-showcase-wrapper { background: var(--pm-img-bg); }
        .video-modal-content { background: var(--pm-modal-bg); }
        .grand-footer-section { background: var(--pm-footer-bg); }
        .footer-newsletter input { background: var(--pm-newsletter-bg); color: var(--text-primary); }
        .footer-newsletter input::placeholder { color: var(--text-secondary); opacity: 0.8; }
        .live-scoreboard .scoreboard-footer { color: #cbd5e1; }
        .jr-node { color: var(--pm-on-accent); }
        .hero-banner, .about-card, .get-app-section { box-shadow: 0 15px 40px var(--pm-shadow); }
        .nx-faq summary, .jr-card h5, .nx-card h5, .video-content-top, .video-content-top h4 { color: inherit; }
        .nx-faq summary, .jr-card h5, .nx-card h5 { color: var(--text-main); }
        .video-content-top h4 { color: var(--accent-blue); }
        img, video { max-width: 100%; }
    </style>

    <!-- 🌟 FIX 1: ALL TEXT VISIBLE (dark + light) - navbar / footer / cards -->
    <style>
        body { background: var(--bg-main) !important; color: var(--text-main); }

        /* FOOTER newsletter input + Join button */
        body:not(.light-mode) .footer-newsletter input {
            background: rgba(3, 7, 18, 0.7) !important; color: #f0f4ff !important; border-color: rgba(0,217,255,0.25) !important;
        }
        body.light-mode .footer-newsletter input {
            background: #ffffff !important; color: #0f172a !important; border: 1.5px solid #cbd5e1 !important;
        }
        body.light-mode .footer-newsletter input::placeholder { color: #64748b !important; opacity: 1; }
        body:not(.light-mode) .footer-newsletter input::placeholder { color: #a8b8d8 !important; opacity: 1; }
        .footer-newsletter button { color: #030712 !important; white-space: nowrap; }
        body.light-mode .footer-newsletter button { color: #ffffff !important; }
        @media (max-width: 400px) { .footer-newsletter form { flex-direction: column; } .footer-newsletter button { width: 100%; } }

        /* LIGHT MODE: hardcoded dark cards ke text fix */
        body.light-mode .grand-footer-section { border-top-color: #0099cc; box-shadow: 0 -10px 30px rgba(15,23,42,0.12); }
        body.light-mode .footer-brand h3,
        body.light-mode .footer-brand p,
        body.light-mode .footer-links a,
        body.light-mode .footer-newsletter p,
        body.light-mode .footer-bottom-bar,
        body.light-mode .footer-bottom-links a { color: #334155 !important; }
        body.light-mode .footer-links h4,
        body.light-mode .footer-newsletter h4,
        body.light-mode .footer-brand h3 span { color: #0284c7 !important; text-shadow: none; }
        body.light-mode .store-badge i,
        body.light-mode .store-badge .store-badge-text strong { color: #0f172a; }
        body.light-mode .store-badge .store-badge-text small { color: #475569; }
        body.light-mode .quick-nav-item { color: #0f172a; }
        body.light-mode .quick-nav-item:hover { color: #0284c7; }
        body.light-mode .live-scoreboard { background: rgba(255,255,255,0.9); }
        body.light-mode .live-scoreboard .team-row { color: #0f172a; }
        body.light-mode .live-scoreboard .scoreboard-footer { color: #475569; }
        body.light-mode .hero-banner::before { background: radial-gradient(circle, rgba(2,132,199,0.10) 0%, rgba(5,150,105,0.06) 35%, transparent 70%); }
        body.light-mode .about-card,
        body.light-mode .get-app-section { border-color: #cbd5e1; }
        body.light-mode .performer-avatar,
        body.light-mode .testimonial-avatar { color: #ffffff; }
        body.light-mode .video-content-top h4 { color: #0284c7; }
        body.light-mode .section-title { color: #0f172a; }
        body.light-mode .close-modal { color: #475569; }
        body.light-mode .video-modal { background: rgba(15, 23, 42, 0.8); }
        body.light-mode .video-modal-content h4 { color: #0284c7 !important; }
        body.light-mode .cta-banner {
            background: linear-gradient(135deg, #e0f2fe 0%, #bae6fd 55%, #ffffff 100%);
            border: 1.5px solid #cbd5e1; box-shadow: 0 20px 40px rgba(15,23,42,0.12);
        }
        body.light-mode .cta-banner-text h2 { color: #0f172a; }
        body.light-mode .cta-banner-text p { color: #334155; }
        body.light-mode .cta-banner .btn-cta-white { background: linear-gradient(135deg, #38bdf8, #0284c7); color: #ffffff; }
        body.light-mode .cta-banner .btn-cta-white:hover { color: #ffffff; }
    </style>

    <!-- 🌟 FIX 2: teams.jsp wala same method - nav + input + footer theme-aware -->
    <style>
        :root {
            --pm-nav-bg: #0d1222;
            --pm-input-bg: #030712;
            --pm-badge-bg: rgba(3, 7, 18, 0.8);
            --pm-nav-border: #1e294b;
        }
        :root[data-theme="light"], :root[data-bs-theme="light"],
        :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
        body[data-theme="light"], body[data-bs-theme="light"],
        body.light, body.light-mode, body.light-theme, body.theme-light {
            --pm-nav-bg: #ffffff;
            --pm-input-bg: #ffffff;
            --pm-badge-bg: rgba(255, 255, 255, 0.92);
            --pm-nav-border: #cbd5e1;
        }

        /* FOOTER input + Join button: dono modes mein visible */
        .grand-footer-section .footer-newsletter input {
            background: var(--pm-input-bg) !important;
            color: var(--text-primary) !important;
            border: 1.5px solid var(--border-glass) !important;
        }
        .grand-footer-section .footer-newsletter input::placeholder {
            color: var(--text-secondary) !important; opacity: 0.85;
        }
        .grand-footer-section .footer-newsletter button {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)) !important;
            color: var(--pm-on-accent) !important;
            white-space: nowrap;
        }

        /* MOBILE RESPONSIVE (teams.jsp jaisa) */
        img { max-width: 100%; }
        body { overflow-x: hidden; }
        @media (max-width: 768px) {
            .grand-footer-section { padding: 36px 20px 24px 20px; width: calc(100% - 24px); }
            .footer-newsletter form { flex-direction: column; }
            .footer-newsletter button { width: 100%; }
        }
    </style>

    <!-- Script to hide YouTube extras (logos, titles, captions, share buttons) -->
    <script>
        function getYouTubeId(url) {
            const m = url.match(/(?:youtu\.be\/|v=|embed\/|shorts\/)([\w-]{11})/);
            return m ? m[1] : null;
        }

        function openVideo(url) {
            const box = document.getElementById('videoPlayer');
            const id = getYouTubeId(url);
            document.getElementById('videoModal').style.display = 'flex';

            if (id) {
                box.innerHTML = `
                    <div class="video-player-box">
                        <div class="yt-cover-top"></div>
                        <div class="yt-cover-bottom"></div>
                        <iframe src="https://www.youtube-nocookie.com/embed/\${id}?autoplay=1&controls=0&modestbranding=1&rel=0&iv_load_policy=3&disablekb=1&cc_load_policy=0&fs=0" allow="autoplay"></iframe>
                    </div>
                `;
            } else {
                box.innerHTML = '<video src="' + url + '" controls autoplay playsinline style="width:100%;height:100%;"></video>';
            }
        }

        function closeVideo() {
            document.getElementById('videoPlayer').innerHTML = '';
            document.getElementById('videoModal').style.display = 'none';
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeVideo();
        });

        window.addEventListener('DOMContentLoaded', () => {
            const autoVid = document.getElementById('aboutAutoVideo');
            if (autoVid) {
                autoVid.play().catch(error => { console.log("Autoplay prevented:", error); });
            }
        });
    </script>
</head>
<body>

    <!-- STICKY TOP NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />
    <script>
        if (document.documentElement.getAttribute('data-theme') === 'light') document.body.classList.add('light-mode');
    </script>

    <div class="container">

        <!-- HERO BANNER -->
        <div class="hero-banner">
            <!-- 🌟 NEW: animated background layer -->
            <div class="hero-bg-anim" aria-hidden="true">
                <span class="hero-ring r1"></span>
                <span class="hero-ring r2"></span>
                <span class="hero-streak s1"></span>
                <span class="hero-streak s2"></span>
                <span class="hero-streak s3"></span>
                <span class="hero-ball b1"></span>
                <span class="hero-ball b2"></span>
                <span class="hero-ball b3"></span>
                <span class="hero-ball b4"></span>
                <span class="hero-ball b5"></span>
            </div>
            <div class="hero-glow-orb"></div>
            <div class="hero-glow-orb orb-2"></div>
            <div class="hero-content">
                <span class="season-tag">● Season 2026 • Live Matchday 24</span>
                <h1>Welcome back, ${not empty sessionScope.user.name ? sessionScope.user.name : 'Jitendra'}!</h1>
                <p>Register your tournament teams, analyze live match schedules, review comprehensive points tables, and manage rosters seamlessly.</p>
                <div>
                    <a href="${pageContext.request.contextPath}/register-team" class="btn-custom-glow">
                        <i class="fa-solid fa-shield-cat"></i> Register Team Now
                    </a>
                    <a href="${pageContext.request.contextPath}/register" class="btn-signup-outline">
                        <i class="fa-solid fa-user-plus"></i> Sign Up Free
                    </a>
                </div>
                <div class="hero-chips">
                    <span class="hero-chip"><i class="fa-solid fa-circle-check"></i> Free Sign Up</span>
                    <span class="hero-chip"><i class="fa-solid fa-bolt"></i> Live Scores</span>
                    <span class="hero-chip"><i class="fa-solid fa-calculator"></i> Auto NRR</span>
                </div>
            </div>
            <div class="hero-stadium-art">
                <div class="particle p1"></div>
                <div class="particle p2"></div>
                <div class="particle p3"></div>
                <div class="particle p4"></div>
                <div class="particle p5"></div>
                <div class="cricket-ball-icon">⚾</div>
                <div class="live-scoreboard">
                    <div class="scoreboard-header"><span class="live-dot"></span> Live Match</div>
                    <div class="team-row"><span>🛡️ Titans XI</span><span class="team-score">182/4</span></div>
                    <div class="team-row"><span>⚡ Strikers CC</span><span class="team-score">Yet to bat</span></div>
                    <div class="scoreboard-progress"><div class="scoreboard-progress-bar"></div></div>
                    <div class="scoreboard-footer"><span>Overs: 18.4/20</span><span>CRR: 9.75</span></div>
                </div>
            </div>
        </div>

        <!-- RUNNING TICKER -->
        <div class="running-ticker">
            <marquee behavior="scroll" direction="left" scrollamount="6">
                <span>⚡ Welcome to ProMatch Arena</span>&bull;&bull;&bull;<span>🏆 Season 2026 Live Matchdays Underway</span>&bull;&bull;&bull;<span>📊 Automated NRR & Tournament Control Center</span>&bull;&bull;&bull;<span>🚀 Register your teams and squads today!</span>
            </marquee>
        </div>

        <!-- STATS WIDGETS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-trophy"></i></div>
                <div>
                    <h4>Active Tournaments</h4>
                    <p class="val">Championship Cup <span class="live-badge-mini">Live</span></p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-shield-halved"></i></div>
                <div>
                    <h4>Registered Clubs</h4>
                    <p class="val">Elite Squads Active</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-bolt"></i></div>
                <div>
                    <h4>Season Fixtures</h4>
                    <p class="val">Scheduled Matches</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-tower-broadcast"></i></div>
                <div>
                    <h4>Matchday Status</h4>
                    <p class="val" style="color: var(--accent-green);">Round 24 Active</p>
                </div>
            </div>
        </div>

        <!-- QUICK NAVIGATION HUB -->
        <div class="card-box">
            <h3><i class="fa-solid fa-compass" style="color: var(--accent-blue);"></i> Quick Navigation & Tournament Hub</h3>
            <div class="quick-nav-grid">
                <a href="${pageContext.request.contextPath}/register-team" class="quick-nav-item">
                    <i class="fa-solid fa-shield-halved"></i> Register Team
                </a>
                <a href="/teams" class="quick-nav-item">
                    <i class="fa-solid fa-users"></i> View Teams
                </a>
                <a href="/tournaments" class="quick-nav-item">
                    <i class="fa-solid fa-trophy"></i> Tournaments
                </a>
                <a href="/matches" class="quick-nav-item">
                    <i class="fa-solid fa-bolt"></i> Live Matches
                </a>
                <a href="/pointsTable" class="quick-nav-item">
                    <i class="fa-solid fa-chart-bar"></i> Points Table
                </a>
                <a href="/about" class="quick-nav-item">
                    <i class="fa-solid fa-circle-info"></i> About Us
                </a>
            </div>
        </div>

        <!-- ABOUT US -->
        <div class="about-us-section">
            <div class="about-us-video-wrap">
                <span class="about-us-video-tag"><span class="dot"></span> Live Match Action</span>
                <video id="aboutAutoVideo" autoplay muted loop playsinline preload="metadata" controls style="object-fit: fill;">
                    <source src="https://resource.flexclip.com/templates/video/720p/cricket-match-sport-match-highlights-game-youtube-intro-outro.mp4?v=1.1.4.9.7" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
            <div class="about-us-text">
                <h2>About <span>ProMatch Arena</span></h2>
                <p><strong>ProMatch Arena</strong> is India's most loved cricket tournament and match discovery platform. We connect millions of users and local teams every day, offering seamless team registration, live match scheduling, and a rich sports analytics experience.</p>
                <p>Founded to transform how people discover and manage cricket leagues, ProMatch Arena brings complete tournament control directly to your fingertips. With features like real-time squad controls, automated Net Run Rate (NRR) calculators, and secure role-based administration, we ensure organizers and players make informed competitive choices.</p>
                <ul class="about-us-features">
                    <li><i class="fa-solid fa-check"></i> Real-time live match scoring & ball-by-ball updates</li>
                    <li><i class="fa-solid fa-check"></i> Automated Net Run Rate & points table calculation</li>
                    <li><i class="fa-solid fa-check"></i> Secure role-based team registration & squad management</li>
                </ul>
                <div class="about-us-stats">
                    <span class="about-badge-pill"><i class="fa-solid fa-trophy me-1"></i> Multi-League Support</span>
                    <span class="about-badge-pill"><i class="fa-solid fa-users me-1"></i> Verified Rosters</span>
                    <span class="about-badge-pill"><i class="fa-solid fa-bolt me-1"></i> Live Score Sync</span>
                </div>
            </div>
        </div>

        <!-- ABOUT THE PROJECT ARCHITECTURE -->
        <div class="section-title">
            <span>About The Project Architecture</span>
            <span style="font-size: 12px; color: var(--accent-blue);">3D Interactive Highlights ⚾</span>
        </div>

        <div class="perspective-container">
            <div class="about-project-grid">
                <div class="about-card">
                    <h5>Spring Boot Core</h5>
                    <p>Robust enterprise backend architecture ensuring fast modular routing and dependency injection.</p>
                </div>
                <div class="about-card">
                    <h5>PostgreSQL Database</h5>
                    <p>Relational data mapping for tournaments, teams, squads, and scorecards with high integrity.</p>
                </div>
                <div class="about-card">
                    <h5>Spring Security Hub</h5>
                    <p>Role-based access control (ADMIN vs USER) securing dashboards and restricted management zones.</p>
                </div>
                <div class="about-card">
                    <h5>Automated NRR Engine</h5>
                    <p>Dynamic Net Run Rate calculator updating standings instantaneously upon match completion.</p>
                </div>
                <div class="about-card">
                    <h5>Roster & Squad Control</h5>
                    <p>Comprehensive player management, jersey assignments, and batch squad deletion features.</p>
                </div>
                <div class="about-card">
                    <h5>Cyber Glassmorphism UI</h5>
                    <p>High-end responsive interface crafted with custom styling, dark themes, and smooth animations.</p>
                </div>
            </div>
        </div>

        <!-- SHOWCASE GALLERY -->
        <div class="section-title">
            <span>Tournament Showcase Gallery</span>
            <span style="font-size: 12px; color: var(--accent-green);">Visuals Feed ⚾</span>
        </div>

        <div class="images-showcase-grid">
            <div class="image-showcase-card">
                <div class="image-showcase-body">
                    <h5>🏟️ Grand Arena Stadium</h5>
                    <p>World-class illumination designed for high-voltage championship spectacles.</p>
                </div>
                <div class="image-showcase-wrapper">
                    <img src="https://img.magnific.com/premium-vector/cricket-background_1302-17285.jpg?semt=ais_hybrid&w=740&q=80" alt="Grand Arena Stadium" loading="lazy" onerror="this.style.opacity=0">
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-body">
                    <h5>⚡ Powerplay Striker</h5>
                    <p>Top order batters unleashing boundary blitzes in early tournament overs.</p>
                </div>
                <div class="image-showcase-wrapper">
                    <img src="https://img.magnific.com/premium-vector/creative-banner-with-cricket-elements_1302-17914.jpg?semt=ais_hybrid&w=740&q=80" alt="Powerplay Batsman Action" loading="lazy" onerror="this.style.opacity=0">
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-body">
                    <h5>🏏 Official Seam Leather</h5>
                    <p>Grade-A tournament match balls engineered for seam deflection and swing control.</p>
                </div>
                <div class="image-showcase-wrapper">
                    <img src="https://png.pngtree.com/png-vector/20221016/ourmid/pngtree-champion-trophy-award-illustration-on-closeup-of-cricket-bat-vector-png-image_28465432.jpg" alt="Championship Match Ball" loading="lazy" onerror="this.style.opacity=0">
                </div>
            </div>

            <div class="image-showcase-card rotate-card">
                <div class="image-showcase-body">
                    <h5>🎯 Intensive Camp Drills</h5>
                    <p>Squads tuning bowling run-ups and defensive timing ahead of matchdays.</p>
                </div>
                <div class="image-showcase-wrapper">
                    <img src="https://upload.wikimedia.org/wikipedia/commons/d/d8/Indian_Cricket_Player.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=original" alt="Intensive Net Training" loading="lazy" onerror="this.style.opacity=0">
                </div>
            </div>

            <div class="image-showcase-card rotate-card">
                <div class="image-showcase-body">
                    <h5>🔥 Stadium Roar & Lights</h5>
                    <p>Electrifying supporter crowd experience under night-game floodlight settings.</p>
                </div>
                <div class="image-showcase-wrapper">
                    <img src="https://c4.wallpaperflare.com/wallpaper/899/523/580/cricket-india-team-wallpaper-preview.jpg" alt="Stadium Atmosphere" loading="lazy" onerror="this.style.opacity=0">
                </div>
            </div>

            <div class="image-showcase-card rotate-card">
                <div class="image-showcase-body">
                    <h5>📊 Hard Turf Match Pitch</h5>
                    <p>True bounce and telemetry tracking verified by certified match referees.</p>
                </div>
                <div class="image-showcase-wrapper">
                    <img src="https://img-cdn.publive.online/fit-in/1200x675/pcq/media/media_files/2026/05/12/how-to-play-as-your-favorite-ipl-team-in-real-cricket-2026-05-12-14-57-49.png" alt="Pristine Turf Pitch" loading="lazy" onerror="this.style.opacity=0">
                </div>
            </div>
        </div>

        <!-- TESTIMONIALS SECTION -->
        <div class="section-title">
            <span>What Organizers Say</span>
            <span style="font-size: 12px; color: var(--accent-blue);">Testimonials ⭐</span>
        </div>

        <div class="testimonial-grid">
            <div class="testimonial-card">
                <i class="fa-solid fa-quote-left quote-icon"></i>
                <p class="quote-text">ProMatch Arena has made our regional tournament completely digital and transparent. Automatic Net Run Rate calculation and real-time standings eliminate all manual errors.</p>
                <div class="testimonial-person">
                    <div class="testimonial-avatar">J</div>
                    <div>
                        <p class="testimonial-name">Jitendra Singh</p>
                        <p class="testimonial-role">Tournament Lead & Admin</p>
                        <div class="testimonial-stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <i class="fa-solid fa-quote-left quote-icon"></i>
                <p class="quote-text">Team registration, roster updates, and matchday tracking are super smooth. The glassmorphic dashboard looks sharp and offers quick access to squad metrics.</p>
                <div class="testimonial-person">
                    <div class="testimonial-avatar">A</div>
                    <div>
                        <p class="testimonial-name">Ankit Ajnotiya</p>
                        <p class="testimonial-role">Team Captain & Manager</p>
                        <div class="testimonial-stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <i class="fa-solid fa-quote-left quote-icon"></i>
                <p class="quote-text">Having live scorecards, match fixtures, and tournament telemetry all unified in one responsive portal delivers the best viewing experience for players and fans alike.</p>
                <div class="testimonial-person">
                    <div class="testimonial-avatar">S</div>
                    <div>
                        <p class="testimonial-name">Shivam Yadav</p>
                        <p class="testimonial-role">League Coordinator</p>
                        <div class="testimonial-stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- SPONSORS STRIP -->
        <div class="section-title">
            <span>Trusted By</span>
            <span style="font-size: 12px; color: var(--accent-green);">Partners ⚽</span>
        </div>

        <div class="sponsors-strip">
            <div class="sponsor-item"><i class="fa-solid fa-trophy"></i> Champions League</div>
            <div class="sponsor-item"><i class="fa-solid fa-shield-halved"></i> ArenaSports</div>
            <div class="sponsor-item"><i class="fa-solid fa-baseball-bat-ball"></i> ProCricket Gear</div>
            <div class="sponsor-item"><i class="fa-solid fa-broadcast-tower"></i> LiveStream+</div>
            <div class="sponsor-item"><i class="fa-solid fa-medal"></i> Elite Turf Co.</div>
        </div>

        <!-- TOP PERFORMERS LEADERBOARD -->
        <div class="section-title">
            <span>Top Performers</span>
            <span style="font-size: 12px; color: var(--accent-amber);">Leaderboard </span>
        </div>

        <div class="performers-grid">
            <div class="performer-card">
                <div class="performer-rank">#1</div>
                <div class="performer-avatar">VK</div>
                <p class="performer-name">Virat K.</p>
                <p class="performer-role">Batsman</p>
                <p class="performer-stat">612</p>
                <p class="performer-stat-label">Runs</p>
            </div>
            <div class="performer-card">
                <div class="performer-rank">#2</div>
                <div class="performer-avatar">JB</div>
                <p class="performer-name">Jasprit B.</p>
                <p class="performer-role">Bowler</p>
                <p class="performer-stat">28</p>
                <p class="performer-stat-label">Wickets</p>
            </div>
            <div class="performer-card">
                <div class="performer-rank">#3</div>
                <div class="performer-avatar">RS</div>
                <p class="performer-name">Rohit S.</p>
                <p class="performer-role">Opener</p>
                <p class="performer-stat">548</p>
                <p class="performer-stat-label">Runs</p>
            </div>
            <div class="performer-card">
                <div class="performer-rank">#4</div>
                <div class="performer-avatar">HP</div>
                <p class="performer-name">Hardik P.</p>
                <p class="performer-role">All-Rounder</p>
                <p class="performer-stat">340</p>
                <p class="performer-stat-label">Runs + 14 Wkts</p>
            </div>
        </div>

        <!-- 🌟 GRAND ARENA VIDEO HIGHLIGHTS -->
        <div class="section-title">
            <span>Grand Arena Video Highlights</span>
            <span style="font-size: 12px; color: var(--accent-blue);">Action Reels ⚡</span>
        </div>

        <div class="video-grid">
            <!-- Video 1 -->
            <div class="video-card-item" onclick="openVideo('https://youtu.be/MAm0RLQpYas?si=6-P8VqowjEgmLxxx')">
                <div class="video-content-top">
                    <h4>🔥 ProMatch Highlight Reel 1</h4>
                    <p>High-voltage tournament moments</p>
                </div>
                <div class="video-thumb-wrapper">
                    <img src="https://img.youtube.com/vi/MAm0RLQpYas/hqdefault.jpg" alt="Video Thumbnail 1" loading="lazy">
                    <div class="play-btn-overlay"><i class="fa-solid fa-play"></i></div>
                </div>
            </div>

            <!-- Video 2 -->
            <div class="video-card-item" onclick="openVideo('https://youtu.be/YqKYpgZ9FWU?si=mibSra9Ov0JmhSXA')">
                <div class="video-content-top">
                    <h4>⚡ ProMatch Highlight Reel 2</h4>
                    <p>Explosive batting & clinical bowling</p>
                </div>
                <div class="video-thumb-wrapper">
                    <img src="https://img.youtube.com/vi/YqKYpgZ9FWU/hqdefault.jpg" alt="Video Thumbnail 2" loading="lazy">
                    <div class="play-btn-overlay"><i class="fa-solid fa-play"></i></div>
                </div>
            </div>

            <!-- Video 3 -->
            <div class="video-card-item" onclick="openVideo('https://youtu.be/MZfi4_ofBGA?si=AhL6d0ukaBMOpS8g')">
                <div class="video-content-top">
                    <h4>🎯 ProMatch Highlight Reel 3</h4>
                    <p>Clutch finishes & grand celebrations</p>
                </div>
                <div class="video-thumb-wrapper">
                    <img src="https://img.youtube.com/vi/MZfi4_ofBGA/hqdefault.jpg" alt="Video Thumbnail 3" loading="lazy">
                    <div class="play-btn-overlay"><i class="fa-solid fa-play"></i></div>
                </div>
            </div>
        </div>

        <!-- ===== NEW: LATEST NEWS ===== -->
        <div class="section-title">
            <span>Latest News & Updates</span>
            <span style="font-size: 12px; color: var(--accent-blue);">Newsroom </span>
        </div>
        <div class="nx-grid-3">
            <div class="nx-card">
                <span class="nx-tag">Breaking</span>
                <h5>Titans XI Storm Into Top Spot</h5>
                <p>A commanding batting display lifts Titans XI to the top of the standings after a thrilling Matchday 24 contest.</p>
                <span class="nx-date"><i class="fa-regular fa-clock me-1"></i> Today</span>
            </div>
            <div class="nx-card">
                <span class="nx-tag">Tournament</span>
                <h5>Championship Cup Playoffs Announced</h5>
                <p>Top four teams will advance to the knockout stage with a revised schedule and floodlit night fixtures.</p>
                <span class="nx-date"><i class="fa-regular fa-clock me-1"></i> Yesterday</span>
            </div>
            <div class="nx-card">
                <span class="nx-tag">Platform</span>
                <h5>New NRR Engine Update Live</h5>
                <p>Faster Net Run Rate calculations now refresh standings instantly once official scorecards are approved.</p>
                <span class="nx-date"><i class="fa-regular fa-clock me-1"></i> 2 days ago</span>
            </div>
        </div>

        <!-- ===== NEW: UPCOMING FIXTURES ===== -->
        <div class="section-title">
            <span>Upcoming Fixtures</span>
            <span style="font-size: 12px; color: var(--accent-green);">Schedule 🗓️</span>
        </div>
        <div class="nx-grid-3">
            <div class="nx-card">
                <div class="nx-fixture-teams">
                    <div class="nx-team">🛡️ Titans XI</div><div class="nx-vs">VS</div><div class="nx-team">⚡ Strikers CC</div>
                </div>
                <div class="nx-fixture-meta"><span><i class="fa-regular fa-calendar"></i>Tomorrow</span><span><i class="fa-regular fa-clock"></i>7:30 PM</span></div>
            </div>
            <div class="nx-card">
                <div class="nx-fixture-teams">
                    <div class="nx-team">🔥 Royal Hawks</div><div class="nx-vs">VS</div><div class="nx-team">🌪️️ Thunder Kings</div>
                </div>
                <div class="nx-fixture-meta"><span><i class="fa-regular fa-calendar"></i>In 2 days</span><span><i class="fa-regular fa-clock"></i>3:00 PM</span></div>
            </div>
            <div class="nx-card">
                <div class="nx-fixture-teams">
                    <div class="nx-team">🦁 Desert Lions</div><div class="nx-vs">VS</div><div class="nx-team">🐺 Night Wolves</div>
                </div>
                <div class="nx-fixture-meta"><span><i class="fa-regular fa-calendar"></i>In 3 days</span><span><i class="fa-regular fa-clock"></i>7:30 PM</span></div>
            </div>
        </div>

        <!-- ===== 🌟 NEW SECTION: YOUR TOURNAMENT JOURNEY ===== -->
        <div class="section-title">
            <span>Your Tournament Journey</span>
            <span style="font-size: 12px; color: var(--accent-amber);">Sign Up To Trophy 🏆</span>
        </div>
        <div class="jr-wrap" id="journeySection">
            <div class="jr-line"><div class="jr-line-fill"></div></div>

            <div class="jr-step" style="--i:0">
                <div class="jr-node"><i class="fa-solid fa-user-plus"></i></div>
                <div class="jr-card">
                    <span class="jr-num">STEP 01</span>
                    <h5>Sign Up Free</h5>
                    <p>Create your free account in under a minute and unlock the dashboard.</p>
                </div>
            </div>
            <div class="jr-step" style="--i:1">
                <div class="jr-node"><i class="fa-solid fa-shield-halved"></i></div>
                <div class="jr-card">
                    <span class="jr-num">STEP 02</span>
                    <h5>Register Your Team</h5>
                    <p>Add team name, captain and full squad with jersey numbers.</p>
                </div>
            </div>
            <div class="jr-step" style="--i:2">
                <div class="jr-node"><i class="fa-solid fa-circle-check"></i></div>
                <div class="jr-card">
                    <span class="jr-num">STEP 03</span>
                    <h5>Admin Approval</h5>
                    <p>Tournament admin verifies your roster and confirms your entry.</p>
                </div>
            </div>
            <div class="jr-step" style="--i:3">
                <div class="jr-node"><i class="fa-solid fa-bolt"></i></div>
                <div class="jr-card">
                    <span class="jr-num">STEP 04</span>
                    <h5>Play Matchdays</h5>
                    <p>Track live scores, fixtures and auto-updated points table with NRR.</p>
                </div>
            </div>
            <div class="jr-step" style="--i:4">
                <div class="jr-node"><i class="fa-solid fa-trophy"></i></div>
                <div class="jr-card">
                    <span class="jr-num">STEP 05</span>
                    <h5>Lift The Trophy</h5>
                    <p>Win the playoffs and claim the Championship Cup glory.</p>
                </div>
            </div>
        </div>
        <div class="jr-cta">
            <a href="${pageContext.request.contextPath}/register" class="btn-custom-glow">
                <i class="fa-solid fa-rocket"></i> Start Free Now
            </a>
        </div>

        <!-- ===== NEW: WHY CHOOSE US ===== -->
        <div class="section-title">
            <span>Why Choose ProMatch Arena</span>
            <span style="font-size: 12px; color: var(--accent-amber);">Features ✨</span>
        </div>
        <div class="nx-grid-4">
            <div class="nx-card nx-why">
                <div class="nx-icon"><i class="fa-solid fa-bolt"></i></div>
                <h5>Live Scoring</h5>
                <p>Ball-by-ball updates with instant score sync across devices.</p>
            </div>
            <div class="nx-card nx-why">
                <div class="nx-icon"><i class="fa-solid fa-calculator"></i></div>
                <h5>Auto NRR</h5>
                <p>Points table and Net Run Rate calculated with zero manual work.</p>
            </div>
            <div class="nx-card nx-why">
                <div class="nx-icon"><i class="fa-solid fa-lock"></i></div>
                <h5>Secure Access</h5>
                <p>Role-based control keeps admin zones and rosters protected.</p>
            </div>
            <div class="nx-card nx-why">
                <div class="nx-icon"><i class="fa-solid fa-users-gear"></i></div>
                <h5>Squad Control</h5>
                <p>Manage players, jersey numbers, and lineups in a few clicks.</p>
            </div>
        </div>

        <!-- ===== NEW: FAQ ===== -->
        <div class="section-title">
            <span>Frequently Asked Questions</span>
            <span style="font-size: 12px; color: var(--accent-blue);">Help ❓</span>
        </div>
        <div class="nx-faq">
            <details>
                <summary>How do I register my team?</summary>
                <p>Click "Register Team Now", fill in your team name, logo, and captain roster, then submit. Approval is handled by the tournament admin.</p>
            </details>
            <details>
                <summary>How is the points table calculated?</summary>
                <p>Points are based on wins and results, and Net Run Rate is calculated automatically once a verified scorecard is submitted.</p>
            </details>
            <details>
                <summary>Can I edit my squad after registration?</summary>
                <p>Yes. You can add or remove players and change jersey numbers from your team management portal.</p>
            </details>
            <details>
                <summary>Who can create tournaments and schedule matches?</summary>
                <p>Only users with the ADMIN role can create tournaments, schedule matches, and approve teams.</p>
            </details>
        </div>

        <!-- GET THE APP SECTION -->
        <div class="get-app-section">
            <div class="get-app-text">
                <h2>Get the <span>ProMatch Arena</span> App</h2>
                <p>Experience tournament management on the go. Scan the QR code or download the app to track live scores, manage your team, and stay updated — anytime, anywhere.</p>
                <ul class="get-app-features">
                    <li><span class="dot-marker"></span> Faster live scoring & real-time notifications</li>
                    <li><span class="dot-marker"></span> Exclusive app-only match insights</li>
                    <li><span class="dot-marker"></span> Manage your squad & schedule on the go</li>
                </ul>
                <div class="get-app-available">Available On</div>
                <div class="store-badges">
                    <a href="#" class="store-badge">
                        <i class="fa-brands fa-google-play"></i>
                        <span class="store-badge-text"><small>Get it on</small><strong>Google Play</strong></span>
                    </a>
                    <a href="#" class="store-badge">
                        <i class="fa-brands fa-app-store-ios"></i>
                        <span class="store-badge-text"><small>Download on the</small><strong>App Store</strong></span>
                    </a>
                </div>
            </div>
            <div class="qr-card">
                <div class="qr-frame">
                    <svg class="qr-svg" viewBox="0 0 189 189" xmlns="http://www.w3.org/2000/svg">
                        <rect x="0" y="0" width="9" height="9"/><rect x="9" y="0" width="9" height="9"/><rect x="18" y="0" width="9" height="9"/><rect x="27" y="0" width="9" height="9"/><rect x="36" y="0" width="9" height="9"/><rect x="45" y="0" width="9" height="9"/><rect x="54" y="0" width="9" height="9"/><rect x="72" y="0" width="9" height="9"/><rect x="81" y="0" width="9" height="9"/><rect x="90" y="0" width="9" height="9"/><rect x="126" y="0" width="9" height="9"/><rect x="135" y="0" width="9" height="9"/><rect x="144" y="0" width="9" height="9"/><rect x="153" y="0" width="9" height="9"/><rect x="162" y="0" width="9" height="9"/><rect x="171" y="0" width="9" height="9"/><rect x="180" y="0" width="9" height="9"/><rect x="0" y="9" width="9" height="9"/><rect x="54" y="9" width="9" height="9"/><rect x="63" y="9" width="9" height="9"/><rect x="81" y="9" width="9" height="9"/><rect x="90" y="9" width="9" height="9"/><rect x="108" y="9" width="9" height="9"/><rect x="117" y="9" width="9" height="9"/><rect x="126" y="9" width="9" height="9"/><rect x="180" y="9" width="9" height="9"/><rect x="0" y="18" width="9" height="9"/><rect x="18" y="18" width="9" height="9"/><rect x="27" y="18" width="9" height="9"/><rect x="36" y="18" width="9" height="9"/><rect x="54" y="18" width="9" height="9"/><rect x="81" y="18" width="9" height="9"/><rect x="108" y="18" width="9" height="9"/><rect x="126" y="18" width="9" height="9"/><rect x="144" y="18" width="9" height="9"/><rect x="153" y="18" width="9" height="9"/><rect x="162" y="18" width="9" height="9"/><rect x="180" y="18" width="9" height="9"/><rect x="0" y="27" width="9" height="9"/><rect x="18" y="27" width="9" height="9"/><rect x="27" y="27" width="9" height="9"/><rect x="36" y="27" width="9" height="9"/><rect x="54" y="27" width="9" height="9"/><rect x="72" y="27" width="9" height="9"/><rect x="81" y="27" width="9" height="9"/><rect x="99" y="27" width="9" height="9"/><rect x="108" y="27" width="9" height="9"/><rect x="117" y="27" width="9" height="9"/><rect x="126" y="27" width="9" height="9"/><rect x="144" y="27" width="9" height="9"/><rect x="153" y="27" width="9" height="9"/><rect x="162" y="27" width="9" height="9"/><rect x="180" y="27" width="9" height="9"/><rect x="0" y="36" width="9" height="9"/><rect x="18" y="36" width="9" height="9"/><rect x="27" y="36" width="9" height="9"/><rect x="36" y="36" width="9" height="9"/><rect x="54" y="36" width="9" height="9"/><rect x="117" y="36" width="9" height="9"/><rect x="126" y="36" width="9" height="9"/><rect x="144" y="36" width="9" height="9"/><rect x="153" y="36" width="9" height="9"/><rect x="162" y="36" width="9" height="9"/><rect x="180" y="36" width="9" height="9"/><rect x="0" y="45" width="9" height="9"/><rect x="54" y="45" width="9" height="9"/><rect x="117" y="45" width="9" height="9"/><rect x="126" y="45" width="9" height="9"/><rect x="180" y="45" width="9" height="9"/><rect x="0" y="54" width="9" height="9"/><rect x="9" y="54" width="9" height="9"/><rect x="18" y="54" width="9" height="9"/><rect x="27" y="54" width="9" height="9"/><rect x="36" y="54" width="9" height="9"/><rect x="45" y="54" width="9" height="9"/><rect x="54" y="54" width="9" height="9"/><rect x="63" y="54" width="9" height="9"/><rect x="72" y="54" width="9" height="9"/><rect x="81" y="54" width="9" height="9"/><rect x="90" y="54" width="9" height="9"/><rect x="99" y="54" width="9" height="9"/><rect x="108" y="54" width="9" height="9"/><rect x="126" y="54" width="9" height="9"/><rect x="135" y="54" width="9" height="9"/><rect x="144" y="54" width="9" height="9"/><rect x="153" y="54" width="9" height="9"/><rect x="162" y="54" width="9" height="9"/><rect x="171" y="54" width="9" height="9"/><rect x="180" y="54" width="9" height="9"/><rect x="0" y="63" width="9" height="9"/><rect x="9" y="63" width="9" height="9"/><rect x="18" y="63" width="9" height="9"/><rect x="27" y="63" width="9" height="9"/><rect x="63" y="63" width="9" height="9"/><rect x="81" y="63" width="9" height="9"/><rect x="90" y="63" width="9" height="9"/><rect x="153" y="63" width="9" height="9"/><rect x="162" y="63" width="9" height="9"/><rect x="171" y="63" width="9" height="9"/><rect x="180" y="63" width="9" height="9"/><rect x="0" y="72" width="9" height="9"/><rect x="27" y="72" width="9" height="9"/><rect x="45" y="72" width="9" height="9"/><rect x="72" y="72" width="9" height="9"/><rect x="81" y="72" width="9" height="9"/><rect x="99" y="72" width="9" height="9"/><rect x="126" y="72" width="9" height="9"/><rect x="135" y="72" width="9" height="9"/><rect x="162" y="72" width="9" height="9"/><rect x="171" y="72" width="9" height="9"/><rect x="180" y="72" width="9" height="9"/><rect x="27" y="81" width="9" height="9"/><rect x="36" y="81" width="9" height="9"/><rect x="81" y="81" width="9" height="9"/><rect x="117" y="81" width="9" height="9"/><rect x="135" y="81" width="9" height="9"/><rect x="180" y="81" width="9" height="9"/><rect x="9" y="90" width="9" height="9"/><rect x="36" y="90" width="9" height="9"/><rect x="63" y="90" width="9" height="9"/><rect x="108" y="90" width="9" height="9"/><rect x="117" y="90" width="9" height="9"/><rect x="126" y="90" width="9" height="9"/><rect x="162" y="90" width="9" height="9"/><rect x="171" y="90" width="9" height="9"/><rect x="9" y="99" width="9" height="9"/><rect x="27" y="99" width="9" height="9"/><rect x="54" y="99" width="9" height="9"/><rect x="81" y="99" width="9" height="9"/><rect x="108" y="99" width="9" height="9"/><rect x="135" y="99" width="9" height="9"/><rect x="144" y="99" width="9" height="9"/><rect x="0" y="108" width="9" height="9"/><rect x="9" y="108" width="9" height="9"/><rect x="18" y="108" width="9" height="9"/><rect x="36" y="108" width="9" height="9"/><rect x="45" y="108" width="9" height="9"/><rect x="54" y="108" width="9" height="9"/><rect x="72" y="108" width="9" height="9"/><rect x="99" y="108" width="9" height="9"/><rect x="108" y="108" width="9" height="9"/><rect x="126" y="108" width="9" height="9"/><rect x="135" y="108" width="9" height="9"/><rect x="0" y="117" width="9" height="9"/><rect x="9" y="117" width="9" height="9"/><rect x="72" y="117" width="9" height="9"/><rect x="81" y="117" width="9" height="9"/><rect x="90" y="117" width="9" height="9"/><rect x="108" y="117" width="9" height="9"/><rect x="117" y="117" width="9" height="9"/><rect x="144" y="117" width="9" height="9"/><rect x="153" y="117" width="9" height="9"/><rect x="0" y="126" width="9" height="9"/><rect x="9" y="126" width="9" height="9"/><rect x="18" y="126" width="9" height="9"/><rect x="27" y="126" width="9" height="9"/><rect x="36" y="126" width="9" height="9"/><rect x="45" y="126" width="9" height="9"/><rect x="54" y="126" width="9" height="9"/><rect x="72" y="126" width="9" height="9"/><rect x="126" y="126" width="9" height="9"/><rect x="144" y="126" width="9" height="9"/><rect x="153" y="126" width="9" height="9"/><rect x="162" y="126" width="9" height="9"/><rect x="171" y="126" width="9" height="9"/><rect x="0" y="135" width="9" height="9"/><rect x="54" y="135" width="9" height="9"/><rect x="63" y="135" width="9" height="9"/><rect x="135" y="135" width="9" height="9"/><rect x="144" y="135" width="9" height="9"/><rect x="0" y="144" width="9" height="9"/><rect x="18" y="144" width="9" height="9"/><rect x="27" y="144" width="9" height="9"/><rect x="36" y="144" width="9" height="9"/><rect x="54" y="144" width="9" height="9"/><rect x="63" y="144" width="9" height="9"/><rect x="99" y="144" width="9" height="9"/><rect x="117" y="144" width="9" height="9"/><rect x="126" y="144" width="9" height="9"/><rect x="153" y="144" width="9" height="9"/><rect x="162" y="144" width="9" height="9"/><rect x="180" y="144" width="9" height="9"/><rect x="0" y="153" width="9" height="9"/><rect x="18" y="153" width="9" height="9"/><rect x="27" y="153" width="9" height="9"/><rect x="36" y="153" width="9" height="9"/><rect x="54" y="153" width="9" height="9"/><rect x="81" y="153" width="9" height="9"/><rect x="117" y="153" width="9" height="9"/><rect x="135" y="153" width="9" height="9"/><rect x="144" y="153" width="9" height="9"/><rect x="162" y="153" width="9" height="9"/><rect x="171" y="153" width="9" height="9"/><rect x="0" y="162" width="9" height="9"/><rect x="18" y="162" width="9" height="9"/><rect x="27" y="162" width="9" height="9"/><rect x="36" y="162" width="9" height="9"/><rect x="54" y="162" width="9" height="9"/><rect x="63" y="162" width="9" height="9"/><rect x="99" y="162" width="9" height="9"/><rect x="108" y="162" width="9" height="9"/><rect x="117" y="162" width="9" height="9"/><rect x="153" y="162" width="9" height="9"/><rect x="162" y="162" width="9" height="9"/><rect x="0" y="171" width="9" height="9"/><rect x="54" y="171" width="9" height="9"/><rect x="90" y="171" width="9" height="9"/><rect x="108" y="171" width="9" height="9"/><rect x="135" y="171" width="9" height="9"/><rect x="144" y="171" width="9" height="9"/><rect x="153" y="171" width="9" height="9"/><rect x="171" y="171" width="9" height="9"/><rect x="0" y="180" width="9" height="9"/><rect x="9" y="180" width="9" height="9"/><rect x="18" y="180" width="9" height="9"/><rect x="27" y="180" width="9" height="9"/><rect x="36" y="180" width="9" height="9"/><rect x="45" y="180" width="9" height="9"/><rect x="54" y="180" width="9" height="9"/><rect x="72" y="180" width="9" height="9"/><rect x="90" y="180" width="9" height="9"/><rect x="126" y="180" width="9" height="9"/><rect x="144" y="180" width="9" height="9"/><rect x="153" y="180" width="9" height="9"/><rect x="180" y="180" width="9" height="9"/>
                    </svg>
                </div>
                <p class="scan-label">Scan to</p>
                <p class="scan-title">Download ProMatch Arena App</p>
                <div class="qr-hourly-badge"><span class="hour-dot"></span> <span id="hourlyActiveText">9:00 PM Active Sync</span></div>
            </div>
        </div>

        <!-- 🌟 VIDEO MODAL -->
        <div id="videoModal" class="video-modal" onclick="if(event.target===this) closeVideo()">
            <div class="video-modal-content">
                <span class="close-modal" onclick="closeVideo()">&times;</span>
                <h4 style="color: var(--accent-blue); margin-bottom: 15px; font-weight: 800;">
                    <i class="fa-solid fa-play me-2"></i> ProMatch Arena Live Stream
                </h4>
                <div id="videoPlayer" class="video-player-box">
                    <div class="yt-cover-top"></div>
                    <div class="yt-cover-bottom"></div>
                </div>
            </div>
        </div>

        <!-- CTA BANNER -->
        <div class="cta-banner">
            <div class="cta-banner-text">
                <h2>Ready to Compete This Season?</h2>
                <p>Register your team in minutes and get access to live scoring, automated points tables, and a professional tournament dashboard — all in one place.</p>
            </div>
            <a href="${pageContext.request.contextPath}/register-team" class="btn-cta-white">
                <i class="fa-solid fa-shield-halved"></i> Register Your Team
            </a>
        </div>

    </div>

    <!-- 🌟 GRAND FOOTER INCLUDE (Untouched) -->
    <jsp:include page="footer.jsp" />

    <!-- 🌟 CHATBOT & SCROLL TO TOP INCLUDE -->
    <jsp:include page="chatbot.jsp" />

    <!-- Bootstrap JS Bundle & Theme Sync Script -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.addEventListener('load', function () {
            var v = document.getElementById('aboutAutoVideo');
            if (v) { v.removeAttribute('controls'); v.controls = false; v.play().catch(function(){}); }
        });

        // Theme sync: navbar toggle html[data-theme] set karta hai -> body.light-mode uske saath chale
        (function () {
            var root = document.documentElement;
            function sync() {
                var light = root.getAttribute('data-theme') === 'light';
                document.body.classList.toggle('light-mode', light);
            }
            try {
                if (localStorage.getItem('promatch_theme') === 'light') root.setAttribute('data-theme', 'light');
            } catch (e) {}
            sync();
            new MutationObserver(sync).observe(root, { attributes: true, attributeFilter: ['data-theme'] });
            window.addEventListener('storage', function (e) {
                if (e.key === 'promatch_theme') {
                    if (e.newValue === 'light') root.setAttribute('data-theme', 'light');
                    else root.removeAttribute('data-theme');
                }
            });
        })();
    </script>

    <!-- 🌟 NEW: Journey section scroll-reveal -->
    <script>
        (function () {
            var el = document.getElementById('journeySection');
            if (!el) return;
            if ('IntersectionObserver' in window) {
                var io = new IntersectionObserver(function (entries) {
                    entries.forEach(function (en) {
                        if (en.isIntersecting) { el.classList.add('in-view'); io.disconnect(); }
                    });
                }, { threshold: 0.2 });
                io.observe(el);
            } else {
                el.classList.add('in-view');
            }
        })();
    </script>
</body>
</html>
