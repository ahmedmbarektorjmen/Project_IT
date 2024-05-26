// Navbar: opening and closing :
var nav_check = document.getElementById("nav_check");
var nav = document.querySelector(".navigation");
nav_check.onchange = function () {
    if (nav_check.checked) {
        nav.setAttribute("style", "transition: 0.5s ease-in;left: 0;");
    }
    else if (nav_check.checked === false) {
        nav.setAttribute("style", "transition: 0.5s ease-in;left: -50rem;");
    }
};
