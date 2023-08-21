//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery3
//= require popper
//= require bootstrap
//= require bootstrap-select

//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

//= require sb-admin-2

//= require jquery.richtext

// Push notification form
//= require moment
//= require tempusdominus-bootstrap-4.js
//= require recurring_select

//= require application/namespace
//= require application/util

//= require common/topbar
//= require common/timeago
//= require common/country
//= require common/sidebar
//= require common/confirm_modal
//= require common/select_picker

// For building question skip logic
//= require common/skip_logic_constant
//= require common/question_type
//= require common/skip_logic
//= require common/criteria

//= require jquery-sortable
//= require tagify.min
//= require common/form
//= require common/datetime_picker
//= require common/audio
//= require common/wizard_form
//= require common/select_recurring_translation

//= require accounts/index
//= require category_images
//= require categories
//= require departures/new
//= require forms/index
//= require forms/new
//= require notifications/index
//= require notifications/new
//= require institutions/new
//= require videos/form
//= require survey_form
//= require telegram_bot

$(document).on("ready turbolinks:load", () => {
  MW.Common.Topbar.init();
  MW.Common.Timeago.init();
  MW.Common.SelectPicker.init();
  MW.Common.DatetimePicker.init();
  MW.Common.Sidebar.init();
  MW.Common.ConfirmModal.init();
  MW.Common.WizardForm.init();

  $("[data-toggle='tooltip']").tooltip();

  let currentPage = MW.Util.getCurrentPage();
  !!MW[currentPage] && MW[currentPage].init();
});

