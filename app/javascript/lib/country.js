const load = () => {
  var input = document.querySelector('.tagify-country');
  var whitelist = [
    { value:'Afghanistan', countryId: 1, code:'AF' },
    { value:'Åland Islands', countryId: 2, code:'AX' },
    { value:'Albania', countryId: 3, code:'AL' },
    { value:'Algeria', countryId: 4, code:'DZ' },
    { value:'American Samoa', countryId: 5, code:'AS' },
    { value:'Andorra', countryId: 6, code:'AD' },
    { value:'Angola', countryId: 7, code:'AO' },
    { value:'Anguilla', countryId: 8, code:'AI' },
    { value:'Antarctica', countryId: 9, code:'AQ' },]

  var tagify = new Tagify(input, {
    whitelist: whitelist,
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
