import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu"]

  toggle() {
    this.menuTarget.classList.toggle("hidden")
  }

  hide() {
    this.menuTarget.classList.add("hidden")
  }

  connect() {
    this.handleClickOutside = this.#clickOutside.bind(this)
    this.handleEscape = this.#escape.bind(this)
    document.addEventListener("click", this.handleClickOutside)
    document.addEventListener("keydown", this.handleEscape)
  }

  disconnect() {
    document.removeEventListener("click", this.handleClickOutside)
    document.removeEventListener("keydown", this.handleEscape)
  }

  // Private methods
  #clickOutside(event) {
    if (!this.element.contains(event.target) && !this.menuTarget.classList.contains("hidden")) {
      this.hide()
    }
  }

  #escape(event) {
    if (event.key === "Escape" && !this.menuTarget.classList.contains("hidden")) {
      this.hide()
    }
  }
}
