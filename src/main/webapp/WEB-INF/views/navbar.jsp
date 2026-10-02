<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- Role check: Role enum = ADMIN / USER -->
<c:set var="isAdmin" value="${sessionScope.user.role == 'ADMIN'}" />

<!-- Theme apply (runs immediately, no flash) -->
<script>
    (function () {
        try {
            if (localStorage.getItem('promatch_theme') === 'light') {
                document.documentElement.setAttribute('data-theme', 'light');
            }
        } catch (e) {}
    })();
</script>
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">

<style>
    /* ===== Fallback color variables (same as home) ===== */
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

    /* =====================================================
       NAVBAR - fully isolated (all rules start with #pmNav)
       so no page CSS can break it
       ===================================================== */
    #pmNav, #pmNav * { box-sizing: border-box !important; }
    #pmNav {
        font-family: 'Inter', system-ui, -apple-system, 'Segoe UI', sans-serif !important;
        background: rgba(13, 18, 30, 0.9) !important;
        backdrop-filter: blur(20px);
        -webkit-backdrop-filter: blur(20px);
        border: none !important;
        border-bottom: 1px solid var(--border-color) !important;
        box-shadow: none;
        height: 64px !important;
        min-height: 64px !important;
        width: 100% !important;
        margin: 0 !important;
        padding: 0 35px !important;
        display: flex !important;
        flex-direction: row !important;
        flex-wrap: nowrap !important;
        justify-content: space-between !important;
        align-items: center !important;
        position: sticky !important;
        top: 0 !important;
        z-index: 1000 !important;
        transition: box-shadow 0.3s ease, background 0.3s ease;
        line-height: 1.5;
        text-transform: none !important;
        letter-spacing: normal !important;
    }
    #pmNav.scrolled { box-shadow: 0 10px 30px rgba(0,0,0,0.5) !important; background: rgba(3, 7, 18, 0.96) !important; }

    #pmNav .pm-left { display: flex !important; align-items: center !important; gap: 30px !important; flex-wrap: nowrap !important; }
    #pmNav .pm-right { display: flex !important; align-items: center !important; gap: 14px !important; flex-wrap: nowrap !important; position: relative; }

    /* Logo */
    #pmNav .pm-logo { display: flex !important; align-items: center !important; gap: 10px !important; text-decoration: none !important; flex-shrink: 0; white-space: nowrap !important; }
    #pmNav .pm-logo-icon {
        background: var(--accent-blue) !important; color: #030712 !important; width: 32px !important; height: 32px !important;
        border-radius: 8px !important; display: flex !important; align-items: center !important; justify-content: center !important;
        font-weight: 900 !important; font-size: 16px !important; box-shadow: 0 0 12px rgba(56,189,248,0.4) !important; flex-shrink: 0;
    }
    #pmNav .pm-logo-text { font-weight: 800 !important; font-size: 17px !important; color: var(--text-main) !important; letter-spacing: 0.5px !important; line-height: 1.5 !important; white-space: nowrap !important; text-transform: none !important; }
    #pmNav .pm-logo-text span { display: block !important; font-size: 9px !important; color: var(--accent-blue) !important; letter-spacing: 1.5px !important; text-transform: uppercase !important; line-height: 1.5 !important; font-weight: 800 !important; }

    /* Links (plain text - no box, no uppercase) */
    #pmNav .pm-links { list-style: none !important; margin: 0 !important; padding: 0 !important; display: flex !important; flex-wrap: nowrap !important; gap: 22px !important; align-items: center !important; }
    #pmNav .pm-links li { list-style: none !important; margin: 0 !important; padding: 0 !important; display: block !important; }
    #pmNav .pm-links a {
        color: var(--text-muted) !important; text-decoration: none !important; font-size: 13.5px !important; font-weight: 600 !important;
        text-transform: none !important; letter-spacing: normal !important; white-space: nowrap !important; line-height: 1.5 !important;
        background: none !important; border: none !important; box-shadow: none !important; border-radius: 0 !important;
        padding: 0 !important; margin: 0 !important; display: inline !important; transition: color 0.2s;
    }
    #pmNav .pm-links a:hover, #pmNav .pm-links a.active {
        color: var(--accent-blue) !important; text-shadow: 0 0 10px rgba(56,189,248,0.4) !important;
        background: none !important; box-shadow: none !important; border: none !important;
    }

    /* Search */
    #pmNav .pm-search { display: flex !important; align-items: center !important; gap: 6px !important; background: rgba(3,7,18,0.6) !important; border: 1px solid var(--border-color) !important; border-radius: 20px !important; padding: 4px 12px !important; margin: 0 !important; height: auto !important; }
    #pmNav .pm-search input { background: transparent !important; border: none !important; box-shadow: none !important; color: var(--text-main) !important; font-size: 12px !important; outline: none !important; width: 140px !important; height: auto !important; padding: 4px 0 !important; margin: 0 !important; font-family: inherit !important; }
    #pmNav .pm-search input::placeholder { color: var(--text-muted) !important; opacity: 1; }
    #pmNav .pm-search button { background: none !important; border: none !important; box-shadow: none !important; color: var(--accent-blue) !important; cursor: pointer; font-size: 12px !important; padding: 0 !important; margin: 0 !important; width: auto !important; height: auto !important; }

    /* Theme toggle + mobile menu button (same round style) */
    #pmNav .pm-theme-btn,
    #pmNav .pm-menu-btn {
        display: flex !important; align-items: center !important; justify-content: center !important;
        width: 36px !important; height: 36px !important; border-radius: 50% !important;
        background: rgba(3,7,18,0.6) !important; border: 1px solid var(--border-color) !important;
        color: var(--accent-blue) !important; cursor: pointer; font-size: 14px !important; padding: 0 !important; margin: 0 !important;
        flex-shrink: 0; transition: all 0.25s;
    }
    #pmNav .pm-theme-btn:hover,
    #pmNav .pm-menu-btn:hover { border-color: var(--accent-blue) !important; transform: translateY(-2px); box-shadow: 0 0 14px rgba(56,189,248,0.35); }
    #pmNav .pm-theme-btn .fa-sun { display: none; }
    html[data-theme="light"] #pmNav .pm-theme-btn .fa-sun { display: inline-block !important; color: var(--accent-amber) !important; }
    html[data-theme="light"] #pmNav .pm-theme-btn .fa-moon { display: none !important; }

    /* Hamburger: only on mobile */
    #pmNav .pm-menu-btn { display: none !important; }

    /* Profile pill */
    #pmNav .pm-profile { position: relative !important; display: inline-block !important; }
    #pmNav .pm-pill {
        display: flex !important; align-items: center !important; gap: 8px !important; background: rgba(3,7,18,0.6) !important;
        border: 1px solid var(--border-color) !important; padding: 5px 14px 5px 6px !important; border-radius: 22px !important; cursor: pointer;
        transition: all 0.2s; white-space: nowrap !important; margin: 0 !important;
    }
    #pmNav .pm-pill:hover { border-color: var(--accent-blue) !important; }
    #pmNav .pm-avatar {
        width: 32px !important; height: 32px !important; min-width: 32px !important; background: var(--accent-blue) !important; color: #030712 !important;
        border-radius: 50% !important; display: flex !important; align-items: center !important; justify-content: center !important;
        font-size: 12px !important; font-weight: 700 !important; overflow: hidden !important; text-transform: uppercase;
    }
    #pmNav .pm-avatar img, #pmNav .pm-photo-big img { width: 100% !important; height: 100% !important; object-fit: cover !important; border-radius: 50% !important; display: block !important; margin: 0 !important; padding: 0 !important; max-width: none !important; }
    #pmNav .pm-username { font-size: 12.5px !important; font-weight: 600 !important; color: var(--text-main) !important; white-space: nowrap !important; line-height: 1.5 !important; }
    #pmNav .pm-caret { font-size: 10px !important; color: var(--text-muted) !important; line-height: 1 !important; transition: transform 0.2s; }
    #pmNav .pm-profile.open .pm-caret { transform: rotate(180deg); }

    /* Dropdown - compact size */
    #pmNav .pm-dropdown {
        display: none; position: absolute !important; right: 0 !important; top: calc(100% + 12px) !important; width: 220px !important;
        background: #0e121c !important; border: 1px solid var(--border-color) !important; border-radius: 14px !important;
        box-shadow: 0 18px 36px rgba(0,0,0,0.6) !important; z-index: 1100; overflow: hidden !important; padding: 0 !important;
    }
    #pmNav .pm-dropdown.show { display: block !important; animation: pmDrop 0.2s ease; }
    @keyframes pmDrop { from { opacity: 0; transform: translateY(-6px); } to { opacity: 1; transform: translateY(0); } }

    /* ----- Header: photo + name + email + role (compact) ----- */
    #pmNav .pm-dd-head {
        padding: 16px 14px 14px 14px !important; text-align: center !important; position: relative;
        background: linear-gradient(135deg, rgba(56,189,248,0.16), rgba(16,185,129,0.08)) !important;
        border-bottom: 1px solid var(--border-color) !important;
        overflow: hidden;
    }
    #pmNav .pm-dd-head::before {
        content: ''; position: absolute; top: -50%; right: -20%; width: 65%; height: 170%;
        background: radial-gradient(circle, rgba(56,189,248,0.16) 0%, transparent 70%); pointer-events: none;
    }

    #pmNav .pm-photo-wrap { position: relative !important; width: 56px !important; height: 56px !important; margin: 0 auto 10px auto !important; z-index: 2; }
    #pmNav .pm-photo-big {
        width: 56px !important; height: 56px !important; border-radius: 50% !important; background: var(--accent-blue) !important; color: #030712 !important;
        display: flex !important; align-items: center !important; justify-content: center !important; font-size: 20px !important; font-weight: 900 !important;
        overflow: hidden !important; border: 2.5px solid rgba(56,189,248,0.6) !important; box-shadow: 0 0 16px rgba(56,189,248,0.4) !important; text-transform: uppercase;
    }

    /* Change photo: single click -> file picker directly (no clipped popup) */
    #pmNav .pm-photo-edit-btn {
        position: absolute !important; bottom: -2px !important; right: -2px !important; width: 21px !important; height: 21px !important; border-radius: 50% !important;
        background: var(--accent-blue) !important; color: #030712 !important; border: 2px solid #0e121c !important; cursor: pointer;
        display: flex !important; align-items: center !important; justify-content: center !important; font-size: 9px !important;
        padding: 0 !important; margin: 0 !important; transition: all 0.2s; line-height: 1 !important; z-index: 4;
    }
    #pmNav .pm-photo-edit-btn:hover { transform: scale(1.12); box-shadow: 0 0 10px rgba(56,189,248,0.65); }

    /* Remove photo: small separate icon, top-left, shown only when a photo is set */
    #pmNav .pm-photo-remove-btn {
        position: absolute !important; top: -3px !important; left: -3px !important; width: 18px !important; height: 18px !important; border-radius: 50% !important;
        background: var(--accent-red) !important; color: #fff !important; border: 2px solid #0e121c !important; cursor: pointer;
        display: none; align-items: center !important; justify-content: center !important; font-size: 8px !important;
        padding: 0 !important; margin: 0 !important; transition: all 0.2s; line-height: 1 !important; z-index: 4;
    }
    #pmNav .pm-photo-remove-btn.visible { display: flex !important; }
    #pmNav .pm-photo-remove-btn:hover { transform: scale(1.12); box-shadow: 0 0 9px rgba(244,63,94,0.65); }

    #pmNav .pm-dd-name { font-size: 12.5px !important; font-weight: 800 !important; color: var(--text-main) !important; margin: 0 0 3px 0 !important; line-height: 1.35 !important; position: relative; z-index: 2; }
    #pmNav .pm-dd-email { font-size: 9.5px !important; color: var(--text-muted) !important; margin: 0 0 8px 0 !important; word-break: break-all; line-height: 1.4 !important; position: relative; z-index: 2; }
    #pmNav .pm-role {
        display: inline-flex !important; align-items: center !important; gap: 4px !important; font-size: 8.5px !important; font-weight: 800 !important; letter-spacing: 0.6px !important;
        text-transform: uppercase !important; color: var(--accent-green) !important; background: rgba(16,185,129,0.15) !important;
        border: 1px solid rgba(16,185,129,0.4) !important; padding: 2px 9px !important; border-radius: 20px !important; position: relative; z-index: 2;
    }

    /* ----- Menu body (compact) ----- */
    #pmNav .pm-dd-body { padding: 8px !important; }
    #pmNav .pm-item {
        display: flex !important; align-items: center !important; gap: 8px !important; width: 100% !important; padding: 8px 9px !important; margin: 0 0 4px 0 !important;
        border-radius: 9px !important; font-size: 11px !important; font-weight: 600 !important; color: var(--text-main) !important; text-decoration: none !important;
        background: rgba(255,255,255,0.02) !important; border: 1px solid transparent !important; cursor: pointer; transition: all 0.2s; text-align: left !important; line-height: 1.4 !important;
        font-family: inherit !important; text-transform: none !important;
    }
    #pmNav .pm-item:last-child { margin-bottom: 0 !important; }
    #pmNav .pm-item:hover { background: rgba(56,189,248,0.12) !important; border-color: rgba(56,189,248,0.25) !important; }
    #pmNav .pm-item .pm-ico {
        width: 22px !important; height: 22px !important; border-radius: 7px !important; flex-shrink: 0;
        display: flex !important; align-items: center !important; justify-content: center !important; font-size: 10px !important;
        background: rgba(56,189,248,0.15) !important; color: var(--accent-blue) !important;
    }
    #pmNav .pm-item .pm-txt { flex: 1; }
    #pmNav .pm-item .pm-chevron { font-size: 9px !important; color: var(--text-muted) !important; }
    #pmNav .pm-dd-divider { height: 1px !important; background: var(--border-color) !important; margin: 6px 2px !important; }
    #pmNav .pm-item.pm-logout { color: var(--accent-red) !important; }
    #pmNav .pm-item.pm-logout .pm-ico { background: rgba(244,63,94,0.15) !important; color: var(--accent-red) !important; }
    #pmNav .pm-item.pm-logout:hover { background: rgba(244,63,94,0.12) !important; border-color: rgba(244,63,94,0.3) !important; }

    /* Responsive */
    @media (max-width: 1100px) {
        #pmNav .pm-links { gap: 16px !important; }
        #pmNav .pm-left { gap: 20px !important; }
    }
    @media (max-width: 767px) {
        #pmNav { padding: 0 16px !important; }
        #pmNav .pm-search input { width: 90px !important; }
        #pmNav .pm-left { gap: 12px !important; }

        /* Hamburger shows, links become a dropdown panel under the navbar */
        #pmNav .pm-menu-btn { display: flex !important; }
        #pmNav .pm-links {
            display: none !important;
            position: absolute !important; top: 100% !important; left: 0 !important; right: 0 !important;
            flex-direction: column !important; align-items: stretch !important; gap: 4px !important;
            background: rgba(13, 18, 30, 0.98) !important;
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color) !important;
            box-shadow: 0 20px 35px rgba(0,0,0,0.55) !important;
            padding: 10px 16px 14px 16px !important;
            max-height: calc(100vh - 64px); overflow-y: auto;
        }
        #pmNav .pm-links.open { display: flex !important; animation: pmDrop 0.2s ease; }
        #pmNav .pm-links a {
            display: block !important; padding: 12px 14px !important; border-radius: 10px !important;
            font-size: 14px !important; width: 100% !important;
        }
        #pmNav .pm-links a:hover, #pmNav .pm-links a.active {
            background: rgba(56,189,248,0.12) !important; text-shadow: none !important;
        }
    }
    @media (max-width: 575px) {
        #pmNav .pm-username { display: none !important; }
        #pmNav .pm-logo-text span { display: none !important; }
        #pmNav .pm-pill { padding: 5px 10px 5px 6px !important; }
        #pmNav .pm-dropdown { width: 210px !important; right: -8px !important; }
        #pmNav .pm-right { gap: 8px !important; }
    }
    @media (max-width: 480px) {
        #pmNav .pm-search input { width: 64px !important; }
        #pmNav .pm-search { padding: 4px 10px !important; }
    }
    @media (max-width: 390px) {
        #pmNav .pm-logo-text { display: none !important; }
    }

    /* ===== LIGHT THEME ===== */
    html[data-theme="light"] {
        --bg-main: #f1f5f9;
        --bg-card: rgba(255, 255, 255, 0.95);
        --bg-card-hover: #ffffff;
        --text-main: #0f172a;
        --text-muted: #475569;
        --border-color: rgba(2, 132, 199, 0.28);
        --border-glass: rgba(2, 132, 199, 0.3);
        --text-primary: #0f172a;
        --text-secondary: #334155;
        --neon-cyan: #0284c7;
    }
    html[data-theme="light"] body { background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%) !important; color: #0f172a; }
    html[data-theme="light"] #pmNav { background: rgba(255,255,255,0.92) !important; }
    html[data-theme="light"] #pmNav.scrolled { background: rgba(255,255,255,0.98) !important; box-shadow: 0 10px 30px rgba(15,23,42,0.12) !important; }
    html[data-theme="light"] #pmNav .pm-search,
    html[data-theme="light"] #pmNav .pm-pill,
    html[data-theme="light"] #pmNav .pm-theme-btn,
    html[data-theme="light"] #pmNav .pm-menu-btn { background: rgba(255,255,255,0.9) !important; }
    html[data-theme="light"] #pmNav .pm-dropdown { background: #ffffff !important; box-shadow: 0 18px 36px rgba(15,23,42,0.2) !important; }
    html[data-theme="light"] #pmNav .pm-item { background: rgba(15,23,42,0.03) !important; }
    html[data-theme="light"] #pmNav .pm-photo-edit-btn,
    html[data-theme="light"] #pmNav .pm-photo-remove-btn { border-color: #ffffff !important; }
    @media (max-width: 767px) {
        html[data-theme="light"] #pmNav .pm-links { background: rgba(255,255,255,0.98) !important; box-shadow: 0 20px 35px rgba(15,23,42,0.15) !important; }
    }
    html[data-theme="light"] .hero-banner { background: linear-gradient(135deg, #ffffff 0%, #e0f2fe 100%) !important; }
    html[data-theme="light"] .hero-content h1 { color: #0f172a !important; text-shadow: none !important; }
    html[data-theme="light"] .about-card,
    html[data-theme="light"] .quick-nav-item,
    html[data-theme="light"] .get-app-section,
    html[data-theme="light"] .chat-window,
    html[data-theme="light"] .video-modal-content { background: #ffffff !important; }
    html[data-theme="light"] .store-badge,
    html[data-theme="light"] .chat-footer { background: #f1f5f9 !important; }
    html[data-theme="light"] .chat-footer input,
    html[data-theme="light"] .footer-newsletter input { background: #ffffff !important; color: #0f172a !important; }
    html[data-theme="light"] .grand-footer-section { background: linear-gradient(135deg, #ffffff, #e2e8f0) !important; }
    html[data-theme="light"] .team-row { color: #f8fafc; }
</style>

<style>
    /* ===== RESPONSIVE ADD-ON (original rules untouched) ===== */
    html, body { max-width: 100%; overflow-x: clip; }

    /* Small laptops / landscape tablets: compact so nothing overflows */
    @media (min-width: 1024px) and (max-width: 1199px) {
        #pmNav { padding: 0 20px !important; }
        #pmNav .pm-left { gap: 16px !important; }
        #pmNav .pm-links { gap: 14px !important; }
        #pmNav .pm-right { gap: 10px !important; }
        #pmNav .pm-search input { width: 110px !important; }
    }

    /* Tablet + phone: hamburger menu (was only up to 767px) */
    @media (max-width: 1023px) {
        #pmNav { padding: 0 20px !important; }
        #pmNav .pm-left { gap: 12px !important; flex-shrink: 0; }
        #pmNav .pm-menu-btn { display: flex !important; }
        #pmNav .pm-links {
            display: none !important;
            position: absolute !important; top: 100% !important; left: 0 !important; right: 0 !important;
            flex-direction: column !important; align-items: stretch !important; gap: 4px !important;
            background: rgba(13, 18, 30, 0.98) !important;
            backdrop-filter: blur(20px); -webkit-backdrop-filter: blur(20px);
            border-bottom: 1px solid var(--border-color) !important;
            box-shadow: 0 20px 35px rgba(0,0,0,0.55) !important;
            padding: 10px 16px 14px 16px !important;
            max-height: calc(100vh - 64px); overflow-y: auto;
        }
        #pmNav .pm-links.open { display: flex !important; animation: pmDrop 0.2s ease; }
        #pmNav .pm-links a {
            display: block !important; padding: 12px 14px !important; border-radius: 10px !important;
            font-size: 14px !important; width: 100% !important;
        }
        #pmNav .pm-links a:hover, #pmNav .pm-links a.active {
            background: rgba(56,189,248,0.12) !important; text-shadow: none !important;
        }
        html[data-theme="light"] #pmNav .pm-links {
            background: rgba(255,255,255,0.98) !important; box-shadow: 0 20px 35px rgba(15,23,42,0.15) !important;
        }
    }
    @supports (height: 100dvh) {
        @media (max-width: 1023px) { #pmNav .pm-links { max-height: calc(100dvh - 64px); } }
    }

    /* Phones: flexible search, bigger touch targets, no iOS zoom, safe dropdown */
    @media (max-width: 767px) {
        #pmNav .pm-right { flex: 1 1 auto; min-width: 0; justify-content: flex-end !important; }
        #pmNav .pm-search { flex: 0 1 220px; min-width: 0 !important; }
        #pmNav .pm-search input { flex: 1 1 0; width: auto !important; min-width: 0 !important; font-size: 16px !important; }
        #pmNav .pm-theme-btn, #pmNav .pm-menu-btn { width: 40px !important; height: 40px !important; }
        #pmNav .pm-dropdown {
            max-width: calc(100vw - 24px) !important;
            max-height: calc(100vh - 80px); overflow-y: auto !important;
        }
    }

    /* Small phones (<=480px): search collapses to an icon, expands on tap */
    @media (max-width: 480px) {
        #pmNav .pm-right { position: static !important; gap: 8px !important; }
        #pmNav .pm-search {
            flex: 0 0 40px !important; width: 40px !important; height: 40px !important;
            padding: 0 !important; justify-content: center !important; border-radius: 50% !important;
        }
        #pmNav .pm-search input { display: none !important; }
        #pmNav .pm-search button { width: 100% !important; height: 100% !important; font-size: 14px !important; }
        #pmNav .pm-search.open {
            position: absolute !important; top: 8px !important; left: 10px !important; right: 10px !important;
            width: auto !important; height: 48px !important; border-radius: 24px !important;
            padding: 0 6px 0 16px !important; background: #0e121c !important; z-index: 1200;
            justify-content: flex-start !important;
        }
        #pmNav .pm-search.open input { display: block !important; }
        #pmNav .pm-search.open button { width: 36px !important; flex: 0 0 36px; }
        html[data-theme="light"] #pmNav .pm-search.open { background: #ffffff !important; }
    }
</style>

<!-- 🌟 STICKY TOP NAVBAR (User / Admin links change automatically by role) -->
<nav id="pmNav">
    <div class="pm-left">
        <a href="${isAdmin ? '/admin/home' : '/home'}" class="pm-logo">
            <div class="pm-logo-icon">P</div>
            <div class="pm-logo-text">ProMatch Arena <span>${isAdmin ? 'Admin Panel' : 'Tournament Control'}</span></div>
        </a>
        <ul class="pm-links" id="pmNavLinks">
            <c:choose>
                <c:when test="${isAdmin}">
                    <li><a href="/admin/home">Home</a></li>
                    <li><a href="/admin/teams">Teams</a></li>
                    <li><a href="/admin/tournaments">Tournaments</a></li>
                    <li><a href="/admin/matches">Matches</a></li>
                    <li><a href="/admin/pointsTable">Points Table</a></li>
                    <li><a href="/admin/users">Users</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="/home">Home</a></li>
                    <li><a href="/teams">View Teams</a></li>
                    <li><a href="/matches">Matches</a></li>
                    <li><a href="/tournaments">Tournaments</a></li>
                    <li><a href="/pointsTable">Points Table</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>

    <div class="pm-right">
		<form action="${isAdmin ? '/admin/search' : '/search'}" method="get" class="pm-search">
		    <input type="text" name="keyword" placeholder="Search team, player..." required>
		    <button type="submit" aria-label="Search"><i class="fa-solid fa-magnifying-glass"></i></button>
		</form>

        <!-- Theme toggle: on navbar itself -->
        <button type="button" class="pm-theme-btn" id="pmThemeToggle" title="Toggle theme" aria-label="Toggle dark or light mode">
            <i class="fa-solid fa-moon"></i>
            <i class="fa-solid fa-sun"></i>
        </button>

        <div class="pm-profile" id="pmProfile">
            <div class="pm-pill" id="pmUserPill">
                <div class="pm-avatar" id="userAvatarContainer" data-initial="${not empty sessionScope.user.name ? sessionScope.user.name.charAt(0) : 'J'}">${not empty sessionScope.user.name ? sessionScope.user.name.charAt(0) : 'J'}</div>
                <div class="pm-username">${not empty sessionScope.user.name ? sessionScope.user.name : 'Jitendra'}</div>
                <span class="pm-caret">▼</span>
            </div>

            <div id="profileDropdown" class="pm-dropdown">
                <!-- Header: photo + name + email + role -->
                <div class="pm-dd-head">
                    <div class="pm-photo-wrap">
                        <div class="pm-photo-big" id="pmPhotoBig">${not empty sessionScope.user.name ? sessionScope.user.name.charAt(0) : 'J'}</div>

                        <!-- One click -> file picker directly -->
                        <button type="button" class="pm-photo-edit-btn" id="pmChangePhoto" title="Change photo"><i class="fa-solid fa-camera"></i></button>

                        <!-- Only visible once a photo is set -->
                        <button type="button" class="pm-photo-remove-btn" id="pmRemovePhoto" title="Remove photo"><i class="fa-solid fa-xmark"></i></button>

                        <input type="file" id="pmPhotoInput" accept="image/*" style="display: none;">
                    </div>
                    <p class="pm-dd-name">${not empty sessionScope.user.name ? sessionScope.user.name : 'Jitendra Singh'}</p>
                    <p class="pm-dd-email">${not empty sessionScope.user.email ? sessionScope.user.email : 'jitendrasingh07022004@gmail.com'}</p>
                    <span class="pm-role"><i class="fa-solid fa-shield-halved"></i> ${not empty sessionScope.user.role ? sessionScope.user.role : 'ADMIN'}</span>
                </div>

                <!-- Menu -->
                <div class="pm-dd-body">
                    <a href="/change-password" class="pm-item">
                        <span class="pm-ico"><i class="fa-solid fa-key"></i></span>
                        <span class="pm-txt">Change Password</span>
                        <span class="pm-chevron"><i class="fa-solid fa-chevron-right"></i></span>
                    </a>
                    <div class="pm-dd-divider"></div>
                    <a href="/logout" class="pm-item pm-logout">
                        <span class="pm-ico"><i class="fa-solid fa-right-from-bracket"></i></span>
                        <span class="pm-txt">Logout</span>
                    </a>
                </div>
            </div>
        </div>

        <!-- Mobile menu button (visible only on small screens) -->
        <button type="button" class="pm-menu-btn" id="pmMenuBtn" aria-label="Open menu" aria-expanded="false">
            <i class="fa-solid fa-bars"></i>
        </button>
    </div>
</nav>

<script>
    (function () {
        var PIC_KEY = 'promatch_profile_pic_v2';
        var OLD_PIC_KEY = 'user_profile_pic';
        var THEME_KEY = 'promatch_theme';

        var nav = document.getElementById('pmNav');
        var profile = document.getElementById('pmProfile');
        var pill = document.getElementById('pmUserPill');
        var dropdown = document.getElementById('profileDropdown');
        var avatar = document.getElementById('userAvatarContainer');
        var photoBig = document.getElementById('pmPhotoBig');
        var input = document.getElementById('pmPhotoInput');
        var changeBtn = document.getElementById('pmChangePhoto');
        var removeBtn = document.getElementById('pmRemovePhoto');
        var themeBtn = document.getElementById('pmThemeToggle');
        var menuBtn = document.getElementById('pmMenuBtn');
        var linksBox = document.getElementById('pmNavLinks');
        var initial = (avatar.getAttribute('data-initial') || 'J').trim();

        /* ---------- Mobile menu (hamburger) ---------- */
        function closeMenu() {
            linksBox.classList.remove('open');
            menuBtn.setAttribute('aria-expanded', 'false');
            menuBtn.querySelector('i').className = 'fa-solid fa-bars';
        }
        menuBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            var open = linksBox.classList.toggle('open');
            menuBtn.setAttribute('aria-expanded', open ? 'true' : 'false');
            menuBtn.querySelector('i').className = open ? 'fa-solid fa-xmark' : 'fa-solid fa-bars';
            dropdown.classList.remove('show');
            profile.classList.remove('open');
        });
        window.addEventListener('resize', function () {
            if (window.innerWidth > 767) closeMenu();
        });

        /* ---------- Dropdown open/close ---------- */
        pill.addEventListener('click', function (e) {
            e.stopPropagation();
            closeMenu();
            dropdown.classList.toggle('show');
            profile.classList.toggle('open', dropdown.classList.contains('show'));
        });
        document.addEventListener('click', function (e) {
            if (!e.target.closest('#pmProfile')) {
                dropdown.classList.remove('show');
                profile.classList.remove('open');
            }
            if (!e.target.closest('#pmNavLinks') && !e.target.closest('#pmMenuBtn')) {
                closeMenu();
            }
        });
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') { dropdown.classList.remove('show'); profile.classList.remove('open'); closeMenu(); }
        });

        /* ---------- Profile photo ---------- */
        function showPhoto(src) {
            if (src) {
                avatar.innerHTML = '<img src="' + src + '" alt="Profile">';
                photoBig.innerHTML = '<img src="' + src + '" alt="Profile">';
                removeBtn.classList.add('visible');
            } else {
                avatar.textContent = initial;
                photoBig.textContent = initial;
                removeBtn.classList.remove('visible');
            }
        }

        function loadSavedPhoto() {
            var saved = null;
            try { saved = localStorage.getItem(PIC_KEY) || localStorage.getItem(OLD_PIC_KEY); } catch (e) {}
            showPhoto(saved);
        }

        /* Single click opens file picker directly - no in-between popup to break */
        changeBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            input.click();
        });

        input.addEventListener('click', function (e) { e.stopPropagation(); });

        input.addEventListener('change', function (e) {
            var file = e.target.files[0];
            if (!file || !file.type || file.type.indexOf('image/') !== 0) return;
            var reader = new FileReader();
            reader.onload = function (ev) {
                var img = new Image();
                img.onload = function () {
                    /* crop to centered square, resize to 256px */
                    var size = Math.min(img.width, img.height);
                    var sx = (img.width - size) / 2;
                    var sy = (img.height - size) / 2;
                    var canvas = document.createElement('canvas');
                    canvas.width = 256; canvas.height = 256;
                    canvas.getContext('2d').drawImage(img, sx, sy, size, size, 0, 0, 256, 256);
                    var data = canvas.toDataURL('image/jpeg', 0.88);
                    try {
                        localStorage.setItem(PIC_KEY, data);
                        localStorage.removeItem(OLD_PIC_KEY);
                    } catch (err) {}
                    showPhoto(data);
                };
                img.src = ev.target.result;
            };
            reader.readAsDataURL(file);
            input.value = '';
        });

        removeBtn.addEventListener('click', function (e) {
            e.stopPropagation();
            try { localStorage.removeItem(PIC_KEY); localStorage.removeItem(OLD_PIC_KEY); } catch (err) {}
            showPhoto(null);
        });

        /* ---------- Dark / Light (on navbar) ---------- */
        themeBtn.addEventListener('click', function () {
            var root = document.documentElement;
            if (root.getAttribute('data-theme') === 'light') {
                root.removeAttribute('data-theme');
                try { localStorage.setItem(THEME_KEY, 'dark'); } catch (err) {}
            } else {
                root.setAttribute('data-theme', 'light');
                try { localStorage.setItem(THEME_KEY, 'light'); } catch (err) {}
            }
        });

        /* ---------- Active link (by current URL) ---------- */
        var links = document.querySelectorAll('#pmNavLinks a');
        var path = window.location.pathname.replace(/\/+$/, '') || '/';
        links.forEach(function (a) {
            var href = a.getAttribute('href');
            if (path === href || (path === '/' && href === '/home') || path.indexOf(href + '/') === 0) {
                a.classList.add('active');
            }
        });

        /* ---------- Scroll shadow ---------- */
        function onScroll() {
            var y = window.pageYOffset || document.documentElement.scrollTop || document.body.scrollTop || 0;
            nav.classList.toggle('scrolled', y > 20);
        }
        window.addEventListener('scroll', onScroll);
        onScroll();

        loadSavedPhoto();
    })();
</script>

<script>
    /* ===== RESPONSIVE ADD-ON (JS) ===== */
    (function () {
        /* viewport tag fallback (agar parent page me na ho) */
        if (!document.querySelector('meta[name="viewport"]')) {
            var m = document.createElement('meta');
            m.name = 'viewport';
            m.content = 'width=device-width, initial-scale=1';
            document.head.appendChild(m);
        }

        /* small-phone search: tap icon -> expand, tap again (empty) -> close */
        var nav = document.getElementById('pmNav');
        if (!nav) return;
        var form = nav.querySelector('.pm-search');
        if (!form) return;
        var input = form.querySelector('input');
        var btn = form.querySelector('button');
        var mq = window.matchMedia('(max-width: 480px)');

        function closeSearch() { form.classList.remove('open'); }

        btn.addEventListener('click', function (e) {
            if (!mq.matches) return;
            if (!form.classList.contains('open')) {
                e.preventDefault();
                form.classList.add('open');
                input.focus();
            } else if (!input.value.trim()) {
                e.preventDefault();
                closeSearch();
            }
        });
        document.addEventListener('click', function (e) {
            if (!e.target.closest('.pm-search')) closeSearch();
        });
        document.addEventListener('keydown', function (e) {
            if (e.key === 'Escape') closeSearch();
        });
        if (mq.addEventListener) mq.addEventListener('change', closeSearch);
        else if (mq.addListener) mq.addListener(closeSearch);
    })();
</script>
