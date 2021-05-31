MW.Audio = do ->
  init = ->
    onRemoveAudio()
    onChangeAudio()

  onRemoveAudio = ->
    $(document).on 'click', '.remove-file-button', (e) =>
      wrapper = $(e.target).parents('.file-wrapper')

      wrapper.find('.file-inputbox').parent().removeClass('d-none')
      wrapper.find('.remove-file-checkbox').val(1)
      wrapper.find('.remove-file-wrapper').hide()

  onChangeAudio = ->
    $(document).on 'change', '.file-inputbox', (e) =>
      wrapper = $(e.target).parents('.file-wrapper')
      !!wrapper.find('.remove-file-checkbox') && wrapper.find('.remove-file-checkbox').val(0)

  { init: init }
