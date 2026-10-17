#!/usr/bin/env bash
# Cek hasil build per skenario terima — dipanggil scripts/build.sh (#5).
#
#   tests/build-checks.sh site <dir>      # cek situs asli (.build/)
#   tests/build-checks.sh fixture <dir>   # cek situs dari tests/fixture/content (.build-fixture/)
#
# Exit 1 bila ada cek yang gagal. Hasil Hugo di-minify, jadi pola tidak bergantung pada tanda kutip atribut.
set -uo pipefail
mode="${1:?site|fixture}"; D="${2:?dir}"
fail=0
ok()  { echo "✅ $1"; }
bad() { echo "❌ $1"; fail=1; }
has() { grep -q -- "$2" "$D/$1" 2>/dev/null; }
count() { grep -o -- "$2" "$D/$1" 2>/dev/null | wc -l | tr -d ' '; }
# Jumlah pola di semua halaman feed: <base>/index.html + <base>/page/N/index.html.
count_feed() { local b="${1%/}" t=0 f; for f in "$D/$b/index.html" "$D/$b"/page/*/index.html; do
  [ -f "$f" ] && t=$((t + $(grep -o -- "$2" "$f" | wc -l))); done; echo "$t"; }
feed_dates() { local b="${1%/}" f; for f in "$D/$b/index.html" $(ls "$D/$b"/page/*/index.html 2>/dev/null | sort -V); do
  grep -oE '\[20[0-9]{2}-[0-9]{2}-[0-9]{2}\]' "$f"; done | tr -d '[]'; }
redirects_to() { grep -qE "url=https://www\.jurnalbagas\.com$2\"?>" "$D/$1/index.html" 2>/dev/null; }

POSTS=(tipe-data kondisional perulangan fungsi list tuple set dictionary)
OLD=(tipe_data kondisional perulangan fungsi list tuple set dictionary)

if [ "$mode" = site ]; then
  # Skenario 1 — beranda: feed tulisan, terbaru dulu, tanpa banner.
  n=$(count_feed . 'class=post-entry')
  dates=$(feed_dates .)
  if [ "$(count index.html 'class=post-entry')" -eq 5 ] && [ "$n" -ge 11 ] && [ "$dates" = "$(echo "$dates" | sort -r)" ] && has index.html 'whoami' && ! has index.html 'hero'; then
    ok "S1 beranda: $n tulisan (5 per halaman), urut terbaru, tanpa banner"
  else bad "S1 beranda (entri=$n, urutan/whoami/banner)"; fi

  # Skenario 2 — filter tag lewat halaman tag.
  n=$(( $(count tag/python/index.html 'class=post-entry') + $(count tag/python/page/2/index.html 'class=post-entry') ))
  if [ "$(count tag/python/index.html 'class=post-entry')" -eq 5 ] && [ "$n" -eq 8 ] && has index.html 'href=/tag/python/'; then ok "S2 tag python: $n tulisan, chip di beranda"
  else bad "S2 tag python (entri=$n)"; fi

  # Skenario 4, 7 — navigasi seri, bagian aktif + daftar isi, sebelumnya/berikutnya.
  P=tulisan/belajar-python-dictionary/index.html
  if [ "$(count $P 'class=n>')" -ge 16 ] && has $P 'class=series-nav' && has $P 'class=active' \
     && has $P 'class=series-toc' && has $P 'href=#pengenalan' && has $P 'class=prevnext' \
     && has $P 'href=/tulisan/belajar-python-set/><small>' && has $P 'data-nav-toggle'; then
    ok "S4/S7 seri: 8 bagian (sidebar + kartu ponsel), aktif + daftar isi, sebelumnya → Set"
  else bad "S4/S7 navigasi seri di $P"; fi
  if has tulisan/belajar-python-tipe-data/index.html 'href=/tulisan/belajar-python-kondisional/><small>'; then
    ok "S7 bagian 1 menaut ke bagian 2"; else bad "S7 tautan berikutnya di bagian 1"; fi

  # Skenario 12 — beranda en: tulisan belum diterjemahkan berlencana ID, menaut ke versi id.
  n=$(count_feed en 'class=badge-id title="[^"]*">ID<')
  if [ "$n" -eq 8 ] && has en/index.html 'href=/tulisan/belajar-python-dictionary/' && has en/index.html './posts'; then
    ok "S12 beranda en: $n tulisan berlencana ID, menu en"
  else bad "S12 beranda en (lencana=$n)"; fi

  # Skenario 14 — indeks pencarian per bahasa.
  if python3 -c "import json,sys; a=json.load(open('$D/index.json')); b=json.load(open('$D/en/index.json')); \
sys.exit(0 if len(a)==9 and all(p['url'].startswith('/tulisan/') for p in a) and len(b)==4 and all(p['url'].startswith('/en/posts/') for p in b) else 1)"; then
    ok "S14 indeks pencarian: id 9 tulisan id, en 4 tulisan en (+#16)"
  else bad "S14 indeks pencarian"; fi

  # Skenario 16 — alamat baru.
  missing=""
  for p in "${POSTS[@]}"; do [ -f "$D/tulisan/belajar-python-$p/index.html" ] || missing="$missing tulisan/belajar-python-$p"; done
  for p in tentang kontak en/about en/contact tulisan en/posts seri/python-dasar tag/python tag en/tags en/series; do
    [ -f "$D/$p/index.html" ] || missing="$missing $p"
  done
  [ -z "$missing" ] && ok "S16 alamat baru lengkap" || bad "S16 alamat baru tidak ada:$missing"

  # Skenario 17 — alamat lama dialihkan ke alamat baru yang benar.
  wrong=""
  for i in "${!OLD[@]}"; do
    redirects_to "article/python/basic/${OLD[$i]}" "/tulisan/belajar-python-${POSTS[$i]}/" || wrong="$wrong ${OLD[$i]}"
  done
  redirects_to page/tentang-saya /tentang/ || wrong="$wrong page/tentang-saya"
  redirects_to page/kontak /kontak/ || wrong="$wrong page/kontak"
  redirects_to en/page/about-me /en/about/ || wrong="$wrong en/page/about-me"
  redirects_to en/page/contact /en/contact/ || wrong="$wrong en/page/contact"
  redirects_to tags/python /tag/python/ || wrong="$wrong tags/python"
  redirects_to tags/programming /tag/programming/ || wrong="$wrong tags/programming"
  redirects_to article /tulisan/ || wrong="$wrong article"
  redirects_to id / || wrong="$wrong id"
  [ -z "$wrong" ] && ok "S17 16 alamat lama dialihkan dengan benar" || bad "S17 alias salah/tidak ada:$wrong"

  # Skenario 18 — halaman demo tema lama tidak ada.
  left=""
  for p in audio quote video status link code de gallery categories author archive page/about-bilberry article/docker; do
    [ -e "$D/$p" ] && left="$left $p"
  done
  [ -z "$left" ] && ok "S18 halaman demo tema lama tidak ada" || bad "S18 masih ada:$left"

  # #6 — tiga tulisan Medium (spec #6).
  MED=(kubernetes-logs-observability-with-clickstack effortless-kubernetes-delivery-with-zuul-ci helm-templating-network-policy)
  KIP=(helm-templating-network-policy effortless-kubernetes-delivery-with-zuul-ci kubernetes-logs-observability-with-clickstack)
  MEDURL=(kubernetes-logs-observability-with-clickstack-clickhouse-hyperdx-37ddcbcc58f2 effortless-kubernetes-delivery-with-zuul-ci-38b9b1d592fe helm-templating-network-policy-using-helm-783b2f7e401a)
  # Jumlah elemen sumber (feed Medium; <pre> berurutan digabung, judul di awal isi dibuang): pre img heading li blockquote
  EXPECT=("11 9 10 8 1" "9 12 8 0 1" "16 1 0 4 0")
  for i in 0 1 2; do
    s=${MED[$i]}; P=en/posts/$s/index.html
    # S10 alamat, S3 catatan sumber, S4 canonical
    if [ -f "$D/$P" ] && has $P "First published on <a href=https://bagas-awibowo.medium.com/${MEDURL[$i]} rel=noopener>Medium</a>" \
       && has $P "rel=canonical href=https://www.jurnalbagas.com/en/posts/$s/>"; then
      ok "#6 S3/S4/S10 $s: alamat, catatan Medium, canonical ke blog"
    else bad "#6 S3/S4/S10 $s"; fi
    # S5 isi utuh (jumlah elemen = sumber)
    got=$(python3 - "$D/$P" <<'PY'
import sys
from html.parser import HTMLParser
class P(HTMLParser):
    # Hitung elemen hanya di dalam <div class=content> (isi tulisan), bukan navigasi seri dll.
    def __init__(s): super().__init__(); s.depth=0; s.c={k:0 for k in ('pre','img','h','li','blockquote')}
    def handle_starttag(s, t, a):
        if s.depth: s.depth += t == 'div'
        elif t == 'div' and ('class', 'content') in a: s.depth = 1; return
        if not s.depth: return
        k = 'h' if t in ('h2','h3','h4','h5','h6') else t
        if k in s.c: s.c[k] += 1
    def handle_endtag(s, t):
        if s.depth and t == 'div': s.depth -= 1
p = P(); p.feed(open(sys.argv[1]).read()); print(*p.c.values())
PY
)
    [ "$got" = "${EXPECT[$i]}" ] && ok "#6 S5 $s: isi utuh ($got)" || bad "#6 S5 $s: elemen $got ≠ sumber ${EXPECT[$i]}"
    # S6 gambar lokal, tanpa Medium
    if ! grep -qE 'cdn-images-1\.medium\.com|miro\.medium\.com|medium\.com/_/stat' "$D/$P" \
       && ! grep -oE '<img src=[^ >]+' "$D/$P" | grep -qE 'src="?https?:'; then ok "#6 S6 $s: semua gambar dari blog"
    else bad "#6 S6 $s: gambar/pelacak dari Medium"; fi
  done
  # S1 beranda en: ketiganya tampil tanpa lencana, urut tanggal (+ tulisan #16 = 4 tulisan en)
  if [ "$(count_feed en 'href=/en/posts/[a-z-]*/>[^<]*</a></h2>')" -eq 4 ] && [ "$(feed_dates en)" = "$(feed_dates en | sort -r)" ]; then
    ok "#6 S1 beranda en: 4 tulisan en (3 Medium + #16), urut tanggal"; else bad "#6 S1 beranda en"; fi
  # S2 beranda id: lencana EN ke versi en
  if [ "$(count_feed . 'class=badge-id title="[^"]*">EN<')" -eq 3 ] && [ "$(count_feed . 'href=/en/posts/[a-z-]*/>[^<]*</a></h2>')" -eq 3 ]; then
    ok "#6 S2 beranda id: 3 tulisan berlencana EN menaut ke /en/posts/"; else bad "#6 S2 beranda id: lencana EN"; fi
  # S10 seri kubernetes-in-practice: 3 bagian urut, aktif benar, prev/next
  for i in 0 1 2; do
    P=en/posts/${KIP[$i]}/index.html
    [ "$(grep -o '<ol class=series-list>' "$D/$P" | wc -l)" -eq 2 ] || { bad "#6 S10 ${KIP[$i]}: navigasi seri tidak ada"; continue; }
    order=$(python3 -c "import re,sys; h=open(sys.argv[1]).read(); ol=h.split('<ol class=series-list>')[1].split('</ol>')[0]; print(' '.join(re.findall(r'href=/en/posts/([a-z-]+)/', ol)))" "$D/$P")
    nav_ok=1
    [ "$order" = "${KIP[*]}" ] || nav_ok=0
    has $P "<li class=active><a href=/en/posts/${KIP[$i]}/ aria-current=page>" || nav_ok=0
    [ $i -gt 0 ] && { has $P "href=/en/posts/${KIP[$((i-1))]}/><small>" || nav_ok=0; }
    [ $i -gt 0 ] && { grep -qE 'class=series-toc><nav id=TableOfContents>(<ul><li>)+<a href=#' "$D/$P" || nav_ok=0; }
    [ $i -lt 2 ] && { has $P "class=next href=/en/posts/${KIP[$((i+1))]}/>" || nav_ok=0; }
    [ $nav_ok -eq 1 ] && ok "#6 S10 ${KIP[$i]}: seri bagian $((i+1))/3, urutan + sebelumnya/berikutnya benar" || bad "#6 S10 ${KIP[$i]} (urutan: $order)"
  done
  # S11 chip tag lintas bahasa
  if has index.html 'href=/en/tags/kubernetes/ hreflang' && grep -qE 'href=/en/tags/kubernetes/[^>]*>kubernetes<span class=chip-lang>EN<' "$D/index.html" \
     && grep -qE 'href=/tag/python/[^>]*>python<span class=chip-lang>ID<' "$D/en/index.html"; then
    ok "#6 S11 chip tag lintas bahasa (kubernetes EN di id, python ID di en)"; else bad "#6 S11 chip tag lintas bahasa"; fi
  # S12 daftar seri lintas bahasa
  if has seri/index.html 'href=/seri/python-dasar/' && grep -qE 'href=/en/series/kubernetes-in-practice/[^>]*>.*<span class=chip-lang>EN<' "$D/seri/index.html" \
     && has en/series/index.html 'href=/en/series/kubernetes-in-practice/' && grep -qE 'href=/seri/python-dasar/[^>]*>.*<span class=chip-lang>ID<' "$D/en/series/index.html"; then
    ok "#6 S12 daftar seri lintas bahasa (id & en memuat kedua seri)"; else bad "#6 S12 daftar seri lintas bahasa"; fi
  # S8 tag topik
  n=$(count_feed en/tags/kubernetes 'class=post-entry')
  [ "$n" -eq 3 ] && [ -f "$D/en/tags/devops/index.html" ] && [ -f "$D/en/tags/helm/index.html" ] && [ ! -e "$D/en/tags/medium" ] \
    && ok "#6 S8 tag topik: kubernetes ($n), devops, helm; tanpa tag medium" || bad "#6 S8 tag topik (kubernetes=$n)"

  # #16 tulisan login wajah (Howdy), seri linux-tips, id + en.
  HID=tulisan/windows-hello-di-opensuse; HEN=en/posts/windows-hello-on-opensuse
  # S1 tulisan terbaru di kedua beranda
  if grep -oE 'href=/[a-z/-]+/>[^<]*</a></h2>' "$D/index.html" | head -1 | grep -q "/$HID/" \
     && grep -oE 'href=/[a-z/-]+/>[^<]*</a></h2>' "$D/en/index.html" | head -1 | grep -q "/$HEN/"; then
    ok "#16 S1 tulisan teratas di beranda id dan en"; else bad "#16 S1 tulisan teratas di beranda"; fi
  # S2 pindah bahasa
  if has $HID/index.html "hreflang=en-US href=https://www.jurnalbagas.com/$HEN/" && has $HEN/index.html "hreflang=id-ID href=https://www.jurnalbagas.com/$HID/" \
     && has $HID/index.html "class=\"icon-btn lang-switch\" href=/$HEN/" && has $HEN/index.html "class=\"icon-btn lang-switch\" href=/$HID/"; then
    ok "#16 S2 id ↔ en saling menaut"; else bad "#16 S2 pindah bahasa"; fi
  # S3 navigasi seri linux-tips bagian 1
  for P in $HID $HEN; do
    ol=$(python3 -c "import sys; h=open(sys.argv[1]).read(); print(h.split('<ol class=series-list>')[1].split('</ol>')[0] if h.count('<ol class=series-list>')==2 else '')" "$D/$P/index.html")
    [ "$(echo "$ol" | grep -oE 'href=/[a-z/-]+/' | sort -u)" = "href=/$P/" ] && echo "$ol" | grep -q 'class=active' && has $P/index.html 'series-nav' \
      && ok "#16 S3 $P: navigasi seri linux-tips, bagian 1 aktif" || bad "#16 S3 $P: navigasi seri"
  done
  # S4 daftar seri
  has seri/index.html 'href=/seri/linux-tips/' && has en/series/index.html 'href=/en/series/linux-tips/' \
    && ok "#16 S4 linux-tips di daftar seri id dan en" || bad "#16 S4 daftar seri"
  # S5 tag topik
  miss=""; for t in linux opensuse howdy security; do
    has tag/$t/index.html "href=/$HID/" || miss="$miss tag/$t"; has en/tags/$t/index.html "href=/$HEN/" || miss="$miss en/tags/$t"; done
  [ -z "$miss" ] && ok "#16 S5 tag linux, opensuse, howdy, security (id + en)" || bad "#16 S5 tag:$miss"
  # S6 indeks pencarian
  python3 -c "import json,sys; a=[p['url'] for p in json.load(open('$D/index.json'))]; b=[p['url'] for p in json.load(open('$D/en/index.json'))]; sys.exit(0 if '/$HID/' in a and '/$HEN/' in b else 1)" \
    && ok "#16 S6 tulisan ada di indeks pencarian id dan en" || bad "#16 S6 indeks pencarian"
  # S7 isi lengkap (h2, blok kode, gambar + alt, tautan repo) · S9 tanpa data pribadi
  for P in $HID $HEN; do
    got=$(python3 - "$D/$P/index.html" <<'PY'
import sys, re
from html.parser import HTMLParser
class P(HTMLParser):
    def __init__(s): super().__init__(); s.depth=0; s.c={'h2':0,'pre':0,'img':0,'noalt':0,'table':0}; s.txt=[]; s.src=[]; s.href=[]
    def handle_starttag(s, t, a):
        if s.depth: s.depth += t == 'div'
        elif t == 'div' and ('class', 'content') in a: s.depth = 1; return
        if not s.depth: return
        a = dict(a)
        if t in s.c: s.c[t] += 1
        if t == 'img': s.src.append(a.get('src', '')); s.c['noalt'] += not a.get('alt')
        if t == 'a': s.href.append(a.get('href', ''))
    def handle_endtag(s, t):
        if s.depth and t == 'div': s.depth -= 1
    def handle_data(s, d):
        if s.depth: s.txt.append(d)
p = P(); p.feed(open(sys.argv[1]).read()); txt = ''.join(p.txt)
imgs = ' '.join(sorted(x.rsplit('/', 1)[-1] for x in p.src))
repo = 'repo' if 'https://github.com/bagaswibowo25/howdy-setup-suse' in p.href else 'norepo'
priv = 'pribadi' if re.search(r'/home/|by-id|@gmail|wibowo-|\bwibowo@', txt) else 'bersih'
print(*p.c.values(), imgs, repo, priv)
PY
)
    case $P in $HID) want="8 4 2 0 1 login-wajah.gif siklus-ir.svg repo bersih" ;; *) want="8 4 2 0 1 ir-cycle.en.svg login-wajah.gif repo bersih" ;; esac
    [ "$got" = "$want" ] && ok "#16 S7/S9 $P: isi lengkap (8 bagian, 4 blok kode, tabel, GIF + diagram ber-alt, tautan repo), tanpa data pribadi" \
      || bad "#16 S7/S9 $P: $got ≠ $want"
  done

  # Semua gambar lokal di semua halaman benar-benar ada di hasil build (gambar rusak = ❌).
  broken=""
  while IFS= read -r f; do
    dir=$(dirname "${f#$D}")
    for src in $(grep -oE '<img src="?[^ ">]+' "$f" | sed -E 's/<img src="?//'); do
      case "$src" in http*|//*|data:*) continue ;; /*) p="$D$src" ;; *) p="$D$dir/$src" ;; esac
      [ -f "$p" ] || broken="$broken ${f#$D/}→$src"
    done
  done < <(find "$D" -name index.html)
  [ -z "$broken" ] && ok "gambar: semua <img> lokal ada filenya" || bad "gambar rusak:$(echo $broken | head -c 300)"

  # Aturan — tanpa layanan pihak luar (Algolia, Google Fonts, skrip/stylesheet dari domain lain).
  ext=$(grep -rlE 'algolia|fonts\.googleapis|fonts\.gstatic|<script[^>]+src=https?://|<link[^>]+stylesheet[^>]+href=https?://' "$D" --include='*.html' --include='*.js' --include='*.css' | head -3)
  [ -z "$ext" ] && ok "aturan: tanpa layanan/skrip pihak luar" || bad "aturan: referensi pihak luar di:$ext"

  # Aturan — tanpa kolom komentar.
  grep -rqiE 'disqus|giscus|utteranc|commento' "$D" --include='*.html' && bad "aturan: ada kolom komentar" || ok "aturan: tanpa kolom komentar"
fi

if [ "$mode" = fixture ]; then
  # Skenario 3 — paginasi saat tulisan lebih dari satu halaman.
  if [ "$(count index.html 'class=post-entry')" -eq 5 ] && [ -f "$D/page/3/index.html" ] && has index.html 'href=/page/2/ data-load-more'; then ok "S3 5 tulisan per halaman, tombol tampilkan lebih lama → /page/2/"
  else bad "S3 paginasi"; fi

  # Skenario 6 — tulisan tanpa seri tidak punya navigasi seri.
  if [ -f "$D/tulisan/uji-tunggal/index.html" ] && ! has tulisan/uji-tunggal/index.html 'series-nav'; then
    ok "S6 tulisan tanpa seri: tanpa navigasi seri"; else bad "S6 tulisan tanpa seri"; fi

  # Skenario 11, 13 — terjemahan saling menaut, versi en tampil di beranda en tanpa lencana.
  if has tulisan/uji-dua-bahasa/index.html 'hreflang=en-US href=https://www.jurnalbagas.com/en/posts/bilingual-test/' \
     && has en/posts/bilingual-test/index.html 'hreflang=id-ID href=https://www.jurnalbagas.com/tulisan/uji-dua-bahasa/' \
     && has tulisan/uji-dua-bahasa/index.html 'class=alt-lang' \
     && has tulisan/uji-dua-bahasa/index.html 'class="icon-btn lang-switch" href=/en/posts/bilingual-test/' \
     && has en/index.html 'Bilingual Test' && ! grep -q 'Uji Dua Bahasa' "$D/en/index.html"; then
    ok "S11/S13 terjemahan saling menaut; tombol bahasa ke pasangannya; beranda en pakai versi en"
  else bad "S11/S13 dua bahasa"; fi

  if python3 -c "import json,sys; b=json.load(open('$D/en/index.json')); sys.exit(0 if [p['title'] for p in b]==['Bilingual Test'] else 1)"; then
    ok "S14 indeks en hanya berisi tulisan en"; else bad "S14 indeks en (fixture)"; fi
fi

exit $fail
