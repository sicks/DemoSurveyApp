import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = [ "toggle" ]
  static values = {
    inputWrapper: String
  }

  connect() {
    this.toRemove = []
    let wrapper = this.element.querySelector(this.inputWrapperValue)
    this.element.querySelectorAll(this.inputWrapperValue + " [type=radio]").forEach((input) => {
      this.toRemove.push(input.value)
      input.addEventListener('change', this.handleChange.bind(this))
    })
    this.handleChange()
  }

  handleChange(e) {
    let wrapper = this.element.querySelector(this.inputWrapperValue)
    this.toggleTarget.classList.remove(...this.toRemove)
    this.toggleTarget.classList.add(wrapper.querySelector("[type=radio]:checked").value)
  }
}
