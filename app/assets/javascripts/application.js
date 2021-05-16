//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery3
//= require popper
//= require bootstrap

//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

//= require sb-admin-2

//= require application/namespace
//= require application/util

//= require common/topbar

// For building question skip logic
//= require common/skip_logic_constant
//= require common/question_type
//= require common/skip_logic
//= require common/criteria

//= require jquery-sortable
//= require tagify.min
//= require common/form
//= require common/audio

//= require accounts/index
//= require category_images
//= require departures/new
//= require forms/new

$(document).on("ready turbolinks:load", () => {
  MW.Common.Topbar.init();
  $("[data-toggle='tooltip']").tooltip();

  let currentPage = MW.Util.getCurrentPage();
  !!MW[currentPage] && MW[currentPage].init();
});

