import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="compare"
// Handles side-by-side place comparison modal
export default class extends Controller {
  static targets = ["modal", "homePlace", "matchPlace"]
  
  homeData = null
  matchData = null

  selectHome(event) {
    const card = event.currentTarget.closest("[data-place]")
    this.homeData = JSON.parse(card.dataset.place)
    this.updateDisplay()
    this.highlightSelected(card, "home")
  }

  selectMatch(event) {
    const card = event.currentTarget.closest("[data-place]")
    this.matchData = JSON.parse(card.dataset.place)
    this.updateDisplay()
    this.highlightSelected(card, "match")
  }

  highlightSelected(card, type) {
    // Remove previous selection of same type
    document.querySelectorAll(`[data-selected="${type}"]`).forEach(el => {
      el.removeAttribute("data-selected")
      el.classList.remove("ring-2", type === "home" ? "ring-teal-500" : "ring-amber-500")
    })
    
    // Add selection to current card
    card.setAttribute("data-selected", type)
    card.classList.add("ring-2", type === "home" ? "ring-teal-500" : "ring-amber-500")
  }

  updateDisplay() {
    if (this.hasHomePlaceTarget) {
      this.homePlaceTarget.innerHTML = this.homeData ? this.renderPlace(this.homeData, "home") : this.renderEmpty("home")
    }
    if (this.hasMatchPlaceTarget) {
      this.matchPlaceTarget.innerHTML = this.matchData ? this.renderPlace(this.matchData, "match") : this.renderEmpty("match")
    }
  }

  renderPlace(place, type) {
    const color = type === "home" ? "teal" : "amber"
    return `
      <div class="text-center">
        ${place.image_url 
          ? `<img src="${place.image_url}" alt="${place.name}" class="w-full h-40 rounded-xl object-cover mb-4">`
          : `<div class="w-full h-40 rounded-xl bg-gradient-to-br from-${color}-500/20 to-${color}-600/20 flex items-center justify-center mb-4 text-4xl">📍</div>`
        }
        <h3 class="text-xl font-bold mb-2">${place.name}</h3>
        <p class="text-gray-400 text-sm mb-4">${place.city || place.address || ''}</p>
        
        <div class="grid grid-cols-2 gap-3 text-sm">
          <div class="p-3 bg-white/5 rounded-lg">
            <div class="text-yellow-400 text-lg">★ ${place.rating || 'N/A'}</div>
            <div class="text-gray-500">Rating</div>
          </div>
          <div class="p-3 bg-white/5 rounded-lg">
            <div class="text-green-400 text-lg">${place.price || 'N/A'}</div>
            <div class="text-gray-500">Price</div>
          </div>
          <div class="p-3 bg-white/5 rounded-lg col-span-2">
            <div class="text-${color}-400 text-lg">${place.reviews_count || 0}</div>
            <div class="text-gray-500">Reviews</div>
          </div>
        </div>
      </div>
    `
  }

  renderEmpty(type) {
    const label = type === "home" ? "home place" : "match"
    const color = type === "home" ? "teal" : "amber"
    return `
      <div class="text-center py-12">
        <div class="text-4xl mb-4 opacity-50">📍</div>
        <p class="text-gray-500">Click a ${label} card above to compare</p>
      </div>
    `
  }

  open() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      this.modalTarget.classList.add("flex")
      document.body.style.overflow = "hidden"
    }
  }

  close() {
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden")
      this.modalTarget.classList.remove("flex")
      document.body.style.overflow = ""
    }
  }

  clear() {
    this.homeData = null
    this.matchData = null
    this.updateDisplay()
    
    // Remove all selections
    document.querySelectorAll("[data-selected]").forEach(el => {
      el.removeAttribute("data-selected")
      el.classList.remove("ring-2", "ring-teal-500", "ring-amber-500")
    })
  }
}
