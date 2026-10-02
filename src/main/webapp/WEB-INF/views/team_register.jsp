<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Team Registration</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.82);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.25);
            --body-overlay: rgba(3, 7, 18, 0.78);
            --input-bg: rgba(3, 7, 18, 0.65);
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
            position: relative;
            box-sizing: border-box;
            transition: background 0.3s ease, color 0.3s ease;
            display: flex;
            flex-direction: column;
        }

        .page-content {
            flex: 1 0 auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: clamp(16px, 3.5vh, 36px) 16px;
            min-height: calc(100vh - 68px);
            min-height: calc(100dvh - 68px);
            box-sizing: border-box;
        }

        .grand-footer-section { flex-shrink: 0; }

        /* 🌟 NAVBAR STYLING (matches navbar.jsp) */
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
            box-shadow: 0 0 15px rgba(56,189,248,0.6); 
        }
        .logo-text { font-weight: 900; font-size: 18px; color: var(--text-primary); letter-spacing: 0.8px; }
        .logo-text span { display: block; font-size: 9.5px; color: var(--neon-cyan); letter-spacing: 2px; text-transform: uppercase; font-weight: 700; }

        .nav-links { list-style: none; margin: 0; padding: 0; display: flex; gap: 8px; align-items: center; }
        .nav-links a { 
            color: var(--text-secondary); text-decoration: none; font-size: 13.5px; font-weight: 700; 
            padding: 8px 16px; border-radius: 10px; transition: all 0.3s ease; text-transform: uppercase; letter-spacing: 0.5px;
        }
        .nav-links a:hover { color: var(--neon-cyan); background: rgba(56, 189, 248, 0.08); }
        .nav-links a.active { 
            color: #030712; background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); 
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.5); font-weight: 800; 
        }

        /* 🌟 FOOTER STYLING (matches footer.jsp) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 30px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(56,189,248,0.5); }
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

        /* Sizes scale with screen height so the form fits without scrolling */
        .form-container {
            width: 100%;
            max-width: 500px;
            background: var(--card-surface);
            backdrop-filter: blur(18px);
            -webkit-backdrop-filter: blur(18px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: clamp(12px, 2.2vh, 22px) clamp(16px, 5vw, 30px);
            box-shadow: 0 25px 50px rgba(0,0,0,0.45);
            position: relative;
            overflow: hidden;
            box-sizing: border-box;
        }
        .form-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .form-header {
            margin-bottom: clamp(8px, 1.6vh, 14px);
            text-align: center;
        }

        .jumping-title {
            color: var(--text-primary); margin: 0 0 3px 0; font-weight: 900;
            font-size: clamp(16px, 4.6vw, 20px); letter-spacing: 1px; text-transform: uppercase;
        }
        .jumping-title span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }
        .subtitle { color: var(--text-secondary); font-size: clamp(11px, 3vw, 12px); margin: 0; line-height: 1.4; }

        .form-group {
            margin-bottom: clamp(5px, 1.2vh, 11px);
        }

        label {
            display: block;
            font-size: 11px;
            font-weight: 700;
            color: var(--text-secondary);
            margin-bottom: clamp(2px, 0.5vh, 4px);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }

        .input-wrapper > i:first-child {
            position: absolute;
            left: 13px;
            color: var(--neon-cyan);
            font-size: 13px;
        }

        input[type="text"],
        input[type="number"] {
            width: 100%;
            height: clamp(32px, 4.6vh, 40px);
            background: var(--input-bg);
            border: 1px solid var(--border-glass);
            border-radius: 10px;
            padding: 0 12px 0 38px;
            color: var(--text-primary);
            font-size: 13.5px;
            font-family: inherit;
            outline: none;
            transition: all 0.2s ease;
            box-sizing: border-box;
        }

        input:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.3);
        }

        .form-actions {
            margin-top: clamp(8px, 1.6vh, 14px);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            height: clamp(36px, 5vh, 44px);
            padding: 0;
            border-radius: 12px;
            font-weight: 800;
            font-size: 12.5px;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.6px;
            box-sizing: border-box;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        /* Mobile responsive */
        @media (max-width: 480px) {
            .form-container { border-radius: 18px; }
            input[type="text"], input[type="number"] { font-size: 16px; } /* prevents zoom on iOS */
        }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="page-content">
    <div class="form-container">
        <div class="form-header">
            <h2 class="jumping-title">Register <span>Team</span></h2>
            <p class="subtitle">Enter your franchise credentials to join the tournament.</p>
        </div>
        
        <form action="${pageContext.request.contextPath}/register-team" method="post">
            
            <div class="form-group">
                <label>Team Name</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-shield-cat"></i>
                    <input type="text" name="teamName" required placeholder="Enter team franchise name" autocomplete="off" />
                </div>
            </div>

            <div class="form-group">
                <label>City</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-location-dot"></i>
                    <input type="text" name="city" required placeholder="Enter home city" autocomplete="off" />
                </div>
            </div>

            <div class="form-group">
                <label>Coach Name</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-user-gear"></i>
                    <input type="text" name="coachName" placeholder="Enter coach full name" autocomplete="off" />
                </div>
            </div>

            <div class="form-group">
                <label>Owner Name</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-user-tie"></i>
                    <input type="text" name="ownerName" placeholder="Enter franchise owner name" autocomplete="off" />
                </div>
            </div>

            <div class="form-group">
                <label>Logo URL</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-image"></i>
                    <input type="text" name="logoUrl" placeholder="Paste image badge link" autocomplete="off" />
                </div>
            </div>

            <div class="form-group">
                <label>Tournament Fee (INR)</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-indian-rupee-sign"></i>
                    <input type="number" name="amount" value="500" readonly style="opacity: 0.8; cursor: not-allowed;" />
                </div>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn-submit">
                    <i class="fa-solid fa-arrow-right-to-bracket"></i> Register Team Now
                </button>
            </div>
        </form>
    </div>
    </div>

    <jsp:include page="footer.jsp" />

</body>
</html>
