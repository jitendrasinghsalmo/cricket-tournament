<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rules & Regulations | ProMatch Arena</title>
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

        /* HERO */
        .rules-hero {
            position: relative; overflow: hidden;
            background: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            border-radius: 28px; padding: 55px; margin-bottom: 30px;
            box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
            display: flex; justify-content: space-between; align-items: center; gap: 30px; flex-wrap: wrap;
        }
        .rules-hero::before {
            content: ''; position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
            background: radial-gradient(circle, rgba(56, 189, 248, 0.16) 0%, rgba(16, 185, 129, 0.10) 35%, transparent 70%);
            animation: rotateGlow 12s linear infinite; z-index: 1;
        }
        @keyframes rotateGlow { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }
        .rules-hero-content { position: relative; z-index: 2; max-width: 680px; }
        .season-tag { color: var(--accent-green); font-size: 11.5px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; margin-bottom: 8px; display: block; text-shadow: 0 0 10px rgba(16,185,129,0.4); }
        .rules-hero h1 { font-size: 38px; margin: 0 0 12px 0; font-weight: 900; color: #fff; text-shadow: 0 0 20px rgba(56,189,248,0.3); }
        .rules-hero h1 span { color: var(--accent-blue); }
        .rules-hero p { color: var(--text-muted); font-size: 14.5px; margin: 0 0 22px 0; line-height: 1.7; }
        .hero-search {
            display: flex; align-items: center; gap: 10px; background: rgba(3,7,18,0.7);
            border: 1.5px solid var(--border-color); border-radius: 14px; padding: 10px 16px; max-width: 460px;
        }
        .hero-search i { color: var(--accent-blue); }
        .hero-search input { flex: 1; background: transparent; border: none; outline: none; color: var(--text-main); font-size: 13.5px; }
        .hero-search input::placeholder { color: var(--text-muted); }

        /* HERO FEE BADGE */
        .hero-fee {
            position: relative; z-index: 2; min-width: 240px; text-align: center;
            background: rgba(3, 7, 18, 0.65); backdrop-filter: blur(8px);
            border: 1.5px solid rgba(16, 185, 129, 0.5); border-radius: 22px; padding: 26px 30px;
            box-shadow: 0 15px 35px rgba(16, 185, 129, 0.25);
        }
        .hero-fee .fee-label { font-size: 11px; font-weight: 800; letter-spacing: 1.5px; text-transform: uppercase; color: var(--accent-green); display: block; margin-bottom: 6px; }
        .hero-fee .fee-amount { font-size: 46px; font-weight: 900; color: #fff; line-height: 1; text-shadow: 0 0 20px rgba(56,189,248,0.4); }
        .hero-fee .fee-amount small { font-size: 22px; color: var(--accent-blue); margin-right: 2px; }
        .hero-fee .fee-note { font-size: 12px; color: var(--text-muted); margin-top: 8px; display: block; }

        /* QUICK FACTS */
        .quick-facts { display: grid; grid-template-columns: repeat(5, 1fr); gap: 20px; margin-bottom: 35px; }
        .fact-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px;
            padding: 20px; text-align: center; box-shadow: 0 10px 30px rgba(0,0,0,0.3); transition: all 0.3s ease;
        }
        .fact-card:hover { transform: translateY(-5px); border-color: var(--accent-blue); box-shadow: 0 15px 40px rgba(56,189,248,0.25); }
        .fact-card i { font-size: 22px; color: var(--accent-blue); margin-bottom: 10px; display: block; }
        .fact-card .num { font-size: 24px; font-weight: 900; color: var(--accent-green); display: block; }
        .fact-card .lbl { font-size: 11px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; font-weight: 700; }

        /* LAYOUT */
        .rules-layout { display: grid; grid-template-columns: 280px 1fr; gap: 30px; align-items: start; margin-bottom: 45px; }
        .rules-sidebar {
            position: sticky; top: 90px; background: var(--bg-card); border: 1.5px solid var(--border-color);
            border-radius: 18px; padding: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
            max-height: calc(100vh - 110px); overflow-y: auto;
        }
        .rules-sidebar h4 { font-size: 13px; font-weight: 800; text-transform: uppercase; letter-spacing: 1px; color: var(--accent-blue); margin: 0 0 14px 0; }
        .rules-sidebar a {
            display: flex; align-items: center; gap: 10px; padding: 9px 12px; border-radius: 10px;
            color: var(--text-muted); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s;
        }
        .rules-sidebar a i { width: 18px; text-align: center; color: var(--accent-blue); }
        .rules-sidebar a:hover, .rules-sidebar a.active { background: rgba(56,189,248,0.12); color: var(--accent-blue); }

        .rule-section { margin-bottom: 30px; scroll-margin-top: 90px; }
        .rule-section-title {
            font-size: 19px; font-weight: 800; margin: 0 0 16px 0; display: flex; align-items: center; gap: 12px;
            border-left: 4px solid var(--accent-blue); padding-left: 12px; text-transform: uppercase; letter-spacing: 0.5px;
        }
        .rule-section-title i { color: var(--accent-blue); font-size: 17px; }

        .rule-card {
            background: var(--bg-card); border: 1.5px solid var(--border-color); border-radius: 18px;
            padding: 6px 24px; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        }
        .rule-item { display: flex; gap: 16px; padding: 18px 0; border-bottom: 1px solid var(--border-color); }
        .rule-item:last-child { border-bottom: none; }
        .rule-num {
            width: 34px; height: 34px; border-radius: 10px; flex-shrink: 0;
            background: rgba(56,189,248,0.15); border: 1px solid rgba(56,189,248,0.3);
            color: var(--accent-blue); font-weight: 900; font-size: 13px;
            display: flex; align-items: center; justify-content: center;
        }
        .rule-item h5 { margin: 0 0 4px 0; font-size: 14.5px; font-weight: 800; color: var(--text-main); }
        .rule-item p { margin: 0; font-size: 13.2px; color: var(--text-muted); line-height: 1.7; }
        .rule-item.hidden-by-search { display: none; }

        /* POINTS */
        .points-box { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; padding: 20px 0; }
        .point-pill { background: rgba(3,7,18,0.7); border: 1.5px solid var(--border-color); border-radius: 14px; padding: 18px; text-align: center; }
        .point-pill .pts { font-size: 28px; font-weight: 900; display: block; }
        .point-pill.win .pts { color: var(--accent-green); }
        .point-pill.tie .pts { color: var(--accent-amber); }
        .point-pill.loss .pts { color: var(--accent-red); }
        .point-pill .lbl { font-size: 11.5px; color: var(--text-muted); text-transform: uppercase; letter-spacing: 1px; font-weight: 700; }

        .formula-box {
            margin: 6px 0 18px 0; padding: 14px 18px; border-radius: 12px;
            background: rgba(16,185,129,0.08); border: 1px dashed rgba(16,185,129,0.5);
            font-size: 13px; color: #d1fae5; line-height: 1.7; font-weight: 600;
        }

        /* FEE HIGHLIGHT */
        .fee-highlight {
            display: flex; align-items: center; justify-content: space-between; gap: 20px; flex-wrap: wrap;
            margin: 20px 0 6px 0; padding: 22px 26px; border-radius: 16px;
            background: linear-gradient(135deg, rgba(16,185,129,0.14), rgba(56,189,248,0.10));
            border: 1.5px solid rgba(16,185,129,0.45);
        }
        .fee-highlight .fh-left h5 { margin: 0 0 4px 0; font-size: 16px; font-weight: 800; color: var(--text-main); }
        .fee-highlight .fh-left p { margin: 0; font-size: 13px; color: var(--text-muted); line-height: 1.6; }
        .fee-highlight .fh-price { font-size: 38px; font-weight: 900; color: var(--accent-green); text-shadow: 0 0 15px rgba(16,185,129,0.4); white-space: nowrap; }
        .fee-highlight .fh-price small { font-size: 13px; color: var(--text-muted); font-weight: 700; display: block; text-align: right; }

        /* STEPS (payment flow) */
        .steps-row { display: grid; grid-template-columns: repeat(4, 1fr); gap: 14px; padding: 20px 0 8px 0; }
        .step-box { background: rgba(3,7,18,0.7); border: 1.5px solid var(--border-color); border-radius: 14px; padding: 16px 12px; text-align: center; }
        .step-box .step-no { width: 30px; height: 30px; border-radius: 50%; background: var(--accent-blue); color: #030712; font-weight: 900; font-size: 13px; display: flex; align-items: center; justify-content: center; margin: 0 auto 10px auto; }
        .step-box span { font-size: 12.5px; font-weight: 700; color: var(--text-main); display: block; line-height: 1.4; }

        /* PRIZE CARDS */
        .prize-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 16px; padding: 20px 0; }
        .prize-card { background: rgba(3,7,18,0.7); border: 1.5px solid var(--border-color); border-radius: 16px; padding: 20px 14px; text-align: center; transition: all 0.3s ease; }
        .prize-card:hover { transform: translateY(-4px); border-color: var(--accent-amber); box-shadow: 0 12px 28px rgba(245,158,11,0.2); }
        .prize-card i { font-size: 26px; margin-bottom: 10px; display: block; }
        .prize-card.gold i { color: #fbbf24; }
        .prize-card.silver i { color: #cbd5e1; }
        .prize-card.bronze i { color: #d97706; }
        .prize-card h6 { margin: 0 0 4px 0; font-size: 14px; font-weight: 800; color: var(--text-main); }
        .prize-card p { margin: 0; font-size: 12px; color: var(--text-muted); }

        /* WARNING NOTE */
        .rule-note {
            display: flex; gap: 14px; align-items: flex-start; margin-bottom: 30px;
            background: rgba(245,158,11,0.08); border: 1.5px solid rgba(245,158,11,0.4);
            border-radius: 16px; padding: 18px 22px;
        }
        .rule-note i { color: var(--accent-amber); font-size: 20px; margin-top: 2px; }
        .rule-note p { margin: 0; font-size: 13.2px; color: #fde68a; line-height: 1.7; }

        .no-results { display: none; text-align: center; padding: 40px; color: var(--text-muted); font-weight: 600; }

        /* CTA */
        .cta-banner {
            position: relative; overflow: hidden;
            background: linear-gradient(135deg, #0284c7 0%, #0f172a 60%, #030712 100%);
            border-radius: 26px; padding: 45px 50px; margin-bottom: 45px;
            display: flex; align-items: center; justify-content: space-between; gap: 30px; flex-wrap: wrap;
            box-shadow: 0 25px 50px rgba(0,0,0,0.5);
        }
        .cta-banner-text { position: relative; z-index: 2; max-width: 550px; }
        .cta-banner-text h2 { font-size: 26px; font-weight: 900; color: #fff; margin: 0 0 10px 0; }
        .cta-banner-text p { font-size: 14px; color: rgba(255,255,255,0.8); margin: 0; line-height: 1.6; }
        .btn-cta-white {
            position: relative; z-index: 2; background: #fff; color: #030712; border: none;
            padding: 14px 30px; border-radius: 14px; font-weight: 800; font-size: 13.5px;
            text-decoration: none; display: inline-flex; align-items: center; gap: 8px;
            text-transform: uppercase; white-space: nowrap; transition: all 0.3s ease; box-shadow: 0 10px 25px rgba(0,0,0,0.3);
        }
        .btn-cta-white:hover { transform: translateY(-3px); color: #030712; box-shadow: 0 15px 30px rgba(0,0,0,0.4); }

        /* SCROLL TOP */
        .scroll-top {
            position: fixed; bottom: 28px; right: 28px; background: rgba(56, 189, 248, 0.15);
            color: var(--accent-blue); width: 50px; height: 50px; border-radius: 50%;
            display: flex; align-items: center; justify-content: center; cursor: pointer;
            border: 1.5px solid var(--border-color); transition: all 0.3s ease; opacity: 0; visibility: hidden; z-index: 999;
        }
        .scroll-top.show { opacity: 1; visibility: visible; }
        .scroll-top:hover { background: rgba(56, 189, 248, 0.25); transform: translateY(-4px); box-shadow: 0 0 20px rgba(56,189,248,0.4); }

        /* FOOTER (same as site) */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1.5px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
        @media(max-width: 1024px) { .grand-footer-content { grid-template-columns: 1fr 1fr; } }
        @media(max-width: 650px) { .grand-footer-content { grid-template-columns: 1fr; text-align: center; } }
        .footer-brand h3 { margin: 0 0 12px 0; font-size: 22px; font-weight: 900; text-transform: uppercase; color: var(--text-primary); letter-spacing: 1.5px; }
        .footer-brand h3 span { color: var(--neon-cyan); text-shadow: 0 0 10px rgba(0,217,255,0.5); }
        .footer-brand p { margin: 0 0 20px 0; font-size: 13.5px; color: var(--text-secondary); line-height: 1.7; }
        .footer-socials { display: flex; gap: 10px; flex-wrap: wrap; }
        .footer-socials a { width: 38px; height: 38px; border-radius: 50%; background: rgba(0, 217, 255, 0.1); border: 1.5px solid var(--border-glass); color: var(--neon-cyan); display: flex; align-items: center; justify-content: center; text-decoration: none; transition: all 0.3s ease; font-size: 14px; }
        .footer-socials a:hover { background: var(--neon-cyan); color: #030712; transform: translateY(-3px); box-shadow: 0 0 15px rgba(0,217,255,0.6); }
        .footer-links h4, .footer-newsletter h4 { margin: 0 0 18px 0; font-size: 14px; font-weight: 800; text-transform: uppercase; color: var(--neon-cyan); letter-spacing: 1px; }
        .footer-links ul { list-style: none; padding: 0; margin: 0; display: flex; flex-direction: column; gap: 12px; }
        .footer-links a { color: var(--text-secondary); text-decoration: none; font-size: 13px; font-weight: 600; transition: all 0.2s ease; display: inline-flex; align-items: center; gap: 6px; }
        .footer-links a:hover { color: var(--neon-cyan); transform: translateX(4px); }
        .footer-newsletter p { font-size: 13px; color: var(--text-secondary); margin-bottom: 15px; line-height: 1.6; }
        .footer-newsletter form { display: flex; gap: 8px; }
        .footer-newsletter input { flex: 1; background: rgba(3, 7, 18, 0.7); border: 1.5px solid var(--border-glass); border-radius: 10px; padding: 10px 14px; color: var(--text-primary); font-size: 12.5px; outline: none; }
        .footer-newsletter button { background: linear-gradient(135deg, var(--neon-cyan), var(--neon-emerald)); color: #030712; border: none; border-radius: 10px; padding: 10px 16px; font-weight: 800; font-size: 12.5px; cursor: pointer; transition: 0.3s; }
        .footer-bottom-bar { max-width: 1350px; margin: 0 auto; display: flex; justify-content: space-between; align-items: center; flex-wrap: wrap; gap: 15px; color: var(--text-secondary); font-size: 12px; letter-spacing: 0.5px; }
        .footer-bottom-links { display: flex; gap: 20px; }
        .footer-bottom-links a { color: var(--text-secondary); text-decoration: none; transition: color 0.2s; }
        .footer-bottom-links a:hover { color: var(--neon-cyan); }

        @media (max-width: 1100px) {
            .quick-facts { grid-template-columns: repeat(3, 1fr); }
        }
        @media (max-width: 992px) {
            .rules-layout { grid-template-columns: 1fr; }
            .rules-sidebar { position: static; display: flex; flex-wrap: wrap; gap: 6px; max-height: none; }
            .rules-sidebar h4 { width: 100%; }
            .quick-facts { grid-template-columns: repeat(2, 1fr); }
            .rules-hero { padding: 35px 25px; }
            .rules-hero h1 { font-size: 28px; }
        }
        @media (max-width: 600px) {
            .points-box, .prize-grid { grid-template-columns: 1fr; }
            .steps-row { grid-template-columns: repeat(2, 1fr); }
            .cta-banner { flex-direction: column; text-align: center; padding: 35px 25px; }
            .fee-highlight { flex-direction: column; text-align: center; }
            .fee-highlight .fh-price small { text-align: center; }
        }

        /* =====================================================
           DARK + LIGHT MODE SYSTEM (same as Teams page)
           Text hamesha visible rahega
           ===================================================== */
        :root {
            --pm-body-bg: linear-gradient(135deg, #030712 0%, #0a0f1d 100%);
            --pm-hero-bg: linear-gradient(135deg, rgba(13, 18, 30, 0.95) 0%, rgba(3, 7, 18, 0.98) 100%);
            --pm-inner-bg: rgba(3, 7, 18, 0.7);
            --pm-fee-badge-bg: rgba(3, 7, 18, 0.65);
            --pm-hero-title: #ffffff;
            --pm-formula-text: #d1fae5;
            --pm-note-text: #fde68a;
            --pm-newsletter-bg: rgba(3, 7, 18, 0.7);
            --pm-footer-bg: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99));
            --pm-shadow: rgba(0, 0, 0, 0.3);
            --pm-shadow-strong: rgba(0, 0, 0, 0.6);
        }

        /* Light mode - jo bhi toggle method use ho (data-theme / class) sab cover hai */
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
            --text-main: #0f172a;
            --text-muted: #475569;
            --border-color: #cbd5e1;
            --neon-cyan: #0891b2;
            --neon-emerald: #059669;
            --border-glass: #cbd5e1;
            --text-primary: #0f172a;
            --text-secondary: #475569;
            --pm-body-bg: linear-gradient(135deg, #eef2f7 0%, #f8fafc 100%);
            --pm-hero-bg: linear-gradient(135deg, #ffffff 0%, #e0f2fe 100%);
            --pm-inner-bg: #f1f5f9;
            --pm-fee-badge-bg: rgba(255, 255, 255, 0.92);
            --pm-hero-title: #0f172a;
            --pm-formula-text: #065f46;
            --pm-note-text: #78350f;
            --pm-newsletter-bg: #ffffff;
            --pm-footer-bg: linear-gradient(135deg, #ffffff, #f1f5f9);
            --pm-shadow: rgba(15, 23, 42, 0.12);
            --pm-shadow-strong: rgba(15, 23, 42, 0.18);
        }

        /* Hardcoded dark backgrounds / colors ab variables se chalenge */
        body { background: var(--pm-body-bg); }
        .rules-hero { background: var(--pm-hero-bg); box-shadow: 0 20px 50px var(--pm-shadow-strong); }
        .rules-hero h1 { color: var(--pm-hero-title); }
        .hero-search { background: var(--pm-inner-bg); }
        .hero-fee { background: var(--pm-fee-badge-bg); }
        .hero-fee .fee-amount { color: var(--pm-hero-title); }
        .fact-card, .rule-card, .rules-sidebar { box-shadow: 0 10px 30px var(--pm-shadow); }
        .point-pill, .step-box, .prize-card { background: var(--pm-inner-bg); }
        .formula-box { color: var(--pm-formula-text); }
        .rule-note p { color: var(--pm-note-text); }
        .grand-footer-section { background: var(--pm-footer-bg); }
        .footer-newsletter input { background: var(--pm-newsletter-bg); }
        .footer-newsletter input::placeholder { color: var(--text-secondary); opacity: 0.8; }

        /* Light mode me glow soft + button text clear */
        body.light-mode .rules-hero h1,
        body.light-mode .season-tag,
        body.light-mode .hero-fee .fee-amount,
        body.light-mode .fee-highlight .fh-price,
        body.light-mode .footer-brand h3 span { text-shadow: none; }
        body.light-mode .step-box .step-no,
        body.light-mode .footer-socials a:hover,
        body.light-mode .footer-newsletter button { color: #ffffff; }
        :root[data-theme="light"] .rules-hero h1, :root.light .rules-hero h1, :root.light-mode .rules-hero h1,
        :root[data-theme="light"] .season-tag, :root.light .season-tag, :root.light-mode .season-tag,
        :root[data-theme="light"] .hero-fee .fee-amount, :root.light .hero-fee .fee-amount, :root.light-mode .hero-fee .fee-amount,
        :root[data-theme="light"] .fee-highlight .fh-price, :root.light .fee-highlight .fh-price, :root.light-mode .fee-highlight .fh-price,
        :root[data-theme="light"] .footer-brand h3 span, :root.light .footer-brand h3 span, :root.light-mode .footer-brand h3 span { text-shadow: none; }
        :root[data-theme="light"] .step-box .step-no, :root.light .step-box .step-no, :root.light-mode .step-box .step-no,
        :root[data-theme="light"] .footer-socials a:hover, :root.light .footer-socials a:hover, :root.light-mode .footer-socials a:hover,
        :root[data-theme="light"] .footer-newsletter button, :root.light .footer-newsletter button, :root.light-mode .footer-newsletter button { color: #ffffff; }

        /* =====================================================
           FULL RESPONSIVE (mobile / tablet / desktop)
           ===================================================== */
        html, body { width: 100%; overflow-x: hidden; }
        * { box-sizing: border-box; }
        img { max-width: 100%; height: auto; }
        .rule-item > div, .fee-highlight .fh-left { min-width: 0; }
        .rule-item h5, .rule-item p, .formula-box { overflow-wrap: anywhere; }

        @media (max-width: 992px) {
            .hero-fee { width: 100%; min-width: 0; }
            .hero-search { max-width: 100%; }
        }

        @media (max-width: 768px) {
            .container { padding: 0 12px; margin: 18px auto; }
            .rules-hero { padding: 28px 18px; border-radius: 22px; }
            .rules-hero h1 { font-size: 25px; }
            .rules-hero p { font-size: 13.5px; }
            .hero-fee .fee-amount { font-size: 38px; }
            .rule-card { padding: 4px 16px; }
            .rule-section-title { font-size: 16px; }
            .fee-highlight { padding: 18px 16px; }
            .fee-highlight .fh-price { font-size: 32px; }
            .cta-banner { border-radius: 20px; }
            .cta-banner-text h2 { font-size: 21px; }
            .btn-cta-white { width: 100%; justify-content: center; }
            .grand-footer-section { padding: 36px 20px 24px 20px; width: calc(100% - 24px); margin-top: 40px; }
            .grand-footer-content { gap: 28px; }
            .footer-newsletter form { flex-direction: column; }
            .footer-bottom-bar { flex-direction: column; text-align: center; }
            .footer-bottom-links { flex-wrap: wrap; justify-content: center; }
            .footer-socials { justify-content: center; }
            .scroll-top { width: 44px; height: 44px; bottom: 18px; right: 16px; }
        }

        @media (max-width: 480px) {
            .quick-facts { grid-template-columns: 1fr 1fr; gap: 12px; }
            .fact-card { padding: 14px 10px; }
            .fact-card .num { font-size: 20px; }
            .rules-hero h1 { font-size: 22px; }
            .rule-item { gap: 12px; padding: 15px 0; }
            .rule-num { width: 30px; height: 30px; font-size: 12px; }
            .rule-note { padding: 14px 16px; flex-direction: column; gap: 8px; }
            .steps-row { gap: 10px; }
            .rules-sidebar a { font-size: 12px; padding: 8px 10px; }
        }
    </style>

    <!-- 🌟 NEW (sirf MOBILE fix, laptop pe koi change nahi): Points pills teeno ek line me + Quick Jump links ek line me 2-2 -->
    <style>
        @media (max-width: 768px) {

            /* ---- 1) Points System & NRR: Win / Tie / Loss teeno ek hi line me, chhote size me ---- */
            .points-box {
                display: grid !important;
                grid-template-columns: repeat(3, 1fr) !important;
                gap: 8px !important;
                padding: 16px 0 !important;
            }
            .point-pill {
                padding: 12px 4px;
                border-radius: 12px;
                min-width: 0;
            }
            .point-pill .pts { font-size: 22px; }
            .point-pill .lbl {
                font-size: 9.5px;
                letter-spacing: 0.4px;
                line-height: 1.3;
                display: block;
            }

            /* ---- 2) Quick Jump: ek line me 2 links, barabar width (grid) ---- */
            .rules-sidebar {
                display: grid !important;
                grid-template-columns: repeat(2, 1fr);
                gap: 6px;
                padding: 16px 12px;
            }
            .rules-sidebar h4 {
                grid-column: 1 / -1;
                width: auto;
                margin-bottom: 8px;
            }
            .rules-sidebar a {
                min-width: 0;
                padding: 9px 8px;
                font-size: 11.5px;
                gap: 6px;
                line-height: 1.3;
            }
            .rules-sidebar a i {
                width: 14px;
                font-size: 12px;
                flex-shrink: 0;
            }
        }

        /* Bahut chhoti screen (320px jaisi) */
        @media (max-width: 360px) {
            .points-box { gap: 6px !important; }
            .point-pill { padding: 10px 2px; }
            .point-pill .pts { font-size: 20px; }
            .point-pill .lbl { font-size: 9px; letter-spacing: 0.2px; }
            .rules-sidebar { padding: 14px 8px; gap: 4px; }
            .rules-sidebar a { font-size: 10.5px; padding: 8px 6px; gap: 5px; }
            .rules-sidebar a i { width: 12px; font-size: 11px; }
        }
    </style>
</head>
<body>

    <!-- NAVBAR -->
    <jsp:include page="navbar.jsp" />

    <!-- CHATBOT -->
    <jsp:include page="chatbot.jsp" />

    <div class="container">

        <!-- HERO -->
        <div class="rules-hero">
            <div class="rules-hero-content">
                <span class="season-tag">● Season 2026 • Official Rulebook</span>
                <h1>Rules & <span>Regulations</span></h1>
                <p>Everything teams, players and organizers need to know about registration, fees, match play, points, kit, safety, awards and disputes at ProMatch Arena. Please read carefully before registering your team.</p>
                <div class="hero-search">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="ruleSearch" placeholder="Search a rule... (e.g. NRR, fees, overs, kit)" onkeyup="filterRules()">
                </div>
            </div>
            <div class="hero-fee">
                <span class="fee-label">Team Registration Fee</span>
                <div class="fee-amount"><small>&#8377;</small>500</div>
                <span class="fee-note">Paid online &bull; Secure payment</span>
            </div>
        </div>

        <!-- QUICK FACTS -->
        <div class="quick-facts">
            <div class="fact-card"><i class="fa-solid fa-indian-rupee-sign"></i><span class="num">&#8377;500</span><span class="lbl">Registration fee</span></div>
            <div class="fact-card"><i class="fa-solid fa-users"></i><span class="num">11</span><span class="lbl">Players per side</span></div>
            <div class="fact-card"><i class="fa-solid fa-baseball-bat-ball"></i><span class="num">20</span><span class="lbl">Overs per innings</span></div>
            <div class="fact-card"><i class="fa-solid fa-user-plus"></i><span class="num">15</span><span class="lbl">Max squad size</span></div>
            <div class="fact-card"><i class="fa-solid fa-trophy"></i><span class="num">2</span><span class="lbl">Points per win</span></div>
        </div>

        <!-- NOTE -->
        <div class="rule-note">
            <i class="fa-solid fa-triangle-exclamation"></i>
            <p><strong>Important:</strong> The tournament admin reserves the right to update these rules before or during a season. Any change will be announced on the platform, and the latest version shown on this page is final.</p>
        </div>

        <!-- LAYOUT -->
        <div class="rules-layout">

            <!-- SIDEBAR -->
            <aside class="rules-sidebar" id="rulesSidebar">
                <h4>Quick Jump</h4>
                <a href="#registration" class="active"><i class="fa-solid fa-shield-halved"></i> Team Registration</a>
                <a href="#payment"><i class="fa-solid fa-indian-rupee-sign"></i> Fees & Payment</a>
                <a href="#players"><i class="fa-solid fa-user-check"></i> Player Eligibility</a>
                <a href="#kit"><i class="fa-solid fa-shirt"></i> Kit & Equipment</a>
                <a href="#match"><i class="fa-solid fa-baseball-bat-ball"></i> Match Rules</a>
                <a href="#officials"><i class="fa-solid fa-clipboard-user"></i> Officials & Scoring</a>
                <a href="#points"><i class="fa-solid fa-chart-bar"></i> Points & NRR</a>
                <a href="#awards"><i class="fa-solid fa-medal"></i> Awards & Prizes</a>
                <a href="#safety"><i class="fa-solid fa-kit-medical"></i> Safety & Fair Play</a>
                <a href="#conduct"><i class="fa-solid fa-handshake"></i> Code of Conduct</a>
                <a href="#disputes"><i class="fa-solid fa-scale-balanced"></i> Disputes & Penalties</a>
            </aside>

            <!-- CONTENT -->
            <div id="rulesContent">

                <!-- 1. REGISTRATION -->
                <section class="rule-section" id="registration">
                    <h3 class="rule-section-title"><i class="fa-solid fa-shield-halved"></i> Team Registration</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Registration is online only</h5><p>Every team must register through the "Register Team" page with the team name, city, coach, owner and logo. Incomplete forms will not be processed.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Registration fee: &#8377;500</h5><p>A registration fee of &#8377;500 per team must be paid to complete the registration. See the Fees & Payment section for details.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Unique team name</h5><p>A team name must be unique within a tournament. Names that copy another registered team or use offensive words will be rejected.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Admin approval required</h5><p>A team is confirmed only after the tournament admin approves the registration and the fee is received.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>One captain, one manager</h5><p>Each team must nominate one captain and one manager as the official point of contact for all communication.</p></div></div>
                        <div class="rule-item"><div class="rule-num">6</div><div><h5>Registration deadline</h5><p>Registrations close on the date announced for each tournament. Late entries are accepted only at the admin's discretion.</p></div></div>
                    </div>
                </section>

                <!-- 2. FEES & PAYMENT -->
                <section class="rule-section" id="payment">
                    <h3 class="rule-section-title"><i class="fa-solid fa-indian-rupee-sign"></i> Fees & Payment</h3>
                    <div class="rule-card">
                        <div class="fee-highlight">
                            <div class="fh-left">
                                <h5>Team Registration Fee</h5>
                                <p>One-time fee per team for entering the tournament. Includes tournament listing, live scoring, points table and team dashboard access.</p>
                            </div>
                            <div class="fh-price">&#8377;500<small>per team</small></div>
                        </div>
                        <div class="steps-row">
                            <div class="step-box"><div class="step-no">1</div><span>Fill team registration form</span></div>
                            <div class="step-box"><div class="step-no">2</div><span>Pay &#8377;500 online</span></div>
                            <div class="step-box"><div class="step-no">3</div><span>Admin verifies & approves</span></div>
                            <div class="step-box"><div class="step-no">4</div><span>Team confirmed in tournament</span></div>
                        </div>
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Entry fee amount</h5><p>The registration fee is &#8377;500 per team. The amount is shown on the payment page before you confirm.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Secure online payment</h5><p>Payments are made online through the secure payment gateway. A payment receipt is generated after a successful transaction.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Confirmation</h5><p>Your slot is confirmed only after the payment is successful and the admin approves the team.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Failed or duplicate payments</h5><p>If money is deducted but the payment shows as failed, keep your transaction ID and contact support. Amounts paid twice by mistake will be reviewed for refund.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Refunds</h5><p>The &#8377;500 fee is generally non-refundable once the tournament schedule is published. Refunds, if any, follow the Refund & Cancellation Policy.</p></div></div>
                    </div>
                </section>

                <!-- 3. PLAYERS -->
                <section class="rule-section" id="players">
                    <h3 class="rule-section-title"><i class="fa-solid fa-user-check"></i> Player Eligibility</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Squad size</h5><p>A squad must have a minimum of 11 and a maximum of 15 registered players. Only registered players may take the field.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Age requirement</h5><p>Players must meet the minimum age set for the tournament. Age proof may be requested by the admin at any time.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>One team per tournament</h5><p>A player can represent only one team in a single tournament. Playing for two teams leads to disqualification of that player.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Unique jersey numbers</h5><p>Every player in a squad must have a unique jersey number. Numbers are locked once the first match starts.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Squad changes</h5><p>Players may be added or replaced only before the tournament's squad lock date. After that, changes need admin approval.</p></div></div>
                    </div>
                </section>

                <!-- 4. KIT & EQUIPMENT -->
                <section class="rule-section" id="kit">
                    <h3 class="rule-section-title"><i class="fa-solid fa-shirt"></i> Kit & Equipment</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Team uniform</h5><p>All players of a team must wear the same colour jersey with the player's jersey number clearly visible on the back.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Match ball</h5><p>The tournament will provide the official match ball. Teams may not use their own ball unless the match referee allows it.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Protective gear</h5><p>Helmets are compulsory for batters facing fast bowlers and for close-in fielders. Wicketkeepers must wear pads and gloves.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Bat and gloves</h5><p>Bats must be of legal size as per cricket laws. The umpire can reject any bat or equipment that is unsafe or unfair.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Footwear</h5><p>Players must wear proper cricket shoes. Metal spikes are not allowed on synthetic or indoor pitches.</p></div></div>
                        <div class="rule-item"><div class="rule-num">6</div><div><h5>Branding and logos</h5><p>Team logos and sponsor branding on kits are allowed, but offensive, political or unlawful content is strictly banned.</p></div></div>
                    </div>
                </section>

                <!-- 5. MATCH RULES -->
                <section class="rule-section" id="match">
                    <h3 class="rule-section-title"><i class="fa-solid fa-baseball-bat-ball"></i> Match Rules</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Format</h5><p>Matches are played in a 20-over per side format unless the tournament announces a different format.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Toss and start time</h5><p>Teams must report 30 minutes before the scheduled time. The toss is held 15 minutes before the start. A team that is more than 15 minutes late may lose the match by default.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Bowling limits</h5><p>A single bowler can bowl a maximum of 4 overs in a 20-over innings.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Powerplay</h5><p>The first 6 overs are the powerplay, with only two fielders allowed outside the 30-yard circle.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Over rate</h5><p>Each innings must finish within the allotted time. Slow over rates may attract penalties as decided by the match referee.</p></div></div>
                        <div class="rule-item"><div class="rule-num">6</div><div><h5>Rain and interrupted matches</h5><p>If a match is interrupted, the result is decided using the reduced-overs method. A minimum of 5 overs per side is needed for a result.</p></div></div>
                        <div class="rule-item"><div class="rule-num">7</div><div><h5>Super Over</h5><p>If a knockout match is tied, a Super Over decides the winner. In the league stage, a tie gives one point to each team.</p></div></div>
                        <div class="rule-item"><div class="rule-num">8</div><div><h5>Umpire's decision is final</h5><p>All on-field decisions taken by the umpires are final. Arguing with an umpire can lead to a penalty.</p></div></div>
                    </div>
                </section>

                <!-- 6. OFFICIALS & SCORING -->
                <section class="rule-section" id="officials">
                    <h3 class="rule-section-title"><i class="fa-solid fa-clipboard-user"></i> Officials & Scoring</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Match officials</h5><p>Every match has two on-field umpires, a scorer and a match referee appointed by the tournament admin.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Official scorecard</h5><p>The scorer's record is the official scorecard. Both captains should confirm the final score at the end of the match.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Result approval</h5><p>Scores and results are published on the platform only after the admin or match referee approves them.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Live score updates</h5><p>Live scores shown on the platform are for viewing only and can be corrected if the official scorer finds an error.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Player of the Match</h5><p>The match referee selects the Player of the Match after every game based on the overall performance.</p></div></div>
                        <div class="rule-item"><div class="rule-num">6</div><div><h5>Score corrections</h5><p>Any scoring mistake must be reported to the match referee before the next match of the same team starts.</p></div></div>
                    </div>
                </section>

                <!-- 7. POINTS -->
                <section class="rule-section" id="points">
                    <h3 class="rule-section-title"><i class="fa-solid fa-chart-bar"></i> Points System & NRR</h3>
                    <div class="rule-card">
                        <div class="points-box">
                            <div class="point-pill win"><span class="pts">2</span><span class="lbl">Win</span></div>
                            <div class="point-pill tie"><span class="pts">1</span><span class="lbl">Tie / No Result</span></div>
                            <div class="point-pill loss"><span class="pts">0</span><span class="lbl">Loss</span></div>
                        </div>
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Ranking order</h5><p>Teams are ranked by total points first. If points are equal, the team with more wins is placed higher, then the better Net Run Rate.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Net Run Rate (NRR)</h5><p>NRR is calculated automatically by the platform once a verified scorecard is submitted, so no manual calculation is needed.</p>
                            <div class="formula-box mt-2">NRR = (Total runs scored ÷ Total overs faced) − (Total runs conceded ÷ Total overs bowled)</div>
                        </div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Live updates</h5><p>The Points Table refreshes after the match result is approved by the admin or match referee.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Playoffs</h5><p>The top four teams at the end of the league stage qualify for the knockout rounds unless the tournament states otherwise.</p></div></div>
                    </div>
                </section>

                <!-- 8. AWARDS -->
                <section class="rule-section" id="awards">
                    <h3 class="rule-section-title"><i class="fa-solid fa-medal"></i> Awards & Prizes</h3>
                    <div class="rule-card">
                        <div class="prize-grid">
                            <div class="prize-card gold"><i class="fa-solid fa-trophy"></i><h6>Champions</h6><p>Winner's trophy & medals</p></div>
                            <div class="prize-card silver"><i class="fa-solid fa-award"></i><h6>Runners-up</h6><p>Runner-up trophy & medals</p></div>
                            <div class="prize-card bronze"><i class="fa-solid fa-medal"></i><h6>Third Place</h6><p>Certificate of merit</p></div>
                        </div>
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Individual awards</h5><p>Awards are given for Player of the Tournament, Best Batter (most runs), Best Bowler (most wickets) and Best Fielder.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Prize details</h5><p>Prize money, trophies and rewards are announced separately for each tournament and displayed on its tournament page.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Certificates</h5><p>All participating teams receive a digital participation certificate after the tournament ends.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Award eligibility</h5><p>Teams or players under a ban or penalty during the tournament may lose their eligibility for awards.</p></div></div>
                    </div>
                </section>

                <!-- 9. SAFETY -->
                <section class="rule-section" id="safety">
                    <h3 class="rule-section-title"><i class="fa-solid fa-kit-medical"></i> Safety & Fair Play</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>First aid</h5><p>A basic first-aid kit will be available at the venue. Teams should also carry their own kit for minor injuries.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Player fitness</h5><p>Every player is responsible for their own fitness and must take part only if they are fit to play.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Injury during a match</h5><p>An injured player may be replaced by a substitute fielder. The substitute cannot bat or bowl unless the opposing captain agrees.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Unsafe conditions</h5><p>The umpires can stop or postpone a match if the pitch, outfield, light or weather is unsafe for players.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Anti-doping and fair play</h5><p>Use of banned substances, alcohol or tobacco on the ground is not allowed. Match fixing or betting leads to a permanent ban.</p></div></div>
                    </div>
                </section>

                <!-- 10. CONDUCT -->
                <section class="rule-section" id="conduct">
                    <h3 class="rule-section-title"><i class="fa-solid fa-handshake"></i> Code of Conduct</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Spirit of the game</h5><p>All players, coaches and supporters must respect opponents, umpires, officials and the rules at all times.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>No abusive behaviour</h5><p>Abusive language, threats, discrimination or physical violence is strictly prohibited and can lead to a ban.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Fair play</h5><p>Match fixing, ball tampering, using fake players or giving false information will result in disqualification.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Ground and equipment</h5><p>Teams must take care of the venue and equipment. Damage caused by a team must be paid for by that team.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Account responsibility</h5><p>Users are responsible for their login details and for the accuracy of the data they enter on the platform.</p></div></div>
                    </div>
                </section>

                <!-- 11. DISPUTES -->
                <section class="rule-section" id="disputes">
                    <h3 class="rule-section-title"><i class="fa-solid fa-scale-balanced"></i> Disputes & Penalties</h3>
                    <div class="rule-card">
                        <div class="rule-item"><div class="rule-num">1</div><div><h5>Raising a protest</h5><p>Any protest must be submitted in writing to the tournament admin within 24 hours of the match ending.</p></div></div>
                        <div class="rule-item"><div class="rule-num">2</div><div><h5>Admin committee decision</h5><p>The tournament admin committee reviews every dispute and its decision is final and binding.</p></div></div>
                        <div class="rule-item"><div class="rule-num">3</div><div><h5>Walkover</h5><p>A team that fails to turn up for a match loses the match by walkover. Repeated walkovers can lead to removal from the tournament without any fee refund.</p></div></div>
                        <div class="rule-item"><div class="rule-num">4</div><div><h5>Penalties</h5><p>Depending on the offence, penalties may include a warning, deduction of points, match suspension, player ban or team disqualification.</p></div></div>
                        <div class="rule-item"><div class="rule-num">5</div><div><h5>Contact for help</h5><p>For any doubt about the rules, use the Contact page or check the FAQ before the match day.</p></div></div>
                    </div>
                </section>

                <div class="no-results" id="noResults"><i class="fa-solid fa-circle-exclamation me-2"></i>No matching rule found. Try a different keyword.</div>
            </div>
        </div>

        <!-- CTA -->
        <div class="cta-banner">
            <div class="cta-banner-text">
                <h2>Read the rules? You're ready to play!</h2>
                <p>Register your team for just &#8377;500 and get access to live scoring, automated points tables and a professional tournament dashboard.</p>
            </div>
            <a href="${pageContext.request.contextPath}/register-team" class="btn-cta-white">
                <i class="fa-solid fa-shield-halved"></i> Register Your Team
            </a>
        </div>

    </div>

    <!-- FOOTER -->
    <jsp:include page="footer.jsp" />

    <button class="scroll-top" id="scrollTopBtn" onclick="scrollToTop()" title="Back to top">
        <i class="fa-solid fa-arrow-up"></i>
    </button>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        /* Search filter */
        function filterRules() {
            var q = document.getElementById('ruleSearch').value.toLowerCase().trim();
            var sections = document.querySelectorAll('.rule-section');
            var totalVisible = 0;

            sections.forEach(function (sec) {
                var items = sec.querySelectorAll('.rule-item');
                var visibleInSec = 0;
                items.forEach(function (it) {
                    var match = q === '' || it.innerText.toLowerCase().indexOf(q) !== -1;
                    it.classList.toggle('hidden-by-search', !match);
                    if (match) visibleInSec++;
                });
                var extras = sec.querySelectorAll('.points-box, .fee-highlight, .steps-row, .prize-grid');
                extras.forEach(function (ex) { ex.style.display = (q === '') ? '' : 'none'; });
                sec.style.display = (q === '' || visibleInSec > 0) ? '' : 'none';
                totalVisible += visibleInSec;
            });
            document.getElementById('noResults').style.display = (q !== '' && totalVisible === 0) ? 'block' : 'none';
        }

        /* Sidebar active link on scroll */
        var sideLinks = document.querySelectorAll('#rulesSidebar a');
        function updateActiveLink() {
            var fromTop = window.scrollY + 130;
            var current = null;
            sideLinks.forEach(function (link) {
                var sec = document.querySelector(link.getAttribute('href'));
                if (sec && sec.offsetParent !== null && sec.offsetTop <= fromTop) current = link;
            });
            sideLinks.forEach(function (l) { l.classList.remove('active'); });
            if (current) current.classList.add('active');
        }

        window.onscroll = function () {
            var btn = document.getElementById("scrollTopBtn");
            var y = document.body.scrollTop || document.documentElement.scrollTop;
            btn.classList.toggle("show", y > 200);
            document.querySelector('nav').classList.toggle('scrolled', y > 20);
            updateActiveLink();
        };

        function scrollToTop() {
            window.scrollTo({ top: 0, behavior: 'smooth' });
        }
    </script>
</body>
</html>
