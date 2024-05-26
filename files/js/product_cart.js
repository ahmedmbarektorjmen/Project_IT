addToCart = (productId) => {
    // Get the cart from localStorage
    let cart = JSON.parse(localStorage.getItem("cart")) || [];
    // Check if the product is already in the cart
    let existingProductIndex = cart.findIndex((product) => product.id === productId);
    // Get the value of the input element
    if (document.getElementById("input_cart").value > 20) {
        var quantity_value = 20;
    }
    else if (document.getElementById("input_cart").value < 1) {
        var quantity_value = 1;
    }
    else {
        var quantity_value = document.getElementById("input_cart").value;
    }
    let item_price = document.getElementById("item-price").innerText;
    let item_name = document.getElementById("item-name").innerText;
    let image_url = document.getElementById("image").getAttribute("src");
    let description = document.getElementById("description").innerText;
    if (existingProductIndex !== -1) {
        // If the product is already in the cart, setthe quantity to the input
        cart[existingProductIndex].quantity = quantity_value;
    }
    else {
        // Otherwise, add the product to the cart
        cart.push({
            id: productId,
            description: description,
            price: item_price,
            quantity: quantity_value,
            name: item_name,
            image: image_url,
        });
    }
    // Save the updated cart to localStorage
    localStorage.setItem("cart", JSON.stringify(cart));
    alert("Product added to cart!");
}



// Define productId variable outside the function
let productId;
const addToCart_btn = document.getElementById("add_to_cart_button");
addToCart_btn.addEventListener("click",  () => {
    addToCart();
});
