<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Registration Successful</title>
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
            --meta-box-bg: rgba(3, 7, 18, 0.6);
        }

        body.light-theme {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.95);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --text-primary: #0f172a;
            --text-secondary: #64748b;
            --border-glass: rgba(2, 132, 199, 0.22);
            --body-overlay: rgba(241, 245, 249, 0.96);
            --meta-box-bg: rgba(248, 250, 252, 0.9);
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

        .success-card {
            width: 100%;
            max-width: 500px;
            background: var(--card-surface);
            backdrop-filter: blur(22px);
            border: 1px solid rgba(16, 185, 129, 0.3); /* Emerald border for success */
            border-radius: 24px;
            padding: 40px 35px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5), 0 0 40px rgba(16, 185, 129, 0.1);
            position: relative;
            overflow: hidden;
            box-sizing: border-box;
            text-align: center;
        }
        
        /* Top glowing line */
        .success-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 5px;
            background: linear-gradient(90deg, #059669, var(--neon-emerald), #34d399);
        }

        /* Animated Icon */
        .icon-container {
            width: 80px; height: 80px; margin: 0 auto 20px auto;
            background: rgba(16, 185, 129, 0.15); border: 2px solid var(--neon-emerald);
            border-radius: 50%; display: flex; align-items: center; justify-content: center;
            font-size: 35px; color: var(--neon-emerald);
            animation: pulse-glow 2s infinite;
        }

        @keyframes pulse-glow {
            0% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0.5); }
            70% { box-shadow: 0 0 0 20px rgba(16, 185, 129, 0); }
            100% { box-shadow: 0 0 0 0 rgba(16, 185, 129, 0); }
        }

        .jumping-title { color: var(--text-primary); margin: 0 0 10px 0; font-weight: 900; font-size: 24px; text-transform: uppercase; letter-spacing: 1px; }
        .jumping-title span { color: var(--neon-emerald); text-shadow: 0 0 15px rgba(16, 185, 129, 0.5); }
        .subtitle { color: var(--text-secondary); font-size: 14px; margin: 0 0 25px 0; font-weight: 500; line-height: 1.5; }
        .subtitle strong { color: var(--text-primary); }

        /* Receipt Box */
        .receipt-box {
            background: var(--meta-box-bg); border: 1px dashed rgba(16, 185, 129, 0.3);
            border-radius: 16px; padding: 20px; margin-bottom: 30px;
            display: flex; flex-direction: column; gap: 12px; text-align: left;
        }

        .receipt-row { display: flex; justify-content: space-between; align-items: center; font-size: 13.5px; }
        .receipt-label { color: var(--text-secondary); font-weight: 600; }
        .receipt-val { color: var(--text-primary); font-weight: 800; font-family: monospace; font-size: 14.5px; }
        
        .status-badge {
            background: rgba(16, 185, 129, 0.15); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3);
            padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 800; text-transform: uppercase;
        }

        /* Action Button */
        .btn-action {
            width: 100%; display: inline-flex; align-items: center; justify-content: center; gap: 10px;
            background: linear-gradient(135deg, var(--neon-cyan), #0284c7); color: #030712;
            border: none; padding: 15px; border-radius: 14px; font-weight: 900; font-size: 15px;
            cursor: pointer; transition: all 0.25s ease; text-decoration: none; text-transform: uppercase;
            box-shadow: 0 5px 20px rgba(56, 189, 248, 0.35); letter-spacing: 0.5px;
        }
        .btn-action:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(56, 189, 248, 0.55); }

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
    <a href="/home" class="top-back-btn"><i class="fa-solid fa-house"></i> Home</a>

    <!-- Top Right Theme Toggle Button -->
    <button class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()">
        🌙 <span id="themeBtnText">Dark</span>
    </button>

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
            <hr style="border: none; border-top: 1px dashed var(--border-glass); margin: 2px 0;">
            <div class="receipt-row">
                <span class="receipt-label">Razorpay TXN ID</span>
                <span class="receipt-val" style="color: var(--neon-cyan);">${paymentId}</span>
            </div>
            <hr style="border: none; border-top: 1px dashed var(--border-glass); margin: 2px 0;">
            <div class="receipt-row">
                <span class="receipt-label">Status</span>
                <span class="status-badge"><i class="fa-solid fa-shield-check"></i> Registered</span>
            </div>
        </div>

        <a href="${pageContext.request.contextPath}/viewTeam" class="btn-action">
            <i class="fa-solid fa-users-rectangle"></i> View All Teams
        </a>

    </div>

</body>
</html>