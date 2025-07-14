window.initFadeInOnScroll = function () {
    const elements = document.querySelectorAll('.fade-in-on-scroll');
    function onScroll() {
        elements.forEach(el => {
            const rect = el.getBoundingClientRect();
            if (rect.top < window.innerHeight - 60) {
                el.classList.add('visible');
            }
        });
    }
    window.addEventListener('scroll', onScroll);
    onScroll(); // Initial check
};