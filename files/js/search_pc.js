// for PC on index.html :
const resultsDiv = document.querySelector("#resultsDiv");
const searchBtn = document.getElementById("search_icon");
const searchInput = document.getElementById("search_input");

searchInput.addEventListener("input", function () {
    if (searchInput.value === "") {
        resultsDiv.style.display = "none";
    } else {
        resultsDiv.style.display = "";
    }
});

function create_html_products(products, coin = "DT") {
    resultsDiv.innerHTML = "";
    const productElements = products.map((product) => {
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
                        ${product.price} ${coin}
                    </div>
                </div>
            </a>`;
        return div_product;
    });
    productElements.map((element) => {
        resultsDiv.append(element);
    });
}

async function searchProducts() {
    const searchInput_value = searchInput.value.trim().toLowerCase();
    if (searchInput_value == "") {
        return;
    }
    const res = await fetch("/api/search_product?name=" + searchInput_value);
    if (!res.ok) {
        const error = await res.json();
        resultsDiv.innerHTML = `
            <h1>${error.detail}</h1>
            <div>${searchInput_value}</div>
          `;
        return;
    }
    const foundProducts = await res.json();
    create_html_products(foundProducts);
}

searchInput.addEventListener("input", () => {
    searchProducts();
});

searchBtn.addEventListener("click", (e) => {
    e.preventDefault();
    searchProducts(); // Call this function when the user clicks the search button
});
