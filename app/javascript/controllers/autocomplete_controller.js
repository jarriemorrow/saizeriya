import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["input", "results", "hiddenInput"];

  connect() {
    if (!this.hasResultsTarget) {
      console.error('Missing target element "results" for "autocomplete" controller');
    }
    this.resultsTarget.classList.add('hidden');  // 初期状態で非表示にする
  }

  async search(event) {
    const query = this.inputTarget.value.trim();

    if (query === "") {
      this.clearResults();
      return;
    }

    const response = await fetch(`/search_menus?query=${encodeURIComponent(query)}`);
    if (response.ok) {
      const results = await response.json();
      this.displayResults(results);
    } else {
      console.error("Failed to fetch search results.");
    }
  }

  displayResults(results) {
    this.clearResults();

    if (results.length === 0) {
      return;
    }

    results.forEach(result => {
      const listItem = document.createElement('li');
      listItem.textContent = result.menu_name;
      listItem.dataset.menuId = result.id;

      listItem.addEventListener('click', () => {
        this.selectResult(result);
      });

      this.resultsTarget.appendChild(listItem);
    });

    // 候補リストを表示
    this.resultsTarget.classList.remove('hidden');
  }

  selectResult(result) {
    this.inputTarget.value = result.menu_name;
    this.hiddenInputTarget.value = result.id;
    this.clearResults();
  }

  clearResults() {
    this.resultsTarget.innerHTML = '';
    this.resultsTarget.classList.add('hidden');  // 検索結果がない場合に非表示
  }
}
