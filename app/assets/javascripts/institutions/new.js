MW.InstitutionsNew = (() => {
  function init() {
    MW.Form.onClickAddAssociation();
    MW.Form.onClickRemoveField();
    MW.Common.Country.init();
  }

  return { init }
})();

MW.InstitutionsCreate = MW.InstitutionsNew
MW.InstitutionsEdit = MW.InstitutionsNew
MW.InstitutionsUpdate = MW.InstitutionsNew
