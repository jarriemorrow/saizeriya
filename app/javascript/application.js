// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import Swiper from 'swiper';
import 'swiper/swiper-bundle.css';
import Cocooned from '@notus.sh/cocooned'
Cocooned.start()

const swiper = new Swiper('.swiper', {
  direction: 'horizontal', // 水平スライド
  loop: true,
  slidesPerView: 1, // 1枚ずつ表示
  autoHeight: true, // 画像に合わせて高さを自動調整
  pagination: {
    el: '.swiper-pagination',
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
  scrollbar: {
    el: '.swiper-scrollbar',
  },
});