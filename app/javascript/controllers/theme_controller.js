import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
// Handles dark/light mode toggle with localStorage persistence
export default class extends Controller {
  connect() {
    // Load saved theme or default to dark
    const savedTheme = localStorage.getItem("theme") || "dark"
    this.applyTheme(savedTheme)
  }

  toggle() {
    const isDark = document.documentElement.classList.contains("dark-mode")
    const newTheme = isDark ? "light" : "dark"
    this.applyTheme(newTheme)
    localStorage.setItem("theme", newTheme)
  }

  applyTheme(theme) {
    if (theme === "dark") {
      document.documentElement.classList.add("dark-mode")
      document.documentElement.classList.remove("light-mode")
    } else {
      document.documentElement.classList.remove("dark-mode")
      document.documentElement.classList.add("light-mode")
    }
    
    // Update all toggle icons on the page
    document.querySelectorAll("[data-theme-icon]").forEach(icon => {
      icon.textContent = theme === "dark" ? "🌙" : "☀️"
    })
  }
}
