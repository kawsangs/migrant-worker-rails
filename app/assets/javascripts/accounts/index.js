MW.AccountsIndex = (function() {
  return {
    init
  }

  function init() {
    MW.Common.DaterangePicker.init();
    onClickBtnCopyConfirmLink();
  }

  function onClickBtnCopyConfirmLink() {
    $(document).off('click', '.btn-copy');
    $(document).on('click', '.btn-copy', function(event) {
      let input = $(this).prev('input.confirm-link');
      input.select();
      document.execCommand("copy");
      event.preventDefault();
      $('.toast').toast('show');
    });
  }

})();
