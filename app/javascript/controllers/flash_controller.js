import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
// Auto-dismisses flash messages and adds close button functionality
export default class extends Controller {
  static values = {
    timeout: { type: Number, default: 5000 }
  }

  connect() {
    // Auto-dismiss after timeout
    this.dismissTimer = setTimeout(() => {
      this.dismiss()
    }, this.timeoutValue)
  }

  disconnect() {
    if (this.dismissTimer) {
      clearTimeout(this.dismissTimer)
    }
  }

  dismiss() {
    // Fade out animation
    this.element.style.opacity = '0'
    this.element.style.transform = 'translateX(100%)'
    
    // Remove from DOM after animation
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }

  close(event) {
    event.preventDefault()
    this.dismiss()
  }
}
