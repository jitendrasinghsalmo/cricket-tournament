<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="terms" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Comprehensive Terms & Conditions</title>
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

        /* Terms & Conditions Content Styles (Restricted h3 styling so footer h3 is unaffected) */
        .terms-container { 
            max-width: 1050px; 
            margin: 0 auto; 
            background: var(--card-surface); 
            border: 1.5px solid var(--border-glass); 
            border-radius: 24px; 
            padding: 50px; 
            box-shadow: 0 25px 60px rgba(0,0,0,0.5); 
            backdrop-filter: blur(20px); 
        }
        .terms-container h1 { color: var(--neon-cyan); font-weight: 900; margin-bottom: 8px; font-size: 32px; display: flex; align-items: center; gap: 14px; }
        .last-updated { font-size: 13.5px; color: var(--text-secondary); margin-bottom: 35px; display: block; border-bottom: 1px solid var(--border-glass); padding-bottom: 15px; }
        .terms-container h3 { color: var(--text-primary); font-size: 18px; font-weight: 800; margin-top: 35px; margin-bottom: 12px; border-left: 4px solid var(--neon-cyan); padding-left: 12px; }
        .terms-container p, .terms-container li { color: var(--text-secondary); font-size: 14.5px; line-height: 1.8; }
        .terms-container ul { padding-left: 22px; margin-bottom: 15px; }
        .contact-box { background: rgba(0, 217, 255, 0.08); border: 1.5px solid var(--neon-cyan); border-radius: 18px; padding: 25px; margin-top: 40px; box-shadow: inset 0 0 15px rgba(0, 217, 255, 0.1); }
        .contact-box h4 { font-size: 17px; font-weight: 800; color: var(--neon-cyan); margin-bottom: 12px; }
        .contact-box p { margin: 6px 0; color: var(--text-primary); font-weight: 600; font-size: 14.5px; }

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
                <h2 style="font-size: 20px; font-weight: 900; margin: 0; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); -webkit-background-clip: text; -webkit-text-fill-color: transparent; text-transform: uppercase; letter-spacing: 1.5px;">Terms & Conditions</h2>
            </div>
            <div class="header-right">
                <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
            </div>
        </div>

        <div class="terms-container">
            <h1><i class="fa-solid fa-file-contract"></i> Comprehensive Terms & Conditions</h1>
            <span class="last-updated">Last updated & Effective Date: June 2026 | ProMatch Arena Governance & User Obligations</span>
            
            <p>Welcome to <strong>ProMatch Arena</strong>. By accessing, logging into, navigating, or utilizing our enterprise-grade cricket tournament management system, you formally agree to abide by these exhaustive Terms and Conditions. Please read every condition, rule, and governance clause carefully before interacting with our digital ecosystem. This agreement is structured to safeguard platform integrity, protect user accounts, and maintain absolute transparency across all sports analytics operations.</p>

            <h3>1. Scope of Agreement & Platform Architecture Acceptance</h3>
            <p>This document constitutes a legally binding contract between you (acting as a user, player, team registrar, tournament coordinator, or system administrator) and ProMatch Arena. Our platform operates on a robust, high-performance, and scalable digital infrastructure engineered specifically for professional sports management, live scorekeeping, and tournament analytics. By accessing our services, you acknowledge and accept our multi-tier architecture:</p>
            <ul>
                <li><strong>Backend Routing Engine:</strong> Powered by Spring Boot enterprise controllers that manage request lifecycles, REST API endpoints, asynchronous threads, and core business logic execution with minimal latency.</li>
                <li><strong>Relational Data Layer:</strong> Backed by a secure PostgreSQL database schema mapping complex relationships between teams, multi-tier tournaments, player squads, individual match scorecards, and historical performance logs.</li>
                <li><strong>Security & Authorization Layer:</strong> Enforced through Spring Security configurations, implementing role-based access control (RBAC) separating ADMIN privileges from regular USER permissions to prevent unauthorized actions and data breaches.</li>
                <li><strong>Frontend Presentation Layer:</strong> Developed using dynamic JSP views enhanced with modern Cyber Glassmorphism UI styling, continuous CSS animations, interactive modal dialogues, automated Net Run Rate (NRR) computation utilities, and an integrated AI assistant chatbot.</li>
            </ul>

            <h3>2. User Account Obligations, Credential Security & Access Rules</h3>
            <p>Account security, integrity, and fair play are absolute prerequisites for participating within ProMatch Arena. Every registered participant, team captain, and system operator must strictly follow these mandatory compliance rules:</p>
            <ul>
                <li><strong>Credential Confidentiality & Management:</strong> Users are solely and exclusively responsible for safeguarding their login credentials, including usernames, hashed passwords, and active browser session tokens. Sharing login credentials across unauthorized individuals, teams, or external entities is strictly prohibited under any circumstances.</li>
                <li><strong>Prohibited System Interferences & Cyber Attacks:</strong> Any malicious attempt to inject code, execute SQL injection payloads, tamper with automated NRR calculation formulas, execute unauthorized database manipulation queries against PostgreSQL tables, or bypass Spring Security filters will result in permanent account termination, IP blacklisting, and potential legal prosecution.</li>
                <li><strong>Authenticity of Registered Data:</strong> Team managers, club representatives, and tournament registrars must submit verified, accurate player details, authentic jersey assignments, and legitimate contact information during squad creation and match scorecard verification.</li>
            </ul>

            <h3>3. Intellectual Property, Software Proprietary Rights & Licensing</h3>
            <p>All source code, software architectures, custom database mappings, graphical assets, video embedding integrations, responsive UI themes, database migration scripts, and textual documentation associated with ProMatch Arena are protected as proprietary intellectual property. Unauthorized copying, unauthorized redistribution, reverse engineering, unauthorized modification, or commercial resale of this platform or any of its modular components is strictly forbidden under domestic and international copyright regulations. All platform visuals and code structures remain the exclusive property of the system architects.</p>

            <h3>4. Limitation of Liability, System Reliability & Operational Uptime</h3>
            <p>ProMatch Arena is provided to users on an "as-is" and "as-available" basis without warranties of any kind, whether express or implied. The platform creators, lead developers, and system administrators do not guarantee absolute uninterrupted server uptime, 100% error-free software execution, or immunity from local browser storage cache clearances. We shall bear no liability whatsoever for accidental data loss resulting from improper local database adjustments, third-party internet service provider outages, browser incompatibilities, or unscheduled emergency server maintenance windows.</p>

            <h3>5. Suspension, Termination & Modification of Operating Terms</h3>
            <p>We reserve the absolute, unrestricted right to modify, update, suspend, or terminate platform features, JSP views, backend controllers, or user accounts at any time without prior individual notice. Continued interaction with ProMatch Arena following the publication of policy updates constitutes your formal, binding consent to the revised terms, conditions, and updated operational guidelines across all future tournaments.</p>

            <h3>6. Official Administrative, Developer & Technical Support</h3>
            <p>For any formal legal inquiries, partnership proposals, security vulnerability disclosures, or technical support requests regarding these comprehensive Terms and Conditions, please contact the platform creator and lead systems architect directly through the following official communication channels:</p>
            
            <div class="contact-box">
                <h4>👤 Jitendra Singh (Lead Developer & System Administrator)</h4>
                <p><i class="fa-solid fa-phone me-2 text-primary"></i> Direct Phone / WhatsApp: +91 7806035087</p>
                <p><i class="fa-solid fa-envelope me-2 text-primary"></i> Official Email: jitendrasingh07022004@gmail.com</p>
                <p><i class="fa-solid fa-code me-2 text-primary"></i> System Architecture: ProMatch Arena Enterprise Tournament Hub</p>
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