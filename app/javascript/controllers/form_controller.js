import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.element.addEventListener("turbo:submit-end", this.handleSubmitEnd.bind(this))
  }

  submit() {
    this.element.requestSubmit()
  }

  handleSubmitEnd(e) {
    if (e.detail.success) {
      this.element.closest(".card").classList.remove("invalid")
    } else {
      this.element.closest(".card").classList.add("invalid")
    }
  }
}
