MW.Common.Country = (() => {
  return { init: init }

  function init() {
    const countries = $(".tagify-country").data('country');
    var input = document.querySelector('.tagify-country');
    var whitelist = countries.map((country, index) => ({ name: country.name, value: country.code })).sort(sortCountryByNames)

    var tagify = new Tagify(input, {
      templates : {
        tag: function(tagData) {
            try {
            return `<tag title='${tagData.value}' contenteditable='false' spellcheck="false" class='tagify__tag ${tagData.class ? tagData.class : ""}' ${this.getAttributes(tagData)}>
                      <x title='remove tag' class='tagify__tag__removeBtn'></x>
                      <div>
                        <span class='tagify__tag-text'>${tagData.name}</span>
                      </div>
                    </tag>`
            }
            catch(err) {}
        },

        dropdownItem: function(tagData) {
            try {
            return `<div ${this.getAttributes(tagData)} class='tagify__dropdown__item ${tagData.class ? tagData.class : ""}' tagifySuggestionIdx="${tagData.tagifySuggestionIdx}">
                      <span>${tagData.name}</span>
                    </div>`
            }
            catch(err) {}
        }
      },
      whitelist: whitelist,
      maxTags: 10,
      enforceWhitelist : true,
      dropdown: {
        maxItems: 1000,
        classname: "extra-properties",
        enabled: 0,
        searchKeys: ['name'],
        closeOnSelect: false
      }
    })

    tagify.on('add', onAddTag);
    tagify.on('remove', onRemoveTag);

    function onAddTag(e) {
      let id = tagify.value.length + 1;
      let { data } = e.detail;

      inputBuilder('country_name', data, data.name, id).insertAfter(input);
      inputBuilder('country_code', data, data.value, id).insertAfter(input);
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

    function sortCountryByNames(c1, c2) {
      if(c1.value < c2.value) { return -1; }
      if(c1.value > c2.value) { return 1; }
      return 0;
    }
  }
})();
