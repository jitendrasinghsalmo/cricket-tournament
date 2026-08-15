<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Add New Tournament</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.72); /* Transparent glassmorphism */
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.82);
            --input-bg: rgba(3, 7, 18, 0.45);
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 40px 20px 60px 20px; 
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Top-Left Corner Floating Back Button */
        .btn-top-left-back {
            position: fixed;
            top: 25px;
            left: 30px;
            background: var(--card-surface);
            color: var(--neon-cyan);
            border: 1px solid var(--border-glass);
            padding: 10px 20px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.4);
            transition: all 0.25s ease;
            z-index: 1000;
        }
        .btn-top-left-back:hover {
            background: var(--neon-cyan);
            color: #030712;
            transform: translateX(-4px);
        }

        .form-container {
            width: 100%;
            max-width: 600px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            border: 1px solid var(--border-glass);
            border-radius: 20px;
            padding: 35px 40px;
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
            margin-bottom: 25px;
            font-weight: 800;
            font-size: 22px;
            letter-spacing: 1px;
            text-transform: uppercase;
        }
        h2 span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }

        .form-group {
            margin-bottom: 18px;
        }

        label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 6px;
        }

        input[type="text"],
        input[type="date"],
        select {
            width: 100%;
            background: var(--input-bg);
            border: 1px solid var(--border-glass);
            border-radius: 10px;
            padding: 11px 15px;
            color: #ffffff;
            font-size: 13.5px;
            font-family: inherit;
            outline: none;
            box-sizing: border-box;
            transition: all 0.2s ease;
        }

        /* Calendar Icon visibility fix for date inputs */
        input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
            cursor: pointer;
            opacity: 0.8;
        }
        input[type="date"]::-webkit-calendar-picker-indicator:hover {
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

        @media(max-width: 768px) {
            .btn-top-left-back { top: 15px; left: 15px; padding: 8px 14px; font-size: 12px; }
            .form-row { grid-template-columns: 1fr; gap: 0; }
            .form-container { padding: 25px 20px; }
        }

        .button-group {
            margin-top: 25px;
        }

        .btn-submit {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            padding: 13px;
            border-radius: 10px;
            font-size: 13.5px;
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
    </style>
</head>
<body>

    <!-- Top-Left Floating Back Button -->
    <a href="/tournaments" class="btn-top-left-back"><i class="fa-solid fa-arrow-left"></i> Back to Tournaments</a>

    <div class="form-container">
        <h2>Add New <span>Tournament</span></h2>
        
        <form action="/saveTournament" method="post">
            
            <div class="form-group">
                <label>Tournament Name</label>
                <input type="text" name="tournamentName" required placeholder="e.g. Champions League Cricket" autocomplete="off">
            </div>

            <div class="form-group">
                <label>Season</label>
                <input type="text" name="season" required placeholder="e.g. Season 2026" autocomplete="off">
            </div>

            <div class="form-row">
                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="startDate" required>
                </div>

                <div class="form-group">
                    <label>End Date</label>
                    <input type="date" name="endDate" required>
                </div>
            </div>

            <div class="form-group">
                <label>Status</label>
                <select name="status">
                    <option value="UPCOMING">Upcoming</option>
                    <option value="ONGOING">Ongoing</option>
                    <option value="COMPLETED">Completed</option>
                </select>
            </div>

            <!-- Submit Button (Clear removed) -->
            <div class="button-group">
                <button type="submit" class="btn-submit">💾 Save Tournament</button>
            </div>

        </form>
    </div>

</body>
</html>