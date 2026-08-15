<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>ProMatch Arena | Edit Team Control</title>
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.72);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.82);
        }

        body.light-mode {
            --bg-deep: #f8fafc;
            --card-surface: rgba(255, 255, 255, 0.82);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: rgba(2, 132, 199, 0.25);
            --body-overlay: rgba(241, 245, 249, 0.82);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 35px 20px 60px 20px; 
            transition: background 0.3s ease, color 0.3s ease;
        }
        
        .header-bar { 
            display: flex; justify-content: space-between; align-items: center; 
            max-width: 850px; margin: 0 auto 30px auto; 
            background: var(--card-surface); backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 16px 28px; border-radius: 18px; border: 1px solid var(--border-glass);
            box-shadow: 0 20px 40px rgba(0,0,0,0.3);
        }
        
        .header-left { display: flex; align-items: center; gap: 15px; }

        .btn-back { background: rgba(56, 189, 248, 0.08); color: var(--neon-cyan); border: 1px solid var(--border-glass); padding: 9px 18px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s ease; }
        .btn-back:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }
        
        .btn-theme-toggle {
            background: var(--card-surface); color: var(--text-primary);
            border: 1px solid var(--border-glass); padding: 9px 15px;
            border-radius: 10px; font-weight: 700; font-size: 13px;
            cursor: pointer; display: inline-flex; align-items: center; gap: 6px;
            transition: all 0.2s ease;
        }
        .btn-theme-toggle:hover { border-color: var(--neon-cyan); color: var(--neon-cyan); }

        .jumping-title {
            text-align: center; color: var(--text-primary); margin: 0; font-weight: 900; font-size: 20px; letter-spacing: 1.5px; text-transform: uppercase;
            display: inline-block;
            white-space: nowrap;
        }
        .jumping-title span {
            display: inline-block;
            opacity: 0;
            transform: translateY(-25px);
            animation: dropInChar 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.04s * var(--i));
        }
        .jumping-title span.highlight {
            color: var(--neon-cyan);
            text-shadow: 0 0 15px rgba(56, 189, 248, 0.6);
        }

        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-25px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .form-container-card {
            max-width: 850px;
            margin: 0 auto;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 40px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 24px;
        }
        @media(max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .form-group.full-width {
            grid-column: 1 / -1;
        }

        .form-label {
            font-size: 12px;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--text-secondary);
        }

        .form-input {
            background: rgba(3, 7, 18, 0.45);
            border: 1px solid var(--border-glass);
            border-radius: 12px;
            padding: 12px 16px;
            color: var(--text-primary);
            font-size: 14px;
            font-family: inherit;
            outline: none;
            transition: all 0.2s ease;
        }
        .form-input:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.25);
            background: rgba(3, 7, 18, 0.7);
        }

        .form-actions-row {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 35px;
            border-top: 1px solid var(--border-glass);
            padding-top: 25px;
        }

        .btn-submit {
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            padding: 12px 28px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            transition: all 0.25s ease;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .btn-cancel {
            background: rgba(255, 255, 255, 0.05);
            color: var(--text-primary);
            border: 1px solid var(--border-glass);
            padding: 12px 22px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 800;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: all 0.25s ease;
        }
        .btn-cancel:hover {
            border-color: var(--neon-cyan);
            color: var(--neon-cyan);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

    <div class="header-bar">
        <div class="header-left">
            <a href="/viewTeam" class="btn-back">⬅ Back to Teams</a>
        </div>
        
        <div>
            <h2 class="jumping-title" id="animatedTitle">Edit Team Record</h2>
        </div>

        <button class="btn-theme-toggle" id="themeToggleBtn" onclick="toggleTheme()">🌙 Dark Mode</button>
    </div>

    <div class="form-container-card">
        <form id="editTeamForm" action="/updateTeam" method="post">
            <input type="hidden" name="id" value="${team.id}">
            
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Team Name</label>
                    <input type="text" id="teamName" name="teamName" class="form-input" value="${team.teamName}" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label">City</label>
                    <input type="text" id="city" name="city" class="form-input" value="${team.city}" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label">Coach Name</label>
                    <input type="text" id="coachName" name="coachName" class="form-input" value="${team.coachName}" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label class="form-label">Owner Name</label>
                    <input type="text" id="ownerName" name="ownerName" class="form-input" value="${team.ownerName}" required autocomplete="off">
                </div>

                <div class="form-group full-width">
                    <label class="form-label">Logo URL</label>
                    <input type="text" id="logoUrl" name="logoUrl" class="form-input" value="${team.logoUrl}" autocomplete="off">
                </div>
            </div>

            <div class="form-actions-row">
                <a href="/viewTeam" class="btn-cancel">Cancel</a>
                <button type="submit" class="btn-submit">💾 Update Team</button>
            </div>
        </form>
    </div>

    <script>
        window.addEventListener('DOMContentLoaded', function() {
            const titleEl = document.getElementById('animatedTitle');
            if (titleEl) {
                const textWords = titleEl.innerText;
                titleEl.innerHTML = textWords.split('').map(function(char, index) {
                    if (char === ' ') return '<span style="--i:' + index + '">&nbsp;</span>';
                    let highlightClass = (index < 4) ? 'highlight' : '';
                    return '<span class="' + highlightClass + '" style="--i:' + index + '">' + char + '</span>';
                }).join('');
            }
        });

        const bodyElement = document.body;
        const themeToggleBtn = document.getElementById('themeToggleBtn');

        if (localStorage.getItem('matchTheme') === 'light') {
            bodyElement.classList.add('light-mode');
            if(themeToggleBtn) themeToggleBtn.innerHTML = '☀️ Light Mode';
        }

        function toggleTheme() {
            if (bodyElement.classList.contains('light-mode')) {
                bodyElement.classList.remove('light-mode');
                localStorage.setItem('matchTheme', 'dark');
                if(themeToggleBtn) themeToggleBtn.innerHTML = '🌙 Dark Mode';
            } else {
                bodyElement.classList.add('light-mode');
                localStorage.setItem('matchTheme', 'light');
                if(themeToggleBtn) themeToggleBtn.innerHTML = '☀️ Light Mode';
            }
        }
    </script>

</body>
</html>