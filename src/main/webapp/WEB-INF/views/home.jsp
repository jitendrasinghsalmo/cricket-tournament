<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
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

        /* 🌟 STICKY TOP NAVBAR */
        nav {
            background: rgba(13, 18, 30, 0.9);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
            padding: 12px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            transition: box-shadow 0.3s ease, background 0.3s ease;
        }
        nav.scrolled { box-shadow: 0 10px 30px rgba(0,0,0,0.5); background: rgba(3, 7, 18, 0.96); }

        .nav-left { display: flex; align-items: center; gap: 30px; }
        .logo-box { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-icon { background: var(--accent-blue); color: #030712; width: 32px; height: 32px; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 16px; box-shadow: 0 0 12px rgba(56,189,248,0.4); }
        .logo-text { font-weight: 800; font-size: 17px; color: var(--text-main); letter-spacing: 0.5px; }
        .logo-text span { display: block; font-size: 9px; color: var(--accent-blue); letter-spacing: 1.5px; text-transform: uppercase; }

        .nav-links { list-style: none; margin: 0; padding: 0; display: flex; gap: 22px; align-items: center; }
        .nav-links a { color: var(--text-muted); text-decoration: none; font-size: 13.5px; font-weight: 600; transition: color 0.2s; }
        .nav-links a:hover, .nav-links a.active { color: var(--accent-blue); text-shadow: 0 0 10px rgba(56,189,248,0.4); }

        .nav-right { display: flex; align-items: center; gap: 15px; position: relative; }
        
        /* SEARCH BAR STYLES */
        .search-form { display: flex; align-items: center; gap: 6px; background: rgba(3,7,18,0.6); border: 1px solid var(--border-color); border-radius: 20px; padding: 4px 12px; }
        .search-input { background: transparent; border: none; color: var(--text-main); font-size: 12px; outline: none; width: 140px; }
        .search-input::placeholder { color: var(--text-muted); }

        /* PROFILE DROPDOWN */
        .profile-menu-container { position: relative; display: inline-block; }
        .user-pill {
            display: flex; align-items: center; gap: 8px; background: rgba(3,7,18,0.6);
            border: 1px solid var(--border-color); padding: 5px 14px 5px 6px; border-radius: 22px; cursor: pointer;
            transition: all 0.2s;
        }
        .user-pill:hover { border-color: var(--accent-blue); }
        .user-avatar { width: 32px; height: 32px; background: var(--accent-blue); color: #030712; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 12px; font-weight: bold; overflow: hidden; }
        .user-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .user-name { font-size: 12.5px; font-weight: 600; color: var(--text-main); }

        .dropdown-content {
            display: none; position: absolute; right: 0; top: 48px; background: #0e121c;
            min-width: 260px; border: 1px solid var(--border-color); border-radius: 14px; box-shadow: 0 15px 35px rgba(0,0,0,0.6); z-index: 100; padding: 18px;
        }
        .dropdown-content.show { display: block; }
        .dropdown-content p { margin: 6px 0; font-size: 12.5px; color: var(--text-muted); word-break: break-all; }
        .dropdown-content p strong { color: var(--text-main); }
        .dropdown-divider { height: 1px; background: var(--border-color); margin: 10px 0; }
        .upload-label { font-size: 11.5px; color: var(--accent-blue); font-weight: 700; cursor: pointer; display: block; margin-top: 8px; }
        .upload-label:hover { color: #fff; }
        .dropdown-content a { color: var(--accent-blue); text-decoration: none; font-size: 12px; display: block; margin-top: 6px; font-weight: 600; }
        .dropdown-content a.logout { color: var(--accent-red); }

        /* CONTAINER */
        .container { max-width: 1350px; margin: 30px auto; padding: 0 20px; }

        /* 🌟 FIRST SECTION: CINEMATIC GLOW ANIMATION HERO (NO BORDER) */
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
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.16) 0%, rgba(16, 185, 129, 0.10) 35%, transparent 70%);
            animation: rotateGlow 12s linear infinite;
            z-index: 1;
        }

        .hero-banner::after {
            content: '';
            position: absolute;
            bottom: -60%; right: -40%;
            width: 180%; height: 180%;
            background: radial-gradient(circle, rgba(244, 63, 94, 0.12) 0%, rgba(245, 158, 11, 0.08) 40%, transparent 70%);
            animation: rotateGlowReverse 18s linear infinite;
            z-index: 1;
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
            border: 1.5px solid rgba(16, 185, 129, 0.5); border-radius: 20px;
            overflow: hidden;
            display: flex; align-items: center; justify-content: center;
            background:
                radial-gradient(circle at 25% 15%, rgba(16, 185, 129, 0.30), transparent 55%),
                radial-gradient(circle at 85% 85%, rgba(56, 189, 248, 0.30), transparent 55%),
                linear-gradient(135deg, rgba(6, 78, 59, 0.55), rgba(3, 7, 18, 0.95));
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.3);
            animation: floatArt 4s ease-in-out infinite alternate;
        }

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
        .live-scoreboard .team-row {
            display: flex; justify-content: space-between; align-items: center;
            font-size: 13.5px; font-weight: 700; color: #fff; padding: 3px 0;
        }
        .live-scoreboard .team-score { color: var(--accent-blue); font-weight: 900; }
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

        @keyframes floatArt {
            0% { transform: translateY(0px) scale(1); }
            100% { transform: translateY(-10px) scale(1.02); }
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
        .stat-card { background: var(--bg-card); border: 1px solid var(--border-color); border-radius: 16px; padding: 22px; transition: transform 0.2s; display: flex; align-items: center; gap: 16px; }
        .stat-card:hover { transform: translateY(-4px); border-color: var(--accent-blue); }
        .stat-icon-badge {
            width: 46px; height: 46px; border-radius: 12px; flex-shrink: 0;
            background: rgba(56, 189, 248, 0.12); display: flex; align-items: center; justify-content: center; font-size: 19px;
        }
        .stat-card h4 { color: var(--text-muted); font-size: 11.5px; text-transform: uppercase; letter-spacing: 0.5px; margin: 0 0 8px 0; font-weight: 700; display: flex; align-items: center; gap: 8px; }
        .stat-card .val { font-size: 26px; font-weight: 900; margin: 0; color: var(--text-main); }

        /* QUICK ACTION HUB */
        .card-box { background: var(--bg-card); border: 1px solid var(--border-color); border-radius: 18px; padding: 28px; margin-bottom: 40px; box-shadow: 0 10px 30px rgba(0,0,0,0.3); }
        .card-box h3 { font-size: 17px; margin: 0 0 18px 0; font-weight: 800; color: var(--text-main); display: flex; align-items: center; gap: 10px; }
        .quick-nav-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; }
        @media (max-width: 700px) { .quick-nav-grid { grid-template-columns: repeat(2, 1fr); } }
        .quick-nav-item {
            background: rgba(3,7,18,0.7); border: 1px solid var(--border-color); padding: 20px 15px;
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

        /* 🌟 ABOUT US (NO BORDER, ACTUAL REAL VIDEO LEFT WITH CINEMATIC ZOOM ANIMATION, BIG TITLE + TEXT RIGHT) */
        .about-us-section {
            position: relative;
            display: grid; grid-template-columns: 1.1fr 1fr; gap: 50px; align-items: center;
            background: transparent;
            border: none;
            border-radius: 0;
            padding: 20px 0; margin-bottom: 45px; box-shadow: none;
            overflow: hidden;
        }
        .about-us-video-wrap {
            position: relative; z-index: 2; width: 100%; height: 520px; border-radius: 20px; overflow: hidden;
            box-shadow: 0 20px 45px rgba(0,0,0,0.55); border: 1.5px solid rgba(56, 189, 248, 0.35);
            background: #000;
        }
        .about-us-video-wrap video {
            width: 100%; height: 100%; object-fit: cover; display: block;
            animation: cinematicZoom 10s ease-in-out infinite alternate;
        }
        @keyframes cinematicZoom {
            0% { transform: scale(1); filter: brightness(1); }
            50% { transform: scale(1.07); filter: brightness(1.15) contrast(1.05); }
            100% { transform: scale(1); filter: brightness(1); }
        }
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
        .about-us-stats { display: flex; gap: 30px; margin-top: 24px; padding-top: 20px; border-top: 1px solid var(--border-color); }
        .about-us-stats .stat-item h3 { margin: 0; font-size: 22px; font-weight: 900; color: var(--accent-blue); }
        .about-us-stats .stat-item span { font-size: 11px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; font-weight: 700; }

        @media (max-width: 900px) {
            .about-us-section { grid-template-columns: 1fr; padding: 0; }
            .about-us-stats { flex-wrap: wrap; }
        }

        /* 🌟 3RD SECTION: PERFECT 3-3 GRID FOR TOURNAMENT SHOWCASE GALLERY (WITH REAL VIDEOS) */
        .images-showcase-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 45px; }
        .image-showcase-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.4); transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }
        .image-showcase-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-blue);
            box-shadow: 0 25px 50px rgba(56, 189, 248, 0.35);
        }
        .image-showcase-wrapper { width: 100%; height: 280px; background: #000; overflow: hidden; position: relative; }
        .image-showcase-wrapper video {
            width: 100%; height: 100%; object-fit: cover; display: block;
            transition: transform 0.5s ease, filter 0.5s ease;
        }
        .image-showcase-card:hover .image-showcase-wrapper video {
            transform: scale(1.08);
            filter: brightness(1.2) contrast(1.1);
        }
        .image-showcase-body { padding: 18px; }
        .image-showcase-body h5 { margin: 0 0 4px 0; font-size: 16px; font-weight: 800; color: var(--text-main); }
        .image-showcase-body p { margin: 0; font-size: 12.5px; color: var(--text-muted); }

        /* VIDEO HIGHLIGHTS GRID (3-3 GRID WITH HOVER PULSE ANIMATION) */
        .video-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 60px; }
        .video-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; overflow: hidden;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5); transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }
        .video-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-blue);
            box-shadow: 0 25px 50px rgba(56, 189, 248, 0.35);
        }
        .video-wrapper { position: relative; width: 100%; height: 280px; background: #000; overflow: hidden; }
        .video-wrapper video {
            width: 100%; height: 100%; object-fit: cover; display: block;
            transition: transform 0.5s ease, filter 0.5s ease;
        }
        .video-card:hover .video-wrapper video {
            transform: scale(1.08);
            filter: brightness(1.2) contrast(1.1);
        }
        
        /* Play Overlay Icon Animation on Hover */
        .video-wrapper::after {
            content: '\f04b'; font-family: 'Font Awesome 6 Free'; font-weight: 900;
            position: absolute; inset: 0; display: flex; align-items: center; justify-content: center;
            font-size: 32px; color: #fff; background: rgba(3, 7, 18, 0.4);
            opacity: 0; transition: opacity 0.3s ease; pointer-events: none;
            text-shadow: 0 0 15px rgba(56, 189, 248, 0.8);
        }
        .video-card:hover .video-wrapper::after { opacity: 1; }

        .video-content { padding: 18px; }
        .video-content h5 { margin: 0 0 6px 0; font-size: 15px; font-weight: 800; color: var(--text-main); }
        .video-content p { margin: 0; font-size: 12px; color: var(--text-muted); line-height: 1.4; }

        /* GRAND FOOTER */
        .grand-footer-section {
            background: var(--bg-card); backdrop-filter: blur(20px);
            border: 1px solid var(--border-color); border-radius: 24px;
            padding: 40px; box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            max-width: 1350px; margin: 60px auto 20px auto;
        }
        .grand-footer-content {
            display: grid; grid-template-columns: 2fr 1fr 1fr 1fr; gap: 30px; align-items: start;
            border-bottom: 1px solid var(--border-color); padding-bottom: 30px; margin-bottom: 25px;
        }
        .footer-brand h3 { margin: 0 0 8px 0; font-size: 18px; font-weight: 800; text-transform: uppercase; color: var(--text-main); letter-spacing: 1px; }
        .footer-brand h3 span { color: var(--accent-blue); }
        .footer-brand p { margin: 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.6; }
        .footer-links h4 { margin: 0 0 12px 0; font-size: 13px; font-weight: 700; text-transform: uppercase; color: var(--text-main); letter-spacing: 0.5px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 10px; }
        .footer-links a { color: var(--text-muted); text-decoration: none; font-size: 12.5px; font-weight: 600; transition: color 0.2s; }
        .footer-links a:hover { color: var(--accent-blue); }
        .footer-bottom-bar { text-align: center; color: var(--text-muted); font-size: 11.5px; letter-spacing: 0.5px; }

        /* 🌟 TOP PERFORMERS LEADERBOARD */
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

        /* 🌟 CTA BANNER */
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
        }

        /* 🌟 GET THE APP SECTION (WITH LIVE HOURLY PULSE AND ADVANCED ANIMATED HOVER QR) */
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
        
        /* 🌟 ADVANCED ANIMATED QR FRAME CONTAINER */
        .qr-frame {
            border: 2px dashed var(--accent-blue); border-radius: 18px; padding: 16px;
            display: inline-flex; align-items: center; justify-content: center; margin-bottom: 14px;
            position: relative;
            animation: qrPulse 3s ease-in-out infinite;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            cursor: pointer;
            overflow: hidden;
        }
        @keyframes qrPulse {
            0%, 100% { border-color: rgba(56,189,248,0.5); box-shadow: 0 0 10px rgba(56,189,248,0.2); transform: scale(1); }
            50% { border-color: rgba(16,185,129,0.9); box-shadow: 0 0 25px rgba(16,185,129,0.4); transform: scale(1.02); }
        }
        
        /* 🌟 DYNAMIC LASER SCANNER LINE ANIMATION OVER QR */
        .qr-frame::after {
            content: '';
            position: absolute;
            top: 0; left: 0; width: 100%; height: 3px;
            background: linear-gradient(90deg, transparent, var(--accent-red), transparent);
            box-shadow: 0 0 10px var(--accent-red), 0 0 20px var(--accent-red);
            animation: laserScan 2.5s ease-in-out infinite alternate;
            opacity: 0.8;
            pointer-events: none;
        }
        @keyframes laserScan {
            0% { top: 10%; }
            100% { top: 90%; }
        }

        /* 🌟 MULTI-LAYERED HOVER TRANSFORMATION ON QR CARD */
        .qr-frame:hover {
            transform: scale(1.08) translateY(-4px) rotate(2deg);
            border-color: var(--accent-red);
            box-shadow: 0 0 45px rgba(244, 63, 94, 0.7), inset 0 0 15px rgba(244, 63, 94, 0.2);
            background: rgba(244, 63, 94, 0.08);
        }
        .qr-frame:hover .qr-svg {
            filter: drop-shadow(0 0 10px rgba(244, 63, 94, 0.9));
            transform: scale(1.06) rotate(-2deg);
        }

        .qr-svg { 
            width: 170px; height: 170px; fill: #030712; 
            transition: transform 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275), filter 0.4s ease;
        }
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

        /* 🌟 TESTIMONIALS SECTION */
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

        /* 🌟 SPONSORS / PARTNERS STRIP */
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

        /* 🌟 ENHANCED AI CHATBOT STYLES */
        .chatbot-btn { 
            position: fixed; top: 70px; right: 25px; background: var(--accent-blue); color: #030712; 
            width: 50px; height: 50px; border-radius: 14px; display: flex; align-items: center; justify-content: center; 
            font-size: 20px; cursor: pointer; box-shadow: 0 0 25px rgba(56,189,248,0.5); z-index: 1000; border: none; 
            transition: all 0.3s ease; font-weight: bold;
        }
        .chatbot-btn:hover { 
            transform: scale(1.12) rotate(5deg); 
            background: #0284c7;
            box-shadow: 0 0 40px rgba(56,189,248,0.8);
        }
        
        .chat-window {
            position: fixed; top: 135px; right: 25px; width: 360px; height: 450px;
            background: linear-gradient(135deg, #0d121e 0%, #0a0f1d 100%); 
            border: 1.5px solid var(--border-color); border-radius: 18px;
            box-shadow: 0 25px 60px rgba(0,0,0,0.7); z-index: 1001; display: none; 
            flex-direction: column; overflow: hidden; backdrop-filter: blur(20px);
        }
        .chat-window.open { display: flex; animation: slideUp 0.3s ease; }
        @keyframes slideUp {
            from { transform: translateY(20px); opacity: 0; }
            to { transform: translateY(0); opacity: 1; }
        }
        
        .chat-header { 
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.2) 0%, rgba(16, 185, 129, 0.1) 100%);
            padding: 14px 18px; border-bottom: 1.5px solid var(--border-color); 
            display: flex; justify-content: space-between; align-items: center; 
            font-weight: 800; font-size: 14px; color: var(--accent-blue);
        }
        .chat-header button { 
            background: none; border: none; color: var(--text-muted); font-size: 18px; 
            cursor: pointer; transition: all 0.2s;
        }
        .chat-header button:hover { color: var(--accent-red); }
        
        .chat-body { 
            flex: 1; padding: 16px; overflow-y: auto; display: flex; flex-direction: column; 
            gap: 12px; font-size: 13px;
        }
        .chat-body::-webkit-scrollbar { width: 6px; }
        .chat-body::-webkit-scrollbar-track { background: rgba(56,189,248,0.1); border-radius: 10px; }
        .chat-body::-webkit-scrollbar-thumb { background: rgba(56,189,248,0.3); border-radius: 10px; }
        
        .chat-msg { padding: 10px 14px; border-radius: 12px; max-width: 88%; line-height: 1.5; word-wrap: break-word; }
        .chat-msg.bot { 
            background: rgba(56, 189, 248, 0.12); color: #e0f2fe; align-self: flex-start; 
            border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 12px 12px 12px 3px;
        }
        .chat-msg.user { 
            background: linear-gradient(135deg, #38bdf8, #0284c7); color: #030712; 
            align-self: flex-end; font-weight: 600; border-radius: 12px 12px 3px 12px;
            box-shadow: 0 4px 12px rgba(56,189,248,0.3);
        }
        .chat-msg span { display: block; }
        
        .chat-footer { 
            padding: 12px; border-top: 1.5px solid var(--border-color); 
            display: flex; gap: 8px; background: rgba(3,7,18,0.9); align-items: center;
        }
        .chat-footer input { 
            flex: 1; background: rgba(255,255,255,0.05); border: 1px solid var(--border-color); 
            border-radius: 8px; padding: 8px 12px; color: #fff; font-size: 13px; 
            outline: none; transition: all 0.2s;
        }
        .chat-footer input:focus { 
            border-color: var(--accent-blue); 
            background: rgba(56,189,248,0.08);
            box-shadow: 0 0 10px rgba(56,189,248,0.2);
        }
        .chat-footer button { 
            background: linear-gradient(135deg, #38bdf8, #0284c7); color: #030712; 
            border: none; border-radius: 8px; padding: 8px 12px; font-weight: 700; 
            font-size: 12px; cursor: pointer; transition: all 0.2s; width: 40px;
            display: flex; align-items: center; justify-content: center;
        }
        .chat-footer button:hover { transform: scale(1.08); }
        
        .ai-typing { 
            font-size: 12px; color: var(--accent-blue); padding: 0 16px 5px 16px; 
            display: none; font-style: italic;
        }

        /* SCROLL TO TOP */
        .scroll-top { 
            position: fixed; bottom: 25px; right: 90px; background: rgba(56, 189, 248, 0.15); 
            color: var(--accent-blue); width: 50px; height: 50px; border-radius: 50%; 
            display: flex; align-items: center; justify-content: center; cursor: pointer; 
            border: 1.5px solid var(--border-color); transition: all 0.3s ease; 
            opacity: 0; visibility: hidden; z-index: 999;
        }
        .scroll-top.show { opacity: 1; visibility: visible; }
        .scroll-top:hover { 
            background: rgba(56, 189, 248, 0.25); 
            transform: translateY(-4px);
            box-shadow: 0 0 20px rgba(56,189,248,0.4);
        }
    </style>
    <script>
        function toggleProfileMenu(event) {
            event.stopPropagation();
            document.getElementById("profileDropdown").classList.toggle("show");
        }
        window.onclick = function(event) {
            if (!event.target.closest('.profile-menu-container')) {
                var dropdowns = document.getElementsByClassName("dropdown-content");
                for (var i = 0; i < dropdowns.length; i++) {
                    var openDropdown = dropdowns[i];
                    if (openDropdown.classList.contains('show')) openDropdown.classList.remove('show');
                }
            }
        }

        function previewProfilePic(event) {
            const file = event.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    const avatarDiv = document.getElementById('userAvatarContainer');
                    avatarDiv.innerHTML = '<img src="' + e.target.result + '" alt="Profile">';
                    localStorage.setItem('user_profile_pic', e.target.result);
                }
                reader.readAsDataURL(file);
            }
        }

        window.addEventListener('DOMContentLoaded', () => {
            const savedPic = localStorage.getItem('user_profile_pic');
            if (savedPic) {
                document.getElementById('userAvatarContainer').innerHTML = '<img src="' + savedPic + '" alt="Profile">';
            }

            const now = new Date();
            const currentHour = now.getHours();
            const formattedHour = currentHour % 12 === 0 ? 12 : currentHour % 12;
            const ampm = currentHour >= 12 ? 'PM' : 'AM';
            const hourlyTextEl = document.getElementById('hourlyActiveText');
            if (hourlyTextEl) {
                hourlyTextEl.innerText = `${formattedHour}:00 ${ampm} Active Sync`;
            }
        });
    </script>
</head>
<body>

    <!-- 🌟 STICKY TOP NAVBAR -->
    <nav>
        <div class="nav-left">
            <a href="/home" class="logo-box">
                <div class="logo-icon">P</div>
                <div class="logo-text">ProMatch Arena <span>Tournament Control</span></div>
            </a>
            <ul class="nav-links d-none d-md-flex">
                <li><a href="/home" class="active">Home</a></li>
                <li><a href="/teams">View Teams</a></li>
                <li><a href="/matches">Matches</a></li>
                <li><a href="/tournaments">Tournaments</a></li>
                <li><a href="/pointsTable">Points Table</a></li>
            </ul>
        </div>

        <div class="nav-right">
            <form action="/search" method="get" class="search-form">
                <input type="text" name="keyword" class="search-input" placeholder="Search team, player..." required>
                <button type="submit" style="background:none; border:none; color:var(--accent-blue); cursor:pointer; font-size:12px;"><i class="fa-solid fa-magnifying-glass"></i></button>
            </form>

            <div class="profile-menu-container">
                <div class="user-pill" onclick="toggleProfileMenu(event)">
                    <div class="user-avatar" id="userAvatarContainer">
                        ${not empty sessionScope.user.name ? sessionScope.user.name.charAt(0) : 'J'}
                    </div>
                    <div class="user-name d-none d-sm-inline">${not empty sessionScope.user.name ? sessionScope.user.name : 'Jitendra'}</div>
                    <span style="font-size: 10px; color: var(--text-muted);">▼</span>
                </div>

                <div id="profileDropdown" class="dropdown-content">
                    <h4 style="margin: 0 0 10px 0; font-size: 14px; color: var(--text-main); font-weight:800; border-bottom:1px solid var(--border-color); padding-bottom:8px;">Account Profile</h4>
                    <p><strong>Name:</strong> ${not empty sessionScope.user.name ? sessionScope.user.name : 'Jitendra Singh'}</p>
                    <p><strong>Email:</strong> ${not empty sessionScope.user.email ? sessionScope.user.email : 'jitendrasingh07022004@gmail.com'}</p>
                    <p><strong>Role:</strong> <span style="color: var(--accent-blue); font-weight: 700;">${not empty sessionScope.user.role ? sessionScope.user.role : 'ADMIN'}</span></p>
                    
                    <label class="upload-label">
                        <i class="fa-solid fa-camera me-1"></i> Change Profile Photo
                        <input type="file" accept="image/*" style="display: none;" onchange="previewProfilePic(event)">
                    </label>

                    <div class="dropdown-divider"></div>
                    <a href="/logout" class="logout">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">

        <!-- 🌟 FIRST SECTION: CINEMATIC GLOW ANIMATION HERO (NO BORDER) -->
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

        <!-- 🌟 RUNNING TICKER (MULTIPLE TEXT SNIPPETS RUNNING CONTINUOUSLY) -->
        <div class="running-ticker">
            <marquee behavior="scroll" direction="left" scrollamount="6">
                <span>⚡ Welcome to ProMatch Arena</span>&bull;&bull;&bull;<span>🏆 Season 2026 Live Matchdays Underway</span>&bull;&bull;&bull;<span>📊 Automated NRR & Tournament Control Center</span>&bull;&bull;&bull;<span>🚀 Register your teams and squads today!</span>
            </marquee>
        </div>

        <!-- STATS WIDGETS -->
        <div class="stats-grid">
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-calendar-days text-info"></i></div>
                <div>
                    <h4>Total Tournaments</h4>
                    <p class="val">4</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-users text-success"></i></div>
                <div>
                    <h4>Registered Teams</h4>
                    <p class="val">12</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-bolt text-warning"></i></div>
                <div>
                    <h4>Total Matches</h4>
                    <p class="val">128</p>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon-badge"><i class="fa-solid fa-tower-broadcast text-danger"></i></div>
                <div>
                    <h4>Active Seasons</h4>
                    <p class="val" style="color: var(--accent-green);">1 Live</p>
                </div>
            </div>
        </div>

        <!-- QUICK NAVIGATION HUB (3-3 GRID) -->
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

        <!-- 🌟 ABOUT US (NO BORDER, ACTUAL REAL VIDEO LEFT WITH CINEMATIC ZOOM ANIMATION, BIG TITLE + TEXT RIGHT) -->
        <div class="about-us-section">
            <div class="about-us-video-wrap">
                <span class="about-us-video-tag"><span class="dot"></span> Live Preview</span>
                <video autoplay muted loop playsinline>
                    <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-player-hitting-a-ball-41267-large.mp4" type="video/mp4">
                    Your browser does not support the video tag.
                </video>
            </div>
            <div class="about-us-text">
                <h2>About <span>ProMatch Arena</span></h2>
                <p><strong>ProMatch Arena</strong> is India's most loved cricket tournament and match discovery platform. We connect millions of users and local teams every day, offering seamless team registration, live match scheduling, and a rich sports analytics experience.</p>
                <p>Founded to transform how people discover and manage cricket leagues, ProMatch Arena brings complete tournament control directly to your fingertips. With features like real-time squad controls, automated Net Run Rate (NRR) calculators, and secure role-based administration, we ensure organizers and players make informed competitive choices. Whether you are managing local gully tournaments or professional league cups, ProMatch Arena brings it to your dashboard fast and fresh.</p>
                <ul class="about-us-features">
                    <li><i class="fa-solid fa-check"></i> Real-time live match scoring & ball-by-ball updates</li>
                    <li><i class="fa-solid fa-check"></i> Automated Net Run Rate & points table calculation</li>
                    <li><i class="fa-solid fa-check"></i> Secure role-based team registration & squad management</li>
                </ul>
                <div class="about-us-stats">
                    <div class="stat-item">
                        <h3>4+</h3>
                        <span>Tournaments</span>
                    </div>
                    <div class="stat-item">
                        <h3>12+</h3>
                        <span>Teams</span>
                    </div>
                    <div class="stat-item">
                        <h3>128+</h3>
                        <span>Matches</span>
                    </div>
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

        <!-- 🌟 TOURNAMENT SHOWCASE GALLERY (3-3 GRID WITH REAL VIDEOS) -->
        <div class="section-title">
            <span>Tournament Showcase Gallery</span>
            <span style="font-size: 12px; color: var(--accent-green);">Visuals Feed 🎥</span>
        </div>

        <div class="images-showcase-grid">
            <div class="image-showcase-card">
                <div class="image-showcase-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-player-hitting-a-ball-41267-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="image-showcase-body">
                    <h5>🏟️ Grand Arena Stadium</h5>
                    <p>World-class illumination designed for grand spectacles.</p>
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-young-man-playing-cricket-in-a-field-41264-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="image-showcase-body">
                    <h5>⚡ Precision Match Ball</h5>
                    <p>Engineered for high swing and seam accuracy.</p>
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-batsman-practicing-shots-41266-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="image-showcase-body">
                    <h5>🏆 Championship Trophy</h5>
                    <p>The ultimate silverware contested by elite squads.</p>
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-player-hitting-a-ball-41267-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="image-showcase-body">
                    <h5>🎯 Intensive Net Session</h5>
                    <p>Players sharpening their skills and mechanics daily.</p>
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-young-man-playing-cricket-in-a-field-41264-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="image-showcase-body">
                    <h5>🔥 Electric Fan Crowd</h5>
                    <p>Unmatched stadium atmosphere driven by supporters.</p>
                </div>
            </div>

            <div class="image-showcase-card">
                <div class="image-showcase-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-batsman-practicing-shots-41266-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="image-showcase-body">
                    <h5>📊 Pitch Telemetry</h5>
                    <p>Advanced performance metrics tracked instantly.</p>
                </div>
            </div>
        </div>

        <!-- VIDEO HIGHLIGHTS (WITH ACTUAL VIDEOS & ANIMATIONS) -->
        <div class="section-title">
            <span>Grand Arena Video Highlights</span>
            <span style="font-size: 12px; color: var(--accent-blue);">Action Reels ⚡</span>
        </div>

        <div class="video-grid">
            <div class="video-card">
                <div class="video-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-player-hitting-a-ball-41267-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="video-content">
                    <h5>🔥 Epic Last Over Finishes</h5>
                    <p>High-voltage drama and winning moments from league fixtures.</p>
                </div>
            </div>

            <div class="video-card">
                <div class="video-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-young-man-playing-cricket-in-a-field-41264-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="video-content">
                    <h5>⚡ Powerplay Boundary Showdown</h5>
                    <p>Explosive batting spells and massive sixes delivered by stars.</p>
                </div>
            </div>

            <div class="video-card">
                <div class="video-wrapper">
                    <video autoplay muted loop playsinline>
                        <source src="https://assets.mixkit.co/videos/preview/mixkit-cricket-batsman-practicing-shots-41266-large.mp4" type="video/mp4">
                    </video>
                </div>
                <div class="video-content">
                    <h5>🎯 Precision Bowling Spells</h5>
                    <p>Crushing yorkers and breakthrough wickets under floodlights.</p>
                </div>
            </div>
        </div>

        <!-- 🌟 TESTIMONIALS SECTION -->
        <div class="section-title">
            <span>What Organizers Say</span>
            <span style="font-size: 12px; color: var(--accent-blue);">Testimonials ⭐</span>
        </div>

        <div class="testimonial-grid">
            <div class="testimonial-card">
                <i class="fa-solid fa-quote-left quote-icon"></i>
                <p class="quote-text">ProMatch Arena ne humare local tournament ko completely paperless bana diya. Points table aur NRR automatic update hota hai, ab manual calculation ki zaroorat nahi.</p>
                <div class="testimonial-person">
                    <div class="testimonial-avatar">R</div>
                    <div>
                        <p class="testimonial-name">Rohit Verma</p>
                        <p class="testimonial-role">Tournament Organizer</p>
                        <div class="testimonial-stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <i class="fa-solid fa-quote-left quote-icon"></i>
                <p class="quote-text">Team registration aur squad management bahut smooth hai. Dashboard clean hai aur live matches track karna easy ho gaya hai.</p>
                <div class="testimonial-person">
                    <div class="testimonial-avatar">S</div>
                    <div>
                        <p class="testimonial-name">Sanya Kapoor</p>
                        <p class="testimonial-role">Team Captain</p>
                        <div class="testimonial-stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i></div>
                    </div>
                </div>
            </div>

            <div class="testimonial-card">
                <i class="fa-solid fa-quote-left quote-icon"></i>
                <p class="quote-text">Ek hi platform pe tournaments, matches, aur points table dekhna kaafi convenient hai. UI bhi kaafi modern aur fast lagta hai.</p>
                <div class="testimonial-person">
                    <div class="testimonial-avatar">A</div>
                    <div>
                        <p class="testimonial-name">Aman Sharma</p>
                        <p class="testimonial-role">Player & Fan</p>
                        <div class="testimonial-stars"><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- 🌟 SPONSORS / PARTNERS STRIP -->
        <div class="section-title">
            <span>Trusted By</span>
            <span style="font-size: 12px; color: var(--accent-green);">Partners 🤝</span>
        </div>

        <div class="sponsors-strip">
            <div class="sponsor-item"><i class="fa-solid fa-trophy"></i> Champions League</div>
            <div class="sponsor-item"><i class="fa-solid fa-shield-halved"></i> ArenaSports</div>
            <div class="sponsor-item"><i class="fa-solid fa-baseball-bat-ball"></i> ProCricket Gear</div>
            <div class="sponsor-item"><i class="fa-solid fa-broadcast-tower"></i> LiveStream+</div>
            <div class="sponsor-item"><i class="fa-solid fa-medal"></i> Elite Turf Co.</div>
        </div>

        <!-- 🌟 TOP PERFORMERS LEADERBOARD -->
        <div class="section-title">
            <span>Top Performers</span>
            <span style="font-size: 12px; color: var(--accent-amber);">Leaderboard 👑</span>
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

        <!-- 🌟 GET THE APP SECTION (WITH LIVE HOURLY PULSE & ENHANCED HOVER QR) -->
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

        <!-- 🌟 CTA BANNER -->
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

    <!-- GRAND FOOTER SECTION -->
    <!-- 🌟 FOOTER INCLUDE -->
    <jsp:include page="footer.jsp" />

    <!-- 🌟 ENHANCED SMART AI CHATBOT -->
    <button class="chatbot-btn" onclick="toggleChat()" title="💬 Chat with ProMatch AI">
        <i class="fa-solid fa-robot"></i>
    </button>

    <div class="chat-window" id="chatWindow">
        <div class="chat-header">
            <span>🤖 ProMatch Cricket AI</span>
            <button onclick="toggleChat()">&times;</button>
        </div>
        <div class="chat-body" id="chatBody">
            <div class="chat-msg bot"><span>👋 Namaste! Main ProMatch AI Assistant hoon. Aap mujhse kuch bhi pooch sakte ho - Teams, Matches, Points Table, Tournament info, ya koi bhi help chaiye!</span></div>
        </div>
        <div class="ai-typing" id="aiTyping"><i class="fa-solid fa-ellipsis"></i> ProMatch AI is thinking...</div>
        <div class="chat-footer">
            <input type="text" id="chatInput" placeholder="Kya poochna hai...?" onkeypress="handleChatKey(event)">
            <button onclick="sendChatMessage()" title="Send"><i class="fa-solid fa-paper-plane"></i></button>
        </div>
    </div>

    <button class="scroll-top" id="scrollTopBtn" onclick="scrollToTop()" title="Back to top">
        <i class="fa-solid fa-arrow-up"></i>
    </button>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // 🌟 ADVANCED CHATBOT KNOWLEDGE BASE
        const chatbotKB = {
            "register": "🛡️ Team Registration: /register-team page pe ja kar apna team register kar sakte ho. Sirf 2 minutes lagenge! Logo, team name, captain details dalni hogi.",
            "teams": "👥 Teams: View Teams section mein sab registered teams dekh sakte ho. Har team ke players, statistics aur performance details available hain.",
            "matches": "⚡ Matches: Live Matches section mein current matches, upcoming fixtures aur past results dekh sakte ho. Ball-by-ball updates real-time milte hain!",
            "points": "📊 Points Table: Har tournament ka complete standings aur NRR (Net Run Rate) automatically calculate hota hai. Rankings live update hoti hain.",
            "tournaments": "🏆 Tournaments: Multiple tournaments run kar sakte ho. Season 2026 mein 4 major tournaments chal rahe hain. 128+ matches already scheduled hain.",
            "nrr": "📈 NRR Calculator: Net Run Rate automatically calculate hota hai match complete hone ke baad. Ab manual calculation ki zaroorat nahi!",
            "squad": "👨‍💼 Squad Management: Apne team ke liye players add/remove kar sakte ho, jerseys assign kar sakte ho, aur squad update kar sakte ho anytime.",
            "admin": "🔐 Admin Features: ADMIN role ko special powers hain - tournaments create karna, matches control karna, teams manage karna sab possible hai.",
            "live": "📡 Live Scoring: Cricket balls pe ball scoreboard update hota hai. Real-time animations ke saath live experience milta hai!",
            "app": "📱 App: ProMatch Arena app download kar sakte ho Google Play ya App Store se. Push notifications ke through updates milte hain.",
            "help": "🆘 Help: Kya specific problem hai? Team register karna hai, points table dekhnaa hai, ya kuch aur? Mujhe bata do!",
            "hello": "👋 Hello! Main ProMatch Cricket AI hoon. Aapka welcome hai! Kya kaam karna hai?",
            "hi": "👋 Hii! 🏏 ProMatch Arena mein welcome! Kaise help kar sakta hoon?",
            "thanks": "🙏 Welcome! Agar aur kuch poochna ho to bilkul poocho!",
            "default": "🤔 Interesting question! Try: **register**, **teams**, **matches**, **points**, **tournaments**, **live**, **app**, **help**, **nrr**, **squad**"
        };

        function toggleChat() {
            const win = document.getElementById("chatWindow");
            win.classList.toggle("open");
            if (win.classList.contains("open")) {
                setTimeout(() => document.getElementById("chatInput").focus(), 100);
            }
        }

        function handleChatKey(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                sendChatMessage();
            }
        }

        function getChatbotResponse(userText) {
            const text = userText.toLowerCase().trim();
            
            // Check for keyword matches
            for (const [key, response] of Object.entries(chatbotKB)) {
                if (text.includes(key)) {
                    return response;
                }
            }
            
            // Check for common Hindi patterns
            if (text.includes("kya") || text.includes("hai") || text.includes("kaise")) {
                if (text.includes("register")) return chatbotKB["register"];
                if (text.includes("team")) return chatbotKB["teams"];
                if (text.includes("match")) return chatbotKB["matches"];
                if (text.includes("point") || text.includes("table")) return chatbotKB["points"];
                if (text.includes("tournament")) return chatbotKB["tournaments"];
            }
            
            return chatbotKB["default"];
        }

        function sendChatMessage() {
            const input = document.getElementById("chatInput");
            const body = document.getElementById("chatBody");
            const typingIndicator = document.getElementById("aiTyping");
            const text = input.value.trim();
            
            if (!text) return;

            // Add user message
            const userDiv = document.createElement("div");
            userDiv.className = "chat-msg user";
            userDiv.innerHTML = `<span>${text}</span>`;
            body.appendChild(userDiv);
            input.value = "";
            body.scrollTop = body.scrollHeight;

            // Show typing
            typingIndicator.style.display = "block";

            // AI response
            setTimeout(() => {
                typingIndicator.style.display = "none";
                const botDiv = document.createElement("div");
                botDiv.className = "chat-msg bot";
                const response = getChatbotResponse(text);
                botDiv.innerHTML = `<span>${response}</span>`;
                body.appendChild(botDiv);
                body.scrollTop = body.scrollHeight;
            }, 800);
        }

        // Scroll functions
        window.onscroll = function() {
            const btn = document.getElementById("scrollTopBtn");
            if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
                btn.classList.add("show");
            } else {
                btn.classList.remove("show");
            }

            const navEl = document.querySelector('nav');
            if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                navEl.classList.add('scrolled');
            } else {
                navEl.classList.remove('scrolled');
            }
        };

        function scrollToTop() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    </script>
</body>
</html>
