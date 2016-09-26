$(() => {
  // Changing pages with `select` on small screen navigation
  console.info($('.js-menu-smallscreen'));
  $('.js-menu-smallscreen').on('change', (event) => {
    console.info('iuiu');
    window.location = event.target.value;
  });
});
