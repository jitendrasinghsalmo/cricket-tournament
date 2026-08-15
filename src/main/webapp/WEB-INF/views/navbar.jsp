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

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const links = document.querySelectorAll('#dynamicNavLinks .nav-item-link');
        const currentPath = window.location.pathname;

        // Page load hone par current URL ke hisab se active class lagayein
        links.forEach(link => {
            const hrefAttr = link.getAttribute('href');
            if (currentPath === hrefAttr || (currentPath === '/' && hrefAttr === '/home')) {
                link.classList.add('active');
            }

            // Jab user kisi bhi link par click kare
            link.addEventListener('click', function() {
                links.forEach(nav => nav.classList.remove('active'));
                this.classList.add('active');
            });
        });
    });
</script>