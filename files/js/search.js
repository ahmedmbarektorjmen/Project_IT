// for mobile:
if (window.innerWidth < 800) {
    window.onload = () => {
        searchInput.setAttribute("data-animate", "true");
    };

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

    const resultsDiv = document.querySelector("#resultsDiv");
    const resetIcon = document.getElementById("searchdelete_icon");
    const searchBtn = document.getElementById("search_icon");
    const searchInput = document.getElementById("search_input");

    async function searchProducts() {
        const searchInputValue = searchInput.value.trim().toLowerCase();
        if (searchInputValue == "") {
            displayAllProducts();
            return;
        }
        const res = await fetch(`/api/search_product?name=${searchInputValue}`);
        if (!res.ok) {
            document.title = `Error ${res.status} - ${res.statusText}`;
            const error = await res.json();
            resultsDiv.innerHTML = `
            <h1>${error.detail}</h1>
            ${searchInputValue}
          `;
        } else {
            const foundProducts = await res.json();
            create_html_products(foundProducts);
        }
    }

    async function displayAllProducts() {
        const res = await fetch("/api/products");
        if (!res.ok) {
            document.title = `Error ${res.status} - ${res.statusText}`;
            const error = await res.json();
            resultsDiv.innerHTML = `
            <h1>${error.detail}</h1>
            ${searchInputValue}
          `;
        }
        const foundProducts = await res.json();
        create_html_products(foundProducts);
    }

    displayAllProducts(); // Call this function when the page is loaded

    searchInput.addEventListener("input", () => {
        searchProducts();
        if (this.value === "") {
            resetIcon.classList.add("hide");
        } else {
            resetIcon.classList.remove("hide");
        }
    });

    resetIcon.addEventListener("click", () => {
        searchInput.value = "";
        resetIcon.classList.add("hide");
        displayAllProducts();
    });

    searchBtn.addEventListener("click", (e) => {
        e.preventDefault();
        searchProducts();
    });
}
