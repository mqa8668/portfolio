// Scroll spy for active nav section highlighting
const ScrollSpy = {
  mounted() {
    this.sections = document.querySelectorAll("section[id]")
    this.handleScroll = this.onScroll.bind(this)
    window.addEventListener("scroll", this.handleScroll, { passive: true })
  },

  destroyed() {
    window.removeEventListener("scroll", this.handleScroll)
  },

  onScroll() {
    const scrollY = window.scrollY + 100

    this.sections.forEach(section => {
      const top = section.offsetTop
      const height = section.offsetHeight
      const id = section.getAttribute("id")

      if (scrollY >= top && scrollY < top + height) {
        this.pushEvent("section_in_view", { section: id })
      }
    })
  }
}

export default ScrollSpy
