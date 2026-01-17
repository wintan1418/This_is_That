import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    latitude: Number,
    longitude: Number,
    name: String
  }

  connect() {
    if (!this.latitudeValue || !this.longitudeValue) return

    // Initialize map
    this.map = L.map(this.element).setView([this.latitudeValue, this.longitudeValue], 15)

    // Add OpenStreetMap tiles
    L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 19,
      attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a>'
    }).addTo(this.map)

    // Add marker
    L.marker([this.latitudeValue, this.longitudeValue])
      .addTo(this.map)
      .bindPopup(this.nameValue)
      .openPopup()
  }

  disconnect() {
    if (this.map) {
      this.map.remove()
    }
  }
}
