// Test UI (#5) — dijalankan lewat `scripts/build.sh ui` di container Playwright terhadap .build/.
export default {
  testDir: '.',
  testMatch: '*.spec.mjs',
  reporter: [['list']],
  use: { baseURL: 'http://localhost:8080' },
};
