MW.Common.Sidebar = (() => {
  return {
    init
  }

  function init() {
    handleActiveSidebar();
    onClickSidebar();
  }

  function handleActiveSidebar() {
    let cssClass = localStorage.getItem('miniSidebar') == 'true' ? 'active' : '';
    $('#sidebar').addClass(cssClass)
  }

  function onClickSidebar(){
    $('#sidebarCollapse').on('click', function() {
      $('#sidebar').toggleClass('active');
      localStorage.setItem('miniSidebar', $('#sidebar').hasClass('active'));
    })
  }
})();
