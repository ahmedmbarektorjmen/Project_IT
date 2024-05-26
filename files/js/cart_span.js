let cart = JSON.parse(localStorage.getItem("cart")) || [];
cart_span = document.querySelectorAll(".cart_number");
cart_span[0].innerText = cart.length;
cart_span[1].innerText = cart.length;