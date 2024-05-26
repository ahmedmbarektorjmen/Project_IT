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
function searchProducts() {
  const simplify = (str) => {
    return str
      .replace(/\s+/g, " ")
      .replace("<script></script>", "")
      .replace("<script>", "")
      .replace("<script", "")
      .replace("</script>", "")
      .replace(/\s+/g, " ")
      .trim()
      .split(" ");
  };

  searchInput_value_array = [...new Set(simplify(searchInput.value))];
  searchInput_value = searchInput.value;

  fetch("/api/products")
    .then((result) => result.json())
    .then((data) => {
      console.log(data);
      let foundProducts = [];
      for (let i = 0; i < searchInput_value_array.length; i++) {
        data.forEach((product) => {
          if (
            product.name
              .toLowerCase()
              .indexOf(searchInput_value_array[i].toLowerCase()) !== -1 ||
            product.description
              .toLowerCase()
              .indexOf(searchInput_value_array[i].toLowerCase()) !== -1
          ) {
            foundProducts.push(product);
          }
        });
      }
      foundProducts = [...new Set(foundProducts)];
      if (foundProducts.length > 0) {
        resultsDiv.innerHTML = "";
        foundProducts.forEach((product) => {
          let div_product = document.createElement("div");
          div_product.className = "div_product";
          // append all elements as a child of the div_product element
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
                    </a>`;
          resultsDiv.append(div_product);
        });
      } else {
        resultsDiv.innerHTML = "";
        resultsDiv.innerHTML = `<h1>Product Not Found !!!</h1>
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
