// Pencarian di browser dari indeks JSON situs ini (Theme K6, spec #5 skenario 14) — tanpa layanan luar.
(function () {
  var dialog = document.querySelector("[data-search-dialog]");
  if (!dialog || typeof dialog.showModal !== "function") return;
  var input = dialog.querySelector("[data-search-input]");
  var list = dialog.querySelector("[data-search-results]");
  var empty = dialog.querySelector("[data-search-empty]");
  var index = null;

  function load() {
    if (index) return Promise.resolve(index);
    return fetch(dialog.getAttribute("data-index")).then(function (r) { return r.json(); }).then(function (d) {
      index = d.map(function (p) {
        p.haystack = [p.title, p.summary, (p.tags || []).join(" "), p.content].join(" ").toLowerCase();
        return p;
      });
      return index;
    });
  }

  function render(q) {
    var words = q.toLowerCase().split(/\s+/).filter(Boolean);
    list.innerHTML = "";
    if (!words.length) { empty.hidden = true; return; }
    var hits = index.filter(function (p) {
      return words.every(function (w) { return p.haystack.indexOf(w) !== -1; });
    }).sort(function (a, b) {
      var at = words.some(function (w) { return a.title.toLowerCase().indexOf(w) !== -1; }) ? 0 : 1;
      var bt = words.some(function (w) { return b.title.toLowerCase().indexOf(w) !== -1; }) ? 0 : 1;
      return at - bt || (a.date < b.date ? 1 : -1);
    }).slice(0, 10);
    empty.hidden = hits.length > 0;
    hits.forEach(function (p) {
      var li = document.createElement("li");
      var a = document.createElement("a");
      a.href = p.url;
      a.textContent = p.title;
      var small = document.createElement("small");
      small.textContent = p.date + " · " + p.summary;
      a.appendChild(small);
      li.appendChild(a);
      list.appendChild(li);
    });
  }

  function open() {
    dialog.showModal();
    input.focus();
    load().then(function () { render(input.value); });
  }

  document.querySelectorAll("[data-search-open]").forEach(function (b) { b.addEventListener("click", open); });
  input.addEventListener("input", function () { load().then(function () { render(input.value); }); });
  document.addEventListener("keydown", function (e) {
    if ((e.metaKey || e.ctrlKey) && e.key.toLowerCase() === "k") { e.preventDefault(); open(); }
  });
})();
