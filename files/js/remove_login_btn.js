const removeLoginBtn = async () => {
    const access_Token = document.cookie.split("=")[1];

    const res = await fetch("/api/get_user", {
        headers: {
            Authorization: `Bearer ${access_Token}`,
        },
    });
    if (res.ok) {
        const login_btn = document.getElementById("login_btn");
        login_btn.remove();
        const user = await res.json();
        globalThis.user = user;
        const avatar = document.getElementById("avatar");
        const account_btn = document.getElementById("account_btn");
        if (window.innerWidth > 800) {
            avatar.innerHTML = `
                    <a href="/account" style="width: 25px; height: 25px;margin: 10px;border-radius: 50%;">
                        <img src="${user.profile_pic}" alt="profile pic"/>
                    </a>
                `;
        } else {
            avatar.innerHTML = "";
            account_btn.innerHTML = `
            <div style="width: 25px; height: 25px;border-radius: 50%;">
                <img src="${user.profile_pic}" alt="profile pic"/>
            </div>
            `;
        }
        window.addEventListener("resize", () => {
            const avatar = document.getElementById("avatar");
            if (window.innerWidth > 800) {
                avatar.innerHTML = `
                    <a href="/account" style="width: 25px; height: 25px;margin: 10px;border-radius: 50%;">
                        <img src="${user.profile_pic}" alt="profile pic"/>
                    </a>
                `;
            } else {
                avatar.innerHTML = "";
                const account_btn = document.getElementById("account_btn");
                console.log(account_btn);
                account_btn.innerHTML = `
            <div style="width: 25px; height: 25px;border-radius: 50%;">
                <img src="${user.profile_pic}" alt="profile pic"/>
            </div>
            `;
            }
        });
    }
};

removeLoginBtn();
