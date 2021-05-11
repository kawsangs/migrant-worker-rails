import country from 'lib/country'

$(document).on("ready turbolinks:load", () => {
  country.load()
});
