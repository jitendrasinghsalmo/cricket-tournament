<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit Team</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #07090e;
            --card-surface: #0e121c;
            --card-hover: #141a28;
            --accent-red: #ff3366;
            --accent-green: #00ffcc;
            --accent-blue: #00d2ff;
            --text-main: #f1f5f9;
            --text-muted: #94a3b8;
            --border-color: #1e293b;
        }

        body.light-theme {
            --bg-deep: #f1f5f9;
            --card-surface: #ffffff;
            --card-hover: #f8fafc;
            --accent-red: #e11d48;
            --accent-green: #059669;
            --accent-blue: #0284c7;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --border-color: #cbd5e1;
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background-color: var(--bg-deep);
            color: var(--text-main); 
            margin: 0; 
            min-height: 100vh;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        /* TOP COMMAND BAR */
        .command-bar {
            background: var(--card-surface);
            border-bottom: 1px solid var(--border-color);
            padding: 12px 35px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .command-left, .command-right {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .command-link {
            color: var(--text-muted);
            text-decoration: none;
            font-size: 13px;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            transition: color 0.2s;
            background: transparent;
            border: none;
            cursor: pointer;
            padding: 0;
        }

        .command-link:hover {
            color: var(--text-main);
        }

        /* CONTAINER */
        .container {
            max-width: 900px;
            margin: 35px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        /* PAGE HEADER */
        .section-header {
            margin-bottom: 25px;
        }

        .section-header h1 {
            font-size: 26px;
            font-weight: 900;
            letter-spacing: 1.5px;
            margin: 0;
            text-transform: uppercase;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-green), var(--accent-red), var(--accent-blue));
            background-size: 300% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: waveShimmer 5s linear infinite;
        }

        @keyframes waveShimmer {
            0% { background-position: 0% center; }
            100% { background-position: 300% center; }
        }

        /* GLASSMORPHIC FORM CARD */
        .form-card {
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 18px;
            padding: 30px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
        }

        .form-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        label {
            font-size: 12px;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-weight: 700;
            color: var(--text-muted);
            display: flex;
            align-items: center;
            gap: 8px;
            white-space: nowrap;
        }

        label i {
            width: 18px;
            text-align: center;
            font-size: 14px;
            flex-shrink: 0;
            color: var(--accent-blue);
        }

        input[type="text"] {
            background: var(--bg-deep);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 12px 15px;
            color: var(--text-main);
            font-size: 13.5px;
            outline: none;
            width: 100%;
            box-sizing: border-box;
            transition: border-color 0.2s, box-shadow 0.2s;
        }

        input[type="text"]:focus {
            border-color: var(--accent-blue);
            box-shadow: 0 0 10px rgba(0, 210, 255, 0.15);
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 15px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid var(--border-color);
        }

        .btn-submit {
            background: var(--accent-blue);
            color: #07090e;
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.3);
            transition: transform 0.2s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
        }

        .btn-clear {
            background: rgba(255, 51, 102, 0.1);
            color: var(--accent-red);
            border: 1px solid rgba(255, 51, 102, 0.3);
            padding: 12px 20px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13.5px;
            cursor: pointer;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.2s;
        }

        .btn-clear:hover {
            background: var(--accent-red);
            color: #fff;
        }

        @media(max-width: 768px) {
            .form-grid { grid-template-columns: 1fr; }
            .form-group.full-width { grid-column: span 1; }
        }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                let btnText = document.getElementById('themeBtnText');
                if(btnText) btnText.innerText = 'Light Mode';
            }
        });

        function toggleTheme() {
            document.body.classList.toggle('light-theme');
            let btnText = document.getElementById('themeBtnText');
            if (document.body.classList.contains('light-theme')) {
                localStorage.setItem('promatch_theme', 'light');
                if(btnText) btnText.innerText = 'Light Mode';
            } else {
                localStorage.setItem('promatch_theme', 'dark');
                if(btnText) btnText.innerText = 'Dark Mode';
            }
        }

        function clearForm(formElement) {
            formElement.querySelectorAll('input[type="text"]').forEach(input => {
                input.value = '';
            });
            return false;
        }
    </script>
</head>
<body>

    <!-- TOP COMMAND BAR -->
    <div class="command-bar">
        <div class="command-left">
            <a href="/admin/teams" class="command-link"><i class="fa-solid fa-arrow-left"></i> Back to Teams</a>
        </div>
        <div class="command-right">
            <button onclick="toggleTheme()" class="command-link"><i class="fa-solid fa-circle-half-stroke"></i> <span id="themeBtnText">Dark Mode</span></button>
        </div>
    </div>

    <div class="container">

        <div class="section-header">
            <h1>Edit Team Details (#TEAM-${team.id})</h1>
        </div>

        <div class="form-card">
            <form action="/admin/updateTeam" method="post" id="editTeamForm">
                <input type="hidden" name="id" value="${team.id}">

                <div class="form-grid">
                    
                    <!-- Team Name -->
                    <div class="form-group full-width">
                        <label><i class="fa-solid fa-shield-halved"></i> Team Name</label>
                        <input type="text" name="teamName" value="${team.teamName}" placeholder="Enter team name" required>
                    </div>

                    <!-- City -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-location-dot"></i> City</label>
                        <input type="text" name="city" value="${team.city}" placeholder="Enter city name" required>
                    </div>

                    <!-- Coach Name -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-user-tie"></i> Coach Name</label>
                        <input type="text" name="coachName" value="${team.coachName}" placeholder="Enter coach name" required>
                    </div>

                    <!-- Owner Name -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-user-shield"></i> Owner Name</label>
                        <input type="text" name="ownerName" value="${team.ownerName}" placeholder="Enter owner name" required>
                    </div>

                    <!-- Logo URL -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-image"></i> Logo URL</label>
                        <input type="text" name="logoUrl" value="${team.logoUrl}" placeholder="Enter image URL">
                    </div>

                </div>

                <div class="form-actions">
                    <button type="button" class="btn-clear" onclick="return clearForm(document.getElementById('editTeamForm'));"><i class="fa-solid fa-eraser"></i> Clear</button>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-check"></i> Update Team</button>
                </div>
            </form>
        </div>

    </div>
</body>
</html>