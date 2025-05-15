import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "template", "wrapper" ]
  static outlets = [ "form" ]

  add() {
    const content = this.templateTarget.content.cloneNode(true)
    this.wrapperTarget.appendChild(content)
    this.wrapperTarget.querySelector(".option:last-child [type=text]").focus()
    this.formOutlet.submit()
  }

  remove(e) {
    e.target.closest(".option").remove()
    this.formOutlet.submit()
  }
}
