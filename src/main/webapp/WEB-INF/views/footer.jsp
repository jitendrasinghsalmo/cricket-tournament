<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Role check (same as navbar): Role enum = ADMIN / USER -->
<c:set var="isAdmin" value="${sessionScope.user.role == 'ADMIN'}" />

<style>
    /* Footer Newsletter Button & Input Alignment */
    .footer-newsletter form { 
        display: flex; 
        gap: 8px; 
        align-items: center; 
    }
    .footer-newsletter input { 
        flex: 1; 
        background: #030712; 
        border: 1.5px solid var(--border-glass); 
        border-radius: 10px; 
        padding: 10px 14px; 
        color: var(--text-primary); 
        font-size: 12.5px; 
        outline: none; 
        height: 42px; 
    }
    .footer-newsletter button { 
        background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); 
        color: #030712; 
        border: none; 
        border-radius: 10px; 
        padding: 0 16px; 
        font-weight: 800; 
        font-size: 12.5px; 
        cursor: pointer; 
        transition: 0.3s; 
        height: 42px; 
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .footer-newsletter button:hover {
        transform: translateY(-2px);
        box-shadow: 0 0 15px rgba(0, 217, 255, 0.5);
    }

    /* Footer Bottom Bar Alignment & Exact Text Size */
    .footer-bottom-bar { 
        max-width: 1350px; 
        margin: 25px auto 0 auto; 
        display: flex; 
        justify-content: space-between; 
        align-items: center; 
        flex-wrap: wrap; 
        gap: 15px; 
        color: var(--text-primary); 
        font-size: 11.5px; 
        letter-spacing: 0.5px;
        padding-top: 20px;
        border-top: 1px solid rgba(0, 217, 255, 0.15);
    }
    .footer-bottom-bar p { 
        margin: 0; 
        font-size: 11.5px; 
        opacity: 0.95;
    }
    .footer-bottom-links { 
        display: flex; 
        gap: 20px; 
    }
    .footer-bottom-links a { 
        color: var(--neon-cyan); 
        text-decoration: none; 
        font-size: 11.5px; 
        font-weight: 600;
        transition: color 0.2s; 
    }
    .footer-bottom-links a:hover { 
        color: #ffffff; 
        text-decoration: underline; 
    }

    /* Brand title link (home / admin home) - looks exactly like plain heading */
    .footer-brand h3 a { color: inherit; text-decoration: none; font: inherit; }

    /* Active link highlight (same idea as navbar) */
    .footer-links a.active {
        color: var(--neon-cyan) !important;
        text-shadow: 0 0 10px rgba(56, 189, 248, 0.4);
    }
</style>

<style>
    /* ===== RESPONSIVE ADD-ON (original rules untouched) ===== */
    .grand-footer-section { max-width: 100%; overflow-x: clip; }
    .grand-footer-content > * { min-width: 0; }
    .footer-brand p, .footer-newsletter p, .footer-links a, .footer-bottom-bar p { overflow-wrap: anywhere; }
    .footer-socials { flex-wrap: wrap; }
    .footer-newsletter input { min-width: 0; }
    .footer-bottom-bar { box-sizing: border-box; width: 100%; }

    /* Tablet: brand + newsletter full width, link columns side by side */
    @media (max-width: 1023px) {
        .grand-footer-section { padding-left: 24px !important; padding-right: 24px !important; }
        .grand-footer-content {
            display: grid !important;
            grid-template-columns: repeat(2, minmax(0, 1fr)) !important;
            gap: 32px 28px !important;
        }
        .footer-brand, .footer-newsletter { grid-column: 1 / -1 !important; }
    }

    /* Phone: single column, centered bottom bar */
    @media (max-width: 575px) {
        .grand-footer-section { padding-left: 18px !important; padding-right: 18px !important; }
        .grand-footer-content {
            grid-template-columns: minmax(0, 1fr) !important;
            gap: 28px !important;
        }
        .footer-newsletter input { font-size: 16px; }   /* stops iOS zoom on focus */
        .footer-bottom-bar {
            flex-direction: column;
            justify-content: center;
            text-align: center;
            gap: 12px;
        }
        .footer-bottom-links { flex-wrap: wrap; justify-content: center; gap: 10px 18px; }
    }

    /* Very small phones: stack newsletter input and button */
    @media (max-width: 360px) {
        .footer-newsletter form { flex-direction: column; align-items: stretch; }
        .footer-newsletter button { width: 100%; }
    }
</style>

<footer class="grand-footer-section">
    <div class="grand-footer-content">
        <div class="footer-brand">
            <h3><a href="${isAdmin ? '/admin/home' : '/home'}"><span>ProMatch</span> Arena</a></h3>
            <p>Advanced Enterprise Cricket Tournament & Match Control Center. Built with Spring Boot, JSP, and PostgreSQL to deliver high-performance sports analytics.</p>
            <div class="footer-socials">
                <a href="https://www.linkedin.com/in/jitendra-singh-725698290/" target="_blank" title="LinkedIn"><i class="fa-brands fa-linkedin-in"></i></a>
                <a href="https://github.com/jitendrasinghsalmo" target="_blank" title="GitHub"><i class="fa-brands fa-github"></i></a>
                <a href="https://www.facebook.com/JitendraSinghSalmo" target="_blank" title="Facebook"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="https://x.com/JitendraSi31162" target="_blank" title="Twitter / X"><i class="fa-brands fa-twitter"></i></a>
                <a href="https://www.instagram.com/jitendra_singh_salmo/" target="_blank" title="Instagram"><i class="fa-brands fa-instagram"></i></a>
                <a href="https://www.youtube.com/@JitendraSalmo" target="_blank" title="YouTube"><i class="fa-brands fa-youtube"></i></a>
            </div>
        </div>
        
        <div class="footer-links">
            <h4>Quick Navigation</h4>
            <ul id="pmFooterNav">
                <c:choose>
                    <c:when test="${isAdmin}">
                        <li><a href="/admin/home"><i class="fa-solid fa-angle-right"></i> Home</a></li>
                        <li><a href="/admin/teams"><i class="fa-solid fa-angle-right"></i> Teams</a></li>
                        <li><a href="/admin/matches"><i class="fa-solid fa-angle-right"></i> Matches</a></li>
                        <li><a href="/admin/tournaments"><i class="fa-solid fa-angle-right"></i> Tournaments</a></li>
                        <li><a href="/admin/users"><i class="fa-solid fa-angle-right"></i> Users</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/home"><i class="fa-solid fa-angle-right"></i> Home</a></li>
                        <li><a href="/teams"><i class="fa-solid fa-angle-right"></i> View Teams</a></li>
                        <li><a href="/register-team"><i class="fa-solid fa-angle-right"></i> Register Team</a></li>
                        <li><a href="/matches"><i class="fa-solid fa-angle-right"></i> Live Matches</a></li>
                        <li><a href="/tournaments"><i class="fa-solid fa-angle-right"></i> Tournaments</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>

        <div class="footer-links">
            <h4>Standings & Stats</h4>
            <ul id="pmFooterStats">
                <c:choose>
                    <c:when test="${isAdmin}">
                        <li><a href="/admin/pointsTable"><i class="fa-solid fa-angle-right"></i> Points Table</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="/pointsTable"><i class="fa-solid fa-angle-right"></i> Points Table</a></li>
                    </c:otherwise>
                </c:choose>
                <!-- Common pages (same for admin and user) -->
                <li><a href="/about"><i class="fa-solid fa-angle-right"></i> About Architecture</a></li>
                <li><a href="/faq"><i class="fa-solid fa-angle-right"></i> FAQ Help Center</a></li>
                <li><a href="/rules"><i class="fa-solid fa-angle-right"></i> Rules & Regulations</a></li>
            </ul>
        </div>

        <div class="footer-newsletter">
            <h4>Stay Updated</h4>
            <p>Subscribe to get live tournament match updates, fixture alerts, and final standings directly.</p>
            <form onsubmit="event.preventDefault(); alert('Subscribed successfully to ProMatch Arena updates!');">
                <input type="email" placeholder="Enter your email..." required>
                <button type="submit">Join</button>
            </form>
        </div>
    </div>

    <div class="footer-bottom-bar">
        <p>&copy; 2026 ProMatch Arena &bull; All Rights Reserved. Crafted with high-end Cyber Glassmorphism UI.</p>
        <div class="footer-bottom-links">
            <a href="/privacy-policy">Privacy Policy</a>
            <a href="/terms-and-conditions">Terms & Conditions</a>
            <a href="/contact">Help & Support</a>
        </div>
    </div>
</footer>

<script>
    /* ===== Footer active link (by current URL, same logic as navbar) ===== */
    (function () {
        var links = document.querySelectorAll('#pmFooterNav a, #pmFooterStats a');
        var path = window.location.pathname.replace(/\/+$/, '') || '/';
        links.forEach(function (a) {
            var href = a.getAttribute('href');
            if (path === href || (path === '/' && href === '/home') || path.indexOf(href + '/') === 0) {
                a.classList.add('active');
            }
        });
    })();
</script>
