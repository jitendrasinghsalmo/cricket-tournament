<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Enterprise Architecture & Project Documentation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-main: #030712;
            --bg-card: rgba(13, 18, 30, 0.85);
            --accent-blue: #38bdf8;
            --accent-green: #10b981;
            --accent-amber: #f59e0b;
            --accent-rose: #f43f5e;
            --accent-gold: #ffd700;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border-color: rgba(56, 189, 248, 0.3);
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: #030712;
            color: var(--text-main);
            margin: 0;
            padding: 0;
            min-height: 100vh;
        }

        nav {
            background: rgba(13, 18, 30, 0.9);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
            padding: 14px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .back-btn {
            display: inline-flex; align-items: center; gap: 8px;
            background: rgba(56, 189, 248, 0.12); color: var(--accent-blue);
            border: 1px solid var(--border-color); padding: 10px 20px;
            border-radius: 12px; text-decoration: none; font-weight: 700; font-size: 13px;
            transition: all 0.25s ease;
        }
        .back-btn:hover { background: var(--accent-blue); color: #030712; box-shadow: 0 0 20px rgba(56,189,248,0.5); }

        .logo-box { display: flex; align-items: center; gap: 12px; text-decoration: none; }
        .logo-icon { background: var(--accent-blue); color: #030712; width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 18px; box-shadow: 0 0 15px rgba(56,189,248,0.5); }
        .logo-text { font-weight: 800; font-size: 17px; color: var(--text-main); letter-spacing: 0.5px; text-align: right; }
        .logo-text span { display: block; font-size: 9.5px; color: var(--accent-blue); letter-spacing: 2px; text-transform: uppercase; }

        .container { max-width: 1300px; margin: 45px auto; padding: 0 20px; }

        /* HERO SECTION */
        .about-hero {
            position: relative;
            background: linear-gradient(135deg, #030712 0%, #081126 25%, #05192d 50%, #061021 75%, #030712 100%);
            background-size: 400% 400%;
            animation: gradientMeshMove 12s ease infinite;
            border: 1.5px solid rgba(56, 189, 248, 0.5);
            border-radius: 30px;
            padding: 95px 50px;
            text-align: center;
            margin-bottom: 45px;
            box-shadow: 0 35px 70px rgba(0, 0, 0, 0.85), inset 0 0 60px rgba(56, 189, 248, 0.2);
            overflow: hidden;
        }

        @keyframes gradientMeshMove {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .hero-wave-light {
            position: absolute;
            width: 150%;
            height: 150%;
            top: -25%;
            left: -25%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.15) 0%, rgba(16, 185, 129, 0.1) 40%, transparent 70%);
            animation: waveRotation 15s linear infinite;
            pointer-events: none;
            z-index: 1;
        }

        @keyframes waveRotation {
            0% { transform: rotate(0deg) scale(1); }
            50% { transform: rotate(180deg) scale(1.15); }
            100% { transform: rotate(360deg) scale(1); }
        }

        .about-hero::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 5px;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-green), var(--accent-gold), var(--accent-blue));
            background-size: 300% 300%;
            animation: shimmerBeam 6s linear infinite;
            z-index: 3;
        }

        @keyframes shimmerBeam {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        .dynamic-hero-content {
            position: relative;
            z-index: 2;
            animation: floatUpDown 4s ease-in-out infinite;
        }

        @keyframes floatUpDown {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-8px); }
        }

        .about-hero h1 { font-size: 46px; font-weight: 900; margin-bottom: 20px; letter-spacing: 0.5px; }
        .about-hero h1 span { color: var(--accent-blue); text-shadow: 0 0 25px rgba(56,189,248,0.6); }
        .about-hero p { color: var(--text-muted); font-size: 16.5px; max-width: 880px; margin: 0 auto; line-height: 1.85; }
        
        .hero-badge {
            display: inline-flex; align-items: center; gap: 10px;
            background: rgba(56, 189, 248, 0.15); color: var(--accent-blue);
            border: 1px solid rgba(56, 189, 248, 0.5); padding: 9px 20px;
            border-radius: 30px; font-size: 13px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 1.5px; margin-bottom: 25px; box-shadow: 0 0 20px rgba(56,189,248,0.3);
        }

        /* ELITE CRICKET SHOWCASE */
        .elite-cricket-showcase {
            max-width: 1300px;
            margin: 0 auto 45px auto;
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.08), rgba(16, 185, 129, 0.08));
            border: 1.5px solid var(--border-color);
            border-radius: 28px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            position: relative;
            overflow: hidden;
        }
        .elite-showcase-title {
            text-align: center;
            font-size: 26px;
            font-weight: 900;
            margin-bottom: 12px;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-green), var(--accent-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .elite-showcase-subtitle {
            text-align: center;
            color: var(--text-muted);
            font-size: 14.5px;
            max-width: 700px;
            margin: 0 auto 35px auto;
            line-height: 1.6;
            font-weight: 600;
        }
        .elite-showcase-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 900px) { .elite-showcase-grid { grid-template-columns: 1fr; } }

        .elite-showcase-card {
            background: rgba(13, 18, 30, 0.88);
            border: 1.5px solid var(--border-color);
            border-radius: 20px;
            padding: 35px 25px;
            box-shadow: 0 12px 35px rgba(0,0,0,0.4);
            transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1);
            position: relative;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
        }
        .elite-showcase-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--accent-blue);
            box-shadow: 0 20px 45px rgba(56, 189, 248, 0.35);
            background: rgba(13, 18, 30, 0.96);
        }
        .elite-icon-gem {
            width: 75px; height: 75px;
            background: linear-gradient(135deg, rgba(56, 189, 248, 0.2), rgba(16, 185, 129, 0.2));
            border: 2px solid var(--accent-blue);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 30px; color: var(--accent-blue);
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(56, 189, 248, 0.3);
            transition: transform 0.3s ease;
        }
        .elite-showcase-card:hover .elite-icon-gem {
            transform: rotate(15deg) scale(1.1);
        }
        .elite-card-body h4 {
            font-size: 18px;
            font-weight: 800;
            color: var(--text-main);
            margin: 0 0 10px 0;
        }
        .elite-card-body p {
            font-size: 13.5px;
            color: var(--text-muted);
            margin: 0 0 20px 0;
            line-height: 1.6;
            font-weight: 500;
        }
        .elite-badge-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background: rgba(16, 185, 129, 0.15);
            color: var(--accent-green);
            border: 1px solid rgba(16, 185, 129, 0.4);
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 11.5px;
            font-weight: 800;
            text-transform: uppercase;
        }

        .docs-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px; margin-bottom: 40px; }
        @media(max-width: 900px) { .docs-grid { grid-template-columns: 1fr; } }

        .doc-card {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.5);
            transition: all 0.35s ease;
            position: relative;
            overflow: hidden;
        }
        .doc-card:hover {
            border-color: var(--accent-blue);
            box-shadow: 0 25px 60px rgba(56, 189, 248, 0.3);
            transform: translateY(-5px);
            background: rgba(13, 18, 30, 0.88);
        }
        .doc-card h3 { 
            font-size: 20px; font-weight: 800; margin-bottom: 24px; 
            display: flex; align-items: center; gap: 15px; 
            border-bottom: 1px solid var(--border-color); padding-bottom: 16px; 
            color: var(--text-main);
        }
        .doc-card h3 i {
            background: rgba(56, 189, 248, 0.12); padding: 12px; border-radius: 14px; border: 1px solid var(--border-color);
            box-shadow: 0 0 15px rgba(56,189,248,0.2);
        }
        
        .feature-list { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 18px; }
        .feature-list li { display: flex; align-items: flex-start; gap: 14px; font-size: 14.5px; color: var(--text-muted); line-height: 1.65; }
        .feature-list li i { color: var(--accent-green); margin-top: 4px; font-size: 16px; filter: drop-shadow(0 0 8px rgba(16,185,129,0.5)); }
        .feature-list li strong { color: var(--text-main); }

        .tech-stack-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-top: 22px; }
        .tech-item {
            background: rgba(3,7,18,0.85);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 18px 12px;
            text-align: center;
            transition: all 0.25s ease;
        }
        .tech-item:hover { border-color: var(--accent-blue); background: rgba(56, 189, 248, 0.08); transform: translateY(-3px); box-shadow: 0 10px 25px rgba(56,189,248,0.2); }
        .tech-item i { font-size: 26px; color: var(--accent-blue); margin-bottom: 10px; display: block; filter: drop-shadow(0 0 8px rgba(56,189,248,0.4)); }
        .tech-item span { font-size: 13px; font-weight: 800; color: var(--text-main); display: block; }
        .tech-item p { font-size: 11px; color: var(--text-muted); margin: 4px 0 0 0; }

        .workflow-box {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 45px;
            margin-bottom: 40px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.5);
        }
        .workflow-steps { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        @media(max-width: 1024px) { .workflow-steps { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 600px) { .workflow-steps { grid-template-columns: 1fr; } }

        .step-card { 
            background: rgba(3,7,18,0.8); border: 1px solid var(--border-color); border-radius: 18px; padding: 25px; text-align: center; 
            transition: all 0.3s ease;
        }
        .step-card:hover { border-color: var(--accent-green); box-shadow: 0 15px 30px rgba(16,185,129,0.25); transform: translateY(-4px); }
        .step-num { width: 38px; height: 38px; background: var(--accent-blue); color: #030712; font-weight: 900; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px auto; font-size: 15px; box-shadow: 0 0 15px rgba(56,189,248,0.6); }
        .step-card h5 { font-size: 16px; font-weight: 800; margin-bottom: 8px; color: var(--text-main); }
        .step-card p { font-size: 12.5px; color: var(--text-muted); margin: 0; line-height: 1.55; }

        .video-highlights-box {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border: 1px solid var(--border-color);
            border-radius: 24px;
            padding: 45px;
            margin-bottom: 40px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.5);
        }
        .video-grid {
            display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-top: 25px;
        }
        @media(max-width: 900px) { .video-grid { grid-template-columns: 1fr; } }
        
        .video-card-item {
            background: transparent;
            height: 380px;
            perspective: 1000px;
            animation: fastSpinThreeTimes 1.5s cubic-bezier(0.4, 0, 0.2, 1) 1;
            cursor: pointer;
        }

        @keyframes fastSpinThreeTimes {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(1080deg); }
        }

        .video-card-flip-inner {
            position: relative;
            width: 100%;
            height: 100%;
            text-align: center;
            transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1);
            transform-style: preserve-3d;
        }

        .video-card-item:hover .video-card-flip-inner {
            transform: rotateY(180deg);
        }

        .v-card-front, .v-card-back {
            position: absolute;
            width: 100%;
            height: 100%;
            backface-visibility: hidden;
            border-radius: 18px;
            overflow: hidden;
            border: 1px solid var(--border-color);
            background: rgba(13, 18, 30, 0.95);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
        }

        .v-card-back {
            transform: rotateY(180deg);
            background: rgba(13, 18, 30, 0.98);
            align-items: center;
            justify-content: center;
            padding: 25px;
            color: var(--text-main);
            text-align: center;
        }
        
        .v-card-back h5 { color: var(--accent-blue); font-weight: 800; margin-bottom: 10px; font-size: 16px; text-transform: uppercase; }
        .v-card-back p { color: var(--text-muted); font-size: 13px; line-height: 1.5; margin: 0; }

        .video-content-top {
            padding: 16px 14px;
            background: rgba(13, 18, 30, 0.98);
            border-bottom: 1px solid var(--border-color);
            text-align: left;
        }
        .video-content-top h4 { margin: 0 0 4px 0; font-size: 15px; font-weight: 800; color: var(--accent-blue); }
        .video-content-top p { margin: 0; font-size: 12px; color: var(--text-muted); line-height: 1.3; }

        .video-thumb-wrapper {
            position: relative; width: 100%; height: 250px; background: #000; overflow: hidden;
            display: flex; align-items: center; justify-content: center; flex-grow: 1;
        }
        .video-thumb-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .play-btn-overlay {
            position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%);
            background: rgba(56, 189, 248, 0.9); color: #030712; width: 45px; height: 45px;
            border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px;
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.6);
        }

        .video-modal {
            display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%;
            background: rgba(3, 7, 18, 0.9); backdrop-filter: blur(10px);
            align-items: center; justify-content: center; padding: 20px;
        }
        .video-modal-content {
            background: #0d121e; border: 1px solid var(--border-color); border-radius: 20px;
            width: 100%; max-width: 800px; padding: 25px; box-shadow: 0 25px 50px rgba(0,0,0,0.8);
            position: relative; text-align: center;
        }
        .close-modal {
            position: absolute; top: 15px; right: 20px; color: var(--text-muted); font-size: 24px; font-weight: 800; cursor: pointer; transition: color 0.2s;
        }
        .close-modal:hover { color: var(--accent-rose); }

        /* ======================================================== */
        /* STANDALONE PRO-SHOWCASE GALLERY WITH 360° HOVER ROTATION */
        /* ======================================================== */
        .pro-showcase-gallery-section {
            max-width: 1300px;
            margin: 0 auto 40px auto;
            background: rgba(13, 18, 30, 0.6);
            backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-color);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.4);
        }

        .pro-showcase-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 768px) { .pro-showcase-grid { grid-template-columns: 1fr; } }

        .pro-showcase-box {
            background: rgba(13, 18, 30, 0.9);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
        }
        .pro-showcase-box:hover {
            transform: translateY(-6px);
            border-color: var(--accent-blue);
            box-shadow: 0 15px 35px rgba(56, 189, 248, 0.25);
        }
        .pro-box-header {
            padding: 16px;
            text-align: center;
            background: rgba(13, 18, 30, 0.98);
            border-bottom: 1px solid var(--border-color);
        }
        .pro-box-header h4 {
            margin: 0 0 5px 0;
            font-size: 15px;
            font-weight: 800;
            color: var(--accent-blue);
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }
        .pro-box-header p {
            margin: 0;
            font-size: 12px;
            color: var(--text-muted);
            line-height: 1.4;
        }
        .pro-box-img-wrapper {
            width: 100%;
            height: 280px;
            overflow: hidden;
            background: #000;
        }
        /* 360 DEGREE ROTATION ON HOVER */
        .pro-box-img-wrapper img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
            transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1);
        }
        .pro-showcase-box:hover .pro-box-img-wrapper img {
            transform: rotate(360deg) scale(1.05);
        }

        /* SYMMETRIC 4-COLUMN FOOTER CONTENT (CLEAN & SEPARATED) */
        .combo-footer-section {
            background: rgba(5, 8, 18, 0.95);
            backdrop-filter: blur(20px);
            border-top: 1.5px solid var(--border-color);
            border-radius: 24px 24px 0 0;
            padding: 50px 45px 30px 45px;
            box-shadow: 0 -20px 45px rgba(0,0,0,0.6);
            max-width: 1300px;
            margin: 0 auto;
        }

        .grand-footer-content {
            display: grid; 
            grid-template-columns: 2fr 1fr 1fr 1fr; 
            gap: 30px; 
            align-items: start;
        }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 768px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }

        .footer-brand h3 { margin: 0 0 8px 0; font-size: 18px; font-weight: 800; text-transform: uppercase; color: var(--text-main); letter-spacing: 1px; }
        .footer-brand h3 span { color: var(--accent-blue); }
        .footer-brand p { margin: 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.6; }

        .footer-links h4 { margin: 0 0 12px 0; font-size: 13px; font-weight: 700; text-transform: uppercase; color: var(--text-main); letter-spacing: 0.5px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 10px; }
        .footer-links a { color: var(--text-muted); text-decoration: none; font-size: 12.5px; font-weight: 600; transition: color 0.2s; }
        .footer-links a:hover { color: var(--accent-blue); }

        .footer-bottom-bar { text-align: center; color: var(--text-muted); font-size: 11.5px; margin-top: 40px; border-top: 1px dashed var(--border-color); padding-top: 20px; letter-spacing: 0.5px; }
    </style>
</head>
<body>

    <nav>
        <a href="/home" class="back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Home</a>
        <a href="/home" class="logo-box">
            <div class="logo-text">ProMatch Arena <span>System Documentation</span></div>
            <div class="logo-icon">P</div>
        </a>
    </nav>

    <div class="container">
        
        <!-- HERO SECTION WITH SMOOTH MOVING MESH BACKGROUND ANIMATION -->
        <div class="about-hero">
            <!-- Moving Cyber Light Wave -->
            <div class="hero-wave-light"></div>

            <div class="dynamic-hero-content">
                <div class="hero-badge"><i class="fa-solid fa-shield-halved"></i> Enterprise Sports Engine</div>
                <h1>About <span>ProMatch Arena</span></h1>
                <p>An elite, full-stack enterprise sports management platform engineered to automate cricket tournament registration, live squad rosters, secure payments, and role-based administration with ultimate performance.</p>
            </div>
        </div>

        <!-- ELITE CRICKET SHOWCASE (ICONS / GEMS) -->
        <div class="elite-cricket-showcase">
            <h3 class="elite-showcase-title">🏆 Elite Cricket Championship Experience</h3>
            <p class="elite-showcase-subtitle">Dive into professional cricket management, stunning stadium arenas, and high-voltage match action built into our platform.</p>
            
            <div class="elite-showcase-grid">
                <!-- Card 1 -->
                <div class="elite-showcase-card">
                    <div class="elite-icon-gem"><i class="fa-solid fa-stadium"></i></div>
                    <div class="elite-card-body">
                        <div>
                            <h4>Floodlit Arenas</h4>
                            <p>World-class stadium lighting and venue setups meticulously organized for grand tournament spectacles.</p>
                        </div>
                        <span class="elite-badge-tag"><i class="fa-solid fa-check"></i> Pro Venue</span>
                    </div>
                </div>

                <!-- Card 2 -->
                <div class="elite-showcase-card">
                    <div class="elite-icon-gem"><i class="fa-solid fa-bolt"></i></div>
                    <div class="elite-card-body">
                        <div>
                            <h4>High-Voltage Action</h4>
                            <p>Real-time match ball tracking, nail-biting finishes, and dynamic scorecard management.</p>
                        </div>
                        <span class="elite-badge-tag"><i class="fa-solid fa-check"></i> Live Scoring</span>
                    </div>
                </div>

                <!-- Card 3 -->
                <div class="elite-showcase-card">
                    <div class="elite-icon-gem"><i class="fa-solid fa-trophy"></i></div>
                    <div class="elite-card-body">
                        <div>
                            <h4>Championship Glory</h4>
                            <p>The ultimate reward for discipline, teamwork, and tactical masterclasses on the field.</p>
                        </div>
                        <span class="elite-badge-tag"><i class="fa-solid fa-check"></i> Grand Prize</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- ARCHITECTURE BOX -->
        <div class="workflow-box">
            <h3><i class="fa-solid fa-layer-group" style="color: var(--accent-blue); background: rgba(56,189,248,0.12); padding: 10px; border-radius: 12px; border: 1px solid var(--border-color);"></i> Enterprise Architecture & Tech Stack</h3>
            <p style="color: var(--text-muted); font-size: 14.5px; margin-bottom: 25px;">Built on robust modern frameworks to guarantee high concurrency, secure session persistence, and zero-latency UI rendering.</p>
            
            <div class="tech-stack-grid">
                <div class="tech-item"><i class="fa-solid fa-leaf"></i><span>Spring Boot</span><p>Core Backend & REST Services</p></div>
                <div class="tech-item"><i class="fa-solid fa-shield-halved"></i><span>Spring Security</span><p>Authentication & Access Control</p></div>
                <div class="tech-item"><i class="fa-solid fa-code"></i><span>JSP & JSTL</span><p>Dynamic Server-Side Views</p></div>
                <div class="tech-item"><i class="fa-solid fa-database"></i><span>Hibernate / JPA</span><p>ORM & Relational Database</p></div>
                <div class="tech-item"><i class="fa-solid fa-credit-card"></i><span>Razorpay API</span><p>Secure Tournament Payments</p></div>
                <div class="tech-item"><i class="fa-solid fa-palette"></i><span>Cyber Glass UI</span><p>Modern Glassmorphism & Bootstrap</p></div>
            </div>
        </div>

        <!-- DOCS GRID -->
        <div class="docs-grid">
            <div class="doc-card">
                <h3><i class="fa-solid fa-clipboard-list" style="color: var(--accent-green);"></i> Core System Modules</h3>
                <ul class="feature-list">
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Admin Dashboard Control:</strong> Centralized hub for managing tournaments, team directories, squads, and live match fixtures.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Squad & Roster Management:</strong> Full CRUD operations for team players with jersey numbers, batting/bowling styles, and live search filtration.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Tournament Registration Pipeline:</strong> Seamless team entry registration coupled with automated payment verification workflows.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Dual Theme Engine:</strong> Persistent Cyber Dark mode and clean Professional Light mode stored locally via browser `localStorage`.</li>
                </ul>
            </div>

            <div class="doc-card">
                <h3><i class="fa-solid fa-gears" style="color: var(--accent-amber);"></i> Engineering Fixes & Optimizations</h3>
                <ul class="feature-list">
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Enum-to-String Safety (`.name()`):</strong> Resolved Jakarta EL runtime conversion crashes by safely evaluating Entity Enum roles in JSTL tags.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>HTTP 405 Resolution:</strong> Cleanly split Controller GET and POST mappings to eliminate method mismatch errors during form submissions.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Dynamic Role Routing:</strong> Intelligent navigation rendering that safely directs ADMINs to control hubs and USERs to standard dashboards.</li>
                </ul>
            </div>
        </div>

        <div class="workflow-box">
            <h3><i class="fa-solid fa-route" style="color: var(--accent-rose); background: rgba(244,63,94,0.12); padding: 10px; border-radius: 12px; border: 1px solid var(--border-color);"></i> Tournament Registration & Match Workflow</h3>
            <div class="workflow-steps" style="margin-top: 22px;">
                <div class="step-card"><div class="step-num">1</div><h5>User Authentication</h5><p>Secure login with role assignment (ADMIN vs USER) via Spring Security.</p></div>
                <div class="step-card"><div class="step-num">2</div><h5>Team & Squad Entry</h5><p>Register tournament teams and add active player rosters with specs.</p></div>
                <div class="step-card"><div class="step-num">3</div><h5>Payment Gateway</h5><p>Smooth integration with Razorpay for verified entry fee settlements.</p></div>
                <div class="step-card"><div class="step-num">4</div><h5>Live Analytics</h5><p>Track fixture scorecards, points tables, and team standings in real-time.</p></div>
            </div>
        </div>

        <!-- VIDEO HIGHLIGHTS SECTION -->
        <div class="video-highlights-box">
            <h3 style="font-size: 20px; font-weight: 800; margin: 0 0 8px 0; display: flex; align-items: center; gap: 12px;">
                <i class="fa-solid fa-video" style="color: var(--accent-blue); background: rgba(56,189,248,0.12); padding: 10px; border-radius: 12px; border: 1px solid var(--border-color);"></i> Live Cricket Match Highlights & Replays
            </h3>
            <p style="color: var(--text-muted); font-size: 14.5px; margin: 0 0 25px 0;">Experience the raw energy of professional tournament clashes. Hover to flip cards or click to stream high-definition match highlights instantly.</p>

            <div class="video-grid">
                <!-- Video Card 1 -->
                <div class="video-card-item" onclick="openVideo('https://www.youtube.com/embed/_TGTwnpqorI')">
                    <div class="video-card-flip-inner">
                        <div class="v-card-front">
                            <div class="video-content-top">
                                <h4>⚡ Extended Match Highlights</h4>
                                <p>Washington Freedom vs MI New York - Match #5</p>
                            </div>
                            <div class="video-thumb-wrapper">
                                <img src="https://static.vecteezy.com/system/resources/previews/007/303/734/non_2x/cricket-championship-tournament-card-with-illustration-free-vector.jpg" alt="Cricket Match 1">
                                <div class="play-btn-overlay"><i class="fa-solid fa-play"></i></div>
                            </div>
                        </div>
                        <div class="v-card-back">
                            <h5>⚡ Match Analysis</h5>
                            <p>Witness tactical batting masterclasses, aggressive powerplay hits, and stadium-wide cheering moments captured live in high definition.</p>
                        </div>
                    </div>
                </div>
                
                <!-- Video Card 2 -->
                <div class="video-card-item" onclick="openVideo('https://www.youtube.com/embed/4HMqphD9ces')">
                    <div class="video-card-flip-inner">
                        <div class="v-card-front">
                            <div class="video-content-top">
                                <h4>🏆 Grand Championship</h4>
                                <p>Ultimate title clash & trophy showdown.</p>
                            </div>
                            <div class="video-thumb-wrapper">
                                <img src="https://5.imimg.com/data5/SELLER/Default/2025/7/524930295/PJ/WN/EH/69998839/cricket-tournaments-trophy.jpg" alt="Cricket Match 2">
                                <div class="play-btn-overlay"><i class="fa-solid fa-play"></i></div>
                            </div>
                        </div>
                        <div class="v-card-back">
                            <h5>🏆 Finale Glory</h5>
                            <p>Relive the adrenaline-pumping championship final where legends are forged and epic victories are celebrated under the grand stadium lights.</p>
                        </div>
                    </div>
                </div>
                
                <!-- Video Card 3 -->
                <div class="video-card-item" onclick="openVideo('https://www.youtube.com/embed/5NV6Rdv1a3I')">
                    <div class="video-card-flip-inner">
                        <div class="v-card-front">
                            <div class="video-content-top">
                                <h4>🔥 Fast Bowling Spells</h4>
                                <p>Devastating Yorkers & breakthrough wickets.</p>
                            </div>
                            <div class="video-thumb-wrapper">
                                <img src="https://www.creativehatti.com/wp-content/uploads/edd/2022/10/Template-banner-of-the-cricket-championship-20-large.jpg" alt="Cricket Match 3">
                                <div class="play-btn-overlay"><i class="fa-solid fa-play"></i></div>
                            </div>
                        </div>
                        <div class="v-card-back">
                            <h5>🔥 Pace & Precision</h5>
                            <p>Explore lethal bowling spells, crucial middle-order collapses, and breathtaking fielding displays that turned the tide of the game.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- VIDEO POPUP MODAL -->
        <div id="videoModal" class="video-modal">
            <div class="video-modal-content">
                <span class="close-modal" onclick="closeVideo()">&times;</span>
                <h4 style="color: var(--accent-blue); margin-bottom: 15px; font-weight: 800;">ProMatch Arena Live Stream</h4>
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px;">
                    <iframe id="videoIframe" src="" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;" allowfullscreen></iframe>
                </div>
            </div>
        </div>

        <!-- ======================================================== -->
        <!-- STANDALONE PRO-SHOWCASE GALLERY WITH 360° HOVER ROTATION -->
        <!-- ======================================================== -->
        <div class="pro-showcase-gallery-section">
            <h3 style="text-align:center; font-size: 22px; font-weight: 900; margin-bottom: 25px; color: var(--accent-blue); text-transform: uppercase; letter-spacing: 1px;">🏟️ Pro Tournament Showcase</h3>
            <div class="pro-showcase-grid">
                <!-- Card 1 -->
                <div class="pro-showcase-box">
                    <div class="pro-box-header">
                        <h4>🏟️ Arena Stadium</h4>
                        <p>Grand venue illumination for professional fixtures.</p>
                    </div>
                    <div class="pro-box-img-wrapper">
                        <img src="https://img.magnific.com/premium-photo/charming-energetic-poster-announcing-upc_981650-68087.jpg?w=1500" alt="Stadium Arena">
                    </div>
                </div>
                
                <!-- Card 2 -->
                <div class="pro-showcase-box">
                    <div class="pro-box-header">
                        <h4>⚡ Match Action</h4>
                        <p>High-voltage cricket action and gameplay.</p>
                    </div>
                    <div class="pro-box-img-wrapper">
                        <img src="https://img.magnific.com/premium-vector/cricket-championship-concept_1302-17549.jpg?w=1500" alt="Cricket Match">
                    </div>
                </div>
                
                <!-- Card 3 -->
                <div class="pro-showcase-box">
                    <div class="pro-box-header">
                        <h4>🏆 Victory Moment</h4>
                        <p>Trophy celebrations and winning moments.</p>
                    </div>
                    <div class="pro-box-img-wrapper">
                        <img src="https://ichef.bbci.co.uk/ace/standard/1552/cpsprodpb/b363/live/acde0890-06f2-11f0-a86b-a333e99bcfef.jpg" alt="Victory Celebration">
                    </div>
                </div>
            </div>
        </div>

    </div>

    <!-- GRAND FOOTER SECTION (SEPARATED CLEANLY FROM IMAGES) -->
    <div class="combo-footer-section">
        <div class="grand-footer-content">
            <div class="footer-brand">
                <h3><span>ProMatch</span> Arena</h3>
                <p>Advanced Enterprise Cricket Tournament & Match Control Center. Built with Spring Boot, JSP, and PostgreSQL to deliver high-performance sports analytics.</p>
            </div>
            
            <div class="footer-links">
                <h4>Quick Navigation</h4>
                <ul>
                    <li><a href="/home">🏠 Home Dashboard</a></li>
                    <li><a href="/teams">👥 View Teams</a></li>
                    <li><a href="/register-team">➕ Register Team</a></li>
                    <li><a href="/matches">⚡ Live Matches</a></li>
                    <li><a href="/tournaments">🏆 Tournaments</a></li>
                </ul>
            </div>

            <div class="footer-links">
                <h4>Standings & Stats</h4>
                <ul>
                    <li><a href="/pointsTable">📊 Points Table</a></li>
                    <li><a href="/about">📖 About Architecture</a></li>
                </ul>
            </div>

            <div class="footer-links">
                <h4>Legal & Support</h4>
                <ul>
                    <li><a href="/faq">❓ FAQ Help Center</a></li>
                    <li><a href="/privacy-policy">🔒 Privacy Policy</a></li>
                    <li><a href="/terms-and-conditions">📄 Terms & Conditions</a></li>
                    <li><a href="/contact">📞 Contact Us</a></li>
                </ul>
            </div>
        </div>

        <div class="footer-bottom-bar">
            <p>&copy; 2026 ProMatch Arena &bull; All Rights Reserved. Crafted with high-end Cyber Glassmorphism UI.</p>
        </div>
    </div>

    <script>
        function openVideo(videoUrl) {
            document.getElementById('videoIframe').src = videoUrl + "?autoplay=1";
            document.getElementById('videoModal').style.display = 'flex';
        }

        function closeVideo() {
            document.getElementById('videoIframe').src = '';
            document.getElementById('videoModal').style.display = 'none';
        }
    </script>

</body>
</html>