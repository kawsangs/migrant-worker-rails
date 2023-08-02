MW.Common.ConfirmModal = (() => {
  return { init: init }

  function init(modalId='confirmModal') {
    if(!$(`#${modalId}`)) return;

    $(`#${modalId}`).on('show.bs.modal', function (event) {
      var button = $(event.relatedTarget);
      var modal = $(this);

      let title = modal.find('.modal-title').data('content').replace(/_type_/, button.data("messageType"));
      let body = modal.find('.modal-body').data('content').replace(/_type_/, button.data("messageType")).replace(/_name_/, button.data("messageName"));

      modal.find('.modal-title .message-title').html(title);
      modal.find('.modal-body').html(body);
      modal.find('form').attr('action', button.data('messageUrl'));
    })
  }

})();
