---
issue: 6
epic: Content
---
# Spec — Memindahkan tiga tulisan Medium ke blog

## Latar

Owner punya tiga tulisan teknis berbahasa Inggris di Medium (https://bagas-awibowo.medium.com/):

| Terbit | Judul |
|---|---|
| 5 Januari 2026 | Kubernetes Logs Observability with ClickStack — ClickHouse & HyperDX |
| 14 Juli 2024 | Effortless Kubernetes Delivery with Zuul CI |
| 4 Februari 2024 | Helm — Templating Network Policy using Helm |

Tulisan itu terpisah dari blog, jadi pembaca blog tidak menemukannya dan owner tidak punya satu tempat untuk semua
tulisannya. Owner ingin blog menjadi rumah utama semua tulisan, dan ke depan menulis langsung di blog.

## Cerita pengguna

**P1 · Semua tulisan di satu tempat.** Sebagai penulis, saya ingin tulisan Medium saya ada di blog dengan isi utuh dan
tanggal aslinya, supaya blog menjadi rumah utama semua tulisan saya.

**P2 · Pembaca menemukan dan membacanya.** Sebagai pembaca (berbahasa Indonesia maupun Inggris), saya ingin melihat
tulisan ini di beranda, tag, dan pencarian, dan membacanya dengan nyaman di ponsel maupun desktop.

**P3 · Seri dan tag yang terlihat.** Sebagai pembaca, saya ingin tulisan Kubernetes ini terkumpul dalam satu seri, dan
tag maupun seri dari bahasa mana pun terlihat di beranda dan daftar seri, supaya saya bisa menjelajah per topik.

**P4 · Sumber asli jelas.** Sebagai pembaca, saya ingin tahu tulisan ini pertama terbit di Medium dan bisa membuka
versi aslinya.

## Skenario terima

1. Kalau pembaca membuka beranda versi Inggris, maka ketiga tulisan tampil di urutan sesuai tanggal terbit aslinya,
   tanpa lencana.
2. Kalau pembaca membuka beranda versi Indonesia, maka ketiga tulisan juga tampil sesuai tanggal aslinya dengan
   lencana "EN", dan membukanya mengarah ke versi Inggris.
3. Kalau pembaca membuka salah satu tulisan, maka di bawah judul tampil tanggal terbit asli dan catatan "First
   published on Medium" beserta tanggalnya, dengan tautan ke tulisan aslinya di Medium.
4. Kalau mesin pencari membaca halaman tulisan itu, maka halaman menyatakan bahwa versi blog adalah versi utamanya.
5. Kalau tulisan dibuka, maka semua isinya sama dengan aslinya: paragraf, subjudul, daftar, kutipan, blok kode, gambar
   beserta keterangannya, dan tautan.
6. Kalau tulisan dibuka, maka semua gambar dimuat dari blog sendiri; tidak ada yang dimuat dari Medium.
7. Kalau tulisan dibuka di ponsel, maka blok kode yang panjang bisa digeser di dalam kotaknya sendiri, dan halaman
   tidak ikut bergeser ke samping.
8. Kalau pembaca menekan tag topik (mis. kubernetes), maka tampil daftar tulisan dengan topik itu.
9. Kalau pembaca mencari "helm" atau "zuul" di versi Inggris, maka tulisan yang cocok muncul.
10. Kalau pembaca membuka salah satu dari ketiga tulisan, maka di samping tampil navigasi seri "kubernetes-in-practice"
    berisi ketiganya berurutan: Helm (bagian 1), Zuul CI (bagian 2), ClickStack (bagian 3), dengan tautan ke bagian
    sebelumnya dan berikutnya.
11. Kalau pembaca melihat chip tag di beranda Indonesia, maka tag dari tulisan Inggris (mis. kubernetes, devops) ikut
    tampil dengan tanda "EN" dan membuka daftar tulisan tag itu; sebaliknya di beranda Inggris, tag python dan
    programming tampil dengan tanda "ID".
12. Kalau pembaca membuka daftar seri (Indonesia maupun Inggris), maka kedua seri — python-dasar dan
    kubernetes-in-practice — tampil; seri dari bahasa lain diberi tanda bahasanya dan membuka halaman serinya.
13. Alamat tulisan: `/en/posts/kubernetes-logs-observability-with-clickstack/`,
    `/en/posts/effortless-kubernetes-delivery-with-zuul-ci/`, `/en/posts/helm-templating-network-policy/`.

## Aturan

- Isi tulisan tidak diubah: tidak diterjemahkan, tidak diringkas, tidak ditulis ulang (constitution #2). Yang boleh
  disesuaikan hanya hal teknis agar tampil benar (format kode, letak gambar).
- Tanggal terbit tetap tanggal asli di Medium.
- Versi blog adalah versi utama; tautan ke versi Medium tetap ada (Content K1).
- Tag mengikuti topik tulisan, bukan asal tulisan — tidak ada tag "medium" (Content K2): ClickStack → kubernetes,
  observability, devops; Zuul CI → kubernetes, cicd, devops; Helm → helm, kubernetes, devops.
- Ketiga tulisan menjadi seri "kubernetes-in-practice", urut tanggal terbit (Content K5).
- Tag dan seri dari bahasa lain tampil di chip tag dan daftar seri dengan tanda bahasanya, mengikuti aturan beranda
  (Theme K8).
- Tulisan berbahasa Inggris yang belum punya versi Indonesia tampil di beranda Indonesia dengan lencana "EN"
  (Content K3; cerminan Theme K4).
- Gambar disimpan di blog sendiri, bukan diambil dari Medium (constitution #4, #5).
- Import dilakukan sekali untuk tiga tulisan ini (Content K4).

## Kriteria sukses

- Owner membuka ketiga tulisan di blog dan isinya sama dengan di Medium, termasuk gambar dan kode.
- Owner melihat ketiganya di beranda Indonesia (berlencana EN) dan beranda Inggris.
- Tautan "First published on Medium" membuka tulisan aslinya.

## Di luar cakupan

- Menerjemahkan ketiga tulisan ke bahasa Indonesia.
- Sinkronisasi otomatis atau alat import untuk tulisan Medium berikutnya.
- Mengubah atau menghapus tulisan di Medium, termasuk mengatur penanda versi utama di pengaturan Medium (dilakukan
  owner sendiri di akun Medium bila diinginkan).
