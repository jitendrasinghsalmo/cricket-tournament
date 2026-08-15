<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProMatch Arena | Comprehensive Privacy Policy</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --bg-main: #030712; --bg-card: rgba(13, 18, 30, 0.94); --accent-blue: #38bdf8; --text-main: #f8fafc; --text-muted: #94a3b8; --border-color: rgba(56, 189, 248, 0.28); }
        body { font-family: 'Inter', system-ui, sans-serif; background: linear-gradient(135deg, #030712 0%, #0a0f1d 100%); color: var(--text-main); min-height: 100vh; padding: 50px 0; }
        .policy-container { max-width: 1050px; margin: 0 auto; background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 24px; padding: 50px; box-shadow: 0 25px 60px rgba(0,0,0,0.8); backdrop-filter: blur(20px); }
        h1 { color: var(--accent-blue); font-weight: 900; margin-bottom: 8px; font-size: 32px; display: flex; align-items: center; gap: 14px; }
        .last-updated { font-size: 13.5px; color: var(--text-muted); margin-bottom: 35px; display: block; border-bottom: 1px solid var(--border-color); padding-bottom: 15px; }
        h3 { color: var(--text-main); font-size: 18px; font-weight: 800; margin-top: 35px; margin-bottom: 12px; border-left: 4px solid var(--accent-blue); padding-left: 12px; }
        p, li { color: var(--text-muted); font-size: 14.5px; line-height: 1.8; }
        ul { padding-left: 22px; margin-bottom: 15px; }
        .tech-badge { background: rgba(56, 189, 248, 0.1); border: 1px solid var(--accent-blue); color: var(--accent-blue); padding: 3px 8px; border-radius: 6px; font-size: 12px; font-weight: 700; }
        .contact-box { background: rgba(56, 189, 248, 0.08); border: 1.5px solid var(--accent-blue); border-radius: 18px; padding: 25px; margin-top: 40px; box-shadow: inset 0 0 15px rgba(56, 189, 248, 0.1); }
        .contact-box h4 { font-size: 17px; font-weight: 800; color: var(--accent-blue); margin-bottom: 12px; }
        .contact-box p { margin: 6px 0; color: var(--text-main); font-weight: 600; font-size: 14.5px; }
        .back-btn { background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); color: #030712; font-weight: 800; padding: 10px 24px; border-radius: 12px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; margin-bottom: 35px; transition: 0.3s; box-shadow: 0 4px 15px rgba(56,189,248,0.3); }
        .back-btn:hover { transform: translateY(-2px); color: #030712; }
    </style>
</head>
<body>
    <div class="container">
        <a href="/home" class="back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        <div class="policy-container">
            <h1><i class="fa-solid fa-shield-halved"></i> Comprehensive Privacy Policy</h1>
            <span class="last-updated">Last updated & Effective Date: June 2026 | ProMatch Arena Governance & Data Compliance</span>
            
            <p>Welcome to <strong>ProMatch Arena</strong>. We value your digital privacy with utmost seriousness. Because our application is a fully realized enterprise-grade cricket tournament management system, this Privacy Policy outlines A to Z conditions regarding how data is collected, processed, structured, and protected across our platform.</p>

            <h3>1. Complete Technological Stack & Data Processing Framework</h3>
            <p>To understand our privacy standards, it is essential to know what technologies process your data within ProMatch Arena:</p>
            <ul>
                <li><span class="tech-badge">Spring Boot Backend</span>: Handles modular routing, controller dispatching, and core application services.</li>
                <li><span class="tech-badge">JSP Views & JSTL</span>: Renders dynamic user dashboards, statistics grids, interactive video highlights, and responsive galleries.</li>
                <li><span class="tech-badge">PostgreSQL Database</span>: Relational database mapping tables for tournaments, teams, player rosters, match scorecards, and historical fixtures with absolute transaction integrity.</li>
                <li><span class="tech-badge">Spring Security</span>: Enforces rigorous role-based access control (RBAC) separating administrative privileges from standard user permissions.</li>
                <li><span class="tech-badge">Automated NRR Engine</span>: Mathematical algorithm that calculates Net Run Rates instantly upon match conclusion to update tournament standings.</li>
            </ul>

            <h3>2. Categories of Information We Collect</h3>
            <p>We restrict data collection strictly to operational necessities required for tournament administration:</p>
            <ul>
                <li><strong>Identity & Authentication Records:</strong> Full user names, secure login email addresses, and encrypted passwords managed through Spring Security session scopes (`sessionScope.user`).</li>
                <li><strong>Client-Side Local Storage Data:</strong> Profile picture binaries or URLs uploaded via the account dropdown, saved locally via browser `localStorage` to ensure user avatars persist seamlessly across page reloads.</li>
                <li><strong>Sports & Operational Logs:</strong> Registered team names, jersey numbers, player squads, match score inputs, and search keyword queries logged during navigation.</li>
            </ul>

            <h3>3. How We Use and Process Your Data</h3>
            <p>Your data is never commercialized, sold, or shared with third-party entities. It is processed exclusively within internal platform modules:</p>
            <ul>
                <li><strong>Session Management:</strong> Verifying user identity during login and securing restricted zones (such as team registration and password modification views).</li>
                <li><strong>Dynamic Analytics & Leaderboards:</strong> Updating points tables, active tournament counts, and win/loss records instantaneously via PostgreSQL queries.</li>
                <li><strong>Interactive AI Assistance:</strong> Processing conversational text inputs inside the "ProMatch Cricket AI" chatbot module to provide fast navigation links and project architecture guidelines.</li>
            </ul>

            <h3>4. Data Security Protocols & Safeguards</h3>
            <p>We deploy robust defense-in-depth measures: passwords undergo enterprise hashing algorithms, database queries utilize parameterized prepared statements to eliminate SQL injection vulnerabilities, and CORS boundaries protect routing layers.</p>

            <h3>5. User Rights & Data Control</h3>
            <p>Users maintain full control over their accounts. You can update your profile avatar at any time, clear local storage tokens, modify your account passwords via the secure change-password portal, or terminate your active session via the secure logout protocol.</p>

            <h3>6. Direct Administrator & Developer Contact</h3>
            <p>If you have any questions, compliance inquiries, or technical support requests regarding this Privacy Policy, please contact the creator and system administrator directly:</p>
            
            <div class="contact-box">
                <h4>👤 Jitendra Singh (Lead Developer & System Administrator)</h4>
                <p><i class="fa-solid fa-phone me-2 text-primary"></i> Direct Phone / WhatsApp: +91 7806035087</p>
                <p><i class="fa-solid fa-envelope me-2 text-primary"></i> Official Email: jitendrasingh07022004@gmail.com</p>
                <p><i class="fa-solid fa-server me-2 text-primary"></i> System: ProMatch Arena Enterprise Tournament Hub</p>
            </div>
        </div>
    </div>
</body>
</html>