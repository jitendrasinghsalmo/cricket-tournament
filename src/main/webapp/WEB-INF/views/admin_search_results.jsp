<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%-- Admin only: anyone else goes to login --%>
<c:if test="${sessionScope.user.role != 'ADMIN'}">
    <c:redirect url="/login" />
</c:if>

<c:set var="page" value="adminSearch" />
<c:set var="tCount" value="${fn:length(teams)}" />
<c:set var="trCount" value="${fn:length(tournaments)}" />
<c:set var="mCount" value="${fn:length(matches)}" />
<c:set var="pCount" value="${fn:length(players)}" />
<c:set var="total" value="${tCount + trCount + mCount + pCount}" />
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ProMatch Arena | Admin Search Results</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        html { scroll-behavior: smooth; }
        :root {
            --bg-main: #030712;
            --bg-card: rgba(13, 18, 30, 0.85);
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
            /* theme-aware surfaces: these flip in light mode so text stays visible */
            --surface-2: rgba(3, 7, 18, 0.55);
            --hero-bg: linear-gradient(135deg, rgba(13,18,30,0.95) 0%, rgba(3,7,18,0.98) 100%);
            --card-shadow: 0 15px 35px rgba(0,0,0,0.4);
        }
        html[data-theme="light"] {
            --surface-2: #f1f5f9;
            --hero-bg: linear-gradient(135deg, #ffffff 0%, #e0f2fe 100%);
            --card-shadow: 0 10px 28px rgba(15,23,42,0.10);
            --accent-green: #059669;
            --accent-amber: #b45309;
            --accent-red: #e11d48;
            --accent-blue: #0284c7;
            --accent-purple: #7c3aed;
        }

        body { font-family: 'Inter', system-ui, -apple-system, sans-serif; background: linear-gradient(135deg, #030712 0%, #0a0f1d 100%); color: var(--text-main); margin: 0; padding: 0; min-height: 100vh; overflow-x: hidden; }
        .container { max-width: 1350px; margin: 30px auto; padding: 0 20px; }

        /* HERO */
        .hero-banner { position: relative; background: var(--hero-bg); border: 1px solid var(--border-color); border-radius: 28px; padding: 50px 55px; margin-bottom: 30px; box-shadow: var(--card-shadow); overflow: hidden; text-align: center; }
        .hero-banner::before { content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%; background: radial-gradient(circle, rgba(56,189,248,0.16) 0%, rgba(16,185,129,0.10) 35%, transparent 70%); animation: rotateGlow 12s linear infinite; z-index: 1; pointer-events: none; }
        .hero-banner::after { content: ''; position: absolute; bottom: -60%; right: -40%; width: 180%; height: 180%; background: radial-gradient(circle, rgba(244,63,94,0.12) 0%, rgba(245,158,11,0.08) 40%, transparent 70%); animation: rotateGlowReverse 18s linear infinite; z-index: 1; pointer-events: none; }
        @keyframes rotateGlow { to { transform: rotate(360deg); } }
        @keyframes rotateGlowReverse { to { transform: rotate(-360deg); } }
        @keyframes pulseDot { 0%,100% { opacity: 1; } 50% { opacity: 0.3; } }
        @media (prefers-reduced-motion: reduce) { .hero-banner::before, .hero-banner::after, .live-dot { animation: none !important; } }
        .hero-content { position: relative; z-index: 2; max-width: 720px; margin: 0 auto; }
        .season-tag { color: var(--accent-green); font-size: 11.5px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px; display: inline-flex; align-items: center; gap: 7px; }
        .live-dot { width: 7px; height: 7px; border-radius: 50%; background: var(--accent-red); box-shadow: 0 0 8px var(--accent-red); animation: pulseDot 1.3s ease-in-out infinite; }
        .hero-content h1 { font-size: 36px; margin: 6px 0 12px 0; font-weight: 900; color: var(--text-main); }
        .hero-content h1 span { color: var(--accent-blue); }
        .hero-content p { color: var(--text-muted); font-size: 14px; margin: 0 0 22px 0; line-height: 1.6; }
        .hero-search-stats { position: relative; z-index: 2; display: flex; justify-content: center; gap: 14px; flex-wrap: wrap; }
        .hero-search-pill { background: var(--surface-2); border: 1px solid var(--border-color); border-radius: 14px; padding: 10px 20px; display: flex; align-items: center; gap: 10px; }
        .hero-search-pill i { color: var(--accent-blue); font-size: 15px; }
        .hero-search-pill .num { font-size: 17px; font-weight: 900; color: var(--text-main); }
        .hero-search-pill .lbl { font-size: 10.5px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; }

        .section-title { font-size: 19px; font-weight: 800; margin: 40px 0 20px 0; display: flex; justify-content: space-between; align-items: center; gap: 10px; flex-wrap: wrap; border-left: 4px solid var(--accent-blue); padding-left: 12px; text-transform: uppercase; letter-spacing: 0.5px; color: var(--text-main); }
        .section-title small { font-size: 12px; color: var(--accent-blue); text-transform: none; letter-spacing: 0; font-weight: 700; }

        /* RESULTS */
        .matrix-grid { display: grid; grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 25px; margin-bottom: 45px; }
        .matrix-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 26px; box-shadow: var(--card-shadow); position: relative; overflow: hidden; transition: border-color .3s, box-shadow .3s; scroll-margin-top: 90px; min-width: 0; }
        .matrix-card:hover { border-color: var(--accent-blue); }
        .matrix-card::before { content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px; }
        .card-teams::before { background: linear-gradient(90deg, var(--accent-green), #059669); }
        .card-tournaments::before { background: linear-gradient(90deg, var(--accent-amber), #d97706); }
        .card-matches::before { background: linear-gradient(90deg, var(--accent-red), #e11d48); }
        .card-players::before { background: linear-gradient(90deg, var(--accent-purple), #9333ea); }
        .matrix-header { display: flex; justify-content: space-between; align-items: center; gap: 10px; margin-bottom: 18px; padding-bottom: 12px; border-bottom: 1px solid var(--border-color); }
        .matrix-header h3 { margin: 0; font-size: 15.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.8px; display: flex; align-items: center; gap: 10px; color: var(--text-main); }
        .count-badge { background: var(--surface-2); border: 1px solid var(--border-color); padding: 4px 10px; border-radius: 8px; font-size: 12px; font-weight: 800; color: var(--accent-blue); white-space: nowrap; }
        .items-list { display: flex; flex-direction: column; gap: 12px; max-height: 340px; overflow-y: auto; padding-right: 5px; }
        .items-list::-webkit-scrollbar { width: 5px; }
        .items-list::-webkit-scrollbar-thumb { background: var(--border-color); border-radius: 10px; }
        .item-row { background: var(--surface-2); border: 1px solid var(--border-color); border-radius: 14px; padding: 12px 16px; display: flex; justify-content: space-between; align-items: center; gap: 10px; flex-wrap: wrap; transition: border-color .2s, background .2s; }
        .item-row:hover { border-color: var(--accent-blue); }
        .item-info { min-width: 0; flex: 1 1 160px; }
        .item-main-text { font-weight: 700; font-size: 14px; color: var(--text-main); display: flex; align-items: center; gap: 10px; word-break: break-word; }
        .item-sub-text { font-size: 12px; color: var(--text-muted); font-weight: 600; margin-top: 2px; }
        .item-actions { display: flex; align-items: center; gap: 8px; flex-shrink: 0; }
        .tag-pill { background: rgba(56,189,248,0.12); color: var(--accent-blue); border: 1px solid rgba(56,189,248,0.3); padding: 4px 10px; border-radius: 6px; font-size: 11px; font-weight: 800; text-transform: uppercase; white-space: nowrap; }
        .manage-btn { display: inline-flex; align-items: center; justify-content: center; width: 34px; height: 34px; border-radius: 10px; background: rgba(56,189,248,0.12); border: 1px solid rgba(56,189,248,0.3); color: var(--accent-blue); text-decoration: none; font-size: 13px; transition: transform .2s, background .2s; }
        .manage-btn:hover { background: var(--accent-blue); color: #030712; transform: translateY(-2px); }
        .no-record-box { text-align: center; color: var(--text-muted); padding: 30px; font-size: 13.5px; font-style: italic; }

        /* 1 Breakdown */
        .breakdown-box { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 28px; margin-bottom: 45px; box-shadow: var(--card-shadow); }
        .breakdown-row { display: flex; align-items: center; gap: 16px; margin-bottom: 16px; }
        .breakdown-row:last-child { margin-bottom: 0; }
        .breakdown-label { width: 130px; font-size: 13px; font-weight: 700; color: var(--text-main); display: flex; align-items: center; gap: 8px; flex-shrink: 0; }
        .breakdown-track { flex: 1; height: 10px; background: var(--surface-2); border-radius: 8px; overflow: hidden; border: 1px solid var(--border-color); }
        .breakdown-fill { height: 100%; border-radius: 8px; }
        .breakdown-pct { width: 42px; text-align: right; font-size: 12.5px; font-weight: 800; color: var(--text-muted); flex-shrink: 0; }

        /* 2 Jump chips */
        .refine-grid { display: flex; flex-wrap: wrap; gap: 14px; margin-bottom: 45px; }
        .refine-chip { background: var(--bg-card); border: 1.5px solid var(--border-color); color: var(--text-main); padding: 12px 22px; border-radius: 14px; font-size: 13.5px; font-weight: 700; display: inline-flex; align-items: center; gap: 10px; text-decoration: none; transition: transform .25s, border-color .25s; }
        .refine-chip i { color: var(--accent-blue); font-size: 15px; }
        .refine-chip:hover { border-color: var(--accent-blue); transform: translateY(-3px); color: var(--accent-blue); }

        /* 3 Review queue */
        .recent-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 22px; margin-bottom: 45px; }
        .recent-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 24px 22px 20px; box-shadow: var(--card-shadow); transition: transform .3s, border-color .3s; position: relative; min-width: 0; }
        .recent-card:hover { transform: translateY(-5px); border-color: var(--accent-green); }
        .recent-badge { position: absolute; top: -10px; right: 16px; background: var(--accent-green); color: #fff; font-size: 10px; font-weight: 900; padding: 4px 10px; border-radius: 8px; text-transform: uppercase; }
        .recent-card h5 { margin: 6px 0 4px 0; font-size: 15px; font-weight: 800; color: var(--text-main); word-break: break-word; }
        .recent-card p { margin: 0 0 14px 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.55; }
        .mini-link { font-size: 12px; font-weight: 800; color: var(--accent-blue); text-decoration: none; }
        .mini-link:hover { text-decoration: underline; }

        /* 4 Spotlight */
        .spotlight-box { position: relative; overflow: hidden; background: linear-gradient(135deg, rgba(245,158,11,0.14), var(--bg-card)); border: 1.5px solid rgba(245,158,11,0.4); border-radius: 24px; padding: 36px; margin-bottom: 45px; display: flex; justify-content: space-between; align-items: center; gap: 28px; flex-wrap: wrap; box-shadow: var(--card-shadow); }
        .spotlight-icon { width: 76px; height: 76px; border-radius: 22px; background: rgba(245,158,11,0.18); border: 1px solid rgba(245,158,11,0.4); display: flex; align-items: center; justify-content: center; font-size: 30px; color: var(--accent-amber); flex-shrink: 0; }
        .spotlight-text { flex: 1; min-width: 240px; }
        .spotlight-tag { font-size: 11px; font-weight: 800; color: var(--accent-amber); text-transform: uppercase; letter-spacing: 1px; margin-bottom: 6px; display: block; }
        .spotlight-text h3 { margin: 0 0 6px 0; font-size: 22px; font-weight: 900; color: var(--text-main); word-break: break-word; }
        .spotlight-text p { margin: 0; font-size: 13.5px; color: var(--text-muted); line-height: 1.6; }
        .spotlight-btn { background: var(--accent-amber); color: #fff; border: none; padding: 13px 26px; border-radius: 12px; font-weight: 800; font-size: 13px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; white-space: nowrap; transition: transform .25s; }
        .spotlight-btn:hover { transform: translateY(-3px); color: #fff; }

        /* 5 Quick actions + 7 status guide + 8 metrics + 9 manage tiles share a card look */
        .tips-grid, .trust-grid { display: grid; grid-template-columns: repeat(3, minmax(0, 1fr)); gap: 22px; margin-bottom: 45px; }
        .tip-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 22px; display: flex; gap: 16px; align-items: flex-start; box-shadow: var(--card-shadow); text-decoration: none; transition: transform .3s, border-color .3s; min-width: 0; }
        .tip-card:hover { border-color: var(--accent-blue); transform: translateY(-4px); }
        .tip-ico { width: 40px; height: 40px; border-radius: 12px; background: rgba(56,189,248,0.15); border: 1px solid rgba(56,189,248,0.35); color: var(--accent-blue); font-size: 16px; display: flex; align-items: center; justify-content: center; flex-shrink: 0; }
        .tip-card h5 { margin: 0 0 4px 0; font-size: 14px; font-weight: 800; color: var(--text-main); }
        .tip-card p { margin: 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.55; }

        /* 6 Activity */
        .activity-box { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 28px; margin-bottom: 45px; box-shadow: var(--card-shadow); }
        .activity-row { display: flex; align-items: center; gap: 16px; padding: 14px 0; border-bottom: 1px solid var(--border-color); }
        .activity-row:last-child { border-bottom: none; padding-bottom: 0; }
        .activity-row:first-child { padding-top: 0; }
        .activity-icon { width: 42px; height: 42px; border-radius: 12px; display: flex; align-items: center; justify-content: center; font-size: 15px; flex-shrink: 0; }
        .activity-text { flex: 1; min-width: 0; font-size: 13.5px; color: var(--text-main); font-weight: 600; }
        .activity-text span { color: var(--text-muted); font-weight: 500; }
        .activity-time { font-size: 11.5px; color: var(--text-muted); flex-shrink: 0; white-space: nowrap; }

        /* 7 Status guide */
        .trust-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 24px; text-align: center; box-shadow: var(--card-shadow); transition: transform .3s, border-color .3s; }
        .trust-card:hover { transform: translateY(-5px); border-color: var(--accent-green); }
        .trust-pill { display: inline-flex; align-items: center; gap: 6px; padding: 5px 14px; border-radius: 20px; font-size: 11px; font-weight: 800; text-transform: uppercase; margin-bottom: 14px; }
        .trust-card p { margin: 0; font-size: 12.5px; color: var(--text-muted); line-height: 1.6; }

        /* 8 Metrics */
        .metrics-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 20px; margin-bottom: 45px; }
        .metric-card { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px; padding: 22px; text-align: center; box-shadow: var(--card-shadow); transition: transform .3s, border-color .3s; }
        .metric-card:hover { transform: translateY(-5px); border-color: var(--accent-blue); }
        .metric-val { font-size: 24px; font-weight: 900; color: var(--accent-blue); margin: 6px 0 4px 0; }
        .metric-label { font-size: 11px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.5px; font-weight: 700; }

        /* 9 Manage tiles */
        .explore-grid { display: grid; grid-template-columns: repeat(4, minmax(0, 1fr)); gap: 20px; margin-bottom: 45px; }
        .explore-tile { background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 20px; padding: 30px 20px; text-align: center; text-decoration: none; transition: transform .3s, border-color .3s; box-shadow: var(--card-shadow); }
        .explore-tile:hover { transform: translateY(-8px); border-color: var(--accent-blue); }
        .explore-tile i { font-size: 30px; margin-bottom: 14px; display: block; }
        .explore-tile h5 { margin: 0 0 4px 0; font-size: 15px; font-weight: 800; color: var(--text-main); }
        .explore-tile span { font-size: 11.5px; color: var(--text-muted); }

        /* 10 CTA (text stays white on its own dark-blue gradient in both themes) */
        .help-cta { position: relative; overflow: hidden; background: linear-gradient(135deg, #0284c7 0%, #0f172a 60%, #030712 100%); border-radius: 26px; padding: 46px; margin-bottom: 20px; display: flex; align-items: center; justify-content: space-between; gap: 30px; flex-wrap: wrap; box-shadow: 0 25px 50px rgba(0,0,0,0.35); }
        .help-cta-text { position: relative; z-index: 2; max-width: 560px; }
        .help-cta-text h2 { font-size: 26px; font-weight: 900; color: #fff; margin: 0 0 10px 0; }
        .help-cta-text p { font-size: 14px; color: rgba(255,255,255,0.85); margin: 0; line-height: 1.6; }
        .btn-help-white { position: relative; z-index: 2; background: #fff; color: #030712; border: none; padding: 14px 30px; border-radius: 14px; font-weight: 800; font-size: 13.5px; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; text-transform: uppercase; white-space: nowrap; transition: transform .3s; }
        .btn-help-white:hover { transform: translateY(-3px); color: #030712; }

        /* RESPONSIVE */
        @media (max-width: 1100px) { .explore-grid, .metrics-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); } }
        @media (max-width: 950px) {
            .matrix-grid, .recent-grid, .tips-grid, .trust-grid { grid-template-columns: 1fr; }
            .help-cta, .spotlight-box { flex-direction: column; text-align: center; padding: 34px 24px; }
        }
        @media (max-width: 640px) {
            .container { padding: 0 14px; margin: 18px auto; }
            .hero-banner { padding: 34px 20px; border-radius: 22px; }
            .hero-content h1 { font-size: 26px; }
            .hero-search-pill { padding: 8px 14px; flex: 1 1 130px; justify-content: center; }
            .section-title { font-size: 16px; margin: 30px 0 16px 0; }
            .matrix-card, .breakdown-box, .activity-box { padding: 18px; border-radius: 16px; }
            .breakdown-label { width: 96px; font-size: 12px; }
            .activity-row { flex-wrap: wrap; gap: 10px 12px; }
            .activity-time { width: 100%; padding-left: 54px; }
            .explore-tile { padding: 22px 12px; }
            .help-cta-text h2 { font-size: 21px; }
            .btn-help-white, .spotlight-btn { width: 100%; justify-content: center; }
        }
        @media (max-width: 420px) {
            .metrics-grid, .explore-grid { gap: 12px; }
            .metric-card { padding: 16px 10px; }
            .refine-chip { flex: 1 1 100%; }
        }

        /* FOOTER (same as user page) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13,18,35,0.98), rgba(4,7,18,0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; box-shadow: 0 -20px 50px rgba(0,0,0,0.6); }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } .grand-footer-section { padding: 40px 20px 24px; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        @media(max-width: 650px) { .footer-socials { justify-content: center; } }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(0,217,255,0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: .3s; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #030712; transform: translateY(-3px); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: .2s; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; min-width: 0; background: rgba(3,7,18,0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; }
        @media(max-width: 768px) { .footer-bottom-bar { flex-direction: column; text-align: center; } }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }
        html[data-theme="light"] .footer-newsletter input { background: #fff; color: #0f172a; }
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="container">

        <!-- HERO -->
        <div class="hero-banner">
            <div class="hero-content">
                <span class="season-tag"><span class="live-dot"></span> Admin Search Console</span>
                <h1>Admin <span>Search Results</span></h1>
                <p>Results for "<strong><c:out value="${keyword}"/></strong>" across teams, tournaments, matches and players. Open any record to manage it.</p>
                <div class="hero-search-stats">
                    <div class="hero-search-pill"><i class="fa-solid fa-shield-cat"></i><span class="num">${tCount}</span><span class="lbl">Teams</span></div>
                    <div class="hero-search-pill"><i class="fa-solid fa-trophy"></i><span class="num">${trCount}</span><span class="lbl">Tournaments</span></div>
                    <div class="hero-search-pill"><i class="fa-solid fa-futbol"></i><span class="num">${mCount}</span><span class="lbl">Matches</span></div>
                    <div class="hero-search-pill"><i class="fa-solid fa-users"></i><span class="num">${pCount}</span><span class="lbl">Players</span></div>
                </div>
            </div>
        </div>

        <!-- RESULTS -->
        <div class="matrix-grid">
            <div class="matrix-card card-teams" id="sec-teams">
                <div class="matrix-header"><h3><i class="fa-solid fa-shield-cat" style="color: var(--accent-green);"></i> Teams</h3><span class="count-badge">${tCount} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${teams}" var="team">
                        <div class="item-row">
                            <div class="item-info"><span class="item-main-text"><i class="fa-solid fa-flag" style="color: var(--accent-green); font-size: 12px;"></i> <c:out value="${team.teamName}"/></span></div>
                            <div class="item-actions"><span class="tag-pill" style="background: rgba(16,185,129,0.12); color: var(--accent-green); border-color: rgba(16,185,129,0.35);">Verified</span><a href="/admin/teams" class="manage-btn" title="Manage teams" aria-label="Manage teams"><i class="fa-solid fa-pen-to-square"></i></a></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty teams}"><div class="no-record-box">No matching teams registered.</div></c:if>
                </div>
            </div>
            <div class="matrix-card card-tournaments" id="sec-tournaments">
                <div class="matrix-header"><h3><i class="fa-solid fa-trophy" style="color: var(--accent-amber);"></i> Tournaments</h3><span class="count-badge">${trCount} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${tournaments}" var="t">
                        <div class="item-row">
                            <div class="item-info"><span class="item-main-text"><i class="fa-solid fa-award" style="color: var(--accent-amber); font-size: 12px;"></i> <c:out value="${t.tournamentName}"/></span></div>
                            <div class="item-actions"><span class="tag-pill" style="background: rgba(245,158,11,0.12); color: var(--accent-amber); border-color: rgba(245,158,11,0.35);">Active</span><a href="/admin/tournaments" class="manage-btn" title="Manage tournaments" aria-label="Manage tournaments"><i class="fa-solid fa-pen-to-square"></i></a></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty tournaments}"><div class="no-record-box">No matching tournaments found.</div></c:if>
                </div>
            </div>
            <div class="matrix-card card-matches" id="sec-matches">
                <div class="matrix-header"><h3><i class="fa-solid fa-futbol" style="color: var(--accent-red);"></i> Matches</h3><span class="count-badge">${mCount} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${matches}" var="m">
                        <div class="item-row">
                            <div class="item-info"><span class="item-main-text"><i class="fa-solid fa-location-dot" style="color: var(--accent-red); font-size: 12px;"></i> Venue: <c:out value="${m.venue}"/></span></div>
                            <div class="item-actions"><span class="tag-pill" style="background: rgba(244,63,94,0.12); color: var(--accent-red); border-color: rgba(244,63,94,0.35);">Scheduled</span><a href="/admin/matches" class="manage-btn" title="Manage matches" aria-label="Manage matches"><i class="fa-solid fa-pen-to-square"></i></a></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty matches}"><div class="no-record-box">No matching match fixtures found.</div></c:if>
                </div>
            </div>
            <div class="matrix-card card-players" id="sec-players">
                <div class="matrix-header"><h3><i class="fa-solid fa-users" style="color: var(--accent-purple);"></i> Players</h3><span class="count-badge">${pCount} Found</span></div>
                <div class="items-list">
                    <c:forEach items="${players}" var="p">
                        <div class="item-row">
                            <div class="item-info">
                                <div class="item-main-text"><i class="fa-solid fa-user-ninja" style="color: var(--accent-purple); font-size: 12px;"></i> <c:out value="${p.playerName}"/></div>
                                <div class="item-sub-text">Team: <span style="color: var(--text-main);"><c:out value="${p.team != null ? p.team.teamName : 'N/A'}"/></span></div>
                            </div>
                            <div class="item-actions"><span class="tag-pill" style="background: rgba(192,132,252,0.12); color: var(--accent-purple); border-color: rgba(192,132,252,0.35);"><c:out value="${p.role}"/></span><a href="/admin/teams" class="manage-btn" title="Manage teams and players" aria-label="Manage teams and players"><i class="fa-solid fa-pen-to-square"></i></a></div>
                        </div>
                    </c:forEach>
                    <c:if test="${empty players}"><div class="no-record-box">No matching player profiles found.</div></c:if>
                </div>
            </div>
        </div>

        <!-- 1. RESULT BREAKDOWN -->
        <div class="section-title"><span>Result Breakdown</span><small>Share of ${total} results</small></div>
        <div class="breakdown-box">
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-shield-cat" style="color: var(--accent-green);"></i> Teams</div><div class="breakdown-track"><div class="breakdown-fill" style="width: ${total > 0 ? tCount * 100 / total : 0}%; background: var(--accent-green);"></div></div><div class="breakdown-pct">${tCount}</div></div>
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-trophy" style="color: var(--accent-amber);"></i> Tournaments</div><div class="breakdown-track"><div class="breakdown-fill" style="width: ${total > 0 ? trCount * 100 / total : 0}%; background: var(--accent-amber);"></div></div><div class="breakdown-pct">${trCount}</div></div>
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-futbol" style="color: var(--accent-red);"></i> Matches</div><div class="breakdown-track"><div class="breakdown-fill" style="width: ${total > 0 ? mCount * 100 / total : 0}%; background: var(--accent-red);"></div></div><div class="breakdown-pct">${mCount}</div></div>
            <div class="breakdown-row"><div class="breakdown-label"><i class="fa-solid fa-users" style="color: var(--accent-purple);"></i> Players</div><div class="breakdown-track"><div class="breakdown-fill" style="width: ${total > 0 ? pCount * 100 / total : 0}%; background: var(--accent-purple);"></div></div><div class="breakdown-pct">${pCount}</div></div>
        </div>

        <!-- 2. JUMP TO -->
        <div class="section-title"><span>Jump To Section</span><small>Quick filter</small></div>
        <div class="refine-grid">
            <a href="#sec-teams" class="refine-chip"><i class="fa-solid fa-shield-cat"></i> Teams Only</a>
            <a href="#sec-tournaments" class="refine-chip"><i class="fa-solid fa-trophy"></i> Tournaments Only</a>
            <a href="#sec-matches" class="refine-chip"><i class="fa-solid fa-futbol"></i> Matches Only</a>
            <a href="#sec-players" class="refine-chip"><i class="fa-solid fa-users"></i> Players Only</a>
        </div>

        <!-- 3. REVIEW QUEUE -->
        <div class="section-title"><span>Needs Your Review</span><small>Top match from each group</small></div>
        <div class="recent-grid">
            <c:forEach items="${teams}" var="rt" end="0">
                <div class="recent-card"><span class="recent-badge">Team</span><h5><i class="fa-solid fa-shield-cat" style="color: var(--accent-green); font-size: 12px;"></i> <c:out value="${rt.teamName}"/></h5><p>Check the roster and verification status for this team.</p><a href="/admin/teams" class="mini-link">Open teams</a></div>
            </c:forEach>
            <c:forEach items="${tournaments}" var="rtn" end="0">
                <div class="recent-card"><span class="recent-badge">Tournament</span><h5><i class="fa-solid fa-trophy" style="color: var(--accent-amber); font-size: 12px;"></i> <c:out value="${rtn.tournamentName}"/></h5><p>Confirm schedule, registered teams and points table setup.</p><a href="/admin/tournaments" class="mini-link">Open tournaments</a></div>
            </c:forEach>
            <c:forEach items="${players}" var="rp" end="0">
                <div class="recent-card"><span class="recent-badge">Player</span><h5><i class="fa-solid fa-user-ninja" style="color: var(--accent-purple); font-size: 12px;"></i> <c:out value="${rp.playerName}"/></h5><p>Verify team assignment and playing role.</p><a href="/admin/teams" class="mini-link">Open teams</a></div>
            </c:forEach>
            <c:if test="${empty teams && empty tournaments && empty players}">
                <div class="recent-card"><p style="margin:0;">Nothing to review for this search.</p></div>
            </c:if>
        </div>

        <!-- 4. SPOTLIGHT -->
        <c:forEach items="${tournaments}" var="spot" end="0">
            <div class="spotlight-box">
                <div class="spotlight-icon"><i class="fa-solid fa-trophy"></i></div>
                <div class="spotlight-text"><span class="spotlight-tag">Tournament Control</span><h3><c:out value="${spot.tournamentName}"/></h3><p>Top matching tournament. Update fixtures, manage teams and check the points table.</p></div>
                <a href="/admin/tournaments" class="spotlight-btn"><i class="fa-solid fa-sliders"></i> Manage Tournament</a>
            </div>
        </c:forEach>

        <!-- 5. QUICK ACTIONS -->
        <div class="section-title"><span>Quick Actions</span><small>Admin shortcuts</small></div>
        <div class="tips-grid">
            <a href="/admin/teams" class="tip-card"><div class="tip-ico"><i class="fa-solid fa-user-plus"></i></div><div><h5>Add Team</h5><p>Register a new team and build its roster.</p></div></a>
            <a href="/admin/tournaments" class="tip-card"><div class="tip-ico"><i class="fa-solid fa-trophy"></i></div><div><h5>Create Tournament</h5><p>Open a new tournament for registrations.</p></div></a>
            <a href="/admin/matches" class="tip-card"><div class="tip-ico"><i class="fa-solid fa-calendar-plus"></i></div><div><h5>Schedule Match</h5><p>Set the date, time and venue for a fixture.</p></div></a>
        </div>

        <!-- 6. ACTIVITY (sample entries, replace with real data when available) -->
        <div class="section-title"><span>Admin Activity</span><small>Recent changes</small></div>
        <div class="activity-box">
            <div class="activity-row"><div class="activity-icon" style="background: rgba(16,185,129,0.15); color: var(--accent-green);"><i class="fa-solid fa-shield-cat"></i></div><div class="activity-text">A new team was <span>registered and awaits verification</span></div><div class="activity-time">Just now</div></div>
            <div class="activity-row"><div class="activity-icon" style="background: rgba(245,158,11,0.15); color: var(--accent-amber);"><i class="fa-solid fa-trophy"></i></div><div class="activity-text">Tournament schedule <span>was updated</span></div><div class="activity-time">12 min ago</div></div>
            <div class="activity-row"><div class="activity-icon" style="background: rgba(192,132,252,0.15); color: var(--accent-purple);"><i class="fa-solid fa-user-plus"></i></div><div class="activity-text">A player profile <span>was added to a team</span></div><div class="activity-time">40 min ago</div></div>
            <div class="activity-row"><div class="activity-icon" style="background: rgba(244,63,94,0.15); color: var(--accent-red);"><i class="fa-solid fa-futbol"></i></div><div class="activity-text">Match venue <span>was confirmed</span></div><div class="activity-time">1 hr ago</div></div>
        </div>

        <!-- 7. STATUS GUIDE -->
        <div class="section-title"><span>Status Guide</span><small>What each badge means</small></div>
        <div class="trust-grid">
            <div class="trust-card"><span class="trust-pill" style="background: rgba(16,185,129,0.15); color: var(--accent-green); border: 1px solid rgba(16,185,129,0.4);"><i class="fa-solid fa-circle-check"></i> Verified</span><p>Team details are reviewed and approved by an admin.</p></div>
            <div class="trust-card"><span class="trust-pill" style="background: rgba(245,158,11,0.15); color: var(--accent-amber); border: 1px solid rgba(245,158,11,0.4);"><i class="fa-solid fa-bolt"></i> Active</span><p>Tournament is open for registrations or in progress.</p></div>
            <div class="trust-card"><span class="trust-pill" style="background: rgba(244,63,94,0.15); color: var(--accent-red); border: 1px solid rgba(244,63,94,0.4);"><i class="fa-solid fa-calendar-check"></i> Scheduled</span><p>Match date, time and venue are confirmed.</p></div>
        </div>

        <!-- 8. METRICS -->
        <div class="section-title"><span>Search Summary</span><small>This query</small></div>
        <div class="metrics-grid">
            <div class="metric-card"><i class="fa-solid fa-list-check" style="color: var(--accent-blue); font-size: 20px;"></i><div class="metric-val">${total}</div><div class="metric-label">Total Results</div></div>
            <div class="metric-card"><i class="fa-solid fa-database" style="color: var(--accent-green); font-size: 20px;"></i><div class="metric-val">4</div><div class="metric-label">Entities Searched</div></div>
            <div class="metric-card"><i class="fa-solid fa-layer-group" style="color: var(--accent-amber); font-size: 20px;"></i><div class="metric-val">${(tCount > 0 ? 1 : 0) + (trCount > 0 ? 1 : 0) + (mCount > 0 ? 1 : 0) + (pCount > 0 ? 1 : 0)}</div><div class="metric-label">Groups With Matches</div></div>
            <div class="metric-card"><i class="fa-solid fa-user-shield" style="color: var(--accent-purple); font-size: 20px;"></i><div class="metric-val">Admin</div><div class="metric-label">Access Level</div></div>
        </div>

        <!-- 9. MANAGE BY CATEGORY -->
        <div class="section-title"><span>Manage By Category</span><small>Open full lists</small></div>
        <div class="explore-grid">
            <a href="/admin/teams" class="explore-tile"><i class="fa-solid fa-shield-cat" style="color: var(--accent-green);"></i><h5>Teams</h5><span>Manage team directory</span></a>
            <a href="/admin/tournaments" class="explore-tile"><i class="fa-solid fa-trophy" style="color: var(--accent-amber);"></i><h5>Tournaments</h5><span>Control every league</span></a>
            <a href="/admin/matches" class="explore-tile"><i class="fa-solid fa-futbol" style="color: var(--accent-red);"></i><h5>Matches</h5><span>Edit fixture schedule</span></a>
            <a href="/admin/users" class="explore-tile"><i class="fa-solid fa-user-gear" style="color: var(--accent-purple);"></i><h5>Users</h5><span>Manage accounts and roles</span></a>
        </div>

        <!-- 10. CTA -->
        <div class="help-cta">
            <div class="help-cta-text"><h2>Can't find the record you need?</h2><p>If a team, tournament or match is missing, add it from the admin panel and search again.</p></div>
            <a href="/admin/home" class="btn-help-white"><i class="fa-solid fa-gauge-high"></i> Go To Admin Home</a>
        </div>

    </div>

    <jsp:include page="footer.jsp" />
    <jsp:include page="chatbot.jsp" />

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
