import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input"]

  search() {
    clearTimeout(this.timeout)
    this.timeout = setTimeout(() => {
      const query = this.inputTarget.value
      const url = `/recipes/search?ingredients=${encodeURIComponent(query)}`
      Turbo.visit(url, { frame: "results" })
    }, 300)
  }
}
