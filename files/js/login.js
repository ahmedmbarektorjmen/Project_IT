const login_btn = document.getElementById("login_btn");
const message = document.getElementById("login_message");

async function setCaptchaToken() {
  const response = await fetch("/captcha");
  const data = await response.blob();
  const url = URL.createObjectURL(data);
  document.getElementById("captcha-image").src = url;
  const captchaToken = response.headers.get("X-Captcha-Token");
  document.getElementById("captcha_token").value = captchaToken;
}
setCaptchaToken();

const show_message = (text) => {
  message.style.display = "";
  message.innerText = text;
};

const start_loading = () => {
  login_btn.disabled = true;
  login_btn.style.cursor = "not-allowed";
  login_btn.innerText = "Loading...";
  login_btn.style.backgroundColor = "gray";
};
const stop_loading = () => {
  login_btn.disabled = false;
  login_btn.style.backgroundColor = "#3a37ff";
  login_btn.style.cursor = "pointer";
  login_btn.innerText = "Login";
};

login_btn.addEventListener("click", async (e) => {
  e.preventDefault();
  start_loading();

  const username = document.getElementById("username");
  const password = document.getElementById("password");
  const captcha = document.getElementById("captcha");
  const captcha_token = document.getElementById("captcha_token");

  if (password.value.length < 8) {
    stop_loading();
    show_message("Password must be at least 8 characters !");
    return;
  }
  if (password.value.length >= 30) {
    stop_loading();
    show_message("must be less than 30 characters !");
    return;
  }
  if (
    username.value.trim() == "" ||
    password.value.trim() == "" ||
    captcha.value.trim() == ""
  ) {
    stop_loading();
    show_message("Invalid Inputs !");
    return;
  }
  const res = await fetch("/api/login", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      username: username.value,
      password: password.value,
      captcha_token: captcha_token.value,
      captcha: captcha.value,
    }),
  });
  if (res.ok) {
    username.value = "";
    password.value = "";
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
