// Slider container :
//   Slider items
var slider_images = Array.from(document.querySelectorAll(".slider_container img"));
//   Get number of images
var slides_count = slider_images.length;
// Set image in slide
var current_slide = 1;
// Previous and Next buttons
var previous_btn = document.getElementById("prev");
var next_btn = document.getElementById("next");
// Handle onClick on Previous & Next buttons
next_btn.onclick = nextSlide;
previous_btn.onclick = prevSlide;
// Next slide function
function nextSlide() {
    current_slide++;
    if (current_slide > slides_count) {
        current_slide = 1;
    }
    setActiveSlide();
}
// Previous slide function
function prevSlide() {
    current_slide--;
    if (current_slide < 1) {
        current_slide = slides_count;
    }
    setActiveSlide();
}
// Set active slide
function setActiveSlide() {
    slider_images.forEach(function (img, index) {
        if (index === current_slide - 1) {
            img.classList.add("active");
        }
        else {
            img.classList.remove("active");
        }
    });
}
// Set initial active slide
setActiveSlide();
// Change slide every 5 seconds
setInterval(nextSlide, 6000);
