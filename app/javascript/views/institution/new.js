import country from '../../lib/country'

MW.InstitutionsNew = (() => {
  function init() {
    console.log('load')
    country.load();
  }

  return { init }
})();