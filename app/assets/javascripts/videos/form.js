MW.VideosNew = (() => {
  function init() {
    MW.Common.tagList.init("#video_tag_list")
  }

  return { init }
})();

MW.VideosCreate = MW.VideosNew
MW.VideosEdit = MW.VideosNew
MW.VideosUpdate = MW.VideosNew
