// Animated counter. The server renders the final value; the hook only
// animates the inner value element and always restores the final text.
const CountUp = {
  mounted() {
    this.target = parseInt(this.el.dataset.target || "0", 10)
    this.suffix = this.el.dataset.suffix || ""
    this.prefix = this.el.dataset.prefix || ""
    this.duration = parseInt(this.el.dataset.duration || "2000", 10)
    this.valueEl = this.el.querySelector("[data-count-value]") || this.el
    this.started = false
    this.done = false

    const reduced = window.matchMedia("(prefers-reduced-motion: reduce)").matches
    if (reduced || typeof IntersectionObserver === "undefined") {
      this.finish()
      return
    }

    this.observer = new IntersectionObserver((entries) => {
      if (entries[0].isIntersecting && !this.started) {
        this.started = true
        this.observer.disconnect()
        this.animate()
      }
    }, { threshold: 0.5 })

    this.observer.observe(this.el)
  },

  updated() {
    this.valueEl = this.el.querySelector("[data-count-value]") || this.el
    if (this.done || !this.started) this.render(this.target)
  },

  destroyed() {
    if (this.observer) this.observer.disconnect()
    if (this.raf) cancelAnimationFrame(this.raf)
  },

  render(n) {
    this.valueEl.textContent = `${this.prefix}${n}${this.suffix}`
  },

  finish() {
    this.done = true
    this.render(this.target)
  },

  animate() {
    const startTime = performance.now()
    const step = (now) => {
      const progress = Math.min((now - startTime) / this.duration, 1)
      const eased = 1 - Math.pow(1 - progress, 3)
      this.render(Math.round(this.target * eased))
      if (progress < 1) {
        this.raf = requestAnimationFrame(step)
      } else {
        this.finish()
      }
    }
    this.raf = requestAnimationFrame(step)
  }
}

export default CountUp
