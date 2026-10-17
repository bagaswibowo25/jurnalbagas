# Constitution — Jurnal Bagas

> Prinsip yang berlaku untuk **semua** pekerjaan. Setiap spec dan plan dicek terhadap halaman ini; plan wajib punya
> bagian "Cek constitution". Mengubah halaman ini butuh persetujuan owner. Rincian ada di dokumen rujukan yang
> ditautkan — prinsipnya hanya ditulis di sini.

## Tentang Jurnal Bagas

Blog pribadi Bagas Wibowo di https://www.jurnalbagas.com — catatan belajar (mis. seri Python Dasar), cerita perjalanan
karir sebagai engineer, dan arsip tulisan yang dipindahkan dari Medium. Pembacanya umum; penulisnya satu orang. Bahasa
utama Indonesia, waktu Asia/Jakarta.

## Prinsip

**1. Owner menyetujui apa yang dikerjakan.** Tidak ada pekerjaan yang dimulai sebelum spec-nya disetujui owner, dan
alurnya sama untuk semua pekerjaan — besar atau kecil, fitur atau perbaikan, termasuk saat situs bermasalah.
→ [Alur SDD](specs/README.md)

**2. Tulisan milik penulis.** Isi tulisan tidak diubah tanpa persetujuan penulis. Tulisan yang dipindahkan dari
tempat lain tetap utuh: tanggal terbit asli, isi, dan tautan ke sumber aslinya.

**3. Alamat tulisan tidak pernah putus.** Tulisan yang sudah terbit tetap bisa dibuka di alamat lamanya. Bila alamat
harus berubah, alamat lama mengarahkan ke yang baru.

**4. Situs statis, tanpa server.** Semua halaman bisa dilayani GitHub Pages sebagai file statis. Tidak ada server,
database, atau layanan berbayar yang wajib hidup agar situs berjalan. Fitur yang butuh layanan luar (komentar,
pencarian, statistik) bersifat tambahan: situs tetap utuh bila layanan itu mati, dan dipasang hanya dengan
persetujuan owner.
→ [Sistem](reference/system.md)

**5. Ringan dan menghormati pembaca.** Halaman cepat dibuka di ponsel, isi tetap terbaca walau JavaScript mati, dan
tidak ada pelacak pihak ketiga tanpa persetujuan owner.

**6. Semua halaman mengikuti satu standar tampilan.** Font, warna, dan tata letak mengikuti keputusan owner, berlaku
di mode gelap dan terang serta di desktop dan ponsel. Pola baru ditambahkan ke standar dulu, dengan persetujuan
owner, baru dipakai.
→ [Standar tampilan](reference/design.md)

**7. Bisa dibaca semua orang.** Kontras teks cukup, semua bisa dipakai dengan keyboard, gambar punya keterangan, dan
struktur judul rapi.

**8. Keputusan owner per domain sama mengikatnya.** Keputusan yang hanya berlaku di satu domain (mis. "tulisan Medium
diberi penanda arsip") ditulis di dokumen epic domain itu.
→ [Epic](epics/)

**9. Setiap skenario terima dibuktikan otomatis.** Sebuah pekerjaan baru selesai bila skenario di spec-nya terbukti
lewat pengecekan otomatis terhadap hasil build (situs ter-build, halaman dan tautan yang dijanjikan ada), bukan hanya
dicoba manual.
