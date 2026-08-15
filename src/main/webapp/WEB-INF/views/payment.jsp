<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Secure Payment Gateway</title>
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --bg-deep: #030712;
            --card-surface: rgba(13, 18, 30, 0.92);
            --neon-cyan: #38bdf8;
            --neon-emerald: #10b981;
            --neon-rose: #f43f5e;
            --neon-amber: #f59e0b;
            --text-primary: #f8fafc;
            --text-secondary: #94a3b8;
            --border-glass: rgba(56, 189, 248, 0.22);
            --body-overlay: rgba(3, 7, 18, 0.94);
            --meta-box-bg: rgba(3, 7, 18, 0.6);
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
        }

        body { 
            font-family: 'Inter', system-ui, -apple-system, sans-serif; 
            background: linear-gradient(135deg, var(--body-overlay) 0%, var(--body-overlay) 100%), 
                        url('https://images.unsplash.com/photo-1540747913346-19e32dc3e97e?auto=format&fit=crop&w=1920&q=80') no-repeat center center fixed;
            background-size: cover;
            color: var(--text-primary); 
            margin: 0; 
            padding: 40px 20px; 
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            position: relative;
            box-sizing: border-box;
            transition: background 0.3s ease, color 0.3s ease;
        }

        /* Top Controls: Floating Back Button & Theme Toggle */
        .top-back-btn {
            position: absolute;
            top: 25px;
            left: 25px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            color: var(--neon-cyan);
            border: 1px solid var(--border-glass);
            padding: 10px 18px;
            border-radius: 12px;
            text-decoration: none;
            font-weight: 700;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            transition: all 0.2s ease;
            z-index: 100;
        }
        .top-back-btn:hover {
            background: var(--neon-cyan);
            color: #030712;
            box-shadow: 0 0 15px rgba(56, 189, 248, 0.5);
        }

        .theme-toggle-btn {
            position: absolute;
            top: 25px;
            right: 25px;
            background: var(--card-surface);
            backdrop-filter: blur(15px);
            color: var(--text-primary);
            border: 1px solid var(--border-glass);
            padding: 10px 16px;
            border-radius: 12px;
            font-size: 13px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            z-index: 100;
        }
        .theme-toggle-btn:hover {
            border-color: var(--neon-cyan);
            box-shadow: 0 0 12px rgba(56, 189, 248, 0.4);
        }

        .payment-card {
            width: 100%;
            max-width: 480px;
            background: var(--card-surface);
            backdrop-filter: blur(22px);
            border: 1px solid var(--border-glass);
            border-radius: 24px;
            padding: 35px;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
            position: relative;
            overflow: hidden;
            box-sizing: border-box;
            margin-top: 20px;
        }
        .payment-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--neon-cyan), var(--neon-emerald));
        }

        .card-header {
            text-align: center;
            margin-bottom: 25px;
        }

        .jumping-title {
            color: var(--text-primary); margin: 0 0 6px 0; font-weight: 900; font-size: 22px; letter-spacing: 1px; text-transform: uppercase;
        }
        .jumping-title span { color: var(--neon-cyan); text-shadow: 0 0 15px rgba(56, 189, 248, 0.5); }
        .subtitle { color: var(--text-secondary); font-size: 13px; margin: 0; font-weight: 500; }

        /* Payment Summary Box */
        .summary-box {
            background: var(--meta-box-bg);
            border: 1px solid var(--border-glass);
            border-radius: 16px;
            padding: 20px;
            margin-bottom: 25px;
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 13.5px;
        }

        .summary-label {
            color: var(--text-secondary);
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .summary-val {
            color: var(--text-primary);
            font-weight: 800;
        }

        .amount-highlight {
            font-size: 22px;
            font-weight: 900;
            color: var(--neon-emerald);
            text-shadow: 0 0 10px rgba(16, 185, 129, 0.3);
        }

        /* Pay Button */
        .btn-pay {
            width: 100%;
            background: linear-gradient(135deg, var(--neon-emerald), #059669);
            color: #030712;
            border: none;
            padding: 14px;
            border-radius: 14px;
            font-weight: 900;
            font-size: 15px;
            cursor: pointer;
            transition: all 0.25s ease;
            box-shadow: 0 5px 20px rgba(16, 185, 129, 0.4);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .btn-pay:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(16, 185, 129, 0.6);
        }

        .security-badge {
            text-align: center;
            margin-top: 20px;
            color: var(--text-secondary);
            font-size: 11.5px;
            font-weight: 600;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 6px;
        }
        .security-badge i { color: var(--neon-cyan); }
    </style>
    <script>
        window.addEventListener('DOMContentLoaded', function() {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.body.classList.add('light-theme');
                let btn = document.getElementById('themeBtnText');
                if(btn) btn.innerText = 'Light';
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
    </script>
</head>
<body>

    <!-- Top Left Floating Back Button -->
    <a href="/home" class="top-back-btn"><i class="fa-solid fa-arrow-left"></i> Dashboard</a>

    <!-- Top Right Theme Toggle Button -->
    <button class="theme-toggle-btn" id="themeToggleBtn" onclick="toggleTheme()">
        🌙 <span id="themeBtnText">Dark</span>
    </button>

    <div class="payment-card">
        <div class="card-header">
            <h2 class="jumping-title">Tournament <span>Checkout</span></h2>
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
            <hr style="border: none; border-top: 1px solid var(--border-glass); margin: 5px 0;">
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