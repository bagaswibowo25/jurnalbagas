# Jurnal Bagas — Agent Rules

Rules for all AI agents (Claude Code, Copilot, etc.) working in this repository.

Jurnal Bagas adalah blog pribadi (https://www.jurnalbagas.com) yang dibangun dengan **Hugo** dan dilayani sebagai
**situs statis di GitHub Pages** — tanpa server, tanpa database. Alur pengembangannya (SDD v2) diadaptasi dari
1994-erp; yang berbeda hanya konteks project dan proses deploy.

---

## 1. Build & cek selalu lewat `scripts/build.sh`

Tidak ada test unit; gerbang kualitas = **situs berhasil di-build dan lolos cek otomatis**:

```bash
scripts/build.sh          # hugo --minify ke folder sementara + cek hasil build
scripts/build.sh serve    # preview lokal (hugo server) untuk dilihat owner
scripts/build.sh ui       # build + cek + test browser (Playwright di Docker) — wajib bila tampilan berubah
```

`build.sh` memakai `hugo` di mesin bila ada, kalau tidak lewat Docker (`hugomods/hugo`, versi terpatok) — jangan memasang versi
Hugo lain secara manual tanpa mencatatnya di `docs/reference/system.md`. Hasil build tidak pernah di-commit ke
branch kerja: `public/`, `resources/`, `.build/` di-`.gitignore`, dan `build.sh` gagal bila build/preview mengubah
repo. Preview selalu lewat `scripts/build.sh serve` (render ke memori), jangan `hugo server` langsung.

---

## 2. All findings, bugs, and new features go into the GitHub Project

Backlog, status, cycle, dan progress Epic hidup di **GitHub Project** — https://github.com/users/bagaswibowo25/projects/2 —
bukan di markdown.

Temuan, bug, atau ide yang muncul di tengah task → buat issue sebelum lanjut:

```bash
scripts/gh-project.sh new "<judul ringkas>" finding "<temuan + bukti (file:line, URL, output build)>"
# type: bug | feature | finding | improvement | chore
```

Issue baru masuk kolom **Backlog tanpa Priority** → muncul di view "Perlu triage". Triage (owner) mengisi Priority +
Size + Epic **setelah spec diberi label `spec-approved`** (§4), atau memindahkan ke Icebox.

---

## 3. Check the issue before executing any task

Sebelum mengubah kode, konfigurasi, atau konten:

1. Issue punya label **`spec-approved`** dan Status **Ready** atau **In Progress**.
2. Folder `docs/specs/<n>-<slug>/` berisi `spec.md`, `plan.md`, dan `tasks.md`, dan di-link dari body issue.

Kalau belum ada → ikuti alur §4. Jangan implementasi tanpa spec yang disetujui owner.

---

## 4. Follow Spec Driven Development (SDD v2)

**Aturan lengkap: [`docs/specs/README.md`](docs/specs/README.md)** — wajib dibaca sebelum menulis spec/plan/tasks.

```
Issue (Backlog tanpa Priority / Icebox)
    │  /sdd-spec  → docs/specs/<n>-<slug>/spec.md   (bahasa awam, untuk owner)
    ▼
label spec-approved  ← HANYA owner
    │  triage (Priority + Size + Epic)            → Backlog
    │  /sdd-plan  → plan.md + tasks.md             → Ready
    ▼
/sdd-implement → worktree → PR                     → In Progress → Review → Done
```

- **Never code first.** Spec disetujui owner sebelum plan ditulis; plan ditulis sebelum kode.
- **Spec bebas istilah teknis** (tanpa nama file, template/partial, shortcode, library, kode). Hal teknis → `plan.md`.
- **Satu alur untuk semua pekerjaan** — fitur, bug, chore, tulisan yang diimpor, XS sampai XL, termasuk situs down
  (perbaikan boleh disiapkan sambil menunggu label, PR/deploy tidak).
- **Isi spec berubah** → berhenti, ubah spec, cabut label `spec-approved`, komentar di issue.
- **Cek dulu** [`docs/constitution.md`](docs/constitution.md) dan epic terkait (`docs/epics/`) sebelum menulis spec;
  `docs/reference/` sebelum menulis plan.
- Checklist di `tasks.md` dicentang saat implementasi; temuan teknis ke `plan.md` §10, bukan ke tasks. Issue
  **tidak** menduplikasi isi spec/plan/tasks.
- **ID = nomor issue GitHub.** Folder `docs/specs/<n>-<slug>/`, branch `feat/<n>-<slug>` (atau `fix/`, `chore/`).
- **Bahasa Indonesia, ringkas.** Nama field YAML frontmatter tetap Inggris.

---

## 4b. Status hidup di GitHub Project — satu-satunya sumber

Kolom Status:

| Status | Arti | Syarat masuk |
|---|---|---|
| **Icebox** | Ide/temuan yang sengaja ditunda | — |
| **Backlog** | Tanpa Priority: baru masuk, spec belum ada / menunggu label (view "Perlu triage"). Dengan Priority: spec disetujui + di-triage, plan belum ada | Triage butuh label `spec-approved` |
| **Ready** | Siap diambil, belum dikerjakan | `plan.md` + `tasks.md` ada |
| **In Progress** | Sedang dikerjakan | Branch dibuat |
| **Review** | Menunggu review/merge | PR terbuka |
| **Done** | Selesai | Issue closed |

- **Blocked** = label `blocked` (item tetap di kolomnya) + komentar alasannya.
- **Dropped** = close issue sebagai *not planned*.
- Sudah merged tapi masih perlu dicek di situs live = label `needs-prod-verify`.
- Field lain: **Priority** P0–P3 · **Size** XS–XL · **Epic** (Theme / Content / Infra) · **Cycle**.
- **Cycle = satu bulan kalender**, dinamai `YYYY-MM` (`2026-10`). Isi Cycle saat item dijadwalkan untuk bulan itu
  (biasanya saat masuk Ready/In Progress) — bukan saat dibuat. Item yang molor dipindah ke cycle berikutnya. Cycle
  baru ditambahkan di pengaturan field Cycle sebelum bulannya mulai. Rencana bulanan ditulis sebagai **Status update**
  di Project, bukan file baru di repo.
- **Progress Epic** = sub-issues. Tiap Epic punya issue induk berlabel `epic` (`Epic: Theme` #1 · `Epic: Content` #2 ·
  `Epic: Infra` #3). Saat triage, isi field Epic **dan** jadikan issue itu sub-issue dari induknya. Issue Epic tidak
  pernah ditutup.

Semua perubahan field bisa lewat `scripts/gh-project.sh` (`status`, `set`, `epic`, `triage`, `show`) — jalankan tanpa
argumen untuk bantuan.

**Saat MULAI:** pindahkan issue ke In Progress. **Saat PR dibuka:** Review. **Saat SELESAI:** PR memakai
`Closes #<n>` → issue tertutup → Done otomatis.

Status **tidak** ditulis di tempat lain — tidak di markdown, tidak di frontmatter. Satu sumber, tidak ada yang perlu
disinkronkan.

---

## 4c. Frontmatter

`spec.md`: `issue: <n>` + `epic: <Epic>`. `tasks.md`: `issue: <n>`. `plan.md`: tanpa frontmatter. Status, priority,
size, cycle **tidak** ditulis di file — hanya di Project. Template: `docs/templates/`.

---

## 4d. Konten dan URL

- **Tulisan milik penulis.** Agent tidak mengubah isi tulisan (kalimat, opini, kesimpulan) tanpa diminta. Perbaikan
  teknis (link rusak, format kode, front matter) boleh, dan dicatat di PR.
- **URL yang sudah terbit tidak berubah.** Mengganti struktur permalink, slug, atau section wajib menyediakan
  redirect (alias Hugo) dari alamat lama. Cek: daftar URL sebelum vs sesudah build di PR.
- **Tulisan impor dari Medium** mempertahankan tanggal terbit asli, menyimpan link ke versi Medium (canonical), dan
  gambarnya disimpan di repo — bukan di-hotlink.
- Gambar diberi teks alternatif.

---

## 5. Konteks project: constitution, epic, rujukan

- [`docs/constitution.md`](docs/constitution.md) — prinsip yang mengikat semua pekerjaan. Baca sebelum spec.
- [`docs/epics/`](docs/epics/) — tujuan, keputusan owner, dan istilah per domain. Baca epic terkait sebelum spec.
- [`docs/reference/`](docs/reference/) — rujukan teknis untuk plan: `system.md` (stack, struktur konten, deploy),
  `design.md` (standar tampilan yang dipilih owner).
- **Setup device:** `scripts/doctor.sh` dijalankan otomatis oleh hook SessionStart (`.claude/settings.json`). Bila
  ia melaporkan ❌, sampaikan ke owner sebelum mulai bekerja.

---

## 6. Worktree dan diff PR

Owner bisa menjalankan beberapa sesi agen sekaligus, jadi tiap issue dikerjakan di worktree sendiri.

1. **Buat dan hapus worktree lewat `scripts/worktree.sh`** — `new ../jurnalbagas-<n> <branch>` / `rm <dir>`.
   Worktree selalu dibuat dari `origin/master`.
2. **Sebelum membuka PR, baca `scripts/worktree.sh diff`** (vs `origin/master`). Setiap file harus milik issue ini;
   file yang **dihapus** disorot dan harus disengaja.
3. **Sebelum merge, cek lagi daftar file PR** (`gh pr diff <n> --name-only`) — `master` bisa sudah maju sejak branch
   dibuat.
4. **Merge dilakukan owner.** Setelah PR siap, berikan baris `! gh pr merge <n> --squash` untuk dijalankan owner.
