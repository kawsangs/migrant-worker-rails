MW.Common.Sidebar = (() => {
  return {
    init
  }

  function init() {
    toggleCollapseContent()
  }

  function toggleCollapseContent() {
    $( ".collapse-inner" ).each(function( index ) {
      let dom = $(this);

      if (!!dom.find(".active").length) {
        setListActived(dom);

        if(isExpandSidebar()) {
          setToggleLinkActived(dom);
          setDisplayCollapseContent(dom);
        }
      }
    });
  }

  function isExpandSidebar() {
    return !$(".sidebar-toggled") || !$(".sidebar-toggled").length;
  }

  function setListActived(dom) {
    dom.parents('li').addClass('active');
  }

  function setToggleLinkActived(dom) {
    dom.parents('li').find('.nav-link').removeClass('collapsed');
  }

  function setDisplayCollapseContent(dom) {
    dom.parent().addClass('show');
  }
})();
