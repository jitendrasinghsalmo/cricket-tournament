<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ProMatch Arena | User Management Command Hub</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{box-sizing:border-box}
html{scroll-behavior:smooth}
:root{--tc-bg:#080b1e;--tc-card:#0e1428;--tc-card-alt:#080b1e;--tc-input:#030712;--tc-cyan:#00d9ff;--tc-green:#00ff88;--tc-rose:#ff006e;--tc-amber:#ffa500;--tc-gold:#ffd700;--tc-purple:#b537f2;--tc-text:#f0f4ff;--tc-muted:#a8b8d8;--tc-border:#1e294b;--neon-cyan:#00d9ff;--neon-emerald:#00ff88;--border-glass:#1e294b;--text-primary:#f0f4ff;--text-secondary:#a8b8d8}
html[data-theme="light"]{--tc-bg:#f1f5f9;--tc-card:#fff;--tc-card-alt:#f1f5f9;--tc-input:#fff;--tc-cyan:#0284c7;--tc-green:#059669;--tc-rose:#e11d48;--tc-amber:#d97706;--tc-gold:#b45309;--tc-purple:#7c3aed;--tc-text:#0f172a;--tc-muted:#475569;--tc-border:#cbd5e1}
body{font-family:'Inter','Segoe UI',system-ui,sans-serif;background:var(--tc-bg);color:var(--tc-text);margin:0;overflow-x:hidden}
.wrap{max-width:1400px;margin:30px auto;padding:0 20px}

/* header + jumping title */
.header-bar{display:grid;grid-template-columns:1fr auto 1fr;align-items:center;gap:16px;margin-bottom:24px;padding:18px 30px;border-radius:18px;background:var(--tc-card);border:1px solid var(--tc-border)}
.admin-chip{display:inline-flex;align-items:center;gap:7px;font-size:11px;font-weight:800;letter-spacing:1px;text-transform:uppercase;color:var(--tc-rose);background:rgba(255,0,110,.12);border:1px solid rgba(255,0,110,.4);padding:6px 12px;border-radius:20px}
.header-right{display:flex;align-items:center;justify-content:flex-end;gap:12px}
.jumping-title{text-align:center;margin:0;font-weight:900;font-size:clamp(17px,4.6vw,24px);letter-spacing:2px;text-transform:uppercase}
.jumping-title .word{display:inline-block;white-space:nowrap}
.jumping-title .ch{display:inline-block;color:var(--tc-cyan);text-shadow:0 0 15px rgba(0,217,255,.7),0 0 30px rgba(0,255,136,.4);transform:translateY(-30px);opacity:0;animation:drop .8s cubic-bezier(.175,.885,.32,1.275) forwards;animation-delay:calc(.05s*var(--i))}
html[data-theme="light"] .jumping-title .ch{text-shadow:none}
@keyframes drop{0%{opacity:0;transform:translateY(-30px) scale(.5)}60%{opacity:1;transform:translateY(10px) scale(1.1)}100%{opacity:1;transform:none}}
.btn-add,.btn-del-all{height:42px;padding:0 18px;border-radius:10px;text-decoration:none;font-weight:700;font-size:13px;display:inline-flex;align-items:center;gap:7px;white-space:nowrap;transition:.3s}
.btn-add{background:linear-gradient(135deg,#0ea5e9,#0369a1);color:#fff;border:1.5px solid rgba(0,217,255,.6)}
.btn-add:hover{transform:translateY(-3px);box-shadow:0 8px 25px rgba(0,217,255,.5)}
.btn-del-all{background:rgba(255,0,110,.12);color:var(--tc-rose);border:1.5px solid var(--tc-rose)}
.btn-del-all:hover{background:var(--tc-rose);color:#fff;transform:translateY(-3px)}

/* search + account tiles */
.search-row{display:flex;justify-content:space-between;align-items:center;gap:14px;flex-wrap:wrap;margin-bottom:16px}
.search-wrap{position:relative;flex:1;max-width:420px;min-width:0}
.search-wrap i{position:absolute;left:15px;top:50%;transform:translateY(-50%);color:var(--tc-muted);font-size:13px}
.search-input{width:100%;background:var(--tc-input);border:1.5px solid var(--tc-border);border-radius:12px;height:44px;padding:0 16px 0 40px;color:var(--tc-text);font-size:14px;outline:none;font-family:inherit}
.search-input:focus{border-color:var(--tc-cyan);box-shadow:0 0 15px rgba(0,217,255,.35)}
.show-badge{font-size:13px;font-weight:700;color:var(--tc-muted)}
.show-badge span{color:var(--tc-gold);font-weight:800}
.tabs{display:grid;grid-template-columns:repeat(4,1fr);gap:14px;margin-bottom:26px}
.tab{display:flex;align-items:center;gap:12px;text-align:left;background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:16px;padding:14px 16px;cursor:pointer;color:var(--tc-text);font-family:inherit;transition:.25s;min-width:0}
.tab i{width:42px;height:42px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:17px;flex-shrink:0;color:var(--tk);background:var(--tk-bg)}
.tab b{display:block;font-size:24px;font-weight:900;line-height:1}
.tab span{display:block;margin-top:4px;font-size:11.5px;font-weight:700;color:var(--tc-muted)}
.tab:hover{transform:translateY(-3px);border-color:var(--tk)}
.tab.active{border-color:var(--tk);background:linear-gradient(135deg,var(--tk-bg),transparent),var(--tc-card);box-shadow:0 10px 26px var(--tk-bg)}
.tab[data-filter="all"]{--tk:var(--tc-cyan);--tk-bg:rgba(0,217,255,.13)}
.tab[data-filter="admin"]{--tk:var(--tc-gold);--tk-bg:rgba(255,215,0,.13)}
.tab[data-filter="member"]{--tk:var(--tc-green);--tk-bg:rgba(0,255,136,.13)}
.tab[data-filter="blocked"]{--tk:var(--tc-rose);--tk-bg:rgba(255,0,110,.13)}

/* ID-badge user cards */
.uc-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(300px,1fr));gap:26px 22px}
.uc{--uc:var(--tc-cyan);position:relative;background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:22px;overflow:hidden;display:flex;flex-direction:column;transition:.3s;box-shadow:0 10px 30px rgba(0,0,0,.22)}
.uc.is-admin{--uc:var(--tc-gold)}.uc.is-member{--uc:var(--tc-green)}.uc.is-blocked{--uc:var(--tc-rose)}
.uc:hover{transform:translateY(-6px);border-color:var(--uc);box-shadow:0 20px 42px rgba(0,217,255,.16)}
.uc-band{position:relative;height:84px;background:linear-gradient(135deg,var(--uc),transparent 85%),var(--tc-card-alt);display:flex;justify-content:space-between;align-items:flex-start;padding:14px 16px}
.uc-band::before{content:'';position:absolute;top:9px;left:50%;width:46px;height:8px;margin-left:-23px;border-radius:8px;background:var(--tc-card);border:1.5px solid var(--tc-border)}
.uc-role{font-size:10px;font-weight:800;text-transform:uppercase;padding:4px 11px;border-radius:20px;background:var(--tc-card);color:var(--uc);border:1.5px solid var(--uc);margin-top:14px}
.uc-id{font-size:10.5px;font-weight:800;color:var(--tc-text);opacity:.75;margin-top:18px}
.uc-av{position:relative;width:76px;height:76px;margin:-40px auto 0;border-radius:50%;background:linear-gradient(135deg,var(--uc),var(--tc-purple));color:#030712;border:4px solid var(--tc-card);display:flex;align-items:center;justify-content:center;font-size:30px;font-weight:900}
.is-blocked .uc-av{filter:grayscale(.85)}
.uc-dot{position:absolute;right:0;bottom:2px;width:18px;height:18px;border-radius:50%;border:3px solid var(--tc-card);background:var(--tc-green)}
.is-blocked .uc-dot{background:var(--tc-rose)}
.uc-body{padding:12px 18px 18px;display:flex;flex-direction:column;gap:12px;flex:1;text-align:center}
.uc-name{margin:0;font-size:18px;font-weight:900;overflow-wrap:anywhere}
.uc-status{font-size:11px;font-weight:800;text-transform:uppercase;color:var(--tc-green);margin-top:-6px}
.is-blocked .uc-status{color:var(--tc-rose)}
.uc-line{display:flex;align-items:center;gap:10px;padding:9px 12px;border-radius:12px;background:var(--tc-card-alt);border:1px solid var(--tc-border);font-size:12.5px;font-weight:600;text-align:left;min-width:0}
.uc-line>i{color:var(--tc-cyan);width:14px;text-align:center;flex-shrink:0}
.uc-line span{flex:1;min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.uc-line span.muted{color:var(--tc-muted)}
.copy-btn{width:28px;height:28px;flex-shrink:0;border-radius:8px;border:1px solid var(--tc-border);background:var(--tc-card);color:var(--tc-muted);cursor:pointer;font-size:11px;transition:.2s}
.copy-btn:hover{color:var(--tc-cyan);border-color:var(--tc-cyan)}
.copy-btn.ok{color:var(--tc-green);border-color:var(--tc-green)}
.uc-joined{font-size:11.5px;font-weight:700;color:var(--tc-muted)}
.uc-joined i{margin-right:6px;color:var(--tc-gold)}
.uc-actions{display:flex;gap:8px;margin-top:auto}
.uc-actions a{height:40px;text-decoration:none;border-radius:12px;font-size:11px;font-weight:800;display:inline-flex;align-items:center;justify-content:center;gap:6px;text-transform:uppercase;transition:.2s;flex:1}
.a-edit{background:rgba(0,217,255,.15);color:var(--tc-cyan);border:1.5px solid var(--tc-cyan)}
.a-edit:hover{background:var(--tc-cyan);color:#030712}
.a-block{background:rgba(255,165,0,.14);color:var(--tc-amber);border:1.5px solid var(--tc-amber)}
.a-block:hover{background:var(--tc-amber);color:#030712}
.a-unblock{background:rgba(0,255,136,.14);color:var(--tc-green);border:1.5px solid var(--tc-green)}
.a-unblock:hover{background:var(--tc-green);color:#030712}
.a-del{flex:0 0 44px!important;background:rgba(255,0,110,.15);color:var(--tc-rose);border:1.5px solid var(--tc-rose)}
.a-del:hover{background:var(--tc-rose);color:#fff}
.protected{width:100%;text-align:center;font-size:12px;font-weight:700;color:var(--tc-gold);padding:11px;border-radius:12px;border:1.5px dashed var(--tc-gold);background:rgba(255,215,0,.07)}
.no-data{text-align:center;color:var(--tc-muted);grid-column:1/-1;padding:46px 20px;font-size:14px;font-weight:700;background:var(--tc-card);border:1px dashed var(--tc-border);border-radius:16px}

/* sections */
.section-block{margin:44px auto 0}
.section-title{font-size:18px;font-weight:800;text-transform:uppercase;letter-spacing:1.2px;margin:0 0 20px;display:flex;align-items:center;gap:12px;flex-wrap:wrap}
.section-title::before{content:'';width:4px;height:24px;background:linear-gradient(180deg,var(--tc-cyan),var(--tc-green));border-radius:2px}
.section-title small{margin-left:auto;font-size:11.5px;font-weight:700;color:var(--tc-muted);text-transform:none;letter-spacing:.3px}
.grid-2{display:grid;grid-template-columns:repeat(2,1fr);gap:22px}
.grid-3{display:grid;grid-template-columns:repeat(3,1fr);gap:20px}
.panel{background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:20px;padding:22px;min-width:0}
.panel h3{margin:0 0 16px;font-size:15px;font-weight:800;text-transform:uppercase;display:flex;align-items:center;gap:9px}
.panel-empty{font-size:13px;color:var(--tc-muted);margin:0}
.list-row{display:flex;align-items:center;gap:12px;padding:12px 0;border-bottom:1px solid var(--tc-border)}
.list-row:last-child{border-bottom:none;padding-bottom:0}.list-row:first-child{padding-top:0}
.list-avatar{width:40px;height:40px;border-radius:12px;flex-shrink:0;background:linear-gradient(135deg,var(--tc-cyan),var(--tc-green));color:#030712;display:flex;align-items:center;justify-content:center;font-weight:900}
.list-main{flex:1;min-width:0}
.list-name{margin:0;font-size:13.5px;font-weight:800;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.list-sub{margin:2px 0 0;font-size:11.5px;color:var(--tc-muted);overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.tags{display:flex;gap:5px;flex-wrap:wrap;margin-top:6px}
.tag{font-size:10px;font-weight:800;padding:3px 9px;border-radius:20px;text-transform:uppercase;color:var(--tc-amber);background:rgba(255,165,0,.14);border:1px solid rgba(255,165,0,.35)}
.mini-link{font-size:11px;font-weight:800;color:var(--tc-cyan);text-decoration:none;border:1.5px solid var(--tc-cyan);padding:6px 12px;border-radius:8px;white-space:nowrap}
.mini-link:hover{background:var(--tc-cyan);color:#030712}
.mini-link.green{color:var(--tc-green);border-color:var(--tc-green)}.mini-link.green:hover{background:var(--tc-green);color:#030712}

.tl{position:relative;padding-left:26px}
.tl::before{content:'';position:absolute;left:7px;top:6px;bottom:6px;width:2px;background:linear-gradient(180deg,var(--tc-cyan),var(--tc-purple));opacity:.5}
.tl-item{position:relative;padding-bottom:18px}.tl-item:last-child{padding-bottom:0}
.tl-item::before{content:'';position:absolute;left:-26px;top:3px;width:16px;height:16px;border-radius:50%;background:var(--tc-card);border:3px solid var(--tc-cyan)}
.tl-time{font-size:11px;font-weight:800;color:var(--tc-cyan);text-transform:uppercase}
.tl-name{margin:3px 0;font-size:14px;font-weight:800;overflow-wrap:anywhere}
.tl-sub{font-size:11.5px;color:var(--tc-muted);font-weight:600;overflow-wrap:anywhere}

.ring-wrap{display:flex;align-items:center;gap:26px;flex-wrap:wrap;justify-content:center}
.ring{--a:0;--b:0;width:170px;height:170px;border-radius:50%;background:conic-gradient(var(--tc-gold) 0 calc(var(--a)*1%),var(--tc-green) calc(var(--a)*1%) calc(var(--b)*1%),var(--tc-rose) calc(var(--b)*1%) 100%);display:flex;align-items:center;justify-content:center;flex-shrink:0}
.ring div{width:118px;height:118px;border-radius:50%;background:var(--tc-card);display:flex;flex-direction:column;align-items:center;justify-content:center}
.ring b{font-size:30px;font-weight:900;line-height:1}.ring span{font-size:10.5px;font-weight:800;color:var(--tc-muted);text-transform:uppercase;margin-top:4px}
.legend{display:flex;flex-direction:column;gap:12px;font-size:13px;font-weight:700}
.legend i{display:inline-block;width:12px;height:12px;border-radius:4px;margin-right:9px}

.trend{display:flex;align-items:flex-end;justify-content:space-between;gap:10px;height:190px;padding-top:10px}
.t-col{flex:1;min-width:0;height:100%;display:flex;flex-direction:column;justify-content:flex-end;align-items:center;gap:6px}
.t-bar{width:100%;max-width:46px;border-radius:10px 10px 4px 4px;background:linear-gradient(180deg,var(--tc-cyan),var(--tc-purple));min-height:4px}
.t-col b{font-size:12px;font-weight:900}.t-col span{font-size:10.5px;font-weight:700;color:var(--tc-muted)}
.bar-row{margin-bottom:14px}.bar-row:last-child{margin-bottom:0}
.bar-label{display:flex;justify-content:space-between;gap:10px;font-size:12.5px;font-weight:700;margin-bottom:6px}
.bar-label span:first-child{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.bar-track{height:10px;border-radius:8px;background:var(--tc-card-alt);border:1px solid var(--tc-border);overflow:hidden}
.bar-fill{height:100%;border-radius:8px}

.admin-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(250px,1fr));gap:16px}
.admin-card{display:flex;align-items:center;gap:14px;background:var(--tc-card);border:1.5px solid rgba(255,215,0,.45);border-radius:18px;padding:16px;min-width:0}
.admin-card .list-avatar{width:48px;height:48px;border-radius:50%;background:linear-gradient(135deg,var(--tc-gold),var(--tc-amber))}
.admin-card i.lock{color:var(--tc-gold)}

.desk{margin:44px 0 10px;border-radius:22px;padding:28px 34px;background:linear-gradient(135deg,rgba(0,217,255,.14),rgba(181,55,242,.1)),var(--tc-card);border:2px solid var(--tc-cyan);display:flex;align-items:center;justify-content:space-between;gap:20px;flex-wrap:wrap}
.desk h3{margin:0 0 6px;font-size:clamp(17px,4.5vw,22px);font-weight:900;text-transform:uppercase}
.desk p{margin:0;font-size:13.5px;color:var(--tc-muted);font-weight:600;max-width:520px;line-height:1.6}
.desk-btns{display:flex;gap:12px;flex-wrap:wrap}
.btn-desk{background:linear-gradient(135deg,var(--tc-cyan),var(--tc-green));color:#030712;border:none;height:48px;padding:0 24px;border-radius:14px;font-weight:900;font-size:13px;text-transform:uppercase;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;gap:9px;white-space:nowrap;font-family:inherit}
.btn-desk.ghost{background:transparent;color:var(--tc-cyan);border:2px solid var(--tc-cyan)}

/* member seniority */
.grid-4{display:grid;grid-template-columns:repeat(4,1fr);gap:18px}
.age-card{background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:18px;padding:20px;position:relative;overflow:hidden;transition:.3s}
.age-card:hover{transform:translateY(-5px);border-color:var(--ac)}
.age-card::before{content:'';position:absolute;inset:0 0 auto 0;height:4px;background:var(--ac)}
.age-ico{width:44px;height:44px;border-radius:12px;display:flex;align-items:center;justify-content:center;font-size:18px;color:var(--ac);border:1.5px solid var(--ac);background:var(--tc-card-alt);margin-bottom:14px}
.age-num{font-size:30px;font-weight:900;color:var(--ac);line-height:1}
.age-lbl{margin-top:6px;font-size:12px;font-weight:800;color:var(--tc-text)}
.age-sub{margin-top:2px;font-size:11px;font-weight:600;color:var(--tc-muted)}
.age-track{height:6px;border-radius:6px;background:var(--tc-card-alt);border:1px solid var(--tc-border);margin-top:12px;overflow:hidden}
.age-track i{display:block;height:100%;background:var(--ac);border-radius:6px}

/* profile completeness */
.score-wrap{display:flex;align-items:center;gap:30px;flex-wrap:wrap}
.score-ring{--p:0;width:150px;height:150px;border-radius:50%;background:conic-gradient(var(--tc-green) calc(var(--p)*1%),var(--tc-border) 0);display:flex;align-items:center;justify-content:center;flex-shrink:0}
.score-ring div{width:106px;height:106px;border-radius:50%;background:var(--tc-card);display:flex;flex-direction:column;align-items:center;justify-content:center}
.score-ring b{font-size:30px;font-weight:900;line-height:1}.score-ring span{font-size:10px;font-weight:800;color:var(--tc-muted);text-transform:uppercase;margin-top:4px}
.score-bars{flex:1;min-width:230px}

/* A-Z directory */
.az-wrap{display:flex;flex-wrap:wrap;gap:10px}
.az-chip{min-width:52px;height:50px;padding:0 12px;border-radius:14px;border:1.5px solid var(--tc-border);background:var(--tc-card);color:var(--tc-text);font-family:inherit;cursor:pointer;display:flex;flex-direction:column;align-items:center;justify-content:center;transition:.2s}
.az-chip b{font-size:16px;font-weight:900;line-height:1}
.az-chip span{font-size:10px;font-weight:700;color:var(--tc-muted);margin-top:3px}
.az-chip:hover{border-color:var(--tc-cyan);transform:translateY(-3px)}
.az-chip.active{background:var(--tc-cyan);border-color:var(--tc-cyan);color:#030712}
.az-chip.active span{color:#030712}
html[data-theme="light"] .az-chip.active,html[data-theme="light"] .az-chip.active span{color:#fff}

/* access levels */
.table-scroll{overflow-x:auto;-webkit-overflow-scrolling:touch}
.perm-table{width:100%;border-collapse:collapse;font-size:13px;min-width:320px}
.perm-table th{text-align:center;font-size:11px;text-transform:uppercase;color:var(--tc-muted);padding:0 8px 12px;letter-spacing:.5px}
.perm-table th:first-child,.perm-table td:first-child{text-align:left}
.perm-table td{padding:12px 8px;border-top:1px solid var(--tc-border);text-align:center;font-weight:600;color:var(--tc-muted)}
.perm-table td:first-child{color:var(--tc-text);font-weight:700}
.yes,.no{display:inline-flex;width:26px;height:26px;border-radius:8px;align-items:center;justify-content:center;font-size:12px}
.yes{background:rgba(0,255,136,.14);color:var(--tc-green);border:1px solid rgba(0,255,136,.4)}
.no{background:rgba(255,0,110,.12);color:var(--tc-rose);border:1px solid rgba(255,0,110,.4)}
.check-list{list-style:none;margin:0;padding:0;display:flex;flex-direction:column;gap:13px}
.check-list li{display:flex;gap:11px;font-size:13px;line-height:1.5;color:var(--tc-muted);font-weight:600}
.check-list li strong{color:var(--tc-text)}
.check-list li i{width:22px;height:22px;flex-shrink:0;border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:11px;background:rgba(0,217,255,.12);color:var(--tc-cyan);border:1px solid rgba(0,217,255,.35)}
@media(max-width:1100px){.grid-4{grid-template-columns:1fr 1fr}}
@media(max-width:640px){.grid-4{gap:12px}.age-card{padding:16px}.age-num{font-size:26px}.score-wrap{justify-content:center;gap:20px}.az-chip{min-width:46px;height:46px}}
@media(max-width:380px){.grid-4{grid-template-columns:1fr}}

/* responsive */
@media(max-width:1100px){.grid-3{grid-template-columns:1fr 1fr}.grid-2{grid-template-columns:1fr}.tabs{grid-template-columns:repeat(2,1fr)}}
@media(max-width:900px){.header-bar{grid-template-columns:1fr;text-align:center;padding:18px 16px}.header-left,.header-right{justify-content:center}}
@media(max-width:640px){
.wrap{padding:0 14px;margin:20px auto}
.header-right{width:100%}.header-right a{flex:1;justify-content:center;padding:0 10px;font-size:12px}
.search-wrap{max-width:none;flex-basis:100%}.search-input{font-size:16px}
.tabs{gap:10px}.tab{padding:12px;gap:10px}.tab i{width:36px;height:36px;font-size:15px}.tab b{font-size:21px}
.uc-grid{grid-template-columns:1fr}
.grid-3{grid-template-columns:1fr}
.section-title small{margin-left:0;width:100%}
.panel{padding:18px 14px}
.ring-wrap{gap:18px}.ring{width:150px;height:150px}.ring div{width:104px;height:104px}
.trend{height:160px;gap:6px}
.admin-grid{grid-template-columns:1fr}
.desk{padding:22px 18px;flex-direction:column;text-align:center}
/* ===== MOBILE FIX: both User Desk buttons side by side in one line ===== */
.desk-btns{width:100%;flex-direction:row;flex-wrap:nowrap;gap:8px}
.btn-desk{flex:1 1 0;min-width:0;width:auto;height:44px;padding:0 8px;font-size:10px;letter-spacing:.3px;gap:5px}
.btn-desk i{font-size:11px}
}
@media(max-width:380px){.tab span{font-size:10.5px}}
@media(prefers-reduced-motion:reduce){.jumping-title .ch{animation:none!important;opacity:1;transform:none}}

/* footer */
.grand-footer-section{background:linear-gradient(135deg,rgba(13,18,35,.98),rgba(4,7,18,.99));border-top:2px solid var(--neon-cyan);border-radius:28px 28px 0 0;padding:60px 40px 30px;max-width:1400px;margin:60px auto 20px;width:calc(100% - 40px)}
.grand-footer-content{display:grid;grid-template-columns:2fr 1.2fr 1.2fr 1.5fr;gap:40px;align-items:start;border-bottom:1px solid var(--border-glass);padding-bottom:40px;margin-bottom:25px}
@media(max-width:1024px){.grand-footer-content{grid-template-columns:1fr 1fr}}
@media(max-width:650px){.grand-footer-content{grid-template-columns:1fr;text-align:center}.grand-footer-section{padding:40px 20px 24px}}
.footer-brand h3{margin:0 0 12px;font-size:22px;font-weight:900;text-transform:uppercase;color:var(--text-primary)}
.footer-brand h3 span{color:var(--neon-cyan)}
.footer-brand p,.footer-newsletter p{font-size:13.5px;color:var(--text-secondary);line-height:1.7}
.footer-socials{display:flex;gap:10px;flex-wrap:wrap}
.footer-socials a{width:38px;height:38px;border-radius:50%;background:rgba(0,217,255,.1);border:1.5px solid var(--border-glass);color:var(--neon-cyan);display:flex;align-items:center;justify-content:center;text-decoration:none}
.footer-links h4,.footer-newsletter h4{margin:0 0 18px;font-size:14px;font-weight:800;text-transform:uppercase;color:var(--neon-cyan)}
.footer-links ul{list-style:none;padding:0;margin:0;display:flex;flex-direction:column;gap:12px}
.footer-links a{color:var(--text-secondary);text-decoration:none;font-size:13px;font-weight:600}
.footer-links a:hover{color:var(--neon-cyan)}
.footer-newsletter form{display:flex;gap:8px}
.footer-newsletter input{flex:1;min-width:0;background:rgba(3,7,18,.7);border:1.5px solid var(--border-glass);border-radius:10px;padding:10px 14px;color:var(--text-primary);outline:none}
.footer-newsletter button{background:linear-gradient(135deg,var(--neon-cyan),var(--neon-emerald));color:#030712;border:none;border-radius:10px;padding:10px 16px;font-weight:800;cursor:pointer}
.footer-bottom-bar{display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:15px;color:var(--text-secondary);font-size:12px}
.footer-bottom-links{display:flex;gap:20px}.footer-bottom-links a{color:var(--text-secondary);text-decoration:none}
@media(max-width:768px){.footer-bottom-bar{flex-direction:column;text-align:center}}
</style>
</head>
<body>

<jsp:include page="navbar.jsp" />

<div class="wrap">

    <div class="header-bar">
        <div class="header-left"><span class="admin-chip"><i class="fa-solid fa-user-shield"></i> Admin Control</span></div>
        <h2 class="jumping-title" id="animatedTitle">Registered Users Hub</h2>
        <div class="header-right">
            <a href="/admin/addUserPage" class="btn-add"><i class="fa-solid fa-user-plus"></i> Add User</a>
            <c:if test="${not empty users}">
                <a href="/admin/deleteAllUsers" class="btn-del-all" onclick="return confirm('WARNING: Are you sure you want to delete all non-admin users?');"><i class="fa-solid fa-trash-can"></i> Delete All</a>
            </c:if>
        </div>
    </div>

    <!-- SEARCH + ACCOUNT TILES (tiles = filter) -->
    <div class="search-row">
        <div class="search-wrap"><i class="fa-solid fa-magnifying-glass"></i><input type="text" id="userSearch" class="search-input" placeholder="Search name, email or phone..." autocomplete="off"></div>
        <div class="show-badge">Showing <span id="totalBadge">${empty users ? 0 : users.size()}</span> accounts</div>
    </div>
    <div class="tabs" id="tabs">
        <button type="button" class="tab active" data-filter="all"><i class="fa-solid fa-users"></i><div><b id="tAll">0</b><span>All Accounts</span></div></button>
        <button type="button" class="tab" data-filter="admin"><i class="fa-solid fa-user-shield"></i><div><b id="tAdmin">0</b><span>Admin Team</span></div></button>
        <button type="button" class="tab" data-filter="member"><i class="fa-solid fa-user-check"></i><div><b id="tMember">0</b><span>Active Members</span></div></button>
        <button type="button" class="tab" data-filter="blocked"><i class="fa-solid fa-user-lock"></i><div><b id="tBlocked">0</b><span>Blocked</span></div></button>
    </div>

    <!-- USER CARDS -->
    <div class="uc-grid" id="ucGrid">
        <c:forEach items="${users}" var="u">
            <div class="uc ${u.role == 'ADMIN' ? 'is-admin' : (u.blocked ? 'is-blocked' : 'is-member')}"
                 data-id="<c:out value='${u.id}'/>"
                 data-name="<c:out value='${u.name}'/>"
                 data-email="<c:out value='${u.email}'/>"
                 data-phone="<c:out value='${u.phone}'/>"
                 data-role="<c:out value='${u.role}'/>"
                 data-blocked="${u.blocked ? 'true' : 'false'}"
                 data-joined="<c:out value='${u.createdAt}'/>">

                <div class="uc-band">
                    <span class="uc-role"><c:out value="${u.role}"/></span>
                    <span class="uc-id">ID #<c:out value="${u.id}"/></span>
                </div>
                <div class="uc-av"><span class="uc-init">U</span><span class="uc-dot"></span></div>

                <div class="uc-body">
                    <h3 class="uc-name"><c:out value="${u.name}"/></h3>
                    <div class="uc-status">${u.blocked ? 'Blocked' : 'Active'}</div>

                    <div class="uc-line"><i class="fa-solid fa-envelope"></i><span><c:out value="${u.email}"/></span><button type="button" class="copy-btn" data-copy="email" title="Copy email" aria-label="Copy email"><i class="fa-regular fa-copy"></i></button></div>
                    <div class="uc-line"><i class="fa-solid fa-phone"></i><span class="ph"><c:out value="${empty u.phone ? 'Phone not added' : u.phone}"/></span><button type="button" class="copy-btn" data-copy="phone" title="Copy phone" aria-label="Copy phone"><i class="fa-regular fa-copy"></i></button></div>

                    <div class="uc-joined"><i class="fa-solid fa-calendar-check"></i><span class="jn">Joined recently</span></div>

                    <div class="uc-actions">
                        <c:choose>
                            <c:when test="${u.role == 'ADMIN'}">
                                <div class="protected"><i class="fa-solid fa-shield-halved"></i> Protected Account</div>
                            </c:when>
                            <c:otherwise>
                                <a href="/admin/editUser/${u.id}" class="a-edit" title="Edit user"><i class="fa-solid fa-pen-to-square"></i> Edit</a>
                                <a href="/admin/toggleBlock/${u.id}" class="${u.blocked ? 'a-unblock' : 'a-block'}" title="${u.blocked ? 'Unblock user' : 'Block user'}"><i class="fa-solid ${u.blocked ? 'fa-lock-open' : 'fa-lock'}"></i> ${u.blocked ? 'Unblock' : 'Block'}</a>
                                <a href="/admin/deleteUser/${u.id}" class="a-del" title="Delete user" aria-label="Delete user" onclick="return confirm('Are you sure you want to delete this user?');"><i class="fa-solid fa-trash"></i></a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty users}"><div class="no-data">👥 No registered users found in the system.</div></c:if>
        <div class="no-data" id="noResults" style="display:none;">🔍 No accounts match your search.</div>
    </div>

    <!-- NEWEST + ROLE SPLIT -->
    <div class="section-block">
        <h3 class="section-title">🆕 New Joiners &amp; Account Mix <small>Who joined lately, and how accounts are split</small></h3>
        <div class="grid-2">
            <div class="panel"><h3><i class="fa-solid fa-user-plus" style="color:var(--tc-cyan)"></i> Newest Members</h3><div id="newest"></div></div>
            <div class="panel"><h3><i class="fa-solid fa-chart-pie" style="color:var(--tc-gold)"></i> Role &amp; Status Split</h3><div id="ringBox"></div></div>
        </div>
    </div>

    <!-- TREND + DOMAINS -->
    <div class="section-block">
        <h3 class="section-title">📈 Growth &amp; Email Insights <small>Built from your user list</small></h3>
        <div class="grid-2">
            <div class="panel"><h3><i class="fa-solid fa-chart-column" style="color:var(--tc-purple)"></i> Signups, Last 6 Months</h3><div id="trend"></div></div>
            <div class="panel"><h3><i class="fa-solid fa-at" style="color:var(--tc-green)"></i> Top Email Domains</h3><div id="domains"></div></div>
        </div>
    </div>

    <!-- BLOCKED WATCHLIST -->
    <div class="section-block">
        <h3 class="section-title">🚫 Blocked Watchlist <small>Unblock with one click</small></h3>
        <div class="panel"><div id="blockedList"></div></div>
    </div>

    <!-- ADMIN TEAM -->
    <div class="section-block">
        <h3 class="section-title">🛡️ Admin Team <small>Protected accounts, cannot be edited here</small></h3>
        <div class="admin-grid" id="adminGrid"></div>
    </div>

    <!-- HEALTH CHECK -->
    <div class="section-block">
        <h3 class="section-title">🩺 Account Health Check <small>Missing or doubtful details</small></h3>
        <div class="panel"><div id="healthList"></div></div>
    </div>

    <!-- MEMBER SENIORITY -->
    <div class="section-block">
        <h3 class="section-title">🎂 Member Seniority <small>How long accounts have been with you</small></h3>
        <div class="grid-4" id="ageGrid"></div>
    </div>

    <!-- PROFILE COMPLETENESS -->
    <div class="section-block">
        <h3 class="section-title">🧩 Profile Completeness <small>How complete user details are</small></h3>
        <div class="panel"><div id="scoreBox"></div></div>
    </div>

    <!-- A-Z DIRECTORY -->
    <div class="section-block">
        <h3 class="section-title">🔤 A to Z Directory <small>Tap a letter to filter the cards above</small></h3>
        <div class="panel"><div class="az-wrap" id="azBox"></div></div>
    </div>

    <!-- ACCESS LEVELS -->
    <div class="section-block">
        <h3 class="section-title">🔐 Access Levels &amp; Security Rules <small>Who can do what in this panel</small></h3>
        <div class="grid-2">
            <div class="panel">
                <h3><i class="fa-solid fa-key" style="color:var(--tc-gold)"></i> Permission Guide</h3>
                <div class="table-scroll">
                    <table class="perm-table">
                        <thead><tr><th>Action</th><th>Admin</th><th>Member</th></tr></thead>
                        <tbody>
                            <tr><td>Open this admin panel</td><td><span class="yes"><i class="fa-solid fa-check"></i></span></td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td></tr>
                            <tr><td>Add new users</td><td><span class="yes"><i class="fa-solid fa-check"></i></span></td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td></tr>
                            <tr><td>Edit member profiles</td><td><span class="yes"><i class="fa-solid fa-check"></i></span></td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td></tr>
                            <tr><td>Block or unblock members</td><td><span class="yes"><i class="fa-solid fa-check"></i></span></td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td></tr>
                            <tr><td>Delete members</td><td><span class="yes"><i class="fa-solid fa-check"></i></span></td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td></tr>
                            <tr><td>Edit or delete an admin here</td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td><td><span class="no"><i class="fa-solid fa-xmark"></i></span></td></tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="panel">
                <h3><i class="fa-solid fa-shield-halved" style="color:var(--tc-cyan)"></i> Security Rules</h3>
                <ul class="check-list">
                    <li><i class="fa-solid fa-lock"></i><span><strong>Block first, delete later.</strong> Blocking keeps the account and can be undone.</span></li>
                    <li><i class="fa-solid fa-trash-can"></i><span><strong>Delete All</strong> removes only non-admin users. Deleting cannot be undone.</span></li>
                    <li><i class="fa-solid fa-user-shield"></i><span><strong>Admin accounts are protected</strong> and show no edit or delete buttons here.</span></li>
                    <li><i class="fa-solid fa-stethoscope"></i><span><strong>Review the Health Check</strong> often to fix wrong emails and duplicates.</span></li>
                </ul>
            </div>
        </div>
    </div>

    <!-- DESK ACTIONS -->
    <div class="desk">
        <div><h3>👥 User Desk</h3><p>Add a new account, fix a flagged profile or ask the support assistant for help.</p></div>
        <div class="desk-btns">
            <a href="/admin/addUserPage" class="btn-desk ghost"><i class="fa-solid fa-user-plus"></i> Add User</a>
            <button type="button" class="btn-desk" onclick="var b=document.querySelector('.chatbot-toggle, .chatbot-btn'); if(b){b.click();}"><i class="fa-solid fa-comment-dots"></i> Chat With Support</button>
        </div>
    </div>
</div>

<jsp:include page="footer.jsp" />
<jsp:include page="chatbot.jsp" />

<script>
/* jumping title */
(function () {
    var t = document.getElementById('animatedTitle'); if (!t) return;
    var idx = 0, words = t.textContent.trim().split(/\s+/);
    t.innerHTML = words.map(function (w) {
        var l = w.split('').map(function (ch) { return '<span class="ch" style="--i:' + (idx++) + '">' + ch + '</span>'; }).join('');
        idx++; return '<span class="word">' + l + '</span>';
    }).join(' ');
})();

(function () {
    var cards = [].slice.call(document.querySelectorAll('#ucGrid .uc'));
    var MON = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'], DAY = 86400000, now = new Date();
    function $(id) { return document.getElementById(id); }
    function el(t, c, x) { var e = document.createElement(t); if (c) e.className = c; if (x !== undefined) e.textContent = x; return e; }
    function empty(b, m) { b.appendChild(el('p', 'panel-empty', m)); }
    function pd(s) { if (!s) return null; var d = new Date(s.trim()); return isNaN(d) ? null : d; }
    function plural(n, w) { return n + ' ' + w + (n === 1 ? '' : 's'); }
    function g(c, k) { return (c.getAttribute('data-' + k) || '').trim(); }
    function fmt(d) { return d ? d.getDate() + ' ' + MON[d.getMonth()] + ' ' + d.getFullYear() : 'Date unknown'; }
    function ago(d) {
        if (!d) return 'Joined recently';
        var n = Math.floor((now - d) / DAY);
        if (n < 1) return 'Joined today';
        if (n < 30) return 'Joined ' + plural(n, 'day') + ' ago';
        if (n < 365) return 'Joined ' + plural(Math.floor(n / 30), 'month') + ' ago';
        return 'Joined ' + plural(Math.floor(n / 365), 'year') + ' ago';
    }
    function row(avatar, name, sub, right) {
        var r = el('div', 'list-row'), av = el('div', 'list-avatar'); av.innerHTML = avatar; r.appendChild(av);
        var m = el('div', 'list-main'); m.appendChild(el('p', 'list-name', name)); if (sub) m.appendChild(el('p', 'list-sub', sub)); r.appendChild(m);
        if (right) r.appendChild(right); return r;
    }

    var us = cards.map(function (c) {
        var role = g(c, 'role').toUpperCase();
        return { id: g(c, 'id'), name: g(c, 'name'), email: g(c, 'email'), phone: g(c, 'phone'), admin: role === 'ADMIN',
            blocked: g(c, 'blocked') === 'true', joined: pd(g(c, 'joined')) };
    });
    function ini(x) { return (x.name || x.email || '?').charAt(0).toUpperCase(); }
    var nAdmin = us.filter(function (x) { return x.admin; }).length;
    var nBlocked = us.filter(function (x) { return x.blocked && !x.admin; }).length;
    var nMember = us.length - nAdmin - nBlocked;
    $('tAll').textContent = us.length; $('tAdmin').textContent = nAdmin; $('tMember').textContent = nMember; $('tBlocked').textContent = nBlocked;

    /* cards */
    cards.forEach(function (c, i) {
        var x = us[i];
        c.querySelector('.uc-init').textContent = ini(x);
        c.querySelector('.jn').textContent = ago(x.joined);
        if (!x.phone) c.querySelector('.ph').classList.add('muted');
    });
    document.addEventListener('click', function (e) {
        var b = e.target.closest ? e.target.closest('.copy-btn') : null; if (!b) return;
        var card = b.closest('.uc'), i = cards.indexOf(card), val = b.getAttribute('data-copy') === 'email' ? us[i].email : us[i].phone;
        if (!val) return;
        function ok() { b.classList.add('ok'); b.innerHTML = '<i class="fa-solid fa-check"></i>'; setTimeout(function () { b.classList.remove('ok'); b.innerHTML = '<i class="fa-regular fa-copy"></i>'; }, 1400); }
        if (navigator.clipboard && navigator.clipboard.writeText) navigator.clipboard.writeText(val).then(ok);
        else { var t = document.createElement('textarea'); t.value = val; document.body.appendChild(t); t.select(); try { document.execCommand('copy'); ok(); } catch (er) {} document.body.removeChild(t); }
    });

    /* newest members */
    var nb = $('newest'), nw = us.filter(function (x) { return x.joined; }).sort(function (p, q) { return q.joined - p.joined; }).slice(0, 5);
    if (!nw.length) empty(nb, 'Join dates will appear here once users have a created date.');
    else { var tl = el('div', 'tl'); nw.forEach(function (x) {
        var it = el('div', 'tl-item'); it.appendChild(el('div', 'tl-time', ago(x.joined).replace('Joined ', '')));
        it.appendChild(el('div', 'tl-name', x.name || 'Unnamed user')); it.appendChild(el('div', 'tl-sub', x.email + '  •  ' + fmt(x.joined))); tl.appendChild(it); }); nb.appendChild(tl); }

    /* ring */
    var rb = $('ringBox');
    if (!us.length) empty(rb, 'No accounts yet.');
    else {
        var a = Math.round(nAdmin / us.length * 100), b2 = a + Math.round(nMember / us.length * 100), w = el('div', 'ring-wrap');
        var ring = el('div', 'ring'); ring.style.setProperty('--a', a); ring.style.setProperty('--b', b2);
        var mid = el('div'); mid.appendChild(el('b', '', String(us.length))); mid.appendChild(el('span', '', 'Accounts')); ring.appendChild(mid); w.appendChild(ring);
        var lg = el('div', 'legend');
        [['var(--tc-gold)', 'Admins', nAdmin], ['var(--tc-green)', 'Active members', nMember], ['var(--tc-rose)', 'Blocked', nBlocked]].forEach(function (p) {
            var r = el('div'), s = el('i'); s.style.background = p[0]; r.appendChild(s); r.appendChild(document.createTextNode(p[1] + ': ' + p[2])); lg.appendChild(r); });
        w.appendChild(lg); rb.appendChild(w);
    }

    /* signup trend */
    var tr = $('trend'), months = [], cy = now.getFullYear(), cm = now.getMonth();
    for (var k = 5; k >= 0; k--) { var d0 = new Date(cy, cm - k, 1); months.push({ y: d0.getFullYear(), m: d0.getMonth(), n: 0 }); }
    us.forEach(function (x) { if (!x.joined) return; months.forEach(function (mo) { if (mo.y === x.joined.getFullYear() && mo.m === x.joined.getMonth()) mo.n++; }); });
    var mx = Math.max.apply(null, months.map(function (m) { return m.n; }));
    if (!mx) empty(tr, 'No signups in the last 6 months.');
    else { var box = el('div', 'trend'); months.forEach(function (mo) {
        var col = el('div', 't-col'); col.appendChild(el('b', '', String(mo.n)));
        var bar = el('div', 't-bar'); bar.style.height = Math.max(3, mo.n / mx * 100) + '%'; bar.style.opacity = mo.n ? 1 : .3; col.appendChild(bar);
        col.appendChild(el('span', '', MON[mo.m])); box.appendChild(col); }); tr.appendChild(box); }

    /* email domains */
    var dm = $('domains'), dmap = {};
    us.forEach(function (x) { var at = x.email.lastIndexOf('@'); if (at > 0) { var d = x.email.slice(at + 1).toLowerCase(); dmap[d] = (dmap[d] || 0) + 1; } });
    var dk = Object.keys(dmap).sort(function (p, q) { return dmap[q] - dmap[p]; }).slice(0, 5);
    if (!dk.length) empty(dm, 'No email data yet.');
    else { var colors = ['var(--tc-cyan)', 'var(--tc-green)', 'var(--tc-gold)', 'var(--tc-rose)', 'var(--tc-purple)'], top = dmap[dk[0]];
        dk.forEach(function (k2, i) {
            var r = el('div', 'bar-row'), lb = el('div', 'bar-label'); lb.appendChild(el('span', '', '@' + k2));
            var nn = el('span', '', plural(dmap[k2], 'user')); nn.style.color = colors[i]; lb.appendChild(nn);
            var t = el('div', 'bar-track'), f = el('div', 'bar-fill'); f.style.width = Math.max(8, dmap[k2] / top * 100) + '%'; f.style.background = colors[i];
            t.appendChild(f); r.appendChild(lb); r.appendChild(t); dm.appendChild(r); }); }

    /* blocked watchlist */
    var bl = $('blockedList'), bu = us.filter(function (x) { return x.blocked && !x.admin; });
    if (!bu.length) empty(bl, '✅ No blocked accounts right now.');
    else bu.slice(0, 6).forEach(function (x) {
        var a2 = el('a', 'mini-link green', 'Unblock'); a2.href = '/admin/toggleBlock/' + x.id;
        bl.appendChild(row(ini(x), x.name || 'Unnamed user', x.email + '  •  ' + ago(x.joined).replace('Joined ', 'joined '), a2)); });
    if (bu.length > 6) { var mo2 = el('p', 'panel-empty', '+ ' + (bu.length - 6) + ' more blocked account(s).'); mo2.style.marginTop = '12px'; bl.appendChild(mo2); }

    /* admin team */
    var ag = $('adminGrid'), ad = us.filter(function (x) { return x.admin; });
    if (!ad.length) { ag.style.display = 'block'; empty(ag, 'No admin accounts found.'); }
    else ad.forEach(function (x) {
        var c = el('div', 'admin-card'), av = el('div', 'list-avatar', ini(x)); c.appendChild(av);
        var m = el('div', 'list-main'); m.appendChild(el('p', 'list-name', x.name || 'Admin')); m.appendChild(el('p', 'list-sub', x.email)); c.appendChild(m);
        var lk = el('i', 'fa-solid fa-lock lock'); c.appendChild(lk); ag.appendChild(c); });

    /* health check */
    var hl = $('healthList'), seen = {}, dup = {};
    us.forEach(function (x) { var e = x.email.toLowerCase(); if (!e) return; if (seen[e]) dup[e] = 1; seen[e] = 1; });
    var re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    var issues = us.map(function (x) {
        var l = [];
        if (!x.name) l.push('Name missing');
        if (!x.email) l.push('Email missing'); else if (!re.test(x.email)) l.push('Email looks wrong'); else if (dup[x.email.toLowerCase()]) l.push('Duplicate email');
        if (!x.phone) l.push('Phone missing');
        if (!x.joined) l.push('Join date unknown');
        return { x: x, l: l };
    }).filter(function (r) { return r.l.length; });
    if (!us.length) empty(hl, 'Add a user to see checks here.');
    else if (!issues.length) empty(hl, '✅ Every account has a name, valid email, phone and join date.');
    else {
        issues.slice(0, 5).forEach(function (r) {
            var lk = null; if (!r.x.admin) { lk = el('a', 'mini-link', 'Fix'); lk.href = '/admin/editUser/' + r.x.id; }
            var rw = row(ini(r.x), r.x.name || r.x.email || 'Unnamed user', '', lk); rw.querySelector('.list-main').removeChild(rw.querySelector('.list-sub'));
            var tg = el('div', 'tags'); r.l.forEach(function (s) { tg.appendChild(el('span', 'tag', s)); }); rw.querySelector('.list-main').appendChild(tg); hl.appendChild(rw); });
        if (issues.length > 5) { var m3 = el('p', 'panel-empty', '+ ' + (issues.length - 5) + ' more account(s) need attention.'); m3.style.marginTop = '12px'; hl.appendChild(m3); }
    }

    /* member seniority */
    var sg = $('ageGrid'), joinedUs = us.filter(function (x) { return x.joined; });
    if (!joinedUs.length) { sg.style.display = 'block'; empty(sg, 'Seniority appears once users have a created date.'); }
    else {
        var groups = [
            { l: 'New this week', s: 'Joined in the last 7 days', i: 'fa-seedling', c: 'var(--tc-green)', f: function (d) { return d < 7; } },
            { l: 'This month', s: '7 to 29 days old', i: 'fa-calendar-day', c: 'var(--tc-cyan)', f: function (d) { return d >= 7 && d < 30; } },
            { l: 'Growing', s: '1 to 6 months old', i: 'fa-hourglass-half', c: 'var(--tc-gold)', f: function (d) { return d >= 30 && d < 180; } },
            { l: 'Veterans', s: 'Over 6 months old', i: 'fa-medal', c: 'var(--tc-purple)', f: function (d) { return d >= 180; } }
        ];
        groups.forEach(function (gr) {
            var n = joinedUs.filter(function (x) { return gr.f(Math.floor((now - x.joined) / DAY)); }).length;
            var c = el('div', 'age-card'); c.style.setProperty('--ac', gr.c);
            var ic = el('div', 'age-ico'); ic.innerHTML = '<i class="fa-solid ' + gr.i + '"></i>'; c.appendChild(ic);
            c.appendChild(el('div', 'age-num', String(n))); c.appendChild(el('div', 'age-lbl', gr.l)); c.appendChild(el('div', 'age-sub', gr.s));
            var tk = el('div', 'age-track'), fl = el('i'); fl.style.width = Math.round(n / joinedUs.length * 100) + '%'; tk.appendChild(fl); c.appendChild(tk); sg.appendChild(c);
        });
    }

    /* profile completeness */
    var sb = $('scoreBox');
    if (!us.length) empty(sb, 'Add users to see completeness.');
    else {
        var fields = [
            ['Name', us.filter(function (x) { return x.name; }).length, 'var(--tc-cyan)'],
            ['Valid email', us.filter(function (x) { return re.test(x.email); }).length, 'var(--tc-green)'],
            ['Phone number', us.filter(function (x) { return x.phone; }).length, 'var(--tc-gold)'],
            ['Join date', us.filter(function (x) { return x.joined; }).length, 'var(--tc-purple)']
        ];
        var pcts = fields.map(function (f) { return Math.round(f[1] / us.length * 100); });
        var overall = Math.round(pcts.reduce(function (a, b) { return a + b; }, 0) / pcts.length);
        var sw = el('div', 'score-wrap'), sr = el('div', 'score-ring'); sr.style.setProperty('--p', overall);
        var inner = el('div'); inner.appendChild(el('b', '', overall + '%')); inner.appendChild(el('span', '', 'Complete')); sr.appendChild(inner); sw.appendChild(sr);
        var bars = el('div', 'score-bars');
        fields.forEach(function (f, i) {
            var r = el('div', 'bar-row'), lb = el('div', 'bar-label'); lb.appendChild(el('span', '', f[0]));
            var nn = el('span', '', pcts[i] + '%  (' + f[1] + '/' + us.length + ')'); nn.style.color = f[2]; lb.appendChild(nn);
            var t = el('div', 'bar-track'), fi = el('div', 'bar-fill'); fi.style.width = Math.max(pcts[i], 2) + '%'; fi.style.background = f[2];
            t.appendChild(fi); r.appendChild(lb); r.appendChild(t); bars.appendChild(r);
        });
        sw.appendChild(bars); sb.appendChild(sw);
    }

    /* A-Z directory (filters the cards) */
    var letter = '', azb = $('azBox'), lm = {};
    function key(x) { var L = ini(x); return /[A-Z]/.test(L) ? L : '#'; }
    us.forEach(function (x) { var k3 = key(x); lm[k3] = (lm[k3] || 0) + 1; });
    var lks = Object.keys(lm).sort();
    if (!lks.length) empty(azb, 'No users to list yet.');
    else {
        var chips = [];
        function chip(val, label, count) {
            var b = el('button', 'az-chip' + (val === '' ? ' active' : '')); b.type = 'button';
            b.appendChild(el('b', '', label)); b.appendChild(el('span', '', String(count)));
            b.addEventListener('click', function () {
                chips.forEach(function (o) { o.classList.remove('active'); }); b.classList.add('active'); letter = val; apply();
                var grid = $('ucGrid'); if (grid.scrollIntoView) grid.scrollIntoView({ behavior: 'smooth', block: 'start' });
            });
            chips.push(b); azb.appendChild(b);
        }
        chip('', 'All', us.length);
        lks.forEach(function (k4) { chip(k4, k4, lm[k4]); });
    }

    /* search + tab filter */
    var search = $('userSearch'), nr = $('noResults'), badge = $('totalBadge'), tabs = [].slice.call(document.querySelectorAll('#tabs .tab')), active = 'all';
    function apply() {
        var q = search.value.trim().toLowerCase(), vis = 0;
        cards.forEach(function (c, i) {
            var x = us[i], txt = (x.name + ' ' + x.email + ' ' + x.phone).toLowerCase();
            var sOk = active === 'all' || (active === 'admin' && x.admin) || (active === 'blocked' && x.blocked && !x.admin) || (active === 'member' && !x.admin && !x.blocked);
            var ok = (!q || txt.indexOf(q) > -1) && sOk && (!letter || key(x) === letter); c.style.display = ok ? '' : 'none'; if (ok) vis++; });
        nr.style.display = (us.length && !vis) ? '' : 'none'; badge.textContent = vis;
    }
    search.addEventListener('input', apply);
    tabs.forEach(function (b) { b.addEventListener('click', function () {
        tabs.forEach(function (o) { o.classList.remove('active'); }); b.classList.add('active'); active = b.getAttribute('data-filter'); apply(); }); });
})();
</script>
</body>
</html>
