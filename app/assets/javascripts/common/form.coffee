MW.Form = do ->
  selectOne = 'Questions::SelectOne'
  selectMultiple = 'Questions::SelectMultiple'
  resultType = 'Questions::Result'

  init = ->
    initView()
    initSortable()
    initSetting()

    onClickAddField()
    onClickRemoveField()
    onClickAddFieldOption()
    onChooseFieldType()

    onClickCollapseTrigger()
    onClickBtnAdd()
    onClickRequireCheckbox()

    onClickSettingItem()
    onClickBtnSetting()
    # MW.SkipLogic.init()

    onClickBtnAdvanceOption()
    MW.Audio.init()
    onClickCollapseAllTrigger()
    onClickAddCriteria()
    onChangeQuestionName()

    MW.Criteria.init()

  onChangeQuestionName = ->
    $(document).off 'change', '.field-name'
    $(document).on 'change', '.field-name', (e)->
      value = e.currentTarget.value
      if !!value
        value = value.split(" ").join("_").toLowerCase()
      $(e.currentTarget).parents('.fieldset').find('.question-code').val(value)


  onClickCollapseAllTrigger = ->
    $(document).off 'click', '.collapse-all-trigger'
    $(document).on 'click', '.collapse-all-trigger', (e)->
      dom = e.currentTarget
      content = $('.fieldset').find('.collapse-content')
      icon = $($(dom).find('i'))
      content.toggle()

      if $(content).is(":visible")
        icon.removeClass('fa-caret-right')
        icon.addClass('fa-caret-down')
        hideSettingContent(this)
      else
        icon.addClass('fa-caret-right')
        icon.removeClass('fa-caret-down')

  onClickBtnAdvanceOption = ->
    $(document).off 'click', '.btn-advance'
    $(document).on 'click', '.btn-advance', (e)->
      $(this).parents('.field-wrapper').find('.advance-options').toggleClass('d-none')
      e.preventDefault()

  onClickBtnSetting = ->
    $(document).off 'click', '.btn-setting'
    $(document).on 'click', '.btn-setting', ->
      toggleSettingContent(this)
      hideCollapseContent(this)

  toggleSettingContent = (dom)->
    $(dom).parents('.fieldset').find('.btn-setting').toggleClass('active')
    $(dom).parents('.fieldset').find('.setting-wrapper').toggle()

  hideSettingContent = (dom)->
    $(dom).parents('.fieldset').find('.btn-setting').removeClass('active')
    $(dom).parents('.fieldset').find('.setting-wrapper').hide()

  initSetting = ->
    $('.item-setting').addClass('active')
    $('.setting-content').show()

  onClickSettingItem = ->
    $(document).off 'click', '.setting-wrapper .item'
    $(document).on 'click', '.setting-wrapper .item', (event) ->
      $(this).parents('.setting-wrapper').find('.content').hide()
      $(this).parents('.setting-wrapper').find('.item').removeClass('active')
      $(this).parents('.setting-wrapper').find($(this).data('target')).show()
      $(this).addClass('active')

  onClickRequireCheckbox = ->
    $(document).off 'click', '.field-required'
    $(document).on 'click', '.field-required', (e)->
      $(this).parents('.fieldset').find('.abbr-required').toggleClass('d-none')

  initView = ->
    $('input.field-type').each (index, dom) ->
      return unless dom.value
      initBtnMove(dom)
      initFieldNameStyleAsTitle(dom)
      initCollapseContent(dom)

  initCollapseContent = (dom) ->
    hideCollapseContent(dom)

    if dom.value == selectOne || dom.value == selectMultiple
      showCollapseTrigger(dom)
      showOption(dom)
    else if dom.value == resultType
      showResultField(dom)
      showCollapseTrigger(dom)
    return

  hideCollapseContent = (dom)->
    $(dom).parents('.fieldset').find('.collapse-content').hide()

  showCollapseTrigger = (dom)->
    $(dom).parents('.fieldset').find('.collapse-trigger').show()


  initFieldNameStyleAsTitle = (dom) ->
    parentDom = $(dom).parents('.fieldset')
    parentDom.find('.field-name').addClass('no-style as-title')
    parentDom.find('.btn-add-field').hide()

  initBtnMove = (dom)->
    parentDom = $(dom).parents('.fieldset')
    icon = parentDom.find("[data-field_type='" + dom.value + "'] .icon").clone()
    btnMove = parentDom.find('.move')
    btnMove.empty()
    btnMove.append(icon)
    btnMove.show()

  onClickBtnAdd = ->
    $(document).off('click', '.btn-add-field')
    $(document).on 'click', '.btn-add-field', (event) ->
      $(this).hide()
      parent = $(event.currentTarget).parents('.fieldset')
      parent.find('.field-type-wrapper').show()
      parent.find('.field-name').addClass('no-style')

  onClickCollapseTrigger = ->
    $(document).off('click', '.collapse-trigger')
    $(document).on 'click', '.collapse-trigger', (event) ->
      dom = event.currentTarget
      content = $(dom).parents('.fieldset').find('.collapse-content')
      icon = $($(dom).find('i'))

      content.toggle()

      if $(content).is(":visible")
        icon.removeClass('fa-caret-right')
        icon.addClass('fa-caret-down')
        hideSettingContent(this)
      else
        icon.addClass('fa-caret-right')
        icon.removeClass('fa-caret-down')

  hideCollapseContent = (dom)->
    icon = $(dom).parents('.fieldset').find('.collapse-trigger i')
    icon.addClass('fa-caret-right')
    icon.removeClass('fa-caret-down')
    $(dom).parents('.fieldset').find('.collapse-content').hide()

  # for both remove field and remove option
  onClickRemoveField = ->
    $(document).on 'click', 'form .remove_fields', (event) ->
      event.preventDefault()

      removeField(this)

  removeField = (dom)->
    $(dom).parent().find('input[type=hidden]').val('1')
    $(dom).closest('fieldset').hide()

  onClickAddField = ->
    $(document).off('click', 'form .add_questions')
    $(document).on 'click', 'form .add_questions', (event) ->
      appendField(this)
      event.preventDefault()

  onClickAddAssociation = (css_class='form .add_association')->
    $(document).off('click', css_class)
    $(document).on 'click', css_class, (event) ->
      appendField(this)
      event.preventDefault()

  onClickAddFieldOption = ->
    $(document).off('click', 'form .add_options')
    $(document).on 'click', 'form .add_options', (event) ->
      appendField(this)
      event.preventDefault()

  onClickAddCriteria = ->
    $(document).off('click', 'form .add_criterias')
    $(document).on 'click', 'form .add_criterias', (event) ->
      event.preventDefault()
      criteriaWrapper = appendField(this)
      MW.Criteria.initOptionsToCriteriaQuestionSelect(criteriaWrapper)

  onChooseFieldType = ->
    $(document).off('click', '.field-type-list')
    $(document).on 'click', '.field-type-list', (event) ->
      dom = event.currentTarget
      field_type = $(dom).data('field_type')

      setFieldNameInputAsTitleStyle(dom)
      assignBtnMove(dom)
      assignFieldType(dom, field_type)
      handleCollapseContent(dom, field_type)
      showBtnSetting(dom)

  showBtnSetting = (dom)->
    $(dom).parents('.fieldset').find('.btn-setting').removeClass('d-none')
    $(dom).parents('.fieldset').find('.item-setting').click()

  setFieldNameInputAsTitleStyle = (dom) ->
    fieldName = $(dom).parents('.fieldset').find('.field-name')
    fieldName.addClass('as-title')

  handleCollapseContent = (dom, field_type) ->
    console.log(field_type)
    if field_type == selectOne || field_type == selectMultiple
      showOption(dom)
      initOneOption(dom)
      showArrowDownIcon(dom)
    else if field_type == resultType
      showResultField(dom)
      showArrowDownIcon(dom)

    hideFieldTypeList(dom)

  showArrowDownIcon = (dom)->
    icon = $(dom).parents('.fieldset').find('.collapse-trigger i')
    icon.removeClass('fa-caret-right')
    icon.addClass('fa-caret-down')

    btnCollapseTrigger = $(dom).parents('.fieldset').find('.collapse-trigger')
    btnCollapseTrigger.show()

  hideFieldTypeList = (dom)->
    fieldTypeWrapper = $(dom).parents('.fieldset').find('.field-type-wrapper')
    fieldTypeWrapper.hide()

  showResultField = (dom) ->
    $(dom).parents('.fieldset').find('.result-type-wrapper').show()

  assignBtnMove = (dom) ->
    btnMove = $(dom).parents('.fieldset').find('.move')
    btnMove.empty()
    btnMove.append($($(dom).find('.icon')).clone())
    btnMove.show()

  showOption = (dom)->
    $(dom).parents('.fieldset').find('.options-wrapper').show()

  hideOption = (dom)->
    $(dom).parents('.fieldset').find('.options-wrapper').hide()
    clearAllOptions(dom)

  clearAllOptions = (dom)->
    $(dom).parents('.fieldset').find('.options-wrapper .remove_fields').click()

  assignFieldType = (dom, field_type)->
    fieldType = $(dom).parents('.fieldset').find('.field-type')
    fieldType.val(field_type)

  appendField = (dom) ->
    time = new Date().getTime()
    regexp = new RegExp($(dom).data('id'), 'g')
    field = $($(dom).data('fields').replace(regexp, time))
    field.find('.btn-setting').addClass('d-none')

    $(dom).before(field)
    assignDisplayOrderToListItem()
    MW.Common.SelectPicker.init()
    MW.Common.tagList.init($(field).find('.tag-list'), handleDisplayTagListWrapper) if !!$(field).find('.tag-list').length
    $("[data-toggle='tooltip']").tooltip()

    return field

  handleDisplayTagListWrapper = (dom, tagList) ->
    return hideTagListWrapper(dom) if !tagList

    showTagListWrapper(dom)
    updateDisplayTagList(dom, tagList)

  showTagListWrapper = (dom) ->
    $(dom).parents(".fieldset").find(".tag-list-wrapper").removeClass("d-none")

  hideTagListWrapper = (dom) ->
    $(dom).parents(".fieldset").find(".tag-list-wrapper").addClass("d-none")

  updateDisplayTagList = (dom, tagList) ->
    wrapper = dom.parents(".fieldset").find(".tag-list-wrapper .tag-wrapper")
    tags = tagList.split(",").map((tag) => "<small class='tag rounded mr-1'>" + tag + "</small>").join("")
    wrapper.html(tags)

  initOneOption = (dom)->
    $(dom).parents('.fieldset').find('.add_options').click()

  animateListItems = ($item, container, _super) ->
    $clonedItem = $('<li/>').css(height: 0)
    $item.before $clonedItem
    $clonedItem.animate 'height': $item.height()
    $item.animate $clonedItem.position(), ->
      $clonedItem.detach()
      _super $item, container
    return

  assignDisplayOrderToListItem = ->
    $('ol.fields li').each (index)->
      $(this).find('.display-order').val(index)

  initSortable = ->
    $(document).find('ol.fields.sortable').sortable
      handle: '.move'
      onDrop: ($item, container, _super) ->
        animateListItems($item, container, _super)
        assignDisplayOrderToListItem()

  {
    init: init
    onClickAddAssociation: onClickAddAssociation
    onClickRemoveField: onClickRemoveField
    handleDisplayTagListWrapper: handleDisplayTagListWrapper
  }
