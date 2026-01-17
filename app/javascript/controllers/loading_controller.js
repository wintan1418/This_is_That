import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  static targets = ["button", "spinner", "text", "icon"]
  static values = {
    text: String,
    loadingText: { type: String, default: "Loading..." },
    disable: { type: Boolean, default: true }
  }

  submit(event) {
    // If it's a form submission, we let it bubble but update UI
    this.showLoading()
  }

  // Can be called directly for non-submit clicks
  click(event) {
    this.showLoading()
  }

  showLoading() {
    // 1. Disable button
    if (this.disableValue && this.hasButtonTarget) {
      this.buttonTarget.disabled = true
    }

    // 2. Hide icon if present
    if (this.hasIconTarget) {
      this.iconTarget.classList.add("hidden")
    }

    // 3. Show spinner if present
    if (this.hasSpinnerTarget) {
      this.spinnerTarget.classList.remove("hidden")
    }

    // 4. Update text if configured
    if (this.hasTextTarget && this.loadingTextValue) {
      // Save original text? maybe not needed for one-way transition
      this.textTarget.textContent = this.loadingTextValue
    }
  }
}
