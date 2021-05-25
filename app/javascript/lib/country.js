// https://github.com/annexare/Countries
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
      maxItems: 20,
      classname: "extra-properties",
      enabled: 0,
      closeOnSelect: false
    }
  })

  tagify.on('add', onAddTag);
  tagify.on('remove', onRemoveTag);

  function onAddTag(e) {
    let id = tagify.value.length + 1;
    let { data } = e.detail;

    inputBuilder('country_name', data, data.value, id).insertAfter(input);
    inputBuilder('country_code', data, data.code, id).insertAfter(input);
  }

  function inputBuilder(name, data, value, id) {
    return $(`<input class="${tagify_class(data.value)}" 
                type="hidden" 
                name="institution[country_institutions_attributes][${id}][${name}]" 
                value="${value}" />`)
  }

  function onRemoveTag(e) {
    console.log("onRemoveTag:", `.tagify-item-${e.detail.index}`, "tagify instance value:", tagify.value);
    let country = $(`.del-${tagify_class(e.detail.data.value)}`)

    if( !!country.length ) country.val('1'); // set _destroy=1
    else $(`.${tagify_class(e.detail.data.value)}`).remove()
  }

  function tagify_class(value) {
    return 'tagify-item-' + value.replace(/[^a-zA-Z0-9]/g,'-');
  }
}

export default { load }
