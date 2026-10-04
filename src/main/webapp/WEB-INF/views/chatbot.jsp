<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- Chatbot and Scroll-to-Top CSS Styles -->
<style>
    /* 🌟 FLOATING AI CHATBOT */
    .chatbot-btn { 
        position: fixed; bottom: 92px; right: 25px; 
        background: linear-gradient(135deg, var(--accent-blue) 0%, #0284c7 100%); 
        color: #030712; width: 56px; height: 56px; border-radius: 50%; 
        display: flex; align-items: center; justify-content: center; 
        font-size: 23px; cursor: pointer; 
        box-shadow: 0 8px 30px rgba(56, 189, 248, 0.55), 0 0 0 3px rgba(56, 189, 248, 0.25); 
        z-index: 1001; border: none; transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    }
    .chatbot-btn:hover { 
        transform: scale(1.1) translateY(-3px); 
        box-shadow: 0 12px 35px rgba(56, 189, 248, 0.8), 0 0 0 5px rgba(56, 189, 248, 0.35); 
    }
    
    .chat-window {
        position: fixed; bottom: 158px; right: 25px; width: 360px;
        height: min(480px, calc(100vh - 180px));
        max-height: 480px;
        background: linear-gradient(135deg, #0d121e 0%, #0a0f1d 100%); 
        border: 1.5px solid var(--border-color); border-radius: 20px;
        box-shadow: 0 25px 60px rgba(0,0,0,0.8); z-index: 1002; display: none; 
        flex-direction: column; overflow: hidden; backdrop-filter: blur(20px);
    }
    .chat-window.open { display: flex; animation: slideUp 0.3s ease; }
    @keyframes slideUp { from { transform: translateY(18px); opacity: 0; } to { transform: translateY(0); opacity: 1; } }
    
    .chat-header { 
        background: linear-gradient(135deg, rgba(56, 189, 248, 0.2) 0%, rgba(16, 185, 129, 0.1) 100%);
        padding: 13px 18px; border-bottom: 1.5px solid var(--border-color); 
        display: flex; justify-content: space-between; align-items: center; 
        font-weight: 800; font-size: 14px; color: var(--accent-blue);
    }
    .chat-header button { background: none; border: none; color: var(--text-muted); font-size: 18px; cursor: pointer; transition: all 0.2s; }
    .chat-header button:hover { color: var(--accent-red); }
    
    .chat-body { flex: 1; padding: 15px; overflow-y: auto; display: flex; flex-direction: column; gap: 12px; font-size: 13px; }
    .chat-body::-webkit-scrollbar { width: 6px; }
    .chat-body::-webkit-scrollbar-track { background: rgba(56,189,248,0.1); border-radius: 10px; }
    .chat-body::-webkit-scrollbar-thumb { background: rgba(56,189,248,0.3); border-radius: 10px; }
    
    .chat-msg { padding: 10px 14px; border-radius: 12px; max-width: 88%; line-height: 1.5; word-wrap: break-word; }
    .chat-msg.bot { 
        background: rgba(56, 189, 248, 0.12); color: #e0f2fe; align-self: flex-start; 
        border: 1px solid rgba(56, 189, 248, 0.3); border-radius: 12px 12px 12px 3px;
    }
    .chat-msg.user { 
        background: linear-gradient(135deg, #38bdf8, #0284c7); color: #030712; 
        align-self: flex-end; font-weight: 600; border-radius: 12px 12px 3px 12px;
        box-shadow: 0 4px 12px rgba(56,189,248,0.3);
    }
    .chat-msg span { display: block; }
    
    .chat-footer { padding: 11px 14px; border-top: 1.5px solid var(--border-color); display: flex; gap: 8px; background: rgba(3,7,18,0.9); align-items: center; }
    .chat-footer input { 
        flex: 1; background: rgba(255,255,255,0.05); border: 1px solid var(--border-color); 
        border-radius: 8px; padding: 8px 12px; color: #fff; font-size: 13px; outline: none; transition: all 0.2s;
    }
    .chat-footer input:focus { border-color: var(--accent-blue); background: rgba(56,189,248,0.08); box-shadow: 0 0 10px rgba(56,189,248,0.2); }
    .chat-footer button { 
        background: linear-gradient(135deg, #38bdf8, #0284c7); color: #030712; 
        border: none; border-radius: 8px; padding: 8px 12px; font-weight: 700; 
        font-size: 12px; cursor: pointer; transition: all 0.2s; width: 40px; display: flex; align-items: center; justify-content: center;
    }
    .chat-footer button:hover { transform: scale(1.08); }
    .ai-typing { font-size: 12px; color: var(--accent-blue); padding: 0 16px 5px 16px; display: none; font-style: italic; }

    /* SCROLL TO TOP */
    .scroll-top { 
        position: fixed; bottom: 28px; right: 28px; background: rgba(56, 189, 248, 0.15); 
        color: var(--accent-blue); width: 50px; height: 50px; border-radius: 50%; 
        display: flex; align-items: center; justify-content: center; cursor: pointer; 
        border: 1.5px solid var(--border-color); transition: all 0.3s ease; opacity: 0; visibility: hidden; z-index: 999;
    }
    .scroll-top.show { opacity: 1; visibility: visible; }
    .scroll-top:hover { background: rgba(56, 189, 248, 0.25); transform: translateY(-4px); box-shadow: 0 0 20px rgba(56,189,248,0.4); }
</style>

<!-- 🌟 NEW: mobile responsive fix for chatbot (size on desktop unchanged) -->
<style>
    @media (max-width: 480px) {
        .chat-window { right: 10px; left: 10px; width: auto; bottom: 150px; }
        .chatbot-btn { right: 16px; bottom: 84px; }
        .scroll-top { right: 19px; bottom: 22px; }
        .chat-msg { max-width: 92%; }
    }
</style>

<!-- 🌟 NEW: DARK + LIGHT MODE SYSTEM (same method as teams.jsp) + CHIPS + CLEAR BUTTON -->
<style>
    :root {
        --cb-window-bg: linear-gradient(135deg, #0d121e 0%, #0a0f1d 100%);
        --cb-border: rgba(56, 189, 248, 0.28);
        --cb-shadow: 0 25px 60px rgba(0, 0, 0, 0.8);
        --cb-header-bg: linear-gradient(135deg, rgba(56, 189, 248, 0.2) 0%, rgba(16, 185, 129, 0.1) 100%);
        --cb-header-text: #38bdf8;
        --cb-icon: #94a3b8;
        --cb-icon-hover: #f43f5e;
        --cb-body-text: #e0f2fe;
        --cb-bot-bg: rgba(56, 189, 248, 0.12);
        --cb-bot-text: #e0f2fe;
        --cb-bot-border: rgba(56, 189, 248, 0.3);
        --cb-user-bg: linear-gradient(135deg, #38bdf8, #0284c7);
        --cb-user-text: #030712;
        --cb-footer-bg: rgba(3, 7, 18, 0.9);
        --cb-input-bg: rgba(255, 255, 255, 0.06);
        --cb-input-text: #ffffff;
        --cb-placeholder: rgba(255, 255, 255, 0.55);
        --cb-input-focus-bg: rgba(56, 189, 248, 0.10);
        --cb-accent: #38bdf8;
        --cb-send-bg: linear-gradient(135deg, #38bdf8, #0284c7);
        --cb-send-text: #030712;
        --cb-typing: #38bdf8;
        --cb-chips-bg: rgba(3, 7, 18, 0.6);
        --cb-chip-bg: rgba(56, 189, 248, 0.12);
        --cb-chip-text: #7dd3fc;
        --cb-chip-border: rgba(56, 189, 248, 0.35);
        --cb-chip-hover: rgba(56, 189, 248, 0.28);
        --cb-btn-bg: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        --cb-btn-text: #030712;
        --cb-top-bg: rgba(56, 189, 248, 0.15);
        --cb-top-text: #38bdf8;
        --cb-top-border: rgba(56, 189, 248, 0.28);
    }

    /* Light mode - jo bhi toggle method use ho, sab cover hai */
    :root[data-theme="light"], :root[data-bs-theme="light"], :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
        body[data-theme="light"], body[data-bs-theme="light"], body.light, body.light-mode, body.light-theme, body.theme-light {
        --cb-window-bg: linear-gradient(135deg, #ffffff 0%, #f1f5f9 100%);
        --cb-border: #cbd5e1;
        --cb-shadow: 0 25px 60px rgba(15, 23, 42, 0.28);
        --cb-header-bg: linear-gradient(135deg, #e0f2fe 0%, #dcfce7 100%);
        --cb-header-text: #075985;
        --cb-icon: #475569;
        --cb-icon-hover: #e11d48;
        --cb-body-text: #0f172a;
        --cb-bot-bg: #e0f2fe;
        --cb-bot-text: #0f172a;
        --cb-bot-border: #7dd3fc;
        --cb-user-bg: linear-gradient(135deg, #0284c7, #0369a1);
        --cb-user-text: #ffffff;
        --cb-footer-bg: #ffffff;
        --cb-input-bg: #f1f5f9;
        --cb-input-text: #0f172a;
        --cb-placeholder: #64748b;
        --cb-input-focus-bg: #ffffff;
        --cb-accent: #0284c7;
        --cb-send-bg: linear-gradient(135deg, #0284c7, #0369a1);
        --cb-send-text: #ffffff;
        --cb-typing: #0369a1;
        --cb-chips-bg: #f8fafc;
        --cb-chip-bg: #e0f2fe;
        --cb-chip-text: #075985;
        --cb-chip-border: #7dd3fc;
        --cb-chip-hover: #bae6fd;
        --cb-btn-bg: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
        --cb-btn-text: #ffffff;
        --cb-top-bg: #ffffff;
        --cb-top-text: #0284c7;
        --cb-top-border: #cbd5e1;
    }

    /* Hardcoded colors ab variables se chalenge (dono modes me text visible) */
    .chatbot-btn { background: var(--cb-btn-bg); color: var(--cb-btn-text); }
    .chat-window { background: var(--cb-window-bg); border-color: var(--cb-border); box-shadow: var(--cb-shadow); }
    .chat-header { background: var(--cb-header-bg); border-bottom-color: var(--cb-border); color: var(--cb-header-text); }
    .chat-header button { color: var(--cb-icon); }
    .chat-header button:hover { color: var(--cb-icon-hover); }
    .chat-body { color: var(--cb-body-text); }
    .chat-msg.bot { background: var(--cb-bot-bg); color: var(--cb-bot-text); border-color: var(--cb-bot-border); }
    .chat-msg.user { background: var(--cb-user-bg); color: var(--cb-user-text); }
    .chat-footer { background: var(--cb-footer-bg); border-top-color: var(--cb-border); }
    .chat-footer input { background: var(--cb-input-bg); color: var(--cb-input-text); border-color: var(--cb-border); }
    .chat-footer input::placeholder { color: var(--cb-placeholder); }
    .chat-footer input:focus { background: var(--cb-input-focus-bg); border-color: var(--cb-accent); }
    .chat-footer button { background: var(--cb-send-bg); color: var(--cb-send-text); }
    .ai-typing { color: var(--cb-typing); }
    .scroll-top { background: var(--cb-top-bg); color: var(--cb-top-text); border-color: var(--cb-top-border); }
    .chat-msg b { font-weight: 800; }
    .chat-msg i { opacity: 0.95; }

    .chat-head-actions { display: flex; align-items: center; gap: 6px; }
    .chat-head-actions button { padding: 2px 6px; }

    .chat-chips {
        display: flex; gap: 8px; overflow-x: auto; white-space: nowrap; padding: 8px 12px;
        border-top: 1px solid var(--cb-border); background: var(--cb-chips-bg); flex-shrink: 0;
        -webkit-overflow-scrolling: touch; scrollbar-width: thin;
    }
    .chat-chips::-webkit-scrollbar { height: 4px; }
    .chat-chips::-webkit-scrollbar-thumb { background: var(--cb-chip-border); border-radius: 10px; }
    .chat-chip {
        flex-shrink: 0; cursor: pointer; font-size: 11.5px; font-weight: 700; padding: 5px 12px; border-radius: 20px;
        color: var(--cb-chip-text); background: var(--cb-chip-bg); border: 1px solid var(--cb-chip-border);
        transition: all 0.2s ease; font-family: inherit;
    }
    .chat-chip:hover { background: var(--cb-chip-hover); transform: translateY(-1px); }
</style>

<!-- Chatbot & Scroll-to-Top HTML Elements -->
<button class="chatbot-btn" onclick="toggleChat()" title="Chat with ProMatch Assistant">
    <i class="fa-solid fa-comment-dots"></i>
</button>

<div class="chat-window" id="chatWindow">
    <div class="chat-header">
        <span><i class="fa-solid fa-robot me-1"></i> ProMatch Arena Assistant</span>
        <button onclick="toggleChat()">&times;</button>
    </div>
    <div class="chat-body" id="chatBody">
        <div class="chat-msg bot"><span>Hello! I am your ProMatch Arena virtual assistant. Feel free to ask about team registrations, live fixtures, tournament standings, or platform features.</span></div>
    </div>
    <div class="ai-typing" id="aiTyping"><i class="fa-solid fa-ellipsis"></i> ProMatch Assistant is typing...</div>
    <div class="chat-footer">
        <input type="text" id="chatInput" placeholder="Ask a question..." onkeypress="handleChatKey(event)">
        <button onclick="sendChatMessage()" title="Send"><i class="fa-solid fa-paper-plane"></i></button>
    </div>
</div>

<button class="scroll-top" id="scrollTopBtn" onclick="scrollToTop()" title="Back to top">
    <i class="fa-solid fa-arrow-up"></i>
</button>

<!-- Chatbot & Scroll-to-Top JavaScript Logic -->
<script>
    const chatbotKB = {
        "register": "Team Registration: You can register your squad by visiting the /register-team portal. It takes just two minutes to submit team details, logo, and captain roster.",
        "teams": "Teams: Access the 'View Teams' directory to explore all registered clubs, detailed player profiles, and squad performance statistics.",
        "matches": "Matches: Check the 'Live Matches' section for ball-by-ball updates, schedules, upcoming fixtures, and verified match results.",
        "points": "Points Table: Tournament standings and Net Run Rates (NRR) update automatically as soon as verified match results are logged.",
        "tournaments": "Tournaments: ProMatch Arena hosts multiple league tournaments each season with full automated bracket and points control.",
        "nrr": "NRR Engine: The integrated Net Run Rate calculator updates run rates dynamically upon scorecard submission, eliminating manual math.",
        "squad": "Squad Management: Easily add or modify players, assign jersey numbers, and manage starting lineups from your team management portal.",
        "admin": "Admin Control: Administrators have full privileges to create tournaments, schedule matches, approve teams, and maintain scorecards.",
        "live": "Live Telemetry: Track ball-by-ball updates, run rates, and active player statistics with real-time animated dashboards.",
        "app": "Mobile App: Download the ProMatch Arena application on Google Play and Apple App Store for real-time mobile push alerts and match telemetry.",
        "help": "Support: Need assistance? You can ask about registrations, standings, rules, or tournament administration.",
        "hello": "Hello! Welcome to ProMatch Arena. How may I assist you today?",
        "hi": "Hi there! Welcome to ProMatch Arena. How can I help you today?",
        "thanks": "You're very welcome! Feel free to ask if you need anything else.",
        "default": "I'd be glad to help! You can inquire about: register, teams, matches, points, tournaments, squad, or app features."
    };

    function toggleChat() {
        const win = document.getElementById("chatWindow");
        win.classList.toggle("open");
        if (win.classList.contains("open")) {
            setTimeout(() => document.getElementById("chatInput").focus(), 100);
        }
    }

    function handleChatKey(e) {
        if (e.key === 'Enter') {
            e.preventDefault();
            sendChatMessage();
        }
    }

    function getChatbotResponse(userText) {
        const text = userText.toLowerCase().trim();

        if (text.includes("kaise ho") || text.includes("how are you") || text.includes("how r u") || text.includes("kaisa hai") || text.includes("how you doing")) {
            return "I am doing exceptionally well, fully synchronized and ready to assist you! Matchday engines and live scorefeeds are running at optimal speed. How can I assist you with the tournament today?";
        }
        if (text.includes("or btao") || text.includes("aur batao") || text.includes("whats up") || text.includes("what's up") || text.includes("kya chal rha") || text.includes("kya chal raha") || text.includes("tell me more")) {
            return "The arena is electric today! Season 2026 is at Matchday 24, Titans XI posted an imposing 182/4, Strikers CC are preparing their chase, and points table calculations are standing by. What section would you like to review?";
        }
        if (text.includes("match") || text.includes("score") || text.includes("live") || text.includes("result") || text.includes("schedule") || text.includes("kaun jeeta")) {
            return "Live Match Overview: Titans XI scored 182/4 in 18.4 overs (CRR: 9.75) against Strikers CC at Grand Arena Stadium. Strikers CC are yet to bat. Full ball-by-ball updates and wagon wheels are available in the Live Matches tab!";
        }
        if (text.includes("points") || text.includes("table") || text.includes("standings") || text.includes("rank") || text.includes("nrr")) {
            return "Standings Telemetry: Points table ranks teams based on total points, wins, and automated Net Run Rate (NRR). Standings refresh live as soon as match referees approve official scorecards.";
        }

        for (const [key, response] of Object.entries(chatbotKB)) {
            if (text.includes(key)) {
                return response;
            }
        }
        return chatbotKB["default"];
    }

    function sendChatMessage() {
        const input = document.getElementById("chatInput");
        const body = document.getElementById("chatBody");
        const typingIndicator = document.getElementById("aiTyping");
        const text = input.value.trim();
        if (!text) return;

        const userDiv = document.createElement("div");
        userDiv.className = "chat-msg user";
        userDiv.innerHTML = "<span>" + text.replace(/</g, "&lt;").replace(/>/g, "&gt;") + "</span>";
        body.appendChild(userDiv);
        input.value = "";
        body.scrollTop = body.scrollHeight;

        typingIndicator.style.display = "block";
        body.scrollTop = body.scrollHeight;

        setTimeout(() => {
            typingIndicator.style.display = "none";
            const botDiv = document.createElement("div");
            botDiv.className = "chat-msg bot";
            const response = getChatbotResponse(text);
            botDiv.innerHTML = "<span>" + response + "</span>";
            body.appendChild(botDiv);
            body.scrollTop = body.scrollHeight;
        }, 600);
    }

    window.addEventListener('scroll', function() {
        const btn = document.getElementById("scrollTopBtn");
        if (document.body.scrollTop > 200 || document.documentElement.scrollTop > 200) {
            btn.classList.add("show");
        } else {
            btn.classList.remove("show");
        }
    });

    function scrollToTop() {
        window.scrollTo({ top: 0, behavior: 'smooth' });
    }
</script>

<!-- 🌟 NEW: SMART ENGLISH-ONLY BRAIN (overrides getChatbotResponse above) -->
<script>
    function getChatbotResponse(userText) {
        var t = userText.toLowerCase().replace(/[^a-z0-9\s'.\/-]/g, ' ').replace(/\s+/g, ' ').trim();

        function has() {
            for (var i = 0; i < arguments.length; i++) {
                var p = arguments[i];
                var re = (p instanceof RegExp) ? p : new RegExp('(^|\\s)' + p + '(\\s|$)');
                if (re.test(t)) return true;
            }
            return false;
        }
        function any() {
            for (var i = 0; i < arguments.length; i++) { if (t.indexOf(arguments[i]) !== -1) return true; }
            return false;
        }

        /* ---------- SMALL TALK ---------- */
        if (any('how are you', 'how r u', 'how are u', 'kaise ho', 'kaisa hai', 'kese ho', 'kya haal', 'how do you do', 'how you doing', "how's it going", 'hows it going')) {
            return "I'm doing great, thank you for asking! 😊 I'm fully charged and ready to help.<br>How are you? Ask me anything about matches, teams, points table, or cricket rules.";
        }
        if (any('where are you', 'where r u', 'where are u', 'kahan ho', 'kaha ho', 'where do you live', 'where you from', 'where are you from', 'your location', 'tum kahan')) {
            return "I am based in Bengaluru, India 📍 — but as a virtual assistant I'm online 24/7 right here at ProMatch Arena, wherever you are!";
        }
        if (any('who are you', 'your name', 'what are you', 'tum kaun', 'who made you', 'who created you', 'who built you')) {
            return "I'm the <b>ProMatch Arena Assistant</b> 🏏 — a virtual guide for the platform. I can help with team registration, live scores, fixtures, points table, NRR, tournament rules and cricket knowledge.";
        }
        if (any("what's up", 'whats up', 'wassup', 'aur batao', 'or btao', 'kya chal', 'tell me more', 'what is new', "what's new")) {
            return "The arena is buzzing! 🔥 Season 2026 is at Matchday 24 — Titans XI posted 182/4 and Strikers CC are about to chase.<br>Would you like the live score, upcoming fixtures, or the points table?";
        }
        if (any('thank', 'thanks', 'thx', 'shukriya', 'dhanyawad')) {
            return "You're most welcome! 😊 Happy to help anytime. Is there anything else you'd like to know?";
        }
        if (has('bye', 'goodbye', 'see you', 'see ya', 'good night', 'tata', 'alvida')) {
            return "Goodbye! 👋 Thanks for visiting ProMatch Arena. Come back soon for the next matchday!";
        }
        if (has('hello', 'hi', 'hey', 'hii', 'hiii', 'namaste', 'good morning', 'good afternoon', 'good evening', 'yo')) {
            return "Hello! 👋 Welcome to ProMatch Arena. I can help you with live scores, fixtures, team registration, points table, and cricket rules. What would you like to know?";
        }
        if (any('i am fine', "i'm fine", 'i am good', "i'm good", 'i am great', "i'm great", 'main theek', 'mai theek', 'all good', 'doing good', 'doing well')) {
            return "Glad to hear that! 😊 So, what would you like to explore today — live match, fixtures, standings, or team registration?";
        }
        if (any('you are great', 'you are awesome', 'good bot', 'nice bot', 'well done', 'great job', 'awesome', 'superb', 'nice work')) {
            return "Thank you so much! 🙏 That means a lot. Let me know if there's anything else I can help with.";
        }
        if (any('joke', 'funny')) {
            return "Why did the cricketer take a ladder to the match? Because he heard the bowler was delivering a <b>high full toss</b>! 😄";
        }

        /* ---------- PLATFORM: REGISTRATION & ACCOUNT ---------- */
        if (any('fee', 'price', 'cost', 'charges', 'payment', 'how much', 'entry fee', 'rupee')) {
            return "💰 <b>Team Registration Fee: ₹500</b> per team.<br>Sign up for a free account first, then register your team from the Register Team page. You can find more details on the Rules & Regulations page.";
        }
        if (any('sign up', 'signup', 'create account', 'new account', 'join', 'login', 'log in', 'sign in', 'account')) {
            return "🆕 <b>Creating an account is free!</b><br>1. Click <b>Sign Up Free</b> on the home page.<br>2. Fill in your details and submit.<br>3. Log in and start registering your team.<br>Already registered? Just log in with your credentials.";
        }
        if (any('register', 'registration', 'enroll', 'enrol', 'add my team', 'create team', 'new team')) {
            return "🛡️ <b>How to register your team:</b><br>1. Sign up / log in.<br>2. Open <b>Register Team</b> (/register-team).<br>3. Enter team name, logo and captain details.<br>4. Add your squad with jersey numbers.<br>5. Submit — the tournament admin reviews and approves it.<br>Registration fee: ₹500.";
        }
        if (any('rules', 'regulation', 'guideline', 'terms', 'policy', 'eligib')) {
            return "📜 <b>Rules & Regulations</b><br>Full tournament rules, eligibility and fee details are available on the <b>Rules & Regulations</b> page (link in the footer under FAQ Help Center).<br>Key points: verified rosters only, fair-play conduct, official scorecards decide results, and the admin's decision is final.";
        }
        if (any('password', 'forgot', 'reset')) {
            return "🔐 To change your password, open your <b>profile menu</b> in the top navbar and select <b>Change Password</b>. Enter your current password, then the new one, and save.";
        }
        if (any('profile', 'photo', 'picture', 'avatar')) {
            return "👤 Open the <b>profile dropdown</b> in the navbar to change or remove your photo, change your password, or log out.";
        }
        if (any('dark mode', 'light mode', 'theme', 'dark theme', 'light theme')) {
            return "🌗 Use the <b>theme toggle</b> in the navbar to switch between Dark and Light mode. Your choice is remembered across pages.";
        }
        if (any('contact', 'support', 'customer care', 'email us', 'phone number', 'helpline')) {
            return "📞 For support, scroll to the footer — you'll find contact details and the FAQ Help Center. You can also ask me about registrations, standings, rules or admin work.";
        }
        if (any('admin', 'organizer', 'organiser', 'role')) {
            return "🛠️ <b>Admin Role:</b> Admins can create tournaments, schedule matches, approve or reject teams, enter scorecards, and manage squads. Normal users can register teams, view fixtures, scores and standings.";
        }
        if (any('app', 'download', 'play store', 'google play', 'app store', 'android', 'ios', 'iphone', 'qr')) {
            return "📱 The <b>ProMatch Arena App</b> gives faster live scoring, real-time notifications and squad management on the go. Scan the QR code on the home page or use the Google Play / App Store buttons.";
        }

        /* ---------- PLATFORM: MATCH & TOURNAMENT INFO ---------- */
        if (any('live', 'score', 'scorecard', 'current match', 'ongoing', 'who won', 'who is winning', 'kaun jeeta', 'result', 'today match', 'match today')) {
            return "🔴 <b>Live Match — Matchday 24</b><br>🛡️ Titans XI: <b>182/4</b> (18.4 overs, CRR 9.75)<br>⚡ Strikers CC: <b>Yet to bat</b><br>Strikers CC need to chase a big target. Ball-by-ball updates are in the <b>Live Matches</b> tab.";
        }
        if (any('fixture', 'upcoming', 'schedule', 'next match', 'when is', 'timing', 'time table', 'timetable')) {
            return "🗓️ <b>Upcoming Fixtures</b><br>• Titans XI vs Strikers CC — Tomorrow, 7:30 PM<br>• Royal Hawks vs Thunder Kings — In 2 days, 3:00 PM<br>• Desert Lions vs Night Wolves — In 3 days, 7:30 PM";
        }
        if (any('points table', 'standing', 'ranking', 'rank', 'leaderboard table', 'table')) {
            return "📊 <b>Points Table</b><br>Teams are ranked by <b>total points</b>, then <b>wins</b>, then <b>Net Run Rate (NRR)</b>. It updates automatically once the admin approves an official scorecard. Titans XI currently lead after Matchday 24. Open the <b>Points Table</b> page for full standings.";
        }
        if (any('nrr', 'net run rate', 'run rate')) {
            return "🧮 <b>Net Run Rate (NRR)</b> = (Total runs scored ÷ Total overs faced) − (Total runs conceded ÷ Total overs bowled).<br>Example: 180 runs in 20 overs = 9.00; conceding 160 in 20 overs = 8.00 → NRR = <b>+1.00</b>.<br>ProMatch Arena calculates this automatically.";
        }
        if (any('playoff', 'knockout', 'semi', 'final', 'qualif', 'top four', 'top 4')) {
            return "🏆 <b>Playoffs:</b> The top four teams of the Championship Cup advance to the knockout stage, with floodlit night fixtures. Qualification is decided by points, then wins, then NRR.";
        }
        if (any('top performer', 'best player', 'top scorer', 'most runs', 'most wickets', 'orange cap', 'purple cap', 'man of the match', 'mvp')) {
            return "⭐ <b>Top Performers</b><br>#1 Virat K. — 612 runs<br>#2 Jasprit B. — 28 wickets<br>#3 Rohit S. — 548 runs<br>#4 Hardik P. — 340 runs + 14 wickets";
        }
        if (any('squad', 'player', 'roster', 'jersey', 'lineup', 'line-up', 'playing xi', 'captain')) {
            return "👥 <b>Squad Management:</b> Add or remove players, assign jersey numbers, set the captain and manage the lineup from your team portal. A team plays with <b>11 players</b> on the field.";
        }
        if (any('team', 'club')) {
            return "🛡️ Use <b>View Teams</b> to explore all registered clubs and their squads. Current teams in action: Titans XI, Strikers CC, Royal Hawks, Thunder Kings, Desert Lions and Night Wolves.";
        }
        if (any('tournament', 'season', 'championship', 'cup', 'league')) {
            return "🏆 <b>Championship Cup — Season 2026</b> is live and at Matchday 24. ProMatch Arena supports multiple leagues with automated fixtures, points tables, NRR and playoffs.";
        }
        if (any('stadium', 'venue', 'ground', 'pitch')) {
            return "🏟️ Matches are played at the <b>Grand Arena Stadium</b> with floodlights for night games and a hard-turf pitch verified by certified match referees.";
        }
        if (any('feature', 'what can you do', 'what do you do', 'about promatch', 'about this', 'about website', 'about platform')) {
            return "🏏 <b>ProMatch Arena</b> is a cricket tournament management platform with: live scoring, automated NRR & points table, secure role-based access (Admin / User), team registration, squad control and a mobile app.";
        }

        /* ---------- CRICKET KNOWLEDGE ---------- */
        if (any('what is cricket', 'about cricket', 'explain cricket', 'cricket kya', 'how to play cricket', 'how cricket')) {
            return "🏏 <b>Cricket</b> is a bat-and-ball game between two teams of 11 players. One team bats and tries to score runs; the other bowls and fields to take 10 wickets or limit runs. After both innings, the team with more runs wins.";
        }
        if (any('t20', 'odi', 'test match', 'format', 'overs', 'over ')) {
            return "⏱️ <b>Formats:</b><br>• <b>T20</b> — 20 overs per side (about 3 hours)<br>• <b>ODI</b> — 50 overs per side<br>• <b>Test</b> — up to 5 days, 2 innings per side<br>One over = 6 legal balls. ProMatch Arena matches follow the 20-over format.";
        }
        if (any('powerplay', 'power play')) {
            return "⚡ <b>Powerplay (T20):</b> The first 6 overs, where only 2 fielders are allowed outside the 30-yard circle — great for aggressive batting.";
        }
        if (any('dls', 'duckworth', 'rain')) {
            return "🌧️ <b>DLS Method:</b> Duckworth-Lewis-Stern sets a fair revised target when rain shortens a match, based on overs left and wickets in hand.";
        }
        if (any('super over', 'tie', 'tied', 'draw')) {
            return "🤝 <b>Tie-breaker:</b> If scores are level, a <b>Super Over</b> is played — each team bats 1 over (6 balls) with up to 2 wickets. The higher score wins. Tied or abandoned matches without a result typically give 1 point to each team.";
        }
        if (any('point system', 'how many points', 'win points', 'points for win', 'points system')) {
            return "🎯 <b>Typical points system:</b> Win = 2 points, Tie / No result = 1 point, Loss = 0. If teams are level on points, the higher <b>NRR</b> decides.";
        }
        if (any('lbw', 'leg before')) {
            return "🦵 <b>LBW (Leg Before Wicket):</b> A batter is out if the ball hits their leg or pad when it would have hit the stumps, provided it pitched in line or on the off side and the batter wasn't hit outside the line while playing a shot.";
        }
        if (any('wicket', 'dismissal', 'out', 'how can a batsman', 'ways to get out', 'ways of getting out')) {
            return "☝️ <b>Ways a batter can be out:</b> Bowled, Caught, LBW, Run Out, Stumped, Hit Wicket, Handled the Ball, Obstructing the Field, Hit the Ball Twice, and Timed Out.";
        }
        if (any('wide', 'no ball', 'no-ball', 'bye', 'leg bye', 'extra', 'free hit')) {
            return "➕ <b>Extras:</b><br>• <b>Wide</b> — ball too far to hit: +1 run and re-bowl<br>• <b>No-ball</b> — illegal delivery: +1 run, re-bowl and a <b>Free Hit</b> in limited-overs cricket<br>• <b>Bye / Leg bye</b> — runs taken without bat hitting the ball (legs bye: off the body)";
        }
        if (any('strike rate')) {
            return "📈 <b>Strike Rate</b> (batter) = (Runs ÷ Balls faced) × 100. Example: 45 runs off 30 balls = 150.";
        }
        if (any('economy')) {
            return "📉 <b>Economy Rate</b> (bowler) = Runs conceded ÷ Overs bowled. A lower economy is better.";
        }
        if (any('average', 'batting average', 'bowling average')) {
            return "📊 <b>Batting Average</b> = Runs scored ÷ Times dismissed.<br><b>Bowling Average</b> = Runs conceded ÷ Wickets taken.";
        }
        if (any('crr', 'rrr', 'required run rate', 'current run rate')) {
            return "📐 <b>CRR</b> (Current Run Rate) = Runs ÷ Overs bowled.<br><b>RRR</b> (Required Run Rate) = Runs needed ÷ Overs remaining.<br>Example: Titans XI's 182 in 18.4 overs gives a CRR of 9.75.";
        }
        if (any('batsman', 'batter', 'bowler', 'all-rounder', 'allrounder', 'all rounder', 'wicketkeeper', 'wicket keeper', 'keeper', 'fielder', 'opener')) {
            return "🧢 <b>Player roles:</b><br>• <b>Batter</b> — scores runs<br>• <b>Opener</b> — bats first in the order<br>• <b>Bowler</b> — delivers the ball (pace or spin)<br>• <b>All-rounder</b> — contributes with bat and ball<br>• <b>Wicketkeeper</b> — stands behind the stumps<br>• <b>Fielder</b> — stops runs and takes catches";
        }
        if (any('fielding', 'slip', 'gully', 'point', 'mid on', 'mid off', 'cover', 'square leg', 'fine leg', 'third man', 'silly')) {
            return "🧤 <b>Common fielding positions:</b> Slip, Gully, Point, Cover, Mid-off, Mid-on, Mid-wicket, Square leg, Fine leg, Third man, Long-on, Long-off. Placement depends on the bowler and batter.";
        }
        if (any('umpire', 'signal', 'third umpire', 'drs', 'review')) {
            return "🧑‍⚖️ <b>Umpires & DRS:</b> On-field umpires make the decisions. Teams can use the <b>Decision Review System (DRS)</b> to challenge LBW and catch decisions with ball-tracking and Snicko technology. The third umpire reviews close calls.";
        }
        if (any('boundary', 'four', 'six', 'sixer', 'maiden', 'century', 'hundred', 'fifty', 'duck', 'hat-trick', 'hat trick')) {
            return "🎯 <b>Cricket terms:</b><br>• <b>Four</b> — ball reaches the boundary after bouncing<br>• <b>Six</b> — ball clears the boundary on the full<br>• <b>Maiden</b> — an over with no runs<br>• <b>Fifty / Century</b> — 50 / 100 runs by a batter<br>• <b>Duck</b> — dismissed for 0<br>• <b>Hat-trick</b> — 3 wickets in 3 balls";
        }
        if (any('toss', 'coin')) {
            return "🪙 <b>Toss:</b> The two captains flip a coin before the match. The winner chooses to bat or bowl first.";
        }
        if (any('innings', 'inning')) {
            return "🔄 <b>Innings:</b> A team's turn to bat. In T20, each team gets one innings of up to 20 overs, or until 10 wickets fall.";
        }
        if (any('pitch report', 'spin', 'pace', 'swing', 'seam', 'bouncer', 'yorker', 'googly', 'doosra')) {
            return "🎳 <b>Bowling types:</b><br>• <b>Pace / Seam / Swing</b> — fast bowlers using movement in the air or off the pitch<br>• <b>Spin</b> — off-spin, leg-spin, googly, doosra<br>• <b>Yorker</b> — full ball aimed at the batter's feet<br>• <b>Bouncer</b> — short, fast ball rising at head height";
        }
        if (any('cricket')) {
            return "🏏 I can explain cricket formats, rules, scoring, dismissals, extras, player roles, NRR and more. Try asking: <i>What is a powerplay?</i> or <i>How is NRR calculated?</i>";
        }
        if (any('match')) {
            return "🏏 <b>Matches:</b> Check <b>Live Matches</b> for ball-by-ball updates, scores and results. Ask me for the <i>live score</i> or <i>upcoming fixtures</i> and I'll share them right here.";
        }
        if (any('help')) {
            return "🤝 I'm happy to help! You can ask me about:<br>• Live score & fixtures<br>• Points table & NRR<br>• Team registration & fee<br>• Rules & tournament info<br>• Cricket rules & terms<br>• Admin, app & account help";
        }

        /* ---------- FALLBACK ---------- */
        return "I'd love to help, but I didn't quite get that. 🤔 Try asking about:<br>• <b>Live score</b> or <b>fixtures</b><br>• <b>Points table</b> / <b>NRR</b><br>• <b>Team registration</b> & fee<br>• <b>Cricket rules</b> (powerplay, LBW, extras...)";
    }
</script>

<!-- 🌟 NEW: EXTRA BRAIN (calculators, facts, tips, fun talk) + QUICK CHIPS + CLEAR CHAT -->
<script>
(function () {
    var prevBrain = window.getChatbotResponse;

    function nums(s) { var m = s.match(/\d+(?:\.\d+)?/g); return m ? m.map(Number) : []; }
    function ov(o) { var w = Math.floor(o), b = Math.round((o - w) * 10); return (b >= 0 && b <= 5) ? (w + b / 6) : o; }
    function r2(x) { return (Math.round(x * 100) / 100).toFixed(2); }
    function pick(a) { return a[Math.floor(Math.random() * a.length)]; }

    var facts = [
        "The cricket pitch is <b>22 yards (20.12 m)</b> long.",
        "Sachin Tendulkar is the only player with <b>100 international centuries</b>.",
        "The first Cricket World Cup was held in <b>1975</b> in England.",
        "India won the ODI World Cup in <b>1983</b> and <b>2011</b>, and the T20 World Cup in <b>2007</b> and <b>2024</b>.",
        "Brian Lara holds the highest individual Test score: <b>400 not out</b>.",
        "Muttiah Muralitharan holds the record for most Test wickets: <b>800</b>.",
        "The first IPL season was played in <b>2008</b> and was won by Rajasthan Royals.",
        "A standard cricket ball weighs about <b>156–163 grams</b> and is made of cork, wrapped in leather.",
        "In Test cricket, a team can bat for up to <b>5 days</b> across two innings."
    ];
    var tips = {
        bat: "🏏 <b>Batting tips:</b> Watch the ball closely, keep your head still, play straight early on, rotate the strike with singles, and attack only the loose balls.",
        bowl: "🎳 <b>Bowling tips:</b> Stick to a consistent line and length, vary your pace, mix in a yorker at the death, and set the batter up with plans.",
        field: "🧤 <b>Fielding tips:</b> Stay low and alert, keep your eyes on the ball, throw to the stumps, and always back up the throw.",
        cap: "🧠 <b>Captaincy tips:</b> Read the pitch, rotate bowlers smartly, set attacking fields in the powerplay, and communicate clearly with the team."
    };
    var names = ["Thunder Strikers", "Royal Challengers XI", "Blazing Hawks", "Storm Chasers", "Desert Falcons", "Night Riders", "Golden Lions", "Steel Panthers", "Phoenix Warriors", "Cyber Titans", "Velocity XI", "Raging Rhinos"];
    var topics = "• Live score &amp; fixtures<br>• Points table &amp; NRR<br>• Registration &amp; fee<br>• Rules<br>• Cricket facts &amp; tips<br>• Calculators (NRR, strike rate, economy, run rate)";

    window.getChatbotResponse = function (userText) {
        var t = userText.toLowerCase().replace(/[^a-z0-9\s'.\/-]/g, ' ').replace(/\s+/g, ' ').trim();
        var n = nums(t);
        function any() { for (var i = 0; i < arguments.length; i++) { if (t.indexOf(arguments[i]) !== -1) return true; } return false; }

        /* --- simple follow-ups --- */
        if (/^(yes|yeah|yep|yup|sure|ok|okay|ya|yea|haan|ha|please)$/.test(t)) {
            return "Great! 😊 Pick a topic and I'll dive in:<br>" + topics;
        }
        if (/^(no|nope|nah|nothing|no thanks|not now|nahi)$/.test(t)) {
            return "No problem! 👍 I'm right here whenever you need me.";
        }
        if (any('menu', 'options', 'topics', 'what can i ask', 'what can you answer')) {
            return "Here's what you can ask me:<br>" + topics;
        }

        /* --- calculators (need numbers) --- */
        if (any('nrr', 'net run rate') && n.length >= 4) {
            var v = n[0] / ov(n[1]) - n[2] / ov(n[3]);
            return "🧮 <b>NRR</b> = (" + n[0] + " ÷ " + r2(ov(n[1])) + ") − (" + n[2] + " ÷ " + r2(ov(n[3])) + ")<br>= <b>" + (v >= 0 ? "+" : "") + r2(v) + "</b>";
        }
        if (any('strike rate', 'sr ') && n.length >= 2) {
            return "📈 <b>Strike Rate</b> = (" + n[0] + " ÷ " + n[1] + ") × 100 = <b>" + r2(n[0] / n[1] * 100) + "</b>";
        }
        if (any('economy') && n.length >= 2) {
            return "📉 <b>Economy Rate</b> = " + n[0] + " ÷ " + r2(ov(n[1])) + " overs = <b>" + r2(n[0] / ov(n[1])) + "</b> runs per over";
        }
        if (any('rrr', 'required run rate', 'required rate') && n.length >= 2) {
            return "📐 <b>Required Run Rate</b> = " + n[0] + " ÷ " + r2(ov(n[1])) + " overs = <b>" + r2(n[0] / ov(n[1])) + "</b>";
        }
        if (any('crr', 'current run rate', 'run rate') && !any('nrr', 'net run rate') && n.length >= 2) {
            return "📐 <b>Current Run Rate</b> = " + n[0] + " ÷ " + r2(ov(n[1])) + " overs = <b>" + r2(n[0] / ov(n[1])) + "</b>";
        }
        if (any('average') && n.length >= 2) {
            return "📊 <b>Average</b> = " + n[0] + " ÷ " + n[1] + " = <b>" + r2(n[0] / n[1]) + "</b>";
        }
        if (any('calculator', 'calculate', 'calc')) {
            return "🧮 <b>I can calculate for you!</b> Try:<br>• <i>nrr 180 20 160 20</i> (runs scored, overs, runs conceded, overs)<br>• <i>strike rate 45 30</i> (runs, balls)<br>• <i>economy 32 4</i> (runs, overs)<br>• <i>crr 120 10</i> (runs, overs)<br>• <i>rrr 60 6</i> (runs needed, overs left)<br>• <i>average 450 9</i> (runs, dismissals)";
        }

        /* --- date & time --- */
        if (/(what|current|tell).*(time|date|day)|time now|today.?s date|which day/.test(t) && !any('match', 'fixture', 'game', 'play', 'toss', 'schedule')) {
            var d = new Date();
            return "🕒 It's <b>" + d.toLocaleTimeString('en-IN', { hour: '2-digit', minute: '2-digit' }) + "</b> on <b>" + d.toLocaleDateString('en-IN', { weekday: 'long', day: 'numeric', month: 'long', year: 'numeric' }) + "</b>.";
        }

        /* --- facts, records, history --- */
        if (any('fact', 'trivia', 'did you know', 'interesting', 'something new')) {
            return "💡 <b>Cricket fact:</b> " + pick(facts);
        }
        if (any('world cup')) {
            return "🌍 <b>World Cups:</b> The first Cricket World Cup was in 1975. India won the ODI World Cup in 1983 and 2011, and the T20 World Cup in 2007 and 2024.";
        }
        if (any('ipl', 'indian premier')) {
            return "🏆 The <b>IPL</b> started in 2008 and is one of the biggest T20 leagues in the world, with franchise teams, auctions and a playoff stage.";
        }
        if (any('record', 'highest score', 'most runs ever', 'most wickets ever', 'most centuries')) {
            return "📚 <b>Famous records:</b><br>• Most international centuries: Sachin Tendulkar (100)<br>• Highest Test score: Brian Lara (400*)<br>• Most Test wickets: Muttiah Muralitharan (800)<br>• Highest ODI score: Rohit Sharma (264)";
        }
        if (any('sachin', 'tendulkar')) {
            return "👑 Sachin Tendulkar is the only player with 100 international centuries and one of the greatest batters ever.";
        }
        if (any('dhoni', 'ms dhoni')) {
            return "🧢 MS Dhoni captained India to the 2007 T20 World Cup, 2011 ODI World Cup and 2013 Champions Trophy — famous for his calm finishing.";
        }
        if (any('kohli', 'virat')) {
            return "🔥 Virat Kohli is known for his chasing ability and holds the record for most ODI centuries.";
        }
        if (any('pitch length', 'how long is the pitch', 'ground size', 'stump height', 'bat size', 'ball weight', 'equipment')) {
            return "📏 <b>Basics:</b> Pitch = 22 yards (20.12 m). Stumps = 28.5 inches high. Ball = about 156–163 g. A bat's blade is up to 4.25 inches wide and the bat is up to 38 inches long.";
        }

        /* --- tips & ideas --- */
        if (any('batting tip', 'how to bat', 'improve batting', 'batting advice')) { return tips.bat; }
        if (any('bowling tip', 'how to bowl', 'improve bowling', 'bowling advice')) { return tips.bowl; }
        if (any('fielding tip', 'improve fielding')) { return tips.field; }
        if (any('captain tip', 'captaincy', 'how to captain')) { return tips.cap; }
        if (any('tip', 'advice', 'improve', 'coach')) {
            return "🎓 <b>Pick a tip:</b> Ask for <i>batting tips</i>, <i>bowling tips</i>, <i>fielding tips</i> or <i>captaincy tips</i>.";
        }
        if (any('team name', 'name idea', 'suggest name', 'naming')) {
            var a = [], k = 0;
            while (k < 5) { var c = pick(names); if (a.indexOf(c) === -1) { a.push(c); k++; } }
            return "🛡️ <b>Team name ideas:</b><br>• " + a.join("<br>• ") + "<br>Ask again for fresh ideas!";
        }
        if (any('best xi', 'ideal xi', 'team composition', 'team balance', 'combination', 'how many batsmen', 'how many bowlers')) {
            return "⚖️ <b>A balanced XI:</b> 5–6 specialist batters (including the wicketkeeper), 1–2 all-rounders and 4–5 bowlers (2–3 pace, 1–2 spin).";
        }

        /* --- bot personality & fun --- */
        if (any('how old', 'your age', 'when were you born')) {
            return "I'm a virtual assistant, so I don't age 😄 — but I'm always up to date with ProMatch Arena!";
        }
        if (any('are you human', 'are you real', 'are you a robot', 'are you ai', 'are you a bot', 'are you bot')) {
            return "I'm a virtual assistant built for ProMatch Arena 🤖 — not a human, but I'll do my best to help like a good teammate!";
        }
        if (any('do you sleep', 'are you online', 'are you there')) {
            return "I'm online 24/7 ⚡ — ask me anything, anytime.";
        }
        if (any('hindi', 'language', 'speak', 'english')) {
            return "I communicate in <b>English</b> here 🇬🇧 — just type your question and I'll reply clearly.";
        }
        if (any('weather', 'forecast', 'rain today')) {
            return "☁️ I can't check live weather, but if rain stops a match, the <b>DLS method</b> sets a fair revised target. Always check the match page for updates.";
        }
        if (any('favorite team', 'favourite team', 'favorite player', 'favourite player', 'who will win', 'predict', 'prediction', 'who is better')) {
            return "🔮 I stay neutral, but right now <b>Titans XI</b> are in strong form with 182/4. Strikers CC will need a great chase!";
        }
        if (any('bored', 'boring')) {
            return "Let's fix that! 🎉 Ask for a <i>cricket fact</i>, a <i>joke</i>, <i>team name ideas</i> or try the <i>calculator</i>.";
        }
        if (any('sad', 'tired', 'upset', 'angry', 'stressed')) {
            return "Sorry to hear that 💙 Take a deep breath — a little cricket always helps. Want a fun fact or the live score?";
        }
        if (any('love you', 'i like you', 'you are cute', 'you are nice')) {
            return "That's very kind of you! 😊 I'm here to make your ProMatch Arena experience smooth.";
        }
        if (any('sorry', 'my bad', 'oops')) {
            return "No worries at all! 😊 How can I help you?";
        }

        return prevBrain(userText);
    };

    /* ---------- UI: quick chips + clear button ---------- */
    function initUI() {
        var win = document.getElementById('chatWindow');
        var body = document.getElementById('chatBody');
        if (!win || !body || win.getAttribute('data-ext') === '1') return;
        win.setAttribute('data-ext', '1');

        var welcome = body.innerHTML;

        /* chips bar (just above the input) */
        var footer = win.querySelector('.chat-footer');
        var bar = document.createElement('div');
        bar.className = 'chat-chips';
        var items = [
            ['Live score', 'live score'], ['Fixtures', 'upcoming fixtures'], ['Points table', 'points table'],
            ['Register team', 'how to register'], ['Fee', 'registration fee'], ['NRR', 'what is nrr'],
            ['Cricket facts', 'cricket fact'], ['Tips', 'tips'], ['Calculator', 'calculator'], ['Rules', 'rules']
        ];
        items.forEach(function (it) {
            var b = document.createElement('button');
            b.type = 'button'; b.className = 'chat-chip'; b.textContent = it[0];
            b.onclick = function () {
                document.getElementById('chatInput').value = it[1];
                sendChatMessage();
            };
            bar.appendChild(b);
        });
        win.insertBefore(bar, footer);

        /* clear chat button next to the close button */
        var head = win.querySelector('.chat-header');
        var closeBtn = head.querySelector('button');
        var wrap = document.createElement('div');
        wrap.className = 'chat-head-actions';
        var clr = document.createElement('button');
        clr.type = 'button'; clr.title = 'Clear chat';
        clr.innerHTML = '<i class="fa-solid fa-rotate-right"></i>';
        clr.onclick = function () { body.innerHTML = welcome; };
        head.replaceChild(wrap, closeBtn);
        wrap.appendChild(clr);
        wrap.appendChild(closeBtn);
    }
    if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', initUI); } else { initUI(); }
})();
</script>
