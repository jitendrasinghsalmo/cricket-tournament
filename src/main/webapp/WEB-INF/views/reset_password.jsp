<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Reset Password</title>

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
            width: 100%; max-width: 480px;
            background: var(--card-surface); backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass); border-radius: 22px;
            padding: clamp(20px, 5.5vh, 52px) clamp(20px, 6vw, 46px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.45);
            position: relative; overflow: hidden;
        }
        .auth-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .auth-title {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            font-size: clamp(17px, 5.6vw, 26px); font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; margin-bottom: clamp(4px, 1.2vh, 10px);
            text-align: center; white-space: nowrap;
        }
        .title-emoji { font-size: 1em; line-height: 1; }
        .auth-subtitle {
            font-size: clamp(11.5px, 3.3vw, 13.5px); color: var(--text-secondary); text-align: center;
            line-height: 1.55; margin-bottom: clamp(12px, 4vh, 34px);
        }

        .alert-error {
            background: rgba(244, 63, 94, 0.15); border: 1px solid rgba(244, 63, 94, 0.4);
            color: var(--neon-rose); padding: 9px 14px; border-radius: 10px;
            font-size: 12.5px; font-weight: 700; margin-bottom: 14px; text-align: center;
        }

        /* Sizes scale with screen height so the form always fits without scrolling */
        .form-group {
            --gap: clamp(3px, 0.9vh, 8px);
            --input-h: clamp(40px, 7vh, 58px);
            display: flex; flex-direction: column; gap: var(--gap);
            margin-bottom: clamp(10px, 3vh, 26px); position: relative;
        }

        label {
            font-size: 11.5px; font-weight: 700; color: var(--text-secondary);
            text-transform: uppercase; letter-spacing: 0.5px; line-height: 14px;
        }

        input {
            background: var(--input-bg); border: 1px solid var(--border-glass);
            border-radius: 11px; padding: 0 46px 0 16px; color: var(--text-primary);
            font-size: 16px; outline: none; transition: all 0.2s ease; width: 100%;
            height: var(--input-h); backdrop-filter: blur(5px);
        }
        input::placeholder { color: #64748b; }
        input:focus {
            border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.35);
            background: var(--card-surface);
        }

        /* Eye toggle: always vertically centered on the input */
        .toggle-password {
            position: absolute;
            top: calc(14px + var(--gap));
            right: 6px;
            height: var(--input-h);
            width: 40px;
            padding: 0;
            display: flex; align-items: center; justify-content: center;
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            font-size: 1.05rem;
            transition: color 0.2s;
        }
        .toggle-password:hover { color: var(--neon-cyan); }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff; border: 1px solid rgba(56, 189, 248, 0.4);
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            height: clamp(42px, 7vh, 54px); border-radius: 12px;
            font-size: 13.5px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.6px; cursor: pointer; transition: all 0.25s ease;
            display: flex; align-items: center; justify-content: center; gap: 8px;
            margin-top: clamp(2px, 1vh, 10px);
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .auth-footer {
            text-align: center; margin-top: clamp(10px, 3.2vh, 28px); font-size: 13px; color: var(--text-secondary);
        }
        .auth-footer a {
            color: var(--neon-cyan); font-weight: 700; text-decoration: none; transition: 0.2s;
        }
        .auth-footer a:hover { text-decoration: underline; text-shadow: 0 0 10px rgba(56, 189, 248, 0.4); }

        /* Mobile responsive */
        @media (max-width: 480px) {
            body { padding: 8px; }
            .auth-container { border-radius: 18px; }
            .auth-title { letter-spacing: 0.5px; gap: 8px; }
        }

        /* Very short screens (landscape phones) */
        @media (max-height: 460px) {
            body { padding: 6px; }
            label { font-size: 10.5px; }
            .auth-footer { font-size: 12px; }
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
            <span class="title-emoji">🔐</span>
            <span>Reset Password</span>
        </div>
        <div class="auth-subtitle">Set a strong new password to secure your account.</div>

        <c:if test="${not empty error}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/reset-password" method="post" id="resetForm">

            <div class="form-group">
                <label>New Password</label>
                <input type="password" name="newPassword" id="newPassInput" placeholder="Enter new password" required autocomplete="off">
                <button type="button" class="toggle-password" onclick="togglePassword('newPassInput', this)">
                    <i class="fa-regular fa-eye"></i>
                </button>
            </div>

            <div class="form-group">
                <label>Confirm Password</label>
                <input type="password" name="confirmPassword" id="confirmPassInput" placeholder="Re-enter new password" required autocomplete="off">
                <button type="button" class="toggle-password" onclick="togglePassword('confirmPassInput', this)">
                    <i class="fa-regular fa-eye"></i>
                </button>
            </div>

            <button type="submit" class="btn-submit">
                Update Password <i class="fa-solid fa-square-check"></i>
            </button>
        </form>

        <div class="auth-footer">
            Back to <a href="${pageContext.request.contextPath}/login">Login</a>
        </div>
    </div>

    <script>
        function togglePassword(fieldId, btn) {
            const input = document.getElementById(fieldId);
            const icon = btn.querySelector('i');
            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("fa-eye");
                icon.classList.add("fa-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("fa-eye-slash");
                icon.classList.add("fa-eye");
            }
        }
    </script>

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
