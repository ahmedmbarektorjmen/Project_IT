// for PC on index.html :
var resultsDiv = document.querySelector("#resultsDiv");
var searchBtn = document.getElementById("search_icon");
var searchInput = document.getElementById("search_input");

searchInput.addEventListener("input", function () {
    if (searchInput.value === "") {
        resultsDiv.style.display = "none";
    } else {
        resultsDiv.style.display = "";
    }
});

function create_html_products(products) {
    products.map((product) => {
        let div_product = document.createElement("div");
        div_product.className = "div_product";
        div_product.innerHTML = `
        <div>
          <img src="${product.image}">
        </div>
        <a href="/product/${product.id}">
          <div class="div_content">
            <div class="div_content_title">
              ${product.name}
            </div>
            <div class="div_content_price">
              ${product.price}
            </div>
          </div>
        </a>
        `;
        resultsDiv.append(div_product);
    });
}

function searchProducts() {
    const simplify = (str) => {
        return str
            .replace(/\s+/g, " ")
            .replace("<script></script>", "")
            .replace("<script>", "")
            .replace("<script", "")
            .replace("</script>", "")
            .replace(/\s+/g, " ")
            .trim();
    };

    let searchInput_value = simplify(searchInput.value).toLowerCase();

    fetch("/api/products")
        .then((result) => result.json())
        .then((data) => {
            let foundProducts = data.filter((product) => {
                return (
                    product.name.toLowerCase().includes(searchInput_value) ||
                    product.description
                        .toLowerCase()
                        .includes(searchInput_value)
                );
            });
            create_html_products(foundProducts);

            if (foundProducts.length > 0) {
                resultsDiv.innerHTML = "";
            } else {
                resultsDiv.innerHTML = "";
                resultsDiv.innerHTML = `
          <h1>Product Not Found !!!</h1>
          <div>${searchInput_value}</div>`;
            }
        });
}

searchInput.addEventListener("input", () => {
    searchProducts();
});

searchBtn.addEventListener("click", (e) => {
    e.preventDefault();
    searchProducts(); // Call this function when the user clicks the search button
});
