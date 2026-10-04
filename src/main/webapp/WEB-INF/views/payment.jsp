<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Secure Payment Gateway</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg-main: #030712;
            --bg-card: #0d121e;
            --card-surface: rgba(13, 18, 30, 0.75);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.25);
            --body-overlay: rgba(3, 7, 18, 0.85);
            --meta-box-bg: rgba(3, 7, 18, 0.55);
        }

        * { box-sizing: border-box; }
        html, body { width: 100%; overflow-x: hidden; }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%),
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary);
            margin: 0;
            padding: 0;
            min-height: 100vh;
            min-height: 100dvh;
            display: flex;
            flex-direction: column;
        }

        .page-content {
            flex: 1 0 auto;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: clamp(24px, 6vh, 56px) 16px;
        }

        .grand-footer-section { flex-shrink: 0; }

        .payment-card {
            width: 100%;
            max-width: 480px;
            background: var(--card-surface);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border-glass);
            border-radius: 22px;
            padding: clamp(26px, 5vh, 40px) clamp(20px, 6vw, 40px);
            box-shadow: 0 30px 60px rgba(0,0,0,0.45);
            position: relative;
            overflow: hidden;
        }
        .payment-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .card-header {
            text-align: center;
            margin-bottom: clamp(18px, 3.5vh, 28px);
        }

        .jumping-title {
            display: flex; align-items: center; justify-content: center; gap: 10px;
            color: var(--text-primary); margin: 0 0 8px 0; font-weight: 900;
            font-size: clamp(16px, 5vw, 24px); letter-spacing: 1px; text-transform: uppercase;
            white-space: nowrap;
        }
        .title-emoji { font-size: 1em; line-height: 1; }
        .jumping-title .accent { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }
        .subtitle { color: var(--text-secondary); font-size: clamp(11.5px, 3.3vw, 13px); margin: 0; font-weight: 500; line-height: 1.55; }

        /* Payment Summary Box */
        .summary-box {
            background: var(--meta-box-bg);
            border: 1px solid var(--border-glass);
            border-radius: 16px;
            padding: clamp(14px, 3vh, 22px) clamp(14px, 4vw, 22px);
            margin-bottom: clamp(18px, 3.5vh, 26px);
            display: flex;
            flex-direction: column;
            gap: clamp(10px, 1.8vh, 14px);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 14px;
            font-size: 13.5px;
        }

        .summary-label {
            color: var(--text-secondary);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-shrink: 0;
            text-transform: uppercase;
            letter-spacing: 0.4px;
            font-size: 12px;
        }

        .summary-val {
            color: var(--text-primary);
            font-weight: 800;
            text-align: right;
            min-width: 0;
            overflow-wrap: anywhere;
        }

        .summary-divider {
            border: none;
            border-top: 1px solid var(--border-glass);
            margin: 2px 0;
            width: 100%;
        }

        .amount-highlight {
            font-size: clamp(19px, 5.5vw, 24px);
            font-weight: 900;
            color: var(--neon-emerald);
            text-shadow: 0 0 10px rgba(16, 185, 129, 0.3);
        }

        /* Pay Button */
        .btn-pay {
            width: 100%;
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%);
            color: #ffffff;
            border: 1px solid rgba(56, 189, 248, 0.4);
            height: clamp(46px, 7vh, 54px);
            border-radius: 12px;
            font-weight: 800;
            font-size: 13.5px;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 0.6px;
        }
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(14, 165, 233, 0.5);
            background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%);
        }

        .security-badge {
            text-align: center;
            margin-top: clamp(14px, 2.5vh, 20px);
            color: var(--text-secondary);
            font-size: clamp(10.5px, 3vw, 11.5px);
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
        .security-badge i { color: var(--neon-cyan); }

        @media (max-width: 480px) {
            .payment-card { border-radius: 18px; }
            .jumping-title { letter-spacing: 0.5px; gap: 8px; }
            .summary-row { font-size: 13px; }
            .summary-label { font-size: 11px; }
        }

        /* 🌟 NAVBAR STYLING (matches navbar.jsp) */
        nav {
            background: rgba(10, 14, 39, 0.92);
            backdrop-filter: blur(25px);
            border-bottom: 1.5px solid var(--border-glass);
            padding: 14px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            position: sticky;
            top: 0;
            z-index: 1000;
            box-shadow: 0 15px 35px rgba(0,0,0,0.5);
        }

        /* 🌟 FOOTER STYLING (exact match with home.jsp) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,217,255,0.5); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        @media(max-width: 650px) { .footer-socials { justify-content: center; } }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(56, 189, 248, 0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #030712; transform: translateY(-3px); box-shadow: 0 0 15px rgba(56,189,248,0.6); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(56,189,248,0.3); }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; transition: 0.3s; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }

        /* =====================================================
           DARK + LIGHT MODE SYSTEM (same as Teams page)
           Text hamesha visible rahega
           ===================================================== */
        :root {
            --pm-nav-bg: rgba(10, 14, 39, 0.92);
            --pm-newsletter-bg: rgba(3, 7, 18, 0.7);
            --pm-footer-bg: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
            --pm-shadow: rgba(0, 0, 0, 0.45);
            --pm-placeholder: #64748b;
        }

        /* Light mode - data-theme / class, jo bhi toggle method ho sab cover hai */
        :root[data-theme="light"], :root[data-bs-theme="light"],
        :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
        body[data-theme="light"], body[data-bs-theme="light"],
        body.light, body.light-mode, body.light-theme, body.theme-light {
            --bg-main: #f1f5f9;
            --bg-card: #ffffff;
            --card-surface: rgba(255, 255, 255, 0.94);
            --body-overlay: rgba(238, 242, 247, 0.9);
            --meta-box-bg: #f1f5f9;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --border-glass: #cbd5e1;
            --neon-cyan: #0891b2;
            --neon-emerald: #059669;
            --neon-rose: #e11d48;
            --neon-amber: #d97706;
            --pm-nav-bg: rgba(255, 255, 255, 0.95);
            --pm-newsletter-bg: #ffffff;
            --pm-footer-bg: linear-gradient(135deg, #ffffff, #f1f5f9);
            --pm-shadow: rgba(15, 23, 42, 0.15);
            --pm-placeholder: #94a3b8;
        }

        /* Hardcoded dark backgrounds ab variables se chalenge */
        nav { background: var(--pm-nav-bg); }
        .grand-footer-section { background: var(--pm-footer-bg); }
        .footer-newsletter input { background: var(--pm-newsletter-bg); }
        .footer-newsletter input::placeholder { color: var(--pm-placeholder); opacity: 1; }
        .payment-card { box-shadow: 0 30px 60px var(--pm-shadow); }

        /* =====================================================
           FULL RESPONSIVE
           ===================================================== */
        img { max-width: 100%; height: auto; }

        @media (max-width: 900px) {
            nav { padding: 12px 20px; flex-wrap: wrap; gap: 10px; }
        }

        @media (max-width: 768px) {
            nav { padding: 10px 14px; }
            .grand-footer-section { padding: 36px 20px 24px 20px; width: calc(100% - 24px); margin-top: 30px; }
            .grand-footer-content { gap: 28px; }
            .footer-newsletter form { flex-direction: column; }
            .footer-bottom-links { flex-wrap: wrap; justify-content: center; }
        }

        @media (max-width: 480px) {
            .page-content { padding: 18px 12px; }
            .payment-card { padding: 22px 16px; }
            .btn-pay { font-size: 12.5px; }
        }

        @media (max-width: 360px) {
            .jumping-title { white-space: normal; flex-wrap: wrap; text-align: center; }
            .summary-row { flex-wrap: wrap; }
            .summary-val { text-align: left; }
        }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="page-content">
    <div class="payment-card">
        <div class="card-header">
            <h2 class="jumping-title"><span class="title-emoji">💳</span><span>Tournament <span class="accent">Checkout</span></span></h2>
            <p class="subtitle">Complete secure online fee transaction via Razorpay.</p>
        </div>

        <div class="summary-box">
            <div class="summary-row">
                <span class="summary-label"><i class="fa-solid fa-shield-cat" style="color: var(--neon-cyan);"></i> Team Name</span>
                <span class="summary-val">${sessionScope.pendingTeamName}</span>
            </div>
            <div class="summary-row">
                <span class="summary-label"><i class="fa-solid fa-location-dot" style="color: var(--neon-rose);"></i> City</span>
                <span class="summary-val">${sessionScope.pendingCity}</span>
            </div>
            <div class="summary-row">
                <span class="summary-label"><i class="fa-solid fa-user-tie" style="color: var(--neon-amber);"></i> Owner</span>
                <span class="summary-val">${sessionScope.pendingOwnerName}</span>
            </div>
            <hr class="summary-divider">
            <div class="summary-row" style="align-items: baseline;">
                <span class="summary-label"><i class="fa-solid fa-indian-rupee-sign" style="color: var(--neon-emerald);"></i> Total Amount</span>
                <span class="summary-val amount-highlight">₹${sessionScope.paymentAmount}</span>
            </div>
        </div>

        <button id="payBtn" class="btn-pay"><i class="fa-solid fa-lock"></i> Pay Now Securely</button>

        <div class="security-badge">
            <i class="fa-solid fa-shield-halved"></i> 256-Bit SSL Encrypted Razorpay Gateway
        </div>
    </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        document.getElementById('payBtn').onclick = function(e){
            var amount = "${sessionScope.paymentAmount}";
            var owner = "${sessionScope.pendingOwnerName}";

            $.ajax({
                url: '${pageContext.request.contextPath}/create-order',
                type: 'POST',
                data: { amount: amount },
                success: function (orderId) {
                    if(orderId.startsWith("Error")) {
                        alert(orderId);
                        return;
                    }

                    var options = {
                        "key": "${keyId}",
                        "amount": amount * 100, 
                        "currency": "INR",
                        "name": "Cricket Tournament",
                        "description": "Team Registration Fee",
                        "order_id": orderId,
                        "handler": function (response){
                            window.location.href = '${pageContext.request.contextPath}/payment-success?paymentId=' + response.razorpay_payment_id;
                        },
                        "prefill": {
                            "name": owner,
                            "email": "user@example.com",
                            "contact": "9999999999"
                        },
                        "theme": {
                            "color": "#10b981"
                        }
                    };
                    var rzp1 = new Razorpay(options);
                    rzp1.open();
                },
                error: function(err) {
                    alert("Order creation failed!");
                }
            });
        }
    </script>
</body>
</html>