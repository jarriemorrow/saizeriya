import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    console.log("SearchController connected");
  }

  async search(event) {
    console.log("Search event triggered");
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
    this.clearResults(); // 前回の結果をクリア

    if (results.length === 0) {
      return;
    }

    results.forEach(result => {
      const listItem = document.createElement('li');
      listItem.textContent = result.menu_name;
      listItem.classList.add('search-item'); // クラスを追加
      listItem.dataset.menuId = result.id;

      listItem.addEventListener('click', () => {
        this.selectResult(result);
      });

      this.resultsTarget.appendChild(listItem);
    });

    this.resultsTarget.classList.remove('hidden'); // 結果リストを表示
  }

  selectResult(result) {
    this.inputTarget.value = result.menu_name; // 選択した値を入力フィールドに反映
    this.clearResults(); // リストをクリアして非表示にする
  }

  clearResults() {
    this.resultsTarget.innerHTML = ''; // リストを空にする
    this.resultsTarget.classList.add('hidden'); // 非表示にする
  }
}
