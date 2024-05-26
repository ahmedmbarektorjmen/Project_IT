// Get the cart data from localStorage and parse it as JSON
const cart = JSON.parse(localStorage.getItem("cart"));
var root = document.querySelector(".root");
if (cart.length !== 0) {
    // clear the root div
    root.innerText = "";
}

var TOTAL = 0;

const format_TOTAL = (productPrice,productQuantity) => {
  let ch = ""
  for (let i=0;i<productPrice.length;i++) {
    if (productPrice[i] == ",") {
      ch += "";
    }
    else {
      ch += productPrice[i];
    }
  }
  productPrice = ch;
  productPrice = Number(productPrice.replace(' DT',""));
  return productPrice;
}



// Loop through the cart items and display them on the page
cart.forEach((item) => {
    let productId = item.id;
    let productName = item.name;
    let productPrice = item.price;
    let productQuantity = item.quantity;
    let imageUrl = item.image;
    // Display the product ID and quantity on the page
    const cart_product = document.createElement("div");
    cart_product.className = "cart_product";
    cart_product.setAttribute("data-productid", productId);
    cart_product.innerHTML = `<a href="/product/${productId}">
        <div class="div_img">
          <img src="${imageUrl}" alt="${productName} image" />
        </div>
        <div class="product_name">${productName}</div>
        </a>
        <input type="number" min="5" max="20" class="quantity" value="${productQuantity}" disabled/>
        <div class="price">${productPrice}</div>
      <div class="button"><form><button id="removefromcart" class="removefromcart remove">remove</button></form></div>`;
    TOTAL += (format_TOTAL(productPrice,productQuantity) * productQuantity);
    root.appendChild(cart_product);
});
total = document.createElement("div");
TOTAL = Number(TOTAL).toLocaleString();
total.innerHTML = `<span>TOTAL: ${TOTAL} DT</span>`;
root.append(total);
document.appendChild(root);
