const login_btn = document.getElementById("login_btn");
const email = document.getElementById("email");
const password = document.getElementById("password");
const login_message = document.getElementById("login_message");
function show_login_message() {
    login_message.style.display = "";
}
function hide_login_message() {
    login_message.style.display = "none";
}
login_btn.addEventListener('click', (e) => {
    e.preventDefault();
    if (email.value !== "" && password.value !== "") {
        show_login_message();
        setInterval(hide_login_message, 3000);
    }
});
