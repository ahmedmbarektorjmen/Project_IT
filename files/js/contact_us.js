const name_input = document.getElementById("name");
const email_input = document.getElementById("email");
const message_input = document.getElementById("message");
const contact_message = document.getElementById("contact_message");
const send_btn = document.getElementById("send_btn");
function show_login_message() {
    login_message.style.display = "";
}
function hide_login_message() {
    login_message.style.display = "none";
}
send_btn.addEventListener('click', (e) => {
    e.preventDefault();
    if (email_input.value !== "" && name_input.value !== "" && message_input.value !== "") {
        show_login_message();
        setInterval(hide_login_message, 3000);
    }
});
