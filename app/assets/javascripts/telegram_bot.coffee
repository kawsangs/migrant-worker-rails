MW.Telegram_botsShow = do ->
  init = ->
    handleDisplayToggle()
    onChangeTelegramToggle()

  onChangeTelegramToggle = ->
    $(document).off 'change', "[name='telegram_bot[enabled]']"
    $(document).on 'change', "[name='telegram_bot[enabled]']", (event)->
      handleDisplayToggle()

  handleDisplayToggle = ->
    isChecked = !!$("[name='telegram_bot[enabled]']:checked").length
    $('.tokens').toggle(isChecked)

  { init: init }

MW.Telegram_botsUpsert = MW.Telegram_botsShow
