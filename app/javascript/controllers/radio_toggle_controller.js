import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ "toggle", "wrapper" ]

  connect() {
    this.toRemove = []
    this.wrapperTarget.querySelectorAll("[type=radio]").forEach((input) => {
      this.toRemove.push(input.value)
      input.addEventListener('change', this.handleChange.bind(this))
    })
    this.handleChange()
  }

  handleChange(e) {
    let value = this.wrapperTarget.querySelector("[type=radio]:checked").value
    this.toggleTarget.classList.remove(...this.toRemove)
    this.toggleTarget.classList.add(value)
  }
}
