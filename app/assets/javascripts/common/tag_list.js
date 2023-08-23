MW.Common.tagList = (() => {
  function init(dom) {
    let input = $(dom);
    let tagify = new Tagify(input[0], {
      whitelist: input.data('tags'),
      dropdown: { maxItems: 20, classname: "tags-look", enabled: 0, closeOnSelect: false }
    });

    setValueToTagListInput();

    tagify.on('add', setValueToTagListInput);
    tagify.on('remove', setValueToTagListInput);

    function setValueToTagListInput(e) {
      let tagList = tagify.value.map((v,i) => v.value).join(',');

      input.val(tagList);
    }
  }

  return { init }
})();
