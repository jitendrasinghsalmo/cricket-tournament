<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Contact Us</title>
    <!-- Bootstrap 5 CSS & FontAwesome -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        html { scroll-behavior: smooth; }
        :root {
            --bg-main: #030712;
            --bg-card: rgba(13, 18, 30, 0.88);
            --accent-blue: #38bdf8;
            --accent-green: #10b981;
            --accent-rose: #f43f5e;
            --accent-gold: #ffd700;
            --accent-cyan: #00d9ff;
            --accent-purple: #c084fc;
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
            background: rgba(13, 18, 30, 0.95);
            backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color);
            padding: 15px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .logo-box { display: flex; align-items: center; gap: 10px; text-decoration: none; }
        .logo-icon { background: var(--accent-blue); color: #030712; width: 35px; height: 35px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 18px; box-shadow: 0 0 12px rgba(56,189,248,0.4); }
        .logo-text { font-weight: 800; font-size: 18px; color: var(--text-main); letter-spacing: 0.5px; }
        .logo-text span { display: block; font-size: 10px; color: var(--accent-blue); letter-spacing: 1.5px; text-transform: uppercase; }

        .nav-links { list-style: none; margin: 0; padding: 0; display: flex; gap: 25px; align-items: center; }
        .nav-links a { color: var(--text-muted); text-decoration: none; font-size: 14px; font-weight: 600; transition: color 0.2s; }
        .nav-links a:hover, .nav-links a.active { color: var(--accent-blue); text-shadow: 0 0 10px rgba(56,189,248,0.4); }

        /* SECTIONS SPACING HELPER */
        .section-spacer { margin-top: 80px; margin-bottom: 80px; }

        /* CONTACT HERO */
        .contact-hero {
            background: linear-gradient(135deg, var(--accent-rose), #be123c);
            padding: 80px 20px; text-align: center; color: white;
            box-shadow: inset 0 0 50px rgba(0,0,0,0.2);
            margin-bottom: 60px;
        }
        .contact-hero h1 { font-weight: 900; font-size: 3.5rem; margin-bottom: 15px; }
        .contact-hero p { font-size: 1.2rem; opacity: 0.95; margin: 0; max-width: 600px; margin-left: auto; margin-right: auto; }

        /* 🌟 TOP 4 CIRCULAR CARDS */
        .cards-grid-4 {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }
        @media(max-width: 992px) { .cards-grid-4 { grid-template-columns: repeat(2, 1fr); gap: 30px; } }
        @media(max-width: 576px) { .cards-grid-4 { grid-template-columns: 1fr; } }

        .mini-circle-card {
            background: var(--bg-card);
            border: 1.5px solid var(--border-color);
            border-radius: 20px;
            padding: 25px;
            text-align: center;
            backdrop-filter: blur(10px);
            box-shadow: 0 15px 30px rgba(0,0,0,0.3);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .mini-circle-card:hover {
            border-color: var(--accent-cyan);
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 217, 255, 0.2);
        }
        .mini-circle-avatar {
            width: 90px; height: 90px; border-radius: 50%; overflow: hidden;
            border: 3px solid var(--accent-cyan);
            margin-bottom: 15px;
            background: #000;
            display: flex; align-items: center; justify-content: center;
        }
        .mini-circle-avatar img {
            width: 100%; height: 100%;
            object-fit: cover;
            object-position: center;
            display: block;
            animation: fastContinuousRotate 6s linear infinite;
        }
        @keyframes fastContinuousRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .mini-circle-card h6 { font-size: 15px; font-weight: 800; color: var(--accent-cyan); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 1px;}
        .mini-circle-card p { font-size: 12px; color: var(--text-muted); margin: 0; line-height: 1.4; }

        /* 🌟 STUNNING ANIMATED BANNER */
        .animated-banner-section {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .animated-banner-box {
            position: relative;
            background: linear-gradient(135deg, #030712 0%, #0d1b3a 50%, #030712 100%);
            border: 2px solid var(--accent-blue);
            border-radius: 20px;
            padding: 50px;
            text-align: center;
            overflow: hidden;
            box-shadow: 0 20px 50px rgba(56, 189, 248, 0.15);
        }
        .animated-banner-box::before {
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.1) 0%, rgba(16, 185, 129, 0.05) 40%, transparent 70%);
            animation: rotateWaveLights 10s linear infinite;
            pointer-events: none;
        }
        @keyframes rotateWaveLights {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .animated-banner-content {
            position: relative;
            z-index: 2;
            animation: bouncePulse 3s ease-in-out infinite;
        }
        @keyframes bouncePulse {
            0%, 100% { transform: translateY(0); }
            50% { transform: translateY(-4px); }
        }
        .animated-banner-box h2 {
            font-size: 28px;
            font-weight: 900;
            color: var(--accent-gold);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 15px;
            text-shadow: 0 0 15px rgba(255, 215, 0, 0.3);
        }
        .animated-banner-box p {
            font-size: 15px;
            color: var(--text-muted);
            max-width: 750px;
            margin: 0 auto;
            line-height: 1.8;
            font-weight: 600;
        }

        /* MAIN CONTACT SECTION */
        .contact-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: grid; grid-template-columns: 1fr 1.5fr; gap: 50px;
        }
        @media(max-width: 992px) { .contact-container { grid-template-columns: 1fr; gap: 40px; } }

        .contact-info-card, .contact-form-card {
            background: var(--bg-card); backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-color); border-radius: 24px; padding: 40px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
            height: 100%;
        }
        .contact-info-card h3, .contact-form-card h3 {
            font-size: 26px; font-weight: 900; margin-bottom: 30px;
            color: var(--text-main); border-left: 5px solid var(--accent-blue); padding-left: 15px;
            text-transform: uppercase; letter-spacing: 1px;
        }
        .info-item { display: flex; align-items: flex-start; gap: 20px; margin-bottom: 25px; }
        .info-item:last-child { margin-bottom: 0; }
        .info-item i {
            font-size: 24px; color: var(--accent-blue);
            margin-top: 5px; background: rgba(56, 189, 248, 0.1);
            width: 50px; height: 50px; border-radius: 12px;
            display: flex; align-items: center; justify-content: center; flex-shrink: 0;
        }
        .info-item h5 { margin: 0 0 6px 0; font-size: 18px; font-weight: 800; color: var(--text-main); }
        .info-item p { margin: 0; font-size: 15px; color: var(--text-muted); line-height: 1.6; }

        /* Form Styling */
        .form-group { margin-bottom: 20px; }
        .form-label { font-size: 13px; font-weight: 700; color: var(--text-muted); margin-bottom: 8px; display: block; text-transform: uppercase; letter-spacing: 0.5px; }
        .form-control-custom {
            width: 100%; background: rgba(3,7,18,0.6); border: 1px solid var(--border-color);
            border-radius: 12px; padding: 15px; color: var(--text-main); font-size: 15px; outline: none; transition: 0.3s;
        }
        .form-control-custom:focus { border-color: var(--accent-blue); box-shadow: 0 0 15px rgba(56,189,248,0.2); }
        textarea.form-control-custom { resize: vertical; height: 160px; }
        .btn-submit {
            background: linear-gradient(135deg, var(--accent-blue), #0284c7); color: #030712; border: none;
            width: 100%; padding: 16px; border-radius: 12px; font-weight: 900; font-size: 16px; text-transform: uppercase; letter-spacing: 1px;
            cursor: pointer; transition: 0.3s; box-shadow: 0 5px 20px rgba(56,189,248,0.3); margin-top: 10px;
        }
        .btn-submit:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(56,189,248,0.5); }

        /* 🌟 3 + 2 FEATURE SECTION (REDESIGNED WITH VIBRANT CYAN & PURPLE NEON THEME) */
        .custom-feature-section {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .grid-row-3-features {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
            margin-bottom: 30px;
        }
        .grid-row-2-features {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
            max-width: 720px;
            margin: 0 auto;
        }
        @media(max-width: 768px) {
            .grid-row-3-features { grid-template-columns: 1fr; gap: 20px;}
            .grid-row-2-features { grid-template-columns: 1fr; max-width: 100%; gap: 20px;}
        }

        .feature-box-unique {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(181, 55, 242, 0.08)), var(--bg-card);
            border: 2px solid var(--accent-cyan);
            border-radius: 20px;
            padding: 30px 20px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0, 217, 255, 0.15);
            transition: all 0.3s ease;
        }
        .feature-box-unique:hover {
            border-color: var(--accent-purple);
            transform: translateY(-5px);
            box-shadow: 0 20px 45px rgba(181, 55, 242, 0.3);
        }
        .feature-box-icon {
            font-size: 28px;
            color: var(--accent-cyan);
            background: rgba(0, 217, 255, 0.15);
            width: 65px; height: 65px;
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 15px auto;
            box-shadow: 0 0 20px rgba(0, 217, 255, 0.3);
        }
        .feature-box-unique h5 { font-size: 17px; font-weight: 800; color: var(--accent-cyan); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.8px; text-shadow: 0 0 10px rgba(0, 217, 255, 0.3); }
        .feature-box-unique p { font-size: 13px; color: var(--text-muted); margin: 0; line-height: 1.5; font-weight: 500; }

        /* 🌟 3 YELLOW THEME IMAGES CARDS SECTION */
        .extra-images-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            text-align: center;
        }
        .extra-images-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 30px;
        }
        @media(max-width: 992px) { .extra-images-grid { grid-template-columns: 1fr; gap: 30px; } }

        .extra-img-card {
            background: var(--bg-card);
            border: 1.5px solid var(--border-color);
            border-radius: 24px;
            padding: 40px 25px;
            text-align: center;
            backdrop-filter: blur(10px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.35);
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: all 0.3s ease;
        }
        .extra-img-card:hover {
            border-color: var(--accent-gold);
            transform: translateY(-5px);
            box-shadow: 0 20px 45px rgba(255, 215, 0, 0.25);
        }
        .extra-img-content { margin-bottom: 25px; width: 100%; }
        .extra-img-card h4 { font-size: 19px; font-weight: 800; color: var(--accent-gold); margin: 0 0 8px 0; text-transform: uppercase; letter-spacing: 0.5px; }
        .extra-img-card p { font-size: 14px; color: var(--text-muted); margin: 0; line-height: 1.6; }

        .extra-avatar {
            width: 190px; height: 190px; border-radius: 50%; overflow: hidden;
            border: 4px solid var(--accent-gold); box-shadow: 0 0 25px rgba(255, 215, 0, 0.3);
            background: #000; display: flex; align-items: center; justify-content: center;
        }
        .extra-avatar img {
            width: 100%; height: 100%; object-fit: cover; object-position: center; display: block;
            animation: slowRotate 12s linear infinite;
        }
        @keyframes slowRotate {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .extra-img-card:hover .extra-avatar img {
            animation: fastSpin 0.8s linear infinite !important;
        }
        @keyframes fastSpin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* YELLOW BANNER SECTION */
        .footer-banner-section {
            max-width: 1100px;
            margin: 0 auto;
            padding: 0 20px;
        }
        .footer-banner-box {
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.12), rgba(56, 189, 248, 0.12)), var(--bg-card);
            border: 2px solid var(--accent-gold);
            border-radius: 20px;
            padding: 45px 30px;
            text-align: center;
            box-shadow: 0 20px 45px rgba(255, 215, 0, 0.15);
        }
        .footer-banner-box h3 {
            font-size: 24px;
            font-weight: 900;
            color: var(--accent-gold);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            margin-bottom: 12px;
            text-shadow: 0 0 10px rgba(255, 215, 0, 0.3);
        }
        .footer-banner-box p {
            font-size: 15px;
            color: var(--text-muted);
            margin: 0;
            line-height: 1.7;
            font-weight: 600;
            max-width: 750px;
            margin-left: auto;
            margin-right: auto;
        }

        /* 🌟 PRO ARENA HIGHLIGHTS GALLERY */
        .circle-gallery-section {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            text-align: center;
        }
        .circle-gallery-title {
            font-size: 28px; font-weight: 900; text-transform: uppercase; letter-spacing: 1px;
            background: linear-gradient(135deg, var(--accent-blue), var(--accent-green));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
            margin-bottom: 40px;
        }
        .circle-gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; }
        @media(max-width: 992px) { .circle-gallery-grid { grid-template-columns: 1fr; gap: 30px; } }
        
        .circle-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color);
            border-radius: 24px; padding: 40px 25px; backdrop-filter: blur(10px);
            display: flex; flex-direction: column; align-items: center; text-align: center;
            transition: all 0.3s ease; box-shadow: 0 15px 35px rgba(0,0,0,0.35);
        }
        .circle-card:hover { border-color: var(--accent-blue); transform: translateY(-5px); box-shadow: 0 20px 45px rgba(56,189,248,0.25); }
        
        .circle-card-content { margin-bottom: 25px; width: 100%; }
        .circle-card h4 { font-size: 19px; font-weight: 800; color: var(--accent-blue); margin: 0 0 8px 0; text-transform: uppercase; letter-spacing: 0.5px; }
        .circle-card p { font-size: 14px; color: var(--text-muted); margin: 0; line-height: 1.6; }

        .circle-img-wrapper {
            width: 190px; height: 190px; border-radius: 50%; overflow: hidden;
            border: 4px solid var(--accent-blue); box-shadow: 0 0 25px rgba(56,189,248,0.3);
            background: #000; display: flex; align-items: center; justify-content: center;
        }
        .circle-img-wrapper img {
            width: 100%; height: 100%; object-fit: cover; object-position: center;
            display: block;
            animation: fastContinuousRotate 6s linear infinite;
        }

        /* GRAND FOOTER SECTION */
        .grand-footer-section {
            background: var(--bg-card);
            backdrop-filter: blur(20px);
            border-top: 1px solid var(--border-color);
            padding: 60px 40px 30px 40px;
            margin-top: 100px;
            box-shadow: 0 -25px 50px rgba(0,0,0,0.5);
        }
        .grand-footer-content {
            max-width: 1200px;
            margin: 0 auto 40px auto;
            display: grid;
            grid-template-columns: 2fr 1fr 1fr 1fr;
            gap: 40px;
            align-items: start;
        }
        @media(max-width: 992px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; gap: 30px; } }

        .footer-brand h3 { margin: 0 0 12px 0; font-size: 20px; font-weight: 900; text-transform: uppercase; color: var(--text-main); letter-spacing: 1px; }
        .footer-brand h3 span { color: var(--accent-blue); }
        .footer-brand p { margin: 0; font-size: 13.5px; color: var(--text-muted); line-height: 1.7; }
        .footer-links h4 { margin: 0 0 15px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--accent-blue); letter-spacing: 0.5px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-muted); text-decoration: none; font-size: 13.5px; font-weight: 600; transition: color 0.2s; }
        .footer-links a:hover { color: var(--accent-blue); }
        .footer-bottom-bar {
            max-width: 1200px;
            margin: 0 auto;
            border-top: 1px solid var(--border-color);
            padding-top: 25px;
            text-align: center;
            color: var(--text-muted);
            font-size: 12.5px;
            letter-spacing: 0.5px;
        }

        /* SUCCESS POPUP MODAL STYLES */
        .success-modal {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(3, 7, 18, 0.85); backdrop-filter: blur(8px); z-index: 2000;
            align-items: center; justify-content: center;
        }
        .success-modal.active { display: flex; }
        .success-content {
            background: var(--bg-card); border: 2px solid var(--accent-green); border-radius: 20px;
            padding: 40px; max-width: 420px; width: 90%; text-align: center;
            box-shadow: 0 20px 50px rgba(16, 185, 129, 0.3); animation: popUp 0.3s ease;
        }
        @keyframes popUp { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .success-icon { font-size: 50px; color: var(--accent-green); margin-bottom: 15px; }
        .success-content h3 { font-size: 22px; font-weight: 900; margin-bottom: 10px; color: var(--text-main); }
        .success-content p { font-size: 14px; color: var(--text-muted); margin-bottom: 25px; line-height: 1.6; }
        .btn-close-popup {
            background: var(--accent-green); color: #030712; border: none; width: 100%;
            padding: 12px; border-radius: 12px; font-weight: 800; font-size: 14px; text-transform: uppercase; cursor: pointer;
        }
    </style>
</head>
<body>

    <!-- 🌟 STICKY TOP NAVBAR -->
    <nav>
        <a href="/home" class="logo-box">
            <div class="logo-icon">P</div>
            <div class="logo-text">ProMatch Arena <span>Tournament Control</span></div>
        </a>
        <ul class="nav-links d-none d-md-flex">
            <li><a href="/home">Home</a></li>
            <li><a href="/teams">View Teams</a></li>
            <li><a href="/matches">Matches</a></li>
            <li><a href="/tournaments">Tournaments</a></li>
            <li><a href="/pointsTable">Points Table</a></li>
            <li><a href="/faq">FAQ</a></li>
            <li><a href="/contact" class="active">Contact Us</a></li>
        </ul>
    </nav>

    <!-- HERO SECTION -->
    <div class="contact-hero">
        <h1>Get in Touch</h1>
        <p>Have questions about tournaments or need technical support? We're here to help!</p>
    </div>

    <!-- 🌟 TOP 4 CIRCULAR CARDS WITH ROTATING IMAGES -->
    <div class="section-spacer">
        <div class="cards-grid-4">
            <div class="mini-circle-card">
                <div class="mini-circle-avatar">
                    <img src="https://media.gettyimages.com/id/2217853759/photo/topshot-royal-challengers-bengalurus-virat-kohli-along-with-his-former-teammates-ab-de.jpg?s=612x612&w=gi&k=20&c=KwbFGriFUpsRlJNaMGtDr8-dl1aj6W2D5FfVgFDuaEM=" alt="Analytics">
                </div>
                <h6>Live Analytics</h6>
                <p>Real-time match data synced.</p>
            </div>
            <div class="mini-circle-card">
                <div class="mini-circle-avatar">
                    <img src="https://akm-img-a-in.tosshub.com/indiatoday/images/story/202604/cooper-connolly-015403622-16x9_0.jpg?VersionId=UuL_9pzJM3MD4pm7CdPDoN7d_ewZiJl7&size=690:388" alt="NRR">
                </div>
                <h6>Instant NRR</h6>
                <p>Zero-error calculation engine.</p>
            </div>
            <div class="mini-circle-card">
                <div class="mini-circle-avatar">
                    <img src="https://thumbs.dreamstime.com/b/ap-ipl-april-218500286.jpg" alt="Cloud">
                </div>
                <h6>Cloud Sync</h6>
                <p>Enterprise server backing.</p>
            </div>
            <div class="mini-circle-card">
                <div class="mini-circle-avatar">
                    <img src="https://media.gettyimages.com/id/2139220591/photo/virat-kohli-of-royal-challengers-bengaluru-is-playing-a-shot-during-the-indian-premier-league.jpg?s=612x612&w=gi&k=20&c=NFJ29_DVl3Cy8uIvvAq3F40C0qREWLhOuqobyYjn_qU=" alt="Broadcast">
                </div>
                <h6>Live Stream</h6>
                <p>Seamless broadcast feeds.</p>
            </div>
        </div>
    </div>

    <!-- STUNNING ANIMATED BANNER -->
    <div class="section-spacer">
        <div class="animated-banner-section">
            <div class="animated-banner-box">
                <div class="animated-banner-content">
                    <h2>🚀 Elite Cricket Management System</h2>
                    <p>Automate your tournament registrations, real-time NRR tracking, and role-based squad administrations with ultimate enterprise reliability.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- MAIN CONTACT SECTION -->
    <div class="section-spacer">
        <div class="contact-container">
            <!-- Left: Direct Info -->
            <div class="contact-info-card">
                <h3>Contact Info</h3>
                <div class="info-item">
                    <i class="fa-solid fa-user-tie"></i>
                    <div>
                        <h5>Lead Administrator</h5>
                        <p>Jitendra Singh</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-phone"></i>
                    <div>
                        <h5>Phone Support</h5>
                        <p>+91 7806035087</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-envelope"></i>
                    <div>
                        <h5>Email Address</h5>
                        <p>jitendrasingh07022004@gmail.com</p>
                    </div>
                </div>
                <div class="info-item">
                    <i class="fa-solid fa-location-dot"></i>
                    <div>
                        <h5>Headquarters</h5>
                        <p>Bangalore, Karnataka, India</p>
                    </div>
                </div>
            </div>

            <!-- Right: Inquiry Form -->
            <div class="contact-form-card">
                <h3>Send a Message</h3>
                <form id="contactForm" onsubmit="handleContactSubmit(event)">
                    <div class="form-group">
                        <label class="form-label">Your Name</label>
                        <input type="text" name="name" class="form-control-custom" placeholder="Enter your full name" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Your Email</label>
                        <input type="email" name="email" class="form-control-custom" placeholder="Enter your email address" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Message</label>
                        <textarea name="message" class="form-control-custom" placeholder="Write your inquiry or feedback here..." required></textarea>
                    </div>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-paper-plane me-2"></i> Send Message</button>
                </form>
            </div>
        </div>
    </div>

    <!-- 🌟 3 + 2 FEATURE SECTION (REDESIGNED WITH VIBRANT CYAN & PURPLE NEON THEME) -->
    <div class="section-spacer">
        <div class="custom-feature-section">
            <div class="grid-row-3-features">
                <div class="feature-box-unique">
                    <div class="feature-box-icon"><i class="fa-solid fa-arrows-rotate"></i></div>
                    <h5>Roster Updates</h5>
                    <p>Instant player transfers and squad optimization.</p>
                </div>
                <div class="feature-box-unique">
                    <div class="feature-box-icon"><i class="fa-solid fa-bell"></i></div>
                    <h5>Fixture Alerts</h5>
                    <p>Automated match reminders and schedule sync.</p>
                </div>
                <div class="feature-box-unique">
                    <div class="feature-box-icon"><i class="fa-solid fa-cloud-arrow-up"></i></div>
                    <h5>Secure DB Sync</h5>
                    <p>Encrypted cloud records with high redundancy.</p>
                </div>
            </div>
            <div class="grid-row-2-features">
                <div class="feature-box-unique">
                    <div class="feature-box-icon"><i class="fa-solid fa-shield-cat"></i></div>
                    <h5>Captain Control</h5>
                    <p>Absolute team management and tactical authority.</p>
                </div>
                <div class="feature-box-unique">
                    <div class="feature-box-icon"><i class="fa-solid fa-bolt"></i></div>
                    <h5>Instant Access</h5>
                    <p>High-performance lightning fast interface.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 🌟 3 YELLOW THEME IMAGES CARDS SECTION -->
    <div class="section-spacer">
        <div class="extra-images-section">
            <div class="extra-images-grid">
                <div class="extra-img-card">
                    <div class="extra-img-content">
                        <h4>Tournament Glory</h4>
                        <p>Lifting the ultimate cup of victory.</p>
                    </div>
                    <div class="extra-avatar">
                        <img src="https://i.pinimg.com/736x/2e/0f/34/2e0f3447204e89a15664651896181383.jpg" alt="Tournament Glory">
                    </div>
                </div>
                <div class="extra-img-card">
                    <div class="extra-img-content">
                        <h4>Victorious Moments</h4>
                        <p>Pure emotion and celebration.</p>
                    </div>
                    <div class="extra-avatar">
                        <img src="https://t3.ftcdn.net/jpg/05/58/68/92/360_F_558689214_FaOrwT5jBMhpLLsOXE4OupzYfdPgkGb7.jpg" alt="Victorious Moments">
                    </div>
                </div>
                <div class="extra-img-card">
                    <div class="extra-img-content">
                        <h4>Cricketing Passion</h4>
                        <p>Dedication on every single delivery.</p>
                    </div>
                    <div class="extra-avatar">
                        <img src="https://www.shutterstock.com/image-vector/illustration-bat-ball-on-cricket-260nw-2589843491.jpg" alt="Cricketing Passion">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- YELLOW BANNER SECTION -->
    <div class="section-spacer">
        <div class="footer-banner-section">
            <div class="footer-banner-box">
                <h3>🏆 Ready to Elevate Your Tournament Experience?</h3>
                <p>Join hundreds of cricket enthusiasts and club organizers managing fixtures effortlessly on ProMatch Arena.</p>
            </div>
        </div>
    </div>

    <!-- 🌟 PRO ARENA HIGHLIGHTS GALLERY -->
    <div class="section-spacer">
        <div class="circle-gallery-section">
            <h3 class="circle-gallery-title">🏟️ Pro Arena Highlights</h3>
            <div class="circle-gallery-grid">
                <div class="circle-card">
                    <div class="circle-card-content">
                        <h4>Floodlit Venues</h4>
                        <p>Meticulously organized world-class stadiums built for electrifying tournament nights.</p>
                    </div>
                    <div class="circle-img-wrapper">
                        <img src="https://www.sportspro.com/wp-content/uploads/2026/03/IPL-2025-virat-kohli.jpg?x86394" alt="Floodlit Venues">
                    </div>
                </div>
                <div class="circle-card">
                    <div class="circle-card-content">
                        <h4>High-Voltage Action</h4>
                        <p>Real-time ball tracking, crucial wickets, and nail-biting match finishes.</p>
                    </div>
                    <div class="circle-img-wrapper">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-_-hPje-O6FfJLPmvOSHTK8rtbMxLZf0wdHTaTIjXOCYOlMAHbjOK4dU&s=10" alt="High-Voltage Action">
                    </div>
                </div>
                <div class="circle-card">
                    <div class="circle-card-content">
                        <h4>Championship Glory</h4>
                        <p>The ultimate reward for dedication, teamwork, and tactical mastery.</p>
                    </div>
                    <div class="circle-img-wrapper">
                        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1szo7JyubHapxBIh4UL_of9XzEtfYo9ItXretmFXARZF3uqCzt43U1jg&s=10" alt="Championship Glory">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- 🌟 GRAND FOOTER SECTION -->
    <footer class="grand-footer-section">
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
    </footer>

    <!-- 🌟 SUCCESS POPUP MODAL -->
    <div class="success-modal" id="successModal">
        <div class="success-content">
            <div class="success-icon"><i class="fa-solid fa-circle-check"></i></div>
            <h3>Message Sent Successfully!</h3>
            <p>Thank you for reaching out to ProMatch Arena Support. Our team has received your message and will respond shortly.</p>
            <button class="btn-close-popup" onclick="closeSuccessModal()">Okay, Got It</button>
        </div>
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        class ContactManager {
            static init() {
                const form = document.getElementById('contactForm');
                if (form) {
                    form.addEventListener('submit', (e) => this.handleSubmit(e));
                }
            }

            static handleSubmit(event) {
                event.preventDefault();
                document.getElementById('successModal').classList.add('active');
                event.target.reset();
            }
        }

        function closeSuccessModal() {
            document.getElementById('successModal').classList.remove('active');
        }

        window.addEventListener('click', function(e) {
            const modal = document.getElementById('successModal');
            if (e.target === modal) {
                modal.classList.remove('active');
            }
        });

        document.addEventListener('DOMContentLoaded', () => {
            ContactManager.init();
        });
    </script>
</body>
</html>