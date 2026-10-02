<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Team Command Center</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; }
        html { scroll-behavior: smooth; }

        :root {
            --tc-bg: #080b1e;
            --tc-card: #0e1428;
            --tc-card-alt: #080b1e;
            --tc-input: #030712;
            --tc-cyan: #00d9ff;
            --tc-green: #00ff88;
            --tc-rose: #ff006e;
            --tc-amber: #ffa500;
            --tc-gold: #ffd700;
            --tc-purple: #b537f2;
            --tc-text: #f0f4ff;
            --tc-muted: #a8b8d8;
            --tc-border: #1e294b;
            --tc-btn-ink: #030712;
            /* fallbacks used by footer.jsp styling */
            --neon-cyan: #00d9ff;
            --neon-emerald: #00ff88;
            --border-glass: #1e294b;
            --text-primary: #f0f4ff;
            --text-secondary: #a8b8d8;
        }
        html[data-theme="light"] {
            --tc-bg: #f1f5f9;
            --tc-card: #ffffff;
            --tc-card-alt: #f1f5f9;
            --tc-input: #ffffff;
            --tc-cyan: #0284c7;
            --tc-green: #059669;
            --tc-rose: #e11d48;
            --tc-amber: #d97706;
            --tc-gold: #b45309;
            --tc-purple: #7c3aed;
            --tc-text: #0f172a;
            --tc-muted: #475569;
            --tc-border: #cbd5e1;
        }

        body {
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
            background: var(--tc-bg);
            color: var(--tc-text);
            margin: 0; padding: 0;
            overflow-x: hidden;
        }

        .main-content-wrap { max-width: 1400px; margin: 30px auto; padding: 0 20px; }

        /* ================= 1. HEADER BAR ================= */
        .header-bar {
            display: grid; grid-template-columns: 1fr auto 1fr; align-items: center; gap: 16px;
            margin-bottom: 26px; padding: 18px 30px; border-radius: 18px;
            background: var(--tc-card); border: 1px solid var(--tc-border);
        }
        .header-left { display: flex; align-items: center; }
        .admin-chip {
            display: inline-flex; align-items: center; gap: 7px; font-size: 11px; font-weight: 800; letter-spacing: 1px; text-transform: uppercase;
            color: var(--tc-rose); background: rgba(255, 0, 110, 0.12); border: 1px solid rgba(255, 0, 110, 0.4);
            padding: 6px 12px; border-radius: 20px;
        }
        .header-right { display: flex; align-items: center; justify-content: flex-end; gap: 12px; }

        .jumping-title {
            text-align: center; margin: 0; font-weight: 900; font-size: clamp(17px, 4.6vw, 24px);
            letter-spacing: 2px; text-transform: uppercase; overflow: visible;
        }
        .jumping-title .word { display: inline-block; white-space: nowrap; }
        .jumping-title .ch {
            display: inline-block; color: var(--tc-cyan);
            text-shadow: 0 0 15px rgba(0, 217, 255, 0.7), 0 0 30px rgba(0, 255, 136, 0.4);
            transform: translateY(-30px); opacity: 0;
            animation: dropInChar 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275) forwards;
            animation-delay: calc(0.05s * var(--i));
        }
        html[data-theme="light"] .jumping-title .ch { text-shadow: none; }
        @keyframes dropInChar {
            0% { opacity: 0; transform: translateY(-30px) scale(0.5); }
            60% { opacity: 1; transform: translateY(10px) scale(1.1); }
            100% { opacity: 1; transform: translateY(0) scale(1); }
        }

        .btn-top-add {
            background: linear-gradient(135deg, #0ea5e9 0%, #0369a1 100%); color: #ffffff;
            border: 1.5px solid rgba(0, 217, 255, 0.6); height: 42px; padding: 0 18px; border-radius: 10px;
            text-decoration: none; font-weight: 700; font-size: 13px; display: inline-flex; align-items: center; gap: 7px;
            box-shadow: 0 4px 15px rgba(14, 165, 233, 0.3); transition: all 0.3s ease; white-space: nowrap;
        }
        .btn-top-add:hover { transform: translateY(-3px); box-shadow: 0 8px 25px rgba(0, 217, 255, 0.5); background: linear-gradient(135deg, #38bdf8 0%, #0284c7 100%); color: #fff; }
        .btn-delete-all {
            background: linear-gradient(135deg, rgba(255, 0, 110, 0.15), rgba(255, 106, 0, 0.15)); color: var(--tc-rose);
            border: 1.5px solid var(--tc-rose); height: 42px; padding: 0 18px; border-radius: 10px;
            text-decoration: none; font-weight: 700; font-size: 13px; display: inline-flex; align-items: center; gap: 7px;
            transition: all 0.3s ease; white-space: nowrap;
        }
        .btn-delete-all:hover { background: var(--tc-rose); color: #fff; box-shadow: 0 0 20px rgba(255, 0, 110, 0.5); transform: translateY(-3px); }

        /* ================= 2. CONTROL BAR ================= */
        .control-bar {
            margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; gap: 14px; flex-wrap: wrap;
            background: var(--tc-card); padding: 14px 24px; border-radius: 14px; border: 1px solid var(--tc-border);
        }
        .search-input {
            background: var(--tc-input); border: 1.5px solid var(--tc-border); border-radius: 10px;
            height: 42px; padding: 0 16px; color: var(--tc-text); font-size: 13px; width: 100%; max-width: 360px;
            outline: none; transition: 0.3s; font-family: inherit;
        }
        .search-input::placeholder { color: var(--tc-muted); opacity: 0.7; }
        .search-input:focus { border-color: var(--tc-cyan); box-shadow: 0 0 15px rgba(0, 217, 255, 0.35); }
        .stats-badge {
            font-size: 13px; font-weight: 700; color: var(--tc-muted); background: var(--tc-card-alt);
            padding: 10px 16px; border-radius: 10px; border: 1px solid var(--tc-border); white-space: nowrap;
        }
        .stats-badge span { color: var(--tc-gold); font-weight: 800; }

        /* ================= 3. TEAM CARDS ================= */
        .teams-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 24px; margin: 0 auto 10px; }
        .team-card {
            background: var(--tc-card); border-radius: 20px; border: 1.5px solid var(--tc-border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.25); position: relative; overflow: hidden;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); display: flex; flex-direction: column;
        }
        .team-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 100%; height: 4px;
            background: linear-gradient(90deg, var(--tc-cyan), var(--tc-green), var(--tc-gold));
        }
        .team-card:hover { transform: translateY(-8px); border-color: var(--tc-cyan); box-shadow: 0 22px 45px rgba(0, 217, 255, 0.25); }
        .card-banner {
            height: 68px; background: linear-gradient(135deg, rgba(0, 217, 255, 0.15), rgba(0, 255, 136, 0.15));
            border-bottom: 1.5px solid var(--tc-border); display: flex; justify-content: space-between; align-items: flex-start; padding: 13px 18px;
        }
        .team-id-badge {
            font-size: 10px; font-weight: 800; color: var(--tc-cyan); background: rgba(3, 7, 18, 0.8);
            padding: 4px 12px; border-radius: 8px; border: 1.5px solid var(--tc-cyan);
        }
        html[data-theme="light"] .team-id-badge { background: rgba(255,255,255,0.9); }
        .card-body-section { padding: 0 20px 20px 20px; margin-top: -36px; display: flex; flex-direction: column; gap: 16px; flex: 1; }
        .logo-title-row { display: flex; align-items: flex-end; gap: 14px; }
        .team-logo-avatar {
            width: 76px; height: 76px; border-radius: 16px; object-fit: cover; flex-shrink: 0;
            border: 3px solid var(--tc-card); background: #020617; box-shadow: 0 10px 25px rgba(0,0,0,0.4); transition: transform 0.3s ease;
            display: flex; align-items: center; justify-content: center; font-size: 10px; font-weight: 800; color: var(--tc-cyan);
        }
        .team-card:hover .team-logo-avatar { transform: scale(1.05); border-color: var(--tc-cyan); }
        .team-title-wrap { flex: 1; min-width: 0; padding-bottom: 4px; }
        .team-name { font-size: 17px; font-weight: 900; letter-spacing: 0.5px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .team-city { font-size: 12.5px; font-weight: 700; color: var(--tc-cyan); margin-top: 3px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .info-pods { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; }
        .pod { background: var(--tc-card-alt); border: 1.5px solid var(--tc-border); border-radius: 12px; padding: 11px; display: flex; flex-direction: column; gap: 3px; min-width: 0; }
        .pod-label { font-size: 10px; text-transform: uppercase; font-weight: 800; color: var(--tc-muted); }
        .pod-val { font-size: 13px; font-weight: 700; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .card-actions { display: grid; grid-template-columns: 1.3fr 1fr 1fr; gap: 9px; margin-top: auto; padding-top: 4px; }
        .card-actions a {
            height: 38px; text-decoration: none; border-radius: 10px; font-size: 11px; font-weight: 800;
            display: inline-flex; align-items: center; justify-content: center; gap: 6px;
            transition: all 0.2s ease; text-transform: uppercase; letter-spacing: 0.4px; white-space: nowrap;
        }
        .btn-view { background: rgba(0, 255, 136, 0.15); color: var(--tc-green); border: 1.5px solid var(--tc-green); }
        .btn-view:hover { background: var(--tc-green); color: #030712; box-shadow: 0 0 15px rgba(0, 255, 136, 0.4); }
        .btn-edit { background: rgba(0, 217, 255, 0.15); color: var(--tc-cyan); border: 1.5px solid var(--tc-cyan); }
        .btn-edit:hover { background: var(--tc-cyan); color: #030712; box-shadow: 0 0 15px rgba(0, 217, 255, 0.4); }
        .btn-delete { background: rgba(255, 0, 110, 0.15); color: var(--tc-rose); border: 1.5px solid var(--tc-rose); }
        .btn-delete:hover { background: var(--tc-rose); color: #fff; box-shadow: 0 0 15px rgba(255, 0, 110, 0.4); }
        html[data-theme="light"] .btn-view:hover, html[data-theme="light"] .btn-edit:hover { color: #fff; }

        .no-team {
            text-align: center; color: var(--tc-muted); grid-column: 1 / -1; padding: 50px 20px; font-size: 14px; font-weight: 700;
            background: var(--tc-card); border: 1px dashed var(--tc-border); border-radius: 16px; text-transform: uppercase;
        }

        /* ================= 4. PAGINATION ================= */
        .pagination-bar { display: flex; justify-content: flex-end; align-items: center; gap: 16px; margin: 34px 0 0; padding: 4px 0; flex-wrap: wrap; }
        .pagination-bar a, .pagination-bar .disabled {
            height: 40px; padding: 0 20px; border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 12px; text-transform: uppercase;
            display: inline-flex; align-items: center;
        }
        .pagination-bar a { background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712; transition: all 0.2s; }
        .pagination-bar a:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0, 217, 255, 0.5); }
        .pagination-bar .disabled { opacity: 0.35; cursor: not-allowed; background: rgba(148, 163, 184, 0.1); color: var(--tc-muted); }
        .page-indicator { font-size: 13px; font-weight: 700; color: var(--tc-muted); padding: 0 15px; border-left: 2px solid var(--tc-border); border-right: 2px solid var(--tc-border); }

        /* ================= SECTION TITLE (shared) ================= */
        .section-block { margin: 44px auto 0; }
        .section-title {
            font-size: 18px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.2px;
            margin: 0 0 22px; display: flex; align-items: center; gap: 12px; flex-wrap: wrap;
        }
        .section-title::before { content: ''; width: 4px; height: 24px; flex-shrink: 0; background: linear-gradient(180deg, var(--tc-cyan), var(--tc-green)); border-radius: 2px; }
        .section-title small { margin-left: auto; font-size: 11.5px; font-weight: 700; color: var(--tc-muted); text-transform: none; letter-spacing: 0.3px; }

        /* ================= 5. LEAGUE OVERVIEW ================= */
        .stats-grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .stat-box {
            background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 18px; padding: 24px; text-align: center;
            transition: all 0.3s ease; box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .stat-box:hover { border-color: var(--tc-cyan); transform: translateY(-5px); }
        .stat-box i { font-size: 20px; margin-bottom: 10px; display: block; }
        .stat-number { font-size: 32px; font-weight: 900; color: var(--tc-cyan); margin-bottom: 6px; }
        .stat-label { font-size: 12.5px; font-weight: 700; color: var(--tc-muted); text-transform: uppercase; }

        /* ================= panels ================= */
        .grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; }
        .grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px; }
        .grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .panel { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 18px; padding: 24px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
        .panel h3 { margin: 0 0 18px; font-size: 15px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.6px; display: flex; align-items: center; gap: 9px; }
        .panel-empty { font-size: 13px; color: var(--tc-muted); margin: 0; }

        /* city bars */
        .bar-row { margin-bottom: 15px; }
        .bar-row:last-child { margin-bottom: 0; }
        .bar-label { display: flex; justify-content: space-between; gap: 10px; font-size: 12.5px; font-weight: 700; margin-bottom: 6px; }
        .bar-label span:first-child { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .bar-track { height: 10px; border-radius: 8px; background: var(--tc-card-alt); border: 1px solid var(--tc-border); overflow: hidden; }
        .bar-fill { height: 100%; border-radius: 8px; transition: width 0.6s ease; }

        /* list rows */
        .list-row { display: flex; align-items: center; gap: 12px; padding: 12px 0; border-bottom: 1px solid var(--tc-border); }
        .list-row:last-child { border-bottom: none; padding-bottom: 0; }
        .list-row:first-child { padding-top: 0; }
        .list-avatar {
            width: 40px; height: 40px; border-radius: 12px; flex-shrink: 0; overflow: hidden;
            background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712;
            display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 14px;
        }
        .list-avatar img { width: 100%; height: 100%; object-fit: cover; }
        .list-main { flex: 1; min-width: 0; }
        .list-name { margin: 0; font-size: 13.5px; font-weight: 800; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .list-sub { margin: 2px 0 0; font-size: 11.5px; color: var(--tc-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .tags { display: flex; gap: 5px; flex-wrap: wrap; margin-top: 6px; }
        .tag {
            font-size: 10px; font-weight: 800; padding: 3px 9px; border-radius: 20px; text-transform: uppercase; white-space: nowrap;
            color: var(--tc-amber); background: rgba(255, 165, 0, 0.14); border: 1px solid rgba(255, 165, 0, 0.35);
        }
        .mini-link {
            font-size: 11px; font-weight: 800; color: var(--tc-cyan); text-decoration: none; white-space: nowrap;
            border: 1.5px solid var(--tc-cyan); padding: 6px 12px; border-radius: 8px; transition: all 0.2s; text-transform: uppercase;
        }
        .mini-link:hover { background: var(--tc-cyan); color: #030712; }

        /* quick actions */
        .qa-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(170px, 1fr)); gap: 16px; }
        .qa-item {
            background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 16px; padding: 22px 14px; text-align: center;
            text-decoration: none; color: var(--tc-text); font-size: 13px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.4px; transition: all 0.25s;
        }
        .qa-item i { display: block; font-size: 24px; margin-bottom: 12px; color: var(--tc-cyan); }
        .qa-item:hover { border-color: var(--tc-cyan); transform: translateY(-5px); box-shadow: 0 15px 35px rgba(0, 217, 255, 0.2); color: var(--tc-cyan); }

        /* admin toolkit cards */
        .feature-card {
            background: linear-gradient(135deg, rgba(14, 20, 40, 0.5), rgba(8, 11, 30, 0.2)), var(--tc-card);
            border: 1.5px solid var(--tc-border); border-radius: 18px; padding: 24px; transition: all 0.3s ease; box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        .feature-card:hover { transform: translateY(-5px); border-color: var(--tc-cyan); box-shadow: 0 15px 40px rgba(0, 217, 255, 0.22); }
        .feature-icon {
            width: 48px; height: 48px; border-radius: 12px; background: rgba(0, 217, 255, 0.12); border: 1px solid var(--tc-cyan);
            display: flex; align-items: center; justify-content: center; font-size: 20px; color: var(--tc-cyan); margin-bottom: 16px;
        }
        .feature-card h5 { margin: 0 0 8px; font-size: 15px; font-weight: 800; text-transform: uppercase; }
        .feature-card p { margin: 0; font-size: 12.5px; color: var(--tc-muted); line-height: 1.6; }

        /* workflow steps */
        .steps-wrap { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 20px; padding: 30px; }
        .step-box { background: var(--tc-card-alt); border: 1.5px solid var(--tc-border); border-radius: 14px; padding: 20px; text-align: center; transition: all 0.3s ease; }
        .step-box:hover { transform: translateY(-4px); border-color: var(--tc-cyan); }
        .step-num {
            width: 36px; height: 36px; margin: 0 auto 12px; border-radius: 50%; background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green));
            color: #030712; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 14px; box-shadow: 0 0 15px rgba(0, 217, 255, 0.4);
        }
        .step-box h5 { margin: 0 0 6px; font-size: 13.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.4px; }
        .step-box p { margin: 0; font-size: 12px; color: var(--tc-muted); line-height: 1.5; }

        /* tips */
        .tip-row { display: flex; gap: 14px; align-items: flex-start; }
        .tip-num {
            width: 32px; height: 32px; border-radius: 10px; flex-shrink: 0; background: rgba(0, 217, 255, 0.12); border: 1px solid var(--tc-cyan);
            color: var(--tc-cyan); font-weight: 900; font-size: 13px; display: flex; align-items: center; justify-content: center;
        }
        .tip-title { font-size: 13.5px; font-weight: 800; margin: 0 0 4px; }
        .tip-desc { font-size: 12.5px; color: var(--tc-muted); margin: 0; line-height: 1.55; }

        /* help CTA */
        .help-cta {
            margin: 44px auto 10px; border-radius: 22px; padding: 38px;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.16), rgba(0, 255, 136, 0.1)), var(--tc-card);
            border: 2px solid var(--tc-cyan); box-shadow: 0 20px 45px rgba(0, 217, 255, 0.15);
            display: flex; align-items: center; justify-content: space-between; gap: 24px; flex-wrap: wrap;
        }
        .help-cta h3 { margin: 0 0 8px; font-size: clamp(18px, 4.5vw, 22px); font-weight: 900; text-transform: uppercase; letter-spacing: 1px; }
        .help-cta p { margin: 0; font-size: 13.5px; color: var(--tc-muted); font-weight: 600; max-width: 560px; line-height: 1.6; }
        .btn-help {
            background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712; border: none; height: 46px; padding: 0 26px;
            border-radius: 14px; font-weight: 900; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; cursor: pointer;
            display: inline-flex; align-items: center; gap: 8px; white-space: nowrap; box-shadow: 0 0 25px rgba(0, 217, 255, 0.45); transition: all 0.3s ease; font-family: inherit;
        }
        .btn-help:hover { transform: scale(1.05); box-shadow: 0 0 35px rgba(0, 255, 136, 0.6); }


        /* overview cards + new sections */
        .overview-link { text-decoration: none; color: inherit; display: block; }
        .overview-link .go { display: inline-flex; align-items: center; gap: 7px; margin-top: 14px; font-size: 11.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; color: var(--tc-cyan); transition: gap 0.2s; }
        .overview-link:hover .go { gap: 11px; }

        .check-list { list-style: none; margin: 0; padding: 0; display: flex; flex-direction: column; gap: 13px; }
        .check-list li { display: flex; align-items: flex-start; gap: 11px; font-size: 13px; line-height: 1.5; color: var(--tc-muted); font-weight: 600; }
        .check-list li strong { color: var(--tc-text); font-weight: 800; }
        .check-list li i { width: 22px; height: 22px; flex-shrink: 0; margin-top: 1px; border-radius: 7px; display: flex; align-items: center; justify-content: center; font-size: 11px; background: rgba(0,255,136,0.14); color: var(--tc-green); border: 1px solid rgba(0,255,136,0.35); }
        .check-list.info li i { background: rgba(0,217,255,0.12); color: var(--tc-cyan); border-color: rgba(0,217,255,0.35); }

        .faq-item { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 14px; margin-bottom: 12px; transition: border-color 0.25s; overflow: hidden; }
        .faq-item:hover, .faq-item[open] { border-color: var(--tc-cyan); }
        .faq-item summary { cursor: pointer; padding: 16px 20px; font-size: 14px; font-weight: 800; list-style: none; display: flex; justify-content: space-between; align-items: center; gap: 14px; }
        .faq-item summary::-webkit-details-marker { display: none; }
        .faq-item summary::after { content: '+'; color: var(--tc-cyan); font-size: 22px; font-weight: 700; line-height: 1; flex-shrink: 0; }
        .faq-item[open] summary::after { content: '\2212'; }
        .faq-body { padding: 0 20px 18px; font-size: 13px; color: var(--tc-muted); line-height: 1.7; font-weight: 500; }

        /* ================= RESPONSIVE ================= */
        @media (max-width: 1024px) {
            .stats-grid, .grid-4 { grid-template-columns: repeat(2, 1fr); }
            .grid-3 { grid-template-columns: repeat(2, 1fr); }
            .grid-2 { grid-template-columns: 1fr; }
        }
        @media (max-width: 900px) {
            .header-bar { grid-template-columns: 1fr; text-align: center; padding: 18px 16px; }
            .header-left, .header-right { justify-content: center; }
        }
        @media (max-width: 640px) {
            .main-content-wrap { padding: 0 14px; margin: 20px auto; }
            .header-right { width: 100%; }
            .header-right .btn-top-add, .header-right .btn-delete-all { flex: 1; justify-content: center; padding: 0 10px; font-size: 12px; }
            .control-bar { padding: 12px; }
            .search-input { max-width: none; font-size: 16px; }
            .stats-badge { width: 100%; text-align: center; }
            .teams-grid { grid-template-columns: 1fr; }
            .grid-3, .grid-4 { grid-template-columns: 1fr; }
            .steps-wrap { padding: 20px 16px; }
            .help-cta { padding: 26px 20px; flex-direction: column; text-align: center; }
            .btn-help { width: 100%; justify-content: center; }
            .pagination-bar { justify-content: center; }
            .section-title small { margin-left: 0; width: 100%; }
        }
        @media (max-width: 420px) {
            .stats-grid { grid-template-columns: 1fr 1fr; gap: 12px; }
            .stat-box { padding: 18px 10px; }
            .stat-number { font-size: 26px; }
        }

        /* ================= FOOTER (same as user pages) ================= */
        .grand-footer-section { background: linear-gradient(135deg, rgba(13, 18, 35, 0.98), rgba(4, 7, 18, 0.99)); backdrop-filter: blur(25px); border-top: 2px solid var(--neon-cyan); border-radius: 28px 28px 0 0; padding: 60px 40px 30px 40px; box-shadow: 0 -20px 50px rgba(0, 0, 0, 0.6); max-width: 1400px; margin: 60px auto 20px auto; width: calc(100% - 40px); box-sizing: border-box; }
        .grand-footer-content { display: grid; grid-template-columns: 2fr 1.2fr 1.2fr 1.5fr; gap: 40px; align-items: start; border-bottom: 1px solid var(--border-glass); padding-bottom: 40px; margin-bottom: 25px; max-width: 1350px; margin-left: auto; margin-right: auto; }
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
    </style>
</head>
<body>

    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">

        <!-- ================= 1. HEADER BAR ================= -->
        <div class="header-bar">
            <div class="header-left"><span class="admin-chip"><i class="fa-solid fa-user-shield"></i> Admin Control</span></div>
            <h2 class="jumping-title" id="animatedTitle">Team Command Center</h2>
            <div class="header-right">
                <a href="/admin/addTeamPage" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Team</a>
                <c:if test="${not empty teams}">
                    <a href="/admin/deleteAllTeams" class="btn-delete-all" onclick="return confirm('DANGER: Are you sure you want to delete all teams?');"><i class="fa-solid fa-trash-can"></i> Delete All</a>
                </c:if>
            </div>
        </div>

        <!-- ================= 2. CONTROL BAR ================= -->
        <div class="control-bar">
            <input type="text" id="teamSearch" class="search-input" placeholder="🔍 Search team by name or city..." autocomplete="off">
            <div class="stats-badge">Total Teams: <span id="totalBadge">${empty totalItems ? (empty teams ? 0 : teams.size()) : totalItems}</span></div>
        </div>

        <!-- ================= 3. TEAMS GRID ================= -->
        <div class="teams-grid" id="teamsGrid">
            <c:forEach items="${teams}" var="t">
                <div class="team-card"
                     data-id="<c:out value='${t.id}'/>"
                     data-name="<c:out value='${t.teamName}'/>"
                     data-city="<c:out value='${t.city}'/>"
                     data-coach="<c:out value='${t.coachName}'/>"
                     data-owner="<c:out value='${t.ownerName}'/>"
                     data-logo="<c:out value='${t.logoUrl}'/>">

                    <div class="card-banner">
                        <span class="team-id-badge">#TEAM-${t.id}</span>
                    </div>

                    <div class="card-body-section">
                        <div class="logo-title-row">
                            <c:choose>
                                <c:when test="${not empty t.logoUrl}">
                                    <img src="<c:out value='${t.logoUrl}'/>" alt="Logo" class="team-logo-avatar">
                                </c:when>
                                <c:otherwise>
                                    <div class="team-logo-avatar">LOGO</div>
                                </c:otherwise>
                            </c:choose>
                            <div class="team-title-wrap">
                                <div class="team-name" title="<c:out value='${t.teamName}'/>"><c:out value="${t.teamName}"/></div>
                                <div class="team-city">📍 <c:out value="${t.city}"/></div>
                            </div>
                        </div>

                        <div class="info-pods">
                            <div class="pod">
                                <span class="pod-label">Coach</span>
                                <span class="pod-val" title="<c:out value='${t.coachName}'/>"><c:out value="${t.coachName}"/></span>
                            </div>
                            <div class="pod">
                                <span class="pod-label">Owner</span>
                                <span class="pod-val" title="<c:out value='${t.ownerName}'/>"><c:out value="${t.ownerName}"/></span>
                            </div>
                        </div>

                        <div class="card-actions">
                            <a href="/admin/team/${t.id}/players" class="btn-view"><i class="fa-solid fa-users"></i> Players</a>
                            <a href="/admin/editTeam/${t.id}" class="btn-edit"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                            <a href="/admin/deleteTeam/${t.id}" class="btn-delete" onclick="return confirm('WARNING: Are you sure you want to delete this team?');"><i class="fa-solid fa-trash"></i> Delete</a>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty teams}">
                <div class="no-team">🏏 No active teams registered yet. Click "New Team" to add the first one.</div>
            </c:if>
            <div class="no-team" id="noResults" style="display:none;">🔍 No teams match your search.</div>
        </div>

        <!-- ================= 4. PAGINATION (shows only if your controller sends totalPages) ================= -->
        <c:if test="${not empty totalPages and totalPages > 1}">
            <div class="pagination-bar">
                <c:choose>
                    <c:when test="${currentPage > 0}">
                        <a href="${pageContext.request.contextPath}/admin/teams?page=${currentPage - 1}">⬅ Previous</a>
                    </c:when>
                    <c:otherwise><span class="disabled">⬅ Previous</span></c:otherwise>
                </c:choose>

                <span class="page-indicator">Page ${currentPage + 1} of ${totalPages}</span>

                <c:choose>
                    <c:when test="${currentPage + 1 < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/teams?page=${currentPage + 1}">Next ➡</a>
                    </c:when>
                    <c:otherwise><span class="disabled">Next ➡</span></c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- ================= 5. LEAGUE CONTROL OVERVIEW ================= -->
        <div class="section-block">
            <h3 class="section-title">🏏 League Control Overview <small>Everything you can manage from here</small></h3>
            <div class="grid-4">
                <a href="/admin/addTeamPage" class="feature-card overview-link">
                    <div class="feature-icon"><i class="fa-solid fa-shield-halved"></i></div>
                    <h5>Franchise Management</h5>
                    <p>Register new franchises, update their details and keep every team profile complete.</p>
                    <span class="go">Add a team <i class="fa-solid fa-arrow-right"></i></span>
                </a>
                <a href="/admin/tournaments" class="feature-card overview-link">
                    <div class="feature-icon" style="color: var(--tc-gold); border-color: var(--tc-gold); background: rgba(255,215,0,0.10);"><i class="fa-solid fa-trophy"></i></div>
                    <h5>Tournament Control</h5>
                    <p>Create tournaments, choose the format and decide which teams take part.</p>
                    <span class="go">Open tournaments <i class="fa-solid fa-arrow-right"></i></span>
                </a>
                <a href="/admin/matches" class="feature-card overview-link">
                    <div class="feature-icon" style="color: var(--tc-green); border-color: var(--tc-green); background: rgba(0,255,136,0.10);"><i class="fa-solid fa-baseball"></i></div>
                    <h5>Fixtures &amp; Scheduling</h5>
                    <p>Schedule matches, update results and keep the fixture list accurate for everyone.</p>
                    <span class="go">Open matches <i class="fa-solid fa-arrow-right"></i></span>
                </a>
                <a href="/admin/pointsTable" class="feature-card overview-link">
                    <div class="feature-icon" style="color: var(--tc-purple); border-color: var(--tc-purple); background: rgba(181,55,242,0.10);"><i class="fa-solid fa-ranking-star"></i></div>
                    <h5>Standings &amp; Reports</h5>
                    <p>Follow the points table and see how every team is performing in the season.</p>
                    <span class="go">View points table <i class="fa-solid fa-arrow-right"></i></span>
                </a>
            </div>
        </div>

        <!-- ================= 6. TEAM INSIGHTS ================= -->
        <div class="section-block">
            <h3 class="section-title">⚡ Team Insights <small>Updates from your team list</small></h3>
            <div class="grid-2">
                <div class="panel">
                    <h3><i class="fa-solid fa-location-dot" style="color: var(--tc-rose);"></i> Teams By City</h3>
                    <div id="cityBars"></div>
                </div>
                <div class="panel">
                    <h3><i class="fa-solid fa-clock-rotate-left" style="color: var(--tc-cyan);"></i> Recently Added Teams</h3>
                    <div id="recentList"></div>
                </div>
            </div>
        </div>

        <!-- ================= 7. NEEDS ATTENTION ================= -->
        <div class="section-block">
            <h3 class="section-title">⚠️ Needs Attention <small>Incomplete team profiles</small></h3>
            <div class="panel"><div id="attentionList"></div></div>
        </div>

        <!-- ================= 8. QUICK ACTIONS ================= -->
        <div class="section-block">
            <h3 class="section-title">🚀 Quick Actions</h3>
            <div class="qa-grid">
                <a href="/admin/addTeamPage" class="qa-item"><i class="fa-solid fa-circle-plus"></i>Add New Team</a>
                <a href="/admin/tournaments" class="qa-item"><i class="fa-solid fa-trophy"></i>Tournaments</a>
                <a href="/admin/matches" class="qa-item"><i class="fa-solid fa-baseball"></i>Matches</a>
                <a href="/admin/pointsTable" class="qa-item"><i class="fa-solid fa-ranking-star"></i>Points Table</a>
                <a href="/admin/users" class="qa-item"><i class="fa-solid fa-users"></i>Manage Users</a>
                <a href="/admin/home" class="qa-item"><i class="fa-solid fa-gauge-high"></i>Dashboard</a>
            </div>
        </div>

        <!-- ================= 9. ADMIN TOOLKIT ================= -->
        <div class="section-block">
            <h3 class="section-title">💎 Admin Toolkit</h3>
            <div class="grid-4">
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-users-gear"></i></div><h5>Roster Control</h5><p>Open any team, review its players and update squads without leaving the admin panel.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-pen-ruler"></i></div><h5>Quick Edit</h5><p>Correct team name, city, coach, owner or logo in one click from the team card.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-shield-halved"></i></div><h5>Verified Records</h5><p>Every franchise entry is stored in the database so records stay clean and consistent.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-bolt-lightning"></i></div><h5>Instant Sync</h5><p>Changes you make appear on the public Teams page, fixtures and points table right away.</p></div>
            </div>
        </div>

        <!-- ================= NEW: SUPPORTED TOURNAMENT FORMATS ================= -->
        <div class="section-block">
            <h3 class="section-title">🏆 Supported Tournament Formats</h3>
            <div class="grid-4">
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-bolt"></i></div><h5>T20 Blast</h5><p>Fast, high-scoring matches that finish in one evening and keep fans on the edge.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-hourglass-half"></i></div><h5>One-Day Series</h5><p>Longer innings that reward planning, partnerships and consistent bowling.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-sitemap"></i></div><h5>Knockout Rounds</h5><p>Lose once and you are out. Every match feels like a final.</p></div>
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-arrows-rotate"></i></div><h5>Round Robin</h5><p>Every team plays every other team, and the points table decides the winner.</p></div>
            </div>
        </div>

        <!-- ================= 10. REGISTRATION WORKFLOW ================= -->
        <div class="section-block">
            <div class="steps-wrap">
                <h3 class="section-title">📝 Registration Workflow (Admin View)</h3>
                <div class="grid-4">
                    <div class="step-box"><div class="step-num">1</div><h5>Team Submitted</h5><p>Owner fills in team details and logo</p></div>
                    <div class="step-box"><div class="step-num">2</div><h5>Payment Verified</h5><p>Entry fee confirmed via secure payment</p></div>
                    <div class="step-box"><div class="step-num">3</div><h5>Admin Review</h5><p>Check details and fix anything incomplete</p></div>
                    <div class="step-box"><div class="step-num">4</div><h5>Team Live</h5><p>Team shows in directory and fixtures</p></div>
                </div>
            </div>
        </div>

        <!-- ================= NEW: PROFILE CHECKLIST + LOGO GUIDELINES ================= -->
        <div class="section-block">
            <h3 class="section-title">✅ Franchise Standards</h3>
            <div class="grid-2">
                <div class="panel">
                    <h3><i class="fa-solid fa-clipboard-check" style="color: var(--tc-green);"></i> Complete Profile Checklist</h3>
                    <ul class="check-list">
                        <li><i class="fa-solid fa-check"></i><span><strong>Unique team name</strong> so fans and players can find the team easily.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Home city</strong> to show where the franchise is based.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Head coach</strong> who leads the squad on match days.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Franchise owner</strong> as the main point of contact.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Team logo</strong> so the team looks professional on every page.</span></li>
                    </ul>
                </div>
                <div class="panel">
                    <h3><i class="fa-solid fa-image" style="color: var(--tc-cyan);"></i> Logo Guidelines</h3>
                    <ul class="check-list info">
                        <li><i class="fa-solid fa-square"></i><span>Use a <strong>square image</strong> so it fits the round and rounded frames.</span></li>
                        <li><i class="fa-solid fa-file-image"></i><span>Prefer <strong>PNG or JPG</strong> files with a clean, clear background.</span></li>
                        <li><i class="fa-solid fa-link"></i><span>Paste a <strong>direct image link</strong>, not a web page address.</span></li>
                        <li><i class="fa-solid fa-gauge-high"></i><span>Keep the file <strong>light</strong> so the Teams page loads quickly.</span></li>
                        <li><i class="fa-solid fa-copyright"></i><span>Only use logos you have the <strong>right to use</strong>.</span></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- ================= 11. ADMIN TIPS ================= -->
        <div class="section-block">
            <h3 class="section-title">💡 Admin Tips</h3>
            <div class="grid-3">
                <div class="panel"><div class="tip-row"><div class="tip-num">1</div><div><p class="tip-title">Add a logo for every team</p><p class="tip-desc">Teams with logos look better on match cards and the points table.</p></div></div></div>
                <div class="panel"><div class="tip-row"><div class="tip-num">2</div><div><p class="tip-title">Keep owner and coach updated</p><p class="tip-desc">Accurate details make approvals and scheduling smoother.</p></div></div></div>
                <div class="panel"><div class="tip-row"><div class="tip-num">3</div><div><p class="tip-title">Think before you delete</p><p class="tip-desc">Deleting a team can remove its players and match history. This cannot be undone.</p></div></div></div>
            </div>
        </div>

        <!-- ================= NEW: DATA SAFETY ================= -->
        <div class="section-block">
            <h3 class="section-title">🔒 Data Safety &amp; Access</h3>
            <div class="grid-3">
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-user-lock"></i></div><h5>Role-Based Access</h5><p>Only admins can add, edit or delete teams. Regular users can only view them.</p></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-amber); border-color: var(--tc-amber); background: rgba(255,165,0,0.10);"><i class="fa-solid fa-triangle-exclamation"></i></div><h5>Confirm Before Delete</h5><p>Every delete action asks for confirmation, so nothing is removed by accident.</p></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-green); border-color: var(--tc-green); background: rgba(0,255,136,0.10);"><i class="fa-solid fa-database"></i></div><h5>Consistent Records</h5><p>All changes are saved to the database and shown the same way on every page.</p></div>
            </div>
        </div>

        <!-- ================= NEW: ADMIN FAQ ================= -->
        <div class="section-block">
            <h3 class="section-title">❓ Admin FAQ</h3>
            <details class="faq-item"><summary>How do I add a new team?</summary><div class="faq-body">Click the <strong>New Team</strong> button at the top of this page, fill in the team details and save. The team will appear in the list right away.</div></details>
            <details class="faq-item"><summary>How do I change a team's logo or details?</summary><div class="faq-body">Click <strong>Edit</strong> on the team card, update the fields you need (including the logo link) and save your changes.</div></details>
            <details class="faq-item"><summary>What happens when I delete a team?</summary><div class="faq-body">The team is removed from the directory. Its players and match records may also be affected, so double-check before you confirm. This cannot be undone.</div></details>
            <details class="faq-item"><summary>I cannot see a team in the list. Why?</summary><div class="faq-body">The search box filters teams by name and city. Clear the search box to see every team again. If you use pages, also check the next page.</div></details>
        </div>

        <!-- ================= 12. HELP CTA ================= -->
        <div class="help-cta">
            <div>
                <h3>🚀 Need Help Managing Teams?</h3>
                <p>Chat with the support assistant for quick guidance on adding teams, editing players and match scheduling.</p>
            </div>
            <button type="button" class="btn-help" onclick="var b=document.querySelector('.chatbot-toggle, .chatbot-btn'); if(b){b.click();}"><i class="fa-solid fa-comment-dots"></i> Chat With Support</button>
        </div>

    </div>

    <jsp:include page="footer.jsp" />
    <jsp:include page="chatbot.jsp" />

    <script>
        /* ---------- Animated title (words never break in the middle) ---------- */
        (function () {
            var titleEl = document.getElementById('animatedTitle');
            if (!titleEl) return;
            var idx = 0;
            var words = titleEl.textContent.trim().split(/\s+/);
            titleEl.innerHTML = words.map(function (w) {
                var letters = w.split('').map(function (ch) {
                    return '<span class="ch" style="--i:' + (idx++) + '">' + ch + '</span>';
                }).join('');
                idx++;
                return '<span class="word">' + letters + '</span>';
            }).join(' ');
        })();

        (function () {
            var cards = Array.prototype.slice.call(document.querySelectorAll('#teamsGrid .team-card'));
            var teams = cards.map(function (c) {
                return {
                    id: parseInt(c.getAttribute('data-id'), 10) || 0,
                    name: (c.getAttribute('data-name') || '').trim(),
                    city: (c.getAttribute('data-city') || '').trim(),
                    coach: (c.getAttribute('data-coach') || '').trim(),
                    owner: (c.getAttribute('data-owner') || '').trim(),
                    logo: (c.getAttribute('data-logo') || '').trim()
                };
            });

            function el(tag, cls, text) {
                var e = document.createElement(tag);
                if (cls) e.className = cls;
                if (text !== undefined) e.textContent = text;
                return e;
            }
            function emptyMsg(box, msg) { box.appendChild(el('p', 'panel-empty', msg)); }
            function avatar(t) {
                var a = el('div', 'list-avatar');
                if (t.logo) {
                    var img = document.createElement('img');
                    img.src = t.logo; img.alt = t.name;
                    a.appendChild(img);
                } else {
                    a.textContent = (t.name.charAt(0) || '?').toUpperCase();
                }
                return a;
            }

            /* ----- League overview ----- */
            var cityMap = {};
            teams.forEach(function (t) {
                var key = t.city.toLowerCase();
                if (key) {
                    if (!cityMap[key]) cityMap[key] = { label: t.city, count: 0 };
                    cityMap[key].count++;
                }
            });
            var cityList = Object.keys(cityMap).map(function (k) { return cityMap[k]; })
                .sort(function (a, b) { return b.count - a.count; });

            /* ----- Teams by city ----- */
            var cityBox = document.getElementById('cityBars');
            if (!cityList.length) {
                emptyMsg(cityBox, 'No city data yet.');
            } else {
                var colors = ['var(--tc-cyan)', 'var(--tc-green)', 'var(--tc-rose)', 'var(--tc-amber)', 'var(--tc-purple)', 'var(--tc-gold)'];
                var max = cityList[0].count;
                cityList.slice(0, 6).forEach(function (c, i) {
                    var row = el('div', 'bar-row');
                    var label = el('div', 'bar-label');
                    label.appendChild(el('span', '', c.label));
                    var num = el('span', '', c.count + (c.count === 1 ? ' team' : ' teams'));
                    num.style.color = colors[i % colors.length];
                    label.appendChild(num);
                    var track = el('div', 'bar-track');
                    var fill = el('div', 'bar-fill');
                    fill.style.width = Math.max(8, Math.round((c.count / max) * 100)) + '%';
                    fill.style.background = colors[i % colors.length];
                    track.appendChild(fill);
                    row.appendChild(label);
                    row.appendChild(track);
                    cityBox.appendChild(row);
                });
            }

            /* ----- Recently added ----- */
            var recentBox = document.getElementById('recentList');
            var recent = teams.slice().sort(function (a, b) { return b.id - a.id; }).slice(0, 4);
            if (!recent.length) {
                emptyMsg(recentBox, 'No teams added yet.');
            } else {
                recent.forEach(function (t) {
                    var row = el('div', 'list-row');
                    row.appendChild(avatar(t));
                    var main = el('div', 'list-main');
                    main.appendChild(el('p', 'list-name', t.name));
                    main.appendChild(el('p', 'list-sub', (t.city || 'City not set') + ' • Owner: ' + (t.owner || '—')));
                    row.appendChild(main);
                    row.appendChild(el('span', 'list-sub', '#TEAM-' + t.id));
                    recentBox.appendChild(row);
                });
            }

            /* ----- Needs attention ----- */
            var attBox = document.getElementById('attentionList');
            var incomplete = teams.map(function (t) {
                var missing = [];
                if (!t.logo) missing.push('Logo');
                if (!t.coach) missing.push('Coach');
                if (!t.owner) missing.push('Owner');
                return { t: t, missing: missing };
            }).filter(function (x) { return x.missing.length; });

            if (!teams.length) {
                emptyMsg(attBox, 'Add a team to see profile checks here.');
            } else if (!incomplete.length) {
                emptyMsg(attBox, '✅ All teams have a logo, coach and owner. Great job!');
            } else {
                incomplete.slice(0, 5).forEach(function (x) {
                    var row = el('div', 'list-row');
                    row.appendChild(avatar(x.t));
                    var main = el('div', 'list-main');
                    main.appendChild(el('p', 'list-name', x.t.name));
                    var tags = el('div', 'tags');
                    x.missing.forEach(function (m) { tags.appendChild(el('span', 'tag', 'Missing ' + m)); });
                    main.appendChild(tags);
                    row.appendChild(main);
                    var link = el('a', 'mini-link', 'Fix');
                    link.href = '/admin/editTeam/' + x.t.id;
                    row.appendChild(link);
                    attBox.appendChild(row);
                });
                if (incomplete.length > 5) {
                    var more = el('p', 'panel-empty', '+ ' + (incomplete.length - 5) + ' more team(s) need updates.');
                    more.style.marginTop = '12px';
                    attBox.appendChild(more);
                }
            }

            /* ----- Live search (name or city) ----- */
            var search = document.getElementById('teamSearch');
            var noResults = document.getElementById('noResults');
            var badge = document.getElementById('totalBadge');
            var originalTotal = badge.textContent;

            search.addEventListener('input', function () {
                var q = search.value.trim().toLowerCase();
                var visible = 0;
                cards.forEach(function (c, i) {
                    var t = teams[i];
                    var match = !q || t.name.toLowerCase().indexOf(q) > -1 || t.city.toLowerCase().indexOf(q) > -1;
                    c.style.display = match ? '' : 'none';
                    if (match) visible++;
                });
                noResults.style.display = (teams.length && !visible) ? '' : 'none';
                badge.textContent = q ? visible : originalTotal;
            });
        })();
    </script>
</body>
</html>
