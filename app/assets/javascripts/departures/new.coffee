MW.DeparturesNew = do ->
  init = ->
    onRemoveAudio()
    onChangeAudio()

    onChangeImageFile()
    onClickButtonDeleteImage()

    handleDisplayGallery()
    onToggleIsLastCategory()

    MW.CategoryImages.onFileUpload()

  onToggleIsLastCategory = ->
    $(document).off 'change', "[name='category[last]']"
    $(document).on 'change', "[name='category[last]']", (event)->
      handleDisplayGallery()

  handleDisplayGallery = ->
    isChecked = !!$("[name='category[last]']:checked").length
    $("#category-images").toggle(isChecked)

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

  #=========Image rendering
  onClickButtonDeleteImage = ->
    $(document).on 'click', '.btn-delete', (event)->
      parent = $(event.target).parents('.image-wrapper')
      showDefaultImage(parent)
      hideDeleteButton(parent)
      setCheckRemoveAvatar(parent)

  onChangeImageFile = ->
    $(document). on 'change', '.image-file', (event)->
      parent = $(event.target).parents('.image-wrapper')
      readURL(this, parent)
      showButtonDelete(parent)
      setUncheckRemoveAvatar(parent)

  setCheckRemoveAvatar = (parentDom)->
    $(parentDom).find('.remove-image-checkbock').attr('checked', true)

  showDefaultImage = (parentDom)->
    parentDom.find('.display-image').attr 'src', parentDom.find('.display-image').data('default')

  hideDeleteButton = (parentDom)->
    parentDom.find('.btn-delete').addClass 'd-none'

  readURL = (input, parentDom) ->
    if input.files and input.files[0]
      reader = new FileReader

      reader.onload = (e) ->
        parentDom.find('.display-image').attr 'src', e.target.result

      reader.readAsDataURL input.files[0]

  showButtonDelete = (parentDom)->
    parentDom.find('.btn-delete').removeClass 'd-none'

  setUncheckRemoveAvatar = (parentDom)->
    parentDom.find('.remove-image-checkbock').attr 'checked', false

  {
    init: init,
    onRemoveAudio: onRemoveAudio,
    onChangeAudio: onChangeAudio,
    onChangeImageFile: onChangeImageFile,
    onClickButtonDeleteImage: onClickButtonDeleteImage
  }

MW.DeparturesEdit = MW.DeparturesNew
MW.DeparturesUpdate = MW.DeparturesNew
MW.DeparturesCreate = MW.DeparturesNew

MW.SafetiesNew = MW.DeparturesNew
MW.SafetiesEdit = MW.DeparturesNew
MW.SafetiesUpdate = MW.DeparturesNew
MW.SafetiesCreate = MW.DeparturesNew
