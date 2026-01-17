import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="compare"
export default class extends Controller {
  static targets = ["modal", "homePlace", "matchPlace"]
  
  connect() {
    this.homeData = null
    this.matchData = null
  }

  selectHome(event) {
    const button = event.currentTarget
    const placeData = button.dataset.place
    
    if (placeData) {
      this.homeData = JSON.parse(placeData)
      this.updateHomeDisplay()
      
      // Visual feedback - update button
      document.querySelectorAll('.select-home-btn').forEach(btn => {
        btn.classList.remove('bg-teal-500', 'text-white')
        btn.classList.add('bg-teal-500/20', 'text-teal-400')
        btn.textContent = '✓ Select for Compare'
      })
      button.classList.remove('bg-teal-500/20', 'text-teal-400')
      button.classList.add('bg-teal-500', 'text-white')
      button.textContent = '✓ Selected!'
    }
  }

  selectMatch(event) {
    const button = event.currentTarget
    const placeData = button.dataset.place
    
    if (placeData) {
      this.matchData = JSON.parse(placeData)
      this.updateMatchDisplay()
      
      // Visual feedback - update button
      document.querySelectorAll('.select-match-btn').forEach(btn => {
        btn.classList.remove('bg-amber-500', 'text-white')
        btn.classList.add('bg-amber-500/20', 'text-amber-400')
        btn.textContent = '✓ Select for Compare'
      })
      button.classList.remove('bg-amber-500/20', 'text-amber-400')
      button.classList.add('bg-amber-500', 'text-white')
      button.textContent = '✓ Selected!'
    }
  }

  updateHomeDisplay() {
    if (this.hasHomePlaceTarget && this.homeData) {
      this.homePlaceTarget.innerHTML = this.renderPlace(this.homeData)
    }
  }

  updateMatchDisplay() {
    if (this.hasMatchPlaceTarget && this.matchData) {
      this.matchPlaceTarget.innerHTML = this.renderPlace(this.matchData)
    }
  }

  renderPlace(place) {
    const imageHtml = place.image_url 
      ? `<img src="${place.image_url}" alt="${place.name}" class="w-full h-40 rounded-xl object-cover mb-4">`
      : `<div class="w-full h-40 rounded-xl bg-gradient-to-br from-teal-500/20 to-amber-500/20 flex items-center justify-center mb-4 text-4xl">📍</div>`
    
    return `
      <div class="text-center">
        ${imageHtml}
        <h3 class="text-xl font-bold mb-2">${place.name || 'Unknown'}</h3>
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
            <div class="text-purple-400 text-lg">${place.reviews_count || 0}</div>
            <div class="text-gray-500">Reviews</div>
          </div>
        </div>
      </div>
    `
  }

  open(event) {
    event.preventDefault()
    if (this.hasModalTarget) {
      this.modalTarget.classList.remove("hidden")
      this.modalTarget.classList.add("flex")
      document.body.style.overflow = "hidden"
    }
  }

  close(event) {
    if (event) event.preventDefault()
    if (this.hasModalTarget) {
      this.modalTarget.classList.add("hidden")
      this.modalTarget.classList.remove("flex")
      document.body.style.overflow = ""
    }
  }

  stopPropagation(event) {
    event.stopPropagation()
  }

  clear(event) {
    if (event) event.preventDefault()
    this.homeData = null
    this.matchData = null
    
    if (this.hasHomePlaceTarget) {
      this.homePlaceTarget.innerHTML = `
        <div class="text-center py-12">
          <div class="text-4xl mb-4 opacity-50">📍</div>
          <p class="text-gray-500">Click "Select for Compare" on a home place</p>
        </div>
      `
    }
    if (this.hasMatchPlaceTarget) {
      this.matchPlaceTarget.innerHTML = `
        <div class="text-center py-12">
          <div class="text-4xl mb-4 opacity-50">📍</div>
          <p class="text-gray-500">Click "Select for Compare" on a match</p>
        </div>
      `
    }
    
    // Reset all buttons
    document.querySelectorAll('.select-home-btn').forEach(btn => {
      btn.classList.remove('bg-teal-500', 'text-white')
      btn.classList.add('bg-teal-500/20', 'text-teal-400')
      btn.textContent = '✓ Select for Compare'
    })
    document.querySelectorAll('.select-match-btn').forEach(btn => {
      btn.classList.remove('bg-amber-500', 'text-white')
      btn.classList.add('bg-amber-500/20', 'text-amber-400')
      btn.textContent = '✓ Select for Compare'
    })
  }
}
