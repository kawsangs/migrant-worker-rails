import country from '../../lib/country'

MW.InstitutionsNew = (() => {
  function init() {
    country.load();
  }

  return { init }
})();