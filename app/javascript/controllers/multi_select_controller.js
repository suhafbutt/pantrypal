import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

export default class extends Controller {
  connect() {
    new TomSelect(this.element, {
      maxItems: null,
      create: false,
      valueField: "name",
      labelField: "name",
      searchField: "name",
      plugins: ['remove_button'],
      load: (query, callback) => {
        fetch(`/ingredients?query=${encodeURIComponent(query)}`)
          .then(response => response.json())
          .then(data => callback(data.map(name => ({ name }))))
          .catch(() => callback());
      }
    })
  }
}
