<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="contact" />
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

        html { scroll-behavior: smooth; }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-deep);
            color: var(--text-primary);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            overflow-x: hidden;
            transition: background 0.3s ease, color 0.3s ease;
            position: relative;
        }

        /* AUTOMATIC BACKGROUND FLOATING GLOW */
        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; width: 100%; height: 100%;
            background: radial-gradient(circle at 15% 20%, rgba(0, 217, 255, 0.08) 0%, transparent 45%),
                        radial-gradient(circle at 85% 80%, rgba(181, 55, 242, 0.08) 0%, transparent 45%),
                        radial-gradient(circle at 50% 50%, rgba(0, 255, 136, 0.05) 0%, transparent 60%);
            animation: backgroundFloatPulse 10s ease-in-out infinite alternate;
            z-index: -1;
            pointer-events: none;
        }
        @keyframes backgroundFloatPulse {
            0% { transform: scale(1) translateY(0); opacity: 0.7; }
            50% { transform: scale(1.08) translateY(-15px); opacity: 1; }
            100% { transform: scale(1) translateY(0); opacity: 0.7; }
        }

        /* TOP NAVBAR */
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

        .main-content-wrap { max-width: 1400px; margin: 30px auto; padding: 0 20px; }

        /* HEADER BAR */
        .header-bar { 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            margin-bottom: 40px; 
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

        .section-spacer { margin-top: 60px; margin-bottom: 60px; }

        /* CONTACT HERO */
        .contact-hero {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.12), rgba(181, 55, 242, 0.12)), var(--card-surface);
            border: 1.5px solid var(--border-glass);
            backdrop-filter: blur(20px);
            padding: 70px 40px;
            text-align: center;
            color: var(--text-primary);
            margin-bottom: 40px;
            border-radius: 24px;
            box-shadow: 0 25px 60px rgba(0, 217, 255, 0.2);
        }
        .contact-hero::before {
            content: '';
            position: absolute;
            top: -50%; left: -50%;
            width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(0, 217, 255, 0.18) 0%, rgba(0, 255, 136, 0.08) 35%, transparent 70%);
            animation: heroGlowSpin 12s linear infinite;
            pointer-events: none;
            z-index: 1;
        }
        @keyframes heroGlowSpin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .contact-hero > * { position: relative; z-index: 2; }
        .contact-hero h1 {
            font-weight: 900;
            font-size: 3.5rem;
            margin: 0 0 15px 0;
            text-transform: uppercase;
            letter-spacing: 2px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 0 30px rgba(0, 217, 255, 0.3);
        }
        .contact-hero p { font-size: 1.25rem; opacity: 0.95; margin: 0; color: var(--text-secondary); max-width: 700px; margin-left: auto; margin-right: auto; line-height: 1.6; font-weight: 600; }

        /* TOP 4 CIRCULAR CARDS */
        .cards-grid-4 {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
            max-width: 1400px;
            margin: 0 auto;
        }
        @media(max-width: 992px) { .cards-grid-4 { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 576px) { .cards-grid-4 { grid-template-columns: 1fr; } }

        .mini-circle-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
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
            border-color: var(--neon-cyan);
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 217, 255, 0.2);
        }
        .mini-circle-avatar {
            width: 85px; height: 85px; border-radius: 50%; overflow: hidden;
            border: 3px solid var(--neon-cyan);
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
        .mini-circle-card h6 { font-size: 15px; font-weight: 800; color: var(--neon-cyan); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 1px;}
        .mini-circle-card p { font-size: 12px; color: var(--text-secondary); margin: 0; line-height: 1.4; }

        /* PERSONAL DETAILS 3-CARTS SECTION */
        .personal-contact-section { max-width: 1400px; margin: 0 auto; }
        .personal-contact-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 992px) { .personal-contact-grid { grid-template-columns: 1fr; } }
        
        .personal-contact-card {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(0, 255, 136, 0.08)), var(--card-surface);
            border: 1.5px solid var(--neon-cyan);
            border-radius: 20px;
            padding: 35px 25px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0, 217, 255, 0.15);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .personal-contact-card:hover {
            border-color: var(--neon-emerald);
            transform: translateY(-5px);
            box-shadow: 0 20px 45px rgba(0, 255, 136, 0.25);
        }
        .personal-contact-icon {
            width: 65px; height: 65px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            border-radius: 16px;
            display: flex; align-items: center; justify-content: center;
            color: #030712; font-size: 26px; font-weight: 900;
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(0, 217, 255, 0.5);
        }
        .personal-contact-card h3 {
            font-size: 17px; font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; margin-bottom: 10px;
        }
        .personal-contact-card p {
            font-size: 14px; color: var(--neon-cyan); font-weight: 700;
            margin: 0; word-break: break-all; line-height: 1.5;
        }

        /* ELITE MANAGEMENT 3-CARTS SECTION */
        .elite-management-section { max-width: 1400px; margin: 0 auto; }
        .elite-management-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 992px) { .elite-management-grid { grid-template-columns: 1fr; } }
        
        .elite-management-card {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.1), rgba(0, 217, 255, 0.1)), var(--card-surface);
            border: 1.5px solid var(--neon-purple);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 40px rgba(181, 55, 242, 0.2);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .elite-management-card:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-6px);
            box-shadow: 0 20px 50px rgba(0, 217, 255, 0.3);
        }
        .elite-management-icon {
            width: 75px; height: 75px;
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-cyan));
            border-radius: 18px;
            display: flex; align-items: center; justify-content: center;
            color: #030712; font-size: 30px; font-weight: 900;
            margin-bottom: 25px;
            box-shadow: 0 0 25px rgba(181, 55, 242, 0.6);
        }
        .elite-management-card h3 {
            font-size: 19px; font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; margin-bottom: 12px;
        }
        .elite-management-card p {
            font-size: 14px; color: var(--text-secondary);
            line-height: 1.7; margin: 0; font-weight: 600;
        }

        /* MAIN CONTACT SECTION */
        .contact-container {
            max-width: 1400px;
            margin: 0 auto;
            display: grid; grid-template-columns: 1fr 1.5fr; gap: 30px;
        }
        @media(max-width: 992px) { .contact-container { grid-template-columns: 1fr; gap: 30px; } }

        .contact-info-card, .contact-form-card {
            background: var(--card-surface); backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass); border-radius: 20px; padding: 35px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.4);
            height: 100%;
        }
        .contact-info-card h3, .contact-form-card h3 {
            font-size: 22px; font-weight: 900; margin-bottom: 25px;
            color: var(--text-primary); border-left: 4px solid var(--neon-cyan); padding-left: 12px;
            text-transform: uppercase; letter-spacing: 1px;
        }
        .info-item { display: flex; align-items: flex-start; gap: 18px; margin-bottom: 22px; }
        .info-item:last-child { margin-bottom: 0; }
        .info-item i {
            font-size: 22px; color: var(--neon-cyan);
            margin-top: 4px; background: rgba(0, 217, 255, 0.1);
            width: 45px; height: 45px; border-radius: 10px;
            display: flex; align-items: center; justify-content: center; flex-shrink: 0;
            border: 1.5px solid var(--border-glass);
        }
        .info-item h5 { margin: 0 0 4px 0; font-size: 16px; font-weight: 800; color: var(--text-primary); }
        .info-item p { margin: 0; font-size: 14px; color: var(--text-secondary); line-height: 1.5; }

        /* Form Styling */
        .form-group { margin-bottom: 18px; }
        .form-label { font-size: 11px; font-weight: 700; color: var(--text-secondary); margin-bottom: 6px; display: block; text-transform: uppercase; letter-spacing: 0.6px; }
        .form-control-custom {
            width: 100%; background: rgba(0, 217, 255, 0.04); border: 1.5px solid var(--border-glass);
            border-radius: 10px; padding: 12px 15px; color: var(--text-primary); font-size: 13.5px; outline: none; transition: 0.3s;
        }
        .form-control-custom:focus { border-color: var(--neon-cyan); box-shadow: 0 0 15px rgba(0, 217, 255, 0.25); background: rgba(0, 217, 255, 0.08); }
        textarea.form-control-custom { resize: vertical; height: 140px; }
        .btn-submit {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none;
            width: 100%; padding: 14px; border-radius: 10px; font-weight: 900; font-size: 13.5px; text-transform: uppercase; letter-spacing: 0.8px;
            cursor: pointer; transition: 0.3s; box-shadow: 0 0 20px rgba(0, 217, 255, 0.4); margin-top: 5px;
        }
        .btn-submit:hover { transform: translateY(-2px); box-shadow: 0 0 30px rgba(0, 217, 255, 0.7); }

        /* FEATURE SECTION */
        .custom-feature-section { max-width: 1400px; margin: 0 auto; }
        .grid-row-3-features { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 25px; }
        .grid-row-2-features { display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px; max-width: 900px; margin: 0 auto; }
        @media(max-width: 768px) {
            .grid-row-3-features { grid-template-columns: 1fr; gap: 20px;}
            .grid-row-2-features { grid-template-columns: 1fr; max-width: 100%; gap: 20px;}
        }

        .feature-box-unique {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 18px;
            padding: 30px 20px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
        }
        .feature-box-unique:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-5px);
            box-shadow: 0 20px 45px rgba(0, 217, 255, 0.2);
        }
        .feature-box-icon {
            font-size: 26px; color: #0a0e27;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            width: 60px; height: 60px; border-radius: 14px;
            display: flex; align-items: center; justify-content: center;
            margin: 0 auto 15px auto; box-shadow: 0 0 15px rgba(0, 217, 255, 0.5);
        }
        .feature-box-unique h5 { font-size: 16px; font-weight: 800; color: var(--text-primary); margin-bottom: 8px; text-transform: uppercase; letter-spacing: 0.8px; }
        .feature-box-unique p { font-size: 12.5px; color: var(--text-secondary); margin: 0; line-height: 1.5; font-weight: 600; }

        /* EXTRA IMAGES CARDS SECTION */
        .extra-images-section { max-width: 1400px; margin: 0 auto; text-align: center; }
        .extra-images-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 992px) { .extra-images-grid { grid-template-columns: 1fr; gap: 25px; } }

        .extra-img-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 20px;
            padding: 35px 25px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            display: flex; flex-direction: column; align-items: center;
            transition: all 0.3s ease;
        }
        .extra-img-card:hover {
            border-color: var(--neon-gold);
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(255, 215, 0, 0.25);
        }
        .extra-img-content { margin-bottom: 20px; width: 100%; }
        .extra-img-card h4 { font-size: 17px; font-weight: 800; color: var(--neon-gold); margin: 0 0 6px 0; text-transform: uppercase; letter-spacing: 0.5px; }
        .extra-img-card p { font-size: 13px; color: var(--text-secondary); margin: 0; line-height: 1.5; font-weight: 600; }

        .extra-avatar {
            width: 170px; height: 170px; border-radius: 50%; overflow: hidden;
            border: 3px solid var(--neon-gold); box-shadow: 0 0 20px rgba(255, 215, 0, 0.4);
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
            animation: ultraFastSpin 0.5s linear infinite !important;
        }
        @keyframes ultraFastSpin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        /* BANNER SECTION */
        .footer-banner-section { max-width: 1400px; margin: 0 auto; }
        .footer-banner-box {
            background: linear-gradient(135deg, rgba(255, 215, 0, 0.1), rgba(0, 217, 255, 0.1)), var(--card-surface);
            border: 1.5px solid var(--neon-gold);
            border-radius: 20px;
            padding: 40px 30px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(255, 215, 0, 0.15);
            backdrop-filter: blur(15px);
        }
        .footer-banner-box h3 {
            font-size: 22px; font-weight: 900; color: var(--neon-gold);
            text-transform: uppercase; letter-spacing: 1.2px; margin-bottom: 10px;
        }
        .footer-banner-box p {
            font-size: 14px; color: var(--text-secondary);
            margin: 0; line-height: 1.6; font-weight: 600;
            max-width: 750px; margin-left: auto; margin-right: auto;
        }

        /* ELITE DUO SECTION */
        .elite-duo-section { max-width: 1400px; margin: 0 auto; }
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

        /* PRO ARENA HIGHLIGHTS GALLERY */
        .circle-gallery-section { max-width: 1400px; margin: 0 auto; text-align: center; perspective: 1000px; }
        .circle-gallery-title {
            font-size: 24px; font-weight: 900; text-transform: uppercase; letter-spacing: 1px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;
            margin-bottom: 30px;
        }
        .circle-gallery-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; }
        @media(max-width: 992px) { .circle-gallery-grid { grid-template-columns: 1fr; gap: 25px; } }
        
        .circle-card {
            background: var(--card-surface); border: 1.5px solid var(--border-glass);
            border-radius: 20px; padding: 35px 25px; backdrop-filter: blur(15px);
            display: flex; flex-direction: column; align-items: center; text-align: center;
            transition: all 0.6s cubic-bezier(0.4, 0, 0.2, 1); box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            transform-style: preserve-3d;
        }
        .circle-card:hover {
            transform: rotateY(360deg);
            border-color: var(--neon-cyan);
            box-shadow: 0 20px 45px rgba(0, 217, 255, 0.35);
        }
        .circle-card-content { margin-bottom: 20px; width: 100%; }
        .circle-card h4 { font-size: 17px; font-weight: 800; color: var(--neon-cyan); margin: 0 0 6px 0; text-transform: uppercase; letter-spacing: 0.5px; }
        .circle-card p { font-size: 13px; color: var(--text-secondary); margin: 0; line-height: 1.5; font-weight: 600; }

        .circle-img-wrapper {
            width: 170px; height: 170px; border-radius: 50%; overflow: hidden;
            border: 3px solid var(--neon-cyan); box-shadow: 0 0 20px rgba(0, 217, 255, 0.3);
            background: #000; display: flex; align-items: center; justify-content: center;
        }
        .circle-img-wrapper img {
            width: 100%; height: 100%; object-fit: cover; object-position: center;
            display: block;
            animation: fastContinuousRotate 6s linear infinite;
        }

        /* SUCCESS POPUP MODAL STYLES */
        .success-modal {
            display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(10, 14, 39, 0.85); backdrop-filter: blur(8px); z-index: 2000;
            align-items: center; justify-content: center;
        }
        .success-modal.active { display: flex; }
        .success-content {
            background: var(--card-surface); border: 2px solid var(--neon-emerald); border-radius: 16px;
            padding: 35px; max-width: 420px; width: 90%; text-align: center;
            box-shadow: 0 20px 50px rgba(0, 255, 136, 0.3); animation: popUp 0.3s ease;
            backdrop-filter: blur(15px);
        }
        @keyframes popUp { from { transform: scale(0.8); opacity: 0; } to { transform: scale(1); opacity: 1; } }
        .success-icon { font-size: 45px; color: var(--neon-emerald); margin-bottom: 15px; text-shadow: 0 0 15px rgba(0,255,136,0.5); }
        .success-content h3 { font-size: 20px; font-weight: 900; margin-bottom: 10px; color: var(--text-primary); text-transform: uppercase; }
        .success-content p { font-size: 13.5px; color: var(--text-secondary); margin-bottom: 25px; line-height: 1.6; font-weight: 600; }
        .btn-close-popup {
            background: linear-gradient(135deg, var(--neon-emerald), var(--neon-cyan)); color: #030712; border: none; width: 100%;
            padding: 12px; border-radius: 10px; font-weight: 900; font-size: 13px; text-transform: uppercase; cursor: pointer; transition: 0.3s;
        }
        .btn-close-popup:hover { box-shadow: 0 0 20px rgba(0,255,136,0.6); }

        /* GRAND CYBER FOOTER STYLING (Tournament Match Style) */
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
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 11.5px; letter-spacing: 0.5px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; font-size: 11.5px; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }
    </style>
</head>
<body>

    <!-- NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">
        <!-- HEADER BAR -->
        <div class="header-bar">
            <div class="header-left">
                <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            </div>
            <div>
                <h2 style="font-size: 20px; font-weight: 900; margin: 0; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-transform: uppercase; letter-spacing: 1.5px;">Contact Support</h2>
            </div>
            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
            </div>
        </div>

        <!-- HERO SECTION -->
        <div class="contact-hero">
            <h1>Get in Touch</h1>
            <p>Have questions about tournaments or need technical support? We're here to help!</p>
        </div>

        <!-- PERSONAL DETAILS 3-CARTS SECTION -->
        <div class="section-spacer">
            <div class="personal-contact-section">
                <div class="personal-contact-grid">
                    <div class="personal-contact-card">
                        <div class="personal-contact-icon"><i class="fa-solid fa-phone-volume"></i></div>
                        <h3>Phone Support</h3>
                        <p>+91 7806035087</p>
                    </div>
                    <div class="personal-contact-card">
                        <div class="personal-contact-icon"><i class="fa-solid fa-envelope-open-text"></i></div>
                        <h3>Official Gmail</h3>
                        <p>jitendrasingh07022004@gmail.com</p>
                    </div>
                    <div class="personal-contact-card">
                        <div class="personal-contact-icon"><i class="fa-solid fa-building-shield"></i></div>
                        <h3>Office Headquarters</h3>
                        <p>Bangalore, Karnataka, India</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- TOP 4 CIRCULAR CARDS -->
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

        <!-- ELITE MANAGEMENT 3-CARTS SECTION -->
        <div class="section-spacer">
            <div class="elite-management-section">
                <div class="elite-management-grid">
                    <div class="elite-management-card">
                        <div class="elite-management-icon"><i class="fa-solid fa-clipboard-list"></i></div>
                        <h3>Automated Registrations</h3>
                        <p>Streamline team entries and roster submissions instantly through automated digital verification channels.</p>
                    </div>
                    <div class="elite-management-card">
                        <div class="elite-management-icon"><i class="fa-solid fa-chart-pie"></i></div>
                        <h3>Real-Time NRR Tracking</h3>
                        <p>Advanced algorithmic scoreboards compute net run rates dynamically after every single match delivery.</p>
                    </div>
                    <div class="elite-management-card">
                        <div class="elite-management-icon"><i class="fa-solid fa-user-shield"></i></div>
                        <h3>Role-Based Squad Admin</h3>
                        <p>Secure administrative and captain controls ensuring absolute integrity across tournament brackets.</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- MAIN CONTACT SECTION -->
        <div class="section-spacer">
            <div class="contact-container">
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

        <!-- FEATURE SECTION -->
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

        <!-- EXTRA IMAGES CARDS SECTION -->
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

        <!-- BANNER SECTION -->
        <div class="section-spacer">
            <div class="footer-banner-section">
                <div class="footer-banner-box">
                    <h3>🏆 Ready to Elevate Your Tournament Experience?</h3>
                    <p>Join hundreds of cricket enthusiasts and club organizers managing fixtures effortlessly on ProMatch Arena.</p>
                </div>
            </div>
        </div>

        <!-- ELITE DUO SECTION -->
        <div class="section-spacer">
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
        </div>

        <!-- PRO ARENA HIGHLIGHTS GALLERY -->
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

        <!-- 🌟 FOOTER INCLUDE (Only Footer Added Here) -->
        <jsp:include page="footer.jsp" />
    </div>

    <!-- SUCCESS POPUP MODAL -->
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
        function handleContactSubmit(e) {
            e.preventDefault();
            document.getElementById('successModal').classList.add('active');
            e.target.reset();
        }

        function closeSuccessModal() {
            document.getElementById('successModal').classList.remove('active');
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