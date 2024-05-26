console.clear;
let deleteButtons = document.querySelectorAll(".removefromcart");
deleteButtons.forEach((button) => {
    button.addEventListener("click", (event) => {
        let cartItem = event.target.closest(".cart_product");
        let productId = cartItem.dataset.productid;
        // Call the deleteProduct function with the productId
        removefromcart(productId);
    });
});
function removefromcart(productId) {
    let cart = JSON.parse(localStorage.getItem("cart"));
    let existingProductIndex = cart.findIndex((product) => product.id === parseInt(productId));
    console.log(existingProductIndex);
    if (existingProductIndex !== -1) {
        cart.splice(existingProductIndex, 1); // Remove the item from the array
        localStorage.setItem("cart", JSON.stringify(cart)); // Update the localStorage
        alert("product removed from cart");
    }
}
