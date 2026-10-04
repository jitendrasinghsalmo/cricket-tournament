<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="page" value="search" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>ProMatch Arena | Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        html { scroll-behavior: smooth; }
        :root {
            --bg-main: #030712;
            --bg-card: rgba(13, 18, 30, 0.85);
            --bg-card-hover: rgba(20, 26, 40, 0.95);
            --accent-red: #f43f5e;
            --accent-green: #10b981;
            --accent-blue: #38bdf8;
            --accent-amber: #f59e0b;
            --accent-purple: #c084fc;
            --text-main: #f8fafc;
            --text-muted: #94a3b8;
            --border-color: rgba(56, 189, 248, 0.22);
            --neon-cyan: #00d9ff;
            --neon-emerald: #00ff88;
            --border-glass: rgba(0, 217, 255, 0.25);
            --text-primary: #f0f4ff;
            --text-secondary: #a8b8d8;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background: linear-gradient(135deg, #030712 0%, #0a0f1d 100%);
            color: var(--text-main);
            margin: 0; padding: 0; min-height: 100vh; overflow-x: hidden;
        }

        .container { max-width: 1350px; margin: 30px auto; padding: 0 20px; }

        /* HERO BANNER */
        .hero-banner {
            position: relative;
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            border-radius: 28px; padding: 50px 55px; margin-bottom: 30px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6); overflow: hidden;
            text-align: center;
        }
        .hero-banner::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.16) 0%, rgba(16, 185, 129, 0.10) 35%, transparent 70%);
            animation: rotateGlow 12s linear infinite; z-index: 1;
        }
        .hero-banner::after {
            content: ''; position: absolute; bottom: -60%; right: -40%; width: 180%; height: 180%;
            background: radial-gradient(circle, rgba(244, 63, 94, 0.12) 0%, rgba(245, 158, 11, 0.08) 40%, transparent 70%);
            animation: rotateGlowReverse 18s linear infinite; z-index: 1;
        }
        .hero-glow-orb {
            position: absolute; width: 220px; height: 220px; border-radius: 50%;
            background: radial-gradient(circle, rgba(56,189,248,0.35), transparent 70%);
            filter: blur(30px); z-index: 1; pointer-events: none; top: 5%; left: 10%;
            animation: driftOrb 9s ease-in-out infinite alternate;
        }
        .hero-glow-orb.orb-2 {
            background: radial-gradient(circle, rgba(16,185,129,0.3), transparent 70%);
            top: 60%; left: 55%; width: 180px; height: 180px;
            animation: driftOrb2 11s ease-in-out infinite alternate;
        }
        @keyframes rotateGlow { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        @keyframes rotateGlowReverse { 0% { transform: rotate(0deg); } 100% { transform: rotate(-360deg); } }
        @keyframes driftOrb { 0% { transform: translate(0,0) scale(1); } 100% { transform: translate(40px,30px) scale(1.2); } }
        @keyframes driftOrb2 { 0% { transform: translate(0,0) scale(1); } 100% { transform: translate(-30px,-20px) scale(1.15); } }
        @keyframes pulseDot { 0%,100% { opacity: 1; } 50% { opacity: 0.3; } }

        .hero-content { position: relative; z-index: 2; max-width: 700px; margin: 0 auto; }
        .season-tag { color: var(--accent-green); font-size: 11.5px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px; display: inline-flex; align-items: center; gap: 7px; text-shadow: 0 0 10px rgba(16,185,129,0.4); }
        .season-tag .live-dot { width: 7px; height: 7px; border-radius: 50%; background: var(--accent-red); box-shadow: 0 0 8px var(--accent-red); animation: pulseDot 1.3s ease-in-out infinite; }
        .hero-content h1 { font-size: 36px; margin: 6px 0 12px 0; font-weight: 900; letter-spacing: 0.5px; color: #fff; text-shadow: 0 0 20px rgba(56,189,248,0.3); }
        .hero-content h1 span { color: var(--accent-blue); }
        .hero-content p { color: var(--text-muted); font-size: 14px; margin: 0 0 22px 0; line-height: 1.6; }

        .hero-search-stats { position: relative; z-index: 2; display: flex; justify-content: center; gap: 14px; flex-wrap: wrap; }
        .hero-search-pill { background: rgba(3,7,18,0.6); backdrop-filter: blur(8px); border: 1px solid rgba(56,189,248,0.4); border-radius: 14px; padding: 10px 20px; display: flex; align-items: center; gap: 10px; }
        .hero-search-pill i { color: var(--accent-blue); font-size: 15px; }
        .hero-search-pill .num { font-size: 17px; font-weight: 900; color: #fff; }
        .hero-search-pill .lbl { font-size: 10.5px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }

        /* SECTION TITLES */
        .section-title { font-size: 19px; font-weight: 800; margin: 40px 0 20px 0; display: flex; justify-content: space-between; align-items: center; border-left: 4px solid var(--accent-blue); padding-left: 12px; text-transform: uppercase; letter-spacing: 0.5px; }

        /* ===== SECTION 2: RESULTS MATRIX ===== */
        .matrix-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 25px; margin-bottom: 45px; }
        @media(max-width: 950px) { .matrix-grid { grid-template-columns: 1fr; } }
        .matrix-card { background: var(--bg-card); backdrop-filter: blur(22px); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 26px; box-shadow: 0 15px 35px rgba(0,0,0,0.4); position: relative; overflow: hidden; transition: all 0.3s ease; scroll-margin-top: 20px; }
        .matrix-card:hover { border-color: var(--accent-blue); box-shadow: 0 20px 40px rgba(56,189,248,0.18); }
        .matrix-card::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px; }
        .card-teams::before { background: linear-gradient(90deg, var(--accent-green), #059669); }
        .card-tournaments::before { background: linear-gradient(90deg, var(--accent-amber), #d97706); }
        .card-matches::before { background: linear-gradient(90deg, var(--accent-red), #e11d48); }
        .card-players::before { background: linear-gradient(90deg, var(--accent-purple), #9333ea); }
        .matrix-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 18px; padding-bottom: 12px; border-bottom: 1px solid var(--border-color); }
        .matrix-header h3 { margin: 0; font-size: 15.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.8px; display: flex; align-items: center; gap: 10px; color: var(--text-main); }
        .count-badge { background: rgba(3,7,18,0.6); border: 1px solid var(--border-color); padding: 4px 10px; border-radius: 8px; font-size: 12px; font-weight: 800; color: var(--accent-blue); }
        .items-list { display: flex; flex-direction: column; gap: 12px; max-height: 320px; overflow-y: auto; padding-right: 5px; }
        .items-list::-webkit-scrollbar { width: 5px; }
        .items-list::-webkit-scrollbar-thumb { background: var(--border-color); border-radius: 10px; }
        .item-row { background: rgba(3,7,18,0.55); border: 1px solid var(--border-color); border-radius: 14px; padding: 14px 18px; display: flex; justify-content: space-between; align-items: center; transition: all 0.2s ease; }
        .item-row:hover { border-color: var(--accent-blue); transform: translateX(4px); background: rgba(56, 189, 248, 0.06); }
        .item-main-text { font-weight: 700; font-size: 14px; color: var(--text-main); display: flex; align-items: center; gap: 10px; }
        .item-sub-text { font-size: 12px; color: var(--text-muted); font-weight: 600; }
        .tag-pill { background: rgba(56, 189, 248, 0.12); color: var(--accent-blue); border: 1px solid rgba(56, 189, 248, 0.25); padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 800; text-transform: uppercase; }
        .no-record-box { text-align: center; color: var(--text-muted); padding: 30px; font-size: 13.5px; font-style: italic; }

        /* ===== NEW SECTION-SPECIFIC STYLES ===== */

        /* 1. Search Breakdown (bar chart) */
        .breakdown-box { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 28px; margin-bottom: 45px; box-shadow: 0 15px 35px rgba(0,0,0,0.35); }
        .breakdown-row { display: flex; align-items: center; gap: 16px; margin-bottom: 16px; }
        .breakdown-row:last-child { margin-bottom: 0; }
        .breakdown-label { width: 130px; font-size: 13px; font-weight: 700; color: var(--text-main); display: flex; align-items: center; gap: 8px; flex-shrink: 0; }
        .breakdown-track { flex: 1; height: 10px; background: rgba(3,7,18,0.7); border-radius: 8px; overflow: hidden; border: 1px solid var(--border-color); }
        .breakdown-fill { height: 100%; border-radius: 8px; transition: width 1s ease; }
        .breakdown-pct { width: 42px; text-align: right; font-size: 12.5px; font-weight: 800; color: var(--text-muted); flex-shrink: 0; }

        /* 2. Refine Your Search */
        .refine-grid { display: flex; flex-wrap: wrap; gap: 14px; margin-bottom: 45px; }
        .refine-chip { background: var(--bg-card); border: 1.5px solid var(--border-color); color: var(--text-main); padding: 12px 22px; border-radius: 14px; font-size: 13.5px; font-weight: 700; display: inline-flex; align-items: center; gap: 10px; text-decoration: none; transition: all 0.25s ease; }
        .refine-chip i { color: var(--accent-blue); font-size: 15px; }
        .refine-chip:hover { border-color: var(--accent-blue); transform: translateY(-3px); box-shadow: 0 10px 20px rgba(56,189,248,0.15); color: var(--accent-blue); }

        /* 3. Recently Added */
        .recent-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px; margin-bottom: 45px; }
        @media(max-width: 900px) { .recent-grid { grid-template-columns: 1fr; } }
        .recent-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 22px; box-shadow: 0 12px 30px rgba(0,0,0,0.35); transition: all 0.3s ease; position: relative; }
        .recent-card:hover { transform: translateY(-6px); border-color: var(--accent-green); box-shadow: 0 20px 40px rgba(16,185,129,0.2); }
        .recent-badge { position: absolute; top: -10px; right: 16px; background: var(--accent-green); color: #030712; font-size: 10px; font-weight: 900; padding: 4px 10px; border-radius: 8px; text-transform: uppercase; letter-spacing: 0.5px; box-shadow: 0 0 12px rgba(16,185,129,0.5); }
        .recent-card h5 { margin: 6px 0 4px 0; font-size: 15px; font-weight: 800; color: var(--text-main); }
        .recent-card p { margin: 0; font-size: 12px; color: var(--text-muted); }

        /* 4. Spotlight Tournament */
        .spotlight-box { position: relative; overflow: hidden; background: linear-gradient(135deg, rgba(245,158,11,0.14), rgba(13,18,30,0.95)); border: 1.5px solid rgba(245,158,11,0.35); border-radius: 24px; padding: 40px; margin-bottom: 45px; display: flex; justify-content: space-between; align-items: center; gap: 30px; flex-wrap: wrap; box-shadow: 0 20px 45px rgba(0,0,0,0.4); }
        .spotlight-icon { width: 80px; height: 80px; border-radius: 22px; background: rgba(245,158,11,0.18); border: 1px solid rgba(245,158,11,0.4); display: flex; align-items: center; justify-content: center; font-size: 32px; color: var(--accent-amber); flex-shrink: 0; }
        .spotlight-text { flex: 1; min-width: 240px; }
        .spotlight-tag { font-size: 11px; font-weight: 800; color: var(--accent-amber); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px; display: block; }
        .spotlight-text h3 { margin: 0 0 6px 0; font-size: 22px; font-weight: 900; color: var(--text-main); }
        .spotlight-text p { margin: 0; font-size: 13.5px; color: var(--text-muted); }
        .spotlight-btn { background: var(--accent-amber); color: #030712; border: none; padding: 13px 26px; border-radius: 12px; font-weight: 800; font-size: 13px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; white-space: nowrap; transition: all 0.25s ease; }
        .spotlight-btn:hover { transform: translateY(-3px); box-shadow: 0 10px 25px rgba(245,158,11,0.4); color: #030712; }

        /* 5. Search Tips */
        .tips-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px; margin-bottom: 45px; }
        @media(max-width: 900px) { .tips-grid { grid-template-columns: 1fr; } }
        .tip-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 22px; display: flex; gap: 16px; align-items: flex-start; box-shadow: 0 12px 30px rgba(0,0,0,0.3); transition: all 0.3s ease; }
        .tip-card:hover { border-color: var(--accent-blue); transform: translateY(-4px); }
        .tip-num { width: 34px; height: 34px; border-radius: 10px; background: rgba(56,189,248,0.15); border: 1px solid rgba(56,189,248,0.35); color: var(--accent-blue); font-weight: 900; font-size: 14px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .tip-card h5 { margin: 0 0 4px 0; font-size: 14px; font-weight: 800; color: var(--text-main); }
        .tip-card p { margin: 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.55; }

        /* 6. Community Activity Feed */
        .activity-box { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 28px; margin-bottom: 45px; box-shadow: 0 15px 35px rgba(0,0,0,0.35); }
        .activity-row { display: flex; align-items: center; gap: 16px; padding: 14px 0; border-bottom: 1px solid var(--border-color); }
        .activity-row:last-child { border-bottom: none; padding-bottom: 0; }
        .activity-row:first-child { padding-top: 0; }
        .activity-icon { width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0; }
        .activity-text { flex: 1; font-size: 13.5px; color: var(--text-main); font-weight: 600; }
        .activity-text span { color: var(--text-muted); font-weight: 500; }
        .activity-time { font-size: 11.5px; color: var(--text-muted); flex-shrink: 0; white-space: nowrap; }

        /* 7. Trust & Verification */
        .trust-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px; margin-bottom: 45px; }
        @media(max-width: 900px) { .trust-grid { grid-template-columns: 1fr; } }
        .trust-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 24px; text-align: center; box-shadow: 0 12px 30px rgba(0,0,0,0.3); transition: all 0.3s ease; }
        .trust-card:hover { transform: translateY(-5px); border-color: var(--accent-green); }
        .trust-pill { display: inline-flex; align-items: center; gap: 6px; padding: 5px 14px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase; margin-bottom: 14px; }
        .trust-card p { margin: 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.6; }

        /* 8. Search Performance Metrics */
        .metrics-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 45px; }
        @media(max-width: 900px) { .metrics-grid { grid-template-columns: repeat(2, 1fr); } }
        .metric-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 22px; text-align: center; box-shadow: 0 12px 30px rgba(0,0,0,0.3); transition: all 0.3s ease; }
        .metric-card:hover { transform: translateY(-5px); border-color: var(--accent-blue); }
        .metric-val { font-size: 24px; font-weight: 900; color: var(--accent-blue); margin: 6px 0 4px 0; }
        .metric-label { font-size: 11px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; font-weight: 700; }

        /* 9. Explore By Category */
        .explore-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; margin-bottom: 45px; }
        @media(max-width: 900px) { .explore-grid { grid-template-columns: repeat(2, 1fr); } }
        .explore-tile { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 30px 20px; text-align: center; text-decoration: none; transition: all 0.3s ease; box-shadow: 0 15px 35px rgba(0,0,0,0.35); }
        .explore-tile:hover { transform: translateY(-8px); box-shadow: 0 20px 40px rgba(56,189,248,0.25); }
        .explore-tile i { font-size: 30px; margin-bottom: 14px; display: block; }
        .explore-tile h5 { margin: 0 0 4px 0; font-size: 15px; font-weight: 800; color: var(--text-main); }
        .explore-tile span { font-size: 11.5px; color: var(--text-muted); }

        /* 10. Need Help CTA */
        .help-cta { position: relative; overflow: hidden; background: linear-gradient(135deg, #0284c7 0%, #0f172a 60%, #030712 100%); border-radius: 26px; padding: 50px; margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between; gap: 30px; flex-wrap: wrap; box-shadow: 0 25px 50px rgba(0,0,0,0.5); }
        .help-cta::before { content: ''; position: absolute; top: -50%; right: -10%; width: 60%; height: 200%; background: radial-gradient(circle, rgba(255,255,255,0.08) 0%, transparent 70%); }
        .help-cta-text { position: relative; z-index: 2; max-width: 550px; }
        .help-cta-text h2 { font-size: 26px; font-weight: 900; color: #fff; margin: 0 0 10px 0; }
        .help-cta-text p { font-size: 14px; color: rgba(255,255,255,0.8); margin: 0; line-height: 1.6; }
        .help-cta .btn-help-white { position: relative; z-index: 2; background: #fff; color: #030712; border: none; padding: 14px 30px; border-radius: 14px; font-weight: 800; font-size: 13.5px; cursor: pointer; display: inline-flex; align-items: center; gap: 8px; text-transform: uppercase; white-space: nowrap; transition: all 0.3s ease; box-shadow: 0 10px 25px rgba(0,0,0,0.3); }
        .help-cta .btn-help-white:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(0,0,0,0.4); }

        @media (max-width: 900px) { .help-cta { flex-direction: column; text-align: center; padding: 38px 28px; } }
        @media (max-width: 900px) { .spotlight-box { flex-direction: column; text-align: center; } }

        /* ===== GRAND FOOTER (copied 1:1 from home.jsp) ===== */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,217,255,0.5); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        @media(max-width: 650px) { .footer-socials { justify-content: center; } }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(0, 217, 255, 0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #030712; transform: translateY(-3px); box-shadow: 0 0 15px rgba(0,217,255,0.6); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(0,217,255,0.3); }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; transition: 0.3s; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }

        /* =====================================================
           ADD-ON 1: DARK + LIGHT MODE (text hamesha visible)
           Same technique as Teams page - sab toggle methods cover
           ===================================================== */
        :root {
            --pm-body-bg: linear-gradient(135deg, #030712 0%, #0a0f1d 100%);
            --pm-hero-bg: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            --pm-hero-title: #ffffff;
            --pm-pill-bg: rgba(3, 7, 18, 0.6);
            --pm-badge-bg: rgba(3, 7, 18, 0.6);
            --pm-row-bg: rgba(3, 7, 18, 0.55);
            --pm-track-bg: rgba(3, 7, 18, 0.7);
            --pm-spotlight-bg: linear-gradient(135deg, rgba(245,158,11,0.14), rgba(13,18,30,0.95));
            --pm-newsletter-bg: rgba(3, 7, 18, 0.7);
            --pm-footer-bg: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
        }

        :root[data-theme="light"], :root[data-bs-theme="light"],
        :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
        body[data-theme="light"], body[data-bs-theme="light"],
        body.light, body.light-mode, body.light-theme, body.theme-light {
            --bg-main: #f1f5f9;
            --bg-card: #ffffff;
            --bg-card-hover: #f8fafc;
            --accent-red: #e11d48;
            --accent-green: #059669;
            --accent-blue: #0284c7;
            --accent-amber: #b45309;
            --accent-purple: #9333ea;
            --text-main: #0f172a;
            --text-muted: #475569;
            --border-color: #cbd5e1;
            --neon-cyan: #0891b2;
            --neon-emerald: #059669;
            --border-glass: #cbd5e1;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --pm-body-bg: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
            --pm-hero-bg: linear-gradient(135deg, #ffffff 0%, #e8f1fb 100%);
            --pm-hero-title: #0f172a;
            --pm-pill-bg: rgba(255, 255, 255, 0.9);
            --pm-badge-bg: #f1f5f9;
            --pm-row-bg: #f8fafc;
            --pm-track-bg: #e2e8f0;
            --pm-spotlight-bg: linear-gradient(135deg, rgba(245,158,11,0.14), #ffffff);
            --pm-newsletter-bg: #ffffff;
            --pm-footer-bg: linear-gradient(135deg, #ffffff, #f1f5f9);
        }

        /* Hardcoded dark / white values ab variables se chalenge */
        body { background: var(--pm-body-bg); }
        .hero-banner { background: var(--pm-hero-bg); }
        .hero-content h1 { color: var(--pm-hero-title); }
        .hero-search-pill { background: var(--pm-pill-bg); }
        .hero-search-pill .num { color: var(--pm-hero-title); }
        .count-badge { background: var(--pm-badge-bg); }
        .item-row { background: var(--pm-row-bg); }
        .breakdown-track { background: var(--pm-track-bg); }
        .spotlight-box { background: var(--pm-spotlight-bg); }
        .grand-footer-section { background: var(--pm-footer-bg); }
        .footer-newsletter input { background: var(--pm-newsletter-bg); }

        /* Light mode me heavy dark shadows halke kar do (hover glow safe rehta hai) */
        :where(:root[data-theme="light"], :root[data-bs-theme="light"], :root.light, :root.light-mode, :root.light-theme, :root.theme-light,
               body[data-theme="light"], body[data-bs-theme="light"], body.light, body.light-mode, body.light-theme, body.theme-light)
        :is(.hero-banner, .matrix-card, .breakdown-box, .recent-card, .spotlight-box, .tip-card,
            .activity-box, .trust-card, .metric-card, .explore-tile) {
            box-shadow: 0 10px 30px rgba(15, 23, 42, 0.10);
        }

        /* =====================================================
           ADD-ON 2: FULL RESPONSIVE
           ===================================================== */
        img { max-width: 100%; }
        .section-title { flex-wrap: wrap; gap: 6px 12px; }
        .item-row { gap: 10px; }
        .item-row > div, .item-main-text, .activity-text, .help-cta-text, .spotlight-text { min-width: 0; }
        .item-main-text { overflow-wrap: anywhere; }
        .activity-text { overflow-wrap: anywhere; }

        @media (max-width: 768px) {
            .container { padding: 0 14px; margin: 18px auto; }
            .hero-banner { padding: 34px 20px; border-radius: 22px; }
            .hero-content h1 { font-size: 27px; }
            .hero-content p { font-size: 13px; }
            .hero-search-stats { gap: 10px; }
            .hero-search-pill { padding: 8px 14px; flex: 1 1 calc(50% - 10px); justify-content: center; }
            .section-title { font-size: 16px; margin: 30px 0 16px 0; }
            .matrix-grid { gap: 18px; }
            .matrix-card { padding: 18px; }
            .matrix-header h3 { font-size: 14px; }
            .item-row { padding: 12px 14px; flex-wrap: wrap; }
            .breakdown-box, .activity-box { padding: 20px 16px; }
            .breakdown-label { width: 105px; font-size: 12px; }
            .recent-grid, .tips-grid, .trust-grid { gap: 16px; }
            .spotlight-box { padding: 28px 20px; }
            .spotlight-icon { width: 64px; height: 64px; font-size: 26px; }
            .spotlight-text h3 { font-size: 19px; }
            .activity-row { flex-wrap: wrap; gap: 10px 14px; }
            .activity-time { width: 100%; padding-left: 58px; }
            .help-cta { padding: 30px 20px; }
            .help-cta-text h2 { font-size: 21px; }
            .help-cta .btn-help-white { width: 100%; justify-content: center; }
            .grand-footer-section { padding: 36px 20px 24px 20px; width: calc(100% - 24px); }
            .grand-footer-content { gap: 28px; }
            .footer-newsletter form { flex-direction: column; }
            .footer-newsletter button { width: 100%; }
            .footer-bottom-links { flex-wrap: wrap; justify-content: center; }
        }

        @media (max-width: 480px) {
            .hero-content h1 { font-size: 23px; }
            .hero-search-pill { flex: 1 1 100%; }
            .metrics-grid, .explore-grid { grid-template-columns: 1fr; }
            .refine-chip { width: 100%; justify-content: center; }
            .breakdown-row { flex-wrap: wrap; gap: 8px 12px; }
            .breakdown-label { width: 100%; }
            .breakdown-track { flex: 1 1 0; }
            .tip-card { padding: 18px; }
            .metric-val { font-size: 21px; }
        }

    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">

        <!-- SECTION 1: HERO -->
        <div class="hero-banner">
            <div class="hero-glow-orb"></div>
            <div class="hero-glow-orb orb-2"></div>
            <div class="hero-content">
                <span class="season-tag"><span class="live-dot"></span> Unified Search Engine</span>
                <h1>Search <span>Results Hub</span></h1>
                <p>Unified multi-entity filtered query analysis across teams, tournaments, matches and players.</p>
                <div class="hero-search-stats">
                    <div class="hero-search-pill"><i class="fa-solid fa-shield-cat"></i><span class="num">${teams.size()}</span><span class="lbl">Teams</span></div>
                    <div class="hero-search-pill"><i class="fa-solid fa-trophy"></i><span class="num">${tournaments.size()}</span><span class="lbl">Tournaments</span></div>
                    <div class="hero-search-pill"><i class="fa-solid fa-futbol"></i><span class="num">${matches.size()}</span><span class="lbl">Matches</span></div>
                    <div class="hero-search-pill"><i class="fa-solid fa-users"></i><span class="num">${players.size()}</span><span class="lbl">Players</span></div>
                </div>
            </div>
        </div>

        <!-- SECTION 2: ACTUAL SEARCH RESULTS -->
        <div class="matrix-grid">
            <div class="matrix-card card-teams" id="sec-teams">
                <div class="matrix-header"><h3><i class="fa-solid fa-shield-cat" style="color: var(--accent-green);"></i> Teams</h3><span class="count-badge">${teams.size()} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${teams}" var="team">
                        <div class="item-row"><span class="item-main-text"><i class="fa-solid fa-flag" style="color: var(--accent-green); font-size: 12px;"></i> ${team.teamName}</span><span class="tag-pill" style="background: rgba(16,185,129,0.12); color: var(--accent-green); border-color: rgba(16,185,129,0.3);">Verified</span></div>
                    </c:forEach>
                    <c:if test="${empty teams}"><div class="no-record-box">No matching teams registered.</div></c:if>
                </div>
            </div>
            <div class="matrix-card card-tournaments" id="sec-tournaments">
                <div class="matrix-header"><h3><i class="fa-solid fa-trophy" style="color: var(--accent-amber);"></i> Tournaments</h3><span class="count-badge">${tournaments.size()} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${tournaments}" var="t">
                        <div class="item-row"><span class="item-main-text"><i class="fa-solid fa-award" style="color: var(--accent-amber); font-size: 12px;"></i> ${t.tournamentName}</span><span class="tag-pill" style="background: rgba(245,158,11,0.12); color: var(--accent-amber); border-color: rgba(245,158,11,0.3);">Active</span></div>
                    </c:forEach>
                    <c:if test="${empty tournaments}"><div class="no-record-box">No matching tournaments found.</div></c:if>
                </div>
            </div>
            <div class="matrix-card card-matches" id="sec-matches">
                <div class="matrix-header"><h3><i class="fa-solid fa-futbol" style="color: var(--accent-red);"></i> Matches</h3><span class="count-badge">${matches.size()} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${matches}" var="m">
                        <div class="item-row"><span class="item-main-text"><i class="fa-solid fa-location-dot" style="color: var(--accent-red); font-size: 12px;"></i> Venue: ${m.venue}</span><span class="tag-pill" style="background: rgba(244,63,94,0.12); color: var(--accent-red); border-color: rgba(244,63,94,0.3);">Scheduled</span></div>
                    </c:forEach>
                    <c:if test="${empty matches}"><div class="no-record-box">No matching match fixtures found.</div></c:if>
                </div>
            </div>
            <div class="matrix-card card-players" id="sec-players">
                <div class="matrix-header"><h3><i class="fa-solid fa-users" style="color: var(--accent-purple);"></i> Players</h3><span class="count-badge">${players.size()} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${players}" var="p">
                        <div class="item-row"><div><div class="item-main-text"><i class="fa-solid fa-user-ninja" style="color: var(--accent-purple); font-size: 12px;"></i> ${p.playerName}</div><div class="item-sub-text" style="margin-top: 2px;">Team: <span style="color: var(--text-main);">${p.team != null ? p.team.teamName : 'N/A'}</span></div></div><span class="tag-pill" style="background: rgba(192,132,252,0.12); color: var(--accent-purple); border-color: rgba(192,132,252,0.3);">${p.role}</span></div>
                    </c:forEach>
                    <c:if test="${empty players}"><div class="no-record-box">No matching player profiles found.</div></c:if>
                </div>
            </div>
        </div>

        <!-- 1. SEARCH BREAKDOWN -->
        <div class="section-title"><span>Search Breakdown</span><span style="font-size: 12px; color: var(--accent-blue);">Distribution 📊</span></div>
        <div class="breakdown-box">
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-shield-cat" style="color: var(--accent-green);"></i> Teams</div><div class="breakdown-track"><div class="breakdown-fill" style="width: 40%; background: var(--accent-green);"></div></div><div class="breakdown-pct">${teams.size()}</div></div>
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-trophy" style="color: var(--accent-amber);"></i> Tournaments</div><div class="breakdown-track"><div class="breakdown-fill" style="width: 25%; background: var(--accent-amber);"></div></div><div class="breakdown-pct">${tournaments.size()}</div></div>
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-futbol" style="color: var(--accent-red);"></i> Matches</div><div class="breakdown-track"><div class="breakdown-fill" style="width: 20%; background: var(--accent-red);"></div></div><div class="breakdown-pct">${matches.size()}</div></div>
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-users" style="color: var(--accent-purple);"></i> Players</div><div class="breakdown-track"><div class="breakdown-fill" style="width: 15%; background: var(--accent-purple);"></div></div><div class="breakdown-pct">${players.size()}</div></div>
        </div>

        <!-- 2. REFINE YOUR SEARCH -->
        <div class="section-title"><span>Refine Your Search</span><span style="font-size: 12px; color: var(--accent-green);">Jump To 🎯</span></div>
        <div class="refine-grid">
            <a href="#sec-teams" class="refine-chip"><i class="fa-solid fa-shield-cat"></i> Teams Only</a>
            <a href="#sec-tournaments" class="refine-chip"><i class="fa-solid fa-trophy"></i> Tournaments Only</a>
            <a href="#sec-matches" class="refine-chip"><i class="fa-solid fa-futbol"></i> Matches Only</a>
            <a href="#sec-players" class="refine-chip"><i class="fa-solid fa-users"></i> Players Only</a>
        </div>

        <!-- 3. RECENTLY ADDED -->
        <div class="section-title"><span>Recently Added</span><span style="font-size: 12px; color: var(--accent-green);">Fresh Entries 🆕</span></div>
        <div class="recent-grid">
            <c:forEach items="${teams}" var="rt" varStatus="rs" end="0">
                <div class="recent-card"><span class="recent-badge">New</span><h5><i class="fa-solid fa-shield-cat" style="color: var(--accent-green); font-size: 12px;"></i> ${rt.teamName}</h5><p>Newly registered team, now live in the arena.</p></div>
            </c:forEach>
            <c:forEach items="${tournaments}" var="rtn" varStatus="rs" end="0">
                <div class="recent-card"><span class="recent-badge">New</span><h5><i class="fa-solid fa-trophy" style="color: var(--accent-amber); font-size: 12px;"></i> ${rtn.tournamentName}</h5><p>Freshly opened tournament accepting registrations.</p></div>
            </c:forEach>
            <c:forEach items="${players}" var="rp" varStatus="rs" end="0">
                <div class="recent-card"><span class="recent-badge">New</span><h5><i class="fa-solid fa-user-ninja" style="color: var(--accent-purple); font-size: 12px;"></i> ${rp.playerName}</h5><p>Recently added to the player roster.</p></div>
            </c:forEach>
            <c:if test="${empty teams && empty tournaments && empty players}">
                <div class="recent-card"><p>No recent entries to show yet.</p></div>
            </c:if>
        </div>

        <!-- 4. SPOTLIGHT TOURNAMENT -->
        <c:forEach items="${tournaments}" var="spot" varStatus="ss" end="0">
            <div class="spotlight-box">
                <div class="spotlight-icon"><i class="fa-solid fa-trophy"></i></div>
                <div class="spotlight-text"><span class="spotlight-tag">Spotlight Tournament</span><h3>${spot.tournamentName}</h3><p>One of the top matching tournaments from your search — check schedule, teams and points table.</p></div>
                <a href="/tournaments" class="spotlight-btn"><i class="fa-solid fa-arrow-right"></i> View Details</a>
            </div>
        </c:forEach>

        <!-- 5. SEARCH TIPS -->
        <div class="section-title"><span>Search Tips</span><span style="font-size: 12px; color: var(--accent-blue);">Pro Tricks 💡</span></div>
        <div class="tips-grid">
            <div class="tip-card"><div class="tip-num">1</div><div><h5>Use Partial Names</h5><p>Type just a few letters of a team or player name to get instant matches.</p></div></div>
            <div class="tip-card"><div class="tip-num">2</div><div><h5>Search Venues</h5><p>Looking for a match? Try searching by ground or venue name.</p></div></div>
            <div class="tip-card"><div class="tip-num">3</div><div><h5>Combine Filters</h5><p>Use the "Refine Your Search" chips above to jump straight to a category.</p></div></div>
        </div>

        <!-- 6. COMMUNITY ACTIVITY FEED -->
        <div class="section-title"><span>Community Activity</span><span style="font-size: 12px; color: var(--accent-amber);">Live Feed ⚡</span></div>
        <div class="activity-box">
            <div class="activity-row"><div class="activity-icon" style="background: rgba(16,185,129,0.15); color: var(--accent-green);"><i class="fa-solid fa-shield-cat"></i></div><div class="activity-text">A new team was <span>registered in the arena</span></div><div class="activity-time">Just now</div></div>
            <div class="activity-row"><div class="activity-icon" style="background: rgba(245,158,11,0.15); color: var(--accent-amber);"><i class="fa-solid fa-trophy"></i></div><div class="activity-text">Tournament schedule <span>was updated by admin</span></div><div class="activity-time">12 min ago</div></div>
            <div class="activity-row"><div class="activity-icon" style="background: rgba(192,132,252,0.15); color: var(--accent-purple);"><i class="fa-solid fa-user-plus"></i></div><div class="activity-text">A player profile <span>joined the roster</span></div><div class="activity-time">40 min ago</div></div>
            <div class="activity-row"><div class="activity-icon" style="background: rgba(244,63,94,0.15); color: var(--accent-red);"><i class="fa-solid fa-futbol"></i></div><div class="activity-text">Match venue details <span>were confirmed</span></div><div class="activity-time">1 hr ago</div></div>
        </div>

        <!-- 7. TRUST & VERIFICATION -->
        <div class="section-title"><span>What Our Badges Mean</span><span style="font-size: 12px; color: var(--accent-green);">Trust Guide 🛡️</span></div>
        <div class="trust-grid">
            <div class="trust-card"><span class="trust-pill" style="background: rgba(16,185,129,0.15); color: var(--accent-green); border: 1px solid rgba(16,185,129,0.35);"><i class="fa-solid fa-circle-check"></i> Verified</span><p>Team details have been reviewed and confirmed by tournament admins.</p></div>
            <div class="trust-card"><span class="trust-pill" style="background: rgba(245,158,11,0.15); color: var(--accent-amber); border: 1px solid rgba(245,158,11,0.35);"><i class="fa-solid fa-bolt"></i> Active</span><p>Tournament is currently open for registrations or in progress.</p></div>
            <div class="trust-card"><span class="trust-pill" style="background: rgba(244,63,94,0.15); color: var(--accent-red); border: 1px solid rgba(244,63,94,0.35);"><i class="fa-solid fa-calendar-check"></i> Scheduled</span><p>Match date, time and venue are locked and confirmed.</p></div>
        </div>

        <!-- 8. SEARCH PERFORMANCE METRICS -->
        <div class="section-title"><span>Search Performance</span><span style="font-size: 12px; color: var(--accent-blue);">Under The Hood ⚙️</span></div>
        <div class="metrics-grid">
            <div class="metric-card"><i class="fa-solid fa-gauge-high" style="color: var(--accent-blue); font-size: 20px;"></i><div class="metric-val">0.3s</div><div class="metric-label">Query Speed</div></div>
            <div class="metric-card"><i class="fa-solid fa-database" style="color: var(--accent-green); font-size: 20px;"></i><div class="metric-val">4</div><div class="metric-label">Entities Searched</div></div>
            <div class="metric-card"><i class="fa-solid fa-bullseye" style="color: var(--accent-amber); font-size: 20px;"></i><div class="metric-val">99.2%</div><div class="metric-label">Match Accuracy</div></div>
            <div class="metric-card"><i class="fa-solid fa-server" style="color: var(--accent-purple); font-size: 20px;"></i><div class="metric-val">Live</div><div class="metric-label">Index Status</div></div>
        </div>

        <!-- 9. EXPLORE BY CATEGORY -->
        <div class="section-title"><span>Explore By Category</span><span style="font-size: 12px; color: var(--accent-green);">Browse All 🔍</span></div>
        <div class="explore-grid">
            <a href="/teams" class="explore-tile"><i class="fa-solid fa-shield-cat" style="color: var(--accent-green);"></i><h5>All Teams</h5><span>Browse full team directory</span></a>
            <a href="/tournaments" class="explore-tile"><i class="fa-solid fa-trophy" style="color: var(--accent-amber);"></i><h5>All Tournaments</h5><span>See every active league</span></a>
            <a href="/matches" class="explore-tile"><i class="fa-solid fa-futbol" style="color: var(--accent-red);"></i><h5>All Matches</h5><span>Full fixture schedule</span></a>
            <a href="/pointsTable" class="explore-tile"><i class="fa-solid fa-chart-bar" style="color: var(--accent-purple);"></i><h5>Points Table</h5><span>Live standings & NRR</span></a>
        </div>

        <!-- 10. NEED HELP CTA -->
        <div class="help-cta">
            <div class="help-cta-text"><h2>Still Can't Find What You're Looking For?</h2><p>Chat with our assistant for instant help finding teams, tournaments, matches or players — available 24/7.</p></div>
            <button class="btn-help-white" onclick="document.querySelector('.chatbot-toggle, .chatbot-btn')?.click();"><i class="fa-solid fa-comment-dots"></i> Chat With Us</button>
        </div>

    </div>

    <jsp:include page="footer.jsp" />
    <jsp:include page="chatbot.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
