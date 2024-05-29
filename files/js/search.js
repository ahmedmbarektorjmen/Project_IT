// for mobile:
if (window.innerWidth < 800) {
    window.onload = () => {
        searchInput.setAttribute("data-animate", "true");
    };

    var resultsDiv = document.querySelector("#resultsDiv");
    var resetIcon = document.getElementById("searchdelete_icon");
    var searchBtn = document.getElementById("search_icon");
    var searchInput = document.getElementById("search_input");

    async function searchProducts() {
        let searchInputValue = searchInput.value.trim().toLowerCase();

        await fetch(`/api/search_product?name=${searchInputValue}`)
            .then((response) => {
                if (!response.ok) {
                    throw new Error("Product not found !");
                }
                return response.json();
            })
            .then((foundProducts) => {
                if (foundProducts.length > 0) {
                    resultsDiv.innerHTML = "";

                    const productElements = foundProducts.map((product) => {
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
                    ${product.price} DT
                  </div>
                </div>
              </a>`;
                        return div_product;
                    });

                    productElements.forEach((element) => {
                        resultsDiv.append(element);
                    });
                } else {
                    resultsDiv.innerHTML = "";
                    resultsDiv.innerHTML = `<h1>Product Not Found !!!</h1>
            ${searchInputValue}`;
                }
            })
            .catch((error) => {
                console.error("Error:", error.message);
                resultsDiv.innerHTML = "";
                resultsDiv.innerHTML = `<h1>${error.message}</h1>`;
            });
    }

    function displayAllProducts() {
        fetch("/api/products")
            .then((result) => result.json())
            .then((data) => {
                resultsDiv.innerHTML = "";
                const productElements = data.map((product) => {
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
                  ${product.price} DT
                </div>
              </div>
            </a>`;
                    return div_product;
                });

                productElements.forEach((element) => {
                    resultsDiv.append(element);
                });
            })
            .catch((error) => {
                console.error("Error:", error.message);
                resultsDiv.innerHTML = "";
                resultsDiv.innerHTML = `<h1>Error loading products</h1>`;
            });
    }

    displayAllProducts(); // Call this function when the page is loaded

    searchInput.addEventListener("input", function () {
        searchProducts();
        if (this.value === "") {
            resetIcon.classList.add("hide");
        } else {
            resetIcon.classList.remove("hide");
        }
    });

    resetIcon.addEventListener("click", function () {
        searchInput.value = "";
        resetIcon.classList.add("hide");
        displayAllProducts();
    });

    searchBtn.addEventListener("click", function (e) {
        e.preventDefault();
        searchProducts();
    });
}
