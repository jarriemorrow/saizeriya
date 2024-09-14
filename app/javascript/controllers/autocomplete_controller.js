import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["input", "results", "hiddenInput"];

  connect() {
    if (!this.hasResultsTarget) {
      console.error('Missing target element "results" for "autocomplete" controller');
    }
  }

  async search(event) {
    const query = this.inputTarget.value;
    const response = await fetch(`/search_menus?query=${encodeURIComponent(query)}`);
    const results = await response.json();
    this.displayResults(results);
  }

  displayResults(results) {
    this.resultsTarget.innerHTML = '';
    results.forEach(result => {
      const listItem = document.createElement('li');
      listItem.textContent = result.menu_name;
      listItem.dataset.menuId = result.id;

      listItem.addEventListener('click', () => {
        this.selectResult(result);
      });

      this.resultsTarget.appendChild(listItem);
    });
  }

  selectResult(result) {
    this.inputTarget.value = result.menu_name;
    this.hiddenInputTarget.value = result.id;
    this.resultsTarget.innerHTML = '';
  }
}
