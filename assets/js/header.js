// Navigasi atas menyingkir saat scroll ke bawah dan muncul saat scroll ke atas (Theme K9, spec #13).
// Tanpa JS header tetap menempel (CSS). Tidak menyingkir saat menu/kotak cari terbuka atau fokus ada di header.
(function () {
  var root = document.documentElement;
  var header = document.querySelector(".site-header");
  if (!header) return;
  var menu = header.querySelector("details.menu");
  var dialog = document.querySelector("[data-search-dialog]");
  var lastY = window.scrollY;
  var THRESHOLD = 6;

  function measure() { root.style.setProperty("--header-h", header.offsetHeight + "px"); }
  function show() { root.classList.remove("header-hidden"); }
  function locked() {
    return (menu && menu.open) || (dialog && dialog.open) || header.contains(document.activeElement);
  }
  function onScroll() {
    var y = window.scrollY;
    var dy = y - lastY;
    if (Math.abs(dy) < THRESHOLD) return;
    if (dy > 0 && y > header.offsetHeight && !locked()) root.classList.add("header-hidden");
    else if (dy < 0) show();
    lastY = y;
  }

  measure();
  window.addEventListener("resize", measure);
  window.addEventListener("scroll", onScroll, { passive: true });
  header.addEventListener("focusin", show);
  if (menu) menu.addEventListener("toggle", function () { if (menu.open) show(); });
})();
