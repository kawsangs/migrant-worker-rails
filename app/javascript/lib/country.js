window.countryList = require('countries-list');

const load = () => {
  const countries = Object.keys(countryList.countries)
  var input = document.querySelector('.tagify-country');
  var whitelist = countries.map((code, index) => ({ value: countryList.countries[code].name, code: code }))

  var tagify = new Tagify(input, {
    templates : {
      tag: function(tagData) {
          try {
          return `<tag title='${tagData.value}' contenteditable='false' spellcheck="false" class='tagify__tag ${tagData.class ? tagData.class : ""}' ${this.getAttributes(tagData)}>
                    <x title='remove tag' class='tagify__tag__removeBtn'></x>
                    <div>
                      ${tagData.code ?
                      `<img onerror="this.style.visibility='hidden'" src='https://lipis.github.io/flag-icon-css/flags/4x3/${tagData.code.toLowerCase()}.svg'>` : ''
                      }
                      <span class='tagify__tag-text'>${tagData.value}</span>
                    </div>
                  </tag>`
          }
          catch(err) {}
      },

      dropdownItem: function(tagData) {
          try {
          return `<div class='tagify__dropdown__item ${tagData.class ? tagData.class : ""}' tagifySuggestionIdx="${tagData.tagifySuggestionIdx}">
                    <img onerror="this.style.visibility = 'hidden'"
                          src='https://lipis.github.io/flag-icon-css/flags/4x3/${tagData.code.toLowerCase()}.svg'>
                    <span>${tagData.value}</span>
                  </div>`
          }
          catch(err) {}
      }
    },
    whitelist: whitelist,
    maxTags: 10,
    enforceWhitelist : true,
    dropdown: {
      maxItems: 20,           // <- mixumum allowed rendered suggestions
      classname: "extra-properties", // <- custom classname for this dropdown, so it could be targeted
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
    $(`.del-${tagify_class(e.detail.data.value)}`).val('1'); // set _destroy=1
  }

  function tagify_class(value) {
    return 'tagify-item-' + value.replace(/[^a-zA-Z0-9]/g,'-');
  }
}

export default { load }
