// for mobile :
if (window.innerWidth < 800) {
  window.onload = () => {
    searchInput.setAttribute("data-animate", "true");
  };

  var resultsDiv = document.querySelector("#resultsDiv");
  var resetIcon = document.getElementById("searchdelete_icon");
  var searchBtn = document.getElementById("search_icon");
  var searchInput = document.getElementById("search_input");

  async function searchProducts() {
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

      await fetch("/api/products")
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

              if (foundProducts.length > 0) {
                  resultsDiv.innerHTML = "";

                  foundProducts.map((product) => {
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
              </a>`;
                      resultsDiv.append(div_product);
                  });
              } else {
                  resultsDiv.innerHTML = "";
                  resultsDiv.innerHTML = `<h1>Product Not Found !!!</h1>
            ${searchInput_value}`;
              }
          });
  }

  function displayAllProducts() {
      fetch("/api/products")
          .then((result) => result.json())
          .then((data) => {
              let foundProducts = data;
              resultsDiv.innerHTML = "";
              foundProducts.forEach((product) => {
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
            </a>`;
                  resultsDiv.append(div_product);
              });
          });
  }

  displayAllProducts(); // Call this function when the page is loaded

  searchInput.addEventListener("input", function () {
      searchProducts();
      if (this.value === "") {
          resetIcon.className =
              "searchdelete_icon fa-sharp fa-solid fa-circle-xmark hide";
          // hide the reset icon
      } else {
          resetIcon.className =
              "searchdelete_icon fa-sharp fa-solid fa-circle-xmark show";
          // show the reset icon
      }
  });

  resetIcon.addEventListener("click", function () {
      searchInput.value = ""; // Reset the value of searchInput
      resetIcon.className =
          "searchdelete_icon fa-sharp fa-solid fa-circle-xmark hide"; // Hide the reset icon
      displayAllProducts(); // Call this function when the user clicks the reset button
  });

  searchBtn.addEventListener("click", function (e) {
    e.preventDefault();
    searchProducts(); // Call this function when the user clicks the search button
  });
}
