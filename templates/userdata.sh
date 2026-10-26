#!/bin/bash
set -e

sudo amazon-linux-extras install -y nginx1
sudo systemctl enable nginx
sudo systemctl start nginx

sudo tee /usr/share/nginx/html/index.html > /dev/null <<'HTML'
<!doctype html>
<html lang="pl">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="theme-color" content="#f8f3ed">
  <title>Dla Roksany, z miłością</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;500;600;700&family=Playfair+Display:ital,wght@0,500;0,600;0,700;1,500;1,600&display=swap" rel="stylesheet">
  <style>
    :root { --paper:#f8f3ed; --ink:#29221f; --muted:#796d65; --rose:#bd655d; --line:#e8ddd3; }
    * { box-sizing:border-box; }
    body { margin:0; background:var(--paper); color:var(--ink); font-family:'DM Sans',sans-serif; }
    .page { min-height:100vh; overflow:hidden; position:relative; }
    .page:before { content:''; position:absolute; width:480px; height:480px; border-radius:50%; background:#efd8ce; opacity:.45; top:-250px; right:-180px; filter:blur(2px); }
    header { width:min(1120px, calc(100% - 48px)); margin:auto; height:92px; display:flex; align-items:center; justify-content:space-between; position:relative; z-index:1; }
    .brand { font-family:'Playfair Display',serif; font-size:20px; letter-spacing:.02em; }
    .brand span { color:var(--rose); }
    .top-note { color:var(--muted); font-size:12px; letter-spacing:.18em; text-transform:uppercase; }
    main { width:min(1120px, calc(100% - 48px)); margin:38px auto 80px; position:relative; z-index:1; }
    .hero { display:grid; grid-template-columns:1.05fr .95fr; align-items:center; gap:7%; min-height:510px; }
    .eyebrow { display:flex; align-items:center; gap:12px; color:var(--rose); font-size:12px; font-weight:700; letter-spacing:.2em; text-transform:uppercase; }
    .eyebrow:before { content:''; width:32px; height:1px; background:var(--rose); }
    h1 { font-family:'Playfair Display',serif; font-size:clamp(54px,7vw,88px); line-height:.99; letter-spacing:-.045em; font-weight:500; margin:26px 0 24px; }
    h1 em { color:var(--rose); font-weight:500; }
    .intro { max-width:440px; color:var(--muted); font-size:16px; line-height:1.85; }
    .signature { margin-top:30px; font-family:'Playfair Display',serif; font-size:23px; font-style:italic; }
    .signature span { color:var(--rose); }
    .portrait { min-height:430px; border-radius:48% 48% 8px 8px; background:linear-gradient(145deg,#d49a87,#aa6459 58%,#704a46); position:relative; display:grid; place-items:center; overflow:hidden; box-shadow:0 28px 70px #704a4622; }
    .portrait:before,.portrait:after { content:''; position:absolute; border:1px solid #ffffff55; border-radius:50%; width:330px; height:330px; }
    .portrait:after { width:410px; height:410px; }
    .sun { position:absolute; width:190px; height:190px; border-radius:50%; background:#f4d7ad; top:50px; right:55px; opacity:.84; }
    .flower { position:relative; z-index:1; font-size:138px; filter:drop-shadow(0 18px 12px #482b3033); transform:rotate(-12deg); }
    .portrait-label { position:absolute; bottom:27px; left:0; right:0; text-align:center; color:#fff7ed; font-family:'Playfair Display',serif; font-style:italic; font-size:17px; letter-spacing:.04em; }
    .divider { height:1px; background:var(--line); margin:36px 0 46px; }
    .note { display:grid; grid-template-columns:.7fr 1.3fr; gap:8%; align-items:start; }
    .note h2 { margin:0; font:500 34px/1.15 'Playfair Display',serif; }
    .note-copy { color:var(--muted); line-height:1.9; font-size:15px; max-width:610px; }
    .note-copy p { margin:0 0 16px; }
    button { border:0; background:var(--ink); color:#fff8f2; padding:15px 22px; border-radius:2px; font:600 13px 'DM Sans',sans-serif; letter-spacing:.04em; cursor:pointer; transition:transform .2s,background .2s; }
    button:hover { background:var(--rose); transform:translateY(-2px); }
    #surprise { display:none; margin-top:20px; padding:19px 22px; border-left:2px solid var(--rose); background:#fffaf5; color:var(--ink); font:italic 20px/1.55 'Playfair Display',serif; }
    #surprise.show { display:block; animation:appear .45s ease both; }
    footer { width:min(1120px,calc(100% - 48px)); margin:0 auto; border-top:1px solid var(--line); padding:24px 0 32px; display:flex; justify-content:space-between; color:#a2948a; font-size:11px; letter-spacing:.13em; text-transform:uppercase; }
    .heart { color:var(--rose); }
    @keyframes appear { from { opacity:0; transform:translateY(8px); } to { opacity:1; transform:translateY(0); } }
    @media(max-width:700px) { header { height:74px; } .top-note { font-size:9px; } main { margin-top:24px; } .hero { grid-template-columns:1fr; gap:38px; } .hero-copy { padding:18px 0 0; } h1 { font-size:64px; } .portrait { min-height:340px; } .flower { font-size:110px; } .note { grid-template-columns:1fr; gap:20px; } .note h2 { font-size:31px; } footer { font-size:9px; } }
    @media(prefers-reduced-motion:reduce) { *,*:before,*:after { animation-duration:.01ms!important; transition-duration:.01ms!important; } }
  </style>
</head>
<body>
  <div class="page">
    <header>
      <div class="brand">mały <span>♡</span> wielki gest</div>
      <div class="top-note">strona stworzona specjalnie dla Ciebie</div>
    </header>
    <main>
      <section class="hero">
        <div class="hero-copy">
          <div class="eyebrow">Dla Roksany</div>
          <h1>Świat jest<br>piękniejszy,<br><em>bo jesteś.</em></h1>
          <p class="intro">To tylko mała strona, ale stoi za nią wielka myśl: dobrze, że jesteś. Niech przypomina Ci o tym dziś i każdego dnia.</p>
          <div class="signature">Z całego serca <span>♥</span></div>
        </div>
        <div class="portrait" aria-label="Kwiat w ciepłych, różowych barwach">
          <div class="sun"></div>
          <div class="flower" aria-hidden="true">🌷</div>
          <div class="portrait-label">dla kogoś naprawdę wyjątkowego</div>
        </div>
      </section>
      <div class="divider"></div>
      <section class="note">
        <h2>Jedna mała<br>wiadomość</h2>
        <div class="note-copy">
          <p>Roksano, oby nie zabrakło Ci powodów do uśmiechu, spokojnych poranków i ludzi, przy których możesz być po prostu sobą. A jeśli dziś potrzebujesz przypomnienia — jesteś ważna, jesteś cudowna i zasługujesz na wszystko, co dobre.</p>
          <button type="button" id="surpriseButton" aria-expanded="false" aria-controls="surprise">Otwórz małą niespodziankę <span aria-hidden="true">✦</span></button>
          <div id="surprise" role="status">Gdybym miał wybierać jeszcze raz, znów wybrałbym Ciebie. ♡</div>
        </div>
      </section>
    </main>
    <footer><span>zrobione z myślą o Tobie</span><span>Roksana <span class="heart">♥</span></span></footer>
  </div>
  <script>
    const button = document.getElementById('surpriseButton');
    const surprise = document.getElementById('surprise');
    button.addEventListener('click', () => {
      const open = surprise.classList.toggle('show');
      button.setAttribute('aria-expanded', String(open));
      button.firstChild.textContent = open ? 'Schowaj wiadomość ' : 'Otwórz małą niespodziankę ';
    });
  </script>
</body>
</html>
HTML
