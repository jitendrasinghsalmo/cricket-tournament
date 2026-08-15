<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit Tournament</title>
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

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background-color: var(--bg-deep);
            color: var(--text-main); 
            margin: 0; 
            min-height: 100vh;
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

        .command-left {
            display: flex;
            align-items: center;
            gap: 25px;
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
        }

        .command-link:hover {
            color: var(--text-main);
        }

        /* CONTAINER */
        .container {
            max-width: 650px;
            margin: 40px auto;
            padding: 0 20px;
            box-sizing: border-box;
        }

        /* FORM CARD */
        .form-card {
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 16px;
            padding: 35px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        .form-header {
            margin-bottom: 25px;
            text-align: center;
        }

        .form-header h1 {
            font-size: 22px;
            font-weight: 900;
            letter-spacing: 1.5px;
            margin: 0;
            text-transform: uppercase;
            background: linear-gradient(90deg, var(--accent-blue), var(--accent-green), var(--accent-red), var(--accent-blue));
            background-size: 300% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: waveShimmer 6s linear infinite;
        }

        @keyframes waveShimmer {
            0% { background-position: 0% center; }
            100% { background-position: 300% center; }
        }

        .form-header p {
            font-size: 13px;
            color: var(--text-muted);
            margin: 6px 0 0 0;
            font-weight: 500;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 12px;
            text-transform: uppercase;
            color: var(--text-muted);
            font-weight: 700;
            margin-bottom: 8px;
            letter-spacing: 0.5px;
        }

        .form-control {
            width: 100%;
            background: var(--bg-deep);
            border: 1px solid var(--border-color);
            border-radius: 10px;
            padding: 12px 15px;
            color: var(--text-main);
            font-size: 14px;
            font-weight: 500;
            outline: none;
            box-sizing: border-box;
            transition: border-color 0.2s;
        }

        .form-control:focus {
            border-color: var(--accent-blue);
        }

        select.form-control {
            cursor: pointer;
        }

        /* Force calendar icon appearance and color filters for dark mode browsers */
        input[type="date"]::-webkit-calendar-picker-indicator {
            filter: invert(1) brightness(1.5);
            cursor: pointer;
            opacity: 0.8;
            transition: opacity 0.2s;
        }
        input[type="date"]::-webkit-calendar-picker-indicator:hover {
            opacity: 1;
        }

        .form-actions {
            display: flex;
            gap: 12px;
            margin-top: 30px;
        }

        .btn-submit {
            flex: 1;
            background: var(--accent-blue);
            color: #07090e;
            border: none;
            padding: 12px;
            border-radius: 10px;
            font-weight: 800;
            font-size: 13px;
            cursor: pointer;
            text-align: center;
            box-shadow: 0 0 15px rgba(0, 210, 255, 0.3);
            transition: transform 0.2s;
        }

        .btn-submit:hover {
            transform: translateY(-2px);
        }

        .btn-clear {
            flex: 1;
            background: rgba(255, 51, 102, 0.1);
            color: var(--accent-red);
            border: 1px solid rgba(255, 51, 102, 0.3);
            padding: 12px;
            border-radius: 10px;
            font-weight: 700;
            font-size: 13px;
            text-align: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-clear:hover {
            background: var(--accent-red);
            color: #fff;
        }
    </style>
    <script>
        function clearForm() {
            document.getElementById("editTournamentForm").reset();
        }
    </script>
</head>
<body>

    <!-- TOP COMMAND BAR -->
    <div class="command-bar">
        <div class="command-left">
            <a href="/admin/tournaments" class="command-link"><i class="fa-solid fa-arrow-left"></i> Back to Tournaments</a>
            <a href="/admin/home" class="command-link"><i class="fa-solid fa-chart-pie"></i> Dashboard</a>
        </div>
    </div>

    <div class="container">
        <div class="form-card">
            <div class="form-header">
                <h1>Edit Tournament</h1>
                <p>Modify tournament configuration and scheduling parameters (#PTC-${tournament.id})</p>
            </div>
            
            <form id="editTournamentForm" action="/admin/updateTournament" method="post">
                <input type="hidden" name="id" value="${tournament.id}">
                
                <div class="form-group">
                    <label>Tournament Name</label>
                    <input type="text" name="tournamentName" class="form-control" value="${tournament.tournamentName}" required>
                </div>

                <div class="form-group">
                    <label>Season</label>
                    <input type="text" name="season" class="form-control" value="${tournament.season}" required>
                </div>

                <div class="form-group">
                    <label>Start Date</label>
                    <input type="date" name="startDate" class="form-control" value="${tournament.startDate}" required>
                </div>

                <div class="form-group">
                    <label>End Date</label>
                    <input type="date" name="endDate" class="form-control" value="${tournament.endDate}" required>
                </div>

                <div class="form-group">
                    <label>Status</label>
                    <select name="status" class="form-control">
                        <option value="UPCOMING" ${tournament.status == 'UPCOMING' ? 'selected' : ''}>Upcoming</option>
                        <option value="ONGOING" ${tournament.status == 'ONGOING' ? 'selected' : ''}>Ongoing</option>
                        <option value="COMPLETED" ${tournament.status == 'COMPLETED' ? 'selected' : ''}>Completed</option>
                    </select>
                </div>
                
                <div class="form-actions">
                    <button type="button" class="btn-clear" onclick="clearForm()"><i class="fa-solid fa-rotate-right"></i> Clear Form</button>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-check"></i> Update Tournament</button>
                </div>
            </form>
        </div>
    </div>

</body>
</html>