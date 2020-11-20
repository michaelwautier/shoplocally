import { Controller } from "stimulus"
let currentTab = 1
let tabs = []
export default class extends Controller {
  static targets = [ "output", "progress","tab1", "tab2", "tab3","prevBtn"];
  
  connect() {
    this.outputTarget.textContent = `Checkout: step ${currentTab} of 3`
    tabs = [this.tab1Target, this.tab2Target, this.tab3Target]
    this.progressTarget.style.width = `${currentTab * 33.3}%`
  }

  activateTab(element) {
    element.classList.add("show", "active")
    element.classList.remove("fade")
  }

  deactivateTab(element) {
    element.classList.remove("show", "active")
    element.classList.add("fade")
  }

  updateActiveTab() {
    for (let index = 0; index < tabs.length; index++) {
      if (index + 1 === currentTab) {
        this.activateTab(tabs[index])
      } else {
        this.deactivateTab(tabs[index])
      }
    }
    this.outputTarget.textContent = `Checkout: step ${currentTab} of 3`
    this.progressTarget.style.width = `${currentTab * 33.3}%`
  }

  next() {
    if (currentTab === 3) {
      // do payment and submit form if payment ok
      return
    }
    if (currentTab == 2) {
      // validate address
    }
    currentTab += 1
    this.updateActiveTab()
    this.prevBtnTarget.classList.remove("d-none")
  }

  prev() {
    if (currentTab === 1) { return }

    if (currentTab === 2) {
      this.prevBtnTarget.classList.add("d-none")
    }
    currentTab -=1
    this.updateActiveTab()
  }

  payNow() {
    document.getElementById("submitBtn").click()
    const url = window.location.href
    window.location.replace(url.replace("cart/checkout", "orders"))
  }
}
