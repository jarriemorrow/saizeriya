// app/javascript/posts_form.js
document.addEventListener("DOMContentLoaded", function() {
  let menuIndex = document.querySelectorAll('.menu-field').length;

  document.getElementById('add-menu-button').addEventListener('click', function() {
    const container = document.getElementById('menu-fields-container');
    const newMenuField = document.classList.add('menu-field');
    container.appendChild(newMenuField);
    menuIndex++;
  });
});
