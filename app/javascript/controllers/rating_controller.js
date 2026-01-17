import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="rating"
// Provides visual feedback for star rating selection
export default class extends Controller {
  static targets = ["star", "input"]

  connect() {
    this.updateStars()
  }

  select(event) {
    const value = event.currentTarget.dataset.value
    
    // Find and check the corresponding radio input
    const input = this.element.querySelector(`input[value="${value}"]`)
    if (input) {
      input.checked = true
      this.updateStars()
    }
  }

  hover(event) {
    const value = parseInt(event.currentTarget.dataset.value)
    this.highlightStars(value)
  }

  reset() {
    this.updateStars()
  }

  updateStars() {
    const checkedInput = this.element.querySelector('input[type="radio"]:checked')
    const selectedValue = checkedInput ? parseInt(checkedInput.value) : 0
    this.highlightStars(selectedValue)
  }

  highlightStars(value) {
    this.starTargets.forEach((star, index) => {
      const starValue = index + 1
      if (starValue <= value) {
        star.classList.add("text-yellow-400", "scale-110")
        star.classList.remove("text-gray-500")
      } else {
        star.classList.remove("text-yellow-400", "scale-110")
        star.classList.add("text-gray-500")
      }
    })
  }
}
