MW.NotificationsNew = do ->
  init = ->
    handleDisplay()
    onChangeTitle()
    onChangeBody()
    onKeypressTitle()
    onKeypressBody()
    onClickToggleCollapse()

    # Notification Shedule
    onChangeScheduleMode()
    handleDisplayScheduleSetting($("#notification_schedule_mode").val())
    MW.Common.SelectRecurringTranslation.init()

  onClickToggleCollapse = ->
    $(document).off 'click', ".toggle-trigger"
    $(document).on 'click', ".toggle-trigger", (event)->
      if $('.title').hasClass('text-truncate')
        $('.title').removeClass('text-truncate')
        $('.text-body').removeClass('text-truncate')
        $('.toggle-trigger i').removeClass('fa-chevron-down')
        $('.toggle-trigger i').addClass('fa-chevron-up')
      else
        $('.title').addClass('text-truncate')
        $('.text-body').addClass('text-truncate')
        $('.toggle-trigger i').removeClass('fa-chevron-up')
        $('.toggle-trigger i').addClass('fa-chevron-down')

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

  onChangeScheduleMode = ->
    $("#notification_schedule_mode").on 'change', (event) ->
      handleDisplayScheduleSetting(@.value)

  handleDisplayScheduleSetting = (value)->
    if value == 'onetime'
      hideRecurrenceContent()
      showOnetimeContent()
    else if value == 'recurrence'
      hideOnetimeContent()
      showRecurrenceContent()
    else
      hideOnetimeContent()
      hideRecurrenceContent()

  showOnetimeContent = ->
    $('.onetime-wrapper').removeClass('d-none')

  showRecurrenceContent = ->
    $('.recurrence-wrapper').removeClass('d-none')

  hideOnetimeContent = ->
    $('.onetime-wrapper').addClass('d-none')

  hideRecurrenceContent = ->
    $('.recurrence-wrapper').addClass('d-none')

  { init: init }

MW.NotificationsEdit = MW.NotificationsNew
MW.NotificationsUpdate = MW.NotificationsNew
MW.NotificationsCreate = MW.NotificationsNew
