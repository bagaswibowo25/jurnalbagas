# Jurnal Bagas — Claude Code Instructions

See **[AGENTS.md](AGENTS.md)** for all agent rules that apply in this repository.

Ringkasan yang paling sering terlewat (detail di AGENTS.md §2–§6 dan `docs/specs/README.md`):

- **Backlog & status ada di GitHub Project** — https://github.com/users/bagaswibowo25/projects/2. Temuan/bug/ide baru → `scripts/gh-project.sh new …`, bukan file markdown.
- **SDD v2:** `docs/specs/<n>-<slug>/` berisi `spec.md` (bahasa awam, untuk owner) → label `spec-approved` dari owner → `plan.md` + `tasks.md` → Ready → kode. Plan tidak boleh ditulis sebelum label. Skill: `/sdd-spec`, `/sdd-plan`, `/sdd-implement`, `/sdd-check`. Prinsip: `docs/constitution.md`.
- **Situs statis.** Semua harus bisa dilayani GitHub Pages tanpa server (constitution #4). Gerbang test = `scripts/build.sh` hijau.
- **Status hanya di Project** — pindahkan issue In Progress → Review sendiri; PR `Closes #<n>` menutupnya jadi Done.
- **Worktree per issue lewat `scripts/worktree.sh`** — sebelum PR baca `scripts/worktree.sh diff`: semua file harus milik issue ini.
