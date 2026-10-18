// Interactive terminal typing animation hook
const Terminal = {
  mounted() {
    this.lines = JSON.parse(this.el.dataset.lines || "[]")
    this.outputEl = this.el.querySelector("[data-terminal-output]")
    this.cursorEl = this.el.querySelector("[data-terminal-cursor]")
    this.currentLine = 0
    this.currentChar = 0
    this.isTypingCommand = true
    this.typeSpeed = 45
    this.lineDelay = 800
    this.responseDelay = 300

    // Start animation when element is visible
    this.observer = new IntersectionObserver((entries) => {
      if (entries[0].isIntersecting && this.currentLine === 0 && this.currentChar === 0) {
        this.observer.disconnect()
        setTimeout(() => this.startTyping(), 500)
      }
    }, { threshold: 0.3 })
    this.observer.observe(this.el)
  },

  destroyed() {
    if (this.observer) this.observer.disconnect()
    if (this.timeout) clearTimeout(this.timeout)
  },

  startTyping() {
    if (this.currentLine >= this.lines.length) {
      // Loop after a pause
      this.timeout = setTimeout(() => {
        this.outputEl.innerHTML = ""
        this.currentLine = 0
        this.currentChar = 0
        this.isTypingCommand = true
        this.startTyping()
      }, 5000)
      return
    }

    const line = this.lines[this.currentLine]

    if (this.isTypingCommand && line.command) {
      this.typeCommand(line)
    } else {
      this.showResponse(line)
    }
  },

  typeCommand(line) {
    const prompt = `<span class="text-success">iex&gt;</span> `
    const cmd = line.command

    if (this.currentChar === 0) {
      this.outputEl.innerHTML += `<div class="terminal-line">${prompt}<span class="terminal-cmd"></span></div>`
    }

    const cmdEl = this.outputEl.querySelector(".terminal-line:last-child .terminal-cmd")

    if (this.currentChar < cmd.length) {
      cmdEl.textContent = cmd.substring(0, this.currentChar + 1)
      this.currentChar++
      this.timeout = setTimeout(() => this.typeCommand(line), this.typeSpeed + Math.random() * 30)
    } else {
      this.currentChar = 0
      this.isTypingCommand = false
      this.timeout = setTimeout(() => this.startTyping(), this.responseDelay)
    }
  },

  showResponse(line) {
    if (line.response) {
      const responseHtml = `<div class="terminal-response text-warning/80">${this.escapeHtml(line.response)}</div>`
      this.outputEl.innerHTML += responseHtml
    }
    this.currentLine++
    this.isTypingCommand = true
    this.timeout = setTimeout(() => this.startTyping(), this.lineDelay)
  },

  escapeHtml(text) {
    const div = document.createElement("div")
    div.textContent = text
    return div.innerHTML
  }
}

export default Terminal
