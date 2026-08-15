<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit User Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.92);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.94);
            --input-bg: rgba(3, 7, 18, 0.75);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 40px 20px; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            box-sizing: border-box;
        }

        /* Top-Left Floating Back Button */
        .top-back-btn {
            position: absolute;
            top: 25px;
            left: 25px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            color: var(--neon-cyan);
            border: 1px solid var(--border-glass);
            padding: 10px 18px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: all 0.2s ease;
            z-index: 100;
        }
        .top-back-btn:hover {
            background: var(--neon-cyan);
            color: #030712;
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.5);
        }

        .form-container {
            width: 100%;
            max-width: 520px;
            background: var(--card-surface);
            backdrop-filter: blur(22px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 35px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            position: relative;
            overflow: hidden;
            box-sizing: border-box;
            margin-top: 20px;
        }
        .form-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .form-header {
            margin-bottom: 25px;
            text-align: center;
        }

        .jumping-title {
            color: var(--text-primary); margin: 0; font-weight: 900; font-size: 22px; letter-spacing: 1px; text-transform: uppercase;
        }
        .jumping-title span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-size: 12.5px;
            font-weight: 700;
            color: var(--text-secondary);
            margin-bottom: 8px;
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
            left: 14px;
            color: var(--neon-cyan);
            font-size: 14px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"],
        select {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border-glass);
            border-radius: 12px;
            padding: 12px 14px 12px 42px;
            color: var(--text-primary);
            font-size: 14px;
            font-family: inherit;
            outline: none;
            transition: all 0.2s ease;
            box-sizing: border-box;
        }

        /* Password right icon (Eye Toggle) */
        .toggle-password {
            position: absolute;
            right: 14px;
            color: var(--text-secondary);
            cursor: pointer;
            font-size: 14px;
            transition: color 0.2s;
        }
        .toggle-password:hover {
            color: var(--neon-cyan);
        }

        select {
            appearance: none;
            cursor: pointer;
        }

        input:focus, select:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.3);
        }

        .button-group {
            display: flex;
            gap: 12px;
            margin-top: 15px;
        }

        .btn-submit {
            flex: 1;
            background: linear-gradient(135deg, var(--neon-cyan), #0284c7);
            color: #030712;
            border: none;
            padding: 13px;
            border-radius: 12px;
            font-weight: 800;
            font-size: 13.5px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 5px 20px rgba(56, 189, 248, 0.35);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(56, 189, 248, 0.55);
        }

        .btn-clear {
            flex: 1;
            background: rgba(244, 63, 94, 0.1);
            color: var(--neon-rose);
            border: 1px solid rgba(244, 63, 94, 0.3);
            padding: 13px;
            border-radius: 12px;
            font-weight: 800;
            font-size: 13.5px;
            cursor: pointer;
            transition: all 0.2s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }
        .btn-clear:hover {
            background: var(--neon-rose);
            color: #030712;
            box-shadow: 0 0 15px rgba(244, 63, 94, 0.4);
            transform: translateY(-2px);
        }
    </style>
    <script>
        function togglePasswordVisibility() {
            let passwordInput = document.getElementById('passwordField');
            let eyeIcon = document.getElementById('eyeIcon');
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                eyeIcon.classList.remove('fa-eye');
                eyeIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                eyeIcon.classList.remove('fa-eye-slash');
                eyeIcon.classList.add('fa-eye');
            }
        }

        function clearForm() {
            document.getElementById('editUserForm').reset();
        }
    </script>
</head>
<body>

    <!-- Top Left Floating Back Button -->
    <a href="/admin/users" class="top-back-btn"><i class="fa-solid fa-arrow-left"></i> Back to Users</a>

    <div class="form-container">
        <div class="form-header">
            <h2 class="jumping-title">Edit <span>User</span></h2>
        </div>
        
        <form id="editUserForm" action="/admin/updateUser" method="post">
            <input type="hidden" name="id" value="${user.id}">
            
            <div class="form-group">
                <label>Full Name</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-user"></i>
                    <input type="text" name="name" value="${user.name}" required placeholder="Enter full name">
                </div>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-envelope"></i>
                    <input type="email" name="email" value="${user.email}" required placeholder="Enter email address">
                </div>
            </div>

            <div class="form-group">
                <label>Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock"></i>
                    <input type="password" id="passwordField" name="password" value="${user.password}" required placeholder="Enter password">
                    <i class="fa-solid fa-eye toggle-password" id="eyeIcon" onclick="togglePasswordVisibility()" title="Show/Hide Password"></i>
                </div>
            </div>

            <div class="form-group">
                <label>Phone Number</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-phone"></i>
                    <input type="text" name="phone" value="${user.phone}" placeholder="Enter phone number">
                </div>
            </div>

            <div class="form-group">
                <label>System Role</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-shield-halved"></i>
                    <select name="role">
                        <option value="USER" ${user.role == 'USER' ? 'selected' : ''}>USER</option>
                        <option value="ADMIN" ${user.role == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                    </select>
                </div>
            </div>
            
            <div class="button-group">
                <button type="button" class="btn-clear" onclick="clearForm()"><i class="fa-solid fa-rotate-right"></i> Clear</button>
                <button type="submit" class="btn-submit"><i class="fa-solid fa-floppy-disk"></i> Update</button>
            </div>
        </form>
    </div>

</body>
</html>