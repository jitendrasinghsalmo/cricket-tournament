<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <title>Admin Dashboard - PitchOps</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; }
        html { scroll-behavior: smooth; }
        :root {
            --bg-main: #07090e;
            --bg-card: #0e121c;
            --bg-card-hover: #141a28;
            --accent-red: #ff3366;
            --accent-green: #00ffcc;
            --accent-blue: #00d2ff;
            --accent-amber: #f59e0b;
            --accent-purple: #c084fc;
            --text-main: #f1f5f9;
            --text-muted: #64748b;
            --border-color: #1e293b;
            --neon-cyan: #00d2ff;
            --neon-emerald: #00ffcc;
            --border-glass: rgba(0, 210, 255, 0.22);
            --text-primary: #f1f5f9;
            --text-secondary: #94a3b8;
        }

        body {
            font-family: 'Inter', system-ui, -apple-system, sans-serif;
            background-color: var(--bg-main);
            color: var(--text-main);
            margin: 0;
            padding: 0;
            overflow-x: hidden;
        }

        /* CONTAINER */
        .container { max-width: 1350px; margin: 25px auto; padding: 0 20px; }

        /* ================= HERO BANNER (auto animated background) ================= */
        .hero-banner {
            position: relative;
            isolation: isolate;
            background: linear-gradient(120deg, #0b1220, #08222f, #17112e, #0b1220);
            background-size: 300% 300%;
            animation: bgShift 16s ease infinite;
            border: 1px solid var(--border-color);
            border-radius: 20px;
            padding: 44px 48px;
            margin-bottom: 25px;
            display: grid;
            grid-template-columns: 1.25fr 1fr;
            align-items: center;
            gap: 30px;
            overflow: hidden;
            box-shadow: 0 20px 45px rgba(0,0,0,0.5);
        }
        @keyframes bgShift { 0% { background-position: 0% 50%; } 50% { background-position: 100% 50%; } 100% { background-position: 0% 50%; } }

        .hero-grid-lines {
            position: absolute; inset: 0; z-index: -1; pointer-events: none;
            background-image:
                linear-gradient(rgba(0,210,255,0.07) 1px, transparent 1px),
                linear-gradient(90deg, rgba(0,210,255,0.07) 1px, transparent 1px);
            background-size: 38px 38px;
            animation: gridMove 12s linear infinite;
            -webkit-mask-image: radial-gradient(ellipse at 70% 50%, #000 10%, transparent 75%);
            mask-image: radial-gradient(ellipse at 70% 50%, #000 10%, transparent 75%);
        }
        @keyframes gridMove { from { background-position: 0 0, 0 0; } to { background-position: 38px 38px, 38px 38px; } }

        .hero-banner::before {
            content: ''; position: absolute; top: -60%; left: -40%; width: 160%; height: 220%; z-index: -1;
            background: radial-gradient(circle, rgba(0, 210, 255, 0.14) 0%, rgba(0, 255, 204, 0.07) 35%, transparent 65%);
            animation: rotateGlow 18s linear infinite; pointer-events: none;
        }
        .hero-banner::after {
            content: ''; position: absolute; bottom: -70%; right: -30%; width: 150%; height: 170%; z-index: -1;
            background: radial-gradient(circle, rgba(255, 51, 102, 0.12) 0%, transparent 65%);
            animation: rotateGlowReverse 24s linear infinite; pointer-events: none;
        }
        .hero-glow-orb {
            position: absolute; width: 200px; height: 200px; border-radius: 50%; z-index: -1; pointer-events: none;
            background: radial-gradient(circle, rgba(0,210,255,0.32), transparent 70%);
            filter: blur(30px); top: 6%; left: 6%;
            animation: driftOrb 9s ease-in-out infinite alternate;
        }
        .hero-glow-orb.orb-2 {
            background: radial-gradient(circle, rgba(0,255,204,0.26), transparent 70%);
            top: 58%; left: 42%; width: 160px; height: 160px;
            animation: driftOrb2 11s ease-in-out infinite alternate;
        }
        .hero-glow-orb.orb-3 {
            background: radial-gradient(circle, rgba(192,132,252,0.26), transparent 70%);
            top: 10%; left: 72%; width: 170px; height: 170px;
            animation: driftOrb 13s ease-in-out infinite alternate-reverse;
        }
        .hero-sparks { position: absolute; inset: 0; z-index: -1; pointer-events: none; overflow: hidden; }
        .hero-sparks span {
            position: absolute; bottom: -10px; left: var(--l); width: 4px; height: 4px; border-radius: 50%;
            background: var(--accent-blue); box-shadow: 0 0 10px var(--accent-blue); opacity: 0;
            animation: sparkUp 7s linear infinite; animation-delay: var(--d);
        }
        .hero-sparks span:nth-child(even) { background: var(--accent-green); box-shadow: 0 0 10px var(--accent-green); width: 3px; height: 3px; }
        @keyframes sparkUp { 0% { transform: translateY(0); opacity: 0; } 15% { opacity: 0.9; } 100% { transform: translateY(-340px); opacity: 0; } }
        @keyframes rotateGlow { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        @keyframes rotateGlowReverse { 0% { transform: rotate(0deg); } 100% { transform: rotate(-360deg); } }
        @keyframes driftOrb { 0% { transform: translate(0,0) scale(1); } 100% { transform: translate(35px,25px) scale(1.15); } }
        @keyframes driftOrb2 { 0% { transform: translate(0,0) scale(1); } 100% { transform: translate(-25px,-18px) scale(1.1); } }
        @keyframes pulseDot { 0%,100% { opacity: 1; } 50% { opacity: 0.3; } }

        .hero-content { position: relative; z-index: 2; min-width: 0; }
        .season-tag { color: var(--accent-red); font-size: 11px; font-weight: 700; letter-spacing: 1px; text-transform: uppercase; margin-bottom: 10px; display: flex; align-items: center; gap: 7px; flex-wrap: wrap; }
        .season-tag .live-dot { width: 7px; height: 7px; border-radius: 50%; background: var(--accent-red); box-shadow: 0 0 8px var(--accent-red); animation: pulseDot 1.3s ease-in-out infinite; }
        .hero-content h1 { font-size: 34px; line-height: 1.2; margin: 0 0 12px 0; font-weight: 800; text-shadow: 0 0 20px rgba(0,210,255,0.25); overflow-wrap: anywhere; }
        .hero-content h1 .name { background: linear-gradient(90deg, var(--accent-blue), var(--accent-green)); -webkit-background-clip: text; background-clip: text; color: transparent; }
        .hero-content p { color: #8ea0b8; font-size: 13.5px; margin: 0 0 18px 0; max-width: 470px; line-height: 1.6; }

        .hero-clock {
            display: inline-flex; flex-wrap: wrap; align-items: center; gap: 6px 14px; margin: 0 0 20px;
            padding: 9px 15px; border-radius: 12px; font-size: 12.5px; font-weight: 600;
            background: rgba(0,210,255,0.08); border: 1px solid rgba(0,210,255,0.25); backdrop-filter: blur(6px);
        }
        .hero-clock .greet { color: var(--accent-amber); font-weight: 800; display: inline-flex; align-items: center; gap: 6px; }
        .hero-clock .time { color: var(--accent-green); font-weight: 800; letter-spacing: 1px; font-variant-numeric: tabular-nums; }
        .hero-clock .date { color: var(--text-secondary); }

        .hero-btns { display: flex; gap: 12px; flex-wrap: wrap; }
        .btn-primary { background: var(--accent-blue); color: #07090e; border: none; padding: 11px 20px; border-radius: 9px; font-weight: 700; font-size: 13px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 6px; box-shadow: 0 0 20px rgba(0,210,255,0.35); transition: all 0.25s ease; }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 0 28px rgba(0,210,255,0.55); color: #07090e; }
        .btn-secondary { background: rgba(7,9,14,0.7); color: var(--text-main); border: 1px solid var(--border-color); padding: 11px 20px; border-radius: 9px; font-weight: 700; font-size: 13px; cursor: pointer; text-decoration: none; display: inline-flex; align-items: center; justify-content: center; gap: 6px; transition: all 0.25s ease; }
        .btn-secondary:hover { border-color: var(--accent-blue); color: var(--accent-blue); }

        /* Hero art: floating cricket ball + orbits */
        .hero-art { position: relative; width: min(290px, 100%); aspect-ratio: 1 / 1; justify-self: center; z-index: 1; }
        .orbit { position: absolute; border-radius: 50%; border: 1px dashed rgba(0,210,255,0.35); }
        .orbit.o1 { inset: 0; animation: spin 22s linear infinite; animation-delay: 0s; }
        .orbit.o2 { inset: 13%; border-color: rgba(0,255,204,0.35); animation: spinRev 16s linear infinite; animation-delay: -5s; }
        .orbit.o3 { inset: 27%; border-color: rgba(255,51,102,0.4); animation: spin 10s linear infinite; animation-delay: -3.5s; }
        .sat {
            position: absolute; top: 0; left: 50%; width: 32px; height: 32px; margin: -16px 0 0 -16px; border-radius: 50%;
            background: var(--bg-card); border: 1.5px solid var(--accent-blue); color: var(--accent-blue);
            display: flex; align-items: center; justify-content: center; font-size: 13px; box-shadow: 0 0 14px rgba(0,210,255,0.5);
        }
        .o1 .sat { animation: spinRev 22s linear infinite; animation-delay: 0s; }
        .o2 .sat { border-color: var(--accent-green); color: var(--accent-green); box-shadow: 0 0 14px rgba(0,255,204,0.5); animation: spin 16s linear infinite; animation-delay: -5s; }
        .o3 .sat { border-color: var(--accent-red); color: var(--accent-red); box-shadow: 0 0 14px rgba(255,51,102,0.5); animation: spinRev 10s linear infinite; animation-delay: -3.5s; }
        @keyframes spin { from { transform: rotate(0deg); } to { transform: rotate(360deg); } }
        @keyframes spinRev { from { transform: rotate(0deg); } to { transform: rotate(-360deg); } }

        .ball-wrap { position: absolute; inset: 36%; animation: ballFloat 3.2s ease-in-out infinite alternate; }
        .ball-wrap svg { width: 100%; height: 100%; display: block; animation: spin 12s linear infinite; filter: drop-shadow(0 0 16px rgba(255,51,102,0.6)); }
        .ball-shadow { position: absolute; left: 50%; bottom: 16%; width: 26%; height: 5%; margin-left: -13%; border-radius: 50%; background: radial-gradient(ellipse, rgba(0,0,0,0.55), transparent 70%); animation: shadowPulse 3.2s ease-in-out infinite alternate; }
        @keyframes ballFloat { from { transform: translateY(6px); } to { transform: translateY(-12px); } }
        @keyframes shadowPulse { from { transform: scale(1.1); opacity: 0.9; } to { transform: scale(0.7); opacity: 0.45; } }


        /* hero art: radar sweep + ripples (always running) */
        .hero-art::before {
            content: ''; position: absolute; inset: -6%; border-radius: 50%; z-index: -1;
            background: conic-gradient(from 0deg, transparent 0 68%, rgba(0,210,255,0.30) 100%);
            -webkit-mask-image: radial-gradient(circle, #000 55%, transparent 72%);
            mask-image: radial-gradient(circle, #000 55%, transparent 72%);
            animation: spin 6s linear infinite;
        }
        .rip { position: absolute; inset: 30%; border-radius: 50%; border: 2px solid rgba(0,210,255,0.55); opacity: 0; animation: ripple 3.6s ease-out infinite; pointer-events: none; }
        .rip.r2 { border-color: rgba(0,255,204,0.5); animation-delay: 1.8s; }
        @keyframes ripple { 0% { transform: scale(0.6); opacity: 0.7; } 100% { transform: scale(1.75); opacity: 0; } }

        /* quick shortcut cards (rotating glow border) */
        .sc-card { position: relative; display: block; overflow: hidden; border-radius: 14px; padding: 24px 22px; background: var(--bg-card); border: 1px solid var(--border-color); text-decoration: none; color: var(--text-main); transition: transform 0.25s ease; min-width: 0; }
        .sc-card::before { content: ''; position: absolute; inset: -70%; z-index: 0; background: conic-gradient(from 0deg, transparent 0 72%, var(--accent-blue) 88%, var(--accent-green) 100%); animation: spin 5s linear infinite; }
        .sc-card::after { content: ''; position: absolute; inset: 1.5px; z-index: 0; border-radius: 13px; background: var(--bg-card); }
        .sc-card > * { position: relative; z-index: 1; }
        .sc-card:hover { transform: translateY(-6px); }
        .sc-ico { width: 52px; height: 52px; border-radius: 14px; display: flex; align-items: center; justify-content: center; font-size: 22px; margin-bottom: 14px; animation: iconBob 2.4s ease-in-out infinite alternate; }
        @keyframes iconBob { from { transform: translateY(2px) rotate(-4deg); } to { transform: translateY(-5px) rotate(4deg); } }
        .sc-card h5 { margin: 0 0 6px; font-size: 15px; font-weight: 800; }
        .sc-card p { margin: 0; font-size: 12px; color: var(--text-muted); line-height: 1.55; }
        .sc-go { display: inline-flex; align-items: center; gap: 7px; margin-top: 14px; font-size: 11.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; color: var(--accent-blue); transition: gap 0.2s; }
        .sc-card:hover .sc-go { gap: 12px; }


        /* ===== Cap leaders ===== */
        .cap-head { display: flex; align-items: center; justify-content: space-between; gap: 10px; flex-wrap: wrap; margin-bottom: 18px; }
        .cap-head h3 { margin: 0; font-size: 15px; font-weight: 800; display: flex; align-items: center; gap: 10px; }
        .cap-crown { width: 36px; height: 36px; border-radius: 11px; display: flex; align-items: center; justify-content: center; font-size: 16px; animation: iconBob 2.4s ease-in-out infinite alternate; }
        .cap-row { display: flex; align-items: center; gap: 12px; padding: 13px 0; border-bottom: 1px solid var(--border-color); }
        .cap-row:last-child { border-bottom: none; padding-bottom: 0; }
        .cap-rank { width: 22px; font-size: 13px; font-weight: 900; color: var(--text-muted); text-align: center; flex-shrink: 0; }
        .cap-av { width: 42px; height: 42px; border-radius: 50%; flex-shrink: 0; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 14px; color: #07090e; }
        .cap-av.glow { animation: capGlow 1.8s ease-in-out infinite alternate; }
        @keyframes capGlow { from { box-shadow: 0 0 0 0 rgba(255,255,255,0.0), 0 0 8px var(--g); } to { box-shadow: 0 0 0 5px rgba(255,255,255,0.05), 0 0 22px var(--g); } }
        .cap-main { flex: 1; min-width: 0; }
        .cap-name { margin: 0 0 2px; font-size: 13.5px; font-weight: 800; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .cap-team { margin: 0 0 8px; font-size: 11.5px; color: var(--text-muted); }
        .cap-val { text-align: right; flex-shrink: 0; }
        .cap-val b { display: block; font-size: 20px; font-weight: 900; line-height: 1; }
        .cap-val span { font-size: 10px; color: var(--text-muted); text-transform: uppercase; font-weight: 700; }

        /* ===== Hall of fame ===== */
        .hof-card { position: relative; overflow: hidden; text-align: center; }
        .hof-card::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 3px; background: linear-gradient(90deg, #f59e0b, #fde68a, #f59e0b); }
        .hof-card::after { content: ''; position: absolute; top: -50%; left: -60%; width: 40%; height: 200%; background: linear-gradient(90deg, transparent, rgba(255,255,255,0.09), transparent); transform: rotate(20deg); animation: shineMove 5s ease-in-out infinite; pointer-events: none; }
        @keyframes shineMove { 0% { left: -60%; } 60%, 100% { left: 130%; } }
        .hof-trophy { width: 60px; height: 60px; margin: 6px auto 12px; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 26px; color: #fbbf24; background: radial-gradient(circle, rgba(251,191,36,0.22), rgba(251,191,36,0.04)); border: 1.5px solid rgba(251,191,36,0.5); box-shadow: 0 0 22px rgba(251,191,36,0.25); animation: iconBob 2.4s ease-in-out infinite alternate; }
        .hof-year { display: inline-block; font-size: 11px; font-weight: 800; letter-spacing: 1px; color: #fbbf24; background: rgba(251,191,36,0.12); border: 1px solid rgba(251,191,36,0.35); padding: 3px 11px; border-radius: 20px; margin-bottom: 10px; }
        .hof-team { margin: 0 0 4px; font-size: 16px; font-weight: 900; }
        .hof-sub { margin: 0; font-size: 11.5px; color: var(--text-muted); }
        .hof-meta { margin-top: 14px; padding-top: 12px; border-top: 1px solid var(--border-color); font-size: 11.5px; color: var(--text-muted); }
        .hof-meta strong { color: var(--text-main); }

        /* LIVE SCORE TICKER */
        .ticker-bar { background: var(--bg-card); border: 1px solid var(--border-color); border-radius: 12px; padding: 12px 20px; display: flex; align-items: center; gap: 20px; margin-bottom: 30px; overflow-x: auto; }
        .live-badge { background: rgba(255, 51, 102, 0.15); color: var(--accent-red); border: 1px solid var(--accent-red); font-size: 10px; font-weight: bold; padding: 3px 8px; border-radius: 4px; text-transform: uppercase; white-space: nowrap; }
        .ticker-match { display: flex; align-items: center; gap: 15px; font-size: 12px; font-weight: 500; border-right: 1px solid var(--border-color); padding-right: 20px; white-space: nowrap; }

        /* QUICK NAV */
        .card-box { background: var(--bg-card); border: 1px solid var(--border-color); border-radius: 14px; padding: 25px; margin-bottom: 40px; }
        .card-box h3 { font-size: 16px; margin: 0 0 15px 0; display: flex; align-items: center; gap: 8px; }
        .quick-nav-grid { display: grid; grid-template-columns: repeat(5, 1fr); gap: 15px; }
        .quick-nav-item { background: var(--bg-main); border: 1px solid var(--border-color); padding: 15px; border-radius: 10px; text-align: center; text-decoration: none; color: var(--text-main); font-size: 13px; font-weight: 600; transition: all 0.2s; }
        .quick-nav-item:hover { border-color: var(--accent-blue); background: var(--bg-card-hover); color: var(--accent-blue); transform: translateY(-3px); }

        /* SECTION TITLE */
        .section-title { font-size: 18px; font-weight: 700; margin: 40px 0 18px 0; display: flex; justify-content: space-between; align-items: center; gap: 6px 12px; flex-wrap: wrap; border-left: 4px solid var(--accent-blue); padding-left: 12px; }

        /* MEDIA GALLERY */
        .cards-grid-8 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 35px; }
        .media-card { background: var(--bg-card); border: 1px solid var(--border-color); border-radius: 12px; overflow: hidden; transition: transform 0.2s, border-color 0.2s; }
        .media-card:hover { transform: translateY(-4px); border-color: var(--accent-green); }
        .media-card img { width: 100%; height: 170px; object-fit: cover; background: #000; display: block; }
        .media-body { padding: 15px; }
        .media-body h5 { margin: 0 0 5px 0; font-size: 14px; font-weight: 600; }
        .media-body p { margin: 0; font-size: 12px; color: var(--text-muted); }

        /* MEDIA GALLERY FIX: heading + paragraph on top, image below, image fills the whole card width (no side gaps) */
        .cards-grid-8 { align-items: stretch; }
        .media-card { display: flex; flex-direction: column; min-width: 0; height: 100%; }
        .media-body { order: 1; padding: 16px 16px 14px 16px; min-width: 0; }
        .media-body h5 { font-size: 15px; font-weight: 700; line-height: 1.35; overflow-wrap: anywhere; }
        .media-body p { line-height: 1.55; overflow-wrap: anywhere; }
        .media-card img { order: 2; display: block; width: 100%; max-width: 100%; height: auto; aspect-ratio: 16 / 10; object-fit: cover; object-position: center; background: #000; border-top: 1px solid var(--border-color); margin-top: auto; }

        /* GENERIC ADMIN CARD GRID SYSTEM */
        .adm-grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: 22px; margin-bottom: 40px; }
        .adm-grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 20px; margin-bottom: 40px; }
        .adm-grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; margin-bottom: 40px; }
        .adm-card { background: var(--bg-card); border: 1px solid var(--border-color); border-radius: 14px; padding: 22px; transition: all 0.25s ease; min-width: 0; }
        .adm-card:hover { border-color: var(--accent-blue); transform: translateY(-4px); }
        .adm-card.flat:hover { transform: none; }
        .adm-single { margin-bottom: 40px; }

        /* ===== NEW 1: ANIMATED STATS COUNTERS ===== */
        .stat-card { position: relative; overflow: hidden; text-align: center; }
        .stat-card::after { content: ''; position: absolute; left: 0; bottom: 0; width: 100%; height: 3px; background: linear-gradient(90deg, var(--accent-blue), var(--accent-green)); }
        .stat-ico { width: 50px; height: 50px; border-radius: 14px; margin: 0 auto 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; }
        .stat-num { font-size: 32px; font-weight: 900; margin: 0 0 4px; font-variant-numeric: tabular-nums; }
        .stat-lbl { font-size: 11.5px; color: var(--text-muted); text-transform: uppercase; font-weight: 700; letter-spacing: 0.5px; }
        .stat-trend { display: inline-flex; align-items: center; gap: 5px; margin-top: 10px; font-size: 11px; font-weight: 800; color: var(--accent-green); background: rgba(0,255,204,0.12); padding: 3px 9px; border-radius: 20px; }

        /* ===== Tournament formats / match-day cards ===== */
        .fmt-ico { width: 48px; height: 48px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 20px; margin-bottom: 14px; background: rgba(0,210,255,0.12); color: var(--accent-blue); border: 1px solid rgba(0,210,255,0.4); }
        .adm-card h5 { margin: 0 0 6px; font-size: 14.5px; font-weight: 800; }
        .adm-card p.sub { margin: 0; font-size: 12px; color: var(--text-muted); line-height: 1.55; }
        .pill { display: inline-flex; align-items: center; gap: 5px; margin-top: 12px; font-size: 10.5px; font-weight: 800; text-transform: uppercase; padding: 4px 10px; border-radius: 20px; white-space: nowrap; }
        .pill.cyan { background: rgba(0,210,255,0.14); color: var(--accent-blue); }
        .pill.green { background: rgba(0,255,204,0.14); color: var(--accent-green); }
        .pill.amber { background: rgba(245,158,11,0.14); color: var(--accent-amber); }
        .pill.red { background: rgba(255,51,102,0.14); color: var(--accent-red); }
        .pill.purple { background: rgba(192,132,252,0.14); color: var(--accent-purple); }
        .pill .dot { width: 6px; height: 6px; border-radius: 50%; background: currentColor; animation: pulseDot 1.2s infinite; }

        /* ===== NEW 2: WEEKLY ACTIVITY CHART ===== */
        .chart-legend { display: flex; gap: 18px; flex-wrap: wrap; margin-bottom: 18px; font-size: 12px; font-weight: 700; color: var(--text-secondary); }
        .chart-legend i { display: inline-block; width: 10px; height: 10px; border-radius: 3px; margin-right: 6px; }
        .chart { display: grid; grid-template-columns: repeat(7, 1fr); gap: 10px; height: 230px; align-items: stretch; padding-bottom: 4px; border-bottom: 1px solid var(--border-color); }
        .chart-col { display: flex; flex-direction: column; justify-content: flex-end; align-items: center; height: 100%; min-width: 0; }
        .chart-bars { display: flex; align-items: flex-end; justify-content: center; gap: 4px; width: 100%; height: calc(100% - 24px); }
        .cbar { width: min(18px, 42%); height: 0; border-radius: 6px 6px 0 0; transition: height 1.1s cubic-bezier(.2,.8,.2,1); }
        .cbar.c1 { background: linear-gradient(180deg, var(--accent-blue), #0284c7); box-shadow: 0 0 12px rgba(0,210,255,0.35); }
        .cbar.c2 { background: linear-gradient(180deg, var(--accent-green), #059669); box-shadow: 0 0 12px rgba(0,255,204,0.3); }
        .chart.in .cbar { height: var(--h); }
        .chart-day { margin-top: 8px; font-size: 11px; font-weight: 700; color: var(--text-muted); text-transform: uppercase; height: 16px; }
        .chart-foot { display: flex; justify-content: space-between; flex-wrap: wrap; gap: 10px; margin-top: 16px; font-size: 12px; color: var(--text-muted); }
        .chart-foot strong { color: var(--text-main); }

        /* ===== NEW 3: TOURNAMENT PROGRESS ===== */
        .tp-row { padding: 16px 0; border-bottom: 1px solid var(--border-color); }
        .tp-row:last-child { border-bottom: none; padding-bottom: 0; }
        .tp-row:first-child { padding-top: 0; }
        .tp-head { display: flex; justify-content: space-between; align-items: center; gap: 10px; flex-wrap: wrap; margin-bottom: 9px; }
        .tp-name { font-size: 13.5px; font-weight: 800; display: flex; align-items: center; gap: 9px; min-width: 0; }
        .tp-name i { color: var(--accent-amber); }
        .tp-track { height: 10px; background: var(--bg-main); border-radius: 8px; border: 1px solid var(--border-color); overflow: hidden; }
        .tp-fill { height: 100%; width: 0; border-radius: 8px; transition: width 1.3s cubic-bezier(.2,.8,.2,1); background: linear-gradient(90deg, var(--accent-blue), var(--accent-green)); }
        .tp-fill.amber { background: linear-gradient(90deg, var(--accent-amber), #fbbf24); }
        .tp-fill.purple { background: linear-gradient(90deg, var(--accent-purple), var(--accent-blue)); }
        .tp-meta { display: flex; justify-content: space-between; gap: 10px; flex-wrap: wrap; margin-top: 7px; font-size: 11.5px; color: var(--text-muted); }

        /* ===== Venues ===== */
        .venue-top { display: flex; align-items: center; gap: 12px; margin-bottom: 14px; }
        .venue-top .fmt-ico { margin-bottom: 0; flex-shrink: 0; background: rgba(192,132,252,0.12); color: var(--accent-purple); border-color: rgba(192,132,252,0.4); }
        .venue-meta { display: flex; justify-content: space-between; gap: 10px; border-top: 1px solid var(--border-color); padding-top: 12px; margin-top: 14px; font-size: 11.5px; color: var(--text-muted); }
        .venue-meta strong { color: var(--text-main); }

        /* System Health */
        .health-row { display: flex; align-items: center; justify-content: space-between; gap: 10px; padding: 13px 0; border-bottom: 1px solid var(--border-color); }
        .health-row:last-child { border-bottom: none; padding-bottom: 0; }
        .health-row:first-child { padding-top: 0; }
        .health-left { display: flex; align-items: center; gap: 12px; font-size: 13px; font-weight: 600; min-width: 0; }
        .health-left i { width: 34px; height: 34px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .health-status { font-size: 11px; font-weight: 800; padding: 4px 10px; border-radius: 20px; text-transform: uppercase; white-space: nowrap; }

        /* Pending Approvals */
        .approval-row { display: flex; align-items: center; justify-content: space-between; gap: 12px; flex-wrap: wrap; padding: 14px 0; border-bottom: 1px solid var(--border-color); }
        .approval-row:last-child { border-bottom: none; padding-bottom: 0; }
        .approval-row:first-child { padding-top: 0; }
        .approval-info { display: flex; align-items: center; gap: 12px; min-width: 0; }
        .approval-icon { width: 36px; height: 36px; border-radius: 10px; background: rgba(0,210,255,0.12); color: var(--accent-blue); display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .approval-name { font-size: 13.5px; font-weight: 700; color: var(--text-main); margin: 0; }
        .approval-sub { font-size: 11.5px; color: var(--text-muted); margin: 0; }
        .approval-actions { display: flex; gap: 8px; }
        .btn-mini { border: none; border-radius: 8px; padding: 6px 12px; font-size: 11.5px; font-weight: 700; cursor: pointer; }
        .btn-mini.approve { background: rgba(0,255,204,0.15); color: var(--accent-green); border: 1px solid rgba(0,255,204,0.4); }
        .btn-mini.reject { background: rgba(255,51,102,0.12); color: var(--accent-red); border: 1px solid rgba(255,51,102,0.35); }

        /* Activity Log */
        .log-row { display: flex; gap: 14px; padding: 13px 0; border-bottom: 1px solid var(--border-color); align-items: flex-start; }
        .log-row:last-child { border-bottom: none; padding-bottom: 0; }
        .log-row:first-child { padding-top: 0; }
        .log-dot { width: 8px; height: 8px; border-radius: 50%; margin-top: 5px; flex-shrink: 0; }
        .log-text { font-size: 13px; color: var(--text-main); font-weight: 600; }
        .log-text span { color: var(--text-muted); font-weight: 500; }
        .log-time { font-size: 11px; color: var(--text-muted); margin-top: 2px; }

        /* Leaderboard */
        .perf-card { text-align: center; position: relative; }
        .perf-rank { position: absolute; top: 12px; left: 12px; width: 24px; height: 24px; border-radius: 50%; background: rgba(0,210,255,0.15); color: var(--accent-blue); font-size: 11px; font-weight: 900; display: flex; align-items: center; justify-content: center; }
        .perf-avatar { width: 58px; height: 58px; border-radius: 50%; margin: 8px auto 12px auto; background: linear-gradient(135deg, var(--accent-blue), #0284c7); color: #07090e; display: flex; align-items: center; justify-content: center; font-size: 19px; font-weight: 900; }
        .perf-name { font-size: 13.5px; font-weight: 800; color: var(--text-main); margin: 0 0 2px 0; }
        .perf-role { font-size: 10.5px; color: var(--accent-blue); font-weight: 600; text-transform: uppercase; margin: 0 0 10px 0; }
        .perf-stat { font-size: 19px; font-weight: 900; color: var(--accent-green); margin: 0; }
        .perf-stat-label { font-size: 10px; color: var(--text-muted); text-transform: uppercase; margin: 0; }

        /* Fixtures */
        .fx-teams { display: flex; justify-content: space-between; align-items: center; gap: 10px; margin: 4px 0 14px 0; }
        .fx-team { font-size: 13px; font-weight: 800; color: var(--text-main); text-align: center; flex: 1; min-width: 0; }
        .fx-vs { width: 32px; height: 32px; border-radius: 50%; background: rgba(0,210,255,0.15); border: 1px solid rgba(0,210,255,0.4); color: var(--accent-blue); font-weight: 900; font-size: 11px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .fx-meta { display: flex; justify-content: space-between; gap: 8px; flex-wrap: wrap; font-size: 11px; color: var(--text-muted); border-top: 1px solid var(--border-color); padding-top: 10px; }

        /* ===== NEW 4: REGISTRATION & FEE COLLECTION ===== */
        .fee-wrap { display: flex; align-items: center; gap: 26px; flex-wrap: wrap; justify-content: center; }
        .donut { position: relative; width: 160px; height: 160px; border-radius: 50%; flex-shrink: 0;
            background: conic-gradient(var(--accent-green) 0 75%, var(--accent-amber) 75% 91.7%, var(--accent-red) 91.7% 100%);
            animation: donutIn 1.2s ease both; box-shadow: 0 0 30px rgba(0,255,204,0.15); }
        .donut::after { content: ''; position: absolute; inset: 20px; border-radius: 50%; background: var(--bg-card); }
        .donut-center { position: absolute; inset: 0; z-index: 1; display: flex; flex-direction: column; align-items: center; justify-content: center; }
        .donut-center b { font-size: 26px; font-weight: 900; color: var(--accent-green); }
        .donut-center span { font-size: 10.5px; color: var(--text-muted); text-transform: uppercase; font-weight: 700; }
        @keyframes donutIn { from { transform: rotate(-120deg) scale(0.6); opacity: 0; } to { transform: rotate(0) scale(1); opacity: 1; } }
        .fee-legend { display: flex; flex-direction: column; gap: 12px; font-size: 13px; font-weight: 600; min-width: 160px; }
        .fee-legend div { display: flex; align-items: center; gap: 10px; }
        .fee-legend i { width: 11px; height: 11px; border-radius: 3px; flex-shrink: 0; }
        .fee-legend span { color: var(--text-muted); margin-left: auto; padding-left: 10px; }
        .fee-row { display: flex; align-items: center; justify-content: space-between; gap: 12px; padding: 14px 0; border-bottom: 1px solid var(--border-color); }
        .fee-row:first-child { padding-top: 0; }
        .fee-row:last-child { border-bottom: none; padding-bottom: 0; }
        .fee-row .l { display: flex; align-items: center; gap: 12px; font-size: 13px; font-weight: 700; min-width: 0; }
        .fee-row .l i { width: 34px; height: 34px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .fee-row .amt { font-size: 17px; font-weight: 900; white-space: nowrap; }

        /* Roles Breakdown */
        .role-bar-row { margin-bottom: 16px; }
        .role-bar-row:last-child { margin-bottom: 0; }
        .role-bar-label { display: flex; justify-content: space-between; font-size: 12.5px; font-weight: 700; margin-bottom: 6px; }
        .role-bar-track { height: 9px; background: var(--bg-main); border-radius: 8px; overflow: hidden; border: 1px solid var(--border-color); }
        .role-bar-fill { height: 100%; border-radius: 8px; }

        /* Alerts */
        .alert-row { display: flex; gap: 14px; align-items: flex-start; padding: 14px 0; border-bottom: 1px solid var(--border-color); }
        .alert-row:last-child { border-bottom: none; padding-bottom: 0; }
        .alert-row:first-child { padding-top: 0; }
        .alert-icon { width: 36px; height: 36px; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 14px; flex-shrink: 0; }
        .alert-title { font-size: 13px; font-weight: 700; color: var(--text-main); margin: 0 0 2px 0; }
        .alert-desc { font-size: 11.5px; color: var(--text-muted); margin: 0; }

        /* Tips */
        .tip-row { display: flex; gap: 14px; align-items: flex-start; }
        .tip-num-adm { width: 30px; height: 30px; border-radius: 9px; background: rgba(0,210,255,0.12); color: var(--accent-blue); font-weight: 900; font-size: 13px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .tip-title { font-size: 13px; font-weight: 700; color: var(--text-main); margin: 0 0 2px 0; }
        .tip-desc { font-size: 12px; color: var(--text-muted); margin: 0; line-height: 1.5; }

        /* Help CTA */
        .help-cta { position: relative; overflow: hidden; background: linear-gradient(135deg, #0e3a4d 0%, #0e121c 60%, #07090e 100%); border-radius: 20px; padding: 40px; margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between; gap: 25px; flex-wrap: wrap; border: 1px solid var(--border-color); }
        .help-cta-text h2 { font-size: 22px; font-weight: 800; margin: 0 0 8px 0; color: var(--text-main); }
        .help-cta-text p { font-size: 13px; color: var(--text-muted); margin: 0; max-width: 480px; }
        .help-cta .btn-help { background: var(--accent-blue); color: #07090e; border: none; padding: 12px 24px; border-radius: 10px; font-weight: 800; font-size: 13px; cursor: pointer; display: inline-flex; align-items: center; justify-content: center; gap: 8px; white-space: nowrap; box-shadow: 0 0 20px rgba(0,210,255,0.35); font-family: inherit; }

        /* ================= RESPONSIVE ================= */
        @media(max-width: 1100px) {
            .cards-grid-8 { grid-template-columns: repeat(2, 1fr); }
            .quick-nav-grid { grid-template-columns: repeat(3, 1fr); }
            .adm-grid-3, .adm-grid-4 { grid-template-columns: repeat(2, 1fr); }
            .adm-grid-2 { grid-template-columns: 1fr; }
        }
        @media(max-width: 900px) {
            .hero-banner { grid-template-columns: 1fr; text-align: center; padding: 34px 26px; gap: 22px; }
            .season-tag, .hero-btns { justify-content: center; }
            .hero-content p { margin-left: auto; margin-right: auto; }
            .hero-art { width: min(230px, 62vw); }
        }
        @media(max-width: 700px) {
            .container { padding: 0 14px; margin: 16px auto; }
            .hero-content h1 { font-size: 25px; }
            .cards-grid-8 { grid-template-columns: 1fr; }
            .quick-nav-grid { grid-template-columns: repeat(2, 1fr); gap: 10px; }
            .adm-grid-3, .adm-grid-4.one-mobile { grid-template-columns: 1fr; }
            .adm-grid-4 { grid-template-columns: repeat(2, 1fr); gap: 12px; }
            .adm-grid-4.one-mobile { grid-template-columns: 1fr; }
            .adm-card { padding: 18px; }
            .card-box { padding: 18px; }
            .section-title { font-size: 16px; margin: 30px 0 14px; }
            .stat-num { font-size: 26px; }
            .chart { height: 200px; gap: 6px; }
            .help-cta { padding: 26px 20px; flex-direction: column; text-align: center; }
            .help-cta .btn-help { width: 100%; }
            .approval-actions { width: 100%; }
            .approval-actions .btn-mini { flex: 1; padding: 8px 12px; }
            .fee-wrap { flex-direction: column; }
            .fee-legend { width: 100%; }
        }
        @media(max-width: 480px) {
            .hero-art { display: none; }
            .hero-banner { padding: 28px 18px; }
            .hero-btns { flex-direction: column; }
            .hero-btns a { width: 100%; }
            .hero-clock { width: 100%; justify-content: center; }
            .quick-nav-grid { grid-template-columns: 1fr; }
            .adm-grid-4 { grid-template-columns: 1fr; }
            .adm-grid-4.stats-4 { grid-template-columns: repeat(2, 1fr); }
            .stat-ico { width: 42px; height: 42px; font-size: 17px; }
            .ticker-match { gap: 10px; padding-right: 14px; }
            .media-card img { aspect-ratio: 4 / 3; }
            .media-body { padding: 14px; }
        }
        /* GRAND FOOTER */
        .grand-footer-section { background: linear-gradient(135deg, rgba(14, 18, 28, 0.98), rgba(5, 7, 12, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,210,255,0.5); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        @media(max-width: 650px) { .footer-socials { justify-content: center; } }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(0, 210, 255, 0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #07090e; transform: translateY(-3px); box-shadow: 0 0 15px rgba(0,210,255,0.6); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; background: rgba(7, 9, 14, 0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter input:focus { border-color: var(--neon-cyan); box-shadow: 0 0 10px rgba(0,210,255,0.3); }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #07090e; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; transition: 0.3s; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }
    </style>

    <!-- 🌟 NEW: LIGHT MODE FIX (navbar.jsp ka html[data-theme="light"] follow karta hai) - dark mode same rehta hai -->
    <style>
        html[data-theme="light"] {
            --bg-main: #f1f5f9;
            --bg-card: #ffffff;
            --bg-card-hover: #e0f2fe;
            --accent-red: #e11d48;
            --accent-green: #059669;
            --accent-blue: #0284c7;
            --accent-amber: #d97706;
            --accent-purple: #9333ea;
            --text-main: #0f172a;
            --text-muted: #475569;
            --border-color: #cbd5e1;
            --neon-cyan: #0284c7;
            --neon-emerald: #059669;
            --border-glass: rgba(2, 132, 199, 0.3);
            --text-primary: #0f172a;
            --text-secondary: #334155;
        }

        /* HERO */
        html[data-theme="light"] .hero-banner {
            background: linear-gradient(120deg, #e0f2fe, #f0fdf4, #ede9fe, #e0f2fe);
            background-size: 300% 300%;
            box-shadow: 0 15px 35px rgba(15, 23, 42, 0.12);
        }
        html[data-theme="light"] .hero-grid-lines {
            background-image:
                linear-gradient(rgba(2,132,199,0.10) 1px, transparent 1px),
                linear-gradient(90deg, rgba(2,132,199,0.10) 1px, transparent 1px);
        }
        html[data-theme="light"] .hero-content h1 { color: #0f172a; text-shadow: none; }
        html[data-theme="light"] .hero-content p { color: #475569; }
        html[data-theme="light"] .hero-clock { background: rgba(255,255,255,0.75); border-color: rgba(2,132,199,0.3); }
        html[data-theme="light"] .btn-primary { color: #ffffff; box-shadow: 0 6px 16px rgba(2,132,199,0.3); }
        html[data-theme="light"] .btn-primary:hover { color: #ffffff; }
        /* ✅ FIX 1: "View Teams" button visible */
        html[data-theme="light"] .btn-secondary {
            background: #ffffff; color: #0f172a; border: 1.5px solid #0284c7;
            box-shadow: 0 4px 12px rgba(15, 23, 42, 0.08);
        }
        html[data-theme="light"] .btn-secondary:hover { background: #e0f2fe; color: #0284c7; border-color: #0284c7; }

        /* CARDS / TEXT */
        html[data-theme="light"] .ticker-bar,
        html[data-theme="light"] .card-box,
        html[data-theme="light"] .adm-card,
        html[data-theme="light"] .media-card,
        html[data-theme="light"] .sc-card { box-shadow: 0 6px 18px rgba(15, 23, 42, 0.06); }
        html[data-theme="light"] .quick-nav-item { background: #ffffff; color: #0f172a; }
        html[data-theme="light"] .quick-nav-item:hover { background: #e0f2fe; color: #0284c7; }
        html[data-theme="light"] .media-body h5,
        html[data-theme="light"] .sc-card h5,
        html[data-theme="light"] .adm-card h5,
        html[data-theme="light"] .hof-team { color: #0f172a; }
        html[data-theme="light"] .section-title { color: #0f172a; }
        html[data-theme="light"] .hof-year { color: #b45309; background: rgba(245,158,11,0.14); border-color: rgba(180,83,9,0.35); }
        html[data-theme="light"] .hof-trophy { color: #d97706; }

        /* ✅ FIX 2: "Need Help Managing the System?" banner visible */
        html[data-theme="light"] .help-cta {
            background: linear-gradient(135deg, #e0f2fe 0%, #f0fdf4 60%, #ffffff 100%);
            border: 1.5px solid #cbd5e1;
            box-shadow: 0 10px 25px rgba(15, 23, 42, 0.10);
        }
        html[data-theme="light"] .help-cta-text h2 { color: #0f172a; }
        html[data-theme="light"] .help-cta-text p { color: #475569; }
        html[data-theme="light"] .help-cta .btn-help { background: #0284c7; color: #ffffff; box-shadow: 0 6px 16px rgba(2,132,199,0.3); }

        /* FOOTER */
        html[data-theme="light"] .footer-newsletter input { background: #ffffff; color: #0f172a; border-color: #cbd5e1; }
        html[data-theme="light"] .footer-newsletter input::placeholder { color: #64748b; opacity: 1; }
        html[data-theme="light"] .footer-newsletter button { color: #ffffff; }
        html[data-theme="light"] .footer-socials a:hover { color: #ffffff; }
        html[data-theme="light"] .grand-footer-section { box-shadow: 0 -10px 30px rgba(15,23,42,0.12); }
        @media (max-width: 400px) {
            .footer-newsletter form { flex-direction: column; }
            .footer-newsletter button { width: 100%; }
        }
    </style>

    <!-- 🌟 NEW FIX 1: Hero buttons (Manage Matches + View Teams) mobile pe ek hi line me -->
    <style>
        @media (max-width: 480px) {
            .hero-banner .hero-btns {
                flex-direction: row !important;
                flex-wrap: nowrap !important;
                gap: 8px !important;
                width: 100%;
            }
            .hero-banner .hero-btns a {
                width: auto !important;
                flex: 1 1 0 !important;
                min-width: 0;
                padding: 11px 8px !important;
                font-size: 12.5px !important;
                gap: 5px !important;
                white-space: nowrap;
            }
        }
        @media (max-width: 360px) {
            .hero-banner .hero-btns a { font-size: 11.5px !important; padding: 10px 5px !important; }
        }
    </style>

    <!-- 🌟 NEW FIX 2: Continuous scrolling ticker (cricket + project + admin text) - purani ticker hide, nayi add -->
    <style>
        .ticker-bar:not(.ticker-pro) { display: none !important; }

        .ticker-pro {
            display: flex;
            align-items: center;
            gap: 0;
            overflow: hidden;
            padding: 0;
            margin-bottom: 30px;
            background: var(--bg-card);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            position: relative;
        }
        .ticker-pro .tp-badge {
            flex-shrink: 0;
            display: inline-flex;
            align-items: center;
            gap: 7px;
            padding: 0 16px;
            height: 46px;
            background: var(--bg-card);
            border-right: 1px solid var(--border-color);
            position: relative;
            z-index: 2;
        }
        .ticker-pro .tp-badge .live-badge { display: inline-flex; align-items: center; gap: 6px; }
        .ticker-pro .tp-badge .live-badge .dot { width: 6px; height: 6px; border-radius: 50%; background: var(--accent-red); animation: pulseDot 1.2s infinite; }
        .ticker-pro .tp-viewport {
            flex: 1;
            min-width: 0;
            overflow: hidden;
            position: relative;
            -webkit-mask-image: linear-gradient(90deg, transparent 0, #000 24px, #000 calc(100% - 24px), transparent 100%);
            mask-image: linear-gradient(90deg, transparent 0, #000 24px, #000 calc(100% - 24px), transparent 100%);
        }
        .ticker-pro .tp-track-move {
            display: inline-flex;
            align-items: center;
            white-space: nowrap;
            will-change: transform;
            animation: tickerPro 60s linear infinite;
        }
        .ticker-pro:hover .tp-track-move { animation-play-state: paused; }
        .ticker-pro .tp-item {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            font-size: 12.5px;
            font-weight: 600;
            color: var(--text-main);
            padding: 0 22px;
            height: 46px;
            position: relative;
        }
        .ticker-pro .tp-item::after {
            content: '';
            position: absolute;
            right: 0;
            top: 50%;
            width: 5px;
            height: 5px;
            margin-top: -2.5px;
            border-radius: 50%;
            background: var(--accent-blue);
            opacity: 0.6;
        }
        .ticker-pro .tp-item i { font-size: 12.5px; }
        .ticker-pro .tp-item strong { font-weight: 800; }
        .ticker-pro .tp-item .muted { color: var(--text-muted); font-weight: 500; }
        .ticker-pro .c-blue { color: var(--accent-blue); }
        .ticker-pro .c-green { color: var(--accent-green); }
        .ticker-pro .c-amber { color: var(--accent-amber); }
        .ticker-pro .c-red { color: var(--accent-red); }
        .ticker-pro .c-purple { color: var(--accent-purple); }
        @keyframes tickerPro {
            0% { transform: translate3d(0, 0, 0); }
            100% { transform: translate3d(-50%, 0, 0); }
        }
        @media (max-width: 700px) {
            .ticker-pro .tp-badge { padding: 0 10px; height: 42px; }
            .ticker-pro .tp-item { font-size: 11.5px; padding: 0 16px; height: 42px; gap: 6px; }
            .ticker-pro .tp-track-move { animation-duration: 70s; }
        }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">

        <!-- ================= HERO BANNER (animated background + cricket ball) ================= -->
        <div class="hero-banner">
            <div class="hero-grid-lines"></div>
            <div class="hero-glow-orb"></div>
            <div class="hero-glow-orb orb-2"></div>
            <div class="hero-glow-orb orb-3"></div>
            <div class="hero-sparks">
                <span style="--l:8%;  --d:0s;"></span>
                <span style="--l:20%; --d:1.6s;"></span>
                <span style="--l:34%; --d:3.1s;"></span>
                <span style="--l:48%; --d:0.8s;"></span>
                <span style="--l:62%; --d:2.4s;"></span>
                <span style="--l:75%; --d:4.2s;"></span>
                <span style="--l:88%; --d:1.1s;"></span>
                <span style="--l:95%; --d:3.6s;"></span>
            </div>

            <div class="hero-content">
                <span class="season-tag"><span class="live-dot"></span> ADMIN CONTROL CENTER • 2026</span>
                <h1>Welcome back, <span class="name">${sessionScope.user.name}</span>!</h1>
                <p>Manage teams, schedule fixtures and keep tournament standings up to date, all from one place.</p>

                <div class="hero-clock">
                    <span class="greet"><i class="fa-solid fa-sun" id="greetIcon"></i> <span id="greetText">Good morning</span></span>
                    <span class="time" id="liveClock">00:00:00</span>
                    <span class="date" id="liveDate">Thursday, 1 Oct</span>
                </div>

                <div class="hero-btns">
                    <a href="/admin/matches" class="btn-primary"><i class="fa-solid fa-bolt"></i> Manage Matches</a>
                    <a href="/admin/teams" class="btn-secondary"><i class="fa-solid fa-shield-halved"></i> View Teams</a>
                </div>
            </div>

            <div class="hero-art" aria-hidden="true">
                <span class="rip r1"></span><span class="rip r2"></span>
                <div class="orbit o1"><span class="sat"><i class="fa-solid fa-trophy"></i></span></div>
                <div class="orbit o2"><span class="sat"><i class="fa-solid fa-shield-halved"></i></span></div>
                <div class="orbit o3"><span class="sat"><i class="fa-solid fa-bolt"></i></span></div>
                <div class="ball-wrap">
                    <svg viewBox="0 0 100 100" xmlns="http://www.w3.org/2000/svg">
                        <defs>
                            <radialGradient id="ballG" cx="35%" cy="30%" r="75%">
                                <stop offset="0" stop-color="#ff8aa0"/>
                                <stop offset="0.55" stop-color="#e11d48"/>
                                <stop offset="1" stop-color="#6d0620"/>
                            </radialGradient>
                        </defs>
                        <circle cx="50" cy="50" r="46" fill="url(#ballG)"/>
                        <path d="M24 14 C44 36 44 64 24 86" fill="none" stroke="#fff" stroke-width="2.2" stroke-dasharray="4 3" opacity="0.9"/>
                        <path d="M76 14 C56 36 56 64 76 86" fill="none" stroke="#fff" stroke-width="2.2" stroke-dasharray="4 3" opacity="0.9"/>
                        <path d="M30 20 C46 38 46 62 30 80" fill="none" stroke="#fff" stroke-width="1" opacity="0.35"/>
                        <path d="M70 20 C54 38 54 62 70 80" fill="none" stroke="#fff" stroke-width="1" opacity="0.35"/>
                    </svg>
                </div>
                <div class="ball-shadow"></div>
            </div>
        </div>

        <!-- LIVE TICKER -->
        <div class="ticker-bar">
            <span class="live-badge">SYSTEM LIVE</span>
            <div class="ticker-match"><span>CSK <strong>186/4 (18.2)</strong></span><span style="color:var(--text-muted)">vs</span><span>MI <strong>—</strong></span></div>
            <div class="ticker-match" style="border:none;"><span>RCB <strong>142/6 (16.0)</strong></span><span style="color:var(--text-muted)">vs</span><span>GT <strong>98/2 (10.4)</strong></span></div>
        </div>

        <!-- 🌟 NEW: CONTINUOUS SCROLLING TICKER (cricket + project + admin updates) -->
        <div class="ticker-bar ticker-pro">
            <div class="tp-badge"><span class="live-badge"><span class="dot"></span> SYSTEM LIVE</span></div>
            <div class="tp-viewport">
                <div class="tp-track-move" id="tickerProTrack">
                    <span class="tp-item"><i class="fa-solid fa-baseball-bat-ball c-blue"></i> <span>CSK <strong>186/4 (18.2)</strong> <span class="muted">vs</span> MI <strong>Yet to bat</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-circle-dot c-red"></i> <span>RCB <strong>142/6 (16.0)</strong> <span class="muted">vs</span> GT <strong>98/2 (10.4)</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-hourglass-half c-amber"></i> <span><strong>3 approvals pending:</strong> Thunder Kings, Winter Premier League, Rohan Mehta</span></span>
                    <span class="tp-item"><i class="fa-solid fa-crown c-amber"></i> <span>Orange Cap: <strong>Aarav Sharma</strong> <span class="muted">(Titans XI)</span> - <strong>612 runs</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-crown c-purple"></i> <span>Purple Cap: <strong>Ishaan Verma</strong> <span class="muted">(Desert Lions)</span> - <strong>24 wickets</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-ranking-star c-green"></i> <span>Points Table &amp; NRR auto-update after every verified result</span></span>
                    <span class="tp-item"><i class="fa-solid fa-trophy c-amber"></i> <span>Championship Cup 2026: <strong>Round 3 of 4</strong> <span class="muted">- 42 of 56 matches played</span></span></span>
                    <span class="tp-item"><i class="fa-solid fa-snowflake c-blue"></i> <span>Winter Premier League registrations open: <strong>8 of 20 slots filled</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-indian-rupee-sign c-green"></i> <span>Fee collected: <strong>₹9,000</strong> of <strong>₹12,000</strong> target <span class="muted">(₹500 per team)</span></span></span>
                    <span class="tp-item"><i class="fa-solid fa-location-dot c-purple"></i> <span>Narendra Modi Stadium <strong>in use</strong> <span class="muted">|</span> Eden Gardens &amp; Chinnaswamy <strong>available</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-tower-broadcast c-red"></i> <span>Live scoring feed is <strong>active</strong> and syncing with the website</span></span>
                    <span class="tp-item"><i class="fa-solid fa-clipboard-list c-purple"></i> <span>Scorers Desk: <strong>1 slot pending</strong> this week</span></span>
                    <span class="tp-item"><i class="fa-solid fa-clock c-amber"></i> <span>Background jobs <strong>delayed</strong> - check NRR and points sync</span></span>
                    <span class="tp-item"><i class="fa-solid fa-shield-halved c-green"></i> <span>Auth &amp; Security: <strong>Secure</strong> <span class="muted">| Database: Healthy</span></span></span>
                    <span class="tp-item"><i class="fa-solid fa-user-shield c-blue"></i> <span>Admin tip: <strong>review pending approvals daily</strong> to avoid organizer delays</span></span>
                    <span class="tp-item"><i class="fa-solid fa-bolt c-blue"></i> <span>ProMatch Arena - cricket tournament management built with <strong>Spring Boot, JSP &amp; PostgreSQL</strong></span></span>
                    <span class="tp-item"><i class="fa-solid fa-people-group c-green"></i> <span>Manage teams, tournaments, matches and users from one control center</span></span>
                </div>
            </div>
        </div>

        <!-- QUICK NAVIGATION -->
        <div class="card-box">
            <h3><i class="fa-solid fa-compass" style="color: var(--accent-blue);"></i> Quick Navigation & Management Hub</h3>
            <div class="quick-nav-grid">
                <a href="/admin/teams" class="quick-nav-item">⚡ View / Edit Teams</a>
                <a href="/admin/tournaments" class="quick-nav-item">🏆 View / Edit Tournaments</a>
                <a href="/admin/matches" class="quick-nav-item">🏏 View / Edit Matches</a>
                <a href="/admin/pointsTable" class="quick-nav-item">📊 View Points Table</a>
                <a href="/admin/users" class="quick-nav-item">👥 Manage Users</a>
            </div>
        </div>

        <!-- QUICK ADMIN SHORTCUTS (replaced counters) -->
        <div class="section-title"><span>Quick Admin Shortcuts</span><span style="font-size: 12px; color: var(--accent-green); font-weight: normal;">One Click Access ⚡</span></div>
        <div class="adm-grid-4 one-mobile">
            <a href="/admin/tournaments" class="sc-card">
                <div class="sc-ico" style="background: rgba(192,132,252,0.14); color: var(--accent-purple);"><i class="fa-solid fa-trophy"></i></div>
                <h5>Create Tournament</h5><p>Set up a new tournament with format, dates and participating teams.</p>
                <span class="sc-go">Open <i class="fa-solid fa-arrow-right"></i></span>
            </a>
            <a href="/admin/matches" class="sc-card">
                <div class="sc-ico" style="background: rgba(245,158,11,0.14); color: var(--accent-amber);"><i class="fa-solid fa-calendar-plus"></i></div>
                <h5>Schedule Match</h5><p>Pick teams, venue and time for the next fixture in seconds.</p>
                <span class="sc-go">Open <i class="fa-solid fa-arrow-right"></i></span>
            </a>
            <a href="/admin/addTeamPage" class="sc-card">
                <div class="sc-ico" style="background: rgba(0,210,255,0.14); color: var(--accent-blue);"><i class="fa-solid fa-shield-halved"></i></div>
                <h5>Register Team</h5><p>Add a new franchise with coach, owner and team logo.</p>
                <span class="sc-go">Open <i class="fa-solid fa-arrow-right"></i></span>
            </a>
            <a href="/admin/pointsTable" class="sc-card">
                <div class="sc-ico" style="background: rgba(0,255,204,0.14); color: var(--accent-green);"><i class="fa-solid fa-ranking-star"></i></div>
                <h5>Update Points</h5><p>Check standings and recalculate the table after every result.</p>
                <span class="sc-go">Open <i class="fa-solid fa-arrow-right"></i></span>
            </a>
        </div>

        <!-- MEDIA GALLERY (3 images) -->
        <div class="section-title"><span>Match Moments Gallery</span><span style="font-size: 12px; color: var(--accent-blue); font-weight: normal;">Live Media Feed</span></div>
        <div class="cards-grid-8">
            <div class="media-card">
                <img src="https://c4.wallpaperflare.com/wallpaper/883/1002/491/sachin-tendulkar-god-of-cricket-wallpaper-preview.jpg" alt="Stadium">
                <div class="media-body"><h5>Grand Arena Setup</h5><p>Packed stadium during opening match.</p></div>
            </div>
            <div class="media-card">
                <img src="https://www.sportphotogallery.com/content/images/cmsfiles/product/33741/34479-list.jpg" alt="Batting Action">
                <div class="media-body"><h5>Powerplay Batting</h5><p>Aggressive stroke play in action.</p></div>
            </div>
            <div class="media-card">
                <img src="https://images.alphacoders.com/442/442880.jpg" alt="Net Practice">
                <div class="media-body"><h5>Net Practice Session</h5><p>Batsmen sharpening skills before match.</p></div>
            </div>
        </div>

        <!-- REPLACEMENT: TOURNAMENT FORMATS (was Live Video Highlights) -->
        <div class="section-title"><span>Supported Tournament Formats</span><span style="font-size: 12px; color: var(--accent-blue); font-weight: normal;">Choose When Creating 🏆</span></div>
        <div class="adm-grid-4 one-mobile">
            <div class="adm-card"><div class="fmt-ico"><i class="fa-solid fa-bolt"></i></div><h5>T20 Blast</h5><p class="sub">Fast, high-scoring matches that finish in one evening and keep fans on the edge.</p><span class="pill cyan">20 Overs</span></div>
            <div class="adm-card"><div class="fmt-ico" style="background: rgba(0,255,204,0.12); color: var(--accent-green); border-color: rgba(0,255,204,0.4);"><i class="fa-solid fa-hourglass-half"></i></div><h5>One-Day Series</h5><p class="sub">Longer innings that reward planning, partnerships and consistent bowling.</p><span class="pill green">50 Overs</span></div>
            <div class="adm-card"><div class="fmt-ico" style="background: rgba(255,51,102,0.12); color: var(--accent-red); border-color: rgba(255,51,102,0.4);"><i class="fa-solid fa-sitemap"></i></div><h5>Knockout Rounds</h5><p class="sub">Lose once and you are out. Every match feels like a final.</p><span class="pill red">Sudden Exit</span></div>
            <div class="adm-card"><div class="fmt-ico" style="background: rgba(245,158,11,0.12); color: var(--accent-amber); border-color: rgba(245,158,11,0.4);"><i class="fa-solid fa-arrows-rotate"></i></div><h5>Round Robin</h5><p class="sub">Every team plays every other team, and the points table decides the winner.</p><span class="pill amber">League Table</span></div>
        </div>

        <!-- NEW 2: WEEKLY ACTIVITY CHART -->
        <div class="section-title"><span>Weekly Activity Overview</span><span style="font-size: 12px; color: var(--accent-blue); font-weight: normal;">Last 7 Days 📊</span></div>
        <div class="adm-card flat adm-single">
            <div class="chart-legend">
                <span><i style="background: var(--accent-blue);"></i>Matches Scheduled</span>
                <span><i style="background: var(--accent-green);"></i>New Registrations</span>
            </div>
            <div class="chart" id="weekChart">
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:36%;" title="4 matches"></div><div class="cbar c2" style="--h:54%;" title="6 registrations"></div></div><div class="chart-day">Mon</div></div>
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:54%;" title="6 matches"></div><div class="cbar c2" style="--h:36%;" title="4 registrations"></div></div><div class="chart-day">Tue</div></div>
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:45%;" title="5 matches"></div><div class="cbar c2" style="--h:63%;" title="7 registrations"></div></div><div class="chart-day">Wed</div></div>
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:72%;" title="8 matches"></div><div class="cbar c2" style="--h:45%;" title="5 registrations"></div></div><div class="chart-day">Thu</div></div>
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:63%;" title="7 matches"></div><div class="cbar c2" style="--h:81%;" title="9 registrations"></div></div><div class="chart-day">Fri</div></div>
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:90%;" title="10 matches"></div><div class="cbar c2" style="--h:54%;" title="6 registrations"></div></div><div class="chart-day">Sat</div></div>
                <div class="chart-col"><div class="chart-bars"><div class="cbar c1" style="--h:81%;" title="9 matches"></div><div class="cbar c2" style="--h:27%;" title="3 registrations"></div></div><div class="chart-day">Sun</div></div>
            </div>
            <div class="chart-foot">
                <span>Total matches: <strong>49</strong></span>
                <span>Total registrations: <strong>40</strong></span>
                <span>Busiest day: <strong>Saturday</strong></span>
            </div>
        </div>

        <!-- REPLACEMENT: VENUES & STADIUMS (was "More From The Arena") -->
        <div class="section-title"><span>Venues &amp; Stadiums</span><span style="font-size: 12px; color: var(--accent-purple); font-weight: normal;">Match Grounds 🏟️</span></div>
        <div class="adm-grid-4 one-mobile">
            <div class="adm-card"><div class="venue-top"><div class="fmt-ico"><i class="fa-solid fa-location-dot"></i></div><div><h5 style="margin:0;">M. Chinnaswamy Stadium</h5><p class="sub">Bengaluru</p></div></div><span class="pill green">Available</span><div class="venue-meta"><span>Capacity <strong>40,000</strong></span><span>Floodlights <strong>Yes</strong></span></div></div>
            <div class="adm-card"><div class="venue-top"><div class="fmt-ico"><i class="fa-solid fa-location-dot"></i></div><div><h5 style="margin:0;">Wankhede Stadium</h5><p class="sub">Mumbai</p></div></div><span class="pill amber">Booked Soon</span><div class="venue-meta"><span>Capacity <strong>33,000</strong></span><span>Floodlights <strong>Yes</strong></span></div></div>
            <div class="adm-card"><div class="venue-top"><div class="fmt-ico"><i class="fa-solid fa-location-dot"></i></div><div><h5 style="margin:0;">Eden Gardens</h5><p class="sub">Kolkata</p></div></div><span class="pill green">Available</span><div class="venue-meta"><span>Capacity <strong>66,000</strong></span><span>Floodlights <strong>Yes</strong></span></div></div>
            <div class="adm-card"><div class="venue-top"><div class="fmt-ico"><i class="fa-solid fa-location-dot"></i></div><div><h5 style="margin:0;">Narendra Modi Stadium</h5><p class="sub">Ahmedabad</p></div></div><span class="pill cyan">In Use</span><div class="venue-meta"><span>Capacity <strong>1,32,000</strong></span><span>Floodlights <strong>Yes</strong></span></div></div>
        </div>

        <!-- SYSTEM HEALTH STATUS -->
        <div class="section-title"><span>System Health Status</span><span style="font-size: 12px; color: var(--accent-green); font-weight: normal;">All Systems ✅</span></div>
        <div class="adm-card flat adm-single">
            <div class="health-row"><div class="health-left"><i style="background: rgba(0,255,204,0.14); color: var(--accent-green);" class="fa-solid fa-server"></i> Application Server</div><span class="health-status" style="background: rgba(0,255,204,0.14); color: var(--accent-green);">Online</span></div>
            <div class="health-row"><div class="health-left"><i style="background: rgba(0,255,204,0.14); color: var(--accent-green);" class="fa-solid fa-database"></i> Database Connection</div><span class="health-status" style="background: rgba(0,255,204,0.14); color: var(--accent-green);">Healthy</span></div>
            <div class="health-row"><div class="health-left"><i style="background: rgba(245,158,11,0.14); color: var(--accent-amber);" class="fa-solid fa-clock"></i> Background Jobs</div><span class="health-status" style="background: rgba(245,158,11,0.14); color: var(--accent-amber);">Delayed</span></div>
            <div class="health-row"><div class="health-left"><i style="background: rgba(0,255,204,0.14); color: var(--accent-green);" class="fa-solid fa-shield-halved"></i> Auth &amp; Security</div><span class="health-status" style="background: rgba(0,255,204,0.14); color: var(--accent-green);">Secure</span></div>
        </div>

        <!-- PENDING APPROVALS -->
        <div class="section-title"><span>Pending Approvals</span><span style="font-size: 12px; color: var(--accent-amber); font-weight: normal;">Needs Review ⏳</span></div>
        <div class="adm-card flat adm-single">
            <div class="approval-row">
                <div class="approval-info"><div class="approval-icon"><i class="fa-solid fa-shield-cat"></i></div><div><p class="approval-name">Thunder Kings</p><p class="approval-sub">New team registration awaiting approval</p></div></div>
                <div class="approval-actions"><button class="btn-mini approve">Approve</button><button class="btn-mini reject">Reject</button></div>
            </div>
            <div class="approval-row">
                <div class="approval-info"><div class="approval-icon"><i class="fa-solid fa-trophy"></i></div><div><p class="approval-name">Winter Premier League</p><p class="approval-sub">New tournament pending publish</p></div></div>
                <div class="approval-actions"><button class="btn-mini approve">Approve</button><button class="btn-mini reject">Reject</button></div>
            </div>
            <div class="approval-row">
                <div class="approval-info"><div class="approval-icon"><i class="fa-solid fa-user-ninja"></i></div><div><p class="approval-name">Rohan Mehta</p><p class="approval-sub">Player profile flagged for review</p></div></div>
                <div class="approval-actions"><button class="btn-mini approve">Approve</button><button class="btn-mini reject">Reject</button></div>
            </div>
        </div>

        <!-- NEW 3: TOURNAMENT PROGRESS TRACKER -->
        <div class="section-title"><span>Tournament Progress Tracker</span><span style="font-size: 12px; color: var(--accent-green); font-weight: normal;">Season 2026 🎯</span></div>
        <div class="adm-card flat adm-single">
            <div class="tp-row">
                <div class="tp-head"><div class="tp-name"><i class="fa-solid fa-trophy"></i> Championship Cup 2026</div><span class="pill cyan" style="margin-top:0;">Round 3 of 4</span></div>
                <div class="tp-track"><div class="tp-fill" data-w="75" style="--w:75%;"></div></div>
                <div class="tp-meta"><span>42 of 56 matches played</span><span><strong style="color: var(--text-main);">75%</strong> complete</span></div>
            </div>
            <div class="tp-row">
                <div class="tp-head"><div class="tp-name"><i class="fa-solid fa-snowflake"></i> Winter Premier League</div><span class="pill amber" style="margin-top:0;">Registrations Open</span></div>
                <div class="tp-track"><div class="tp-fill amber" data-w="40" style="--w:40%;"></div></div>
                <div class="tp-meta"><span>8 of 20 team slots filled</span><span><strong style="color: var(--text-main);">40%</strong> filled</span></div>
            </div>
            <div class="tp-row">
                <div class="tp-head"><div class="tp-name"><i class="fa-solid fa-bolt"></i> Corporate T20 Blast</div><span class="pill green" style="margin-top:0;">Knockouts</span></div>
                <div class="tp-track"><div class="tp-fill" data-w="90" style="--w:90%;"></div></div>
                <div class="tp-meta"><span>Semifinals completed, final next</span><span><strong style="color: var(--text-main);">90%</strong> complete</span></div>
            </div>
            <div class="tp-row">
                <div class="tp-head"><div class="tp-name"><i class="fa-solid fa-child-reaching"></i> Youth Cricket Series</div><span class="pill purple" style="margin-top:0;">Scheduling</span></div>
                <div class="tp-track"><div class="tp-fill purple" data-w="20" style="--w:20%;"></div></div>
                <div class="tp-meta"><span>Fixtures being prepared</span><span><strong style="color: var(--text-main);">20%</strong> ready</span></div>
            </div>
        </div>

        <!-- NEW: ORANGE CAP & PURPLE CAP LEADERS (replaces Recent Admin Activity) -->
        <div class="section-title"><span>Orange Cap &amp; Purple Cap Leaders</span><span style="font-size: 12px; color: var(--accent-amber); font-weight: normal;">Season Stars ⭐</span></div>
        <div class="adm-grid-2">
            <div class="adm-card flat">
                <div class="cap-head"><h3><span class="cap-crown" style="background: rgba(245,158,11,0.16); color: var(--accent-amber);"><i class="fa-solid fa-crown"></i></span> Orange Cap · Most Runs</h3><span class="pill amber" style="margin-top:0;">Top Scorers</span></div>
                <div class="cap-row"><span class="cap-rank">1</span><div class="cap-av glow" style="background: linear-gradient(135deg,#fbbf24,#f59e0b); --g: rgba(245,158,11,0.7);">AS</div><div class="cap-main"><p class="cap-name">Aarav Sharma</p><p class="cap-team">Titans XI</p><div class="tp-track"><div class="tp-fill amber" data-w="100" style="--w:100%;"></div></div></div><div class="cap-val"><b style="color: var(--accent-amber);">612</b><span>Runs</span></div></div>
                <div class="cap-row"><span class="cap-rank">2</span><div class="cap-av" style="background: linear-gradient(135deg,#fde68a,#f59e0b);">RM</div><div class="cap-main"><p class="cap-name">Rohan Mehta</p><p class="cap-team">Strikers CC</p><div class="tp-track"><div class="tp-fill amber" data-w="94" style="--w:94%;"></div></div></div><div class="cap-val"><b style="color: var(--accent-amber);">574</b><span>Runs</span></div></div>
                <div class="cap-row"><span class="cap-rank">3</span><div class="cap-av" style="background: linear-gradient(135deg,#fde68a,#f59e0b);">KS</div><div class="cap-main"><p class="cap-name">Kabir Singh</p><p class="cap-team">Royal Hawks</p><div class="tp-track"><div class="tp-fill amber" data-w="87" style="--w:87%;"></div></div></div><div class="cap-val"><b style="color: var(--accent-amber);">531</b><span>Runs</span></div></div>
            </div>
            <div class="adm-card flat">
                <div class="cap-head"><h3><span class="cap-crown" style="background: rgba(192,132,252,0.16); color: var(--accent-purple);"><i class="fa-solid fa-crown"></i></span> Purple Cap · Most Wickets</h3><span class="pill purple" style="margin-top:0;">Top Bowlers</span></div>
                <div class="cap-row"><span class="cap-rank">1</span><div class="cap-av glow" style="background: linear-gradient(135deg,#d8b4fe,#a855f7); --g: rgba(192,132,252,0.7);">IV</div><div class="cap-main"><p class="cap-name">Ishaan Verma</p><p class="cap-team">Desert Lions</p><div class="tp-track"><div class="tp-fill purple" data-w="100" style="--w:100%;"></div></div></div><div class="cap-val"><b style="color: var(--accent-purple);">24</b><span>Wickets</span></div></div>
                <div class="cap-row"><span class="cap-rank">2</span><div class="cap-av" style="background: linear-gradient(135deg,#e9d5ff,#a855f7);">DP</div><div class="cap-main"><p class="cap-name">Dev Patel</p><p class="cap-team">Thunder Kings</p><div class="tp-track"><div class="tp-fill purple" data-w="88" style="--w:88%;"></div></div></div><div class="cap-val"><b style="color: var(--accent-purple);">21</b><span>Wickets</span></div></div>
                <div class="cap-row"><span class="cap-rank">3</span><div class="cap-av" style="background: linear-gradient(135deg,#e9d5ff,#a855f7);">AN</div><div class="cap-main"><p class="cap-name">Arjun Nair</p><p class="cap-team">Night Wolves</p><div class="tp-track"><div class="tp-fill purple" data-w="79" style="--w:79%;"></div></div></div><div class="cap-val"><b style="color: var(--accent-purple);">19</b><span>Wickets</span></div></div>
            </div>
        </div>

        <!-- REPLACEMENT: MATCH DAY OPERATIONS (was Security &amp; Audit Snapshot) -->
        <div class="section-title"><span>Match Day Operations</span><span style="font-size: 12px; color: var(--accent-green); font-weight: normal;">Ready To Play 🏏</span></div>
        <div class="adm-grid-4 one-mobile">
            <div class="adm-card"><div class="fmt-ico" style="background: rgba(245,158,11,0.12); color: var(--accent-amber); border-color: rgba(245,158,11,0.4);"><i class="fa-solid fa-coins"></i></div><h5>Toss &amp; Captains</h5><p class="sub">Both team captains confirmed for the next fixture.</p><span class="pill green">Ready</span></div>
            <div class="adm-card"><div class="fmt-ico"><i class="fa-solid fa-person-chalkboard"></i></div><h5>Umpires Panel</h5><p class="sub">On-field and third umpires assigned to upcoming matches.</p><span class="pill green">Assigned</span></div>
            <div class="adm-card"><div class="fmt-ico" style="background: rgba(192,132,252,0.12); color: var(--accent-purple); border-color: rgba(192,132,252,0.4);"><i class="fa-solid fa-clipboard-list"></i></div><h5>Scorers Desk</h5><p class="sub">Official scorers allotted. One slot still open this week.</p><span class="pill amber">1 Pending</span></div>
            <div class="adm-card"><div class="fmt-ico" style="background: rgba(255,51,102,0.12); color: var(--accent-red); border-color: rgba(255,51,102,0.4);"><i class="fa-solid fa-tower-broadcast"></i></div><h5>Live Scoring</h5><p class="sub">Scoreboard feed is active and syncing with the website.</p><span class="pill red"><span class="dot"></span> Live</span></div>
        </div>

        <!-- NEW 4: REGISTRATION & FEE COLLECTION -->
        <div class="section-title"><span>Registration &amp; Fee Collection</span><span style="font-size: 12px; color: var(--accent-amber); font-weight: normal;">Entry Fee ₹500 / Team 💰</span></div>
        <div class="adm-grid-2">
            <div class="adm-card flat">
                <div class="fee-wrap">
                    <div class="donut"><div class="donut-center"><b>75%</b><span>Paid</span></div></div>
                    <div class="fee-legend">
                        <div><i style="background: var(--accent-green);"></i> Paid <span>18 teams</span></div>
                        <div><i style="background: var(--accent-amber);"></i> Pending <span>4 teams</span></div>
                        <div><i style="background: var(--accent-red);"></i> Failed <span>2 teams</span></div>
                    </div>
                </div>
            </div>
            <div class="adm-card flat">
                <div class="fee-row"><div class="l"><i style="background: rgba(0,255,204,0.14); color: var(--accent-green);" class="fa-solid fa-circle-check"></i> Fees Collected</div><span class="amt" style="color: var(--accent-green);">₹9,000</span></div>
                <div class="fee-row"><div class="l"><i style="background: rgba(245,158,11,0.14); color: var(--accent-amber);" class="fa-solid fa-hourglass-half"></i> Payments Pending</div><span class="amt" style="color: var(--accent-amber);">₹2,000</span></div>
                <div class="fee-row"><div class="l"><i style="background: rgba(255,51,102,0.14); color: var(--accent-red);" class="fa-solid fa-circle-xmark"></i> Failed Payments</div><span class="amt" style="color: var(--accent-red);">₹1,000</span></div>
                <div class="fee-row"><div class="l"><i style="background: rgba(0,210,255,0.14); color: var(--accent-blue);" class="fa-solid fa-bullseye"></i> Collection Target</div><span class="amt" style="color: var(--accent-blue);">₹12,000</span></div>
            </div>
        </div>

        <!-- NEW: HALL OF FAME (replaces User Roles + System Alerts) -->
        <div class="section-title"><span>Hall of Fame · Past Champions</span><span style="font-size: 12px; color: #fbbf24; font-weight: normal;">Legends 🏆</span></div>
        <div class="adm-grid-4 one-mobile">
            <div class="adm-card hof-card"><div class="hof-trophy"><i class="fa-solid fa-trophy"></i></div><span class="hof-year">SEASON 2025</span><p class="hof-team">Titans XI</p><p class="hof-sub">Champions</p><div class="hof-meta">Runner-up: <strong>Strikers CC</strong></div></div>
            <div class="adm-card hof-card"><div class="hof-trophy"><i class="fa-solid fa-trophy"></i></div><span class="hof-year">SEASON 2024</span><p class="hof-team">Royal Hawks</p><p class="hof-sub">Champions</p><div class="hof-meta">Runner-up: <strong>Desert Lions</strong></div></div>
            <div class="adm-card hof-card"><div class="hof-trophy"><i class="fa-solid fa-trophy"></i></div><span class="hof-year">SEASON 2023</span><p class="hof-team">Desert Lions</p><p class="hof-sub">Champions</p><div class="hof-meta">Runner-up: <strong>Thunder Kings</strong></div></div>
            <div class="adm-card hof-card"><div class="hof-trophy"><i class="fa-solid fa-trophy"></i></div><span class="hof-year">SEASON 2022</span><p class="hof-team">Thunder Kings</p><p class="hof-sub">Champions</p><div class="hof-meta">Runner-up: <strong>Night Wolves</strong></div></div>
        </div>

        <!-- ADMIN TIPS & BEST PRACTICES -->
        <div class="section-title"><span>Admin Tips &amp; Best Practices</span><span style="font-size: 12px; color: var(--accent-blue); font-weight: normal;">Guidance 💡</span></div>
        <div class="adm-grid-3">
            <div class="adm-card"><div class="tip-row"><div class="tip-num-adm">1</div><div><p class="tip-title">Review approvals daily</p><p class="tip-desc">Clear the pending queue often to avoid delays for organizers.</p></div></div></div>
            <div class="adm-card"><div class="tip-row"><div class="tip-num-adm">2</div><div><p class="tip-title">Audit admin roles monthly</p><p class="tip-desc">Remove unused admin access to keep the system secure.</p></div></div></div>
            <div class="adm-card"><div class="tip-row"><div class="tip-num-adm">3</div><div><p class="tip-title">Watch background jobs</p><p class="tip-desc">Delayed NRR/points jobs can affect live standings accuracy.</p></div></div></div>
        </div>

        <!-- NEED HELP CTA -->
        <div class="help-cta">
            <div class="help-cta-text"><h2>Need Help Managing the System?</h2><p>Chat with the support assistant for quick guidance on approvals, roles, and match scheduling.</p></div>
            <button class="btn-help" onclick="var b=document.querySelector('.chatbot-toggle, .chatbot-btn'); if(b){b.click();}"><i class="fa-solid fa-comment-dots"></i> Chat With Support</button>
        </div>

    </div>

    <jsp:include page="footer.jsp" />
    <jsp:include page="chatbot.jsp" />

    <script>
        /* ---------- Live greeting + clock ---------- */
        (function () {
            var days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
            var months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
            var clockEl = document.getElementById('liveClock');
            var dateEl = document.getElementById('liveDate');
            var greetEl = document.getElementById('greetText');
            var iconEl = document.getElementById('greetIcon');
            function pad(n) { return n < 10 ? '0' + n : '' + n; }
            function tick() {
                var d = new Date();
                var h = d.getHours();
                if (clockEl) clockEl.textContent = pad(h) + ':' + pad(d.getMinutes()) + ':' + pad(d.getSeconds());
                if (dateEl) dateEl.textContent = days[d.getDay()] + ', ' + d.getDate() + ' ' + months[d.getMonth()];
                if (greetEl) {
                    if (h < 12) { greetEl.textContent = 'Good morning'; if (iconEl) iconEl.className = 'fa-solid fa-sun'; }
                    else if (h < 17) { greetEl.textContent = 'Good afternoon'; if (iconEl) iconEl.className = 'fa-solid fa-cloud-sun'; }
                    else { greetEl.textContent = 'Good evening'; if (iconEl) iconEl.className = 'fa-solid fa-moon'; }
                }
            }
            tick();
            setInterval(tick, 1000);
        })();

        /* ---------- Count-up numbers, chart bars, progress bars (on scroll into view) ---------- */
        (function () {
            function countUp(el) {
                var target = parseInt(el.getAttribute('data-target'), 10) || 0;
                var duration = 1400;
                var start = null;
                function step(ts) {
                    if (!start) start = ts;
                    var p = Math.min((ts - start) / duration, 1);
                    var eased = 1 - Math.pow(1 - p, 3);
                    el.textContent = Math.round(target * eased);
                    if (p < 1) requestAnimationFrame(step);
                }
                requestAnimationFrame(step);
            }
            function reveal(el) {
                if (el.classList.contains('count')) { countUp(el); return; }
                if (el.classList.contains('chart')) { el.classList.add('in'); return; }
                if (el.classList.contains('tp-fill')) { el.style.width = el.getAttribute('data-w') + '%'; }
            }
            var targets = Array.prototype.slice.call(document.querySelectorAll('.count, .chart, .tp-fill'));
            if ('IntersectionObserver' in window) {
                var io = new IntersectionObserver(function (entries) {
                    entries.forEach(function (en) {
                        if (en.isIntersecting) { reveal(en.target); io.unobserve(en.target); }
                    });
                }, { threshold: 0.25 });
                targets.forEach(function (t) { io.observe(t); });
            } else {
                targets.forEach(reveal);
            }
        })();
    </script>

    <!-- 🌟 NEW: ticker ko seamless loop banane ke liye items duplicate (continuous chalta rahe) -->
    <script>
        (function () {
            var track = document.getElementById('tickerProTrack');
            if (!track || track.getAttribute('data-cloned') === '1') return;
            track.setAttribute('data-cloned', '1');
            var items = Array.prototype.slice.call(track.children);
            items.forEach(function (it) {
                var c = it.cloneNode(true);
                c.setAttribute('aria-hidden', 'true');
                track.appendChild(c);
            });
        })();
    </script>
</body>
</html>
