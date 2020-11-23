let currentStep = 1
let steps = []

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "step1", "step2", "step3", "progress", "next", "prev", "heading" ]

  connect() {
    steps = [this.step1Target, this.step2Target, this.step3Target]
    document.getElementById("new_address").addEventListener("submit", () => { currentStep = 2 })
    this.updateActiveStep()
  }

  updateActiveStep() {
    for (let index = 0; index < steps.length; index++) {
      ((index + 1) === currentStep) ? steps[index].classList.remove("d-none") : steps[index].classList.add("d-none");
    }
    (currentStep === 1) ? this.prevTarget.classList.add("disabled") : this.prevTarget.classList.remove("disabled");
    (currentStep === steps.length) ? this.nextTarget.classList.add("disabled") : this.nextTarget.classList.remove("disabled");
    this.progressTarget.style.width = `${currentStep * (100 / (steps.length + 1))}%`
    this.headingTarget.innerHTML = `Step ${currentStep} of ${steps.length + 1}` 
  }

  next() {
    if (currentStep === steps.length) { return }

    currentStep++
    this.updateActiveStep()
  }

  prev() {
    if (currentStep === 1) { return }

    currentStep--
    this.updateActiveStep()
  }
}
