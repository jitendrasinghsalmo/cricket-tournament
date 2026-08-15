<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ProMatch Arena | Edit Player Profile</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.82);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.85);
            --input-bg: rgba(3, 7, 18, 0.6);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 40px 20px; 
        }

        .form-container {
            max-width: 750px; margin: 0 auto;
            background: var(--card-surface); backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass); border-radius: 20px;
            padding: 30px 35px; box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            position: relative; overflow: hidden;
        }
        .form-container::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .form-top-bar {
            display: flex; align-items: center; justify-content: space-between;
            margin-bottom: 25px; padding-bottom: 15px; border-bottom: 1px solid var(--border-glass);
        }

        .btn-back-inline {
            background: rgba(56, 189, 248, 0.08); color: var(--neon-cyan);
            border: 1px solid var(--border-glass); padding: 7px 14px;
            border-radius: 8px; text-decoration: none; font-weight: 700;
            font-size: 12.5px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
        }
        .btn-back-inline:hover {
            background: var(--neon-cyan); color: #030712;
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.4);
        }

        .form-title {
            font-size: 17px; font-weight: 800; color: var(--text-primary);
            text-transform: uppercase; letter-spacing: 0.8px; margin: 0;
        }

        .form-grid {
            display: grid; grid-template-columns: 1fr 1fr; gap: 18px;
        }
        @media(max-width: 600px) { .form-grid { grid-template-columns: 1fr; } }

        .form-group {
            display: flex; flex-direction: column; gap: 6px; margin-bottom: 14px;
        }
        .form-group.full-width { grid-column: 1 / -1; }

        label {
            font-size: 12px; font-weight: 700; color: var(--text-secondary); text-transform: uppercase; letter-spacing: 0.5px;
        }

        input[type="text"], input[type="number"], select {
            background: var(--input-bg); border: 1px solid var(--border-glass);
            border-radius: 10px; padding: 11px 14px; color: var(--text-primary);
            font-size: 14px; outline: none; transition: all 0.2s ease; width: 100%; box-sizing: border-box;
        }
        input:focus, select:focus {
            border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.35);
            background: rgba(3, 7, 18, 0.85);
        }

        select option {
            background: var(--bg-deep); color: var(--text-primary); padding: 10px;
        }

        .btn-submit {
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff; border: 1px solid rgba(56, 189, 248, 0.4);
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            width: 100%; padding: 12px; border-radius: 10px;
            font-size: 13px; font-weight: 800; text-transform: uppercase;
            letter-spacing: 0.5px; cursor: pointer; transition: all 0.25s ease;
            margin-top: 15px; grid-column: 1 / -1;
        }
        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .footer-bottom-bar {
            max-width: 750px; margin: 20px auto 0 auto; text-align: center;
            color: var(--text-secondary); font-size: 11.5px; letter-spacing: 0.5px;
        }
    </style>
</head>
<body>

    <div class="form-container">
        <!-- Back Button on Left Side -->
        <div class="form-top-bar">
            <a href="javascript:history.back()" class="btn-back-inline"><i class="fa-solid fa-arrow-left"></i> Back</a>
            <div class="form-title">⚡ Edit Player Profile</div>
        </div>

        <form action="${pageContext.request.contextPath}/updatePlayer" method="post">
            <input type="hidden" name="id" value="${player.id}">
            <input type="hidden" name="teamId" value="${teamId}">
            
            <div class="form-grid">
                <div class="form-group full-width">
                    <label>Player Full Name</label>
                    <input type="text" name="playerName" value="${player.playerName}" placeholder="Enter player name" required autocomplete="off">
                </div>

                <div class="form-group">
                    <label>Age</label>
                    <input type="number" name="age" value="${player.age}" placeholder="Enter age" min="10" max="60" required>
                </div>

                <div class="form-group">
                    <label>Jersey Number</label>
                    <input type="number" name="jerseyNumber" value="${player.jerseyNumber}" placeholder="Enter jersey number" min="0" max="999" required>
                </div>

                <div class="form-group full-width">
                    <label>Player Role</label>
                    <select name="role" required>
                        <!-- Yahan values uppercase karni zaroori hain taaki Spring error na de -->
                        <option value="BATSMAN" ${player.role.name() == 'BATSMAN' ? 'selected' : ''}>Batsman</option>
                        <option value="BOWLER" ${player.role.name() == 'BOWLER' ? 'selected' : ''}>Bowler</option>
                        <option value="ALL_ROUNDER" ${player.role.name() == 'ALL_ROUNDER' ? 'selected' : ''}>All-Rounder</option>
                        <option value="WICKET_KEEPER" ${player.role.name() == 'WICKET_KEEPER' ? 'selected' : ''}>Wicket-Keeper</option>
                    </select>
                </div>

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
            
            <button type="submit" class="btn-submit">💾 Save Changes</button>
        </form>
    </div>

    <div class="footer-bottom-bar">
        <p>&copy; 2026 ProMatch Arena &bull; All Rights Reserved.</p>
    </div>

</body>
</html>