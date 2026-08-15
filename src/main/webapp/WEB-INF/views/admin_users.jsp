<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | User Management Command Hub</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.88);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.18);
            --body-overlay: rgba(3, 7, 18, 0.95);
            --meta-box-bg: rgba(3, 7, 18, 0.55);
            --search-bg: rgba(3, 7, 18, 0.7);
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
            --search-bg: rgba(255, 255, 255, 0.9);
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
            max-width: 1350px; margin: 0 auto 25px auto; 
            background: var(--card-surface); backdrop-filter: blur(20px);
            padding: 16px 28px; border-radius: 18px; border: 1px solid var(--border-glass);
            box-shadow: 0 20px 40px rgba(0,0,0,0.35);
            flex-wrap: wrap; gap: 15px;
        }
        
        .header-left { display: flex; align-items: center; gap: 10px; flex-wrap: wrap; }
        .header-right { display: flex; align-items: center; gap: 12px; }

        .btn-back { background: rgba(56, 189, 248, 0.08); color: var(--neon-cyan); border: 1px solid var(--border-glass); padding: 9px 16px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .btn-back:hover { background: var(--neon-cyan); color: #030712; box-shadow: 0 0 15px rgba(56, 189, 248, 0.4); }

        .btn-dashboard { background: rgba(16, 185, 129, 0.08); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3); padding: 9px 16px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 13px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .btn-dashboard:hover { background: var(--neon-emerald); color: #030712; box-shadow: 0 0 15px rgba(16, 185, 129, 0.4); }

        .btn-add { background: linear-gradient(135deg, var(--neon-cyan), #0284c7); color: #030712; border: none; padding: 10px 18px; border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 13px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; box-shadow: 0 4px 15px rgba(56, 189, 248, 0.3); }
        .btn-add:hover { transform: translateY(-2px); box-shadow: 0 6px 20px rgba(56, 189, 248, 0.5); }

        .btn-delete-all { background: rgba(244, 63, 94, 0.1); color: var(--neon-rose); border: 1px solid rgba(244, 63, 94, 0.3); padding: 10px 16px; border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 13px; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .btn-delete-all:hover { background: var(--neon-rose); color: #030712; box-shadow: 0 0 15px rgba(244, 63, 94, 0.4); }

        .theme-toggle-btn {
            background: var(--card-surface); color: var(--text-primary);
            border: 1px solid var(--border-glass); padding: 9px 14px;
            border-radius: 10px; font-size: 13px; font-weight: 700; cursor: pointer;
            transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px;
        }
        .theme-toggle-btn:hover { border-color: var(--neon-cyan); box-shadow: 0 0 12px rgba(56, 189, 248, 0.3); }

        .jumping-title {
            text-align: center; color: var(--text-primary); margin: 0; font-weight: 900; font-size: 20px; letter-spacing: 1.5px; text-transform: uppercase;
            display: inline-block; white-space: nowrap;
        }
        .jumping-title span {
            display: inline-block; opacity: 0; transform: translateY(-25px);
            animation: dropInChar 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.04s * var(--i));
        }
        .jumping-title span.highlight { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.6); }

        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-25px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .control-bar {
            max-width: 1350px; margin: 0 auto 25px auto;
            display: flex; justify-content: space-between; align-items: center;
            background: var(--card-surface); backdrop-filter: blur(12px);
            padding: 12px 20px; border-radius: 14px; border: 1px solid var(--border-glass);
            flex-wrap: wrap; gap: 15px;
        }
        .search-input {
            background: var(--search-bg); border: 1px solid var(--border-glass);
            border-radius: 8px; padding: 9px 15px; color: var(--text-primary); font-size: 13px;
            width: 300px; outline: none; transition: 0.2s;
        }
        .search-input::placeholder { color: var(--text-secondary); }
        .search-input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(56,189,248,0.3); }

        .stats-badge { font-size: 12px; font-weight: 700; color: var(--text-secondary); background: var(--search-bg); padding: 7px 14px; border-radius: 8px; border: 1px solid var(--border-glass); }

        /* Grid Container */
        .cards-grid {
            max-width: 1350px; margin: 0 auto;
            display: grid; grid-template-columns: repeat(auto-fill, minmax(330px, 1fr)); gap: 22px;
        }

        /* Base Card Styling */
        .user-card {
            background: var(--card-surface); backdrop-filter: blur(20px);
            border-radius: 20px; padding: 24px; box-shadow: 0 15px 35px rgba(0,0,0,0.35);
            position: relative; overflow: hidden; transition: transform 0.25s ease, box-shadow 0.25s ease;
            border: 1px solid var(--border-glass);
        }
        .user-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 22px 45px rgba(56, 189, 248, 0.25);
        }

        /* 3 Different Distinct Card Variants for Visual Diversity */
        .card-variant-1 { border-top: 4px solid var(--neon-cyan); }
        .card-variant-2 { border-top: 4px solid var(--neon-emerald); }
        .card-variant-3 { border-top: 4px solid var(--neon-amber); }

        .card-header {
            display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 15px;
        }
        .user-id { font-size: 11px; font-weight: 800; color: var(--text-secondary); background: var(--meta-box-bg); padding: 3px 9px; border-radius: 6px; }
        
        .user-name { font-size: 18px; font-weight: 900; color: var(--text-primary); margin: 0 0 4px 0; }
        .user-email { font-size: 13px; color: var(--text-secondary); margin-bottom: 18px; word-break: break-all; display: flex; align-items: center; gap: 6px; }

        .user-info-pill {
            background: var(--meta-box-bg); border-radius: 14px; padding: 14px; margin-bottom: 18px;
            display: grid; grid-template-columns: 1fr 1fr; gap: 10px; font-size: 12.5px;
            border: 1px solid rgba(255,255,255,0.03);
        }
        .pill-item { display: flex; flex-direction: column; gap: 3px; }
        .pill-label { color: var(--text-secondary); font-size: 11px; font-weight: 700; text-transform: uppercase; }
        .pill-val { color: var(--text-primary); font-weight: 800; font-size: 12.5px; }

        /* Status & Role Badges */
        .status-badge { padding: 3px 8px; border-radius: 6px; font-size: 11px; font-weight: 800; display: inline-block; }
        .status-active { background: rgba(16, 185, 129, 0.15); color: var(--neon-emerald); border: 1px solid rgba(16, 185, 129, 0.3); }
        .status-blocked { background: rgba(244, 63, 94, 0.15); color: var(--neon-rose); border: 1px solid rgba(244, 63, 94, 0.3); }

        .role-badge { padding: 3px 8px; border-radius: 6px; font-size: 11px; font-weight: 800; display: inline-block; }
        .role-admin { background: rgba(56, 189, 248, 0.15); color: var(--neon-cyan); border: 1px solid rgba(56, 189, 248, 0.3); }
        .role-user { background: rgba(148, 163, 184, 0.12); color: var(--text-secondary); border: 1px solid var(--border-glass); }

        /* Action Buttons */
        .card-actions {
            display: flex; gap: 8px; align-items: center; border-top: 1px solid var(--border-glass); padding-top: 15px;
        }
        .action-link { text-decoration: none; font-weight: 700; font-size: 12px; padding: 8px 12px; border-radius: 8px; transition: 0.2s; display: inline-flex; align-items: center; justify-content: center; gap: 5px; flex: 1; }
        .action-edit { color: var(--neon-cyan); background: rgba(56, 189, 248, 0.08); border: 1px solid rgba(56, 189, 248, 0.2); }
        .action-edit:hover { background: var(--neon-cyan); color: #030712; }

        .action-block { color: var(--neon-amber); background: rgba(245, 158, 11, 0.08); border: 1px solid rgba(245, 158, 11, 0.2); }
        .action-block:hover { background: var(--neon-amber); color: #030712; }

        .action-unblock { color: var(--neon-emerald); background: rgba(16, 185, 129, 0.08); border: 1px solid rgba(16, 185, 129, 0.2); }
        .action-unblock:hover { background: var(--neon-emerald); color: #030712; }

        .action-delete { color: var(--neon-rose); background: rgba(244, 63, 94, 0.08); border: 1px solid rgba(244, 63, 94, 0.2); }
        .action-delete:hover { background: var(--neon-rose); color: #030712; }

        .protected-text { text-align: center; width: 100%; color: var(--text-secondary); font-style: italic; font-size: 12px; padding: 8px; background: var(--meta-box-bg); border-radius: 8px; border: 1px solid var(--border-glass); }

        .grand-footer {
            max-width: 1350px; margin: 40px auto 0 auto;
            background: var(--card-surface); backdrop-filter: blur(20px);
            border: 1px solid var(--border-glass); border-radius: 24px;
            padding: 35px 40px; box-shadow: 0 25px 50px rgba(0,0,0,0.3);
            display: grid; grid-template-columns: 2fr 1.5fr 1fr; gap: 30px; align-items: center;
        }
        @media(max-width: 900px) { .grand-footer { grid-template-columns: 1fr; text-align: center; } }

        .footer-brand-col h3 { margin: 0 0 10px 0; font-size: 18px; font-weight: 800; color: var(--text-primary); text-transform: uppercase; }
        .footer-brand-col h3 span { color: var(--neon-cyan); }
        .footer-brand-col p { margin: 0; font-size: 12.5px; color: var(--text-secondary); line-height: 1.6; }

        .footer-info-box h4 { margin: 0 0 8px 0; font-size: 13px; font-weight: 700; color: var(--neon-emerald); text-transform: uppercase; letter-spacing: 0.5px; }
        .footer-info-box p { margin: 0; font-size: 12px; color: var(--text-secondary); line-height: 1.5; }

        .footer-stat-highlight {
            background: var(--search-bg); border: 1px solid var(--border-glass);
            padding: 15px; border-radius: 14px; text-align: center; font-size: 12px; color: var(--text-secondary); font-weight: 600;
        }
        .footer-stat-highlight span { display: block; font-size: 16px; font-weight: 900; color: var(--neon-cyan); margin-top: 4px; }

        .footer-bottom-bar { max-width: 1350px; margin: 15px auto 0 auto; text-align: center; color: var(--text-secondary); font-size: 11.5px; padding-bottom: 20px; }
        .no-record { grid-column: 1 / -1; text-align: center; color: var(--text-secondary); padding: 50px; font-size: 14px; background: var(--card-surface); border-radius: 18px; border: 1px solid var(--border-glass); }
    </style>
</head>
<body>

    <div class="header-bar">
        <div class="header-left">
            <a href="/admin/home" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Back</a>
            <a href="/admin/home" class="btn-dashboard"><i class="fa-solid fa-gauge"></i> Dashboard</a>
            <a href="/admin/addUserPage" class="btn-add"><i class="fa-solid fa-user-plus"></i> Add User</a>
            <a href="/admin/deleteAllUsers" class="btn-delete-all" onclick="return confirm('WARNING: Are you sure you want to delete all non-admin users?');"><i class="fa-solid fa-trash-can"></i> Delete All</a>
        </div>
        
        <div>
            <h2 class="jumping-title" id="animatedTitle">Registered Users Hub</h2>
        </div>

        <div class="header-right">
            <button class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()">
                🌙 <span id="themeBtnText">Dark</span>
            </button>
        </div>
    </div>

    <!-- Live Search Bar Control -->
    <div class="control-bar">
        <input type="text" id="userSearch" class="search-input" placeholder="🔍 Search name, email or phone..." onkeyup="filterUsers()">
        <div class="stats-badge">Total Users: <span style="color: var(--neon-cyan); font-weight: 800;">${users.size()}</span></div>
    </div>

    <!-- Cards Grid Container with Rotating Variants -->
    <div class="cards-grid" id="usersGridContainer">
        <c:forEach items="${users}" var="u" varStatus="status">
            <%-- Assigning different visual card variants using modulus --%>
            <c:set var="variantClass" value="card-variant-1" />
            <c:if test="${status.index % 3 == 1}"><c:set var="variantClass" value="card-variant-2" /></c:if>
            <c:if test="${status.index % 3 == 2}"><c:set var="variantClass" value="card-variant-3" /></c:if>

            <div class="user-card ${variantClass}" data-search="${u.name.toLowerCase()} ${u.email.toLowerCase()} ${u.phone != null ? u.phone.toLowerCase() : ''}">
                <div class="card-header">
                    <div>
                        <h3 class="user-name">${u.name}</h3>
                        <div class="user-email"><i class="fa-solid fa-envelope" style="color: var(--neon-cyan);"></i> ${u.email}</div>
                    </div>
                    <span class="user-id">#${u.id}</span>
                </div>

                <div class="user-info-pill">
                    <div class="pill-item">
                        <span class="pill-label">Phone</span>
                        <span class="pill-val">${u.phone != null ? u.phone : 'N/A'}</span>
                    </div>
                    <div class="pill-item">
                        <span class="pill-label">Role</span>
                        <span class="pill-val"><span class="role-badge ${u.role == 'ADMIN' ? 'role-admin' : 'role-user'}">${u.role}</span></span>
                    </div>
                    <div class="pill-item">
                        <span class="pill-label">Status</span>
                        <span class="pill-val">
                            <c:choose>
                                <c:when test="${u.blocked}">
                                    <span class="status-badge status-blocked">Blocked</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="status-badge status-active">Active</span>
                                </c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                    <div class="pill-item">
                        <span class="pill-label">Joined</span>
                        <span class="pill-val" style="font-size: 11px; color: var(--text-secondary);">${u.createdAt != null ? u.createdAt : 'Recent'}</span>
                    </div>
                </div>

                <div class="card-actions">
                    <c:choose>
                        <c:when test="${u.role == 'ADMIN'}">
                            <div class="protected-text"><i class="fa-solid fa-shield-halved"></i> Protected Account</div>
                        </c:when>
                        <c:otherwise>
                            <a href="/admin/editUser/${u.id}" class="action-link action-edit" title="Edit User"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                            <a href="/admin/toggleBlock/${u.id}" class="action-link ${u.blocked ? 'action-unblock' : 'action-block'}" title="${u.blocked ? 'Unblock User' : 'Block User'}">
                                <i class="fa-solid ${u.blocked ? 'fa-lock-open' : 'fa-lock'}"></i> ${u.blocked ? 'Unblock' : 'Block'}
                            </a>
                            <a href="/admin/deleteUser/${u.id}" class="action-link action-delete" onclick="return confirm('Are you sure you want to delete this user?');" title="Delete User"><i class="fa-solid fa-trash"></i></a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </c:forEach>
        
        <c:if test="${empty users}">
            <div class="no-record">No registered users found in the system.</div>
        </c:if>
    </div>

    <footer class="grand-footer">
        <div class="footer-brand-col">
            <h3><span>ProMatch</span> Arena</h3>
            <p>Advanced Enterprise Cricket Tournament & Standings Control Hub. Real-time net run rate calculation and automated position sorting engine.</p>
        </div>
        
        <div class="footer-info-box">
            <h4>⚡ User Security Info</h4>
            <p>Admin accounts are securely locked against standard modification or deletion from standard user interfaces.</p>
        </div>

        <div class="footer-stat-highlight">
            System Engine Status
            <span>ONLINE &bull; SECURE v2.6</span>
        </div>
    </footer>

    <div class="footer-bottom-bar">
        <p>&copy; 2026 ProMatch Arena &bull; All Rights Reserved. Crafted with high-end Cyber Glassmorphism UI.</p>
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

            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                document.getElementById('themeToggleBtn').innerHTML = '☀️ <span id="themeBtnText">Light</span>';
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

        function filterUsers() {
            let input = document.getElementById('userSearch').value.toLowerCase().trim();
            let cards = document.querySelectorAll('#usersGridContainer .user-card');

            cards.forEach(card => {
                let searchData = card.getAttribute('data-search');
                if (searchData) {
                    if (input === "" || searchData.indexOf(input) > -1) {
                        card.style.display = "";
                    } else {
                        card.style.display = "none";
                    }
                }
            });
        }
    </script>

</body>
</html>