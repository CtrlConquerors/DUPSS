// carousel.js

function setupCarousel() {
    const slides = document.querySelectorAll('.carousel-image-slide');
    const prevBtn = document.querySelector('.prev-btn-image');
    const nextBtn = document.querySelector('.next-btn-image');
    let currentIndex = 0;

    function showSlide(index) {
        slides.forEach((slide, i) => {
            if (i === index) {
                slide.classList.add('active');
            } else {
                slide.classList.remove('active');
            }
        });
    }

    function nextSlide() {
        currentIndex = (currentIndex + 1) % slides.length;
        showSlide(currentIndex);
    }

    function prevSlide() {
        currentIndex = (currentIndex - 1 + slides.length) % slides.length;
        showSlide(currentIndex);
    }

    if (prevBtn && nextBtn) {
        prevBtn.addEventListener('click', prevSlide);
        nextBtn.addEventListener('click', nextSlide);
    }

    // Hiển thị slide đầu tiên khi gọi setupCarousel
    showSlide(currentIndex);
}
