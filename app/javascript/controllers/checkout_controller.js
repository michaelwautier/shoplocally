let currentStep = 1
let steps = []

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "step1", "step2", "step3", "progress", "next", "prev" ]

  connect() {
    steps = [this.step1Target, this.step2Target, this.step3Target]
    document.getElementById("new_address").addEventListener("submit", () => { currentStep = 1 })
    this.progressTarget.style.width = `${currentStep * 33.33}%`
  }

  updateActiveStep() {
    for (let index = 0; index < steps.length; index++) {
      if ((index + 1) === currentStep) {
        steps[index].classList.remove("d-none")
      } else {
        steps[index].classList.add("d-none")
      }
    }
    this.progressTarget.style.width = `${currentStep * 33.33}%`
  }

  next() {
    if (currentStep === 3) { return }

    currentStep++
    this.updateActiveStep()
  }

  prev() {
    if (currentStep === 1) { return }

    currentStep--
    this.updateActiveStep()
  }
}
