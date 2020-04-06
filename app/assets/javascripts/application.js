//= require rails-ujs
//= require activestorage
//= require turbolinks

//= require jquery3
//= require popper
//= require bootstrap

//= require application/namespace
//= require application/util

//= require common/sidebar

//= require accounts/index

$(document).on("ready turbolinks:load", () => {

  const currentPage = MW.Util.getCurrentPage();
  if (MW[currentPage]) {
    MW[currentPage].init();
  }

  MW.Common.Sidebar.init();

  $("[data-toggle='tooltip']").tooltip()
});

