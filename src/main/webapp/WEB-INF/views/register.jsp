<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | User Registration</title>

    <!-- Theme apply (runs immediately, no flash) - same key as navbar.jsp -->
    <script>
        (function () {
            try {
                if (localStorage.getItem('promatch_theme') === 'light') {
                    document.documentElement.setAttribute('data-theme', 'light');
                }
            } catch (e) {}
        })();
    </script>

    <!-- FontAwesome for Eye Icon -->
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

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            display: flex; justify-content: center; align-items: center;
            min-height: 100vh; min-height: 100dvh; padding: 10px; box-sizing: border-box;
        }

        .auth-container {
            width: 100%; max-width: 420px;
            background: var(--card-surface); backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass); border-radius: 22px;
            padding: 22px 32px; box-shadow: 0 30px 60px rgba(0,0,0,0.45);
            position: relative; overflow: hidden;
        }
        .auth-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .auth-title {
            font-size: 22px; font-weight: 900; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 1px; margin-bottom: 4px;
            text-align: center;
        }
        .auth-subtitle {
            font-size: 12.5px; color: var(--text-secondary); text-align: center; margin-bottom: 14px;
        }

        .form-group {
            display: flex; flex-direction: column; gap: 4px; margin-bottom: 10px;
        }

        label {
            font-size: 11.5px; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 0.5px;
        }

        input {
            background: var(--input-bg); border: 1px solid var(--border-glass);
            border-radius: 10px; padding: 9px 14px; color: var(--text-primary);
            font-size: 14px; outline: none; transition: all 0.2s ease; width: 100%; box-sizing: border-box;
            backdrop-filter: blur(5px);
        }
        input:focus {
            border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.35);
            background: var(--card-surface);
        }

        /* Password Eye Toggle Styling */
        .password-group {
            position: relative;
        }
        .toggle-password {
            position: absolute;
            top: 27px;
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
            padding: 11px; border-radius: 11px;
            font-size: 13px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.6px; cursor: pointer; transition: all 0.25s ease;
            margin-top: 4px; box-sizing: border-box;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .auth-footer-text {
            text-align: center; margin-top: 12px; font-size: 12.5px; color: var(--text-secondary);
        }
        .auth-footer-text a {
            color: var(--neon-cyan); font-weight: 700; text-decoration: none; transition: 0.2s;
        }
        .auth-footer-text a:hover { text-decoration: underline; text-shadow: 0 0 10px rgba(56, 189, 248, 0.4); }

        /* Mobile responsive */
        @media (max-width: 480px) {
            body { padding: 8px; }
            .auth-container { padding: 18px 20px; border-radius: 18px; }
            .auth-title { font-size: 19px; }
            .auth-subtitle { font-size: 12px; margin-bottom: 12px; }
            input { font-size: 16px; } /* prevents zoom on iOS */
            .toggle-password { top: 28px; }
        }

        /* Short screens (small phones / landscape) */
        @media (max-height: 560px) {
            body { padding: 6px; }
            .auth-container { padding: 14px 20px; }
            .auth-title { font-size: 17px; margin-bottom: 2px; }
            .auth-subtitle { margin-bottom: 8px; font-size: 11.5px; }
            .form-group { margin-bottom: 6px; gap: 3px; }
            label { font-size: 10.5px; }
            input { padding: 7px 12px; }
            .toggle-password { top: 22px; }
            .btn-submit { padding: 9px; margin-top: 2px; }
            .auth-footer-text { margin-top: 8px; font-size: 12px; }
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
        input::placeholder { color: var(--text-secondary); opacity: 0.8; }
    </style>
</head>
<body>

    <div class="auth-container">
        <div class="auth-title">🚀 Create Account</div>
        <div class="auth-subtitle">Join ProMatch Arena to manage your tournaments</div>

        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" name="name" placeholder="Enter your full name" required autocomplete="off">
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <input type="email" name="email" placeholder="Enter your email" required autocomplete="off">
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <input type="text" name="phone" placeholder="Enter phone number" required autocomplete="off">
            </div>

            <div class="form-group password-group">
                <label>Password</label>
                <input type="password" name="password" id="passwordInput" placeholder="Create a strong password" required>
                <button type="button" class="toggle-password" onclick="togglePassword()">
                    <i class="fa-regular fa-eye" id="toggleIcon"></i>
                </button>
            </div>

            <button type="submit" class="btn-submit">Register</button>
        </form>

        <div class="auth-footer-text">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Login here</a>
        </div>
    </div>

    <script>
        function togglePassword() {
            const input = document.getElementById('passwordInput');
            const icon = document.getElementById('toggleIcon');
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
