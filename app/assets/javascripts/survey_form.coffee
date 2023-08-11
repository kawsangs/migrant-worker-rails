MW.Survey_formsNew = do ->
  init = ->
    MW.Form.init()
    MW.Form.onClickAddAssociation("form .add_sections")

  { init: init }

# Survey
MW.Survey_formsEdit = MW.Survey_formsNew
MW.Survey_formsUpdate = MW.Survey_formsNew
MW.Survey_formsCreate = MW.Survey_formsNew
