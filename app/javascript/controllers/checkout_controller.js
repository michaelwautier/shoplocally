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
    (currentStep === 1) ? this.prevTarget.classList.add("d-none") : this.prevTarget.classList.remove("d-none");
    (currentStep === steps.length) ? this.nextTarget.classList.add("d-none") : this.nextTarget.classList.remove("d-none");
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

  address(event) {
    // console.log(event.target.id)
    switch (event.target.id) {
      case 'user-address':
        document.getElementById('user-address-radio').checked = true
        this.next()
        break;
      case 'pickup-address':
        document.getElementById('pickup-address-radio').checked = true
        this.next();
        break;
      case 'new-address':
        document.getElementById('new-address-radio').checked = true
        document.getElementById('address_street').focus()
        break;
      default:
        break;
    }
  }
}
