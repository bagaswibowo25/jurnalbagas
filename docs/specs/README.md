# SDD v2 — alur spec → plan → tasks

> Berlaku sejak 2026-10-17 (#4). Diadaptasi dari alur SDD v2 di 1994-erp, yang formatnya diadaptasi dari
> [GitHub spec-kit](https://github.com/github/spec-kit), tanpa `specify init`.

## Lapisan

| Lapis | File | Isi | Pembaca |
|---|---|---|---|
| Constitution | [`docs/constitution.md`](../constitution.md) | Prinsip untuk semua pekerjaan | Owner + agent |
| Epic | [`docs/epics/<epic>.md`](../epics/) | Tujuan domain, keputusan owner (K1…), istilah, peta spec | Owner + agent |
| **Spec** | `docs/specs/<n>-<slug>/spec.md` | **Apa & kenapa**, bahasa awam | **Owner** |
| Plan | `docs/specs/<n>-<slug>/plan.md` | Bagaimana (teknis) + catatan pengerjaan | Agent + reviewer |
| Tasks | `docs/specs/<n>-<slug>/tasks.md` | Checklist per cerita pengguna | Agent |

`<n>` = nomor issue GitHub. Satu folder per pekerjaan, datar (tidak dikelompokkan per epic — epic ada di frontmatter
`spec.md` dan field Project). Template: [`docs/templates/`](../templates/). Rujukan teknis untuk plan:
[`docs/reference/`](../reference/).

**Semua pekerjaan memakai tiga file dan alur yang sama** — fitur, bug, chore, impor tulisan, XS sampai XL. Tidak ada
jalur ringan.

## Alur dan status

| Langkah | Status Project | Siapa | Syarat |
|---|---|---|---|
| Issue dibuat (`scripts/gh-project.sh new`) | Backlog **tanpa Priority** (view "Perlu triage") / Icebox | siapa saja | — |
| `spec.md` ditulis, link di issue, komentar "spec siap" | tetap | agent (`/sdd-spec`) | owner meminta spec ditulis |
| Owner memberi label **`spec-approved`** | tetap | **owner** | owner sudah membaca spec |
| Triage: Priority + Size + Epic | **Backlog** (dengan Priority) | owner | label ada — `gh-project.sh triage` menolak tanpa label |
| `plan.md` + `tasks.md` ditulis | **Ready** | agent (`/sdd-plan`) | label + sudah di-triage |
| Worktree, implementasi | **In Progress** | agent (`/sdd-implement`) | Ready |
| PR dibuka | **Review** | agent | `/sdd-check` lolos, `scripts/build.sh` hijau |
| PR `Closes #<n>` di-merge | **Done** | owner | — |

Ide yang belum pasti diparkir di **Icebox** — spec hanya ditulis bila owner memintanya.

## Aturan

1. **Spec bebas istilah teknis**: tidak ada nama file, template/partial, shortcode, library, kode, nama komponen.
   Enam bagian: latar · cerita pengguna per peran (P1–P3; peran = pembaca atau penulis) · skenario terima
   "kalau … maka …" · aturan · kriteria sukses · di luar cakupan. Maks ±2 halaman.
2. **Plan tidak boleh ditulis sebelum label `spec-approved`.** Plan dan tasks tidak butuh persetujuan owner.
3. **Spec berubah di tengah jalan** (yang owner dapat jadi berbeda): berhenti, ubah `spec.md`, cabut label
   `spec-approved`, komentar di issue apa yang berubah dan kenapa. Lanjut setelah label diberikan lagi. Perubahan
   yang hanya teknis cukup di `plan.md`/`tasks.md`.
4. **Situs rusak / down**: alur tetap sama. Spec ditulis sangat singkat dan owner segera diberi tahu. Selama menunggu
   label, perbaikan boleh disiapkan di worktree, tetapi **tidak boleh** membuka PR atau deploy.
5. **Catatan**:
   | Jenis | Tempat |
   |---|---|
   | Temuan teknis untuk pekerjaan ini | `plan.md` §10 Catatan pengerjaan |
   | Bug / ide / pekerjaan di luar cakupan | issue baru (`gh-project.sh new`) |
   | Mengubah apa yang owner dapat | `spec.md` + persetujuan ulang (aturan 3) |
   | Ringkasan perubahan + hasil build | deskripsi PR |

   `tasks.md` hanya berisi checkbox + satu baris per langkah.
6. **Epic**: keputusan owner baru di satu domain ditambahkan ke dokumen epic-nya; spec baru ditambahkan ke peta spec.
7. **Keputusan tampilan** (warna, font, layout) diambil dari mockup — desktop + mobile, gelap + terang — dan
   hasilnya dicatat di [`docs/reference/design.md`](../reference/design.md).

## Skill

| Skill | Fungsi |
|---|---|
| `/sdd-spec <n>` | Tulis `spec.md` (bertanya dulu bila ambigu), perbarui peta epic, link di issue |
| `/sdd-plan <n>` | Tulis `plan.md` + `tasks.md`, jalankan `/sdd-check`, pindahkan ke Ready |
| `/sdd-implement <n>` | Worktree, In Progress, kerjakan + centang tasks, PR, Review |
| `/sdd-check <n>` | Cek konsistensi spec ↔ plan ↔ tasks ↔ constitution |
| `/grill-me` | Wawancara untuk mematangkan rencana besar sebelum spec |

Skill hanya pembungkus — aturan di halaman ini dan di AGENTS.md tetap berlaku tanpa skill.
