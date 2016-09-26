$(() => {
  // Changing pages with `select` on small screen navigation
  console.info($('.js-menu-smallscreen'));
  $('.js-menu-smallscreen').on('change', (event) => {
    window.location = event.target.value;
  });
});
