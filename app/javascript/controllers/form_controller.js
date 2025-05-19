import { Controller } from "@hotwired/stimulus"
import autosize from "autosize"

export default class extends Controller {
  connect() {
    // handle submit succes or failure
    this.element.addEventListener("turbo:submit-end", this.handleSubmitEnd.bind(this))

    // resize textarea on content chagne
    this.element.querySelectorAll('textarea').forEach((el) => {
      autosize(el)
      el.addEventListener('input', this.handleTextAreaInput.bind(this))
    })
  }

  submit() {
    this.element.requestSubmit()
  }

  handleSubmitEnd(e) {
    if (this.element.closest(".card")) {
      if (e.detail.success) {
        this.element.closest(".card").classList.remove("invalid")
      } else {
        this.element.closest(".card").classList.add("invalid")
      }
    }
  }

  handleTextAreaInput(e) {
    autosize(e.target)
  }
}
