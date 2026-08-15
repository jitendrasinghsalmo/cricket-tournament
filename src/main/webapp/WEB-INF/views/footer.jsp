<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="grand-footer-section">
    <div class="grand-footer-content">
        <div class="footer-brand">
            <h3><span>ProMatch</span> Arena</h3>
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
            <ul>
                <li><a href="/home"><i class="fa-solid fa-angle-right"></i> Home Dashboard</a></li>
                <li><a href="/teams"><i class="fa-solid fa-angle-right"></i> View Teams</a></li>
                <li><a href="/register-team"><i class="fa-solid fa-angle-right"></i> Register Team</a></li>
                <li><a href="/matches"><i class="fa-solid fa-angle-right"></i> Live Matches</a></li>
                <li><a href="/tournaments"><i class="fa-solid fa-angle-right"></i> Tournaments</a></li>
            </ul>
        </div>

        <div class="footer-links">
            <h4>Standings & Stats</h4>
            <ul>
                <li><a href="/pointsTable"><i class="fa-solid fa-angle-right"></i> Points Table</a></li>
                <li><a href="/about"><i class="fa-solid fa-angle-right"></i> About Architecture</a></li>
                <li><a href="/faq"><i class="fa-solid fa-angle-right"></i> FAQ Help Center</a></li>
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
            <a href="/contact">Support</a>
        </div>
    </div>
</footer>