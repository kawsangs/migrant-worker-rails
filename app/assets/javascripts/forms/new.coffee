MW.Story_formsNew = do ->
  init = ->
    MW.Form.init()

  { init: init }

MW.Story_formsEdit = MW.Story_formsNew
MW.Story_formsUpdate = MW.Story_formsNew
MW.Story_formsCreate = MW.Story_formsNew

# Survey
MW.Survey_formsNew = MW.Story_formsNew
MW.Survey_formsEdit = MW.Survey_formsNew
MW.Survey_formsUpdate = MW.Survey_formsNew
MW.Survey_formsCreate = MW.Survey_formsNew
