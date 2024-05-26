var loading_animation = document.querySelector(".loading_animation");
function remove_loading() {
    loading_animation.setAttribute("data-loading", "false");
    setInterval(() => { loading_animation.remove(); }, 500);
}
window.onload = remove_loading;
