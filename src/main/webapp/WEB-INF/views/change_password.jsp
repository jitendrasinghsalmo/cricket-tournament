<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
    <title>ProMatch Arena | Change Password</title>
    <!-- FontAwesome for Eye Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
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

        body.light-theme,
        html[data-theme="light"] body {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.82);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --border-glass: rgba(2, 132, 199, 0.25);
            --body-overlay: rgba(241, 245, 249, 0.82);
            --input-bg: rgba(255, 255, 255, 0.7);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            display: flex; justify-content: center; align-items: center;
            min-height: 100vh; padding: 20px; box-sizing: border-box;
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* Top Left Back Button */
        .btn-back {
            position: absolute; top: 25px; left: 25px; z-index: 10;
            background: var(--card-surface); color: var(--neon-cyan);
            border: 1px solid var(--border-glass); padding: 9px 16px;
            border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px;
            transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
            backdrop-filter: blur(12px); box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .btn-back:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }

        .auth-container {
            width: 100%; max-width: 420px;
            background: var(--card-surface); backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass); border-radius: 22px;
            padding: 35px 40px; box-shadow: 0 30px 60px rgba(0,0,0,0.45);
            position: relative; overflow: hidden;
        }
        .auth-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .auth-title {
            font-size: 22px; font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px;
            text-align: center;
        }
        .auth-subtitle {
            font-size: 12.5px; color: var(--text-secondary); text-align: center; margin-bottom: 25px;
        }

        .alert-error {
            background: rgba(244, 63, 94, 0.15); border: 1px solid rgba(244, 63, 94, 0.4);
            color: var(--neon-rose); padding: 10px 14px; border-radius: 10px;
            font-size: 12.5px; font-weight: 700; text-align: center; margin-bottom: 20px;
            box-shadow: 0 0 12px rgba(244, 63, 94, 0.15);
        }
        .alert-success {
            background: rgba(16, 185, 129, 0.15); border: 1px solid rgba(16, 185, 129, 0.4);
            color: var(--neon-emerald); padding: 10px 14px; border-radius: 10px;
            font-size: 12.5px; font-weight: 700; text-align: center; margin-bottom: 20px;
            box-shadow: 0 0 12px rgba(16, 185, 129, 0.15);
        }

        .form-group {
            display: flex; flex-direction: column; gap: 6px; margin-bottom: 16px;
        }

        label {
            font-size: 11.5px; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 0.5px;
        }

        input {
            background: var(--input-bg); border: 1px solid var(--border-glass);
            border-radius: 10px; padding: 12px 15px; color: var(--text-primary);
            font-size: 14px; outline: none; transition: all 0.2s ease; width: 100%; box-sizing: border-box;
            backdrop-filter: blur(5px);
        }
        input::placeholder { color: var(--text-secondary); opacity: 0.85; }
        input:focus {
            border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.35);
            background: var(--card-surface);
        }
        /* keep typed text visible even when the browser autofills */
        input:-webkit-autofill,
        input:-webkit-autofill:focus {
            -webkit-text-fill-color: var(--text-primary);
            caret-color: var(--text-primary);
            transition: background-color 9999s ease-in-out 0s;
        }

        /* Password Eye Toggle Styling */
        .password-group {
            position: relative;
        }
        .password-group input { padding-right: 44px; }
        .toggle-password {
            position: absolute;
            top: 36px;
            right: 14px;
            background: none;
            border: none;
            color: var(--text-secondary);
            cursor: pointer;
            font-size: 1rem;
            transition: color 0.2s;
        }
        .toggle-password:hover {
            color: var(--neon-cyan);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff; border: 1px solid rgba(56, 189, 248, 0.4);
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            padding: 13px; border-radius: 11px;
            font-size: 13px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.6px; cursor: pointer; transition: all 0.25s ease;
            margin-top: 10px; box-sizing: border-box;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        /* ================= MOBILE: card covers the full screen ================= */
        @media (max-width: 600px) {
            body {
                padding: 0;
                align-items: stretch;
                justify-content: stretch;
            }
            .btn-back { top: 16px; left: 16px; padding: 9px 14px; }
            .auth-container {
                max-width: none;
                min-height: 100vh;
                min-height: 100dvh;
                border-radius: 0;
                border-left: none; border-right: none; border-bottom: none;
                padding: 84px 22px 32px;
                padding-bottom: calc(32px + env(safe-area-inset-bottom, 0px));
                display: flex; flex-direction: column; justify-content: center;
            }
            .auth-title { font-size: 21px; }
            .auth-subtitle { font-size: 13px; margin-bottom: 26px; }
            input { font-size: 16px; padding: 14px 15px; }
            .password-group input { padding-right: 50px; }
            .toggle-password { top: 28px; right: 6px; padding: 10px 12px; }
            .btn-submit { padding: 15px; font-size: 13.5px; }
        }

        /* very small phones */
        @media (max-width: 360px) {
            .auth-container { padding: 80px 16px 26px; }
            .auth-title { font-size: 19px; letter-spacing: 0.6px; }
        }

        /* phone in landscape (short height): start from top and scroll */
        @media (max-height: 520px) and (orientation: landscape) {
            body { align-items: stretch; }
            .auth-container { justify-content: flex-start; padding-top: 70px; }
            .btn-back { top: 12px; left: 12px; }
        }
    </style>
</head>
<body>

    <!-- Theme: follows the theme chosen on the home page (no toggle on this page) -->
    <script>
        (function () {
            var t = null;
            try { t = localStorage.getItem('promatch_theme') || localStorage.getItem('theme'); } catch (e) {}
            var dt = document.documentElement.getAttribute('data-theme');
            if (t === 'light' || dt === 'light') {
                document.body.classList.add('light-theme');
            }
        })();
    </script>

    <!-- Top Left Back Button -->
    <a href="${pageContext.request.contextPath}/home" class="btn-back">⬅ Back</a>

    <div class="auth-container">
        <div class="auth-title">🔑 Change Password</div>
        <div class="auth-subtitle">Update your account security credentials</div>

        <c:if test="${error != null}">
            <div class="alert-error">⚠️ ${error}</div>
        </c:if>
        <c:if test="${success != null}">
            <div class="alert-success">✨ ${success}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/change-password" method="post" id="changePasswordForm">
            
            <div class="form-group password-group">
                <label>Old Password</label>
                <input type="password" name="oldPassword" id="oldPasswordInput" placeholder="Enter old password" required>
                <button type="button" class="toggle-password" onclick="togglePassword('oldPasswordInput', 'oldIcon')">
                    <i class="fa-regular fa-eye" id="oldIcon"></i>
                </button>
            </div>

            <div class="form-group password-group">
                <label>New Password</label>
                <input type="password" name="newPassword" id="newPasswordInput" placeholder="Enter new password" required>
                <button type="button" class="toggle-password" onclick="togglePassword('newPasswordInput', 'newIcon')">
                    <i class="fa-regular fa-eye" id="newIcon"></i>
                </button>
            </div>

            <div class="form-group password-group">
                <label>Confirm New Password</label>
                <input type="password" name="confirmPassword" id="confirmPasswordInput" placeholder="Confirm new password" required>
                <button type="button" class="toggle-password" onclick="togglePassword('confirmPasswordInput', 'confirmIcon')">
                    <i class="fa-regular fa-eye" id="confirmIcon"></i>
                </button>
            </div>

            <button type="submit" class="btn-submit">Update</button>
        </form>
    </div>

    <script>
        function togglePassword(fieldId, iconId) {
            const input = document.getElementById(fieldId);
            const icon = document.getElementById(iconId);
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
</body>
</html>
