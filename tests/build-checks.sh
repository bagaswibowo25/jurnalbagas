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
redirects_to() { grep -qE "url=https://www\.jurnalbagas\.com$2\"?>" "$D/$1/index.html" 2>/dev/null; }

POSTS=(tipe-data kondisional perulangan fungsi list tuple set dictionary)
OLD=(tipe_data kondisional perulangan fungsi list tuple set dictionary)

if [ "$mode" = site ]; then
  # Skenario 1 — beranda: feed tulisan, terbaru dulu, tanpa banner.
  n=$(( $(count index.html 'class=post-entry') + $(count page/2/index.html 'class=post-entry') ))
  dates=$(cat "$D/index.html" "$D/page/2/index.html" 2>/dev/null | grep -oE '\[20[0-9]{2}-[0-9]{2}-[0-9]{2}\]' | tr -d '[]')
  if [ "$n" -ge 8 ] && [ "$dates" = "$(echo "$dates" | sort -r)" ] && has index.html 'whoami' && ! has index.html 'hero'; then
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
  n=$(( $(count en/index.html 'class=badge-id') + $(count en/page/2/index.html 'class=badge-id') ))
  if [ "$n" -eq 8 ] && has en/index.html 'href=/tulisan/belajar-python-dictionary/' && has en/index.html './posts'; then
    ok "S12 beranda en: $n tulisan berlencana ID, menu en"
  else bad "S12 beranda en (lencana=$n)"; fi

  # Skenario 14 — indeks pencarian per bahasa.
  if python3 -c "import json,sys; a=json.load(open('$D/index.json')); b=json.load(open('$D/en/index.json')); \
sys.exit(0 if len(a)==8 and all(p['url'].startswith('/tulisan/') for p in a) and b==[] else 1)"; then
    ok "S14 indeks pencarian: id 8 tulisan, en hanya tulisan en (0)"
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
