<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
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

        body.light-theme {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.88);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --border-glass: rgba(2, 132, 199, 0.25);
            --body-overlay: rgba(241, 245, 249, 0.82);
            --input-bg: rgba(255, 255, 255, 0.85);
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
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* Top Controls */
        .top-back-btn {
            position: absolute; top: 25px; left: 25px;
            background: var(--card-surface); backdrop-filter: blur(15px);
            color: var(--neon-cyan); border: 1px solid var(--border-glass);
            padding: 10px 18px; border-radius: 12px; text-decoration: none;
            font-weight: 700; font-size: 13px; display: inline-flex; align-items: center; gap: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3); transition: all 0.2s ease; z-index: 100;
            cursor: pointer;
        }
        .top-back-btn:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }

        .theme-toggle-btn {
            position: absolute; top: 25px; right: 25px;
            background: var(--card-surface); backdrop-filter: blur(15px);
            color: var(--text-primary); border: 1px solid var(--border-glass);
            padding: 10px 16px; border-radius: 12px; font-size: 13px; font-weight: 700;
            cursor: pointer; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3); z-index: 100;
        }
        .theme-toggle-btn:hover { border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.4); }

        .form-container {
            width: 100%;
            max-width: 540px;
            background: var(--card-surface);
            backdrop-filter: blur(18px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 35px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.45);
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
            color: var(--text-primary); margin: 0 0 5px 0; font-weight: 900; font-size: 22px; letter-spacing: 1px; text-transform: uppercase;
        }
        .jumping-title span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }
        .subtitle { color: var(--text-secondary); font-size: 13px; margin: 0; }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-secondary);
            margin-bottom: 6px;
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
        input[type="number"] {
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

        input:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.3);
        }

        /* Full Width Single Button Structure */
        .form-actions {
            margin-top: 25px;
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, var(--neon-cyan), #0284c7);
            color: #030712;
            border: none;
            padding: 14px;
            border-radius: 12px;
            font-weight: 800;
            font-size: 13px;
            cursor: pointer;
            transition: all 0.2s ease;
            box-shadow: 0 5px 20px rgba(56, 189, 248, 0.35);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-transform: uppercase;
            letter-spacing: 0.8px;
            box-sizing: border-box;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(56, 189, 248, 0.55);
            background: linear-gradient(135deg, #38bdf8 0%, #0369a1 100%);
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                let btn = document.getElementById('themeBtnText');
                if(btn) btn.innerText = 'Light';
            }
        });

        function toggleTheme() {
            document.body.classList.toggle('light-theme');
            let btn = document.getElementById('themeToggleBtn');
            if (document.body.classList.contains('light-theme')) {
                localStorage.setItem('promatch_theme', 'light');
                btn.innerHTML = '☀️ <span id="themeBtnText">Light</span>';
            } else {
                localStorage.setItem('promatch_theme', 'dark');
                btn.innerHTML = '🌙 <span id="themeBtnText">Dark</span>';
            }
        }
    </script>
</head>
<body>

    <!-- Top Left Floating Back Button -->
    <button onclick="history.back()" class="top-back-btn"><i class="fa-solid fa-arrow-left"></i> Back</button>

    <!-- Top Right Theme Toggle Button -->
    <button class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()">
        🌙 <span id="themeBtnText">Dark</span>
    </button>

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

</body>
</html>