// Sembunyikan/tampilkan navigasi seri (Theme K2, spec #5 skenario 5) + bilah progres baca.
(function () {
  var root = document.documentElement;
  document.querySelectorAll("[data-nav-toggle]").forEach(function (btn) {
    btn.addEventListener("click", function () {
      var hidden = root.getAttribute("data-nav") !== "hidden";
      if (hidden) root.setAttribute("data-nav", "hidden"); else root.removeAttribute("data-nav");
      try { localStorage.setItem("seriesNav", hidden ? "hidden" : "shown"); } catch (e) {}
      var other = document.querySelector(hidden ? ".series-rail [data-nav-toggle]" : ".series-nav [data-nav-toggle]");
      if (other) other.focus();
    });
  });
  var bar = document.querySelector("[data-progress]");
  if (bar) {
    var update = function () {
      var h = document.documentElement.scrollHeight - window.innerHeight;
      bar.style.width = (h > 0 ? Math.min(100, (window.scrollY / h) * 100) : 0) + "%";
    };
    window.addEventListener("scroll", update, { passive: true });
    update();
  }
})();
