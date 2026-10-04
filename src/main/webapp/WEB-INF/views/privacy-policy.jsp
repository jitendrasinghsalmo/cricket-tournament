<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="privacy" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Comprehensive Privacy Policy</title>
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

        .main-content-wrap { max-width: 1400px; margin: 40px auto; padding: 0 20px; }

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

        /* Privacy Policy Content Styles */
        .policy-container { 
            max-width: 1050px; 
            margin: 0 auto; 
            background: var(--card-surface); 
            border: 1.5px solid var(--border-glass); 
            border-radius: 24px; 
            padding: 50px; 
            box-shadow: 0 25px 60px rgba(0,0,0,0.5); 
            backdrop-filter: blur(20px); 
        }
        .policy-container h1 { color: var(--neon-cyan); font-weight: 900; margin-bottom: 8px; font-size: 32px; display: flex; align-items: center; gap: 14px; }
        .last-updated { font-size: 13.5px; color: var(--text-secondary); margin-bottom: 35px; display: block; border-bottom: 1px solid var(--border-glass); padding-bottom: 15px; }
        .policy-container h3 { color: var(--text-primary); font-size: 18px; font-weight: 800; margin-top: 35px; margin-bottom: 12px; border-left: 4px solid var(--neon-cyan); padding-left: 12px; }
        .policy-container p, .policy-container li { color: var(--text-secondary); font-size: 14.5px; line-height: 1.8; }
        .policy-container ul { padding-left: 22px; margin-bottom: 15px; }
        .contact-box { background: rgba(0, 217, 255, 0.08); border: 1.5px solid var(--neon-cyan); border-radius: 18px; padding: 25px; margin-top: 40px; box-shadow: inset 0 0 15px rgba(0, 217, 255, 0.1); }
        .contact-box h4 { font-size: 17px; font-weight: 800; color: var(--neon-cyan); margin-bottom: 12px; }
        .contact-box p { margin: 6px 0; color: var(--text-primary); font-weight: 600; font-size: 14.5px; }

        /* GRAND CYBER FOOTER STYLING (Restored Top Border Line & Removed Left Pipe Line) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan) !important; border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; }
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
        
        .footer-bottom-bar { 
            max-width: 1350px; 
            margin: 0 auto; 
            display: flex; 
            justify-content: space-between; 
            align-items: center; 
            flex-wrap: wrap; 
            gap: 15px; 
            color: var(--text-secondary); 
            font-size: 12px; 
            letter-spacing: 0.5px; 
        }
        .footer-bottom-bar p { 
            margin: 0; 
            font-size: 12px; 
        }
        @media(max-width: 768px) { 
            .footer-bottom-bar { flex-direction: column; text-align: center; } 
        }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { 
            color: var(--text-secondary); 
            text-decoration: none; 
            font-size: 12px; 
            transition: color 0.2s; 
        }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }

        /* ===================== EXTRA PRIVACY SECTIONS (added, nothing else touched) ===================== */
        .toc-box { background: rgba(0, 217, 255, 0.05); border: 1.5px solid var(--border-glass); border-radius: 16px; padding: 22px 28px; margin-bottom: 30px; }
        .toc-box h4 { font-size: 15px; font-weight: 800; color: var(--neon-cyan); text-transform: uppercase; letter-spacing: 0.8px; margin: 0 0 14px 0; }
        .toc-list { list-style: none; padding: 0; margin: 0; display: grid; grid-template-columns: repeat(2, 1fr); gap: 8px; }
        @media(max-width: 650px) { .toc-list { grid-template-columns: 1fr; } }
        .toc-list li a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; display: inline-flex; align-items: center; gap: 8px; transition: 0.2s; }
        .toc-list li a:hover { color: var(--neon-cyan); transform: translateX(3px); }
        .toc-list li a i { color: var(--neon-emerald); font-size: 11px; }

        /* =====================================================
           DARK + LIGHT MODE SYSTEM (same as Teams page)
           Text hamesha visible rahega
           ===================================================== */
        :root {
            --pm-nav-bg: rgba(10, 14, 39, 0.92);
            --pm-newsletter-bg: rgba(3, 7, 18, 0.7);
            --pm-footer-bg: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
            --pm-contact-bg: rgba(0, 217, 255, 0.08);
            --pm-toc-bg: rgba(0, 217, 255, 0.05);
            --pm-shadow: rgba(0, 0, 0, 0.5);
            --pm-nav-shadow: rgba(0, 0, 0, 0.5);
        }

        /* Light mode - jo bhi toggle method use ho (data-theme / class) sab cover hai */
        :root[data-theme="light"], :root[data-bs-theme="light"],
        :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
        body[data-theme="light"], body[data-bs-theme="light"],
        body.light, body.light-mode, body.light-theme, body.theme-light {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.96);
            --neon-cyan: #0891b2;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --neon-purple: #7c3aed;
            --neon-gold: #b45309;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: #cbd5e1;
            --pm-nav-bg: rgba(255, 255, 255, 0.96);
            --pm-newsletter-bg: #ffffff;
            --pm-footer-bg: linear-gradient(135deg, #ffffff, #f1f5f9);
            --pm-contact-bg: rgba(8, 145, 178, 0.08);
            --pm-toc-bg: rgba(8, 145, 178, 0.06);
            --pm-shadow: rgba(15, 23, 42, 0.12);
            --pm-nav-shadow: rgba(15, 23, 42, 0.12);
        }

        /* Hardcoded dark backgrounds ab variables se chalenge */
        nav { background: var(--pm-nav-bg); box-shadow: 0 15px 35px var(--pm-nav-shadow); }
        .policy-container { box-shadow: 0 25px 60px var(--pm-shadow); }
        .contact-box { background: var(--pm-contact-bg); }
        .toc-box { background: var(--pm-toc-bg); }
        .grand-footer-section { background: var(--pm-footer-bg); }
        .footer-newsletter input { background: var(--pm-newsletter-bg); }
        .footer-newsletter input::placeholder { color: var(--text-secondary); opacity: 0.8; }

        /* Light mode me glow soft + text/button clear */
        body.light-mode .footer-brand h3 span { text-shadow: none; }
        body.light-mode .nav-links a.active,
        body.light-mode .btn-back:hover,
        body.light-mode .footer-socials a:hover,
        body.light-mode .logo-icon,
        body.light-mode .footer-newsletter button { color: #ffffff; }
        :root[data-theme="light"] .footer-brand h3 span, :root.light .footer-brand h3 span, :root.light-mode .footer-brand h3 span { text-shadow: none; }
        :root[data-theme="light"] .nav-links a.active, :root.light .nav-links a.active, :root.light-mode .nav-links a.active,
        :root[data-theme="light"] .btn-back:hover, :root.light .btn-back:hover, :root.light-mode .btn-back:hover,
        :root[data-theme="light"] .footer-socials a:hover, :root.light .footer-socials a:hover, :root.light-mode .footer-socials a:hover,
        :root[data-theme="light"] .logo-icon, :root.light .logo-icon, :root.light-mode .logo-icon,
        :root[data-theme="light"] .footer-newsletter button, :root.light .footer-newsletter button, :root.light-mode .footer-newsletter button { color: #ffffff; }

        /* =====================================================
           FULL RESPONSIVE (mobile / tablet / desktop)
           ===================================================== */
        html, body { width: 100%; overflow-x: hidden; }
        img { max-width: 100%; height: auto; }
        .policy-container, .policy-container p, .policy-container li,
        .contact-box p, .toc-list li a { overflow-wrap: anywhere; }
        html { scroll-behavior: smooth; }
        .policy-container h3 { scroll-margin-top: 90px; }

        @media (max-width: 992px) {
            .policy-container { padding: 38px 30px; }
        }

        @media (max-width: 900px) {
            nav { padding: 12px 20px; flex-wrap: wrap; gap: 10px; }
            .nav-links { flex-wrap: wrap; justify-content: center; }
        }

        @media (max-width: 768px) {
            nav { padding: 10px 14px; }
            .nav-links a { padding: 7px 10px; font-size: 12px; }
            .main-content-wrap { padding: 0 12px; margin: 22px auto; }
            .policy-container { padding: 26px 18px; border-radius: 18px; }
            .policy-container h1 { font-size: 24px; gap: 10px; }
            .policy-container h3 { font-size: 16.5px; margin-top: 28px; }
            .policy-container p, .policy-container li { font-size: 14px; line-height: 1.7; }
            .policy-container ul { padding-left: 18px; }
            .toc-box { padding: 18px 16px; }
            .contact-box { padding: 18px 16px; }
            .contact-box h4 { font-size: 15.5px; }
            .grand-footer-section { padding: 36px 20px 24px 20px; width: calc(100% - 24px); margin-top: 40px; }
            .grand-footer-content { gap: 28px; }
            .footer-newsletter form { flex-direction: column; }
            .footer-bottom-links { flex-wrap: wrap; justify-content: center; }
        }

        @media (max-width: 480px) {
            .policy-container { padding: 22px 14px; }
            .policy-container h1 { font-size: 21px; flex-wrap: wrap; }
            .last-updated { font-size: 12.5px; }
            .logo-text { font-size: 16px; }
        }
    </style>
</head>
<body>

    <!-- NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">

        <div class="policy-container">
            <h1><i class="fa-solid fa-shield-halved"></i> Comprehensive Privacy Policy</h1>
            <span class="last-updated">Last updated & Effective Date: June 2026 | ProMatch Arena Governance & Data Compliance Framework</span>

            <!-- ===================== TABLE OF CONTENTS ===================== -->
            <div class="toc-box">
                <h4>📑 Quick Navigation</h4>
                <ul class="toc-list">
                    <li><a href="#sec1"><i class="fa-solid fa-caret-right"></i> Technological Stack & Data Framework</a></li>
                    <li><a href="#sec2"><i class="fa-solid fa-caret-right"></i> Categories of Information Collected</a></li>
                    <li><a href="#sec3"><i class="fa-solid fa-caret-right"></i> Purpose & Scope of Data Utilization</a></li>
                    <li><a href="#sec4"><i class="fa-solid fa-caret-right"></i> Data Security Protocols</a></li>
                    <li><a href="#sec5"><i class="fa-solid fa-caret-right"></i> Participant Rights & Data Control</a></li>
                    <li><a href="#sec6"><i class="fa-solid fa-caret-right"></i> Administrative & Developer Contact</a></li>
                    <li><a href="#sec7"><i class="fa-solid fa-caret-right"></i> Cookies & Local Storage Policy</a></li>
                    <li><a href="#sec8"><i class="fa-solid fa-caret-right"></i> Third-Party Services & Data Sharing</a></li>
                    <li><a href="#sec9"><i class="fa-solid fa-caret-right"></i> Children's Privacy</a></li>
                    <li><a href="#sec10"><i class="fa-solid fa-caret-right"></i> Data Retention & Deletion Policy</a></li>
                    <li><a href="#sec11"><i class="fa-solid fa-caret-right"></i> Policy Updates & Changes</a></li>
                </ul>
            </div>
            
            <p>Welcome to <strong>ProMatch Arena</strong>. We value your digital privacy with absolute seriousness and transparency. Because our application functions as a fully realized, enterprise-grade cricket tournament management and sports analytics system, this comprehensive Privacy Policy outlines the complete lifecycle of data collection, structural processing, secure storage, and strict protection protocols enforced across our digital ecosystem. By interacting with our software modules, dashboards, and services, you consent to the data practices described within this governance document.</p>

            <h3 id="sec1">1. Complete Technological Stack & Core Data Processing Framework</h3>
            <p>To fully understand our data privacy standards and compliance metrics, it is vital to examine the multi-tier enterprise architecture that processes participant information within ProMatch Arena:</p>
            <ul>
                <li><strong>Spring Boot Backend Engine:</strong> Operates as the core server-side architecture, managing modular routing, controller dispatching, asynchronous task execution, and core application service orchestration with minimal network latency and maximum request security.</li>
                <li><strong>JSP Views & JSTL Templates:</strong> Responsible for rendering dynamic user dashboards, real-time statistics grids, interactive multimedia video highlights, and responsive visual galleries across client browsers.</li>
                <li><strong>PostgreSQL Relational Database:</strong> Acts as the foundational data repository, maintaining highly structured relational database mapping tables for multi-tier tournaments, competing teams, detailed player rosters, match scorecards, and historical fixture logs with absolute transaction integrity and ACID compliance.</li>
                <li><strong>Spring Security Framework:</strong> Enforces rigorous role-based access control (RBAC) models, strictly separating administrative privileges from standard user permissions to ensure that unauthorized actors cannot access restricted operational data or administrative controllers.</li>
                <li><strong>Automated Net Run Rate (NRR) Engine:</strong> A specialized mathematical calculation algorithm integrated into the backend core that computes precise Net Run Rates instantly upon match conclusion, updating tournament standings and team qualification brackets in real time.</li>
            </ul>

            <h3 id="sec2">2. Categories of Information Collected and Processed</h3>
            <p>In accordance with data minimization principles, ProMatch Arena restricts data collection strictly to operational necessities required for efficient tournament administration, accurate scorekeeping, and secure user authentication:</p>
            <ul>
                <li><strong>Identity & Authentication Records:</strong> Full legal or display names, secure login email addresses, and enterprise-hashed passwords managed securely through Spring Security active session scopes.</li>
                <li><strong>Client-Side Profile Storage:</strong> User profile picture binaries or external image URLs uploaded via account management drop downs, synchronized and cached locally via browser `localStorage` utilities to guarantee seamless avatar persistence across page reloads and browser sessions.</li>
                <li><strong>Sports Analytics & Operational Logs:</strong> Registered team names, squad player configurations, jersey numbers, match score inputs, innings summaries, and navigation search keyword queries logged during active system interaction.</li>
            </ul>

            <h3 id="sec3">3. Purpose and Scope of Data Utilization</h3>
            <p>Your personal and operational data is never commercialized, monetized, rented, or shared with external third-party advertising entities. Information processed within ProMatch Arena is utilized strictly for internal platform modules and tournament workflows:</p>
            <ul>
                <li><strong>Secure Session Management:</strong> Authenticating user identity during login handshakes and securing restricted operational zones, including team registration portals, squad management dashboards, and password modification panels.</li>
                <li><strong>Dynamic Analytics & Real-Time Leaderboards:</strong> Processing transactional records to update points tables, active tournament participant counts, and win-loss team statistics instantaneously via optimized PostgreSQL queries.</li>
                <li><strong>Interactive AI Assistance & Navigation:</strong> Processing conversational text prompts submitted inside the embedded assistant chatbot module to deliver rapid navigation paths, troubleshooting steps, and technical architecture guidance.</li>
            </ul>

            <h3 id="sec4">4. Robust Data Security Protocols and Architectural Safeguards</h3>
            <p>ProMatch Arena deploys multi-layered, defense-in-depth cybersecurity protocols. User credentials undergo advanced cryptographic hashing before persistence in the database; all database interactions utilize parameterized prepared statements to neutralize SQL injection vulnerabilities; and strict cross-origin resource sharing (CORS) boundaries protect the platform routing tiers from malicious external tampering.</p>

            <h3 id="sec5">5. Participant Rights and Individual Data Control</h3>
            <p>Registered participants maintain absolute control over their accounts and personal data profiles. You retain the full legal right to update or replace your user avatar at any time, clear local storage tokens, modify your account access credentials through the secure change-password portal, or terminate your active session securely via the platform logout routine.</p>

            <h3 id="sec6">6. Official Administrative and Developer Support Contact</h3>
            <p>If you have any questions, formal compliance inquiries, vulnerability disclosures, or technical support requirements regarding this comprehensive Privacy Policy, please contact the platform creator and lead architect directly:</p>
            
            <div class="contact-box">
                <h4>👤 Jitendra Singh (Lead Developer & System Administrator)</h4>
                <p><i class="fa-solid fa-phone me-2 text-primary"></i> Direct Phone / WhatsApp: +91 7806035087</p>
                <p><i class="fa-solid fa-envelope me-2 text-primary"></i> Official Email: jitendrasingh07022004@gmail.com</p>
                <p><i class="fa-solid fa-server me-2 text-primary"></i> System Architecture: ProMatch Arena Enterprise Tournament Hub</p>
            </div>

            <!-- ===================== NEW SECTION 7: COOKIES & LOCAL STORAGE POLICY ===================== -->
            <h3 id="sec7">7. Cookies & Local Storage Policy</h3>
            <p>ProMatch Arena uses browser-based storage mechanisms strictly to enhance functional usability rather than for tracking or advertising purposes:</p>
            <ul>
                <li><strong>Session Cookies:</strong> Used exclusively to maintain your authenticated login state as you navigate between dashboards, squad pages, and tournament brackets.</li>
                <li><strong>Local Storage (`matchTheme`):</strong> Stores your Dark Mode / Light Mode preference locally in your browser so the interface remembers your chosen theme across visits.</li>
                <li><strong>No Third-Party Tracking Cookies:</strong> We do not deploy advertising pixels, cross-site tracking cookies, or behavioral profiling scripts anywhere on the platform.</li>
                <li><strong>Browser Control:</strong> You may clear cookies and local storage at any time through your browser settings; doing so will reset your theme preference and require re-authentication.</li>
            </ul>

            <!-- ===================== NEW SECTION 8: THIRD-PARTY SERVICES & DATA SHARING ===================== -->
            <h3 id="sec8">8. Third-Party Services & Limited Data Sharing</h3>
            <p>ProMatch Arena integrates a minimal set of trusted third-party services strictly necessary for platform operation:</p>
            <ul>
                <li><strong>Razorpay Payment Gateway:</strong> Processes tournament entry fee transactions securely; ProMatch Arena never stores raw card or banking credentials on its own servers.</li>
                <li><strong>Content Delivery Networks (CDNs):</strong> Bootstrap, Font Awesome, and Google Fonts are loaded from trusted CDN providers strictly for interface styling — no personal data is transmitted to these providers.</li>
                <li><strong>Video Embeds:</strong> Match highlight videos are embedded via YouTube's standard iframe player, which operates under YouTube's own privacy terms when a video is played.</li>
                <li><strong>No Data Resale:</strong> None of your personal information is sold, rented, or licensed to any third-party marketing or analytics company.</li>
            </ul>

            <!-- ===================== NEW SECTION 9: CHILDREN'S PRIVACY ===================== -->
            <h3 id="sec9">9. Children's Privacy</h3>
            <p>ProMatch Arena is intended for use by team administrators, players, and tournament organizers who are at least 13 years of age. We do not knowingly collect personal information from children under 13. Student and school-level teams registering through supervised programs must be represented by an authorized adult coordinator or coach. If we become aware that data has been inadvertently collected from a child under 13 without appropriate consent, we will take prompt steps to delete such information.</p>

            <!-- ===================== NEW SECTION 10: DATA RETENTION & DELETION POLICY ===================== -->
            <h3 id="sec10">10. Data Retention & Account Deletion Policy</h3>
            <p>We retain personal and tournament-related data only as long as necessary to fulfill the purposes outlined in this policy:</p>
            <ul>
                <li><strong>Active Accounts:</strong> Data is retained for the full duration your account remains active and in good standing on the platform.</li>
                <li><strong>Account Deletion Requests:</strong> Upon a verified deletion request, personal identity data is permanently purged from our PostgreSQL database within 7–10 business days, excluding anonymized historical match statistics required for tournament record integrity.</li>
                <li><strong>Inactive Accounts:</strong> Accounts inactive for over 24 months may be archived or removed following prior notification to the registered email address.</li>
            </ul>

            <!-- ===================== NEW SECTION 11: POLICY UPDATES & CHANGES ===================== -->
            <h3 id="sec11">11. Policy Updates & Changes</h3>
            <p>ProMatch Arena reserves the right to revise this Privacy Policy periodically to reflect platform updates, new features, or evolving legal and regulatory requirements. The "Last updated" date at the top of this page will always indicate the most recent revision. Continued use of the platform following any policy update constitutes your acceptance of the revised terms. We encourage users to periodically review this page for the latest information on our data practices.</p>
        </div>

        <!-- CHATBOT FILE INCLUDE -->
        <jsp:include page="chatbot.jsp" />

        <!-- 🌟 FOOTER INCLUDE -->
        <jsp:include page="footer.jsp" />
    </div>

    <!-- Bootstrap JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
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