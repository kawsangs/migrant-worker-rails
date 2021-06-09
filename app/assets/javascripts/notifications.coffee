MW.NotificationsNew = do ->
  init = ->
    handleDisplay()
    onChangeTitle()
    onChangeBody()
    onKeypressTitle()
    onKeypressBody()

  handleDisplay = ->
    title = $("[name='notification[title]']").val();
    body = $("[name='notification[body]']").val();
    $('.title').html(title || 'Title');
    $('.text-body').html(body || 'Body');

  onChangeTitle = ->
    $(document).off 'change', "[name='notification[title]']"
    $(document).on 'change', "[name='notification[title]']", (event)->
      $('.title').html(event.target.value)
      $('.title-count').html(event.target.value.length)

  onChangeBody = ->
    $(document).off 'change', "[name='notification[body]']"
    $(document).on 'change', "[name='notification[body]']", (event)->
      $('.text-body').html(event.target.value)
      $('.body-count').html(event.target.value.length)

  onKeypressTitle = ->
    $(document).off 'keypress', "[name='notification[title]']"
    $(document).on 'keypress', "[name='notification[title]']", (event)->
      $('.title-count').html(event.target.value.length)

  onKeypressBody = ->
    $(document).off 'keypress', "[name='notification[body]']"
    $(document).on 'keypress', "[name='notification[body]']", (event)->
      $('.body-count').html(event.target.value.length)


  { init: init }

MW.NotificationsEdit = MW.NotificationsNew
MW.NotificationsUpdate = MW.NotificationsNew
MW.NotificationsCreate = MW.NotificationsNew
