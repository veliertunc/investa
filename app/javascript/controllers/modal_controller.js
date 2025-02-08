import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  connect() {
    document.body.classList.add('overflow-hidden')
  }

  disconnect() {
    document.body.classList.remove('overflow-hidden')
  }

  close(event) {
    event.preventDefault()
    this.element.remove()
  }

  // Handle escape key
  closeWithKeyboard(event) {
    if (event.keyCode === 27) {
      this.close(event)
    }
  }
}
