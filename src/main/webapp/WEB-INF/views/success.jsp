<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Registration Successful</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-main: #030712;
            --bg-card: #0d121e;
            --card-surface: rgba(13, 18, 30, 0.75);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.25);
            --body-overlay: rgba(3, 7, 18, 0.85);
            --meta-box-bg: rgba(3, 7, 18, 0.55);
        }

        * { box-sizing: border-box; }
        html, body { width: 100%; overflow-x: hidden; }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%),
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            min-height: 100dvh;
            display: flex;
            flex-direction: column;
        }

        .page-content {
            flex: 1 0 auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: clamp(24px, 6vh, 56px) 16px;
        }

        .grand-footer-section { flex-shrink: 0; }

        .success-card {
            width: 100%;
            max-width: 480px;
            background: var(--card-surface);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass);
            border-radius: 22px;
            padding: clamp(26px, 5vh, 40px) clamp(20px, 6vw, 40px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.45);
            position: relative;
            overflow: hidden;
            text-align: center;
        }
        .success-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .icon-container {
            width: clamp(52px, 9vh, 66px); height: clamp(52px, 9vh, 66px);
            margin: 0 auto clamp(12px, 2vh, 16px) auto;
            background: rgba(16, 185, 129, 0.15); border: 2px solid var(--neon-emerald);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: clamp(22px, 4vh, 28px); color: var(--neon-emerald);
            animation: pulse-glow 2s infinite;
        }

        @keyframes pulse-glow {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.5); }
            70% { box-shadow: 0 0 0 16px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .jumping-title {
            color: var(--text-primary); margin: 0 0 8px 0; font-weight: 900;
            font-size: clamp(16px, 5vw, 24px); text-transform: uppercase; letter-spacing: 1px;
            white-space: nowrap;
        }
        .jumping-title span { color: var(--neon-emerald); text-shadow: 0 0 15px rgba(16, 185, 129, 0.5); }
        .subtitle {
            color: var(--text-secondary); font-size: clamp(11.5px, 3.3vw, 13px);
            margin: 0 0 clamp(16px, 3vh, 24px) 0; font-weight: 500; line-height: 1.55;
            overflow-wrap: anywhere;
        }
        .subtitle strong { color: var(--text-primary); }

        .receipt-box {
            background: var(--meta-box-bg); border: 1px dashed rgba(16, 185, 129, 0.35);
            border-radius: 16px; padding: clamp(14px, 3vh, 20px) clamp(14px, 4vw, 20px);
            margin-bottom: clamp(16px, 3vh, 24px);
            display: flex; flex-direction: column; gap: clamp(9px, 1.6vh, 12px); text-align: left;
        }

        .receipt-row { display: flex; justify-content: space-between; align-items: center; gap: 14px; font-size: 13.5px; }
        .receipt-label {
            color: var(--text-secondary); font-weight: 600; flex-shrink: 0;
            text-transform: uppercase; letter-spacing: 0.4px; font-size: 12px;
        }
        .receipt-val {
            color: var(--text-primary); font-weight: 800; font-family: monospace; font-size: 14px;
            text-align: right; min-width: 0; overflow-wrap: anywhere;
        }
        .receipt-divider { border: none; border-top: 1px dashed var(--border-glass); margin: 2px 0; width: 100%; }

        .status-badge {
            background: rgba(16, 185, 129, 0.15); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3);
            padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 800; text-transform: uppercase;
            white-space: nowrap;
        }

        .btn-action {
            width: 100%; display: flex; align-items: center; justify-content: center; gap: 10px;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%); color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            height: clamp(46px, 7vh, 54px); border-radius: 12px; font-weight: 800; font-size: 13.5px;
            cursor: pointer; transition: all 0.25s ease; text-decoration: none; text-transform: uppercase;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3); letter-spacing: 0.6px;
        }
        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        @media (max-width: 480px) {
            .success-card { border-radius: 18px; }
            .jumping-title { letter-spacing: 0.5px; }
            .receipt-row { font-size: 13px; }
            .receipt-label { font-size: 11px; }
            .receipt-val { font-size: 13px; }
        }

        /* 🌟 NAVBAR STYLING (matches navbar.jsp) */
        nav {
            background: rgba(10, 14, 39, 0.92);
            backdrop-filter: blur(25px);
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

        /* 🌟 FOOTER STYLING (exact match with home.jsp) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,217,255,0.5); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        @media(max-width: 650px) { .footer-socials { justify-content: center; } }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(56, 189, 248, 0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #030712; transform: translateY(-3px); box-shadow: 0 0 15px rgba(56,189,248,0.6); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(56,189,248,0.3); }
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

    <div class="page-content">
    <div class="success-card">

        <div class="icon-container">
            <i class="fa-solid fa-check"></i>
        </div>

        <h2 class="jumping-title">Payment <span>Successful!</span></h2>
        <p class="subtitle">Congratulations! Your team <strong>${teamName}</strong> has been fully registered and verified for the tournament.</p>

        <div class="receipt-box">
            <div class="receipt-row">
                <span class="receipt-label">Team Name</span>
                <span class="receipt-val">${teamName}</span>
            </div>
            <hr class="receipt-divider">
            <div class="receipt-row">
                <span class="receipt-label">Razorpay TXN ID</span>
                <span class="receipt-val" style="color: var(--neon-cyan);">${paymentId}</span>
            </div>
            <hr class="receipt-divider">
            <div class="receipt-row">
                <span class="receipt-label">Status</span>
                <span class="status-badge"><i class="fa-solid fa-shield-check"></i> Registered</span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/viewTeam" class="btn-action">
            <i class="fa-solid fa-users-rectangle"></i> View All Teams
        </a>

    </div>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>
