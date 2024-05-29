async function validatestatus() {
    const access_Token = document.cookie.split("=")[1];

    if (
        !access_Token ||
        access_Token == "" ||
        access_Token == undefined ||
        access_Token == null
    ) {
        window.location.href = "/login";
        return;
    }
    const res = await fetch("/api/get_user", {
        headers: {
            Authorization: `Bearer ${access_Token}`,
        },
    });
    const root = document.getElementById("root");
    if (!res.ok) {
        const error = await res.json();
        if ((error.detail = "Invalid Token !!")) {
            document.title = `ERROR ${res.status} - ${res.statusText}`;
            root.innerHTML = `
            <h1 align="center">Protected Route :</h1>
            <p align="center">
                <b style="color:red">Invalid Token !!</b>
                <br>
                please return to the
                <a href="/login" style="color:red;text-decoration:underline">login page</a>
                and renew your Token
            </p>
            `;
        }
        return;
    } else {
        const data = await res.json();
        if (data.type == "admin") {
            root.innerHTML = `
            <h1 style="text-align:center">Welcome ${data.username} !!</h1>
            <button class="btn bt-primary">Create a product</button>
            `;
            // add this avatar to the header:
            document.getElementById("header").innerHTML = `
            <span class="logo"><a href="/"><span class="shoppy">Shoppy</span>.tn</a></span>
            <div class="avatar">
                <div style="width: 50px; height: 50px; border-radius: 50%;margin-right: 10px;">
                    <img src="${data.profile_pic}" alt="profile pic"/>
                </div>
            </div>
            `;
        } else {
            root.innerHTML = `
        <h1 style="text-align:center;">This is a Protected Route :</h1>
        <p style="text-align:center;">
            <b style="color:red;">Unauthorized !!</b>
            <br>you must be an admin to enter this page
            <br>
            please return to:
            <br><a href="/" style="color:red;text-decoration:underline"> The Home Page</a>
            <br> <span style="text-align:center;">or</span>
            <br>
            <a href="/login" style="color:red;text-decoration:underline">login to your admin account</a>
        </p>
        `;
        }
    }
}

validatestatus();
