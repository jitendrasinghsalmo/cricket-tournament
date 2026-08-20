<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="about" />
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
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-primary);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* 🌟 EXACT MATCHING NAVBAR */
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

        .container { max-width: 1300px; margin: 30px auto; padding: 0 20px; }

        /* HEADER BAR (Back Button + Page Title + Theme Toggle) */
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
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
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

        /* HERO SECTION */
        .about-hero {
            position: relative;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.12), rgba(181, 55, 242, 0.12)), var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 30px;
            padding: 85px 50px;
            text-align: center;
            margin-bottom: 45px;
            box-shadow: 0 35px 70px rgba(0, 0, 0, 0.6);
            overflow: hidden;
            backdrop-filter: blur(20px);
        }

        .hero-wave-light {
            position: absolute; width: 150%; height: 150%; top: -25%; left: -25%;
            background: radial-gradient(circle, rgba(0, 217, 255, 0.15) 0%, rgba(0, 255, 136, 0.1) 40%, transparent 70%);
            animation: waveRotation 15s linear infinite; pointer-events: none; z-index: 1;
        }

        @keyframes waveRotation {
            0% { transform: rotate(0deg) scale(1); }
            50% { transform: rotate(180deg) scale(1.15); }
            100% { transform: rotate(360deg) scale(1); }
        }

        .dynamic-hero-content { position: relative; z-index: 2; }

        .about-hero h1 { font-size: 42px; font-weight: 900; margin-bottom: 20px; color: var(--text-primary); text-transform: uppercase; }
        .about-hero h1 span { color: var(--neon-cyan); text-shadow: 0 0 25px rgba(0,217,255,0.6); }
        .about-hero p { color: var(--text-secondary); font-size: 16.5px; max-width: 880px; margin: 0 auto; line-height: 1.85; font-weight: 600; }
        
        .hero-badge {
            display: inline-flex; align-items: center; gap: 10px;
            background: rgba(0, 217, 255, 0.15); color: var(--neon-cyan);
            border: 1px solid var(--border-glass); padding: 9px 20px;
            border-radius: 30px; font-size: 13px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 1.5px; margin-bottom: 25px; box-shadow: 0 0 20px rgba(0,217,255,0.3);
        }

        /* DETAILED PROJECT DESCRIPTION SECTION */
        .project-description-box {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 24px;
            padding: 50px;
            margin-bottom: 45px;
            box-shadow: 0 20px 45px rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
        }
        .project-description-box h3 {
            font-size: 24px;
            font-weight: 900;
            color: var(--neon-cyan);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            border-bottom: 1.5px solid var(--border-glass);
            padding-bottom: 15px;
        }
        .project-description-content p {
            color: var(--text-secondary);
            font-size: 15px;
            line-height: 1.85;
            margin-bottom: 20px;
            font-weight: 600;
        }
        .project-description-content h4 {
            color: var(--text-primary);
            font-size: 18px;
            font-weight: 800;
            margin-top: 30px;
            margin-bottom: 12px;
        }

        /* ELITE SHOWCASE CARDS */
        .elite-cricket-showcase {
            max-width: 1300px; margin: 0 auto 45px auto;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(0, 255, 136, 0.08)), var(--card-surface);
            border: 1.5px solid var(--border-glass); border-radius: 28px; padding: 40px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
        }
        .elite-showcase-title {
            text-align: center; font-size: 26px; font-weight: 900; margin-bottom: 12px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-transform: uppercase;
        }
        .elite-showcase-subtitle { text-align: center; color: var(--text-secondary); font-size: 14.5px; max-width: 700px; margin: 0 auto 35px auto; font-weight: 600; }
        .elite-showcase-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 900px) { .elite-showcase-grid { grid-template-columns: 1fr; } }

        .elite-showcase-card {
            background: rgba(13, 18, 35, 0.9); border: 1.5px solid var(--border-glass);
            border-radius: 20px; padding: 35px 25px; text-align: center; transition: all 0.3s ease;
            display: flex; flex-direction: column; justify-content: space-between;
        }
        .elite-showcase-card:hover { transform: translateY(-6px); border-color: var(--neon-cyan); box-shadow: 0 15px 35px rgba(0,217,255,0.25); }
        .elite-icon-gem {
            width: 75px; height: 75px; background: linear-gradient(135deg, rgba(0, 217, 255, 0.2), rgba(0, 255, 136, 0.2));
            border: 2px solid var(--neon-cyan); border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 28px; color: var(--neon-cyan); margin: 0 auto 20px auto; box-shadow: 0 0 20px rgba(0,217,255,0.3);
        }
        .elite-card-body h4 { font-size: 18px; font-weight: 800; color: var(--text-primary); margin-bottom: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        .elite-card-body p { font-size: 13.5px; color: var(--text-secondary); margin-bottom: 25px; font-weight: 600; line-height: 1.6; }
        .elite-badge-tag {
            display: inline-flex; align-items: center; justify-content: center; gap: 6px; background: rgba(0, 255, 136, 0.15);
            color: var(--neon-emerald); border: 1px solid rgba(0, 255, 136, 0.4); padding: 8px 16px;
            border-radius: 20px; font-size: 11.5px; font-weight: 800; text-transform: uppercase; margin: 0 auto;
        }

        /* 🌟 HOVER ANIMATION ADDED TO DOC CARDS */
        .docs-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 30px; margin-bottom: 40px; }
        @media(max-width: 900px) { .docs-grid { grid-template-columns: 1fr; } }

        .doc-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass);
            border-radius: 24px; padding: 40px; box-shadow: 0 20px 45px rgba(0,0,0,0.4);
            backdrop-filter: blur(15px);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .doc-card:hover {
            transform: translateY(-8px) scale(1.01);
            border-color: var(--neon-cyan);
            box-shadow: 0 25px 50px rgba(0, 217, 255, 0.3);
        }
        .doc-card h3 { font-size: 20px; font-weight: 800; margin-bottom: 24px; display: flex; align-items: center; gap: 15px; border-bottom: 1px solid var(--border-glass); padding-bottom: 16px; color: var(--text-primary); }
        .doc-card h3 i { background: rgba(0, 217, 255, 0.12); padding: 12px; border-radius: 14px; border: 1px solid var(--border-glass); color: var(--neon-cyan); }
        
        .feature-list { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 18px; }
        .feature-list li { display: flex; align-items: flex-start; gap: 14px; font-size: 14.5px; color: var(--text-secondary); line-height: 1.65; font-weight: 600; }
        .feature-list li i { color: var(--neon-emerald); margin-top: 4px; font-size: 16px; }
        .feature-list li strong { color: var(--text-primary); }

        .tech-stack-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; margin-top: 22px; }
        .tech-item {
            background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 18px 12px; text-align: center; transition: 0.3s;
        }
        .tech-item:hover { border-color: var(--neon-cyan); background: rgba(0, 217, 255, 0.08); transform: translateY(-3px); }
        .tech-item i { font-size: 26px; color: var(--neon-cyan); margin-bottom: 10px; display: block; }
        .tech-item span { font-size: 13px; font-weight: 800; color: var(--text-primary); display: block; }
        .tech-item p { font-size: 11px; color: var(--text-secondary); margin: 4px 0 0 0; font-weight: 600; }

        .workflow-box {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 24px; padding: 45px; margin-bottom: 40px; box-shadow: 0 20px 45px rgba(0,0,0,0.4); backdrop-filter: blur(15px);
        }
        .workflow-steps { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        @media(max-width: 1024px) { .workflow-steps { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 600px) { .workflow-steps { grid-template-columns: 1fr; } }

        /* 🌟 HOVER ANIMATION ADDED TO STEP CARDS */
        .step-card { 
            background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 18px; padding: 25px; text-align: center; 
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }
        .step-card:hover {
            transform: translateY(-8px) scale(1.02);
            border-color: var(--neon-cyan);
            background: rgba(0, 217, 255, 0.05);
            box-shadow: 0 15px 35px rgba(0, 217, 255, 0.25);
        }
        .step-num { width: 38px; height: 38px; background: var(--neon-cyan); color: #030712; font-weight: 900; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 16px auto; font-size: 15px; box-shadow: 0 0 15px rgba(0,217,255,0.6); }
        .step-card h5 { font-size: 16px; font-weight: 800; margin-bottom: 8px; color: var(--text-primary); }
        .step-card p { font-size: 12.5px; color: var(--text-secondary); margin: 0; line-height: 1.55; font-weight: 600; }

        /* 🌟 NEW STUNNING SINGLE BANNER SECTION ADDED BEFORE VIDEOS */
        .feature-highlight-banner {
            max-width: 1300px;
            margin: 0 auto 40px auto;
            background: linear-gradient(135deg, rgba(0, 255, 136, 0.12), rgba(0, 217, 255, 0.12)), var(--card-surface);
            border: 2px solid var(--neon-emerald);
            border-radius: 22px;
            padding: 40px;
            text-align: center;
            box-shadow: 0 15px 45px rgba(0, 255, 136, 0.2);
            backdrop-filter: blur(15px);
            transition: all 0.4s ease;
        }
        .feature-highlight-banner:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 55px rgba(0, 255, 136, 0.35);
            border-color: var(--neon-cyan);
        }
        .feature-highlight-banner h3 {
            font-size: 24px;
            font-weight: 900;
            color: var(--neon-emerald);
            text-transform: uppercase;
            letter-spacing: 1.2px;
            margin-bottom: 12px;
            text-shadow: 0 0 15px rgba(0, 255, 136, 0.5);
        }
        .feature-highlight-banner p {
            font-size: 14.5px;
            color: var(--text-secondary);
            max-width: 850px;
            margin: 0 auto;
            line-height: 1.7;
            font-weight: 600;
        }

        .video-highlights-box {
            background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 24px; padding: 45px; margin-bottom: 40px; box-shadow: 0 20px 45px rgba(0,0,0,0.4); backdrop-filter: blur(15px);
        }
        .video-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; margin-top: 25px; }
        @media(max-width: 900px) { .video-grid { grid-template-columns: 1fr; } }
        
        .video-card-item { background: transparent; height: 380px; perspective: 1000px; cursor: pointer; }
        .video-card-flip-inner { position: relative; width: 100%; height: 100%; text-align: center; transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1); transform-style: preserve-3d; }
        .video-card-item:hover .video-card-flip-inner { transform: rotateY(360deg); }
        
        .v-card-front, .v-card-back { position: absolute; width: 100%; height: 100%; backface-visibility: hidden; border-radius: 18px; overflow: hidden; border: 1.5px solid var(--border-glass); background: rgba(13, 18, 35, 0.95); display: flex; flex-direction: column; }
        .v-card-back { transform: rotateY(180deg); background: rgba(13, 18, 35, 0.98); align-items: center; justify-content: center; padding: 25px; color: var(--text-primary); text-align: center; }
        .v-card-back h5 { color: var(--neon-cyan); font-weight: 800; margin-bottom: 10px; font-size: 16px; text-transform: uppercase; }
        .v-card-back p { color: var(--text-secondary); font-size: 13px; line-height: 1.5; margin: 0; font-weight: 600; }
        .video-content-top { padding: 16px 14px; background: rgba(13, 18, 35, 0.98); border-bottom: 1.5px solid var(--border-glass); text-align: left; }
        .video-content-top h4 { margin: 0 0 4px 0; font-size: 15px; font-weight: 800; color: var(--neon-cyan); }
        .video-content-top p { margin: 0; font-size: 12px; color: var(--text-secondary); font-weight: 600; }
        .video-thumb-wrapper { position: relative; width: 100%; height: 250px; background: #000; overflow: hidden; display: flex; align-items: center; justify-content: center; flex-grow: 1; }
        .video-thumb-wrapper img { width: 100%; height: 100%; object-fit: cover; }
        .play-btn-overlay { position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); background: rgba(0, 217, 255, 0.9); color: #030712; width: 45px; height: 45px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 18px; box-shadow: 0 0 15px rgba(0,217,255,0.6); }

        .video-modal { display: none; position: fixed; z-index: 2000; left: 0; top: 0; width: 100%; height: 100%; background: rgba(3, 7, 18, 0.9); backdrop-filter: blur(10px); align-items: center; justify-content: center; padding: 20px; }
        .video-modal-content { background: var(--card-surface); border: 1.5px solid var(--border-glass); border-radius: 20px; width: 100%; max-width: 800px; padding: 25px; position: relative; text-align: center; }
        .close-modal { position: absolute; top: 15px; right: 20px; color: var(--text-secondary); font-size: 24px; font-weight: 800; cursor: pointer; }

        /* PRO-SHOWCASE GALLERY WITH 360° HOVER ROTATION */
        .pro-showcase-gallery-section { max-width: 1300px; margin: 0 auto 40px auto; background: var(--card-surface); backdrop-filter: blur(15px); border: 1.5px solid var(--border-glass); border-radius: 24px; padding: 40px; box-shadow: 0 20px 45px rgba(0,0,0,0.4); }
        .pro-showcase-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 768px) { .pro-showcase-grid { grid-template-columns: 1fr; } }
        .pro-showcase-box { background: rgba(13, 18, 35, 0.9); border: 1.5px solid var(--border-glass); border-radius: 18px; overflow: hidden; display: flex; flex-direction: column; transition: 0.3s; }
        .pro-showcase-box:hover { transform: translateY(-6px); border-color: var(--neon-cyan); box-shadow: 0 15px 35px rgba(0,217,255,0.25); }
        .pro-box-header { padding: 16px; text-align: center; background: rgba(3, 7, 18, 0.95); border-bottom: 1.5px solid var(--border-glass); }
        .pro-box-header h4 { margin: 0 0 5px 0; font-size: 15px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; }
        .pro-box-header p { margin: 0; font-size: 12px; color: var(--text-secondary); font-weight: 600; }
        .pro-box-img-wrapper { width: 100%; height: 280px; overflow: hidden; background: #000; }
        .pro-box-img-wrapper img { width: 100%; height: 100%; object-fit: cover; display: block; transition: transform 0.8s cubic-bezier(0.4, 0, 0.2, 1); }
        .pro-showcase-box:hover .pro-box-img-wrapper img { transform: rotate(360deg) scale(1.05); }

        /* ELITE DUO SECTION */
        .elite-duo-section { max-width: 1300px; margin: 0 auto 40px auto; }
        .elite-duo-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }
        @media(max-width: 992px) { .elite-duo-grid { grid-template-columns: 1fr; } }
        
        .elite-duo-card {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.1), rgba(0, 217, 255, 0.1)), var(--card-surface);
            border: 1.5px solid var(--neon-purple);
            border-radius: 18px; padding: 35px 30px;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(181, 55, 242, 0.2);
            display: flex; gap: 20px; align-items: center; transition: all 0.3s ease;
        }
        .elite-duo-card:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-4px);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.3);
        }
        .elite-duo-icon {
            min-width: 65px; height: 65px;
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-cyan));
            border-radius: 16px; display: flex; align-items: center; justify-content: center;
            color: #030712; font-size: 26px; font-weight: 900;
            box-shadow: 0 0 20px rgba(181, 55, 242, 0.5); flex-shrink: 0;
        }
        .elite-duo-content h3 {
            font-size: 18px; font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 0.8px; margin-bottom: 8px;
        }
        .elite-duo-content p {
            font-size: 13.5px; color: var(--text-secondary);
            line-height: 1.6; margin: 0; font-weight: 600;
        }

        /* 🌟 GRAND CYBER FOOTER STYLING (Tournament Match Style) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; border-left: none !important; padding-left: 0 !important; }
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

    <jsp:include page="navbar.jsp" />

    <div class="container">
        <!-- HEADER BAR (Back Button + Page Title + Theme Toggle) -->
        <div class="header-bar">
            <div class="header-left">
                <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            </div>
            <div>
                <h2 style="font-size: 20px; font-weight: 900; margin: 0; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-transform: uppercase; letter-spacing: 1.5px;">About ProMatch</h2>
            </div>
            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
            </div>
        </div>

        <div class="about-hero">
            <div class="hero-wave-light"></div>
            <div class="dynamic-hero-content">
                <div class="hero-badge"><i class="fa-solid fa-shield-halved"></i> Enterprise Sports Engine</div>
                <h1>About <span>ProMatch Arena</span></h1>
                <p>An elite, full-stack enterprise sports management platform engineered to automate cricket tournament registration, live squad rosters, secure payments, and role-based administration with ultimate performance.</p>
            </div>
        </div>

        <div class="project-description-box">
            <h3><i class="fa-solid fa-circle-info"></i> Comprehensive Overview & System Architecture</h3>
            <div class="project-description-content">
                <p>ProMatch Arena is engineered as an enterprise-grade sports management and tournament orchestration ecosystem designed to streamline the complexities of modern cricket leagues. In competitive athletics, managing multi-tiered tournaments, maintaining live squad rosters, coordinating real-time registration pipelines, and handling secure payment verifications require a highly resilient technical foundation. Traditional manual record-keeping or fragmented software solutions often struggle with data concurrency, session synchronization bottlenecks, and inadequate user interfaces. ProMatch Arena solves these challenges by combining a powerful Spring Boot backend with a futuristic Cyber Glassmorphism interface, delivering a seamless experience for administrators, team organizers, and cricket fans alike.</p>
                
                <p>The system is built upon robust object-oriented programming principles, utilizing Java Spring Boot for rapid service orchestration and RESTful API management. Data persistence is handled via Hibernate and Java Persistence API (JPA), interfacing directly with a secure PostgreSQL database. This ensures atomic transactions, ACID compliance, and zero-latency retrieval of team statistics, player profiles, and points standings. Whether executing intricate Net Run Rate (NRR) mathematical calculations or rendering dynamic pagination layouts, the backend core maintains high throughput even under intense concurrent traffic loads.</p>

                <h4>Role-Based Access Control & Security Architecture</h4>
                <p>Security is paramount within the ProMatch Arena ecosystem. Powered by Spring Security, the application implements strict role-based authorization hierarchies distinguishing between regular participants and authorized system administrators. Administrators are equipped with an advanced Tournament Command Center, granting them granular control over tournament lifecycles, team approvals, match schedulers, and database maintenance protocols. Users interact with dedicated dashboards where they can securely register new teams, manage player rosters, and review tournament analytics. Session persistence and input sanitization protocols further protect the system against common web vulnerabilities, guaranteeing absolute data protection.</p>

                <h4>User Interface & Modular Ecosystem Workflows</h4>
                <p>Complementing its backend strength, the platform features a responsive Cyber Glassmorphism UI crafted using HTML5, CSS3, JavaScript, and Bootstrap. The visual language utilizes deep midnight gradients accented by neon cyan and emerald green tones, establishing an immersive athletic atmosphere. A persistent dual-theme mechanism empowers users to switch instantly between an immersive Cyber Dark mode and a clean Professional Light mode. Through its modular architecture—spanning automated tournament registration, secure Razorpay financial checkouts, live fixture scorecards, and architectural document centers—ProMatch Arena sets a benchmark for professional cricket league management software.</p>
            </div>
        </div>

        <div class="elite-cricket-showcase">
            <h3 class="elite-showcase-title">⚡ Core Architecture Highlights</h3>
            <p class="elite-showcase-subtitle">Discover the high-performance modules and secure engines powering the ProMatch Arena platform.</p>
            
            <div class="elite-showcase-grid">
                <div class="elite-showcase-card">
                    <div>
                        <div class="elite-icon-gem"><i class="fa-solid fa-microchip"></i></div>
                        <div class="elite-card-body">
                            <h4>Spring Boot Core</h4>
                            <p>High-throughput enterprise REST services designed to handle extreme concurrent traffic without latency.</p>
                        </div>
                    </div>
                    <span class="elite-badge-tag"><i class="fa-solid fa-bolt"></i> Ultra Fast</span>
                </div>

                <div class="elite-showcase-card">
                    <div>
                        <div class="elite-icon-gem"><i class="fa-solid fa-shield-halved"></i></div>
                        <div class="elite-card-body">
                            <h4>Secure Authorization</h4>
                            <p>Advanced role-based access control protecting administrative commands and private user dashboards.</p>
                        </div>
                    </div>
                    <span class="elite-badge-tag"><i class="fa-solid fa-lock"></i> 100% Secure</span>
                </div>

                <div class="elite-showcase-card">
                    <div>
                        <div class="elite-icon-gem"><i class="fa-solid fa-credit-card"></i></div>
                        <div class="elite-card-body">
                            <h4>Razorpay Integration</h4>
                            <p>Seamless, encrypted payment gateways ensuring verified financial transactions for tournament entries.</p>
                        </div>
                    </div>
                    <span class="elite-badge-tag"><i class="fa-solid fa-check-circle"></i> Instant Checkout</span>
                </div>
            </div>
        </div>

        <div class="workflow-box">
            <h3><i class="fa-solid fa-layer-group"></i> Enterprise Architecture & Tech Stack</h3>
            <p style="color: var(--text-secondary); font-size: 14.5px; margin-bottom: 25px; font-weight: 600;">Built on robust modern frameworks to guarantee high concurrency, secure session persistence, and zero-latency UI rendering.</p>
            
            <div class="tech-stack-grid">
                <div class="tech-item"><i class="fa-solid fa-leaf"></i><span>Spring Boot</span><p>Core Backend & REST Services</p></div>
                <div class="tech-item"><i class="fa-solid fa-shield-halved"></i><span>Spring Security</span><p>Authentication & Access Control</p></div>
                <div class="tech-item"><i class="fa-solid fa-code"></i><span>JSP & JSTL</span><p>Dynamic Server-Side Views</p></div>
                <div class="tech-item"><i class="fa-solid fa-database"></i><span>Hibernate / JPA</span><p>ORM & Relational Database</p></div>
                <div class="tech-item"><i class="fa-solid fa-credit-card"></i><span>Razorpay API</span><p>Secure Tournament Payments</p></div>
                <div class="tech-item"><i class="fa-solid fa-palette"></i><span>Cyber Glass UI</span><p>Modern Glassmorphism & Bootstrap</p></div>
            </div>
        </div>

        <div class="docs-grid">
            <div class="doc-card">
                <h3><i class="fa-solid fa-clipboard-list"></i> Core System Modules</h3>
                <ul class="feature-list">
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Admin Dashboard Control:</strong> Centralized hub for managing tournaments, team directories, squads, and live match fixtures.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Squad & Roster Management:</strong> Full CRUD operations for team players with jersey numbers, batting/bowling styles, and live search filtration.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Tournament Registration Pipeline:</strong> Seamless team entry registration coupled with automated payment verification workflows.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Dual Theme Engine:</strong> Persistent Cyber Dark mode and clean Professional Light mode stored locally via browser `localStorage`.</li>
                </ul>
            </div>

            <div class="doc-card">
                <h3><i class="fa-solid fa-gears"></i> Engineering Fixes & Optimizations</h3>
                <ul class="feature-list">
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Enum-to-String Safety (`.name()`):</strong> Resolved Jakarta EL runtime conversion crashes by safely evaluating Entity Enum roles in JSTL tags.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>HTTP 405 Resolution:</strong> Cleanly split Controller GET and POST mappings to eliminate method mismatch errors during form submissions.</li>
                    <li><i class="fa-solid fa-check-circle"></i> <strong>Dynamic Role Routing:</strong> Intelligent navigation rendering that safely directs ADMINs to control hubs and USERs to standard dashboards.</li>
                </ul>
            </div>
        </div>

        <div class="workflow-box">
            <h3><i class="fa-solid fa-route"></i> Tournament Registration & Match Workflow</h3>
            <div class="workflow-steps" style="margin-top: 22px;">
                <div class="step-card">
                    <div class="step-num">1</div>
                    <h5>User Authentication</h5>
                    <p>Secure login with role assignment (ADMIN vs USER) via Spring Security.</p>
                </div>
                <div class="step-card">
                    <div class="step-num">2</div>
                    <h5>Team & Squad Entry</h5>
                    <p>Register tournament teams and add active player rosters with specs.</p>
                </div>
                <div class="step-card">
                    <div class="step-num">3</div>
                    <h5>Payment Gateway</h5>
                    <p>Smooth integration with Razorpay for verified entry fee settlements.</p>
                </div>
                <div class="step-card">
                    <div class="step-num">4</div>
                    <h5>Live Analytics</h5>
                    <p>Track fixture scorecards, points tables, and team standings in real-time.</p>
                </div>
            </div>
        </div>

        <!-- 🌟 NEW FEATURE HIGHLIGHT BANNER BEFORE VIDEOS -->
        <div class="feature-highlight-banner">
            <h3>🏆 Elite Tournament Experience & Live Streaming</h3>
            <p>Immerse yourself in real-time match replays, tactical innings breakdowns, and championship celebrations designed with ultra-low streaming latency.</p>
        </div>

        <div class="video-highlights-box">
            <h3 style="font-size: 20px; font-weight: 800; margin: 0 0 8px 0; display: flex; align-items: center; gap: 12px;">
                <i class="fa-solid fa-video" style="color: var(--neon-cyan);"></i> Live Cricket Match Highlights & Replays
            </h3>
            <p style="color: var(--text-secondary); font-size: 14.5px; margin: 0 0 25px 0; font-weight: 600;">Experience the raw energy of professional tournament clashes. Hover to flip cards or click to stream high-definition match highlights instantly.</p>

            <div class="video-grid">
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

        <div class="elite-duo-section">
            <div class="elite-duo-grid">
                <div class="elite-duo-card">
                    <div class="elite-duo-icon"><i class="fa-solid fa-chart-line"></i></div>
                    <div class="elite-duo-content">
                        <h3>Dynamic NRR Tracking</h3>
                        <p>Zero delay algorithm updates compute net run rates instantly across all active fixtures.</p>
                    </div>
                </div>
                <div class="elite-duo-card">
                    <div class="elite-duo-icon"><i class="fa-solid fa-shield-cat"></i></div>
                    <div class="elite-duo-content">
                        <h3>Secure Squad Management</h3>
                        <p>Verified player authentications and robust role management built for professional leagues.</p>
                    </div>
                </div>
            </div>
        </div>

        <div id="videoModal" class="video-modal">
            <div class="video-modal-content">
                <span class="close-modal" onclick="closeVideo()">&times;</span>
                <h4 style="color: var(--neon-cyan); margin-bottom: 15px; font-weight: 800;">ProMatch Arena Live Stream</h4>
                <div style="position: relative; padding-bottom: 56.25%; height: 0; overflow: hidden; border-radius: 12px;">
                    <iframe id="videoIframe" src="" style="position: absolute; top: 0; left: 0; width: 100%; height: 100%; border:0;" allowfullscreen></iframe>
                </div>
            </div>
        </div>

        <div class="pro-showcase-gallery-section">
            <h3 style="text-align:center; font-size: 22px; font-weight: 900; margin-bottom: 25px; color: var(--neon-cyan); text-transform: uppercase;">🏟️ Pro Tournament Showcase</h3>
            <div class="pro-showcase-grid">
                <div class="pro-showcase-box">
                    <div class="pro-box-header">
                        <h4>🏟️ Arena Stadium</h4>
                        <p>Grand venue illumination for professional fixtures.</p>
                    </div>
                    <div class="pro-box-img-wrapper"><img src="https://img.magnific.com/premium-photo/charming-energetic-poster-announcing-upc_981650-68087.jpg?w=1500" alt="Stadium Arena"></div>
                </div>
                <div class="pro-showcase-box">
                    <div class="pro-box-header">
                        <h4>⚡ Match Action</h4>
                        <p>High-voltage cricket action and gameplay.</p>
                    </div>
                    <div class="pro-box-img-wrapper"><img src="https://img.magnific.com/premium-vector/cricket-championship-concept_1302-17549.jpg?w=1500" alt="Cricket Match"></div>
                </div>
                <div class="pro-showcase-box">
                    <div class="pro-box-header">
                        <h4>🏆 Victory Moment</h4>
                        <p>Trophy celebrations and winning moments.</p>
                    </div>
                    <div class="pro-box-img-wrapper"><img src="https://ichef.bbci.co.uk/ace/standard/1552/cpsprodpb/b363/live/acde0890-06f2-11f0-a86b-a333e99bcfef.jpg" alt="Victory Celebration"></div>
                </div>
            </div>
        </div>

        <!-- 🌟 FOOTER INCLUDE (Exact Tournament Match Footer Style) -->
        <jsp:include page="footer.jsp" />
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
    </script>
</body>
</html>