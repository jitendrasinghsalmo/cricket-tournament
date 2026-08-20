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
    </style>
</head>
<body>

    <!-- NAVBAR INCLUDE -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">
        <div class="header-bar">
            <div class="header-left">
                <button onclick="history.back()" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</button>
            </div>
            <div>
                <h2 style="font-size: 20px; font-weight: 900; margin: 0; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-transform: uppercase; letter-spacing: 1.5px;">Privacy Policy</h2>
            </div>
            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
            </div>
        </div>

        <div class="policy-container">
            <h1><i class="fa-solid fa-shield-halved"></i> Comprehensive Privacy Policy</h1>
            <span class="last-updated">Last updated & Effective Date: June 2026 | ProMatch Arena Governance & Data Compliance Framework</span>
            
            <p>Welcome to <strong>ProMatch Arena</strong>. We value your digital privacy with absolute seriousness and transparency. Because our application functions as a fully realized, enterprise-grade cricket tournament management and sports analytics system, this comprehensive Privacy Policy outlines the complete lifecycle of data collection, structural processing, secure storage, and strict protection protocols enforced across our digital ecosystem. By interacting with our software modules, dashboards, and services, you consent to the data practices described within this governance document.</p>

            <h3>1. Complete Technological Stack & Core Data Processing Framework</h3>
            <p>To fully understand our data privacy standards and compliance metrics, it is vital to examine the multi-tier enterprise architecture that processes participant information within ProMatch Arena:</p>
            <ul>
                <li><strong>Spring Boot Backend Engine:</strong> Operates as the core server-side architecture, managing modular routing, controller dispatching, asynchronous task execution, and core application service orchestration with minimal network latency and maximum request security.</li>
                <li><strong>JSP Views & JSTL Templates:</strong> Responsible for rendering dynamic user dashboards, real-time statistics grids, interactive multimedia video highlights, and responsive visual galleries across client browsers.</li>
                <li><strong>PostgreSQL Relational Database:</strong> Acts as the foundational data repository, maintaining highly structured relational database mapping tables for multi-tier tournaments, competing teams, detailed player rosters, match scorecards, and historical fixture logs with absolute transaction integrity and ACID compliance.</li>
                <li><strong>Spring Security Framework:</strong> Enforces rigorous role-based access control (RBAC) models, strictly separating administrative privileges from standard user permissions to ensure that unauthorized actors cannot access restricted operational data or administrative controllers.</li>
                <li><strong>Automated Net Run Rate (NRR) Engine:</strong> A specialized mathematical calculation algorithm integrated into the backend core that computes precise Net Run Rates instantly upon match conclusion, updating tournament standings and team qualification brackets in real time.</li>
            </ul>

            <h3>2. Categories of Information Collected and Processed</h3>
            <p>In accordance with data minimization principles, ProMatch Arena restricts data collection strictly to operational necessities required for efficient tournament administration, accurate scorekeeping, and secure user authentication:</p>
            <ul>
                <li><strong>Identity & Authentication Records:</strong> Full legal or display names, secure login email addresses, and enterprise-hashed passwords managed securely through Spring Security active session scopes.</li>
                <li><strong>Client-Side Profile Storage:</strong> User profile picture binaries or external image URLs uploaded via account management drop downs, synchronized and cached locally via browser `localStorage` utilities to guarantee seamless avatar persistence across page reloads and browser sessions.</li>
                <li><strong>Sports Analytics & Operational Logs:</strong> Registered team names, squad player configurations, jersey numbers, match score inputs, innings summaries, and navigation search keyword queries logged during active system interaction.</li>
            </ul>

            <h3>3. Purpose and Scope of Data Utilization</h3>
            <p>Your personal and operational data is never commercialized, monetized, rented, or shared with external third-party advertising entities. Information processed within ProMatch Arena is utilized strictly for internal platform modules and tournament workflows:</p>
            <ul>
                <li><strong>Secure Session Management:</strong> Authenticating user identity during login handshakes and securing restricted operational zones, including team registration portals, squad management dashboards, and password modification panels.</li>
                <li><strong>Dynamic Analytics & Real-Time Leaderboards:</strong> Processing transactional records to update points tables, active tournament participant counts, and win-loss team statistics instantaneously via optimized PostgreSQL queries.</li>
                <li><strong>Interactive AI Assistance & Navigation:</strong> Processing conversational text prompts submitted inside the embedded assistant chatbot module to deliver rapid navigation paths, troubleshooting steps, and technical architecture guidance.</li>
            </ul>

            <h3>4. Robust Data Security Protocols and Architectural Safeguards</h3>
            <p>ProMatch Arena deploys multi-layered, defense-in-depth cybersecurity protocols. User credentials undergo advanced cryptographic hashing before persistence in the database; all database interactions utilize parameterized prepared statements to neutralize SQL injection vulnerabilities; and strict cross-origin resource sharing (CORS) boundaries protect the platform routing tiers from malicious external tampering.</p>

            <h3>5. Participant Rights and Individual Data Control</h3>
            <p>Registered participants maintain absolute control over their accounts and personal data profiles. You retain the full legal right to update or replace your user avatar at any time, clear local storage tokens, modify your account access credentials through the secure change-password portal, or terminate your active session securely via the platform logout routine.</p>

            <h3>6. Official Administrative and Developer Support Contact</h3>
            <p>If you have any questions, formal compliance inquiries, vulnerability disclosures, or technical support requirements regarding this comprehensive Privacy Policy, please contact the platform creator and lead architect directly:</p>
            
            <div class="contact-box">
                <h4>👤 Jitendra Singh (Lead Developer & System Administrator)</h4>
                <p><i class="fa-solid fa-phone me-2 text-primary"></i> Direct Phone / WhatsApp: +91 7806035087</p>
                <p><i class="fa-solid fa-envelope me-2 text-primary"></i> Official Email: jitendrasingh07022004@gmail.com</p>
                <p><i class="fa-solid fa-server me-2 text-primary"></i> System Architecture: ProMatch Arena Enterprise Tournament Hub</p>
            </div>
        </div>

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