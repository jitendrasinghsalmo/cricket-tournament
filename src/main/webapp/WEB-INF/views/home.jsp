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

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #030712 0%, #0a0f1d 100%);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .container { max-width: 1350px; margin: 30px auto; padding: 0 20px; }

        /* HERO BANNER */
        .hero-banner {
            position: relative;
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            border: none;
            border-radius: 28px;
            padding: 55px;
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
            overflow: hidden;
        }

        .hero-banner::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.16) 0%, rgba(16, 185, 129, 0.10) 35%, transparent 70%);
            animation: rotateGlow 12s linear infinite; z-index: 1;
        }

        .hero-banner::after {
            content: ''; position: absolute; bottom: -60%; right: -40%; width: 180%; height: 180%;
            background: radial-gradient(circle, rgba(244, 63, 94, 0.12) 0%, rgba(245, 158, 11, 0.08) 40%, transparent 70%);
            animation: rotateGlowReverse 18s linear infinite; z-index: 1;
        }

        .hero-glow-orb {
            position: absolute; width: 220px; height: 220px; border-radius: 50%;
            background: radial-gradient(circle, rgba(56,189,248,0.35), transparent 70%);
            filter: blur(30px); z-index: 1; pointer-events: none;
            animation: driftOrb 9s ease-in-out infinite alternate;
        }
        .hero-glow-orb.orb-2 {
            background: radial-gradient(circle, rgba(16,185,129,0.3), transparent 70%);
            top: 60%; left: 55%; width: 180px; height: 180px;
            animation: driftOrb2 11s ease-in-out infinite alternate;
        }

        @keyframes rotateGlow { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        @keyframes rotateGlowReverse { 0% { transform: rotate(0deg); } 100% { transform: rotate(-360deg); } }
        @keyframes driftOrb {
            0% { transform: translate(0, 0) scale(1); top: 5%; left: 10%; }
            100% { transform: translate(40px, 30px) scale(1.2); top: 15%; left: 20%; }
        }
        @keyframes driftOrb2 {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(-30px, -20px) scale(1.15); }
        }

        .hero-content { z-index: 2; max-width: 600px; }
        .season-tag { color: var(--accent-green); font-size: 11.5px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px; display: block; text-shadow: 0 0 10px rgba(16,185,129,0.4); }
        .hero-content h1 { font-size: 36px; margin: 0 0 12px 0; font-weight: 900; letter-spacing: 0.5px; color: #fff; text-shadow: 0 0 20px rgba(56,189,248,0.3); }
        .hero-content p { color: var(--text-muted); font-size: 14px; margin: 0 0 25px 0; line-height: 1.6; }

        .btn-custom-glow {
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); color: #030712; border: none; padding: 12px 24px;
            border-radius: 14px; font-weight: 800; font-size: 13px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 0 25px rgba(56,189,248,0.5); transition: all 0.3s ease; text-transform: uppercase; z-index: 2;
        }
        .btn-custom-glow:hover { transform: translateY(-3px) scale(1.02); box-shadow: 0 0 35px rgba(56,189,248,0.8); color: #030712; }

        .hero-stadium-art {
            position: relative; z-index: 2; width: 380px; height: 190px;
            border: 1.5px solid rgba(16, 185, 129, 0.5); border-radius: 20px; overflow: hidden;
            display: flex; align-items: center; justify-content: center;
            background: radial-gradient(circle at 25% 15%, rgba(16, 185, 129, 0.30), transparent 55%), radial-gradient(circle at 85% 85%, rgba(56, 189, 248, 0.30), transparent 55%), linear-gradient(135deg, rgba(6, 78, 59, 0.55), rgba(3, 7, 18, 0.95));
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.3); animation: floatArt 4s ease-in-out infinite alternate;
        }
        @keyframes floatArt { 0% { transform: translateY(0px) scale(1); } 100% { transform: translateY(-10px) scale(1.02); } }

        .hero-stadium-art .particle {
            position: absolute; bottom: 6px; width: 6px; height: 6px; border-radius: 50%;
            background: var(--accent-blue); box-shadow: 0 0 8px var(--accent-blue);
            animation: floatParticle 4.5s ease-in infinite; z-index: 1;
        }
        .hero-stadium-art .p1 { left: 10%; animation-delay: 0s; }
        .hero-stadium-art .p2 { left: 28%; background: var(--accent-green); box-shadow: 0 0 8px var(--accent-green); animation-delay: 0.9s; }
        .hero-stadium-art .p3 { left: 50%; animation-delay: 1.8s; }
        .hero-stadium-art .p4 { left: 70%; background: var(--accent-green); box-shadow: 0 0 8px var(--accent-green); animation-delay: 2.7s; }
        .hero-stadium-art .p5 { left: 88%; animation-delay: 3.6s; }

        @keyframes floatParticle {
            0% { transform: translateY(0) scale(1); opacity: 0; }
            12% { opacity: 1; }
            100% { transform: translateY(-150px) scale(0.3); opacity: 0; }
        }

        .hero-stadium-art .cricket-ball-icon {
            position: absolute; top: 14px; right: 18px; font-size: 24px; z-index: 2;
            animation: spinBall 3s linear infinite;
            filter: drop-shadow(0 0 6px rgba(56,189,248,0.6));
        }
        @keyframes spinBall { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

        .live-scoreboard {
            position: relative; z-index: 3; width: 87%;
            background: rgba(3, 7, 18, 0.6); backdrop-filter: blur(8px);
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
        .team-row {
            display: flex; justify-content: space-between; align-items: center;
            font-size: 13.5px; font-weight: 700; color: #fff; padding: 3px 0;
        }
        .team-score { color: var(--accent-blue); font-weight: 900; }
        .live-scoreboard .scoreboard-progress {
            height: 5px; background: rgba(255,255,255,0.08); border-radius: 4px; overflow: hidden; margin-top: 10px;
        }
        .live-scoreboard .scoreboard-progress-bar {
            height: 100%; background: linear-gradient(90deg, var(--accent-green), var(--accent-blue));
            animation: growBar 3s ease-in-out infinite alternate;
        }
        @keyframes growBar { 0% { width: 68%; } 100% { width: 95%; } }
        .live-scoreboard .scoreboard-footer {
            font-size: 10px; color: var(--text-muted); margin-top: 8px; display: flex; justify-content: space-between;
        }

        /* 🌟 RUNNING TICKER */
        .running-ticker {
            background: linear-gradient(90deg, #f43f5e, #0284c7, #10b981);
            color: #ffffff; font-size: 13px; font-weight: 800; padding: 9px 0;
            overflow: hidden; white-space: nowrap; box-shadow: 0 4px 15px rgba(0,0,0,0.3);
            text-transform: uppercase; letter-spacing: 1px; border-radius: 12px;
            margin-bottom: 30px;
        }
        .running-ticker marquee span { margin-right: 40px; }

        /* STATS WIDGETS */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 22px; margin-bottom: 30px; }
        .stat-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 22px; transition: all 0.3s ease; display: flex; align-items: center; gap: 16px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); position: relative; overflow: hidden; }
        .stat-card:hover { transform: translateY(-5px); border-color: var(--accent-blue); box-shadow: 0 15px 40px rgba(56,189,248,0.25); }
        .stat-icon-badge {
            width: 52px; height: 52px; border-radius: 14px; flex-shrink: 0;
            background: rgba(56, 189, 248, 0.15); border: 1px solid rgba(56, 189, 248, 0.3);
            display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--accent-blue);
        }
        .stat-card h4 { color: var(--text-muted); font-size: 11px; text-transform: uppercase; letter-spacing: 1px; margin: 0 0 6px 0; font-weight: 800; }
        .stat-card .val { font-size: 15px; font-weight: 800; margin: 0; color: var(--text-main); display: flex; align-items: center; gap: 8px; }
        .stat-card .live-badge-mini { font-size: 10px; background: rgba(16,185,129,0.2); color: var(--accent-green); border: 1px solid rgba(16,185,129,0.4); padding: 2px 8px; border-radius: 10px; font-weight: 700; text-transform: uppercase; }

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
        .section-title { font-size: 19px; font-weight: 800; margin: 40px 0 20px 0; display: flex; justify-content: space-between; align-items: center; border-left: 4px solid var(--accent-blue); padding-left: 12px; text-transform: uppercase; letter-spacing: 0.5px; }

        /* ABOUT PROJECT ARCHITECTURE CARDS */
        .perspective-container { perspective: 1200px; margin-bottom: 45px; }
        .about-project-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
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
        @keyframes pulseDot { 0%,100% { opacity: 1; } 50% { opacity: 0.3; } }
        
        .about-us-text { position: relative; z-index: 2; }
        .about-us-text h2 { font-size: 38px; font-weight: 900; margin: 0 0 16px 0; color: var(--text-main); letter-spacing: 0.5px; }
        .about-us-text h2 span { color: var(--accent-blue); text-shadow: 0 0 15px rgba(56,189,248,0.4); }
        .about-us-text p { font-size: 14.5px; line-height: 1.8; color: var(--text-muted); margin: 0 0 16px 0; }
        .about-us-features { list-style: none; margin: 0 0 24px 0; padding: 0; display: flex; flex-direction: column; gap: 12px; }
        .about-us-features li { display: flex; align-items: center; gap: 10px; font-size: 13.5px; font-weight: 600; color: var(--text-main); }
        .about-us-features li i { color: var(--accent-green); font-size: 14px; background: rgba(16,185,129,0.15); width: 26px; height: 26px; border-radius: 8px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        
        .about-us-stats { display: flex; gap: 15px; margin-top: 24px; padding-top: 20px; border-top: 1px solid var(--border-color); flex-wrap: wrap; }
        .about-badge-pill { background: rgba(56,189,248,0.1); border: 1px solid rgba(56,189,248,0.3); color: var(--accent-blue); padding: 6px 14px; border-radius: 20px; font-size: 12px; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; display: inline-flex; align-items: center; gap: 6px; }

        @media (max-width: 900px) {
            .about-us-section { grid-template-columns: 1fr; padding: 0; }
            .about-us-video-wrap { height: 280px; }
        }

        /* 🌟 TOURNAMENT SHOWCASE GALLERY */
        .images-showcase-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 45px; }
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
            background: #030712; 
            margin: 0;
            padding: 0;
            border-top: 1px solid var(--border-color);
            display: flex;
            align-items: center;
            justify-content: center;
            flex-grow: 1;
            overflow: hidden;
        }
        .image-showcase-wrapper img {
            width: 100%; 
            height: auto;                     
            max-height: 220px;                
            object-fit: contain;              
            display: block;
            margin: 0;
            padding: 4px;
            transition: filter 0.5s ease;
        }
        .image-showcase-card:hover .image-showcase-wrapper img {
            filter: brightness(1.12) contrast(1.05);
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
            margin: 0;
            padding: 0;
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
            margin: 0;
            padding: 0;
            border: 0;
        }
        .play-btn-overlay { 
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); 
            background: rgba(56, 189, 248, 0.9); color: #030712; width: 46px; height: 46px; 
            border-radius: 50%; display: flex; align-items: center; justify-content: center; 
            font-size: 18px; box-shadow: 0 0 25px rgba(56, 189, 248, 0.8); transition: all 0.3s ease; 
            z-index: 2;
        }
        .video-card-item:hover .play-btn-overlay { transform: translate(-50%, -50%) scale(1.12); background: var(--neon-emerald); }

        /* 🌟 VIDEO POPUP MODAL */
        .video-modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(3, 7, 18, 0.92); backdrop-filter: blur(12px); align-items: center; justify-content: center; padding: 20px; }
        .video-modal-content { background: #0d1223; border: 1.5px solid var(--border-color); border-radius: 20px; width: 100%; max-width: 850px; padding: 25px; position: relative; box-shadow: 0 25px 60px rgba(0,0,0,0.8); }
        .close-modal { position: absolute; top: 14px; right: 20px; color: var(--text-muted); font-size: 28px; font-weight: 800; cursor: pointer; transition: 0.2s; }
        .close-modal:hover { color: var(--accent-red); }
        #videoPlayer iframe { position: absolute; top: 0; left: 0; width: 100%; height: 100%; border: 0; }
        .video-error { position: absolute; inset: 0; display: flex; flex-direction: column; align-items: center; justify-content: center; gap: 8px; padding: 20px; text-align: center; color: var(--text-muted); font-size: 13.5px; font-weight: 600; }
        .video-error i { font-size: 30px; color: var(--accent-red); }

        /* TOP PERFORMERS LEADERBOARD */
        .performers-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 45px; }
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
        .cta-banner::before {
            content: ''; position: absolute; top: -50%; right: -10%; width: 60%; height: 200%;
            background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, transparent 70%);
        }
        .cta-banner-text { position: relative; z-index: 2; max-width: 550px; }
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

        @media (max-width: 900px) {
            .performers-grid { grid-template-columns: repeat(2, 1fr); }
            .cta-banner { flex-direction: column; text-align: center; padding: 40px 30px; }
            .images-showcase-grid, .video-grid { grid-template-columns: 1fr; }
        }

        /* GET THE APP SECTION */
        .get-app-section {
            display: grid; grid-template-columns: 1.2fr 0.8fr; gap: 50px; align-items: center;
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.95), rgba(20, 28, 48, 0.9));
            border: 1.5px solid var(--border-color); border-radius: 28px;
            padding: 50px; margin-bottom: 45px; box-shadow: 0 20px 45px rgba(0,0,0,0.45);
        }
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
            box-shadow: 0 25px 50px rgba(0,0,0,0.4); position: relative;
        }
        .qr-frame {
            border: 2px dashed var(--accent-blue); border-radius: 18px; padding: 16px;
            display: inline-flex; align-items: center; justify-content: center; margin-bottom: 14px;
            position: relative; animation: qrPulse 3s ease-in-out infinite; transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275); cursor: pointer; overflow: hidden;
        }
        @keyframes qrPulse {
            0%, 100% { border-color: rgba(56,189,248,0.5); box-shadow: 0 0 10px rgba(56,189,248,0.2); transform: scale(1); }
            50% { border-color: rgba(16,185,129,0.9); box-shadow: 0 0 25px rgba(16,185,129,0.4); transform: scale(1.02); }
        }
        .qr-frame::after {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 3px;
            background: linear-gradient(90deg, transparent, var(--accent-red), transparent);
            box-shadow: 0 0 10px var(--accent-red), 0 0 20px var(--accent-red);
            animation: laserScan 2.5s ease-in-out infinite alternate; opacity: 0.8; pointer-events: none;
        }
        @keyframes laserScan { 0% { top: 10%; } 100% { top: 90%; } }
        .qr-frame:hover {
            transform: scale(1.08) translateY(-4px) rotate(2deg);
            border-color: var(--accent-red);
            box-shadow: 0 0 45px rgba(244, 63, 94, 0.7), inset 0 0 15px rgba(244, 63, 94, 0.2);
            background: rgba(244, 63, 94, 0.08);
        }
        .qr-frame:hover .qr-svg { filter: drop-shadow(0 0 10px rgba(244, 63, 94, 0.9)); transform: scale(1.06) rotate(-2deg); }
        .qr-svg { width: 170px; height: 170px; fill: #030712; transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275), filter 0.4s ease; }
        .qr-card .scan-label { font-size: 13px; color: #64748b; margin: 0 0 2px 0; }
        .qr-card .scan-title { font-size: 16px; font-weight: 900; color: var(--accent-blue); margin: 0 0 6px 0; }
        .qr-hourly-badge {
            display: inline-flex; align-items: center; gap: 6px;
            background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.4);
            color: #059669; font-size: 11px; font-weight: 800; padding: 4px 12px; border-radius: 20px;
        }
        .qr-hourly-badge .hour-dot { width: 6px; height: 6px; border-radius: 50%; background: #059669; animation: pulseDot 1s infinite; }

        @media (max-width: 900px) {
            .get-app-section { grid-template-columns: 1fr; padding: 32px; }
            .qr-card { max-width: 300px; margin: 0 auto; }
        }

        /* TESTIMONIALS SECTION */
        .testimonial-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 45px; }
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
            .testimonial-grid { grid-template-columns: 1fr; }
            .sponsors-strip { justify-content: center; }
        }

        /* 🌟 GRAND FOOTER */
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

    <!-- ========================================================= -->
    <!-- NEW ADDITIONS (overrides + new sections CSS)              -->
    <!-- ========================================================= -->
    <style>
        /* Gallery images: sab same size, poora fit */
        .image-showcase-wrapper { height: 240px !important; flex-grow: 0 !important; overflow: hidden; }
        .image-showcase-wrapper img {
            width: 100% !important; height: 100% !important; max-height: none !important;
            object-fit: cover !important; object-position: center; padding: 0 !important;
        }

        /* About video: controls hide (size same) */
        .about-us-video-wrap video { pointer-events: none; }
        .about-us-video-wrap video::-webkit-media-controls,
        .about-us-video-wrap video::-webkit-media-controls-enclosure,
        .about-us-video-wrap video::-webkit-media-controls-panel,
        .about-us-video-wrap video::-webkit-media-controls-play-button,
        .about-us-video-wrap video::-webkit-media-controls-mute-button,
        .about-us-video-wrap video::-webkit-media-controls-overflow-button,
        .about-us-video-wrap video::-webkit-media-controls-fullscreen-button {
            display: none !important; opacity: 0 !important; -webkit-appearance: none;
        }

        /* New sections */
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

    <script>
        /* ================= 🎬 VIDEO PLAYER (YouTube in-page + MP4) ================= */
        function getYouTubeId(url) {
            const m = url.match(/(?:youtu\.be\/|v=|embed\/|shorts\/)([\w-]{11})/);
            return m ? m[1] : null;
        }

        let ytPlayer = null;
        let ytApiQueue = [];

        function loadYouTubeApi(cb) {
            if (window.YT && YT.Player) { cb(); return; }
            ytApiQueue.push(cb);
            if (!document.getElementById('yt-api-script')) {
                const s = document.createElement('script');
                s.id = 'yt-api-script';
                s.src = 'https://www.youtube.com/iframe_api';
                document.head.appendChild(s);
                window.onYouTubeIframeAPIReady = function () {
                    ytApiQueue.forEach(fn => fn());
                    ytApiQueue = [];
                };
            }
        }

        function showVideoError() {
            document.getElementById('videoPlayer').innerHTML =
                '<div class="video-error"><i class="fa-solid fa-triangle-exclamation"></i>' +
                'Is video ke owner ne website par play karne ki permission nahi di.<br>Koi doosri video ka link use karo.</div>';
        }

        function openVideo(url) {
            const box = document.getElementById('videoPlayer');
            const id = getYouTubeId(url);
            document.getElementById('videoModal').style.display = 'flex';

            if (id) {
                box.innerHTML = '<div id="ytFrame"></div>';
                loadYouTubeApi(function () {
                    if (!document.getElementById('ytFrame')) return;
                    ytPlayer = new YT.Player('ytFrame', {
                        videoId: id,
                        host: 'https://www.youtube-nocookie.com',
                        playerVars: {
                            autoplay: 1, 
                            rel: 0,                    /* Hide related videos from other channels */
                            modestbranding: 1,         /* Hide YouTube branding logo */
                            iv_load_policy: 3,         /* Hide video annotations */
                            playsinline: 1, 
                            fs: 1, 
                            controls: 0,               /* Hide playback controls */
                            disablekb: 1,              /* Disable keyboard controls */
                            origin: window.location.origin
                        },
                        events: {
                            onReady: function (e) { e.target.playVideo(); },
                            onError: showVideoError
                        }
                    });
                });
            } else {
                box.innerHTML = '<video src="' + url + '" controls autoplay playsinline ' +
                    'style="position:absolute;top:0;left:0;width:100%;height:100%;"></video>';
            }
        }

        function closeVideo() {
            if (ytPlayer && ytPlayer.destroy) { ytPlayer.destroy(); ytPlayer = null; }
            document.getElementById('videoPlayer').innerHTML = '';
            document.getElementById('videoModal').style.display = 'none';
        }

        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeVideo();
        });

        window.addEventListener('DOMContentLoaded', () => {
            const autoVid = document.getElementById('aboutAutoVideo');
            if (autoVid) {
                autoVid.play().catch(error => {
                    console.log("Autoplay prevented by browser policy:", error);
                });
            }
        });
    </script>
</head>
<body>

    <!-- 🌟 STICKY TOP NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="container">

        <!-- 🌟 HERO BANNER -->
        <div class="hero-banner">
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

        <!-- 🌟 RUNNING TICKER -->
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

        <!-- 🌟 ABOUT US -->
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

        <!-- 🌟 SHOWCASE GALLERY -->
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

            <!-- Video 2 (Fixed Thumbnail URL) -->
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
                    <div class="nx-team">🔥 Royal Hawks</div><div class="nx-vs">VS</div><div class="nx-team">🌪️ Thunder Kings</div>
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
                <div id="videoPlayer" style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px; background: #000;"></div>
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

    <!-- 🌟 GRAND FOOTER INCLUDE -->
    <jsp:include page="footer.jsp" />

    <!-- 🌟 CHATBOT & SCROLL TO TOP INCLUDE -->
    <jsp:include page="chatbot.jsp" />

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        window.addEventListener('load', function () {
            var v = document.getElementById('aboutAutoVideo');
            if (v) { v.removeAttribute('controls'); v.controls = false; v.play().catch(function(){}); }
        });
    </script>
</body>
</html>