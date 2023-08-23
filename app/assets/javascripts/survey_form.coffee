MW.Survey_formsNew = do ->
  init = ->
    MW.Form.init()
    MW.Form.onClickAddAssociation("form .add_sections")

    initFormTagList()
    initQuestionTagList()

  initFormTagList = ->
    MW.Common.tagList.init("#forms_survey_form_tag_list")

  initQuestionTagList = ->
    questions = $(".fieldset")
    count = 0

    while count < questions.length
      MW.Common.tagList.init($(questions[count]).find('.tag-list'))
      count++

  { init: init }

# Survey
MW.Survey_formsEdit = MW.Survey_formsNew
MW.Survey_formsUpdate = MW.Survey_formsNew
MW.Survey_formsCreate = MW.Survey_formsNew
