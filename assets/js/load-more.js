// "Tampilkan lebih lama": muat halaman berikutnya dan tempel entrinya di bawah daftar (spec #5 skenario 3).
// Tanpa JS tombol tetap link biasa ke /page/N/.
(function () {
  var list = document.querySelector("[data-entries]");
  if (!list) return;
  document.addEventListener("click", function (e) {
    var btn = e.target.closest("[data-load-more]");
    if (!btn) return;
    e.preventDefault();
    btn.setAttribute("aria-busy", "true");
    fetch(btn.href).then(function (r) { return r.text(); }).then(function (html) {
      var doc = new DOMParser().parseFromString(html, "text/html");
      var first = null;
      doc.querySelectorAll("[data-entries] > .post-entry").forEach(function (el) {
        var node = document.importNode(el, true);
        list.appendChild(node);
        if (!first) first = node;
      });
      var next = doc.querySelector("[data-load-more]");
      if (next) { btn.href = next.getAttribute("href"); btn.removeAttribute("aria-busy"); }
      else btn.remove();
      var newer = document.querySelector(".pager .muted-link[href*='/page/']");
      if (newer && !newer.textContent.includes("rss")) newer.remove();
      if (first) { var a = first.querySelector(".entry-title a"); if (a) a.focus(); }
    }).catch(function () { window.location.href = btn.href; });
  });
})();
