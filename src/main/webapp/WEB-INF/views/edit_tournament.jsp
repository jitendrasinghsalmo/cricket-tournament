<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit Tournament</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.72);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.82);
            --input-bg: rgba(3, 7, 18, 0.45);
        }

        body.light-mode {
            --bg-deep: #f8fafc;
            --card-surface: rgba(255, 255, 255, 0.82);
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: rgba(2, 132, 199, 0.25);
            --body-overlay: rgba(241, 245, 249, 0.82);
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
        }

        /* Top-Left Back Button */
        .btn-top-left-back {
            position: absolute;
            top: 18px;
            left: 22px;
            background: rgba(14, 165, 233, 0.16);
            color: #22d3ee;
            border: 2px solid #06b6d4;
            padding: 9px 22px;
            border-radius: 14px;
            text-decoration: none;
            font-weight: 800;
            font-size: 16px;
            display: inline-flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            box-shadow: 0 0 14px rgba(6, 182, 212, 0.25);
            transition: all 0.25s ease;
            z-index: 1000;
        }
        .btn-top-left-back:hover {
            background: #06b6d4;
            color: #030712;
            transform: translateX(-3px);
            box-shadow: 0 0 20px rgba(6, 182, 212, 0.5);
        }

        /* Form size auto-scales with screen height, so no scroll */
        .form-container {
            width: 100%;
            max-width: 500px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid var(--border-glass);
            border-radius: 18px;
            padding: clamp(18px, 4vh, 40px) 28px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.6);
            position: relative;
            overflow: hidden;
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
            font-weight: 800;
            font-size: clamp(17px, 3.2vh, 25px);
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        h2 span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }

        .form-group {
            margin-bottom: clamp(8px, 2.4vh, 20px);
        }

        label {
            display: block;
            font-size: clamp(10.5px, 1.9vh, 13px);
            font-weight: 700;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: clamp(3px, 0.8vh, 6px);
        }

        input[type="text"],
        input[type="datetime-local"],
        input[type="number"],
        input[type="email"],
        input[type="password"],
        input[type="date"],
        select {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border-glass);
            border-radius: 10px;
            padding: clamp(8px, 2.4vh, 16px) 15px;
            color: #ffffff;
            font-size: clamp(12.5px, 2.1vh, 15px);
            font-family: inherit;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }

        input[type="date"]::-webkit-calendar-picker-indicator,
        input[type="datetime-local"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
            cursor: pointer;
            opacity: 0.8;
        }
        input[type="date"]::-webkit-calendar-picker-indicator:hover,
        input[type="datetime-local"]::-webkit-calendar-picker-indicator:hover {
            opacity: 1;
        }

        select option {
            background: #030712;
            color: #ffffff;
            padding: 10px;
        }

        ::placeholder {
            color: #94a3b8;
            opacity: 1;
        }

        input:focus, select:focus {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.25);
            background: rgba(3, 7, 18, 0.7);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-row .form-group { min-width: 0; }

        .button-group {
            margin-top: clamp(10px, 2.8vh, 26px);
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            padding: clamp(10px, 2.4vh, 16px);
            border-radius: 10px;
            font-size: clamp(12.5px, 2.1vh, 15px);
            font-weight: 800;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            text-transform: uppercase;
            letter-spacing: 0.8px;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }


        /* password eye toggle */
        .pw-wrap { position: relative; }
        .pw-wrap input { padding-right: 42px; }
        .toggle-password { position: absolute; right: 14px; top: 50%; transform: translateY(-50%); color: var(--text-secondary); cursor: pointer; font-size: 14px; transition: color 0.2s; }
        .toggle-password:hover { color: var(--neon-cyan); }
        select { appearance: none; -webkit-appearance: none; cursor: pointer; }

        /* Mobile */
        @media(max-width: 768px) {
            body { padding: 54px 12px 12px 12px; }
            .btn-top-left-back { top: 12px; left: 14px; padding: 6px 15px; font-size: 13px; border-radius: 12px; gap: 8px; }
            .form-container { padding: clamp(14px, 2.8vh, 24px) 16px; max-width: 480px; }
            .form-row { gap: 10px; }
            .form-row.stack-mobile { grid-template-columns: 1fr; gap: 0; }
            h2 { font-size: clamp(15px, 2.7vh, 20px); margin-bottom: clamp(8px, 1.9vh, 16px); }
            .form-group { margin-bottom: clamp(5px, 1.5vh, 13px); }
            input[type="text"],
            input[type="datetime-local"],
            input[type="number"],
            input[type="email"],
            input[type="password"],
            input[type="date"],
            select { padding: clamp(6px, 1.65vh, 11px) 11px; font-size: clamp(12px, 1.9vh, 14px); border-radius: 8px; }
            label { font-size: clamp(9.5px, 1.6vh, 11.5px); margin-bottom: 3px; }
            .button-group { margin-top: clamp(8px, 1.8vh, 16px); }
            .btn-submit { padding: clamp(8px, 1.7vh, 12px); font-size: 13px; }
        }
    </style>
</head>
<body>

    <!-- Top-Left Back Button -->
    <a href="/admin/tournaments" class="btn-top-left-back"><i class="fa-solid fa-arrow-left"></i> Back</a>

    <div class="form-container">
        <h2><span>Edit</span> Tournament (#PTC-${tournament.id})</h2>

        <form id="editTournamentForm" action="/admin/updateTournament" method="post">
            <input type="hidden" name="id" value="${tournament.id}">

            <div class="form-group">
                <label>Tournament Name</label>
                <input type="text" name="tournamentName" value="${tournament.tournamentName}" placeholder="Enter tournament name..." required autocomplete="off">
            </div>

            <div class="form-group">
                <label>Season</label>
                <input type="text" name="season" value="${tournament.season}" placeholder="e.g. 2026 / Season 1" required autocomplete="off">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="startDate" value="${tournament.startDate}" required>
                </div>

                <div class="form-group">
                    <label>End Date</label>
                    <input type="date" name="endDate" value="${tournament.endDate}" required>
                </div>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="status">
                    <option value="UPCOMING" ${tournament.status == 'UPCOMING' ? 'selected' : ''}>Upcoming</option>
                    <option value="ONGOING" ${tournament.status == 'ONGOING' ? 'selected' : ''}>Ongoing</option>
                    <option value="COMPLETED" ${tournament.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                </select>
            </div>

            <div class="button-group">
                <button type="submit" class="btn-submit">💾 Update Tournament</button>
            </div>
        </form>
    </div>

    <script>
        if (localStorage.getItem('promatch_theme') === 'light' || localStorage.getItem('matchTheme') === 'light') {
            document.body.classList.add('light-mode');
        }
    </script>

</body>
</html>
