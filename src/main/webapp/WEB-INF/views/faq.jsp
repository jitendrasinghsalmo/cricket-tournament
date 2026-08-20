<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="faq" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | FAQ & Support Center</title>
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

        * { box-sizing: border-box; }

        body { 
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif; 
            background-color: var(--bg-deep);
            color: var(--text-primary); 
            margin: 0; 
            padding: 0; 
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* TOURNAMENT PAGE STYLED NAVBAR */
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

        /* 🌟 PERFECTLY PROPORTIONED FAQ HERO SECTION WITH GLOW ANIMATION */
        .faq-hero {
            position: relative;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.12), rgba(181, 55, 242, 0.12)), var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 30px;
            padding: 85px 50px;
            text-align: center;
            margin-bottom: 40px;
            box-shadow: 0 35px 70px rgba(0, 0, 0, 0.6);
            overflow: hidden;
            backdrop-filter: blur(20px);
        }

        .hero-wave-light {
            position: absolute; width: 150%; height: 150%; top: -25%; left: -25%;
            background: radial-gradient(circle, rgba(0, 217, 255, 0.18) 0%, rgba(0, 255, 136, 0.12) 40%, transparent 70%);
            animation: waveRotation 15s linear infinite; pointer-events: none; z-index: 1;
        }

        @keyframes waveRotation {
            0% { transform: rotate(0deg) scale(1); }
            50% { transform: rotate(180deg) scale(1.15); }
            100% { transform: rotate(360deg) scale(1); }
        }

        .dynamic-hero-content { position: relative; z-index: 2; }

        .faq-hero h1 {
            font-weight: 900;
            font-size: 3.2rem;
            margin: 0 0 15px 0;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 0 30px rgba(0, 217, 255, 0.3);
        }

        .faq-hero p {
            font-size: 1.2rem;
            opacity: 0.95;
            margin: 0 auto;
            max-width: 800px;
            letter-spacing: 0.5px;
            color: var(--text-secondary);
            font-weight: 600;
            line-height: 1.6;
        }

        .hero-badge {
            display: inline-flex; align-items: center; gap: 10px;
            background: rgba(0, 217, 255, 0.15); color: var(--neon-cyan);
            border: 1px solid var(--border-glass); padding: 9px 20px;
            border-radius: 30px; font-size: 13px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 1.5px; margin-bottom: 25px; box-shadow: 0 0 20px rgba(0,217,255,0.3);
        }

        .ticker-container {
            width: 100%;
            background: rgba(3, 7, 18, 0.95);
            border-top: 1.5px solid var(--neon-cyan);
            border-bottom: 1.5px solid var(--neon-cyan);
            overflow: hidden;
            white-space: nowrap;
            padding: 12px 0;
            margin-bottom: 40px;
            box-shadow: 0 0 25px rgba(0, 217, 255, 0.3);
            position: relative;
            border-radius: 12px;
        }

        .ticker-wrapper {
            display: inline-block;
            white-space: nowrap;
            animation: seamlessTicker 30s linear infinite;
        }

        .ticker-item {
            display: inline-block;
            font-size: 13.5px;
            font-weight: 800;
            color: var(--neon-cyan);
            text-transform: uppercase;
            letter-spacing: 1.5px;
            padding-right: 50px;
        }

        @keyframes seamlessTicker {
            0% { transform: translate3d(0, 0, 0); }
            100% { transform: translate3d(-50%, 0, 0); }
        }

        .category-tabs {
            max-width: 1400px;
            margin: 0 auto 40px auto;
            display: flex;
            justify-content: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .tab-btn {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            color: var(--text-secondary);
            padding: 12px 24px;
            border-radius: 12px;
            font-weight: 700;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            white-space: nowrap;
        }

        .tab-btn:hover {
            border-color: var(--neon-cyan);
            color: var(--neon-cyan);
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.2);
        }

        .tab-btn.active {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            border-color: var(--neon-cyan);
            color: #0a0e27;
            box-shadow: 0 0 20px rgba(0, 217, 255, 0.4);
        }

        .faq-container {
            max-width: 1000px;
            margin: 0 auto 50px auto;
        }

        .faq-category { display: none; }
        .faq-category.active { display: block; animation: fadeIn 0.3s ease; }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .faq-item {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 12px;
            margin-bottom: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .faq-item:hover {
            border-color: var(--neon-cyan);
            box-shadow: 0 8px 24px rgba(0, 217, 255, 0.15);
        }

        .faq-question {
            padding: 18px 24px;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-weight: 700;
            font-size: 14px;
            color: var(--text-primary);
            transition: all 0.3s ease;
            background: rgba(0, 217, 255, 0.04);
        }

        .faq-question:hover {
            background: rgba(0, 217, 255, 0.08);
            color: var(--neon-cyan);
        }

        .faq-icon {
            width: 28px;
            height: 28px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #0a0e27;
            font-weight: 800;
            transition: all 0.3s ease;
            margin-left: 15px;
            flex-shrink: 0;
        }

        .faq-item.active .faq-icon {
            transform: rotate(180deg);
            background: linear-gradient(135deg, var(--neon-rose), var(--neon-gold));
        }

        .faq-answer {
            max-height: 0;
            overflow: hidden;
            transition: max-height 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            padding: 0 24px;
            color: var(--text-secondary);
            line-height: 1.8;
        }

        .faq-item.active .faq-answer {
            max-height: 300px;
            padding: 24px;
            border-top: 1px solid var(--border-glass);
            background: rgba(0, 217, 255, 0.04);
        }

        /* 3-Carts Section */
        .cyber-features-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
        }
        .cyber-features-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
        }
        @media(max-width: 992px) { .cyber-features-grid { grid-template-columns: 1fr; } }
        
        .cyber-feature-card {
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(181, 55, 242, 0.08)), var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 18px;
            padding: 35px 25px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.3);
            transition: all 0.3s ease;
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        .cyber-feature-card:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-5px);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.25);
        }
        .cyber-card-icon {
            width: 65px;
            height: 65px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #030712;
            font-size: 26px;
            font-weight: 900;
            margin-bottom: 20px;
            box-shadow: 0 0 20px rgba(0, 217, 255, 0.5);
        }
        .cyber-feature-card h3 {
            font-size: 18px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
        }
        .cyber-feature-card p {
            font-size: 13.5px;
            color: var(--text-secondary);
            line-height: 1.6;
            margin: 0;
            font-weight: 600;
        }

        .extra-legacy-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
        }

        .legacy-box {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.12), rgba(0, 217, 255, 0.12)), var(--card-surface);
            border: 2px solid var(--neon-cyan);
            border-radius: 18px;
            padding: 35px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 0 30px rgba(0, 217, 255, 0.35);
        }

        .legacy-box h2 {
            font-size: 22px;
            font-weight: 900;
            color: var(--neon-gold);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
        }

        .legacy-box p {
            font-size: 14px;
            color: var(--text-secondary);
            max-width: 800px;
            margin: 0 auto 25px auto;
            line-height: 1.6;
        }

        .legacy-stats-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }
        @media(max-width: 768px) { .legacy-stats-grid { grid-template-columns: 1fr; } }

        .legacy-stat-item {
            background: rgba(3, 7, 18, 0.5);
            border: 1px solid var(--border-glass);
            border-radius: 12px;
            padding: 20px;
        }

        .legacy-stat-num {
            font-size: 24px;
            font-weight: 900;
            color: var(--neon-cyan);
            margin-bottom: 5px;
        }

        .legacy-stat-label {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-secondary);
        }

        /* Elite Duo Section */
        .elite-duo-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
        }
        .elite-duo-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 25px;
        }
        @media(max-width: 992px) { .elite-duo-grid { grid-template-columns: 1fr; } }
        
        .elite-duo-card {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.1), rgba(0, 217, 255, 0.1)), var(--card-surface);
            border: 1.5px solid var(--neon-purple);
            border-radius: 18px;
            padding: 35px 30px;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(181, 55, 242, 0.2);
            display: flex;
            gap: 20px;
            align-items: center;
            transition: all 0.3s ease;
        }
        .elite-duo-card:hover {
            border-color: var(--neon-cyan);
            transform: translateY(-4px);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.3);
        }
        .elite-duo-icon {
            min-width: 65px;
            height: 65px;
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-cyan));
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #030712;
            font-size: 26px;
            font-weight: 900;
            box-shadow: 0 0 20px rgba(181, 55, 242, 0.5);
            flex-shrink: 0;
        }
        .elite-duo-content h3 {
            font-size: 18px;
            font-weight: 900;
            color: var(--text-primary);
            text-transform: uppercase;
            letter-spacing: 0.8px;
            margin-bottom: 8px;
        }
        .elite-duo-content p {
            font-size: 13.5px;
            color: var(--text-secondary);
            line-height: 1.6;
            margin: 0;
            font-weight: 600;
        }

        /* 🌟 ROTATING FEATURES SECTION */
        .rotating-features-section {
            max-width: 1400px;
            margin: 0 auto 40px auto;
        }
        .rotating-features-box {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.08), rgba(0, 217, 255, 0.08)), var(--card-surface);
            border: none;
            border-radius: 18px;
            padding: 40px 30px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .rotating-features-box h2 {
            font-size: 22px;
            font-weight: 900;
            color: var(--neon-purple);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 12px;
        }
        .rotating-features-box p {
            font-size: 14px;
            color: var(--text-secondary);
            max-width: 800px;
            margin: 0 auto 35px auto;
            line-height: 1.6;
        }
        .rotating-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 25px;
        }
        @media(max-width: 992px) { .rotating-grid { grid-template-columns: repeat(2, 1fr); } }
        @media(max-width: 576px) { .rotating-grid { grid-template-columns: 1fr; } }
        
        .rotating-card {
            background: rgba(3, 7, 18, 0.6);
            border: 1.5px solid transparent;
            border-radius: 16px;
            padding: 25px 20px;
            display: flex;
            flex-direction: column;
            align-items: center;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(0,0,0,0.2);
        }
        .rotating-card:hover {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 25px rgba(0, 217, 255, 0.35);
            transform: translateY(-5px);
            background: rgba(0, 217, 255, 0.05);
        }
        .circle-img-box {
            width: 85px;
            height: 85px;
            border-radius: 50%;
            overflow: hidden;
            border: 2px solid var(--neon-cyan);
            box-shadow: 0 0 15px rgba(0, 217, 255, 0.4);
            margin-bottom: 18px;
            animation: spinCircleImg 8s linear infinite;
        }
        .circle-img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        @keyframes spinCircleImg {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        .rotating-card h4 {
            font-size: 15px;
            font-weight: 800;
            color: var(--text-primary);
            text-transform: uppercase;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }
        .rotating-card span {
            font-size: 12px;
            color: var(--text-secondary);
            line-height: 1.5;
            font-weight: 600;
        }

        .contact-section {
            max-width: 1400px;
            margin: 0 auto 50px auto;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.08), rgba(181, 55, 242, 0.08));
            border: 1.5px solid var(--border-glass);
            border-radius: 16px;
            padding: 40px;
            backdrop-filter: blur(15px);
        }

        .contact-title {
            font-size: 18px;
            font-weight: 800;
            color: var(--text-primary);
            margin: 0 0 30px 0;
            text-transform: uppercase;
            letter-spacing: 1.2px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .contact-title::before {
            content: '';
            width: 4px;
            height: 24px;
            background: linear-gradient(180deg, var(--neon-cyan), var(--neon-emerald));
            border-radius: 2px;
        }

        .contact-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 24px;
        }

        .contact-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 12px;
            padding: 24px;
            text-align: center;
            transition: all 0.3s ease;
        }

        .contact-card:hover {
            transform: translateY(-5px);
            border-color: var(--neon-cyan);
            box-shadow: 0 12px 30px rgba(0, 217, 255, 0.2);
        }

        .contact-icon {
            font-size: 32px;
            margin-bottom: 15px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .contact-label {
            font-size: 12px;
            color: var(--text-secondary);
            text-transform: uppercase;
            font-weight: 700;
            letter-spacing: 0.6px;
            margin-bottom: 8px;
        }

        .contact-info {
            font-size: 14px;
            font-weight: 700;
            color: var(--text-primary);
            word-break: break-all;
        }

        .help-box {
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            margin: 50px auto;
            max-width: 900px;
            padding: 40px 30px;
            border-radius: 16px;
            text-align: center;
            box-shadow: 0 20px 40px rgba(0, 217, 255, 0.3);
        }

        .help-box h3 {
            font-size: 24px;
            font-weight: 900;
            margin: 0 0 12px 0;
            color: #0a0e27;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .help-box p {
            color: rgba(10, 14, 39, 0.9);
            margin: 0 0 20px 0;
            font-size: 15px;
            line-height: 1.6;
        }

        .help-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
            flex-wrap: wrap;
        }

        .help-btn {
            background: rgba(10, 14, 39, 0.2);
            color: #0a0e27;
            border: 2px solid #0a0e27;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 800;
            cursor: pointer;
            font-size: 12px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }

        .help-btn:hover {
            background: #0a0e27;
            color: var(--neon-cyan);
            box-shadow: 0 0 20px rgba(10, 14, 39, 0.5);
        }

        .new-sections-wrapper {
            max-width: 1400px;
            margin: 40px auto;
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 30px;
        }
        @media(max-width: 992px) { .new-sections-wrapper { grid-template-columns: 1fr; } }

        .custom-info-card {
            background: var(--card-surface);
            border: 1.5px solid var(--border-glass);
            border-radius: 18px;
            padding: 30px;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0,0,0,0.3);
            transition: 0.3s;
        }
        .custom-info-card:hover {
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0,217,255,0.2);
        }
        .custom-info-card h3 {
            font-size: 18px;
            font-weight: 900;
            color: var(--neon-cyan);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .rules-list {
            list-style: none;
            padding: 0;
            margin: 0;
            display: flex;
            flex-direction: column;
            gap: 14px;
        }
        .rules-list li {
            display: flex;
            align-items: flex-start;
            gap: 12px;
            font-size: 13.5px;
            color: var(--text-secondary);
            font-weight: 600;
            line-height: 1.5;
        }
        .rules-list li i {
            color: var(--neon-emerald);
            font-size: 16px;
            margin-top: 2px;
        }

        .event-banner-box {
            background: linear-gradient(135deg, rgba(181, 55, 242, 0.15), rgba(0, 217, 255, 0.15)), var(--card-surface);
            border: 1.5px solid var(--neon-purple);
            border-radius: 18px;
            padding: 30px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(181,55,242,0.2);
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        .event-banner-box h3 {
            font-size: 18px;
            font-weight: 900;
            color: var(--neon-gold);
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 10px;
        }
        .event-banner-box p {
            font-size: 13.5px;
            color: var(--text-secondary);
            margin-bottom: 20px;
            line-height: 1.6;
        }
        .countdown-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 12px;
            margin-bottom: 20px;
        }
        .countdown-box {
            background: rgba(3, 7, 18, 0.6);
            border: 1px solid var(--border-glass);
            border-radius: 10px;
            padding: 12px;
        }
        .countdown-num {
            font-size: 20px;
            font-weight: 900;
            color: var(--neon-cyan);
        }
        .countdown-label {
            font-size: 10px;
            font-weight: 700;
            text-transform: uppercase;
            color: var(--text-secondary);
        }
        .btn-register-pulse {
            background: linear-gradient(135deg, var(--neon-purple), var(--neon-cyan));
            color: #fff;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 800;
            font-size: 12.5px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            cursor: pointer;
            box-shadow: 0 0 20px rgba(181, 55, 242, 0.5);
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-register-pulse:hover {
            transform: translateY(-2px);
            box-shadow: 0 0 30px rgba(0, 217, 255, 0.8);
            color: #fff;
        }

        .extra-banner-full {
            max-width: 1400px;
            margin: 40px auto;
            background: linear-gradient(135deg, rgba(0, 255, 136, 0.1), rgba(0, 217, 255, 0.1)), var(--card-surface);
            border: 1.5px solid var(--neon-emerald);
            border-radius: 18px;
            padding: 35px 40px;
            text-align: center;
            backdrop-filter: blur(15px);
            box-shadow: 0 15px 35px rgba(0, 255, 136, 0.15);
        }
        .extra-banner-full h3 {
            font-size: 22px;
            font-weight: 900;
            color: var(--neon-emerald);
            text-transform: uppercase;
            letter-spacing: 1.2px;
            margin-bottom: 12px;
        }
        .extra-banner-full p {
            font-size: 14px;
            color: var(--text-secondary);
            max-width: 850px;
            margin: 0 auto;
            line-height: 1.7;
            font-weight: 600;
        }

        /* Gallery Section */
        .faq-showcase-section {
            max-width: 1400px;
            margin: 40px auto;
        }

        .faq-showcase-title {
            text-align: center;
            font-size: 24px;
            font-weight: 900;
            margin-bottom: 30px;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .faq-showcase-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 25px;
            perspective: 1000px;
        }
        @media(max-width: 768px) { .faq-showcase-grid { grid-template-columns: 1fr; } }

        .faq-showcase-card {
            background: rgba(13, 18, 35, 0.95);
            border-radius: 16px;
            overflow: hidden;
            border: 1.5px solid var(--border-glass);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            display: flex;
            flex-direction: column;
            height: 100%;
            transform-style: preserve-3d;
            animation: spinFiveSecs 5s linear infinite;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        @keyframes spinFiveSecs {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(360deg); }
        }

        .faq-showcase-card:hover {
            animation: spinOnce 0.8s ease forwards;
            border-color: var(--neon-cyan);
            box-shadow: 0 15px 40px rgba(0, 217, 255, 0.4);
        }

        @keyframes spinOnce {
            0% { transform: rotateY(0deg); }
            100% { transform: rotateY(360deg); }
        }

        .card-header {
            padding: 18px 16px;
            text-align: center;
            background: rgba(3, 7, 18, 0.95);
            border-bottom: 1px solid var(--border-glass);
        }
        .card-header h4 {
            margin: 0 0 6px 0;
            font-size: 15px;
            font-weight: 800;
            background: linear-gradient(135deg, var(--neon-cyan), var(--neon-gold));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }
        .card-header p { margin: 0; font-size: 12px; color: var(--text-secondary); line-height: 1.4; font-weight: 600; }

        .faq-showcase-img-box {
            position: relative;
            width: 100%;
            height: 220px;
            background: #020617;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .faq-showcase-img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            object-position: center;
            display: block;
        }

        /* Modals */
        .modal-overlay {
            display: none;
            position: fixed;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(10, 14, 39, 0.85);
            backdrop-filter: blur(5px);
            z-index: 2000;
            align-items: center;
            justify-content: center;
        }
        .modal-overlay.active { display: flex; }
        .modal-container {
            background: var(--card-surface);
            border: 1.5px solid var(--neon-cyan);
            border-radius: 16px;
            padding: 25px 30px;
            max-width: 420px;
            width: 90%;
            box-shadow: 0 20px 50px rgba(0, 217, 255, 0.3);
            backdrop-filter: blur(15px);
        }
        .modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            border-bottom: 1px solid var(--border-glass);
            padding-bottom: 10px;
        }
        .modal-title { font-size: 16px; font-weight: 800; color: var(--text-primary); margin: 0; text-transform: uppercase; }
        .modal-close { background: none; border: none; color: var(--neon-cyan); font-size: 20px; cursor: pointer; }
        .form-group { margin-bottom: 12px; }
        .form-label { display: block; font-size: 11px; font-weight: 700; color: var(--text-secondary); margin-bottom: 4px; text-transform: uppercase; }
        .form-input, .form-textarea {
            width: 100%; padding: 9px 12px;
            background: rgba(0, 217, 255, 0.08);
            border: 1.5px solid var(--border-glass);
            border-radius: 8px; color: var(--text-primary); font-size: 12px; outline: none;
        }
        .form-textarea { min-height: 80px; }
        .submit-btn {
            width: 100%; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald));
            color: #0a0e27; border: none; padding: 10px; border-radius: 8px; font-weight: 800; font-size: 12px; cursor: pointer; text-transform: uppercase;
        }

        .chat-box-body {
            height: 240px; background: rgba(3, 7, 18, 0.4); border: 1px solid var(--border-glass);
            border-radius: 8px; padding: 12px; overflow-y: auto; display: flex; flex-direction: column; gap: 10px; margin-bottom: 12px;
        }
        .chat-msg { max-width: 80%; padding: 8px 12px; border-radius: 10px; font-size: 12px; line-height: 1.4; }
        .chat-msg.bot { background: rgba(0, 217, 255, 0.15); color: var(--text-primary); align-self: flex-start; }
        .chat-msg.user { background: var(--neon-cyan); color: #0a0e27; font-weight: 700; align-self: flex-end; }
        .chat-input-area { display: flex; gap: 8px; }
        .chat-input-area input { flex: 1; padding: 9px 12px; background: rgba(0, 217, 255, 0.08); border: 1.5px solid var(--border-glass); border-radius: 8px; color: var(--text-primary); font-size: 12px; outline: none; }
        .chat-input-area button { background: var(--neon-cyan); color: #0a0e27; border: none; padding: 0 15px; border-radius: 8px; font-weight: 800; cursor: pointer; }

        /* GRAND CYBER FOOTER STYLING (Tournament Match Style) */
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

    <!-- NAVBAR FILE INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">
        <div class="header-bar">
            <div class="header-left">
                <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            </div>
            <div>
                <h2 style="font-size: 20px; font-weight: 900; margin: 0; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-transform: uppercase; letter-spacing: 1.5px;">FAQ & Support Center</h2>
            </div>
            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
            </div>
        </div>

        <!-- HERO SECTION WITH AUTOMATIC GLOW ANIMATION & INCREASED PADDING -->
        <div class="faq-hero">
            <div class="hero-wave-light"></div>
            <div class="dynamic-hero-content">
                <div class="hero-badge"><i class="fa-solid fa-circle-question"></i> Support Center</div>
                <h1>Frequently Asked Questions</h1>
                <p>Find answers to common questions about ProMatch Arena Cricket Tournament Management System</p>
            </div>
        </div>

        <!-- TICKER LINE -->
        <div class="ticker-container">
            <div class="ticker-wrapper">
                <span class="ticker-item">⚡ Welcome to ProMatch Arena Support Center ⚡</span>
                <span class="ticker-item">📊 Live NRR & Points Table updates enabled 📊</span>
                <span class="ticker-item">📝 Register your teams before the tournament deadline 📝</span>
                <span class="ticker-item">💬 24/7 Assistance available via Live Chat 💬</span>
                <span class="ticker-item">🏆 Play Hard, Win Big! 🏆</span>
            </div>
        </div>

        <!-- CATEGORY TABS -->
        <div class="category-tabs">
            <button class="tab-btn active" onclick="filterCategory('all')">All Categories</button>
            <button class="tab-btn" onclick="filterCategory('registration')">Registration</button>
            <button class="tab-btn" onclick="filterCategory('points')">Points & NRR</button>
            <button class="tab-btn" onclick="filterCategory('account')">Account & Squad</button>
            <button class="tab-btn" onclick="filterCategory('technical')">Technical Issues</button>
            <button class="tab-btn" onclick="filterCategory('tournament')">Tournament</button>
        </div>

        <!-- FAQ ACCORDION -->
        <div class="faq-container">
            <!-- ALL CATEGORIES -->
            <div id="all" class="faq-category active">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How do I register my team?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Navigate to the 'Register Team' section, fill in your team name, select squad members, and submit the form. Your team will be verified and added to the system within 24 hours. Make sure all team members have valid accounts in the system before registration.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How is NRR calculated?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Net Run Rate (NRR) is calculated as: (Total Runs Scored - Total Runs Conceded) / Total Overs Played. The system automatically computes this based on match data. Positive NRR indicates better performance and is used as a tiebreaker in the points table.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How do I update my squad members?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Go to 'My Squad' in your team dashboard. You can add or remove players before the tournament starts. After tournament begins, squad changes require approval from the tournament administrator. Contact support for emergency squad modifications.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">What should I do if I forget my password?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Click 'Forgot Password' on the login page. Enter your email address and follow the instructions sent to your inbox. If you don't receive the reset link, check your spam folder or contact our support team for assistance.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How can I view live match updates?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Navigate to the 'Live Matches' section to see all ongoing games. The page updates in real-time showing runs, wickets, and other match statistics. You can also get notifications if you enable them in your profile settings.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Who do I contact for support?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">You can reach our support team via phone at +91 7806035087 or email at jitendrasingh07022004@gmail.com. Our team is available Monday to Friday, 9 AM to 6 PM IST. For urgent issues, use the 'Contact Us' form on this page.</div>
                </div>
            </div>

            <!-- REGISTRATION CATEGORY -->
            <div id="registration" class="faq-category">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">What documents do I need to register?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">You need valid email ID and phone number. For team registration, provide team name and member details. Student teams may require college/school verification. All documents should be uploaded in PDF or JPG format (max 5MB).</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Can I register multiple teams?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Yes, you can manage multiple teams if you're an authorized representative. Each team requires separate registration with different squad members. Contact admin for bulk team registration.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">What is the registration fee?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Registration fees vary by tournament. Check the specific tournament details for fee information. Payment can be made online through our secure payment gateway. Registration is completed only after fee verification.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Can I register after the deadline?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Late registrations may be accepted at 1.5x the normal fee, subject to availability. Contact the tournament administrator immediately. No registrations are accepted after the tournament has started.</div>
                </div>
            </div>

            <!-- POINTS & NRR CATEGORY -->
            <div id="points" class="faq-category">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How many points are awarded for winning?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Winning team gets 2 points, losing team gets 0 points. In case of a tie, both teams get 1 point each. Bonus points may be awarded for super-overs or other tournament-specific conditions.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Why is my NRR negative?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Negative NRR means your team has conceded more runs than it has scored (on average per over). This is common early in tournaments. It improves by winning matches and scoring more runs than opponents. Check detailed match stats for analysis.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How is the standings table ranked?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Teams are ranked by: 1) Total Points, 2) NRR (if points are equal), 3) Wins (if NRR is equal). Detailed sorting criteria are mentioned in tournament rules. You can view the complete Points Table any time in the dashboard.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">When is the points table updated?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">The points table is updated in real-time after each match concludes. Updates usually reflect within 5-10 minutes of match completion. If there's a delay, the page may be refreshing—try clearing your browser cache.</div>
                </div>
            </div>

            <!-- ACCOUNT & SQUAD CATEGORY -->
            <div id="account" class="faq-category">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How do I change my account password?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Go to Settings > Change Password. Enter your current password, then enter and confirm your new password. Passwords must be at least 8 characters with uppercase, lowercase, and numbers. Change your password regularly for security.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Can I change my team captain?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Yes, the current captain can designate a new captain from the squad. The change takes effect immediately. Before tournament starts, any team member can be made captain. After tournament starts, captain changes need admin approval.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How do I add players to my squad?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Players must have individual accounts in the system first. Go to Squad Management > Add Player and search by username. Both captain and the player must confirm the addition. Maximum squad size varies by tournament.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">What if I want to delete my account?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Account deletion is permanent and cannot be undone. You can request deletion from Settings > Delete Account. Ensure all dues are settled and you're not in any active tournament. Deletion takes 7-10 days to process.</div>
                </div>
            </div>

            <!-- TECHNICAL ISSUES CATEGORY -->
            <div id="technical" class="faq-category">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">The page is not loading properly. What should I do?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Try these steps: 1) Clear browser cache and cookies, 2) Disable browser extensions, 3) Try a different browser, 4) Check your internet connection, 5) Restart your device. If issue persists, contact support with browser details.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">I'm getting an error message. What should I do?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Note the exact error message and contact support. Include screenshots if possible. Provide: browser name/version, device type, when the error occurs, and what you were trying to do. This helps us resolve issues faster.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Why am I being logged out frequently?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Frequent logouts happen due to: 1) Inactive session timeout (auto logout after 30 mins), 2) Using same account on multiple devices, 3) Browser cache issues, 4) Security settings. Check Settings > Sessions to manage active sessions.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Is the system mobile-friendly?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Yes, ProMatch Arena is fully responsive and works on all devices. For best experience on mobile: 1) Use latest browser version, 2) Enable JavaScript, 3) Allow notifications (optional), 4) Check mobile data speed. Download the mobile app for better performance.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How do I report a bug?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Use the 'Report Issue' option in Settings or email support@promatch.com with: bug description, reproduction steps, screenshots/videos, browser info, and device details. Include error messages if any. Our tech team will investigate and fix priority bugs immediately.</div>
                </div>
            </div>

            <!-- TOURNAMENT CATEGORY -->
            <div id="tournament" class="faq-category">
                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">How do I create a tournament?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Admin/Tournament Organizer: Go to Tournaments > Create New. Fill in tournament name, format, dates, rules, and fee. Set registration deadline and confirm. Once created, send registration link to teams. Set match schedule before tournament starts.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">What tournament formats are supported?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Welcome to ProMatch Arena support! We support Round-Robin, League + Playoffs, and Knockout formats.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">Can I modify tournament dates?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Tournament dates can be changed only before registration closes. After registration deadline, date changes require consent from at least 75% registered teams. Schedule changes after tournament starts require admin intervention and may be restricted.</div>
                </div>

                <div class="faq-item" onclick="toggleFaq(this)">
                    <div class="faq-question">What happens if a match is canceled?<span class="faq-icon">+</span></div>
                    <div class="faq-answer">Canceled matches are marked as 'No Result'. No points awarded to either team. If rain-affected, rules specify: over limit (5 overs = reduced match), reduced points, or full rescheduling. Organizer decides cancellation/rescheduling.</div>
                </div>
            </div>
        </div>

        <!-- Cyber 3-Carts Section -->
        <div class="cyber-features-section">
            <div class="cyber-features-grid">
                <div class="cyber-feature-card">
                    <div class="cyber-card-icon"><i class="fa-solid fa-bolt"></i></div>
                    <h3>Lightning Fast Sync</h3>
                    <p>Experience ultra-low latency real-time score updates and instant database replication across global servers.</p>
                </div>
                <div class="cyber-feature-card">
                    <div class="cyber-card-icon"><i class="fa-solid fa-calculator"></i></div>
                    <h3>Zero-Error NRR Engine</h3>
                    <p>Automated algorithms compute exact Net Run Rates instantly after every match ball without manual delays.</p>
                </div>
                <div class="cyber-feature-card">
                    <div class="cyber-card-icon"><i class="fa-solid fa-shield-halved"></i></div>
                    <h3>Secure Enterprise Core</h3>
                    <p>Robust role-based access control, encrypted squad verification, and automated tournament bracket management.</p>
                </div>
            </div>
        </div>

        <!-- Extra Legacy Section -->
        <div class="extra-legacy-section">
            <div class="legacy-box">
                <h2>⚡ Tournament Legacy & Analytics</h2>
                <p>ProMatch Arena delivers state-of-the-art sports management with ultra-low latency scoreboards, zero-error NRR algorithms, and seamless team coordination built for professional leagues.</p>
                <div class="legacy-stats-grid">
                    <div class="legacy-stat-item">
                        <div class="legacy-stat-num">100%</div>
                        <div class="legacy-stat-label">Real-Time Sync</div>
                    </div>
                    <div class="legacy-stat-item">
                        <div class="legacy-stat-num">24/7</div>
                        <div class="legacy-stat-label">Support Availability</div>
                    </div>
                    <div class="legacy-stat-item">
                        <div class="legacy-stat-num">500+</div>
                        <div class="legacy-stat-label">Matches Tracked</div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Elite Duo Section -->
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

        <!-- Rotating Circular Images Section -->
        <div class="rotating-features-section">
            <div class="rotating-features-box">
                <h2>⚡ Core Architecture Modules</h2>
                <p>Engineered for high-throughput sports ecosystems with real-time websocket streams and reliable redundancy.</p>
                <div class="rotating-grid">
                    <div class="rotating-card">
                        <div class="circle-img-box"><img src="https://template.canva.com/EAFzNP09R9c/1/0/1600w-HPTinIp3XS8.jpg" alt="Live Analytics"></div>
                        <h4>Live Analytics</h4>
                        <span>Real-time match data synced instantly across network nodes.</span>
                    </div>
                    <div class="rotating-card">
                        <div class="circle-img-box"><img src="https://instamart-media-assets.swiggy.com/swiggy/image/upload/fl_lossy,f_auto,q_auto,h_600/NI_CATALOG/IMAGES/CIW/2026/6/29/7a563fae-fcb1-4392-b1bc-376cd0a0ac80_68978.jpg" alt="Instant NRR"></div>
                        <h4>Instant NRR</h4>
                        <span>Zero-error calculation engine for exact net run rates.</span>
                    </div>
                    <div class="rotating-card">
                        <div class="circle-img-box"><img src="https://nwscdn.com/media/.renditions/wysiwyg/3kf/FORZA-Wooden-Garden-Cricket-Set_04_USP_.jpg" alt="Cloud Sync"></div>
                        <h4>Cloud Sync</h4>
                        <span>Enterprise server backing with high availability architecture.</span>
                    </div>
                    <div class="rotating-card">
                        <div class="circle-img-box"><img src="https://resources.ecb.co.uk/photo-resources/2025/05/07/ca08885e-829b-469b-a418-464114d3097b/All-Stars-banner1766x608.png?width=700&height=522" alt="Live Stream"></div>
                        <h4>Live Stream</h4>
                        <span>Seamless broadcast feeds with ultra-low streaming latency.</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Contact Section -->
        <div class="contact-section">
            <h2 class="contact-title">📞 Get in Touch</h2>
            <div class="contact-grid">
                <div class="contact-card">
                    <div class="contact-icon"><i class="fas fa-phone"></i></div>
                    <div class="contact-label">Phone Support</div>
                    <div class="contact-info">+91 7806035087</div>
                    <div style="font-size: 11px; color: var(--text-secondary); margin-top: 8px;">Mon-Fri, 9AM-6PM IST</div>
                </div>
                <div class="contact-card">
                    <div class="contact-icon"><i class="fas fa-envelope"></i></div>
                    <div class="contact-label">Email Support</div>
                    <div class="contact-info">jitendrasingh07022004@gmail.com</div>
                    <div style="font-size: 11px; color: var(--text-secondary); margin-top: 8px;">Response within 24 hours</div>
                </div>
                <div class="contact-card">
                    <div class="contact-icon"><i class="fas fa-map-marker-alt"></i></div>
                    <div class="contact-label">Office Location</div>
                    <div class="contact-info">Bangalore, Karnataka, India</div>
                    <div style="font-size: 11px; color: var(--text-secondary); margin-top: 8px;">Tech Support HQ</div>
                </div>
            </div>
        </div>

        <!-- Help Box -->
        <div class="help-box">
            <h3>Still have questions?</h3>
            <p>Can't find what you're looking for? Our dedicated support team is ready to help you 24/7</p>
            <div class="help-buttons">
                <button class="help-btn" onclick="openContactForm('message')">📧 Send Message</button>
                <button class="help-btn" onclick="openContactForm('chat')">💬 Live Chat</button>
                <button class="help-btn" onclick="window.location.href='/home'">🏠 Back to Home</button>
            </div>
        </div>

        <div class="new-sections-wrapper">
            <div class="custom-info-card">
                <h3><i class="fa-solid fa-shield-halved"></i> Tournament Quick Rules</h3>
                <ul class="rules-list">
                    <li><i class="fa-solid fa-circle-check"></i> All team rosters must be finalized 24 hours prior to the tournament kick-off.</li>
                    <li><i class="fa-solid fa-circle-check"></i> Fair play is strictly enforced; any unsportsmanlike behavior leads to instant disqualification.</li>
                    <li><i class="fa-solid fa-circle-check"></i> Points table rankings are updated automatically based on match outcomes and NRR.</li>
                    <li><i class="fa-solid fa-circle-check"></i> Captains must report to the referee toss desk 15 minutes before match time.</li>
                </ul>
            </div>

            <div class="event-banner-box">
                <h3>⚡ Next Grand Championship</h3>
                <p>Register your squad today to secure a spot in the upcoming ProMatch Super Cup finals!</p>
                <div class="countdown-grid">
                    <div class="countdown-box"><div class="countdown-num">03</div><div class="countdown-label">Days</div></div>
                    <div class="countdown-box"><div class="countdown-num">14</div><div class="countdown-label">Hours</div></div>
                    <div class="countdown-box"><div class="countdown-num">45</div><div class="countdown-label">Mins</div></div>
                </div>
                <a href="/register-team" class="btn-register-pulse">Register Team Now</a>
            </div>
        </div>

        <div class="extra-banner-full">
            <h3>🌟 Ultimate Sporting Excellence</h3>
            <p>Explore our breathtaking tournament moments captured in high definition. From high-voltage boundary clashes to the ultimate trophy lift, experience cricket like never before!</p>
        </div>

        <!-- Gallery Section -->
        <div class="faq-showcase-section">
            <h3 class="faq-showcase-title">🏆 Pro Tournament Visuals</h3>
            <div class="faq-showcase-grid">
                <div class="faq-showcase-card">
                    <div class="card-header"><h4>🏟️ Arena Stadium</h4><p>World-class venue illumination</p></div>
                    <div class="faq-showcase-img-box"><img src="https://img.olympics.com/images/image/private/t_s_pog_staticContent_hero_lg/f_auto/primary/f8bkajhisbszukilfg2a" alt="Arena Stadium"></div>
                </div>
                <div class="faq-showcase-card">
                    <div class="card-header"><h4>⚡ Match Action</h4><p>High-voltage cricketing battles</p></div>
                    <div class="faq-showcase-img-box"><img src="https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?q=80&w=1000&auto=format&fit=crop" alt="Match Action"></div>
                </div>
                <div class="faq-showcase-card">
                    <div class="card-header"><h4>🏆 Victory Moment</h4><p>Champions lifting the glorious trophy</p>
                    </div>
                    <div class="faq-showcase-img-box"><img src="https://video-images-cdn.staylive.tv/9efvh/thumbnail.jpg?width=1600" alt="Victory Moment"></div>
                </div>
            </div>
        </div>

        <!-- Modals -->
        <div class="modal-overlay" id="contactModal">
            <div class="modal-container">
                <div class="modal-header"><h2 class="modal-title">Send Message</h2><button class="modal-close" onclick="closeContactForm()">×</button></div>
                <form onsubmit="handleFormSubmit(event)">
                    <div class="form-group"><label class="form-label">Your Name</label><input type="text" class="form-input" name="name" required placeholder="Enter your full name"></div>
                    <div class="form-group"><label class="form-label">Email Address</label><input type="email" class="form-input" name="email" required placeholder="your.email@example.com"></div>
                    <div class="form-group"><label class="form-label">Subject</label><input type="text" class="form-input" name="subject" required placeholder="What's this about?"></div>
                    <div class="form-group"><label class="form-label">Message</label><textarea class="form-textarea" name="message" required placeholder="Tell us how we can help..."></textarea></div>
                    <button type="submit" class="submit-btn">Send Message</button>
                </form>
            </div>
        </div>

        <div class="modal-overlay" id="chatModal">
            <div class="modal-container">
                <div class="modal-header"><h2 class="modal-title"><i class="fa-solid fa-robot" style="color: var(--neon-cyan);"></i> ProMatch Assistant</h2><button class="modal-close" onclick="closeChatBot()">×</button></div>
                <div class="chat-box-body" id="chatBody">
                    <div class="chat-msg bot">Hello dost! Main ProMatch Arena ka AI Assistant hoon. Main ekdum mast hoon, aap batao kaise ho aur kya haal chal hain? Match ya tournament ke baare mein kuch bhi puch sakte ho!</div>
                </div>
                <div class="chat-input-area">
                    <input type="text" id="chatInput" placeholder="Pucho match ya haal-chaal..." onkeypress="handleChatKey(event)">
                    <button onclick="sendChatMessage()"><i class="fa-solid fa-paper-plane"></i></button>
                </div>
            </div>
        </div>

        <!-- 🌟 FOOTER INCLUDE -->
        <jsp:include page="footer.jsp" />

    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function toggleFaq(element) {
            element.classList.toggle('active');
        }

        function filterCategory(category) {
            const categories = document.querySelectorAll('.faq-category');
            categories.forEach(cat => cat.classList.remove('active'));

            if (category === 'all') {
                document.getElementById('all').classList.add('active');
            } else {
                document.getElementById(category).classList.add('active');
            }

            const tabs = document.querySelectorAll('.tab-btn');
            tabs.forEach(tab => tab.classList.remove('active'));
            event.target.classList.add('active');
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

        function openContactForm(type) {
            if (type === 'chat') {
                document.getElementById('chatModal').classList.add('active');
            } else {
                document.getElementById('contactModal').classList.add('active');
            }
        }

        function closeContactForm() {
            document.getElementById('contactModal').classList.remove('active');
        }

        function closeChatBot() {
            document.getElementById('chatModal').classList.remove('active');
        }

        function handleFormSubmit(event) {
            event.preventDefault();
            alert('✅ Thank you! Your message has been sent. Our support team will contact you soon.');
            closeContactForm();
            event.target.reset();
        }

        function sendChatMessage() {
            const input = document.getElementById('chatInput');
            const text = input.value.trim();
            if(!text) return;

            const chatBody = document.getElementById('chatBody');
            const userMsg = document.createElement('div');
            userMsg.className = 'chat-msg user';
            userMsg.textContent = text;
            chatBody.appendChild(userMsg);

            input.value = '';
            chatBody.scrollTop = chatBody.scrollHeight;

            setTimeout(() => {
                const botMsg = document.createElement('div');
                botMsg.className = 'chat-msg bot';
                const lower = text.toLowerCase();
                if(lower.includes('kaise ho') || lower.includes('haal') || lower.includes('kya hal') || lower.includes('btao')) {
                    botMsg.textContent = 'Arre bhai, main ekdum fit-fat aur shandar hoon! Aap batao, tournament aur matches ka maza le rahe ho ya nahi?';
                } else if(lower.includes('match') || lower.includes('live') || lower.includes('aaj ka')) {
                    botMsg.textContent = '🏏 Aaj ke high-voltage matches mein Thunder Strikers aur Phoenix Warriors ka epic clash chal raha hai!';
                } else if(lower.includes('point') || lower.includes('nrr') || lower.includes('table')) {
                    botMsg.textContent = '📊 Points table live update hoti hai! Top par teams ka NRR +8.45 tak chal raha hai.';
                } else {
                    botMsg.textContent = 'Sahi hai bhai! Main samajh gaya. Agar koi aur technical ya match se juda sawal ho toh pucho!';
                }
                chatBody.appendChild(botMsg);
                chatBody.scrollTop = chatBody.scrollHeight;
            }, 600);
        }

        function handleChatKey(e) {
            if(e.key === 'Enter') {
                sendChatMessage();
            }
        }

        window.addEventListener('click', function(e) {
            if (e.target.classList.contains('modal-overlay')) {
                e.target.classList.remove('active');
            }
        });

        const galleryCards = document.querySelectorAll('.faq-showcase-card');
        galleryCards.forEach(card => {
            card.addEventListener('mouseenter', () => { card.style.animation = 'spinOnce 0.8s ease forwards'; });
            card.addEventListener('mouseleave', () => {
                setTimeout(() => { card.style.animation = 'spinFiveSecs 5s linear infinite'; }, 800);
            });
        });
    </script>
</body>
</html>