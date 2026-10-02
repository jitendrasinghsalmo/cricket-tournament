<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>ProMatch Arena | Tournament Command Center</title>
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

        /* ================= 2. STATS STRIP (NEW) ================= */
        .stats-strip { display: grid; grid-template-columns: repeat(4, 1fr); gap: 18px; margin: 40px 0 0; }
        .stat-box {
            background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 16px; padding: 18px 20px;
            display: flex; align-items: center; gap: 14px; transition: all 0.3s ease;
        }
        .stat-box:hover { transform: translateY(-4px); border-color: var(--tc-cyan); box-shadow: 0 12px 30px rgba(0, 217, 255, 0.18); }
        .stat-ico { width: 46px; height: 46px; border-radius: 13px; display: flex; align-items: center; justify-content: center; font-size: 19px; flex-shrink: 0; }
        .stat-num { font-size: 26px; font-weight: 900; line-height: 1; }
        .stat-lbl { font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.6px; color: var(--tc-muted); margin-top: 5px; }

        /* ================= 3. CONTROL BAR ================= */
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
        .filter-group { display: flex; gap: 8px; flex-wrap: wrap; }
        .filter-btn {
            height: 38px; padding: 0 16px; border-radius: 20px; border: 1.5px solid var(--tc-border); background: var(--tc-card-alt);
            color: var(--tc-muted); font-size: 11.5px; font-weight: 800; text-transform: uppercase; cursor: pointer; transition: all 0.2s; font-family: inherit;
        }
        .filter-btn:hover { border-color: var(--tc-cyan); color: var(--tc-cyan); }
        .filter-btn.active { background: var(--tc-cyan); border-color: var(--tc-cyan); color: #030712; }
        html[data-theme="light"] .filter-btn.active { color: #fff; }
        .stats-badge {
            font-size: 13px; font-weight: 700; color: var(--tc-muted); background: var(--tc-card-alt);
            padding: 10px 16px; border-radius: 10px; border: 1px solid var(--tc-border); white-space: nowrap;
        }
        .stats-badge span { color: var(--tc-gold); font-weight: 800; }

        /* ================= 4. TOURNAMENT CARDS (NEW STYLE) ================= */
        .cups-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 24px; margin: 0 auto 10px; }
        .cup-card {
            background: var(--tc-card); border-radius: 22px; border: 1.5px solid var(--tc-border);
            box-shadow: 0 10px 30px rgba(0,0,0,0.25); position: relative; overflow: hidden;
            transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1); display: flex; flex-direction: column;
            padding: 18px 18px 18px 22px; gap: 16px;
        }
        /* coloured left edge changes with status */
        .cup-card::before {
            content: ''; position: absolute; top: 0; left: 0; width: 6px; height: 100%;
            background: linear-gradient(180deg, var(--tc-cyan), var(--tc-green));
        }
        .cup-card.st-live::before { background: linear-gradient(180deg, var(--tc-green), var(--tc-cyan)); }
        .cup-card.st-upcoming::before { background: linear-gradient(180deg, var(--tc-cyan), var(--tc-purple)); }
        .cup-card.st-completed::before { background: linear-gradient(180deg, var(--tc-muted), var(--tc-border)); }
        .cup-card::after {
            content: '\f091'; font-family: 'Font Awesome 6 Free'; font-weight: 900;
            position: absolute; right: -14px; bottom: -22px; font-size: 120px; color: var(--tc-gold); opacity: 0.05; pointer-events: none; transform: rotate(-12deg);
        }
        .cup-card:hover { transform: translateY(-7px) rotate(-0.4deg); border-color: var(--tc-cyan); box-shadow: 0 22px 45px rgba(0, 217, 255, 0.22); }

        .cup-top { display: flex; justify-content: space-between; align-items: center; }
        .cup-id-badge {
            font-size: 10px; font-weight: 800; color: var(--tc-muted); background: var(--tc-card-alt);
            padding: 4px 11px; border-radius: 8px; border: 1.5px dashed var(--tc-border); letter-spacing: 0.5px;
        }
        .status-pill {
            font-size: 10px; font-weight: 800; padding: 4px 11px; border-radius: 20px; text-transform: uppercase; letter-spacing: 0.5px;
            display: none; align-items: center; gap: 6px; background: var(--tc-card-alt);
        }
        .status-pill.show { display: inline-flex; }
        .status-pill::before { content: ''; width: 6px; height: 6px; border-radius: 50%; background: currentColor; }
        .status-pill.live { color: var(--tc-green); border: 1.5px solid var(--tc-green); }
        .status-pill.live::before { animation: pulseDot 1.2s infinite; }
        .status-pill.upcoming { color: var(--tc-cyan); border: 1.5px solid var(--tc-cyan); }
        .status-pill.completed { color: var(--tc-muted); border: 1.5px solid var(--tc-muted); }
        @keyframes pulseDot { 0%,100% { opacity: 1; } 50% { opacity: 0.3; } }

        .cup-main { display: flex; align-items: center; gap: 16px; }
        .date-block {
            width: 74px; flex-shrink: 0; text-align: center; border-radius: 16px; overflow: hidden;
            border: 1.5px solid var(--tc-border); background: var(--tc-card-alt);
        }
        .date-block .d-mon { display: block; background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712; font-size: 11px; font-weight: 900; text-transform: uppercase; padding: 5px 0; letter-spacing: 1px; }
        .date-block .d-day { display: block; font-size: 28px; font-weight: 900; padding: 6px 0 0; line-height: 1.1; }
        .date-block .d-year { display: block; font-size: 10.5px; font-weight: 700; color: var(--tc-muted); padding: 0 0 7px; }
        .cup-info { flex: 1; min-width: 0; }
        .cup-name { font-size: 18px; font-weight: 900; letter-spacing: 0.4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; margin: 0; }
        .cup-season { font-size: 12.5px; font-weight: 700; color: var(--tc-cyan); margin-top: 4px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .cup-range { font-size: 11.5px; font-weight: 700; color: var(--tc-muted); margin-top: 6px; }
        .cup-range i { color: var(--tc-gold); margin-right: 5px; }

        .progress-wrap { display: flex; flex-direction: column; gap: 7px; }
        .progress-meta { display: flex; justify-content: space-between; gap: 8px; font-size: 11px; font-weight: 800; color: var(--tc-muted); text-transform: uppercase; letter-spacing: 0.3px; }
        .progress-meta .p-right { color: var(--tc-gold); }
        .progress-track { height: 9px; border-radius: 8px; background: var(--tc-card-alt); border: 1px solid var(--tc-border); overflow: hidden; }
        .progress-fill { height: 100%; width: 0; border-radius: 8px; background: linear-gradient(90deg, var(--tc-cyan), var(--tc-green)); transition: width 0.8s ease; }
        .st-completed .progress-fill { background: linear-gradient(90deg, var(--tc-muted), var(--tc-border)); }
        .st-upcoming .progress-fill { background: linear-gradient(90deg, var(--tc-purple), var(--tc-cyan)); }

        .card-actions { display: grid; grid-template-columns: 1fr 1fr; gap: 10px; margin-top: auto; position: relative; z-index: 1; }
        .card-actions a {
            height: 38px; text-decoration: none; border-radius: 10px; font-size: 11px; font-weight: 800;
            display: inline-flex; align-items: center; justify-content: center; gap: 7px;
            transition: all 0.2s ease; text-transform: uppercase; letter-spacing: 0.4px; white-space: nowrap;
        }
        .btn-edit { background: rgba(0, 217, 255, 0.15); color: var(--tc-cyan); border: 1.5px solid var(--tc-cyan); }
        .btn-edit:hover { background: var(--tc-cyan); color: #030712; box-shadow: 0 0 15px rgba(0, 217, 255, 0.4); }
        .btn-delete { background: rgba(255, 0, 110, 0.15); color: var(--tc-rose); border: 1.5px solid var(--tc-rose); }
        .btn-delete:hover { background: var(--tc-rose); color: #fff; box-shadow: 0 0 15px rgba(255, 0, 110, 0.4); }
        html[data-theme="light"] .btn-edit:hover { color: #fff; }

        .no-team {
            text-align: center; color: var(--tc-muted); grid-column: 1 / -1; padding: 50px 20px; font-size: 14px; font-weight: 700;
            background: var(--tc-card); border: 1px dashed var(--tc-border); border-radius: 16px; text-transform: uppercase;
        }

        /* ================= 5. PAGINATION ================= */
        .pagination-bar { display: flex; justify-content: flex-end; align-items: center; gap: 16px; margin: 34px 0 0; padding: 4px 0; flex-wrap: wrap; }
        .pagination-bar a, .pagination-bar .disabled {
            height: 40px; padding: 0 20px; border-radius: 10px; text-decoration: none; font-weight: 800; font-size: 12px; text-transform: uppercase;
            display: inline-flex; align-items: center;
        }
        .pagination-bar a { background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712; transition: all 0.2s; }
        .pagination-bar a:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(0, 217, 255, 0.5); }
        .pagination-bar .disabled { opacity: 0.35; cursor: not-allowed; background: rgba(148, 163, 184, 0.1); color: var(--tc-muted); }
        .page-indicator { font-size: 13px; font-weight: 700; color: var(--tc-muted); padding: 0 15px; border-left: 2px solid var(--tc-border); border-right: 2px solid var(--tc-border); }

        /* ================= SHARED SECTIONS ================= */
        .section-block { margin: 44px auto 0; }
        .section-title {
            font-size: 18px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.2px;
            margin: 0 0 22px; display: flex; align-items: center; gap: 12px; flex-wrap: wrap;
        }
        .section-title::before { content: ''; width: 4px; height: 24px; flex-shrink: 0; background: linear-gradient(180deg, var(--tc-cyan), var(--tc-green)); border-radius: 2px; }
        .section-title small { margin-left: auto; font-size: 11.5px; font-weight: 700; color: var(--tc-muted); text-transform: none; letter-spacing: 0.3px; }

        .grid-2 { display: grid; grid-template-columns: repeat(2, 1fr); gap: 24px; }
        .grid-3 { display: grid; grid-template-columns: repeat(3, 1fr); gap: 22px; }
        .grid-4 { display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px; }
        .panel { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 18px; padding: 24px; box-shadow: 0 10px 30px rgba(0,0,0,0.2); }
        .panel h3 { margin: 0 0 18px; font-size: 15px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.6px; display: flex; align-items: center; gap: 9px; }
        .panel-empty { font-size: 13px; color: var(--tc-muted); margin: 0; }

        .bar-row { margin-bottom: 15px; }
        .bar-row:last-child { margin-bottom: 0; }
        .bar-label { display: flex; justify-content: space-between; gap: 10px; font-size: 12.5px; font-weight: 700; margin-bottom: 6px; }
        .bar-label span:first-child { overflow: hidden; text-overflow: ellipsis; white-space: nowrap; }
        .bar-track { height: 10px; border-radius: 8px; background: var(--tc-card-alt); border: 1px solid var(--tc-border); overflow: hidden; }
        .bar-fill { height: 100%; border-radius: 8px; transition: width 0.6s ease; }

        .list-row { display: flex; align-items: center; gap: 12px; padding: 12px 0; border-bottom: 1px solid var(--tc-border); }
        .list-row:last-child { border-bottom: none; padding-bottom: 0; }
        .list-row:first-child { padding-top: 0; }
        .list-avatar {
            width: 40px; height: 40px; border-radius: 12px; flex-shrink: 0;
            background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712;
            display: flex; align-items: center; justify-content: center; font-size: 15px;
        }
        .list-main { flex: 1; min-width: 0; }
        .list-name { margin: 0; font-size: 13.5px; font-weight: 800; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .list-sub { margin: 2px 0 0; font-size: 11.5px; color: var(--tc-muted); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .tags { display: flex; gap: 5px; flex-wrap: wrap; margin-top: 6px; }
        .tag {
            font-size: 10px; font-weight: 800; padding: 3px 9px; border-radius: 20px; text-transform: uppercase; white-space: nowrap;
            color: var(--tc-amber); background: rgba(255, 165, 0, 0.14); border: 1px solid rgba(255, 165, 0, 0.35);
        }
        .mini-tag { font-size: 10px; font-weight: 800; padding: 4px 10px; border-radius: 20px; text-transform: uppercase; white-space: nowrap; flex-shrink: 0; }
        .mini-tag.live { color: var(--tc-green); background: rgba(0,255,136,0.12); border: 1px solid rgba(0,255,136,0.4); }
        .mini-tag.upcoming { color: var(--tc-cyan); background: rgba(0,217,255,0.12); border: 1px solid rgba(0,217,255,0.4); }
        .mini-tag.completed { color: var(--tc-muted); background: rgba(148,163,184,0.12); border: 1px solid rgba(148,163,184,0.4); }
        .mini-link {
            font-size: 11px; font-weight: 800; color: var(--tc-cyan); text-decoration: none; white-space: nowrap;
            border: 1.5px solid var(--tc-cyan); padding: 6px 12px; border-radius: 8px; transition: all 0.2s; text-transform: uppercase;
        }
        .mini-link:hover { background: var(--tc-cyan); color: #030712; }

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
        .feature-card .meta { display: inline-block; margin-top: 12px; font-size: 10.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.5px; color: var(--tc-gold); }

        /* ---------- NEW: Spotlight ---------- */
        .spotlight {
            border-radius: 22px; padding: 32px; border: 2px solid var(--tc-cyan);
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.16), rgba(181, 55, 242, 0.12)), var(--tc-card);
            box-shadow: 0 20px 45px rgba(0, 217, 255, 0.15);
            display: flex; align-items: center; justify-content: space-between; gap: 28px; flex-wrap: wrap;
        }
        .spot-kicker { font-size: 11px; font-weight: 800; text-transform: uppercase; letter-spacing: 1.4px; color: var(--tc-green); margin-bottom: 8px; }
        .spot-name { margin: 0 0 6px; font-size: clamp(20px, 5vw, 30px); font-weight: 900; text-transform: uppercase; }
        .spot-sub { margin: 0; font-size: 13.5px; font-weight: 600; color: var(--tc-muted); }
        .spot-count { display: flex; gap: 12px; }
        .count-box { min-width: 78px; text-align: center; background: var(--tc-card-alt); border: 1.5px solid var(--tc-border); border-radius: 14px; padding: 14px 10px; }
        .count-box b { display: block; font-size: 28px; font-weight: 900; color: var(--tc-cyan); line-height: 1; }
        .count-box span { display: block; margin-top: 6px; font-size: 10px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.6px; color: var(--tc-muted); }

        /* ---------- NEW: Month calendar ---------- */
        .month-grid { display: grid; grid-template-columns: repeat(6, 1fr); gap: 14px; }
        .month-cell { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 14px; padding: 16px 10px; text-align: center; transition: all 0.25s; }
        .month-cell:hover { border-color: var(--tc-cyan); transform: translateY(-4px); }
        .month-cell .m-name { font-size: 12px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.8px; color: var(--tc-muted); }
        .month-cell .m-num { font-size: 26px; font-weight: 900; margin-top: 6px; color: var(--tc-muted); }
        .month-cell .m-sub { font-size: 10px; font-weight: 700; color: var(--tc-muted); margin-top: 2px; text-transform: uppercase; }
        .month-cell.has { border-color: rgba(0, 217, 255, 0.5); }
        .month-cell.has .m-num { color: var(--tc-cyan); }
        .month-cell.now { background: linear-gradient(135deg, rgba(0,217,255,0.16), rgba(0,255,136,0.12)), var(--tc-card); border-color: var(--tc-green); }
        .month-cell.now .m-name { color: var(--tc-green); }

        /* ---------- Formats / lifecycle / rules ---------- */
        .steps-wrap { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 20px; padding: 30px; }
        .step-box { background: var(--tc-card-alt); border: 1.5px solid var(--tc-border); border-radius: 14px; padding: 20px; text-align: center; transition: all 0.3s ease; }
        .step-box:hover { transform: translateY(-4px); border-color: var(--tc-cyan); }
        .step-num {
            width: 36px; height: 36px; margin: 0 auto 12px; border-radius: 50%; background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green));
            color: #030712; display: flex; align-items: center; justify-content: center; font-weight: 900; font-size: 14px; box-shadow: 0 0 15px rgba(0, 217, 255, 0.4);
        }
        .step-box h5 { margin: 0 0 6px; font-size: 13.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.4px; }
        .step-box p { margin: 0; font-size: 12px; color: var(--tc-muted); line-height: 1.5; }

        .check-list { list-style: none; margin: 0; padding: 0; display: flex; flex-direction: column; gap: 13px; }
        .check-list li { display: flex; align-items: flex-start; gap: 11px; font-size: 13px; line-height: 1.5; color: var(--tc-muted); font-weight: 600; }
        .check-list li strong { color: var(--tc-text); font-weight: 800; }
        .check-list li i { width: 22px; height: 22px; flex-shrink: 0; margin-top: 1px; border-radius: 7px; display: flex; align-items: center; justify-content: center; font-size: 11px; background: rgba(0,255,136,0.14); color: var(--tc-green); border: 1px solid rgba(0,255,136,0.35); }
        .check-list.info li i { background: rgba(0,217,255,0.12); color: var(--tc-cyan); border-color: rgba(0,217,255,0.35); }

        .points-table { width: 100%; border-collapse: collapse; font-size: 13px; }
        .points-table th { text-align: left; font-size: 10.5px; text-transform: uppercase; letter-spacing: 0.6px; color: var(--tc-muted); padding: 0 0 10px; }
        .points-table td { padding: 12px 0; border-top: 1px solid var(--tc-border); font-weight: 600; color: var(--tc-muted); }
        .points-table td:first-child { color: var(--tc-text); font-weight: 800; }
        .points-table td:last-child { text-align: right; color: var(--tc-gold); font-weight: 900; font-size: 15px; }
        .points-table th:last-child { text-align: right; }

        .faq-item { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 14px; margin-bottom: 12px; transition: border-color 0.25s; overflow: hidden; }
        .faq-item:hover, .faq-item[open] { border-color: var(--tc-cyan); }
        .faq-item summary { cursor: pointer; padding: 16px 20px; font-size: 14px; font-weight: 800; list-style: none; display: flex; justify-content: space-between; align-items: center; gap: 14px; }
        .faq-item summary::-webkit-details-marker { display: none; }
        .faq-item summary::after { content: '+'; color: var(--tc-cyan); font-size: 22px; font-weight: 700; line-height: 1; flex-shrink: 0; }
        .faq-item[open] summary::after { content: '\2212'; }
        .faq-body { padding: 0 20px 18px; font-size: 13px; color: var(--tc-muted); line-height: 1.7; font-weight: 500; }


        /* ---------- NEW: Records ---------- */
        .record-card { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 18px; padding: 22px; position: relative; overflow: hidden; transition: all 0.3s ease; }
        .record-card::before { content: ''; position: absolute; inset: 0 0 auto 0; height: 4px; background: var(--rc, var(--tc-cyan)); }
        .record-card:hover { transform: translateY(-6px); border-color: var(--rc, var(--tc-cyan)); box-shadow: 0 16px 38px rgba(0, 217, 255, 0.18); }
        .record-card .r-label { font-size: 10.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.8px; color: var(--tc-muted); display: flex; align-items: center; gap: 8px; }
        .record-card .r-label i { color: var(--rc, var(--tc-cyan)); font-size: 14px; }
        .record-card .r-value { margin: 14px 0 4px; font-size: 30px; font-weight: 900; color: var(--rc, var(--tc-cyan)); line-height: 1; }
        .record-card .r-name { font-size: 13.5px; font-weight: 800; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .record-card .r-sub { font-size: 11.5px; font-weight: 600; color: var(--tc-muted); margin-top: 3px; }

        /* ---------- NEW: Roadmap ---------- */
        .roadmap { display: grid; grid-template-columns: repeat(5, 1fr); gap: 18px; position: relative; background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 20px; padding: 34px 24px 28px; }
        .roadmap::before { content: ''; position: absolute; top: 65px; left: 10%; right: 10%; height: 3px; background: linear-gradient(90deg, var(--tc-cyan), var(--tc-gold), var(--tc-green), var(--tc-purple), var(--tc-rose)); opacity: 0.55; border-radius: 2px; }
        .road-step { text-align: center; position: relative; z-index: 1; }
        .road-dot { --rc: var(--tc-cyan); width: 62px; height: 62px; margin: 0 auto 14px; border-radius: 50%; background: var(--tc-card); border: 3px solid var(--rc); color: var(--rc); display: flex; align-items: center; justify-content: center; font-size: 22px; box-shadow: 0 0 22px rgba(0, 217, 255, 0.25); transition: transform 0.3s ease; }
        .road-step:hover .road-dot { transform: scale(1.12) rotate(-6deg); }
        .road-step h5 { margin: 0 0 6px; font-size: 13.5px; font-weight: 800; text-transform: uppercase; letter-spacing: 0.4px; }
        .road-step p { margin: 0; font-size: 12px; color: var(--tc-muted); line-height: 1.55; }

        /* ---------- NEW: Rule cards ---------- */
        .rule-card { background: var(--tc-card); border: 1.5px solid var(--tc-border); border-radius: 18px; padding: 24px; position: relative; transition: all 0.3s ease; }
        .rule-card:hover { transform: translateY(-5px); border-color: var(--tc-cyan); box-shadow: 0 15px 38px rgba(0, 217, 255, 0.18); }
        .rule-tag { --rt: var(--tc-cyan); position: absolute; top: 18px; right: 18px; font-size: 10px; font-weight: 800; text-transform: uppercase; padding: 3px 10px; border-radius: 20px; color: var(--rt); border: 1px solid var(--rt); }
        .rule-ico { --ri: var(--tc-cyan); width: 52px; height: 52px; border-radius: 15px; display: flex; align-items: center; justify-content: center; font-size: 22px; color: var(--ri); border: 1.5px solid var(--ri); margin-bottom: 16px; background: var(--tc-card-alt); }
        .rule-card h5 { margin: 0 0 8px; font-size: 15px; font-weight: 800; text-transform: uppercase; }
        .rule-card p { margin: 0; font-size: 12.5px; color: var(--tc-muted); line-height: 1.6; }


        /* ---------- Help CTA (above footer) ---------- */
        .help-cta {
            margin: 50px auto 10px; border-radius: 22px; padding: 38px 40px;
            background: linear-gradient(135deg, rgba(0, 217, 255, 0.16), rgba(0, 255, 136, 0.1)), var(--tc-card);
            border: 2px solid var(--tc-cyan); box-shadow: 0 20px 45px rgba(0, 217, 255, 0.15);
            display: flex; align-items: center; justify-content: space-between; gap: 24px; flex-wrap: wrap;
        }
        .help-cta h3 { margin: 0 0 8px; font-size: clamp(18px, 4.5vw, 24px); font-weight: 900; text-transform: uppercase; letter-spacing: 1px; }
        .help-cta p { margin: 0; font-size: 14px; color: var(--tc-muted); font-weight: 600; max-width: 560px; line-height: 1.7; }
        .help-btns { display: flex; align-items: center; gap: 14px; flex-wrap: wrap; }
        .btn-help {
            background: linear-gradient(135deg, var(--tc-cyan), var(--tc-green)); color: #030712; border: none; height: 50px; padding: 0 28px;
            border-radius: 14px; font-weight: 900; font-size: 13px; text-transform: uppercase; letter-spacing: 1px; cursor: pointer; text-decoration: none;
            display: inline-flex; align-items: center; justify-content: center; gap: 9px; white-space: nowrap; box-shadow: 0 0 25px rgba(0, 217, 255, 0.45); transition: all 0.3s ease; font-family: inherit;
        }
        .btn-help:hover { transform: scale(1.05); box-shadow: 0 0 35px rgba(0, 255, 136, 0.6); }
        .btn-help-add { background: transparent; color: var(--tc-cyan); border: 2px solid var(--tc-cyan); box-shadow: none; }
        .btn-help-add:hover { background: var(--tc-cyan); color: #030712; box-shadow: 0 0 30px rgba(0, 217, 255, 0.55); }
        html[data-theme="light"] .btn-help-add:hover { color: #fff; }

        /* ================= RESPONSIVE ================= */
        @media (max-width: 1024px) {
            .grid-4, .grid-3, .stats-strip { grid-template-columns: repeat(2, 1fr); }
            .grid-2 { grid-template-columns: 1fr; }
            .month-grid { grid-template-columns: repeat(4, 1fr); }
            .roadmap { grid-template-columns: repeat(2, 1fr); }
            .roadmap::before { display: none; }
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
            .cups-grid { grid-template-columns: 1fr; }
            .grid-3, .grid-4 { grid-template-columns: 1fr; }
            .stats-strip { grid-template-columns: 1fr 1fr; gap: 12px; }
            .month-grid { grid-template-columns: repeat(3, 1fr); }
            .roadmap { grid-template-columns: 1fr; }
            .help-cta { padding: 26px 20px; flex-direction: column; text-align: center; }
            .help-btns { width: 100%; flex-direction: column; }
            .btn-help { width: 100%; }
            .steps-wrap { padding: 20px 16px; }
            .spotlight { padding: 24px 18px; }
            .spot-count { width: 100%; justify-content: space-between; }
            .count-box { flex: 1; min-width: 0; }
            .pagination-bar { justify-content: center; }
            .section-title small { margin-left: 0; width: 100%; }
        }

        /* ================= FOOTER (same as other pages) ================= */
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

    <!-- ===== INCLUDE 1: NAVBAR ===== -->
    <jsp:include page="navbar.jsp" />

    <div class="main-content-wrap">

        <!-- ================= 1. HEADER BAR ================= -->
        <div class="header-bar">
            <div class="header-left"><span class="admin-chip"><i class="fa-solid fa-user-shield"></i> Admin Control</span></div>
            <h2 class="jumping-title" id="animatedTitle">Tournament Command Center</h2>
            <div class="header-right">
                <a href="/admin/addTournamentPage" class="btn-top-add"><i class="fa-solid fa-plus"></i> New Tournament</a>
                <c:if test="${not empty tournaments}">
                    <a href="/admin/deleteAllTournaments" class="btn-delete-all" onclick="return confirm('WARNING: Are you sure you want to delete all tournaments?');"><i class="fa-solid fa-trash-can"></i> Delete All</a>
                </c:if>
            </div>
        </div>

        <!-- ================= 3. CONTROL BAR ================= -->
        <div class="control-bar">
            <input type="text" id="cupSearch" class="search-input" placeholder="🔍 Search tournament by name or season..." autocomplete="off">
            <div class="filter-group" id="filterGroup">
                <button type="button" class="filter-btn active" data-filter="all">All</button>
                <button type="button" class="filter-btn" data-filter="live">Live</button>
                <button type="button" class="filter-btn" data-filter="upcoming">Upcoming</button>
                <button type="button" class="filter-btn" data-filter="completed">Completed</button>
            </div>
            <div class="stats-badge">Showing: <span id="totalBadge">${empty totalItems ? (empty tournaments ? 0 : tournaments.size()) : totalItems}</span></div>
        </div>

        <!-- ================= 4. TOURNAMENTS GRID (NEW CARD STYLE) ================= -->
        <div class="cups-grid" id="cupsGrid">
            <c:forEach items="${tournaments}" var="t">
                <div class="cup-card"
                     data-id="<c:out value='${t.id}'/>"
                     data-name="<c:out value='${t.tournamentName}'/>"
                     data-season="<c:out value='${t.season}'/>"
                     data-start="<c:out value='${t.startDate}'/>"
                     data-end="<c:out value='${t.endDate}'/>">

                    <div class="cup-top">
                        <span class="cup-id-badge">#PTC-${t.id}</span>
                        <span class="status-pill"></span>
                    </div>

                    <div class="cup-main">
                        <div class="date-block">
                            <span class="d-mon">---</span>
                            <span class="d-day">--</span>
                            <span class="d-year"></span>
                        </div>
                        <div class="cup-info">
                            <h3 class="cup-name" title="<c:out value='${t.tournamentName}'/>"><c:out value="${t.tournamentName}"/></h3>
                            <div class="cup-season">🏏 Season <c:out value="${t.season}"/></div>
                            <div class="cup-range"><i class="fa-regular fa-calendar"></i><c:out value="${t.startDate}"/> → <c:out value="${t.endDate}"/></div>
                        </div>
                    </div>

                    <div class="progress-wrap">
                        <div class="progress-meta"><span class="p-left"></span><span class="p-right"></span></div>
                        <div class="progress-track"><div class="progress-fill"></div></div>
                    </div>

                    <div class="card-actions">
                        <a href="/admin/editTournament/${t.id}" class="btn-edit"><i class="fa-solid fa-pen-to-square"></i> Edit Cup</a>
                        <a href="/admin/deleteTournament/${t.id}" class="btn-delete" onclick="return confirm('Are you sure you want to delete this tournament?');"><i class="fa-solid fa-trash"></i> Delete</a>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty tournaments}">
                <div class="no-team">🏆 No tournaments yet. Click "New Tournament" to create the first one.</div>
            </c:if>
            <div class="no-team" id="noResults" style="display:none;">🔍 No tournaments match your search.</div>
        </div>

        <!-- ================= PAGINATION (only if controller sends totalPages) ================= -->
        <c:if test="${not empty totalPages and totalPages > 1}">
            <div class="pagination-bar">
                <c:choose>
                    <c:when test="${currentPage > 0}">
                        <a href="${pageContext.request.contextPath}/admin/tournaments?page=${currentPage - 1}">⬅ Previous</a>
                    </c:when>
                    <c:otherwise><span class="disabled">⬅ Previous</span></c:otherwise>
                </c:choose>

                <span class="page-indicator">Page ${currentPage + 1} of ${totalPages}</span>

                <c:choose>
                    <c:when test="${currentPage + 1 < totalPages}">
                        <a href="${pageContext.request.contextPath}/admin/tournaments?page=${currentPage + 1}">Next ➡</a>
                    </c:when>
                    <c:otherwise><span class="disabled">Next ➡</span></c:otherwise>
                </c:choose>
            </div>
        </c:if>

        <!-- ================= 2. LIVE STATS STRIP ================= -->
        <div class="stats-strip">
            <div class="stat-box">
                <div class="stat-ico" style="background: rgba(255,215,0,0.12); color: var(--tc-gold);"><i class="fa-solid fa-trophy"></i></div>
                <div><div class="stat-num" id="stTotal">0</div><div class="stat-lbl">Total Cups</div></div>
            </div>
            <div class="stat-box">
                <div class="stat-ico" style="background: rgba(0,255,136,0.12); color: var(--tc-green);"><i class="fa-solid fa-circle-play"></i></div>
                <div><div class="stat-num" id="stLive">0</div><div class="stat-lbl">Live Now</div></div>
            </div>
            <div class="stat-box">
                <div class="stat-ico" style="background: rgba(0,217,255,0.12); color: var(--tc-cyan);"><i class="fa-solid fa-hourglass-start"></i></div>
                <div><div class="stat-num" id="stUpcoming">0</div><div class="stat-lbl">Upcoming</div></div>
            </div>
            <div class="stat-box">
                <div class="stat-ico" style="background: rgba(181,55,242,0.12); color: var(--tc-purple);"><i class="fa-solid fa-flag-checkered"></i></div>
                <div><div class="stat-num" id="stDone">0</div><div class="stat-lbl">Completed</div></div>
            </div>
        </div>


        <!-- ================= NEW A: TOURNAMENT RECORDS (from your data) ================= -->
        <div class="section-block">
            <h3 class="section-title">🏆 Tournament Records <small>Highlights from your tournaments</small></h3>
            <div class="grid-4" id="recordsGrid"></div>
        </div>

        <!-- ================= NEW B: TOURNAMENT JOURNEY ROADMAP ================= -->
        <div class="section-block">
            <h3 class="section-title">🛣️ Tournament Journey <small>From registration to the grand final</small></h3>
            <div class="roadmap">
                <div class="road-step"><div class="road-dot"><i class="fa-solid fa-pen-nib"></i></div><h5>Registration</h5><p>Teams sign up and submit their squads before the deadline.</p></div>
                <div class="road-step"><div class="road-dot" style="--rc: var(--tc-gold);"><i class="fa-solid fa-gavel"></i></div><h5>Player Draft</h5><p>Captains pick players so every team is balanced and fair.</p></div>
                <div class="road-step"><div class="road-dot" style="--rc: var(--tc-green);"><i class="fa-solid fa-people-group"></i></div><h5>Group Stage</h5><p>Teams play their league matches and collect points.</p></div>
                <div class="road-step"><div class="road-dot" style="--rc: var(--tc-purple);"><i class="fa-solid fa-fire"></i></div><h5>Playoffs</h5><p>Top teams fight in Qualifier and Eliminator matches.</p></div>
                <div class="road-step"><div class="road-dot" style="--rc: var(--tc-rose);"><i class="fa-solid fa-crown"></i></div><h5>Grand Final</h5><p>Two best teams meet and the champion lifts the trophy.</p></div>
            </div>
        </div>

        <!-- ================= NEW C: MATCH RULES & FAIR PLAY ================= -->
        <div class="section-block">
            <h3 class="section-title">📜 Match Rules &amp; Fair Play <small>Rules every tournament should follow</small></h3>
            <div class="grid-3">
                <div class="rule-card"><span class="rule-tag">Batting</span><div class="rule-ico"><i class="fa-solid fa-gauge-high"></i></div><h5>Powerplay Overs</h5><p>First 6 overs have only two fielders outside the circle, so batters can attack.</p></div>
                <div class="rule-card"><span class="rule-tag" style="--rt: var(--tc-green);">Review</span><div class="rule-ico" style="--ri: var(--tc-green);"><i class="fa-solid fa-video"></i></div><h5>Decision Review</h5><p>Each team gets limited reviews per innings to challenge the umpire's call.</p></div>
                <div class="rule-card"><span class="rule-tag" style="--rt: var(--tc-gold);">Tie</span><div class="rule-ico" style="--ri: var(--tc-gold);"><i class="fa-solid fa-bolt"></i></div><h5>Super Over</h5><p>If scores are level, one extra over per team decides the winner.</p></div>
                <div class="rule-card"><span class="rule-tag" style="--rt: var(--tc-purple);">Weather</span><div class="rule-ico" style="--ri: var(--tc-purple);"><i class="fa-solid fa-cloud-rain"></i></div><h5>Rain Rule (DLS)</h5><p>When rain cuts play, a revised target keeps the match fair for both teams.</p></div>
                <div class="rule-card"><span class="rule-tag" style="--rt: var(--tc-rose);">Discipline</span><div class="rule-ico" style="--ri: var(--tc-rose);"><i class="fa-solid fa-hand"></i></div><h5>Code Of Conduct</h5><p>Fair play is compulsory. Bad behaviour can lead to fines or match bans.</p></div>
                <div class="rule-card"><span class="rule-tag" style="--rt: var(--tc-amber);">Pace</span><div class="rule-ico" style="--ri: var(--tc-amber);"><i class="fa-solid fa-stopwatch"></i></div><h5>Over Rate</h5><p>Each innings must finish on time, or the team faces a slow over-rate penalty.</p></div>
            </div>
        </div>

        <!-- ================= 5. NEW: TOURNAMENT SPOTLIGHT + COUNTDOWN ================= -->
        <div class="section-block">
            <h3 class="section-title">🔥 Tournament Spotlight <small>Live now or starting next</small></h3>
            <div id="spotlightBox"></div>
        </div>

        <!-- ================= 6. NEW: MONTH-WISE TOURNAMENT CALENDAR ================= -->
        <div class="section-block">
            <h3 class="section-title">🗓️ Tournament Calendar <small id="calYearLabel">This year</small></h3>
            <div class="month-grid" id="monthGrid"></div>
        </div>

        <!-- ================= 7. TIMELINE + SEASONS ================= -->
        <div class="section-block">
            <h3 class="section-title">📅 Tournament Timeline &amp; Seasons <small>Built from your tournament list</small></h3>
            <div class="grid-2">
                <div class="panel">
                    <h3><i class="fa-solid fa-timeline" style="color: var(--tc-cyan);"></i> Upcoming &amp; Recent Cups</h3>
                    <div id="timelineList"></div>
                </div>
                <div class="panel">
                    <h3><i class="fa-solid fa-layer-group" style="color: var(--tc-gold);"></i> Tournaments By Season</h3>
                    <div id="seasonBars"></div>
                </div>
            </div>
        </div>

        <!-- ================= 8. NEEDS ATTENTION ================= -->
        <div class="section-block">
            <h3 class="section-title">⚠️ Tournament Health Check <small>Missing or invalid details</small></h3>
            <div class="panel"><div id="attentionList"></div></div>
        </div>

        <!-- ================= 9. TOURNAMENT FORMATS ================= -->
        <div class="section-block">
            <h3 class="section-title">🏏 Choose Your Tournament Format</h3>
            <div class="grid-4">
                <div class="feature-card"><div class="feature-icon"><i class="fa-solid fa-bolt"></i></div><h5>T20 League</h5><p>20 overs a side, quick matches and big hitting. Perfect for a full tournament in a few weeks.</p><span class="meta">≈ 3 hrs / match</span></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-green); border-color: var(--tc-green); background: rgba(0,255,136,0.10);"><i class="fa-solid fa-hourglass-half"></i></div><h5>One-Day Cup</h5><p>50 overs of planning, partnerships and consistent bowling. A classic and balanced format.</p><span class="meta">≈ 7 hrs / match</span></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-rose); border-color: var(--tc-rose); background: rgba(255,0,110,0.10);"><i class="fa-solid fa-sitemap"></i></div><h5>Knockout</h5><p>Lose once and you are out. Every match feels like a final and the schedule stays short.</p><span class="meta">Fewest matches</span></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-purple); border-color: var(--tc-purple); background: rgba(181,55,242,0.10);"><i class="fa-solid fa-arrows-rotate"></i></div><h5>Round Robin + Playoffs</h5><p>Every team meets every other team, then the top sides fight through the playoffs.</p><span class="meta">Fairest format</span></div>
            </div>
        </div>

        <!-- ================= 10. LIFECYCLE ================= -->
        <div class="section-block">
            <div class="steps-wrap">
                <h3 class="section-title">🔄 Tournament Lifecycle</h3>
                <div class="grid-4">
                    <div class="step-box"><div class="step-num">1</div><h5>Plan</h5><p>Create the tournament with its name, season and dates</p></div>
                    <div class="step-box"><div class="step-num">2</div><h5>Add Teams</h5><p>Register and approve the franchises taking part</p></div>
                    <div class="step-box"><div class="step-num">3</div><h5>Schedule</h5><p>Set up fixtures within the tournament dates</p></div>
                    <div class="step-box"><div class="step-num">4</div><h5>Publish Results</h5><p>Update scores so the points table stays accurate</p></div>
                </div>
            </div>
        </div>

        <!-- ================= 11. NEW: POINTS & QUALIFICATION RULES ================= -->
        <div class="section-block">
            <h3 class="section-title">📊 Points &amp; Qualification Rules <small>How teams reach the playoffs</small></h3>
            <div class="grid-2">
                <div class="panel">
                    <h3><i class="fa-solid fa-ranking-star" style="color: var(--tc-gold);"></i> Standard Points System</h3>
                    <table class="points-table">
                        <thead><tr><th>Match Result</th><th>Points</th></tr></thead>
                        <tbody>
                            <tr><td>Win</td><td>+2</td></tr>
                            <tr><td>Tie / Super Over</td><td>+1</td></tr>
                            <tr><td>No Result (rain)</td><td>+1</td></tr>
                            <tr><td>Loss</td><td>0</td></tr>
                        </tbody>
                    </table>
                </div>
                <div class="panel">
                    <h3><i class="fa-solid fa-medal" style="color: var(--tc-cyan);"></i> Tie-Break Order</h3>
                    <ul class="check-list info">
                        <li><i class="fa-solid fa-1"></i><span><strong>Most wins</strong> decides first when points are equal.</span></li>
                        <li><i class="fa-solid fa-2"></i><span><strong>Net Run Rate (NRR)</strong> is checked next.</span></li>
                        <li><i class="fa-solid fa-3"></i><span><strong>Head-to-head</strong> result between the two teams comes after that.</span></li>
                        <li><i class="fa-solid fa-4"></i><span><strong>Top 4 teams</strong> qualify for the playoffs in a league format.</span></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- ================= 12. NEW: AWARDS & TROPHIES ================= -->
        <div class="section-block">
            <h3 class="section-title">🏅 Tournament Awards <small>Recognise the best performers</small></h3>
            <div class="grid-4">
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-gold); border-color: var(--tc-gold); background: rgba(255,215,0,0.10);"><i class="fa-solid fa-trophy"></i></div><h5>Champions Trophy</h5><p>Awarded to the winning team after the final match of the tournament.</p></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-amber); border-color: var(--tc-amber); background: rgba(255,165,0,0.10);"><i class="fa-solid fa-hat-cowboy"></i></div><h5>Orange Cap</h5><p>Given to the batter with the most runs across the whole tournament.</p></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-purple); border-color: var(--tc-purple); background: rgba(181,55,242,0.10);"><i class="fa-solid fa-hat-wizard"></i></div><h5>Purple Cap</h5><p>Given to the bowler with the most wickets across the whole tournament.</p></div>
                <div class="feature-card"><div class="feature-icon" style="color: var(--tc-green); border-color: var(--tc-green); background: rgba(0,255,136,0.10);"><i class="fa-solid fa-star"></i></div><h5>Player Of The Series</h5><p>Chosen for the most valuable all-round impact during the tournament.</p></div>
            </div>
        </div>

        <!-- ================= 13. SETUP CHECKLIST + SCHEDULING TIPS ================= -->
        <div class="section-block">
            <h3 class="section-title">✅ Before You Publish</h3>
            <div class="grid-2">
                <div class="panel">
                    <h3><i class="fa-solid fa-clipboard-check" style="color: var(--tc-green);"></i> Tournament Setup Checklist</h3>
                    <ul class="check-list">
                        <li><i class="fa-solid fa-check"></i><span><strong>Clear tournament name</strong> that fans can recognise easily.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Season label</strong> so different years never get mixed up.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Correct start date</strong> before the first match is played.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Correct end date</strong> that comes after the start date.</span></li>
                        <li><i class="fa-solid fa-check"></i><span><strong>Enough teams</strong> registered to run the chosen format.</span></li>
                    </ul>
                </div>
                <div class="panel">
                    <h3><i class="fa-solid fa-calendar-check" style="color: var(--tc-cyan);"></i> Match Scheduling Tips</h3>
                    <ul class="check-list info">
                        <li><i class="fa-solid fa-calendar-days"></i><span>Keep <strong>rest days</strong> between matches for the same team.</span></li>
                        <li><i class="fa-solid fa-cloud-sun"></i><span>Plan a <strong>reserve day</strong> in case of rain or bad light.</span></li>
                        <li><i class="fa-solid fa-flag-checkered"></i><span>Fix the <strong>final date</strong> early so fans can plan ahead.</span></li>
                        <li><i class="fa-solid fa-pen-to-square"></i><span>Use <strong>Edit Cup</strong> if the dates change, and tell the teams.</span></li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- ================= 14. TOURNAMENT FAQ ================= -->
        <div class="section-block">
            <h3 class="section-title">❓ Tournament FAQ</h3>
            <details class="faq-item"><summary>How do I create a new tournament?</summary><div class="faq-body">Click the <strong>New Tournament</strong> button at the top, enter the name, season and dates, then save. It will appear in the list straight away.</div></details>
            <details class="faq-item"><summary>How do I change the dates of a tournament?</summary><div class="faq-body">Click <strong>Edit Cup</strong> on the tournament card, update the start or end date and save. The status label (Upcoming, Live or Completed) updates automatically.</div></details>
            <details class="faq-item"><summary>How is Upcoming, Live or Completed decided?</summary><div class="faq-body">It is worked out from today's date. Before the start date it is <strong>Upcoming</strong>, between the start and end dates it is <strong>Live</strong>, and after the end date it is <strong>Completed</strong>.</div></details>
            <details class="faq-item"><summary>What happens when I delete a tournament?</summary><div class="faq-body">The tournament is removed from the list. Matches and points linked to it may also be affected, so double-check before you confirm. This cannot be undone.</div></details>
        </div>


        <!-- ================= HELP CTA (above footer) ================= -->
        <div class="help-cta">
            <div class="help-text">
                <h3>🚀 Need Help Managing Tournaments?</h3>
                <p>Chat with the support assistant for quick guidance on creating tournaments, scheduling matches and updating standings.</p>
            </div>
            <div class="help-btns">
                <a href="/admin/addTournamentPage" class="btn-help btn-help-add"><i class="fa-solid fa-plus"></i> Add Tournament</a>
                <button type="button" class="btn-help" onclick="var b=document.querySelector('.chatbot-toggle, .chatbot-btn'); if(b){b.click();}"><i class="fa-solid fa-comment-dots"></i> Chat With Support</button>
            </div>
        </div>

    </div>

    <!-- ===== INCLUDE 2: FOOTER ===== -->
    <jsp:include page="footer.jsp" />
    <!-- ===== INCLUDE 3: CHATBOT ===== -->
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
            var cards = Array.prototype.slice.call(document.querySelectorAll('#cupsGrid .cup-card'));
            var MONTHS = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
            var DAY = 86400000;

            function parseDate(s) {
                if (!s) return null;
                s = s.trim();
                var d = /^\d{4}-\d{2}-\d{2}$/.test(s) ? new Date(s + 'T00:00:00') : new Date(s);
                return isNaN(d.getTime()) ? null : d;
            }
            function fmt(d) { return d ? d.getDate() + ' ' + MONTHS[d.getMonth()] + ' ' + d.getFullYear() : '—'; }
            function plural(n, w) { return n + ' ' + w + (n === 1 ? '' : 's'); }
            var today = new Date(); today.setHours(0, 0, 0, 0);

            var cups = cards.map(function (c) {
                var start = parseDate(c.getAttribute('data-start'));
                var end = parseDate(c.getAttribute('data-end'));
                var status = '';
                if (start && end) {
                    if (today < start) status = 'upcoming';
                    else if (today > end) status = 'completed';
                    else status = 'live';
                }
                var days = (start && end && end >= start) ? Math.round((end - start) / DAY) + 1 : null;
                return {
                    id: parseInt(c.getAttribute('data-id'), 10) || 0,
                    name: (c.getAttribute('data-name') || '').trim(),
                    season: (c.getAttribute('data-season') || '').trim(),
                    start: start, end: end, status: status, days: days
                };
            });

            var LABEL = { live: 'Live', upcoming: 'Upcoming', completed: 'Completed' };

            function el(tag, cls, text) {
                var e = document.createElement(tag);
                if (cls) e.className = cls;
                if (text !== undefined) e.textContent = text;
                return e;
            }
            function emptyMsg(box, msg) { box.appendChild(el('p', 'panel-empty', msg)); }

            /* ----- stats strip ----- */
            function count(s) { return cups.filter(function (x) { return x.status === s; }).length; }
            document.getElementById('stTotal').textContent = cups.length;
            document.getElementById('stLive').textContent = count('live');
            document.getElementById('stUpcoming').textContent = count('upcoming');
            document.getElementById('stDone').textContent = count('completed');

            /* ----- card: status, date block, progress ----- */
            cards.forEach(function (c, i) {
                var cup = cups[i];
                var pill = c.querySelector('.status-pill');
                if (cup.status) {
                    c.classList.add('st-' + cup.status);
                    if (pill) { pill.className = 'status-pill show ' + cup.status; pill.textContent = LABEL[cup.status]; }
                }
                if (cup.start) {
                    c.querySelector('.d-mon').textContent = MONTHS[cup.start.getMonth()];
                    c.querySelector('.d-day').textContent = cup.start.getDate();
                    c.querySelector('.d-year').textContent = cup.start.getFullYear();
                }
                var left = c.querySelector('.p-left');
                var right = c.querySelector('.p-right');
                var fill = c.querySelector('.progress-fill');
                var pct = 0;
                if (cup.status === 'upcoming') {
                    left.textContent = 'Not started';
                    right.textContent = 'Starts in ' + plural(Math.round((cup.start - today) / DAY), 'day');
                } else if (cup.status === 'live') {
                    var dayNo = Math.round((today - cup.start) / DAY) + 1;
                    pct = cup.days ? Math.round((dayNo / cup.days) * 100) : 0;
                    left.textContent = 'Day ' + dayNo + ' of ' + (cup.days || '?');
                    right.textContent = pct + '% done';
                } else if (cup.status === 'completed') {
                    pct = 100;
                    left.textContent = plural(cup.days || 0, 'day') + ' long';
                    right.textContent = 'Ended ' + plural(Math.round((today - cup.end) / DAY), 'day') + ' ago';
                } else {
                    left.textContent = 'Dates missing';
                }
                setTimeout(function () { fill.style.width = pct + '%'; }, 150);
            });

            /* ----- Spotlight: live cup first, else next upcoming ----- */
            var spotBox = document.getElementById('spotlightBox');
            var spot = cups.filter(function (x) { return x.status === 'live'; })
                .sort(function (a, b) { return a.end - b.end; })[0];
            var spotMode = 'live';
            if (!spot) {
                spotMode = 'upcoming';
                spot = cups.filter(function (x) { return x.status === 'upcoming'; })
                    .sort(function (a, b) { return a.start - b.start; })[0];
            }
            if (!spot) {
                emptyMsg(spotBox, 'No live or upcoming tournament right now. Create one to see it here.');
            } else {
                var box = el('div', 'spotlight');
                var l = el('div');
                l.appendChild(el('div', 'spot-kicker', spotMode === 'live' ? '● Live right now' : 'Next tournament'));
                l.appendChild(el('h3', 'spot-name', spot.name || 'Untitled tournament'));
                l.appendChild(el('p', 'spot-sub', 'Season ' + (spot.season || '—') + '  •  ' + fmt(spot.start) + '  →  ' + fmt(spot.end)));
                box.appendChild(l);

                var target = spotMode === 'live' ? new Date(spot.end.getTime() + DAY) : spot.start;
                var cnt = el('div', 'spot-count');
                var parts = [['Days', 'cdD'], ['Hours', 'cdH'], ['Mins', 'cdM'], ['Secs', 'cdS']];
                parts.forEach(function (p) {
                    var b = el('div', 'count-box');
                    var n = el('b', '', '0'); n.id = p[1];
                    b.appendChild(n); b.appendChild(el('span', '', p[0]));
                    cnt.appendChild(b);
                });
                box.appendChild(cnt);
                spotBox.appendChild(box);

                function pad(n) { return n < 10 ? '0' + n : '' + n; }
                function tick() {
                    var diff = Math.max(0, target.getTime() - Date.now());
                    document.getElementById('cdD').textContent = Math.floor(diff / DAY);
                    document.getElementById('cdH').textContent = pad(Math.floor(diff % DAY / 3600000));
                    document.getElementById('cdM').textContent = pad(Math.floor(diff % 3600000 / 60000));
                    document.getElementById('cdS').textContent = pad(Math.floor(diff % 60000 / 1000));
                }
                tick();
                setInterval(tick, 1000);
                var cd = el('p', 'panel-empty', spotMode === 'live' ? 'Countdown shows time left until this tournament ends.' : 'Countdown shows time left until the first match day.');
                cd.style.marginTop = '10px';
                spotBox.appendChild(cd);
            }

            /* ----- Records (longest, shortest, latest, next) ----- */
            var recBox = document.getElementById('recordsGrid');
            function addRecord(icon, label, value, name, sub, color) {
                var c = el('div', 'record-card');
                c.style.setProperty('--rc', color);
                var l = el('div', 'r-label'); l.innerHTML = '<i class="' + icon + '"></i>'; l.appendChild(document.createTextNode(label));
                c.appendChild(l);
                c.appendChild(el('div', 'r-value', value));
                c.appendChild(el('div', 'r-name', name || 'Untitled tournament'));
                c.appendChild(el('div', 'r-sub', sub));
                recBox.appendChild(c);
            }
            var withDays = cups.filter(function (x) { return x.days; });
            var longest = withDays.slice().sort(function (a, b) { return b.days - a.days; })[0];
            var shortest = withDays.slice().sort(function (a, b) { return a.days - b.days; })[0];
            var latest = cups.filter(function (x) { return x.start; }).sort(function (a, b) { return b.start - a.start; })[0];
            var nextUp = cups.filter(function (x) { return x.status === 'upcoming'; }).sort(function (a, b) { return a.start - b.start; })[0];
            addRecord('fa-solid fa-hourglass-end', 'Longest Cup', longest ? plural(longest.days, 'day') : '—', longest && longest.name, longest ? 'Season ' + (longest.season || '—') : 'No dates yet', 'var(--tc-gold)');
            addRecord('fa-solid fa-bolt', 'Shortest Cup', shortest ? plural(shortest.days, 'day') : '—', shortest && shortest.name, shortest ? 'Season ' + (shortest.season || '—') : 'No dates yet', 'var(--tc-green)');
            addRecord('fa-solid fa-clock-rotate-left', 'Latest Added Start', latest ? fmt(latest.start) : '—', latest && latest.name, latest ? 'Season ' + (latest.season || '—') : 'No dates yet', 'var(--tc-cyan)');
            addRecord('fa-solid fa-forward', 'Next To Start', nextUp ? plural(Math.round((nextUp.start - today) / DAY), 'day') : '—', nextUp && nextUp.name, nextUp ? 'Starts ' + fmt(nextUp.start) : 'No upcoming cup', 'var(--tc-purple)');

            /* ----- Month calendar (current year) ----- */
            var year = today.getFullYear();
            document.getElementById('calYearLabel').textContent = 'Cups running in ' + year;
            var mGrid = document.getElementById('monthGrid');
            for (var m = 0; m < 12; m++) {
                var mStart = new Date(year, m, 1);
                var mEnd = new Date(year, m + 1, 0);
                var n = cups.filter(function (x) { return x.start && x.end && x.start <= mEnd && x.end >= mStart; }).length;
                var cell = el('div', 'month-cell' + (n ? ' has' : '') + (m === today.getMonth() ? ' now' : ''));
                cell.appendChild(el('div', 'm-name', MONTHS[m]));
                cell.appendChild(el('div', 'm-num', String(n)));
                cell.appendChild(el('div', 'm-sub', n === 1 ? 'tournament' : 'tournaments'));
                mGrid.appendChild(cell);
            }

            /* ----- Timeline (newest start first, max 5) ----- */
            var tlBox = document.getElementById('timelineList');
            var dated = cups.filter(function (x) { return x.start; })
                .sort(function (a, b) { return b.start - a.start; });
            if (!dated.length) {
                emptyMsg(tlBox, 'No tournament dates yet. Add a tournament to see the timeline.');
            } else {
                dated.slice(0, 5).forEach(function (x) {
                    var row = el('div', 'list-row');
                    var av = el('div', 'list-avatar'); av.innerHTML = '<i class="fa-solid fa-trophy"></i>';
                    row.appendChild(av);
                    var main = el('div', 'list-main');
                    main.appendChild(el('p', 'list-name', x.name || 'Untitled tournament'));
                    main.appendChild(el('p', 'list-sub', fmt(x.start) + '  →  ' + fmt(x.end)));
                    row.appendChild(main);
                    if (x.status) row.appendChild(el('span', 'mini-tag ' + x.status, LABEL[x.status]));
                    tlBox.appendChild(row);
                });
                if (dated.length > 5) {
                    var more = el('p', 'panel-empty', '+ ' + (dated.length - 5) + ' more tournament(s) in the list above.');
                    more.style.marginTop = '12px';
                    tlBox.appendChild(more);
                }
            }

            /* ----- By season ----- */
            var seasonMap = {};
            cups.forEach(function (x) {
                var key = x.season.toLowerCase();
                if (key) {
                    if (!seasonMap[key]) seasonMap[key] = { label: x.season, count: 0 };
                    seasonMap[key].count++;
                }
            });
            var seasonList = Object.keys(seasonMap).map(function (k) { return seasonMap[k]; })
                .sort(function (a, b) { return b.count - a.count; });
            var sBox = document.getElementById('seasonBars');
            if (!seasonList.length) {
                emptyMsg(sBox, 'No season data yet.');
            } else {
                var colors = ['var(--tc-cyan)', 'var(--tc-green)', 'var(--tc-gold)', 'var(--tc-rose)', 'var(--tc-purple)', 'var(--tc-amber)'];
                var max = seasonList[0].count;
                seasonList.slice(0, 6).forEach(function (s, i) {
                    var row = el('div', 'bar-row');
                    var label = el('div', 'bar-label');
                    label.appendChild(el('span', '', 'Season ' + s.label));
                    var num = el('span', '', s.count + (s.count === 1 ? ' cup' : ' cups'));
                    num.style.color = colors[i % colors.length];
                    label.appendChild(num);
                    var track = el('div', 'bar-track');
                    var fill = el('div', 'bar-fill');
                    fill.style.width = Math.max(8, Math.round((s.count / max) * 100)) + '%';
                    fill.style.background = colors[i % colors.length];
                    track.appendChild(fill);
                    row.appendChild(label);
                    row.appendChild(track);
                    sBox.appendChild(row);
                });
            }

            /* ----- Health check / needs attention ----- */
            var attBox = document.getElementById('attentionList');
            var issues = cups.map(function (x) {
                var list = [];
                if (!x.name) list.push('Name');
                if (!x.season) list.push('Season');
                if (!x.start) list.push('Start date');
                if (!x.end) list.push('End date');
                if (x.start && x.end && x.end < x.start) list.push('End is before start');
                return { x: x, list: list };
            }).filter(function (r) { return r.list.length; });

            if (!cups.length) {
                emptyMsg(attBox, 'Add a tournament to see checks here.');
            } else if (!issues.length) {
                emptyMsg(attBox, '✅ Every tournament has a name, season and valid dates. Great job!');
            } else {
                issues.slice(0, 5).forEach(function (r) {
                    var row = el('div', 'list-row');
                    var av = el('div', 'list-avatar'); av.innerHTML = '<i class="fa-solid fa-trophy"></i>';
                    row.appendChild(av);
                    var main = el('div', 'list-main');
                    main.appendChild(el('p', 'list-name', r.x.name || 'Untitled tournament'));
                    var tags = el('div', 'tags');
                    r.list.forEach(function (mm) { tags.appendChild(el('span', 'tag', mm.indexOf('before') > -1 ? mm : 'Missing ' + mm)); });
                    main.appendChild(tags);
                    row.appendChild(main);
                    var link = el('a', 'mini-link', 'Fix');
                    link.href = '/admin/editTournament/' + r.x.id;
                    row.appendChild(link);
                    attBox.appendChild(row);
                });
                if (issues.length > 5) {
                    var more2 = el('p', 'panel-empty', '+ ' + (issues.length - 5) + ' more tournament(s) need updates.');
                    more2.style.marginTop = '12px';
                    attBox.appendChild(more2);
                }
            }

            /* ----- Live search + status filter ----- */
            var search = document.getElementById('cupSearch');
            var noResults = document.getElementById('noResults');
            var badge = document.getElementById('totalBadge');
            var filterBtns = Array.prototype.slice.call(document.querySelectorAll('#filterGroup .filter-btn'));
            var activeFilter = 'all';

            function applyFilters() {
                var q = search.value.trim().toLowerCase();
                var visible = 0;
                cards.forEach(function (c, i) {
                    var x = cups[i];
                    var textOk = !q || x.name.toLowerCase().indexOf(q) > -1 || x.season.toLowerCase().indexOf(q) > -1;
                    var statusOk = activeFilter === 'all' || x.status === activeFilter;
                    var show = textOk && statusOk;
                    c.style.display = show ? '' : 'none';
                    if (show) visible++;
                });
                noResults.style.display = (cups.length && !visible) ? '' : 'none';
                badge.textContent = visible;
            }
            search.addEventListener('input', applyFilters);
            filterBtns.forEach(function (b) {
                b.addEventListener('click', function () {
                    filterBtns.forEach(function (o) { o.classList.remove('active'); });
                    b.classList.add('active');
                    activeFilter = b.getAttribute('data-filter');
                    applyFilters();
                });
            });
        })();
    </script>
</body>
</html>
