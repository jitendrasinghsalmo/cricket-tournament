<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- 🌟 STICKY TOP NAVBAR -->
<nav>
    <a href="/home" class="logo-box">
        <div class="logo-icon">P</div>
        <div class="logo-text">ProMatch Arena <span>Tournament Control</span></div>
    </a>
    <ul class="nav-links d-none d-md-flex" id="dynamicNavLinks">
        <li><a href="/home" class="nav-item-link">Home</a></li>
        <li><a href="/teams" class="nav-item-link">Teams</a></li>
        <li><a href="/matches" class="nav-item-link">Matches</a></li>
        <li><a href="/tournaments" class="nav-item-link">Tournaments</a></li>
        <li><a href="/pointsTable" class="nav-item-link">Points Table</a></li>
    </ul>
</nav>

<style>
    /* Completely Normal Text Links (No Buttons, No Box Backgrounds) */
    .nav-links {
        list-style: none;
        margin: 0;
        padding: 0;
        display: flex;
        gap: 20px;
        align-items: center;
    }
    .nav-item-link {
        color: var(--text-secondary, #a8b8d8);
        text-decoration: none;
        font-size: 13.5px;
        font-weight: 700;
        padding: 4px 0;
        transition: color 0.2s ease;
        text-transform: uppercase;
        letter-spacing: 0.5px;
        background: none !important;
        border: none !important;
        box-shadow: none !important;
        border-radius: 0 !important;
    }
    .nav-item-link:hover {
        color: var(--neon-cyan, #00d9ff) !important;
        background: none !important;
        box-shadow: none !important;
    }
    .nav-item-link.active {
        color: var(--neon-cyan, #00d9ff) !important;
        background: none !important;
        box-shadow: none !important;
        border: none !important;
    }
</style>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const links = document.querySelectorAll('#dynamicNavLinks .nav-item-link');
        const currentPath = window.location.pathname;

        links.forEach(link => {
            const hrefAttr = link.getAttribute('href');
            if (currentPath === hrefAttr || (currentPath === '/' && hrefAttr === '/home')) {
                link.classList.add('active');
            }

            link.addEventListener('click', function() {
                links.forEach(nav => nav.classList.remove('active'));
                this.classList.add('active');
            });
        });
    });
</script>