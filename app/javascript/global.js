// スマホ用ナビ表示切り替え
document.addEventListener("turbo:load", function() {
  console.log("turbo loaded!");
  const menuToggle = document.getElementById("menu-toggle");
  const navbarContent = document.getElementById("navbarContent");

  menuToggle.addEventListener("click", function() {
    navbarContent.classList.toggle("active");
  });

  function handleResize() {
    if (window.innerWidth > 720) {
      menuToggle.style.display = "none";
      navbarContent.classList.remove("active");
    } else {
      menuToggle.style.display = "block";
    }
  }

  window.addEventListener("resize", handleResize);
  handleResize(); // 初期表示時に実行
});