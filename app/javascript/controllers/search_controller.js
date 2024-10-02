import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ["input", "results"];

  connect() {
    console.log("SearchController connected");
  }

  async search(event) {
    console.log("Search event triggered");

    // スペースで区切ってキーワードを取得
    const keywords = this.inputTarget.value.trim().split(/[\s\u3000]+/).filter(Boolean);
    if (keywords.length === 0) {
      this.clearResults();
      return;
    }

    // 各キーワードで検索を行うためのクエリを生成
    const queries = keywords.map(query => encodeURIComponent(query)).join("&query=");
    const response = await fetch(`/search_menus?query=${queries}`);
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
    // 現在の入力内容を取得
    const currentValue = this.inputTarget.value.trim();
    const keywords = currentValue.split(/[\s\u3000]+/); // スペースで区切る
    keywords[keywords.length - 1] = result.menu_name; // 最後のキーワードを選択したメニュー名に置き換え

    // 結合して入力フィールドに反映
    this.inputTarget.value = keywords.join(" ") + " "; // 最後にスペースを追加

    this.clearResults(); // リストをクリアして非表示にする

    // カーソルを最後に移動
    this.inputTarget.focus();
    this.inputTarget.setSelectionRange(this.inputTarget.value.length, this.inputTarget.value.length);
  }

  clearResults() {
    this.resultsTarget.innerHTML = ''; // リストを空にする
    this.resultsTarget.classList.add('hidden'); // 非表示にする
  }
}
