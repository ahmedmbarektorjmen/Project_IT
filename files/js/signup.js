const signup_btn = document.getElementById("signup_btn");
const message = document.getElementById("signup_message");

async function setCaptchaToken() {
  const response = await fetch("/captcha");
  const data = await response.blob();
  const url = URL.createObjectURL(data);
  document.getElementById("captcha-image").src = url;
  const captchaToken = response.headers.get("X-Captcha-Token");
  document.getElementById("captcha_token").value = captchaToken;
}
setCaptchaToken();

function validateUsername(username) {
  const usernameRegex = /^[a-zA-Z0-9_.-]{3,30}$/;
  return usernameRegex.test(username);
}

function validateEmail(email) {
  const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
  return emailRegex.test(email);
}

const show_message = (text) => {
  message.style.display = "";
  message.innerText = text;
};
const hide_message = () => {
  message.style.display = "none";
};

const start_loading = () => {
  signup_btn.disabled = true;
  signup_btn.style.cursor = "not-allowed";
  signup_btn.innerText = "Loading...";
  signup_btn.style.backgroundColor = "gray";
};
const stop_loading = () => {
  signup_btn.disabled = false;
  signup_btn.style.backgroundColor = "#3a37ff";
  signup_btn.style.cursor = "pointer";
  signup_btn.innerText = "Signup";
};

signup_btn.addEventListener("click", async (e) => {
  e.preventDefault();
  start_loading();

  const username = document.getElementById("username");
  const email = document.getElementById("email");
  const password = document.getElementById("password");
  const repassword = document.getElementById("repassword");
  const captcha = document.getElementById("captcha");
  const captcha_token = document.getElementById("captcha_token");

  if (
    username.value.trim() == "" ||
    password.value.trim() == "" ||
    repassword.value.trim() == "" ||
    email.value.trim() == "" ||
    captcha.value.trim() == ""
  ) {
    stop_loading();
    show_message("Invalid inputs !");
    return;
  }

  if (repassword.value != password.value) {
    stop_loading();
    show_message("Passwords doesn't match !");
    return;
  }
  if (password.value.length < 8) {
    stop_loading();
    show_message("Password must be at least 8 characters !");
    return;
  }
  if (password.value.length >= 30) {
    stop_loading();
    show_message("Password must be less than 30 characters !");
    return;
  }
  if (!validateUsername(username.value) || !validateEmail(email.value)) {
    stop_loading();
    show_message("email/username must not contain extra characters !");
    return;
  }


  hide_message();
  const res = await fetch("/api/register", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      username: username.value,
      email: email.value,
      password: password.value,
      captcha: captcha.value,
      captcha_token: captcha_token.value,
    }),
  });
  if (res.ok) {
    username.value = "";
    password.value = "";
    repassword.value = "";
    email.value = "";
    captcha.value = "";
    stop_loading();
    const data = await res.json();
    document.cookie = `access_token=${data.access_token}`;
    window.location = "/";
  } else {
    stop_loading();
    const error = await res.json();
    show_message(error.detail);
  }
});
