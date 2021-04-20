MW.Common.Topbar = do ->
  init = ->
    switchLanguage()
    onSubmitLanguage()

  switchLanguage = ->
    $('.switch-language').on 'click', (e)->
      $('#account_language_code').val($(e.currentTarget).data('language'))
      Rails.fire($('#switch-language')[0], 'submit')

  onSubmitLanguage = ->
    $('#switch-language').on 'ajax:success', ->
      window.location.reload()

  { init: init }
