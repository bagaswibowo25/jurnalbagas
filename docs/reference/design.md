# Standar tampilan

> Keputusan owner 2026-10-17, dipilih dari mockup (desktop + mobile, gelap + terang):
> https://claude.ai/artifact/3WwGFn4DXsDg54SgECbTDc (halaman "Final"). Constitution #6: pola baru ditambahkan ke
> halaman ini dulu, dengan persetujuan owner. Belum diterapkan ke situs — implementasi lewat spec redesign (Epic Theme).

## Arah

**A · Terminal** — bersih, nuansa terminal, monokrom dengan satu aksen navy.

## Font (F3)

| Peran | Font |
|---|---|
| Judul, navigasi, metadata, kode | IBM Plex Mono (500/600/700) |
| Isi tulisan | IBM Plex Sans (400/500/600) |

## Warna (W9 · Mono + Navy)

| Token | Gelap | Terang |
|---|---|---|
| Latar | `#0A0A0A` | `#FAFAFA` |
| Permukaan (kartu, blok kode) | `#131313` | `#FFFFFF` |
| Garis | `#242424` | `#E5E5E5` |
| Teks utama | `#FAFAFA` | `#0A0A0A` |
| Teks isi | `#CFCFCF` | `#333333` |
| Teks redup | `#8F8F8F` | `#666666` |
| Aksen teks / link | `#8FA8E8` | `#1E3A8A` |
| Tombol | `#2B4FB3` (teks putih) | `#1E3A8A` (teks putih) |

Navy asli `#1E3A8A` tidak terbaca di atas hitam, jadi mode gelap memakai navy yang dicerahkan untuk teks.
Mode mengikuti setelan perangkat, dan pembaca bisa menggantinya lewat tombol di header.

## Layout

- **Beranda (L3 · feed log):** tanpa hero. Satu baris perkenalan, lalu daftar tulisan kronologis
  (`$ tail -f tulisan.log`) dengan filter tag. Tiap tulisan: tanggal, tag, seri, judul, ringkasan, tautan baca.
- **Artikel (AL2 · navigasi seri):** sidebar kiri berisi daftar bagian dalam seri; bagian yang sedang dibuka
  menampilkan daftar isinya. Sidebar **bisa disembunyikan** dan dibuka lagi. Di ponsel sidebar menjadi kartu seri
  yang bisa dibuka-tutup di atas artikel.
- Lebar isi tulisan maks ±720px. Ponsel: jarak tepi 16px, menu jadi tombol.
