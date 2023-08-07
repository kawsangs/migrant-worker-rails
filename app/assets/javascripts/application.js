//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery3
//= require popper
//= require bootstrap

//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

//= require sb-admin-2

//= require jquery.richtext

//= require application/namespace
//= require application/util

//= require common/topbar
//= require common/timeago
//= require common/country
//= require common/sidebar
//= require common/confirm_modal

// For building question skip logic
//= require common/skip_logic_constant
//= require common/question_type
//= require common/skip_logic
//= require common/criteria

//= require jquery-sortable
//= require tagify.min
//= require common/form
//= require common/audio
//= require common/wizard_form

//= require accounts/index
//= require category_images
//= require categories
//= require departures/new
//= require forms/new
//= require notifications
//= require institutions/new
//= require videos/form

$(document).on("ready turbolinks:load", () => {
  MW.Common.Topbar.init();
  MW.Common.Timeago.init();
  MW.Common.Sidebar.init();
  MW.Common.ConfirmModal.init();
  MW.Common.ConfirmModal.init("confirmPublishModal");
  MW.Common.WizardForm.init();

  $("[data-toggle='tooltip']").tooltip();

  let currentPage = MW.Util.getCurrentPage();
  !!MW[currentPage] && MW[currentPage].init();
});

