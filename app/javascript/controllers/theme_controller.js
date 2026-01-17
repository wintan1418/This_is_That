import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
// Handles dark/light mode toggle with localStorage persistence
export default class extends Controller {
  static targets = ["toggle", "icon"]
  static values = {
    theme: { type: String, default: "dark" }
  }

  connect() {
    // Load saved theme or default to dark
    const savedTheme = localStorage.getItem("theme") || "dark"
    this.applyTheme(savedTheme)
  }

  toggle() {
    const newTheme = this.themeValue === "dark" ? "light" : "dark"
    this.applyTheme(newTheme)
    localStorage.setItem("theme", newTheme)
  }

  applyTheme(theme) {
    this.themeValue = theme
    
    if (theme === "light") {
      document.documentElement.classList.add("light-mode")
      document.documentElement.classList.remove("dark-mode")
    } else {
      document.documentElement.classList.add("dark-mode")
      document.documentElement.classList.remove("light-mode")
    }
    
    // Update icon if present
    if (this.hasIconTarget) {
      this.iconTarget.textContent = theme === "dark" ? "🌙" : "☀️"
    }
  }
}
