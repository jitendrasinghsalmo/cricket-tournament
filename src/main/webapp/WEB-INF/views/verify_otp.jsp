<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Verify OTP</title>

    <!-- Theme apply (runs immediately, no flash) - navbar.jsp wali same key -->
    <script>
        (function () {
            try {
                if (localStorage.getItem('promatch_theme') === 'light') {
                    document.documentElement.setAttribute('data-theme', 'light');
                }
            } catch (e) {}
        })();
    </script>

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700;800;900&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.75);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.25);
            --body-overlay: rgba(3, 7, 18, 0.85);
            --input-bg: rgba(3, 7, 18, 0.5);
        }

        html, body { margin: 0; padding: 0; width: 100%; overflow-x: hidden; }
        * { box-sizing: border-box; }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%),
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary);
            display: flex; justify-content: center; align-items: center;
            min-height: 100vh; min-height: 100dvh; padding: 10px;
        }

        .auth-container {
            width: 100%; max-width: 450px;
            background: var(--card-surface); backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass); border-radius: 22px;
            padding: 34px 40px; box-shadow: 0 30px 60px rgba(0,0,0,0.45);
            position: relative; overflow: hidden;
        }
        .auth-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .auth-title {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            font-size: 24px; font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; margin-bottom: 8px;
            text-align: center; white-space: nowrap;
        }
        .title-emoji { font-size: 1em; line-height: 1; }
        .auth-subtitle {
            font-size: 13px; color: var(--text-secondary); text-align: center;
            line-height: 1.6; margin-bottom: 24px;
        }

        .alert-error {
            background: rgba(244, 63, 94, 0.15); border: 1px solid rgba(244, 63, 94, 0.4);
            color: var(--neon-rose); padding: 9px 14px; border-radius: 10px;
            font-size: 12.5px; font-weight: 700; margin-bottom: 16px; text-align: center;
        }

        .form-group { display: flex; flex-direction: column; gap: 6px; margin-bottom: 18px; }

        label {
            font-size: 11.5px; font-weight: 700; color: var(--text-secondary);
            text-transform: uppercase; letter-spacing: 0.5px;
        }

        input {
            background: var(--input-bg); border: 1px solid var(--border-glass);
            border-radius: 11px; padding: 13px 16px; color: var(--text-primary);
            font-size: 1.2rem; outline: none; transition: all 0.2s ease; width: 100%;
            text-align: center; letter-spacing: 8px; font-weight: 700;
            backdrop-filter: blur(5px);
        }
        input::placeholder { color: #64748b; letter-spacing: 4px; }
        input:focus {
            border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.35);
            background: var(--card-surface);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff; border: 1px solid rgba(56, 189, 248, 0.4);
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            padding: 14px; border-radius: 12px;
            font-size: 13.5px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.6px; cursor: pointer; transition: all 0.25s ease;
            display: flex; align-items: center; justify-content: center; gap: 8px;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .auth-footer {
            text-align: center; margin-top: 20px; font-size: 13px; color: var(--text-secondary);
        }
        .auth-footer a {
            color: var(--neon-cyan); font-weight: 700; text-decoration: none; transition: 0.2s;
        }
        .auth-footer a:hover { text-decoration: underline; text-shadow: 0 0 10px rgba(56, 189, 248, 0.4); }

        /* Mobile responsive */
        @media (max-width: 480px) {
            body { padding: 8px; }
            .auth-container { padding: 24px 20px; border-radius: 18px; }
            .auth-title { font-size: 20px; letter-spacing: 0.5px; gap: 8px; }
            .auth-subtitle { font-size: 12px; margin-bottom: 14px; }
            input { letter-spacing: 6px; }
        }

        /* Very small phones */
        @media (max-width: 360px) {
            .auth-title { font-size: 17px; letter-spacing: 0.3px; gap: 6px; }
            input { font-size: 1.1rem; letter-spacing: 4px; padding: 12px 10px; }
        }

        /* Short screens (small phones / landscape) */
        @media (max-height: 560px) {
            body { padding: 6px; }
            .auth-container { padding: 14px 20px; }
            .auth-title { font-size: 17px; margin-bottom: 2px; }
            .auth-subtitle { margin-bottom: 8px; font-size: 11.5px; line-height: 1.4; }
            .form-group { margin-bottom: 8px; gap: 3px; }
            label { font-size: 10.5px; }
            input { padding: 8px 12px; }
            .btn-submit { padding: 9px; }
            .auth-footer { margin-top: 8px; font-size: 12px; }
        }
    </style>

    <!-- 🌟 NEW: DARK + LIGHT MODE (navbar.jsp ki saved theme follow karta hai, toggle nahi) -->
    <style>
        html[data-theme="light"] {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.88);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: rgba(2, 132, 199, 0.35);
            --body-overlay: rgba(241, 245, 249, 0.88);
            --input-bg: #ffffff;
        }
        html[data-theme="light"] .auth-container { box-shadow: 0 25px 50px rgba(15, 23, 42, 0.18); }
        html[data-theme="light"] input::placeholder { color: #64748b; opacity: 1; }
        html[data-theme="light"] input:focus { background: #ffffff; }
        html[data-theme="light"] .alert-error { background: rgba(225, 29, 72, 0.1); border-color: rgba(225, 29, 72, 0.4); }
    </style>
</head>
<body>

    <div class="auth-container">
        <div class="auth-title">
            <span class="title-emoji">🛡️</span>
            <span>Verify OTP</span>
        </div>
        <div class="auth-subtitle">Enter the secure 6-digit code sent to your registered email address.</div>

        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/verify-otp" method="post" id="otpForm">
            <div class="form-group">
                <label>Enter 6-Digit OTP</label>
                <input type="text" name="otp" id="otpInput" placeholder="------" maxlength="6" required autocomplete="off">
            </div>

            <button type="submit" class="btn-submit">
                Verify OTP <i class="fa-solid fa-square-check"></i>
            </button>
        </form>

        <div class="auth-footer">
            Back to <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>

    <!-- 🌟 NEW: saved theme follow (no toggle here) -->
    <script>
        (function () {
            var root = document.documentElement, KEY = 'promatch_theme';
            window.addEventListener('storage', function (e) {
                if (e.key !== KEY) return;
                if (e.newValue === 'light') root.setAttribute('data-theme', 'light');
                else root.removeAttribute('data-theme');
            });
        })();
    </script>
</body>
</html>
