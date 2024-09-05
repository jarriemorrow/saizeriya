import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static classes = [ "activeTab", "inactiveTab" ]
  static targets = ['tab', 'panel', 'select', 'form']
  static values = {
    index: { type: Number, default: null },
    updateAnchor: Boolean,
    scrollToAnchor: Boolean,
    scrollActiveTabIntoView: Boolean
  }

  connect() {
    this.showTab()
  }

  change(event) {
    event.preventDefault();
    const target = event.currentTarget;
    const tagId = target.dataset.tab; // タブIDを取得

    // フォームの隠しフィールドにタグIDを設定
    const hiddenField = document.getElementById('post_tag_id');
    if (hiddenField) {
      hiddenField.value = tagId;
    }

    if (target.tagName === "SELECT") {
      this.indexValue = target.selectedIndex;
    } else if (target.dataset.index) {
      this.indexValue = target.dataset.index;
    } else if (target.dataset.id) {
      this.indexValue = this.tabTargets.findIndex((tab) => tab.id == target.dataset.id);
    } else {
      this.indexValue = this.tabTargets.indexOf(target);
    }
  }

  indexValueChanged() {
    this.showTab()
    this.dispatch("tab-change", {
      target: this.tabTargets[this.indexValue],
      detail: {
        activeIndex: this.indexValue
      }
    })

    if (this.updateAnchorValue) {
      const newTabId = this.tabTargets[this.indexValue].id
      if (this.scrollToAnchorValue) {
        location.hash = newTabId
      } else {
        const currentUrl = window.location.href
        const newUrl = currentUrl.split('#')[0] + '#' + newTabId
        history.replaceState({}, document.title, newUrl)
      }
    }
  }

  showTab() {
    this.panelTargets.forEach((panel, index) => {
      const tab = this.tabTargets[index]

      if (index === this.indexValue) {
        panel.classList.remove('hidden')
        tab.ariaSelected = 'true'
        tab.dataset.active = true
        if (this.hasInactiveTabClass) tab?.classList?.remove(...this.inactiveTabClasses)
        if (this.hasActiveTabClass) tab?.classList?.add(...this.activeTabClasses)
        this.resetForm(panel)
      } else {
        panel.classList.add('hidden')
        tab.ariaSelected = null
        delete tab.dataset.active
        if (this.hasActiveTabClass) tab?.classList?.remove(...this.activeTabClasses)
        if (this.hasInactiveTabClass) tab?.classList?.add(...this.inactiveTabClasses)
      }
    })

    if (this.hasSelectTarget) {
      this.selectTarget.selectedIndex = this.indexValue
    }

    if (this.scrollActiveTabIntoViewValue) {
      this.scrollToActiveTab()
    }
  }

  resetForm(panel) {
    const form = panel.querySelector('form');
    if (form) {
      form.reset();
    }
  }

  scrollToActiveTab() {
    const activeTab = this.element.querySelector('[aria-selected]')
    if (activeTab) {
      activeTab.scrollIntoView({ inline: 'center' })
    }
  }

  get tabsCount() {
    return this.tabTargets.length
  }

  get anchor() {
    return (document.URL.split('#').length > 1) ? document.URL.split('#')[1] : null;
  }
}
