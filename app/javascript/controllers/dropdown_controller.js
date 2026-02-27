import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["select", "button", "menu", "arrow"]

  connect() {
    this.isOpen = false
    this.buildDropdown()
    document.addEventListener("click", this.closeOnOutsideClick)
  }

  disconnect() {
    document.removeEventListener("click", this.closeOnOutsideClick)
  }

  buildDropdown() {
    const select = this.selectTarget
    select.style.display = "none"

    // Build options from the native select
    this.options = Array.from(select.options).map(opt => ({
      label: opt.text,
      value: opt.value,
      selected: opt.selected
    }))

    const selected = this.options.find(o => o.selected && o.value !== "") || this.options[0]
    this.updateButtonText(selected)
  }

  toggle(event) {
    event.preventDefault()
    event.stopPropagation()
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.isOpen = true
    this.menuTarget.classList.remove("hidden")
    this.arrowTarget.classList.add("rotate-180")
  }

  close() {
    this.isOpen = false
    this.menuTarget.classList.add("hidden")
    this.arrowTarget.classList.remove("rotate-180")
  }

  pick(event) {
    event.preventDefault()
    const value = event.currentTarget.dataset.value
    const label = event.currentTarget.dataset.label

    // Update native select
    this.selectTarget.value = value
    this.selectTarget.dispatchEvent(new Event("change", { bubbles: true }))

    // Update button text
    this.updateButtonText({ label, value })

    // Highlight active option
    this.menuTarget.querySelectorAll("[data-action]").forEach(el => {
      el.classList.remove("bg-teal-500/20", "text-teal-400")
      el.classList.add("text-white")
    })
    event.currentTarget.classList.add("bg-teal-500/20", "text-teal-400")
    event.currentTarget.classList.remove("text-white")

    this.close()
  }

  updateButtonText(option) {
    const textEl = this.buttonTarget.querySelector("[data-text]")
    if (textEl) {
      textEl.textContent = option.value === "" ? option.label : option.label
      if (option.value === "") {
        textEl.classList.add("text-gray-500")
        textEl.classList.remove("text-white")
      } else {
        textEl.classList.remove("text-gray-500")
        textEl.classList.add("text-white")
      }
    }
  }

  closeOnOutsideClick = (event) => {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}
