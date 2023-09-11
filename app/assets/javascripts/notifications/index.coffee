MW.NotificationsIndex = do ->
  init = ->
    MW.Common.ConfirmModal.init("confirmCancelModal");
    MW.Common.ConfirmModal.init("confirmPublishModal");

  { init: init }
