import country from '../../lib/country'

MW.InstitutionsNew = (() => {
  function init() {
    country.load();
  }

  return { init }
})();

MW.InstitutionsCreate = MW.InstitutionsNew
MW.InstitutionsEdit = MW.InstitutionsNew
MW.InstitutionsUpdate = MW.InstitutionsNew
