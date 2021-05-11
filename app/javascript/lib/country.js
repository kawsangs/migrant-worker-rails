const load = () => {
  var input = document.querySelector('.tagify-country');
  var tagify = new Tagify(input, {
    whitelist: ["Tajikistan", "Jamaica", "Haiti", "Sao Tome and Principe", "Montserrat", "United Arab Emirates", "Pakistan", "Netherlands", "Luxembourg", "Belize", "Iran (Islamic Republic of)", "Bolivia (Plurinational State of)", "Uruguay", "Ghana", "Saudi Arabia", "Côte d'Ivoire", "Saint Martin (French part)", "French Southern Territories", "Anguilla", "Qatar", "Sint Maarten (Dutch part)", "Libya", "Bouvet Island", "Papua New Guinea", "Kyrgyzstan", "Equatorial Guinea", "Western Sahara", "Niue", "Puerto Rico", "Grenada", "Korea (Republic of)", "Heard Island and McDonald Islands", "San Marino", "Sierra Leone", "Congo (Democratic Republic of the)", "North Macedonia", "Turkey", "Algeria", "Georgia", "Palestine, State of", "Barbados", "Ukraine", "Guadeloupe", "French Polynesia", "Namibia", "Botswana", "Syrian Arab Republic", "Togo", "Dominican Republic", "Antarctica"],
    maxTags: 10,
    enforceWhitelist : true,
    dropdown: {
      maxItems: 20,           // <- mixumum allowed rendered suggestions
      classname: "tags-look", // <- custom classname for this dropdown, so it could be targeted
      enabled: 0,             // <- show suggestions on focus
      closeOnSelect: false    // <- do not hide the suggestions dropdown once an item has been selected
    }
  })

  tagify.on('add', onAddTag);
  tagify.on('remove', onRemoveTag);

  function onAddTag(e) {
    console.log("onAddTag: ", e.detail);
    console.log("original input value: ", input.value);
    $(`<input class="form-control string optional ${tagify_class(e.detail.data.value)}" 
              type="hidden" 
              name="institution[country_institutions_attributes][${tagify.value.length + 1}][country_code]" 
              value="${e.detail.data.value}" />`).insertAfter(input);
    // tagify.off('add', onAddTag)
  }

  function onRemoveTag(e) {
    console.log("onRemoveTag:", `.tagify-item-${e.detail.index}`, "tagify instance value:", tagify.value);
    $(`.del-${tagify_class(e.detail.data.value)}`).val('1');
  }

  function tagify_class(value) {
    return 'tagify-item-' + value.replace(/[^a-zA-Z0-9]/g,'-');
  }
}

export default { load }
