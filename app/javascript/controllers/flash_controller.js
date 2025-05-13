import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  initialize() {
    this.delays = {
      'notice': 5000,
      'success': 5000,
      'alert': 7500,
      'error': 10000
    }
  }

  connect() {
    this.element.style.height = this.element.clientHeight + 'px'
    this.element.addEventListener('mouseenter', this.cancelDismissal.bind(this))
    this.element.addEventListener('mouseleave', this.planDismissal.bind(this))
    window.addEventListener('resize', this.refreshHeight.bind(this))

    this.planDismissal()
  }

  refreshHeight() {
    this.element.style.height = 'auto'
    this.element.style.height = this.element.clientHeight + 'px'
  }

  dismiss() {
    this.element.classList.add('dismissing')
    this.element.style.height = 0
    this.timer = setTimeout(() => {
      this.element.remove()
    }, 500)
  }

  cancelDismissal() {
    this.element.classList.remove('dismissing')
    clearTimeout(this.timer)
  }

  planDismissal() {
    this.timer = setTimeout(()=> {
      this.dismiss()
    }, this.delays[this.element.dataset.type])
  }
}
