MW.Common.tagList = (() => {
  function init(dom, params={}) {
    let input = $(dom);
    let tagify = new Tagify(input[0], getTagOptions(input, params.options));

    setValueToTagListInput();

    tagify.on('add', setValueToTagListInput);
    tagify.on('remove', setValueToTagListInput);

    function setValueToTagListInput(e) {
      let tagList = tagify.value.map((v,i) => v.value).join(',');

      input.val(tagList);
      !!params.callback && (typeof params.callback === 'function') && params.callback(input, tagList);
    }
  }

  function getTagOptions(input, options={}) {
    let option = {
      whitelist: input.data('tags'),
      dropdown: { maxItems: 20, classname: "tags-look", enabled: 0, closeOnSelect: false }
    }
    if (!!options) {
      option = {...option, ...options}
    }

    return option;
  }

  return { init }
})();
