// Scroll-triggered fade-in animation hook
const FadeIn = {
  mounted() {
    this.el.style.opacity = "0"
    this.el.style.transform = "translateY(20px)"
    this.el.style.transition = "opacity 0.6s ease-out, transform 0.6s ease-out"

    const delay = parseInt(this.el.dataset.delay || "0")

    this.observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting) {
          setTimeout(() => {
            entry.target.style.opacity = "1"
            entry.target.style.transform = "translateY(0)"
          }, delay)
          this.observer.unobserve(entry.target)
        }
      })
    }, { threshold: 0.1, rootMargin: "0px 0px -50px 0px" })

    this.observer.observe(this.el)
  },

  destroyed() {
    if (this.observer) this.observer.disconnect()
  }
}

export default FadeIn
