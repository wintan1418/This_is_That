import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["drawer", "overlay", "hamburger"]

  connect() {
    this.isOpen = false
  }

  toggle() {
    this.isOpen ? this.close() : this.open()
  }

  open() {
    this.isOpen = true
    this.drawerTarget.classList.remove("translate-x-full")
    this.drawerTarget.classList.add("translate-x-0")
    this.overlayTarget.classList.remove("opacity-0", "pointer-events-none")
    this.overlayTarget.classList.add("opacity-100")
    document.body.style.overflow = "hidden"
  }

  close() {
    this.isOpen = false
    this.drawerTarget.classList.remove("translate-x-0")
    this.drawerTarget.classList.add("translate-x-full")
    this.overlayTarget.classList.remove("opacity-100")
    this.overlayTarget.classList.add("opacity-0", "pointer-events-none")
    document.body.style.overflow = ""
  }

  closeOnEscape(event) {
    if (event.key === "Escape" && this.isOpen) {
      this.close()
    }
  }
}
