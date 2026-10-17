// Skenario spec #5 yang butuh browser: 5, 8, 9, 10, 14, 15 + kontras (constitution #7).
import { test, expect } from '@playwright/test';

const ARTICLE = '/tulisan/belajar-python-dictionary/';

test('S5 navigasi seri bisa disembunyikan dan dibuka lagi (diingat)', async ({ page }) => {
  await page.setViewportSize({ width: 1280, height: 900 });
  await page.goto(ARTICLE);
  const nav = page.locator('.series-nav');
  const rail = page.locator('.series-rail');
  await expect(nav).toBeVisible();
  await expect(rail).toBeHidden();
  const before = await page.locator('.prose').boundingBox();
  await nav.locator('[data-nav-toggle]').click();
  await expect(nav).toBeHidden();
  await expect(rail).toBeVisible();
  const after = await page.locator('.prose').boundingBox();
  expect(after.x).toBeLessThan(before.x); // tulisan bergeser ke tengah
  await page.reload();
  await expect(nav).toBeHidden();
  await rail.locator('[data-nav-toggle]').click();
  await expect(nav).toBeVisible();
});

const PAGES = ['/', '/tulisan/', '/tag/python/', '/seri/python-dasar/', '/tag/', ARTICLE, '/tentang/', '/kontak/', '/en/', '/en/about/', '/404.html',
  '/en/posts/kubernetes-logs-observability-with-clickstack/', '/en/posts/effortless-kubernetes-delivery-with-zuul-ci/', '/en/posts/helm-templating-network-policy/'];
for (const width of [320, 360, 390, 768]) for (const url of PAGES) {
  test(`S8 ponsel ${width}px tanpa geser ke samping: ${url}`, async ({ page }) => {
    await page.setViewportSize({ width, height: 800 });
    await page.goto(url);
    await expect(page.locator('.menu summary')).toBeVisible();
    await expect(page.locator('.site-header .nav')).toBeHidden();
    const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
    expect(overflow).toBeLessThanOrEqual(0);
  });
}

for (const width of [320, 390, 1280]) {
  test(`chip tag turun baris, tanpa scroll samping (${width}px)`, async ({ page }) => {
    await page.setViewportSize({ width, height: 800 });
    await page.goto('/');
    const chips = page.locator('.chips');
    const [sw, cw] = await chips.evaluate((e) => [e.scrollWidth, e.clientWidth]);
    expect(sw).toBeLessThanOrEqual(cw);
    await expect(chips.locator('.chip').last()).toBeInViewport();
  });
}

test('S8 ponsel 320px: tema & bahasa pindah ke menu', async ({ page }) => {
  await page.setViewportSize({ width: 320, height: 700 });
  await page.goto('/');
  await expect(page.locator('.header-extra [data-theme-toggle]')).toBeHidden();
  await page.locator('.menu summary').click();
  await expect(page.locator('.menu-extra [data-theme-toggle]')).toBeVisible();
  await expect(page.locator('.menu-extra .lang-switch')).toBeVisible();
});

test('S8 ponsel: kartu seri bisa dibuka-tutup, sidebar disembunyikan', async ({ page }) => {
  await page.setViewportSize({ width: 390, height: 844 });
  await page.goto(ARTICLE);
  await expect(page.locator('.series-nav')).toBeHidden();
  const card = page.locator('.series-card');
  await expect(card).toBeVisible();
  await expect(card.locator('.series-list')).toBeHidden();
  await card.locator('summary').click();
  await expect(card.locator('.series-list li')).toHaveCount(8);
  await expect(card.locator('.series-list')).toBeVisible();
});

for (const [scheme, bg] of [['dark', 'rgb(10, 10, 10)'], ['light', 'rgb(250, 250, 250)']]) {
  test(`S9 mengikuti mode perangkat: ${scheme}`, async ({ browser }) => {
    const ctx = await browser.newContext({ colorScheme: scheme });
    const page = await ctx.newPage();
    await page.goto('/');
    await expect(page.locator('body')).toHaveCSS('background-color', bg);
    await ctx.close();
  });
}

test('S10 tombol ganti mode, pilihan diingat', async ({ browser }) => {
  const ctx = await browser.newContext({ colorScheme: 'light' });
  const page = await ctx.newPage();
  await page.goto('/');
  await page.locator('.header-extra [data-theme-toggle]').click();
  await expect(page.locator('body')).toHaveCSS('background-color', 'rgb(10, 10, 10)');
  await page.goto(ARTICLE);
  await expect(page.locator('body')).toHaveCSS('background-color', 'rgb(10, 10, 10)');
  await page.locator('.header-extra [data-theme-toggle]').click();
  await page.reload();
  await expect(page.locator('body')).toHaveCSS('background-color', 'rgb(250, 250, 250)');
  await ctx.close();
});

test('S3 tampilkan lebih lama memuat tulisan berikutnya di halaman yang sama', async ({ page }) => {
  await page.goto('/');
  const entries = page.locator('[data-entries] > .post-entry');
  await expect(entries).toHaveCount(5);
  await page.locator('[data-load-more]').click();
  await expect(entries).toHaveCount(10);
  await page.locator('[data-load-more]').click();
  await expect(entries).toHaveCount(11);
  await expect(page).toHaveURL(/\/$/);
  await expect(page.locator('[data-load-more]')).toHaveCount(0);
});

test('S3 tanpa JavaScript tombol membuka halaman berikutnya', async ({ browser }) => {
  const ctx = await browser.newContext({ javaScriptEnabled: false });
  const page = await ctx.newPage();
  await page.goto('/');
  await page.locator('[data-load-more]').click();
  await expect(page).toHaveURL(/\/page\/2\/$/);
  await expect(page.locator('.post-entry')).toHaveCount(5);
  await ctx.close();
});

test('S14 pencarian menemukan tulisan', async ({ page }) => {
  await page.goto('/');
  await page.locator('[data-search-open]').click();
  await page.locator('[data-search-input]').fill('dictionary');
  await expect(page.locator('[data-search-results] a').first()).toContainText('Belajar Python - Dictionary');
  await page.locator('[data-search-input]').fill('zzzzkatayangtidakada');
  await expect(page.locator('[data-search-empty]')).toBeVisible();
});

for (const [q, title] of [['helm', 'Helm — Templating Network Policy'], ['zuul', 'Effortless Kubernetes Delivery with Zuul CI']]) {
  test(`#6 S9 pencarian en menemukan "${q}"`, async ({ page }) => {
    await page.goto('/en/');
    await page.locator('[data-search-open]').click();
    await page.locator('[data-search-input]').fill(q);
    await expect(page.locator('[data-search-results] a').first()).toContainText(title);
  });
}

test('#6 S7 blok kode panjang bergeser di dalam kotaknya sendiri (ponsel)', async ({ page }) => {
  await page.setViewportSize({ width: 360, height: 800 });
  await page.goto('/en/posts/helm-templating-network-policy/');
  const scrollable = await page.locator('.content pre').evaluateAll((els) => els.some((e) => e.scrollWidth > e.clientWidth && getComputedStyle(e).overflowX === 'auto'));
  expect(scrollable).toBe(true);
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - document.documentElement.clientWidth);
  expect(overflow).toBeLessThanOrEqual(0);
});

test('S15 tanpa JavaScript: tombol cari tidak tampil, tulisan tetap terbaca', async ({ browser }) => {
  const ctx = await browser.newContext({ javaScriptEnabled: false });
  const page = await ctx.newPage();
  await page.goto(ARTICLE);
  await expect(page.locator('[data-search-open]')).toBeHidden();
  await expect(page.locator('.prose h1')).toHaveText('Belajar Python - Dictionary');
  await expect(page.locator('.content')).toContainText('Dictionary merupakan');
  await expect(page.locator('.series-nav')).toBeVisible();
  await ctx.close();
});

for (const scheme of ['dark', 'light']) {
  test(`kontras teks ≥ 4.5:1 (${scheme})`, async ({ browser }) => {
    const ctx = await browser.newContext({ colorScheme: scheme });
    const page = await ctx.newPage();
    await page.goto('/');
    const ratios = await page.evaluate(() => {
      const css = getComputedStyle(document.documentElement);
      const hex = (v) => css.getPropertyValue(v).trim();
      const lum = (h) => {
        const c = [1, 3, 5].map((i) => parseInt(h.slice(i, i + 2), 16) / 255)
          .map((x) => (x <= 0.03928 ? x / 12.92 : ((x + 0.055) / 1.055) ** 2.4));
        return 0.2126 * c[0] + 0.7152 * c[1] + 0.0722 * c[2];
      };
      const ratio = (a, b) => { const [x, y] = [lum(a), lum(b)].sort((p, q) => q - p); return (x + 0.05) / (y + 0.05); };
      const out = {};
      for (const fg of ['--text', '--body', '--muted', '--dim', '--accent']) out[fg] = ratio(hex(fg), hex('--bg'));
      out['--on-fill/--fill'] = ratio(hex('--on-fill'), hex('--fill'));
      return out;
    });
    for (const [k, v] of Object.entries(ratios)) expect(v, k).toBeGreaterThanOrEqual(4.5);
    await ctx.close();
  });
}
