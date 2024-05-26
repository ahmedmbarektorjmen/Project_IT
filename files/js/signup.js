const signup_btn = document.getElementById("signup_btn");
const signup_message = document.getElementById("signup_message");
function show_signup_message() {
  signup_message.style.display = "";
}
function hide_signup_message() {
  signup_message.style.display = "none";
}
signup_btn.addEventListener("click", (e) => {
  e.preventDefault();
  const name = document.getElementById("name").value;
  const email = document.getElementById("email").value;
  const password = document.getElementById("password").value;
  if (xname !== "" && password !== "" && email !== "") {
    fetch("/signup", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({
        username: name,
        email: email,
        password: password,
      }),
    })
      .then((res) => res.json())
      .then((data) => {
        localStorage.setItem("user", JSON.stringify(data));
        window.location = "/";
      });
  }
});
