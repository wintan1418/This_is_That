import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pwa-install"
// Shows install prompt for PWA on supported browsers
export default class extends Controller {
  static targets = ["banner"]
  
  deferredPrompt = null

  connect() {
    // Check if already installed
    if (window.matchMedia('(display-mode: standalone)').matches) {
      return // Already installed as PWA
    }
    
    // Check if dismissed recently
    const dismissed = localStorage.getItem("pwa-install-dismissed")
    if (dismissed) {
      const dismissedAt = parseInt(dismissed)
      const daysSince = (Date.now() - dismissedAt) / (1000 * 60 * 60 * 24)
      if (daysSince < 7) return // Don't show for 7 days after dismissal
    }
    
    // Listen for beforeinstallprompt event
    window.addEventListener("beforeinstallprompt", (e) => {
      e.preventDefault()
      this.deferredPrompt = e
      this.showBanner()
    })
  }

  showBanner() {
    if (this.hasBannerTarget) {
      this.bannerTarget.classList.remove("hidden")
    }
  }

  install() {
    if (!this.deferredPrompt) return
    
    this.deferredPrompt.prompt()
    this.deferredPrompt.userChoice.then((choiceResult) => {
      if (choiceResult.outcome === "accepted") {
        console.log("User accepted the install prompt")
      }
      this.deferredPrompt = null
      this.dismiss()
    })
  }

  dismiss() {
    if (this.hasBannerTarget) {
      this.bannerTarget.classList.add("hidden")
    }
    localStorage.setItem("pwa-install-dismissed", Date.now().toString())
  }
}
