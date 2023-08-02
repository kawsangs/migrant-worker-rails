MW.VideosNew = (() => {
  function init() {
    initTagList();
  }

  function initTagList() {
    input = $("#video_tag_list")

    var tagify = new Tagify(input[0], {
      whitelist: input.data('tags'),
      dropdown: { maxItems: 20, classname: "tags-look", enabled: 0, closeOnSelect: false }
    });

    tagify.on('add', setValueToTagListInput);
    tagify.on('remove', setValueToTagListInput);

    function setValueToTagListInput(e) {
      let tagList = tagify.value.map((v,i) => v.value).join(',');

      input.val(tagList);
    }
  }

  return { init }
})();

MW.VideosCreate = MW.VideosNew
MW.VideosEdit = MW.VideosNew
MW.VideosUpdate = MW.VideosNew
