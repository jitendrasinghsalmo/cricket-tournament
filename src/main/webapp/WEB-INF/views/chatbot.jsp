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