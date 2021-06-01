MW.NotificationsNew = do ->
  init = ->
    handleDisplay()
    onChangeTitle()
    onChangeBody()

  handleDisplay = ->
    title = $("[name='notification[title]']").val();
    body = $("[name='notification[body]']").val();
    $('.title').html(title || 'Title');
    $('.text-body').html(body || 'Body');

  onChangeTitle = ->
    $(document).off 'change', "[name='notification[title]']"
    $(document).on 'change', "[name='notification[title]']", (event)->
      $('.title').html(event.target.value)

  onChangeBody = ->
    $(document).off 'change', "[name='notification[body]']"
    $(document).on 'change', "[name='notification[body]']", (event)->
      $('.text-body').html(event.target.value)


  { init: init }

MW.NotificationsEdit = MW.NotificationsNew
MW.NotificationsUpdate = MW.NotificationsNew
MW.NotificationsCreate = MW.NotificationsNew
