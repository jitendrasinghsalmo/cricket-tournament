<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Edit Match</title>
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
            font-size: 24px;
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

        /* GLASSMORPHIC FORM CARD */
        .form-card {
            background: var(--card-surface);
            border: 1px solid var(--border-color);
            border-radius: 16px;
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

        input[type="text"],
        input[type="datetime-local"],
        input[type="number"],
        select {
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

        /* FORCE DATETIME-LOCAL ICON VISIBILITY */
        input[type="datetime-local"]::-webkit-calendar-picker-indicator {
            filter: invert(1);
            cursor: pointer;
            opacity: 0.8;
            transition: opacity 0.2s;
        }

        input[type="datetime-local"]::-webkit-calendar-picker-indicator:hover {
            opacity: 1;
        }

        body.light-theme input[type="datetime-local"]::-webkit-calendar-picker-indicator {
            filter: invert(0);
        }

        input:focus, select:focus {
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
            formElement.querySelectorAll('input[type="text"], input[type="number"], input[type="datetime-local"]').forEach(input => {
                input.value = '';
            });
            formElement.querySelectorAll('select').forEach(select => {
                select.selectedIndex = 0;
            });
            return false;
        }
    </script>
</head>
<body>

    <!-- TOP COMMAND BAR -->
    <div class="command-bar">
        <div class="command-left">
            <a href="/admin/matches" class="command-link"><i class="fa-solid fa-arrow-left"></i> Back to Matches</a>
        </div>
        <div class="command-right">
            <button onclick="toggleTheme()" class="command-link"><i class="fa-solid fa-circle-half-stroke"></i> <span id="themeBtnText">Dark Mode</span></button>
        </div>
    </div>

    <div class="container">

        <div class="section-header">
            <h1>Edit Match Details (#M-${match.id})</h1>
        </div>

        <div class="form-card">
            <form action="/admin/updateMatch" method="post" id="editMatchForm">
                <input type="hidden" name="id" value="${match.id}">

                <div class="form-grid">
                    
                    <!-- Tournament -->
                    <div class="form-group full-width">
                        <label><i class="fa-solid fa-trophy"></i> Tournament</label>
                        <select name="tournament.id" required>
                            <c:forEach items="${tournaments}" var="t">
                                <option value="${t.id}" ${match.tournament != null && match.tournament.id == t.id ? 'selected' : ''}>${t.tournamentName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Team A -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-shield-halved"></i> Team A</label>
                        <select name="teamA.id" required>
                            <c:forEach items="${teams}" var="team">
                                <option value="${team.id}" ${match.teamA != null && match.teamA.id == team.id ? 'selected' : ''}>${team.teamName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Team B -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-shield-halved"></i> Team B</label>
                        <select name="teamB.id" required>
                            <c:forEach items="${teams}" var="team">
                                <option value="${team.id}" ${match.teamB != null && match.teamB.id == team.id ? 'selected' : ''}>${team.teamName}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <!-- Match Date & Time -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-calendar-days"></i> Date & Time</label>
                        <input type="datetime-local" name="matchDateTime" value="${match.matchDateTime}" required>
                    </div>

                    <!-- Venue -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-location-dot"></i> Venue</label>
                        <input type="text" name="venue" value="${match.venue}" required>
                    </div>

                    <!-- Status -->
                    <div class="form-group full-width">
                        <label><i class="fa-solid fa-circle-info"></i> Status</label>
                        <select name="status">
                            <option value="UPCOMING" ${match.status != null && match.status.name() == 'UPCOMING' ? 'selected' : ''}>UPCOMING</option>
                            <option value="ONGOING" ${match.status != null && match.status.name() == 'ONGOING' ? 'selected' : ''}>ONGOING</option>
                            <option value="COMPLETED" ${match.status != null && match.status.name() == 'COMPLETED' ? 'selected' : ''}>COMPLETED</option>
                        </select>
                    </div>

                    <!-- Runs & Overs A -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-chart-simple"></i> Runs Scored A</label>
                        <input type="number" step="1" name="runsScoredA" value="${match.runsScoredA}">
                    </div>
                    <div class="form-group">
                        <label><i class="fa-solid fa-stopwatch"></i> Overs Faced A</label>
                        <input type="number" step="0.1" name="oversFacedA" value="${match.oversFacedA}">
                    </div>

                    <!-- Runs & Overs B -->
                    <div class="form-group">
                        <label><i class="fa-solid fa-chart-simple"></i> Runs Scored B</label>
                        <input type="number" step="1" name="runsScoredB" value="${match.runsScoredB}">
                    </div>
                    <div class="form-group">
                        <label><i class="fa-solid fa-stopwatch"></i> Overs Faced B</label>
                        <input type="number" step="0.1" name="oversFacedB" value="${match.oversFacedB}">
                    </div>

                    <!-- Winner Team -->
                    <div class="form-group full-width">
                        <label><i class="fa-solid fa-award"></i> Winner Team (If Completed)</label>
                        <select name="winner.id">
                            <option value="">-- Select Winner --</option>
                            <c:if test="${match.teamA != null}">
                                <option value="${match.teamA.id}" ${match.winner != null && match.winner.id == match.teamA.id ? 'selected' : ''}>${match.teamA.teamName}</option>
                            </c:if>
                            <c:if test="${match.teamB != null}">
                                <option value="${match.teamB.id}" ${match.winner != null && match.winner.id == match.teamB.id ? 'selected' : ''}>${match.teamB.teamName}</option>
                            </c:if>
                        </select>
                    </div>

                </div>

                <div class="form-actions">
                    <button type="button" class="btn-clear" onclick="return clearForm(document.getElementById('editMatchForm'));"><i class="fa-solid fa-eraser"></i> Clear</button>
                    <button type="submit" class="btn-submit"><i class="fa-solid fa-check"></i> Update Match</button>
                </div>
            </form>
        </div>

    </div>
</body>
</html>