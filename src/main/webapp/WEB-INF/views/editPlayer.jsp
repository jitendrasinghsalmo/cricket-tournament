<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="editPlayer" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit Player Profile</title>
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
            max-width: 620px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1.5px solid var(--border-glass);
            border-radius: 18px;
            padding: clamp(16px, 4vh, 40px) 34px;
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
            margin-bottom: clamp(9px, 2.6vh, 26px);
            font-weight: 900;
            font-size: clamp(16px, 3vh, 23px);
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        h2 span { color: var(--neon-cyan); }

        .form-group {
            margin-bottom: clamp(7px, 2.2vh, 18px);
        }

        label {
            display: block;
            font-size: clamp(10.5px, 1.8vh, 12.5px);
            font-weight: 800;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: clamp(3px, 0.8vh, 6px);
        }

        input[type="text"],
        input[type="datetime-local"],
        input[type="number"],
        select {
            width: 100%;
            background: var(--input-bg);
            border: 1.5px solid var(--border-glass);
            border-radius: 10px;
            padding: clamp(7px, 2.2vh, 15px) 14px;
            color: var(--input-text);
            font-size: clamp(12.5px, 2vh, 14.5px);
            font-family: inherit;
            font-weight: 600;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }

        body.light-mode input[type="text"]::placeholder,
        body.light-mode input[type="number"]::placeholder {
            color: #64748b;
            opacity: 1;
        }

        ::placeholder {
            color: var(--text-secondary);
            opacity: 0.8;
        }

        select option {
            background: #030712;
            color: #ffffff;
            padding: 10px;
        }
        body.light-mode select option {
            background: #ffffff;
            color: #0f172a;
        }

        input:focus, select:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.25);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
        }

        .form-row .form-group { min-width: 0; }

        .button-group {
            margin-top: clamp(9px, 2.6vh, 24px);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, var(--neon-cyan) 0%, #0284c7 100%);
            color: #030712;
            border: none;
            padding: clamp(9px, 2.2vh, 15px);
            border-radius: 10px;
            font-size: clamp(12.5px, 2vh, 14.5px);
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
            .form-container { padding: clamp(12px, 2.6vh, 22px) 15px; max-width: 480px; }
            .form-row { gap: 10px; }
            .form-row.stack-mobile { grid-template-columns: 1fr; gap: 0; }
            h2 { font-size: clamp(14.5px, 2.6vh, 19px); margin-bottom: clamp(7px, 1.7vh, 14px); }
            .form-group { margin-bottom: clamp(4px, 1.35vh, 12px); }
            input[type="text"],
            input[type="datetime-local"],
            input[type="number"],
            select { padding: clamp(5px, 1.55vh, 10px) 10px; font-size: clamp(12px, 1.8vh, 13.5px); border-radius: 8px; }
            label { font-size: clamp(9px, 1.4vh, 10.5px); margin-bottom: 2px; }
            .button-group { margin-top: clamp(7px, 1.6vh, 14px); }
            .btn-submit { padding: clamp(8px, 1.6vh, 11px); font-size: 13px; }
        }
    </style>
</head>
<body>

    <!-- Top-Left Back Button -->
    <a href="javascript:history.back()" class="btn-top-left-back"><i class="fa-solid fa-arrow-left"></i> Back</a>

    <div class="form-container">
        <h2>⚡ <span>Edit</span> Player Profile</h2>

        <form action="${pageContext.request.contextPath}/updatePlayer" method="post">
            <input type="hidden" name="id" value="${player.id}">
            <input type="hidden" name="teamId" value="${teamId}">

            <div class="form-group">
                <label>Player Full Name</label>
                <input type="text" name="playerName" value="${player.playerName}" placeholder="Enter player name" required autocomplete="off">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Age</label>
                    <input type="number" name="age" value="${player.age}" placeholder="Enter age" min="10" max="60" required>
                </div>

                <div class="form-group">
                    <label>Jersey Number</label>
                    <input type="number" name="jerseyNumber" value="${player.jerseyNumber}" placeholder="Enter jersey number" min="0" max="999" required>
                </div>
            </div>

            <div class="form-group">
                <label>Player Role</label>
                <select name="role" required>
                    <option value="BATSMAN" ${player.role.name() == 'BATSMAN' ? 'selected' : ''}>Batsman</option>
                    <option value="BOWLER" ${player.role.name() == 'BOWLER' ? 'selected' : ''}>Bowler</option>
                    <option value="ALL_ROUNDER" ${player.role.name() == 'ALL_ROUNDER' ? 'selected' : ''}>All-Rounder</option>
                    <option value="WICKET_KEEPER" ${player.role.name() == 'WICKET_KEEPER' ? 'selected' : ''}>Wicket-Keeper</option>
                </select>
            </div>

            <div class="form-row stack-mobile">
                <div class="form-group">
                    <label>Batting Style</label>
                    <select name="battingStyle" required>
                        <option value="Right-hand bat" ${player.battingStyle == 'Right-hand bat' ? 'selected' : ''}>Right-hand bat</option>
                        <option value="Left-hand bat" ${player.battingStyle == 'Left-hand bat' ? 'selected' : ''}>Left-hand bat</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>Bowling Style</label>
                    <select name="bowlingStyle" required>
                        <option value="Right-arm fast" ${player.bowlingStyle == 'Right-arm fast' ? 'selected' : ''}>Right-arm fast</option>
                        <option value="Left-arm fast" ${player.bowlingStyle == 'Left-arm fast' ? 'selected' : ''}>Left-arm fast</option>
                        <option value="Right-arm offbreak" ${player.bowlingStyle == 'Right-arm offbreak' ? 'selected' : ''}>Right-arm offbreak</option>
                        <option value="Legbreak googly" ${player.bowlingStyle == 'Legbreak googly' ? 'selected' : ''}>Legbreak googly</option>
                        <option value="None" ${player.bowlingStyle == 'None' ? 'selected' : ''}>None</option>
                    </select>
                </div>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-submit">💾 Save Changes</button>
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