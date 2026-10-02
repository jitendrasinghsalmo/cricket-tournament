<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>ProMatch Arena | Match Command Center</title>
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
.header-bar{display:grid;grid-template-columns:1fr auto 1fr;align-items:center;gap:16px;margin-bottom:22px;padding:18px 30px;border-radius:18px;background:var(--tc-card);border:1px solid var(--tc-border)}
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

/* score ticker */
.ticker{overflow:hidden;border-radius:14px;background:var(--tc-card);border:1px solid var(--tc-border);display:flex;align-items:center;margin-bottom:22px}
.ticker-label{flex-shrink:0;background:var(--tc-rose);color:#fff;font-size:11px;font-weight:900;letter-spacing:1px;text-transform:uppercase;padding:14px 16px;display:flex;align-items:center;gap:8px}
.ticker-label i{animation:blink 1.2s infinite}
@keyframes blink{50%{opacity:.25}}
.ticker-view{overflow:hidden;flex:1;min-width:0}
.ticker-track{display:inline-flex;white-space:nowrap;animation:scroll 40s linear infinite}
.ticker-view:hover .ticker-track{animation-play-state:paused}
@keyframes scroll{to{transform:translateX(-50%)}}
.tk-item{padding:0 26px;font-size:13px;font-weight:700;color:var(--tc-muted);display:inline-flex;align-items:center;gap:10px;border-right:1px dashed var(--tc-border)}
.tk-item b{color:var(--tc-text)}.tk-item em{font-style:normal;color:var(--tc-green)}
.ticker-empty{padding:14px 18px;font-size:13px;color:var(--tc-muted);font-weight:600}

/* search + status tabs */
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
.tab[data-filter="all"]{--tk:var(--tc-gold);--tk-bg:rgba(255,215,0,.13)}
.tab[data-filter="ongoing"]{--tk:var(--tc-green);--tk-bg:rgba(0,255,136,.13)}
.tab[data-filter="upcoming"]{--tk:var(--tc-cyan);--tk-bg:rgba(0,217,255,.13)}
.tab[data-filter="completed"]{--tk:var(--tc-purple);--tk-bg:rgba(181,55,242,.13)}

/* match cards */
.mx-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(350px,1fr));gap:24px}
.mc{--sc:var(--tc-cyan);position:relative;overflow:hidden;background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:22px;padding:18px;display:flex;flex-direction:column;gap:14px;transition:.3s;box-shadow:0 10px 30px rgba(0,0,0,.22)}
.mc::before{content:'';position:absolute;inset:0 0 auto 0;height:110px;background:linear-gradient(180deg,var(--sc),transparent);opacity:.13;pointer-events:none}
.mc.s-ongoing{--sc:var(--tc-green)}.mc.s-completed{--sc:var(--tc-purple)}
.mc:hover{transform:translateY(-6px);border-color:var(--sc);box-shadow:0 20px 42px rgba(0,217,255,.18)}
.mc>*{position:relative}
.mc-head{display:flex;justify-content:space-between;align-items:center;gap:10px}
.mc-tour{font-size:12px;font-weight:800;color:var(--tc-muted);min-width:0;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.mc-tour i{color:var(--tc-gold);margin-right:6px}
.tagst{font-size:10px;font-weight:800;padding:4px 11px;border-radius:20px;text-transform:uppercase;display:inline-flex;align-items:center;gap:6px;color:var(--sc);border:1.5px solid var(--sc);background:var(--tc-card-alt);flex-shrink:0}
.tagst::before{content:'';width:6px;height:6px;border-radius:50%;background:currentColor}
.s-ongoing .tagst::before{animation:blink 1.2s infinite}
.mc-face{display:grid;grid-template-columns:minmax(0,1fr) auto minmax(0,1fr);align-items:center;gap:8px;padding:6px 0}
.tm{text-align:center;min-width:0}
.av{width:56px;height:56px;margin:0 auto 8px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-size:22px;font-weight:900;color:#030712;background:linear-gradient(135deg,var(--tc-cyan),var(--tc-green));border:3px solid transparent;position:relative}
.t-b .av{background:linear-gradient(135deg,var(--tc-purple),var(--tc-rose));color:#fff}
.tm.win .av{border-color:var(--tc-gold);box-shadow:0 0 18px rgba(255,215,0,.55)}
.tm.win .av::after{content:'\f521';font-family:'Font Awesome 6 Free';font-weight:900;position:absolute;top:-14px;right:-6px;color:var(--tc-gold);font-size:15px;transform:rotate(18deg)}
.nm{font-size:13.5px;font-weight:800;line-height:1.25;display:-webkit-box;-webkit-line-clamp:2;-webkit-box-orient:vertical;overflow:hidden;overflow-wrap:anywhere;min-height:2.5em}
.rn{margin-top:6px;font-family:ui-monospace,Menlo,Consolas,monospace;font-size:22px;font-weight:800}
.rn small{font-size:10.5px;font-weight:600;color:var(--tc-muted);margin-left:3px}
.tm.win .rn{color:var(--tc-green)}
.mid{text-align:center}
.vs{display:inline-block;font-size:11px;font-weight:900;letter-spacing:1px;padding:7px 9px;border-radius:50%;background:var(--tc-card-alt);border:1.5px solid var(--tc-border);color:var(--tc-muted)}
.mid-id{display:block;margin-top:6px;font-size:9.5px;font-weight:800;color:var(--tc-muted)}
.split{display:flex;height:8px;border-radius:8px;overflow:hidden;background:var(--tc-card-alt);border:1px solid var(--tc-border)}
.split i{display:block;height:100%;width:50%;transition:width .8s ease}
.split .sa{background:linear-gradient(90deg,var(--tc-cyan),var(--tc-green))}
.split .sb{background:linear-gradient(90deg,var(--tc-purple),var(--tc-rose))}
.split.none{opacity:.35}
.mc-foot{display:grid;grid-template-columns:1fr 1fr;gap:10px;font-size:12px;font-weight:700}
.mc-foot div{display:flex;align-items:center;gap:8px;min-width:0;padding:9px 11px;border-radius:12px;background:var(--tc-card-alt);border:1px solid var(--tc-border)}
.mc-foot span{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.result{font-size:12px;font-weight:800;padding:9px 12px;border-radius:12px;text-align:center;color:var(--tc-muted);border:1px dashed var(--tc-border)}
.result.has{color:var(--tc-green);background:rgba(0,255,136,.08);border:1px solid rgba(0,255,136,.35)}
.mc-actions{display:flex;gap:10px;margin-top:auto}
.mc-actions a{height:40px;text-decoration:none;border-radius:12px;font-size:11px;font-weight:800;display:inline-flex;align-items:center;justify-content:center;gap:7px;text-transform:uppercase;transition:.2s}
.btn-edit{flex:1;background:rgba(0,217,255,.15);color:var(--tc-cyan);border:1.5px solid var(--tc-cyan)}
.btn-edit:hover{background:var(--tc-cyan);color:#030712}
.btn-delete{width:46px;background:rgba(255,0,110,.15);color:var(--tc-rose);border:1.5px solid var(--tc-rose)}
.btn-delete:hover{background:var(--tc-rose);color:#fff}
.no-data{text-align:center;color:var(--tc-muted);grid-column:1/-1;padding:46px 20px;font-size:14px;font-weight:700;background:var(--tc-card);border:1px dashed var(--tc-border);border-radius:16px}

.pagination-bar{display:flex;justify-content:flex-end;align-items:center;gap:14px;margin-top:30px;flex-wrap:wrap}
.pagination-bar a,.pagination-bar .disabled{height:40px;padding:0 20px;border-radius:10px;text-decoration:none;font-weight:800;font-size:12px;display:inline-flex;align-items:center}
.pagination-bar a{background:linear-gradient(135deg,var(--tc-cyan),var(--tc-green));color:#030712}
.pagination-bar .disabled{opacity:.35;background:rgba(148,163,184,.1);color:var(--tc-muted)}
.page-indicator{font-size:13px;font-weight:700;color:var(--tc-muted)}

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

/* fixture timeline */
.tl{position:relative;padding-left:26px}
.tl::before{content:'';position:absolute;left:7px;top:6px;bottom:6px;width:2px;background:linear-gradient(180deg,var(--tc-cyan),var(--tc-purple));opacity:.5}
.tl-item{position:relative;padding-bottom:18px}.tl-item:last-child{padding-bottom:0}
.tl-item::before{content:'';position:absolute;left:-26px;top:3px;width:16px;height:16px;border-radius:50%;background:var(--tc-card);border:3px solid var(--tc-cyan)}
.tl-item.live::before{border-color:var(--tc-green);animation:blink 1.2s infinite}
.tl-time{font-size:11px;font-weight:800;color:var(--tc-cyan);text-transform:uppercase}
.tl-name{margin:3px 0;font-size:14px;font-weight:800;overflow-wrap:anywhere}
.tl-sub{font-size:11.5px;color:var(--tc-muted);font-weight:600}

/* status ring */
.ring-wrap{display:flex;align-items:center;gap:26px;flex-wrap:wrap;justify-content:center}
.ring{--a:0;--b:0;width:170px;height:170px;border-radius:50%;background:conic-gradient(var(--tc-green) 0 calc(var(--a)*1%),var(--tc-cyan) calc(var(--a)*1%) calc(var(--b)*1%),var(--tc-purple) calc(var(--b)*1%) 100%);display:flex;align-items:center;justify-content:center;flex-shrink:0}
.ring.empty{background:var(--tc-border)}
.ring div{width:118px;height:118px;border-radius:50%;background:var(--tc-card);display:flex;flex-direction:column;align-items:center;justify-content:center}
.ring b{font-size:30px;font-weight:900;line-height:1}.ring span{font-size:10.5px;font-weight:800;color:var(--tc-muted);text-transform:uppercase;margin-top:4px}
.legend{display:flex;flex-direction:column;gap:12px;font-size:13px;font-weight:700}
.legend i{display:inline-block;width:12px;height:12px;border-radius:4px;margin-right:9px}

/* face-off + lists */
.fo-row{margin-bottom:16px}.fo-row:last-child{margin-bottom:0}
.fo-name{font-size:12.5px;font-weight:800;margin-bottom:6px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.fo-line{display:flex;align-items:center;gap:8px;margin-bottom:4px;font-size:11px;font-weight:800;color:var(--tc-muted)}
.fo-line span{width:34px;flex-shrink:0;text-align:right;color:var(--tc-text)}
.fo-bar{height:9px;border-radius:6px;min-width:4px}
.list-row{display:flex;align-items:center;gap:12px;padding:12px 0;border-bottom:1px solid var(--tc-border)}
.list-row:last-child{border-bottom:none;padding-bottom:0}.list-row:first-child{padding-top:0}
.list-avatar{width:40px;height:40px;border-radius:12px;flex-shrink:0;background:linear-gradient(135deg,var(--tc-cyan),var(--tc-green));color:#030712;display:flex;align-items:center;justify-content:center;font-weight:900}
.list-main{flex:1;min-width:0}
.list-name{margin:0;font-size:13.5px;font-weight:800;overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.list-sub{margin:2px 0 0;font-size:11.5px;color:var(--tc-muted);overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.big-num{font-size:17px;font-weight:900;color:var(--tc-gold);white-space:nowrap}
.tags{display:flex;gap:5px;flex-wrap:wrap;margin-top:6px}
.tag{font-size:10px;font-weight:800;padding:3px 9px;border-radius:20px;text-transform:uppercase;color:var(--tc-amber);background:rgba(255,165,0,.14);border:1px solid rgba(255,165,0,.35)}
.mini-link{font-size:11px;font-weight:800;color:var(--tc-cyan);text-decoration:none;border:1.5px solid var(--tc-cyan);padding:6px 12px;border-radius:8px;white-space:nowrap}
.mini-link:hover{background:var(--tc-cyan);color:#030712}

/* tools */
.sel-row{display:grid;grid-template-columns:1fr auto 1fr;gap:10px;align-items:center}
.sel-row em{font-style:normal;font-weight:900;font-size:11px;color:var(--tc-muted)}
.field,.sel-row select{width:100%;height:42px;background:var(--tc-input);border:1.5px solid var(--tc-border);border-radius:10px;padding:0 12px;color:var(--tc-text);font-size:14px;font-family:inherit;outline:none;min-width:0}
.field:focus,.sel-row select:focus{border-color:var(--tc-cyan)}
.h2h-out{margin-top:16px;display:grid;grid-template-columns:1fr auto 1fr;align-items:center;text-align:center;gap:10px}
.h2h-out b{display:block;font-size:34px;font-weight:900;color:var(--tc-cyan)}.h2h-out .r b{color:var(--tc-purple)}
.h2h-out span{font-size:11px;font-weight:700;color:var(--tc-muted)}
.h2h-note{margin:12px 0 0;text-align:center;font-size:12px;font-weight:600;color:var(--tc-muted)}
.calc-grid{display:grid;grid-template-columns:1fr 1fr;gap:10px}
.calc-grid label{font-size:10.5px;font-weight:800;color:var(--tc-muted);text-transform:uppercase;display:block;margin-bottom:5px}
.calc-out{margin-top:14px;padding:14px;border-radius:14px;text-align:center;background:var(--tc-card-alt);border:1.5px dashed var(--tc-border)}
.calc-out b{font-size:26px;font-weight:900;color:var(--tc-green)}.calc-out b.neg{color:var(--tc-rose)}
.calc-out span{display:block;font-size:11px;font-weight:700;color:var(--tc-muted);margin-top:4px}
.calc-title{font-size:12px;font-weight:800;text-transform:uppercase;color:var(--tc-gold);margin:0 0 10px}
.calc-sep{height:1px;background:var(--tc-border);margin:20px 0}

.read-card{background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:18px;padding:22px;display:flex;gap:16px;align-items:flex-start}
.read-ico{width:48px;height:48px;border-radius:14px;flex-shrink:0;display:flex;align-items:center;justify-content:center;font-size:19px;color:var(--c);background:var(--cb);border:1px solid var(--c)}
.read-card h5{margin:0 0 6px;font-size:14px;font-weight:800}
.read-card p{margin:0;font-size:12.5px;color:var(--tc-muted);line-height:1.6}

.desk{margin:44px 0 10px;border-radius:22px;padding:28px 34px;background:linear-gradient(135deg,rgba(0,217,255,.14),rgba(181,55,242,.1)),var(--tc-card);border:2px solid var(--tc-cyan);display:flex;align-items:center;justify-content:space-between;gap:20px;flex-wrap:wrap}
.desk h3{margin:0 0 6px;font-size:clamp(17px,4.5vw,22px);font-weight:900;text-transform:uppercase}
.desk p{margin:0;font-size:13.5px;color:var(--tc-muted);font-weight:600;max-width:520px;line-height:1.6}
.desk-btns{display:flex;gap:12px;flex-wrap:wrap}
.btn-desk{background:linear-gradient(135deg,var(--tc-cyan),var(--tc-green));color:#030712;border:none;height:48px;padding:0 24px;border-radius:14px;font-weight:900;font-size:13px;text-transform:uppercase;cursor:pointer;text-decoration:none;display:inline-flex;align-items:center;justify-content:center;gap:9px;white-space:nowrap;font-family:inherit}
.btn-desk.ghost{background:transparent;color:var(--tc-cyan);border:2px solid var(--tc-cyan)}

/* ground guide */
.venue-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(230px,1fr));gap:18px}
.venue-card{background:var(--tc-card);border:1.5px solid var(--tc-border);border-radius:18px;padding:18px;position:relative;overflow:hidden;transition:.3s}
.venue-card:hover{transform:translateY(-5px);border-color:var(--vc)}
.venue-card::after{content:'\f3c5';font-family:'Font Awesome 6 Free';font-weight:900;position:absolute;right:-8px;bottom:-16px;font-size:80px;color:var(--vc);opacity:.07}
.venue-top{display:flex;align-items:center;gap:12px;margin-bottom:14px}
.venue-ico{width:42px;height:42px;border-radius:12px;flex-shrink:0;display:flex;align-items:center;justify-content:center;color:var(--vc);border:1.5px solid var(--vc);background:var(--tc-card-alt)}
.venue-name{font-size:14px;font-weight:800;min-width:0;overflow-wrap:anywhere}
.venue-stats{display:grid;grid-template-columns:1fr 1fr;gap:10px}
.venue-stats div{background:var(--tc-card-alt);border:1px solid var(--tc-border);border-radius:12px;padding:10px;text-align:center}
.venue-stats b{display:block;font-size:20px;font-weight:900;color:var(--vc);line-height:1}
.venue-stats span{display:block;margin-top:5px;font-size:10px;font-weight:800;text-transform:uppercase;color:var(--tc-muted)}
.venue-last{margin:12px 0 0;font-size:11.5px;font-weight:600;color:var(--tc-muted)}

/* team form guide */
.dots{display:flex;gap:5px;flex-shrink:0}
.dots span{width:24px;height:24px;border-radius:7px;display:flex;align-items:center;justify-content:center;font-size:10.5px;font-weight:900}
.dots .w{background:rgba(0,255,136,.16);color:var(--tc-green);border:1px solid rgba(0,255,136,.45)}
.dots .l{background:rgba(255,0,110,.14);color:var(--tc-rose);border:1px solid rgba(255,0,110,.45)}
.dots .d{background:rgba(148,163,184,.14);color:var(--tc-muted);border:1px solid var(--tc-border)}
.form-row{display:flex;align-items:center;gap:12px;padding:13px 0;border-bottom:1px solid var(--tc-border)}
.form-row:last-child{border-bottom:none;padding-bottom:0}.form-row:first-child{padding-top:0}
.rank{width:26px;font-size:15px;font-weight:900;color:var(--tc-muted);text-align:center;flex-shrink:0}
.form-row:nth-child(1) .rank{color:var(--tc-gold)}.form-row:nth-child(2) .rank{color:var(--tc-cyan)}.form-row:nth-child(3) .rank{color:var(--tc-amber)}
.form-legend{display:flex;gap:16px;flex-wrap:wrap;margin-top:16px;font-size:11.5px;font-weight:700;color:var(--tc-muted)}

/* match calendar */
.cal-head,.cal-grid{display:grid;grid-template-columns:repeat(7,1fr);gap:8px}
.cal-head{margin-bottom:8px}
.cal-head span{text-align:center;font-size:11px;font-weight:800;text-transform:uppercase;color:var(--tc-muted)}
.cal-cell{min-height:64px;border-radius:12px;background:var(--tc-card-alt);border:1.5px solid var(--tc-border);padding:7px 8px;display:flex;flex-direction:column;justify-content:space-between;min-width:0}
.cal-cell.blank{background:transparent;border-color:transparent}
.cal-cell .cd{font-size:13px;font-weight:800;color:var(--tc-muted)}
.cal-cell .cc{align-self:flex-end;font-size:10px;font-weight:900;padding:2px 8px;border-radius:20px;background:var(--tc-cyan);color:#030712;white-space:nowrap}
.cal-cell.has{border-color:rgba(0,217,255,.55)}.cal-cell.has .cd{color:var(--tc-text)}
.cal-cell.live .cc{background:var(--tc-green)}
.cal-cell.now{border-color:var(--tc-green);background:linear-gradient(135deg,rgba(0,217,255,.14),rgba(0,255,136,.1)),var(--tc-card-alt)}
.cal-cell.now .cd{color:var(--tc-green)}
@media(max-width:640px){.cal-head,.cal-grid{gap:4px}.cal-cell{min-height:48px;padding:5px;border-radius:8px}.cal-cell .cd{font-size:11px}.cal-cell .cc{font-size:9px;padding:1px 6px}.dots span{width:21px;height:21px}.form-row{gap:8px}.venue-grid{grid-template-columns:1fr}}

/* responsive */
@media(max-width:1100px){.grid-3{grid-template-columns:1fr 1fr}.grid-2{grid-template-columns:1fr}.tabs{grid-template-columns:repeat(2,1fr)}}
@media(max-width:900px){.header-bar{grid-template-columns:1fr;text-align:center;padding:18px 16px}.header-left,.header-right{justify-content:center}}
@media(max-width:640px){
.wrap{padding:0 14px;margin:20px auto}
.header-right{width:100%}.header-right a{flex:1;justify-content:center;padding:0 10px;font-size:12px}
.ticker-label{padding:14px 12px;font-size:10px}.ticker-label span{display:none}
.search-wrap{max-width:none;flex-basis:100%}.search-input{font-size:16px}
.tabs{gap:10px}.tab{padding:12px;gap:10px}.tab i{width:36px;height:36px;font-size:15px}.tab b{font-size:21px}
.mx-grid{grid-template-columns:1fr;gap:18px}
.av{width:50px;height:50px;font-size:19px}.rn{font-size:19px}
.grid-3{grid-template-columns:1fr}
.section-title small{margin-left:0;width:100%}
.panel{padding:18px 14px}
.ring-wrap{gap:18px}.ring{width:150px;height:150px}.ring div{width:104px;height:104px}
.sel-row{grid-template-columns:1fr}.sel-row em{text-align:center}
.desk{padding:22px 18px;flex-direction:column;text-align:center}.desk-btns{width:100%;flex-direction:column}.btn-desk{width:100%}
.pagination-bar{justify-content:center}
}
@media(max-width:380px){.mc-foot{grid-template-columns:1fr}.tabs{grid-template-columns:1fr 1fr}.tab span{font-size:10.5px}}
@media(prefers-reduced-motion:reduce){.ticker-track,.jumping-title .ch{animation:none!important}.jumping-title .ch{opacity:1;transform:none}.ticker-view{overflow-x:auto}}

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
        <h2 class="jumping-title" id="animatedTitle">Match Command Center</h2>
        <div class="header-right">
            <a href="/admin/addMatchPage" class="btn-add"><i class="fa-solid fa-plus"></i> Schedule Match</a>
            <c:if test="${not empty matches}">
                <a href="/admin/deleteAllMatches" class="btn-del-all" onclick="return confirm('DANGER: Are you sure you want to delete all matches?');"><i class="fa-solid fa-trash-can"></i> Delete All</a>
            </c:if>
        </div>
    </div>

    <!-- SCORE TICKER -->
    <div class="ticker">
        <div class="ticker-label"><i class="fa-solid fa-tower-broadcast"></i><span>Score Ticker</span></div>
        <div class="ticker-view" id="tickerView"></div>
    </div>

    <!-- SEARCH + STATUS TABS (tabs = filter) -->
    <div class="search-row">
        <div class="search-wrap"><i class="fa-solid fa-magnifying-glass"></i><input type="text" id="mxSearch" class="search-input" placeholder="Search team, venue or tournament..." autocomplete="off"></div>
        <div class="show-badge">Showing <span id="totalBadge">${empty totalItems ? (empty matches ? 0 : matches.size()) : totalItems}</span> matches</div>
    </div>
    <div class="tabs" id="tabs">
        <button type="button" class="tab active" data-filter="all"><i class="fa-solid fa-layer-group"></i><div><b id="tAll">0</b><span>All Matches</span></div></button>
        <button type="button" class="tab" data-filter="ongoing"><i class="fa-solid fa-tower-broadcast"></i><div><b id="tLive">0</b><span>On Air</span></div></button>
        <button type="button" class="tab" data-filter="upcoming"><i class="fa-solid fa-clock"></i><div><b id="tUp">0</b><span>Coming Up</span></div></button>
        <button type="button" class="tab" data-filter="completed"><i class="fa-solid fa-circle-check"></i><div><b id="tDone">0</b><span>Full Time</span></div></button>
    </div>

    <!-- CARDS -->
    <div class="mx-grid" id="mxGrid">
        <c:forEach items="${matches}" var="m">
            <div class="mc"
                 data-id="<c:out value='${m.id}'/>"
                 data-status="<c:out value='${m.status}'/>"
                 data-tour="<c:out value="${m.tournament != null ? m.tournament.tournamentName : ''}"/>"
                 data-a="<c:out value="${m.teamA != null ? m.teamA.teamName : ''}"/>"
                 data-b="<c:out value="${m.teamB != null ? m.teamB.teamName : ''}"/>"
                 data-venue="<c:out value='${m.venue}'/>"
                 data-dt="<c:out value='${m.matchDateTime}'/>"
                 data-ra="<c:out value='${m.runsScoredA}' default='0'/>" data-oa="<c:out value='${m.oversFacedA}' default='0'/>"
                 data-rb="<c:out value='${m.runsScoredB}' default='0'/>" data-ob="<c:out value='${m.oversFacedB}' default='0'/>"
                 data-winner="<c:out value="${m.winner != null ? m.winner.teamName : ''}"/>">

                <div class="mc-head">
                    <span class="mc-tour"><i class="fa-solid fa-trophy"></i><c:out value="${m.tournament != null ? m.tournament.tournamentName : 'No tournament'}"/></span>
                    <span class="tagst"><c:out value="${m.status}"/></span>
                </div>

                <div class="mc-face">
                    <div class="tm t-a"><div class="av">A</div><div class="nm"><c:out value="${m.teamA != null ? m.teamA.teamName : 'TBD'}"/></div><div class="rn"><c:out value="${m.runsScoredA}" default="0"/><small><c:out value="${m.oversFacedA}" default="0"/> ov</small></div></div>
                    <div class="mid"><span class="vs">VS</span><span class="mid-id">#M-${m.id}</span></div>
                    <div class="tm t-b"><div class="av">B</div><div class="nm"><c:out value="${m.teamB != null ? m.teamB.teamName : 'TBD'}"/></div><div class="rn"><c:out value="${m.runsScoredB}" default="0"/><small><c:out value="${m.oversFacedB}" default="0"/> ov</small></div></div>
                </div>

                <div class="split none"><i class="sa"></i><i class="sb"></i></div>

                <div class="mc-foot">
                    <div><i class="fa-solid fa-location-dot" style="color:var(--tc-rose)"></i><span><c:out value="${empty m.venue ? 'Venue not set' : m.venue}"/></span></div>
                    <div><i class="fa-regular fa-clock" style="color:var(--tc-cyan)"></i><span class="dt-text"><c:out value="${m.matchDateTime}"/></span></div>
                </div>

                <div class="result">Result pending</div>

                <div class="mc-actions">
                    <a href="/admin/editMatch/${m.id}" class="btn-edit"><i class="fa-solid fa-pen-to-square"></i> Update Match</a>
                    <a href="/admin/deleteMatch/${m.id}" class="btn-delete" title="Delete match" aria-label="Delete match" onclick="return confirm('WARNING: Are you sure you want to delete this match?');"><i class="fa-solid fa-trash"></i></a>
                </div>
            </div>
        </c:forEach>
        <c:if test="${empty matches}"><div class="no-data">🏏 No matches yet. Click "Schedule Match" to add the first one.</div></c:if>
        <div class="no-data" id="noResults" style="display:none;">🔍 No matches found for this search.</div>
    </div>

    <c:if test="${not empty totalPages and totalPages > 1}">
        <div class="pagination-bar">
            <c:choose>
                <c:when test="${currentPage > 0}"><a href="${pageContext.request.contextPath}/admin/matches?page=${currentPage - 1}">⬅ Previous</a></c:when>
                <c:otherwise><span class="disabled">⬅ Previous</span></c:otherwise>
            </c:choose>
            <span class="page-indicator">Page ${currentPage + 1} of ${totalPages}</span>
            <c:choose>
                <c:when test="${currentPage + 1 < totalPages}"><a href="${pageContext.request.contextPath}/admin/matches?page=${currentPage + 1}">Next ➡</a></c:when>
                <c:otherwise><span class="disabled">Next ➡</span></c:otherwise>
            </c:choose>
        </div>
    </c:if>

    <!-- FIXTURES + STATUS RING -->
    <div class="section-block">
        <h3 class="section-title">🕒 Fixture Timeline &amp; Match Mix <small>What is next, and how matches are split</small></h3>
        <div class="grid-2">
            <div class="panel"><h3><i class="fa-solid fa-list-check" style="color:var(--tc-cyan)"></i> Next On The Field</h3><div id="timeline"></div></div>
            <div class="panel"><h3><i class="fa-solid fa-chart-pie" style="color:var(--tc-gold)"></i> Match Mix</h3><div id="ringBox"></div></div>
        </div>
    </div>

    <!-- FACE-OFF + RUN RATE -->
    <div class="section-block">
        <h3 class="section-title">📈 Scoring Insights <small>Built from runs and overs</small></h3>
        <div class="grid-2">
            <div class="panel"><h3><i class="fa-solid fa-scale-balanced" style="color:var(--tc-purple)"></i> Innings Face-Off</h3><div id="faceoff"></div></div>
            <div class="panel"><h3><i class="fa-solid fa-gauge-high" style="color:var(--tc-green)"></i> Fastest Run Rates</h3><div id="rrList"></div></div>
        </div>
    </div>

    <!-- GROUND GUIDE -->
    <div class="section-block">
        <h3 class="section-title">🏟️ Ground Guide <small>Average score and matches at each venue</small></h3>
        <div class="venue-grid" id="venueGrid"></div>
    </div>

    <!-- TEAM FORM GUIDE -->
    <div class="section-block">
        <h3 class="section-title">🔥 Team Form Guide <small>Last 5 results of each team</small></h3>
        <div class="panel">
            <div id="formList"></div>
            <div class="form-legend"><span><b style="color:var(--tc-green)">W</b> Won</span><span><b style="color:var(--tc-rose)">L</b> Lost</span><span><b>D</b> No result</span></div>
        </div>
    </div>

    <!-- MATCH CALENDAR -->
    <div class="section-block">
        <h3 class="section-title">🗓️ Match Calendar <small id="calLabel">This month</small></h3>
        <div class="panel">
            <div class="cal-head"><span>Sun</span><span>Mon</span><span>Tue</span><span>Wed</span><span>Thu</span><span>Fri</span><span>Sat</span></div>
            <div class="cal-grid" id="calGrid"></div>
        </div>
    </div>

    <!-- H2H + TOOLS -->
    <div class="section-block">
        <h3 class="section-title">🧮 Rivalry &amp; Scorer Tools <small>Try them live</small></h3>
        <div class="grid-2">
            <div class="panel">
                <h3><i class="fa-solid fa-hand-fist" style="color:var(--tc-rose)"></i> Head To Head</h3>
                <div class="sel-row"><select id="h1" aria-label="Team one"></select><em>VS</em><select id="h2" aria-label="Team two"></select></div>
                <div class="h2h-out"><div class="l"><b id="hw1">0</b><span id="hn1">Team one wins</span></div><span>wins</span><div class="r"><b id="hw2">0</b><span id="hn2">Team two wins</span></div></div>
                <p class="h2h-note" id="hNote">Pick two teams to see their past results.</p>
            </div>
            <div class="panel">
                <h3><i class="fa-solid fa-calculator" style="color:var(--tc-gold)"></i> Run Rate Tools</h3>
                <p class="calc-title">Net Run Rate</p>
                <div class="calc-grid">
                    <div><label for="n1">Runs scored</label><input class="field" id="n1" type="number" min="0" inputmode="decimal"></div>
                    <div><label for="n2">Overs faced</label><input class="field" id="n2" type="number" min="0" step="0.1" inputmode="decimal"></div>
                    <div><label for="n3">Runs conceded</label><input class="field" id="n3" type="number" min="0" inputmode="decimal"></div>
                    <div><label for="n4">Overs bowled</label><input class="field" id="n4" type="number" min="0" step="0.1" inputmode="decimal"></div>
                </div>
                <div class="calc-out"><b id="nrrOut">—</b><span>Net Run Rate</span></div>
                <div class="calc-sep"></div>
                <p class="calc-title">Required Run Rate</p>
                <div class="calc-grid">
                    <div><label for="q1">Target</label><input class="field" id="q1" type="number" min="0" inputmode="decimal"></div>
                    <div><label for="q2">Runs so far</label><input class="field" id="q2" type="number" min="0" inputmode="decimal"></div>
                    <div><label for="q3">Overs bowled</label><input class="field" id="q3" type="number" min="0" step="0.1" inputmode="decimal"></div>
                    <div><label for="q4">Total overs</label><input class="field" id="q4" type="number" min="1" value="20" inputmode="decimal"></div>
                </div>
                <div class="calc-out"><b id="rrrOut">—</b><span id="rrrSub">Runs needed per over</span></div>
            </div>
        </div>
    </div>

    <!-- SCORER'S DESK -->
    <div class="section-block">
        <h3 class="section-title">📝 Scorer's Desk <small>Matches waiting for an update</small></h3>
        <div class="panel"><div id="deskList"></div></div>
    </div>

    <!-- HOW TO READ -->
    <div class="section-block">
        <h3 class="section-title">👀 How To Read A Match Card</h3>
        <div class="grid-3">
            <div class="read-card" style="--c:var(--tc-cyan);--cb:rgba(0,217,255,.12)"><div class="read-ico"><i class="fa-solid fa-hashtag"></i></div><div><h5>Runs and overs</h5><p>Big number is the runs. The small tag next to it shows overs faced, like 20 ov.</p></div></div>
            <div class="read-card" style="--c:var(--tc-gold);--cb:rgba(255,215,0,.12)"><div class="read-ico"><i class="fa-solid fa-crown"></i></div><div><h5>Gold crown</h5><p>The team with a crown on its badge is the declared winner of the match.</p></div></div>
            <div class="read-card" style="--c:var(--tc-purple);--cb:rgba(181,55,242,.12)"><div class="read-ico"><i class="fa-solid fa-bars-progress"></i></div><div><h5>Split bar</h5><p>The thin bar shows each team's share of the total runs scored in the match.</p></div></div>
        </div>
    </div>

    <!-- DESK ACTIONS -->
    <div class="desk">
        <div><h3>🏏 Match Day Desk</h3><p>Schedule a fixture, update a live score or ask the support assistant for help.</p></div>
        <div class="desk-btns">
            <a href="/admin/addMatchPage" class="btn-desk ghost"><i class="fa-solid fa-plus"></i> Schedule Match</a>
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
    var cards = [].slice.call(document.querySelectorAll('#mxGrid .mc'));
    var MON = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'], DAY = 86400000, now = new Date();
    var LABEL = { ongoing: 'Live', upcoming: 'Upcoming', completed: 'Completed' };

    function el(t, c, x) { var e = document.createElement(t); if (c) e.className = c; if (x !== undefined) e.textContent = x; return e; }
    function empty(b, m) { b.appendChild(el('p', 'panel-empty', m)); }
    function pd(s) { if (!s) return null; var d = new Date(s.trim()); return isNaN(d) ? null : d; }
    function tm(d) { var h = d.getHours(), m = d.getMinutes(); return (h % 12 || 12) + ':' + (m < 10 ? '0' : '') + m + ' ' + (h >= 12 ? 'PM' : 'AM'); }
    function fmt(d) { return d ? d.getDate() + ' ' + MON[d.getMonth()] + ', ' + tm(d) : '—'; }
    function plural(n, w) { return n + ' ' + w + (n === 1 ? '' : 's'); }
    function num(s) { var n = parseFloat(s); return isNaN(n) ? 0 : n; }
    function ov(o) { var p = String(o).split('.'); return (parseInt(p[0], 10) || 0) + ((parseInt(p[1], 10) || 0) / 6); }
    function g(c, k) { return (c.getAttribute('data-' + k) || '').trim(); }
    function row(icon, name, sub, right) {
        var r = el('div', 'list-row'), av = el('div', 'list-avatar'); av.innerHTML = icon; r.appendChild(av);
        var m = el('div', 'list-main'); m.appendChild(el('p', 'list-name', name)); m.appendChild(el('p', 'list-sub', sub)); r.appendChild(m);
        if (right) r.appendChild(right); return r;
    }

    var ms = cards.map(function (c) {
        var x = { id: g(c, 'id'), status: g(c, 'status').toLowerCase(), tour: g(c, 'tour'), a: g(c, 'a'), b: g(c, 'b'), venue: g(c, 'venue'),
            dt: pd(g(c, 'dt')), ra: num(g(c, 'ra')), oa: g(c, 'oa'), rb: num(g(c, 'rb')), ob: g(c, 'ob'), winner: g(c, 'winner') };
        x.name = (x.a || 'TBD') + ' vs ' + (x.b || 'TBD'); return x;
    });
    function cnt(s) { return ms.filter(function (x) { return x.status === s; }).length; }
    var nLive = cnt('ongoing'), nUp = cnt('upcoming'), nDone = cnt('completed');
    document.getElementById('tAll').textContent = ms.length;
    document.getElementById('tLive').textContent = nLive;
    document.getElementById('tUp').textContent = nUp;
    document.getElementById('tDone').textContent = nDone;

    /* cards */
    cards.forEach(function (c, i) {
        var x = ms[i];
        c.classList.add('s-' + (x.status || 'upcoming'));
        var tg = c.querySelector('.tagst'); if (LABEL[x.status]) tg.textContent = LABEL[x.status];
        c.querySelector('.t-a .av').textContent = (x.a || '?').charAt(0).toUpperCase();
        c.querySelector('.t-b .av').textContent = (x.b || '?').charAt(0).toUpperCase();
        var dt = c.querySelector('.dt-text'); dt.textContent = x.dt ? fmt(x.dt) : 'Date not set';
        var tot = x.ra + x.rb, sp = c.querySelector('.split');
        if (tot > 0) { sp.classList.remove('none'); var p = Math.round(x.ra / tot * 100); setTimeout(function () { sp.querySelector('.sa').style.width = p + '%'; sp.querySelector('.sb').style.width = (100 - p) + '%'; }, 150); }
        var res = c.querySelector('.result');
        if (x.winner) {
            res.classList.add('has'); res.textContent = '🏆 ' + x.winner + ' won the match';
            if (x.winner === x.a) c.querySelector('.t-a').classList.add('win'); else if (x.winner === x.b) c.querySelector('.t-b').classList.add('win');
        } else if (x.status === 'ongoing') res.textContent = '● Match in progress';
        else if (x.status === 'upcoming' && x.dt) { var d = Math.ceil((x.dt - now) / DAY); res.textContent = d <= 0 ? 'Starts today' : 'Starts in ' + plural(d, 'day'); }
    });

    /* ticker */
    var tv = document.getElementById('tickerView');
    var tItems = ms.filter(function (x) { return x.status === 'ongoing' || x.status === 'completed'; })
        .sort(function (p, q) { return (q.dt || 0) - (p.dt || 0); }).slice(0, 8);
    if (!tItems.length) tv.appendChild(el('div', 'ticker-empty', 'No scores yet. Live and finished matches will scroll here.'));
    else {
        var trk = el('div', 'ticker-track');
        for (var k = 0; k < 2; k++) tItems.forEach(function (x) {
            var it = el('span', 'tk-item');
            it.appendChild(el('b', '', x.a || 'TBD')); it.appendChild(document.createTextNode(x.ra + '/' + x.oa));
            it.appendChild(document.createTextNode('vs')); it.appendChild(el('b', '', x.b || 'TBD')); it.appendChild(document.createTextNode(x.rb + '/' + x.ob));
            it.appendChild(el('em', '', x.winner ? '🏆 ' + x.winner : (x.status === 'ongoing' ? '● LIVE' : 'Result pending')));
            trk.appendChild(it);
        });
        tv.appendChild(trk);
    }

    /* timeline */
    var tl = document.getElementById('timeline'), nx = ms.filter(function (x) { return x.status === 'ongoing' || (x.status === 'upcoming' && x.dt); })
        .sort(function (p, q) { return (p.status === 'ongoing' ? 0 : 1) - (q.status === 'ongoing' ? 0 : 1) || (p.dt || 0) - (q.dt || 0); }).slice(0, 5);
    if (!nx.length) empty(tl, 'No live or upcoming matches. Schedule one to fill the timeline.');
    else { var w = el('div', 'tl'); nx.forEach(function (x) {
        var it = el('div', 'tl-item' + (x.status === 'ongoing' ? ' live' : ''));
        it.appendChild(el('div', 'tl-time', x.status === 'ongoing' ? 'Live now' : fmt(x.dt)));
        it.appendChild(el('div', 'tl-name', x.name));
        it.appendChild(el('div', 'tl-sub', (x.venue || 'Venue not set') + (x.tour ? '  •  ' + x.tour : '')));
        w.appendChild(it); }); tl.appendChild(w); }

    /* ring */
    var rb = document.getElementById('ringBox');
    if (!ms.length) empty(rb, 'No matches yet.');
    else {
        var wrap = el('div', 'ring-wrap'), a = Math.round(nLive / ms.length * 100), b = a + Math.round(nUp / ms.length * 100);
        var ring = el('div', 'ring'); ring.style.setProperty('--a', a); ring.style.setProperty('--b', b);
        var mid = el('div'); mid.appendChild(el('b', '', String(ms.length))); mid.appendChild(el('span', '', 'Matches')); ring.appendChild(mid); wrap.appendChild(ring);
        var lg = el('div', 'legend');
        [['var(--tc-green)', 'On Air', nLive], ['var(--tc-cyan)', 'Coming Up', nUp], ['var(--tc-purple)', 'Full Time', nDone]].forEach(function (p) {
            var r = el('div'), s = el('i'); s.style.background = p[0]; r.appendChild(s); r.appendChild(document.createTextNode(p[1] + ': ' + p[2])); lg.appendChild(r);
        });
        wrap.appendChild(lg); rb.appendChild(wrap);
    }

    /* face-off */
    var fo = document.getElementById('faceoff'), done = ms.filter(function (x) { return x.status === 'completed' && (x.ra || x.rb); })
        .sort(function (p, q) { return (q.dt || 0) - (p.dt || 0); }).slice(0, 5);
    if (!done.length) empty(fo, 'Finished matches with scores will show here.');
    else {
        var mx = Math.max.apply(null, done.map(function (x) { return Math.max(x.ra, x.rb); })) || 1;
        done.forEach(function (x) {
            var r = el('div', 'fo-row'); r.appendChild(el('div', 'fo-name', x.name));
            [[x.a, x.ra, 'var(--tc-cyan)'], [x.b, x.rb, 'var(--tc-purple)']].forEach(function (p) {
                var l = el('div', 'fo-line'); l.appendChild(el('span', '', String(p[1])));
                var bar = el('div', 'fo-bar'); bar.style.width = Math.max(3, p[1] / mx * 78) + '%'; bar.style.background = p[2]; l.appendChild(bar);
                l.appendChild(document.createTextNode(p[0] || 'TBD')); r.appendChild(l);
            }); fo.appendChild(r);
        });
    }

    /* run rates */
    var rl = document.getElementById('rrList'), inn = [];
    ms.forEach(function (x) {
        if (x.status === 'upcoming') return;
        if (x.ra > 0 && ov(x.oa) > 0) inn.push({ t: x.a, o: x.b, rr: x.ra / ov(x.oa), r: x.ra });
        if (x.rb > 0 && ov(x.ob) > 0) inn.push({ t: x.b, o: x.a, rr: x.rb / ov(x.ob), r: x.rb });
    });
    inn.sort(function (p, q) { return q.rr - p.rr; });
    if (!inn.length) empty(rl, 'Run rates appear once scores and overs are entered.');
    else inn.slice(0, 5).forEach(function (s, i) { rl.appendChild(row('<b>' + (i + 1) + '</b>', s.t || 'TBD', s.r + ' runs vs ' + (s.o || 'TBD'), el('span', 'big-num', s.rr.toFixed(2)))); });

    /* head to head */
    var teams = {}; ms.forEach(function (x) { if (x.a) teams[x.a] = 1; if (x.b) teams[x.b] = 1; });
    var tn = Object.keys(teams).sort(), h1 = document.getElementById('h1'), h2 = document.getElementById('h2');
    [h1, h2].forEach(function (s, i) { tn.forEach(function (t) { var o = el('option', '', t); o.value = t; s.appendChild(o); }); if (tn.length > 1) s.selectedIndex = i; });
    function h2h() {
        var A = h1.value, B = h2.value, w1 = 0, w2 = 0, last = null, n = 0;
        ms.forEach(function (x) { if (x.status !== 'completed') return;
            if ((x.a === A && x.b === B) || (x.a === B && x.b === A)) { n++; if (x.winner === A) w1++; else if (x.winner === B) w2++; if (!last || (x.dt && x.dt > last.dt)) last = x; } });
        document.getElementById('hw1').textContent = w1; document.getElementById('hw2').textContent = w2;
        document.getElementById('hn1').textContent = (A || 'Team one') + ' wins'; document.getElementById('hn2').textContent = (B || 'Team two') + ' wins';
        document.getElementById('hNote').textContent = !A || !B ? 'Add matches to compare teams.' : A === B ? 'Choose two different teams.' : n ? plural(n, 'completed match') + ' between them' + (last && last.dt ? '. Last on ' + fmt(last.dt) + '.' : '.') : 'These teams have not played a completed match yet.';
    }
    h1.addEventListener('change', h2h); h2.addEventListener('change', h2h); h2h();

    /* calculators */
    function $(id) { return document.getElementById(id); }
    function nrr() {
        var f = ov($('n2').value), b = ov($('n4').value), o = $('nrrOut');
        if (!(f > 0 && b > 0) || $('n1').value === '' || $('n3').value === '') { o.textContent = '—'; o.className = ''; return; }
        var v = num($('n1').value) / f - num($('n3').value) / b; o.textContent = (v > 0 ? '+' : '') + v.toFixed(3); o.className = v < 0 ? 'neg' : '';
    }
    function rrr() {
        var t = num($('q1').value), s = num($('q2').value), left = ov($('q4').value) - ov($('q3').value), o = $('rrrOut'), sub = $('rrrSub');
        if (!t || left <= 0) { o.textContent = '—'; sub.textContent = 'Runs needed per over'; return; }
        var need = t - s; if (need <= 0) { o.textContent = 'Won'; sub.textContent = 'Target already reached'; return; }
        o.textContent = (need / left).toFixed(2); sub.textContent = need + ' runs needed from ' + left.toFixed(1) + ' overs';
    }
    ['n1','n2','n3','n4'].forEach(function (i) { $(i).addEventListener('input', nrr); });
    ['q1','q2','q3','q4'].forEach(function (i) { $(i).addEventListener('input', rrr); });

    /* ground guide */
    var vg = $('venueGrid'), vmap = {};
    ms.forEach(function (x) {
        if (!x.venue) return;
        var v = vmap[x.venue] || (vmap[x.venue] = { n: 0, runs: 0, inn: 0, last: null });
        v.n++;
        if (x.status !== 'upcoming') { if (x.ra > 0) { v.runs += x.ra; v.inn++; } if (x.rb > 0) { v.runs += x.rb; v.inn++; } }
        if (x.dt && (!v.last || x.dt > v.last)) v.last = x.dt;
    });
    var vk = Object.keys(vmap).sort(function (p, q) { return vmap[q].n - vmap[p].n; }).slice(0, 6);
    if (!vk.length) { vg.style.display = 'block'; empty(vg, 'Add a venue to a match to see ground stats.'); }
    else {
        var vcol = ['var(--tc-cyan)', 'var(--tc-green)', 'var(--tc-gold)', 'var(--tc-rose)', 'var(--tc-purple)', 'var(--tc-amber)'];
        vk.forEach(function (k, i) {
            var v = vmap[k], c = el('div', 'venue-card'); c.style.setProperty('--vc', vcol[i % 6]);
            var top = el('div', 'venue-top'), ic = el('div', 'venue-ico'); ic.innerHTML = '<i class="fa-solid fa-location-dot"></i>';
            top.appendChild(ic); top.appendChild(el('div', 'venue-name', k)); c.appendChild(top);
            var st = el('div', 'venue-stats'), a = el('div'), b = el('div');
            a.appendChild(el('b', '', String(v.n))); a.appendChild(el('span', '', v.n === 1 ? 'Match' : 'Matches'));
            b.appendChild(el('b', '', v.inn ? String(Math.round(v.runs / v.inn)) : '—')); b.appendChild(el('span', '', 'Avg score'));
            st.appendChild(a); st.appendChild(b); c.appendChild(st);
            c.appendChild(el('p', 'venue-last', v.last ? 'Latest match: ' + fmt(v.last) : 'No date set yet'));
            vg.appendChild(c);
        });
    }

    /* team form guide */
    var fl = $('formList'), rec = {};
    ms.filter(function (x) { return x.status === 'completed'; }).sort(function (p, q) { return (p.dt || 0) - (q.dt || 0); }).forEach(function (x) {
        [x.a, x.b].forEach(function (t) {
            if (!t) return;
            var r = rec[t] || (rec[t] = { p: 0, w: 0, f: [] });
            r.p++; var res = !x.winner ? 'D' : (x.winner === t ? 'W' : 'L'); if (res === 'W') r.w++; r.f.push(res);
        });
    });
    var fk = Object.keys(rec).sort(function (p, q) { return rec[q].w - rec[p].w || (rec[q].w / rec[q].p) - (rec[p].w / rec[p].p); }).slice(0, 6);
    if (!fk.length) empty(fl, 'Form appears after matches are completed.');
    else fk.forEach(function (t, i) {
        var r = rec[t], rw = el('div', 'form-row');
        rw.appendChild(el('div', 'rank', String(i + 1)));
        rw.appendChild(el('div', 'list-avatar', t.charAt(0).toUpperCase()));
        var mn = el('div', 'list-main'); mn.appendChild(el('p', 'list-name', t)); mn.appendChild(el('p', 'list-sub', plural(r.p, 'match') + '  •  ' + r.w + ' won  •  ' + Math.round(r.w / r.p * 100) + '% win rate')); rw.appendChild(mn);
        var ds = el('div', 'dots'); r.f.slice(-5).forEach(function (s) { ds.appendChild(el('span', s.toLowerCase(), s)); }); rw.appendChild(ds);
        fl.appendChild(rw);
    });

    /* match calendar (current month) */
    var cg = $('calGrid'), cy = now.getFullYear(), cm = now.getMonth(), first = new Date(cy, cm, 1).getDay(), dim = new Date(cy, cm + 1, 0).getDate();
    $('calLabel').textContent = ['January','February','March','April','May','June','July','August','September','October','November','December'][cm] + ' ' + cy;
    for (var bI = 0; bI < first; bI++) cg.appendChild(el('div', 'cal-cell blank'));
    for (var dI = 1; dI <= dim; dI++) {
        var dm = ms.filter(function (x) { return x.dt && x.dt.getFullYear() === cy && x.dt.getMonth() === cm && x.dt.getDate() === dI; });
        var isLive = dm.some(function (x) { return x.status === 'ongoing'; });
        var cell = el('div', 'cal-cell' + (dm.length ? ' has' : '') + (isLive ? ' live' : '') + (dI === now.getDate() ? ' now' : ''));
        cell.appendChild(el('span', 'cd', String(dI)));
        if (dm.length) { cell.appendChild(el('span', 'cc', dm.length + (dm.length === 1 ? ' match' : ' matches'))); cell.title = dm.map(function (x) { return x.name; }).join(', '); }
        cg.appendChild(cell);
    }

    /* scorer's desk */
    var dk = $('deskList');
    var todo = ms.map(function (x) {
        var l = [];
        if (x.status === 'ongoing') l.push('Live: update score');
        if (x.status === 'upcoming' && x.dt && x.dt < now) l.push('Start time passed');
        if (x.status === 'completed' && !x.winner) l.push('Winner missing');
        if (x.status === 'upcoming' && x.winner) l.push('Winner set too early');
        if (!x.a || !x.b) l.push('Team missing'); else if (x.a === x.b) l.push('Same team twice');
        if (!x.venue) l.push('Venue missing'); if (!x.dt) l.push('Date missing');
        return { x: x, l: l };
    }).filter(function (r) { return r.l.length; });
    if (!ms.length) empty(dk, 'Schedule a match to see pending updates.');
    else if (!todo.length) empty(dk, '✅ All caught up. No match needs an update right now.');
    else {
        todo.slice(0, 5).forEach(function (r) {
            var a = el('a', 'mini-link', 'Update'); a.href = '/admin/editMatch/' + r.x.id;
            var rw = row('<i class="fa-solid fa-pen-ruler"></i>', '#M-' + r.x.id + '  ' + r.x.name, '', a);
            var sub = rw.querySelector('.list-sub'); sub.remove();
            var tg = el('div', 'tags'); r.l.forEach(function (s) { tg.appendChild(el('span', 'tag', s)); }); rw.querySelector('.list-main').appendChild(tg); dk.appendChild(rw);
        });
        if (todo.length > 5) { var mo = el('p', 'panel-empty', '+ ' + (todo.length - 5) + ' more match(es) need updates.'); mo.style.marginTop = '12px'; dk.appendChild(mo); }
    }

    /* search + tab filter */
    var search = $('mxSearch'), nr = $('noResults'), badge = $('totalBadge'), tabs = [].slice.call(document.querySelectorAll('#tabs .tab')), active = 'all';
    function apply() {
        var q = search.value.trim().toLowerCase(), vis = 0;
        cards.forEach(function (c, i) {
            var x = ms[i], ok = (!q || (x.a + ' ' + x.b + ' ' + x.venue + ' ' + x.tour).toLowerCase().indexOf(q) > -1) && (active === 'all' || x.status === active);
            c.style.display = ok ? '' : 'none'; if (ok) vis++;
        });
        nr.style.display = (ms.length && !vis) ? '' : 'none'; badge.textContent = vis;
    }
    search.addEventListener('input', apply);
    tabs.forEach(function (b) { b.addEventListener('click', function () {
        tabs.forEach(function (o) { o.classList.remove('active'); }); b.classList.add('active'); active = b.getAttribute('data-filter'); apply(); }); });
})();
</script>
</body>
</html>
