MW.Common.DatetimePicker = do ->
  init = ->
    return if !$('.datetimepicker')
    $('.datetimepicker').datetimepicker({format: 'YYYY-MM-DD'})

  { init: init }
