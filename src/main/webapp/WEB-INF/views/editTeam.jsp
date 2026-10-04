<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="editTeam" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit Team Control</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.85);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.25);
            --body-overlay: rgba(3, 7, 18, 0.82);
            --input-bg: rgba(3, 7, 18, 0.65);
            --input-text: #ffffff;
        }

        body.light-mode {
            --bg-deep: #f1f5f9;
            --card-surface: rgba(255, 255, 255, 0.94);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: #cbd5e1;
            --body-overlay: rgba(241, 245, 249, 0.82);
            --input-bg: #ffffff;
            --input-text: #0f172a;
        }

        * { box-sizing: border-box; }

        html, body { max-width: 100%; overflow-x: hidden; }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 60px 15px 14px 15px; 
            min-height: 100vh;
            min-height: 100dvh;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* Top-Left Back Button */
        .btn-top-left-back {
            position: absolute;
            top: 18px;
            left: 22px;
            background: rgba(14, 165, 233, 0.16);
            color: var(--neon-cyan);
            border: 2px solid var(--neon-cyan);
            padding: 9px 22px;
            border-radius: 14px;
            text-decoration: none;
            font-weight: 800;
            font-size: 15px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            box-shadow: 0 0 14px rgba(6, 182, 212, 0.25);
            transition: all 0.25s ease;
            z-index: 1000;
        }
        .btn-top-left-back:hover {
            background: var(--neon-cyan);
            color: #030712;
            transform: translateX(-3px);
            box-shadow: 0 0 20px rgba(6, 182, 212, 0.5);
        }
        body.light-mode .btn-top-left-back:hover { color: #ffffff; }

        /* Form container */
        .form-container {
            width: 100%;
            max-width: 640px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass);
            border-radius: 18px;
            padding: clamp(18px, 4.4vh, 44px) 34px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.4);
            position: relative;
            overflow: hidden;
            transition: background 0.3s ease, border-color 0.3s ease;
        }
        .form-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        h2 {
            text-align: center;
            color: var(--text-primary);
            margin-top: 0;
            margin-bottom: clamp(10px, 2.8vh, 28px);
            font-weight: 900;
            font-size: clamp(18px, 3.2vh, 26px);
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        h2 span { color: var(--neon-cyan); }

        .form-group {
            margin-bottom: clamp(10px, 2.4vh, 20px);
        }

        label {
            display: block;
            font-size: clamp(11px, 1.9vh, 13px);
            font-weight: 800;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.6px;
            margin-bottom: clamp(4px, 0.8vh, 8px);
        }

        input[type="text"],
        input[type="datetime-local"],
        input[type="number"],
        select {
            width: 100%;
            background: var(--input-bg);
            border: 1.5px solid var(--border-glass);
            border-radius: 10px;
            padding: clamp(10px, 2.4vh, 15px) 15px;
            color: var(--input-text);
            font-size: clamp(13px, 2.1vh, 15px);
            font-family: inherit;
            font-weight: 600;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }

        body.light-mode input[type="text"]::placeholder {
            color: #64748b;
            opacity: 1;
        }

        ::placeholder {
            color: var(--text-secondary);
            opacity: 0.8;
        }

        input:focus, select:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.25);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-row .form-group { min-width: 0; }

        .button-group {
            margin-top: clamp(15px, 2.8vh, 26px);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, var(--neon-cyan) 0%, #0284c7 100%);
            color: #030712;
            border: none;
            padding: clamp(11px, 2.4vh, 15px);
            border-radius: 10px;
            font-size: clamp(13px, 2.1vh, 15px);
            font-weight: 900;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }
        body.light-mode .btn-submit { color: #ffffff; }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
        }

        /* Mobile */
        @media(max-width: 768px) {
            body { padding: 54px 12px 12px 12px; }
            .btn-top-left-back { top: 12px; left: 14px; padding: 6px 15px; font-size: 13px; border-radius: 12px; gap: 8px; }
            .form-container { padding: clamp(14px, 2.8vh, 24px) 16px; max-width: 480px; }
            .form-row { gap: 10px; }
            .form-row.stack-mobile { grid-template-columns: 1fr; gap: 0; }
            h2 { font-size: clamp(15px, 2.7vh, 20px); margin-bottom: clamp(8px, 1.9vh, 16px); }
            .form-group { margin-bottom: clamp(8px, 1.5vh, 13px); }
            input[type="text"] { padding: clamp(8px, 1.65vh, 12px) 12px; font-size: clamp(12.5px, 1.9vh, 14px); border-radius: 8px; }
            label { font-size: clamp(10px, 1.6vh, 11.5px); margin-bottom: 4px; }
            .button-group { margin-top: clamp(10px, 1.8vh, 16px); }
            .btn-submit { padding: clamp(9px, 1.7vh, 13px); font-size: 13px; }
        }
    </style>
</head>
<body>

    <!-- Top-Left Back Button -->
    <a href="${pageContext.request.contextPath}/teams" class="btn-top-left-back"><i class="fa-solid fa-arrow-left"></i> Back</a>

    <div class="form-container">
        <h2><span>Edit</span> Team Record</h2>
        
        <form id="editTeamForm" action="${pageContext.request.contextPath}/updateTeam" method="post">
            <input type="hidden" name="id" value="${team.id}">

            <div class="form-row stack-mobile">
                <div class="form-group">
                    <label>Team Name</label>
                    <input type="text" id="teamName" name="teamName" value="${team.teamName}" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label>City</label>
                    <input type="text" id="city" name="city" value="${team.city}" required autocomplete="off">
                </div>
            </div>

            <div class="form-row stack-mobile">
                <div class="form-group">
                    <label>Coach Name</label>
                    <input type="text" id="coachName" name="coachName" value="${team.coachName}" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label>Owner Name</label>
                    <input type="text" id="ownerName" name="ownerName" value="${team.ownerName}" required autocomplete="off">
                </div>
            </div>

            <div class="form-group">
                <label>Logo URL</label>
                <input type="text" id="logoUrl" name="logoUrl" value="${team.logoUrl}" autocomplete="off">
            </div>

            <div class="button-group">
                <button type="submit" class="btn-submit">💾 Update Team</button>
            </div>
        </form>
    </div>

    <script>
        // Synchronize theme seamlessly with other pages using localStorage keys
        if (localStorage.getItem('matchTheme') === 'light' || localStorage.getItem('promatch_theme') === 'light') {
            document.body.classList.add('light-mode');
        } else {
            document.body.classList.remove('light-mode');
        }
    </script>

</body>
</html>