MW.Common.ConfirmModal = (() => {
  return { init: init }

  function init(modalId='confirmModal') {
    if(!$(`#${modalId}`)) return;

    $(`#${modalId}`).on('show.bs.modal', function (event) {
      let button = $(event.relatedTarget);
      let message = button.data('message');
      let modal = $(this);

      let title = modal.find('.modal-title').data('content').replace(/_type_/, message.type);
      let body = modal.find('.modal-body').data('content').replace(/_type_/, message.type).replace(/_name_/, message.name);

      modal.find('.modal-title .message-title').html(title);
      modal.find('.modal-body').html(body);
      modal.find('form').attr('action', message.url);
    })
  }

})();
