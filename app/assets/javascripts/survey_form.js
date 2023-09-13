MW.Survey_formsNew = (() => {
  return {
    init
  }

  function init() {
    MW.Form.init()
    MW.Form.onClickAddAssociation("form .add_sections")

    initFormTagList()
    initQuestionTagList()
    onChangeChatGroupSelect();
    onChangeTracking();
  }

  function onChangeChatGroupSelect() {
    $(document).on("change", "select.chat_group_ids", function(e) {
      let select = $(this);
      let chatGroupNames = getChatGroupLabels(select);

      if(!chatGroupNames.length) return hideChatGroup(select);

      showChatGroup(select);
      updateChatGroupTooltip(select, chatGroupNames);
    })
  }

  function onChangeTracking() {
    $(document).on("change", "input.tracking-checkbox", function(e) {
      $(this).parents(".fieldset").find(".tracking").toggleClass("d-none", !this.checked);
    })
  }

  function updateChatGroupTooltip(select, chatGroupNames) {
    let tooltipSpan = select.parents(".fieldset").find(".notification-wrapper");
    let title = "<div class=\'text-left\'>";
    title += "<span>ក្រុមជជែក</span>: <ol>";
    title += chatGroupNames.map((name) => `<li>${name}</li>`).join("");
    title += "</ol></div>";

    tooltipSpan.attr("data-original-title", title);
    $("[data-toggle='tooltip']").tooltip();
  }

  function showChatGroup(select, chatGroupNames) {
    select.parents(".fieldset").find(".chat-group-wrapper").removeClass("d-none");
  }

  function hideChatGroup(select) {
    select.parents(".fieldset").find(".chat-group-wrapper").addClass("d-none");
  }

  function getChatGroupLabels(select) {
    let chatGroupIds = select.parents(".fieldset").find("select.chat_group_ids").map((index, el) => $(el).val()).toArray();
    let chatGroupOptions = select.find("option").filter((index, el) => chatGroupIds.includes(el.value));

    return chatGroupOptions.map((index, el) => el.text).toArray();
  }

  function initFormTagList() {
    MW.Common.tagList.init("#forms_survey_form_tag_list", {
      options: {
        maxTags: 1
      }
    })
  }

  function initQuestionTagList() {
    let questions = $(".fieldset")

    for(let i=0; i<questions.length; i++) {
      MW.Common.tagList.init($(questions[i]).find('.tag-list'), {
        options: {
          maxTags: 1
        },
        callback: MW.Form.handleDisplayTagListWrapper
      })
    }
  }
})();

MW.Survey_formsEdit = MW.Survey_formsNew
MW.Survey_formsCreate = MW.Survey_formsNew
MW.Survey_formsUpdate = MW.Survey_formsNew
