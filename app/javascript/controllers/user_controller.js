import { Controller } from "@hotwired/stimulus"
import { csrfToken } from "csrf"

export default class extends Controller {
  async exists(e) {
    const input = e.target

    if (input.checkValidity()) {
      const resp = await fetch("/session/user", {
        method: "POST",
        body: JSON.stringify({ email_address: input.value }),
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": csrfToken()
        }
      })

      if (resp.ok) {
        input.closest(".field").classList.remove("new")
      } else {
        input.closest(".field").classList.add("new")
      }
    }
  }
}
