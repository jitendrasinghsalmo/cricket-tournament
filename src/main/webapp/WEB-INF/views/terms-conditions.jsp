<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProMatch Arena | Comprehensive Terms & Conditions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root { --bg-main: #030712; --bg-card: rgba(13, 18, 30, 0.92); --accent-blue: #38bdf8; --text-main: #f8fafc; --text-muted: #94a3b8; --border-color: rgba(56, 189, 248, 0.28); }
        body { font-family: 'Inter', system-ui, sans-serif; background: linear-gradient(135deg, #030712 0%, #0a0f1d 100%); color: var(--text-main); min-height: 100vh; padding: 50px 0; }
        .terms-container { max-width: 1050px; margin: 0 auto; background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 24px; padding: 50px; box-shadow: 0 25px 60px rgba(0,0,0,0.8); backdrop-filter: blur(20px); }
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
        <div class="terms-container">
            <h1><i class="fa-solid fa-file-contract"></i> Comprehensive Terms & Conditions</h1>
            <span class="last-updated">Last updated & Effective Date: June 2026 | ProMatch Arena Governance & User Obligations</span>
            
            <p>Welcome to <strong>ProMatch Arena</strong>. By accessing, logging into, navigating, or utilizing our enterprise-grade cricket tournament management system, you formally agree to abide by these exhaustive Terms and Conditions. Please read every condition carefully.</p>

            <h3>1. Scope of Agreement & Platform Architecture Acceptance</h3>
            <p>This document constitutes a legally binding contract between you (the user, player, team registrar, or system administrator) and ProMatch Arena. Our system operates on a robust ecosystem consisting of:</p>
            <ul>
                <li><strong>Backend Routing:</strong> Spring Boot enterprise controllers managing request lifecycles.</li>
                <li><strong>Data Layer:</strong> PostgreSQL relational database schema mapping teams, tournaments, squads, and math records.</li>
                <li><strong>Security Layer:</strong> Spring Security enforcing role-based permissions (ADMIN vs USER).</li>
                <li><strong>Frontend & Analytics:</strong> JSP views styled with Cyber Glassmorphism UI, featuring continuous spin and hover-tilt galleries, automated Net Run Rate (NRR) calculators, and an interactive AI Chatbot.</li>
            </ul>

            <h3>2. User Account Obligations, Security & Access Rules</h3>
            <ul>
                <li><strong>Credential Confidentiality:</strong> Users are solely responsible for safeguarding their login usernames, passwords, and active session tokens. Sharing credentials across unauthorized individuals is prohibited.</li>
                <li><strong>Prohibited System Interferences:</strong> Any attempt to inject malicious code, tamper with the automated NRR calculation formulas, execute unauthorized database queries against PostgreSQL tables, or bypass Spring Security filters will result in permanent account termination and legal action.</li>
                <li><strong>Accurate Data Input:</strong> Team managers and registrars must submit verified player details, authentic jersey assignments, and accurate match statistics during roster creation.</li>
            </ul>

            <h3>3. Intellectual Property and Proprietary Rights</h3>
            <p>All source code, software architectures, custom database mappings, graphical assets, video embedding integrations, UI themes, and textual documentation associated with ProMatch Arena are proprietary intellectual property. Unauthorized copying, reverse engineering, or commercial resale of this platform is strictly forbidden.</p>

            <h3>4. Limitation of Liability & Operational Uptime</h3>
            <p>ProMatch Arena is provided on an "as-is" and "as-available" basis. The platform creators do not guarantee absolute uninterrupted server uptime or immunity from local browser storage clearances. We shall bear no liability for accidental data loss resulting from improper local database adjustments or unexpected server maintenance windows.</p>

            <h3>5. Suspension, Termination & Modification of Terms</h3>
            <p>We reserve the unrestricted right to modify, update, suspend, or terminate platform features, views, controllers, or user accounts at any time without prior notice. Continued interaction with ProMatch Arena following policy updates constitutes binding consent to the revised agreements.</p>

            <h3>6. Official Administrative & Developer Support</h3>
            <p>For any formal legal inquiries, partnership proposals, security vulnerability reports, or technical support requests regarding these Terms and Conditions, please contact the platform creator and lead administrator directly:</p>
            
            <div class="contact-box">
                <h4>👤 Jitendra Singh (Lead Developer & System Administrator)</h4>
                <p><i class="fa-solid fa-phone me-2 text-primary"></i> Direct Phone / WhatsApp: +91 7806035087</p>
                <p><i class="fa-solid fa-envelope me-2 text-primary"></i> Official Email: jitendrasingh07022004@gmail.com</p>
                <p><i class="fa-solid fa-code me-2 text-primary"></i> System: ProMatch Arena Enterprise Tournament Hub</p>
            </div>
        </div>
    </div>
</body>
</html>