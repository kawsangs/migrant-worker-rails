MW.UsersIndex = (() => {
  function init() {
    MW.Common.DaterangePicker.init();
    MW.Common.toggleAdvanceSearch.init("user_advance_search");

    initAgeRageSlider();
  }

  function initAgeRageSlider() {
    let slider = document.getElementById('slider-round');
    let inputStartAge = document.getElementById('start-age');
    let inputEndAge = document.getElementById('end-age');
    let minAge = -1;
    let maxAge = 99;
    let self = this;

    noUiSlider.create(slider, {
      start: [(inputStartAge.value || minAge), (inputEndAge.value || maxAge)],
      connect: true,
      range: {
        'min': minAge,
        'max': maxAge
      },
      step: 1,
    });

    slider.noUiSlider.on('update', function (values, handle) {
      let value = Math.round(values[handle]);

      if (handle) {
        inputEndAge.value = value;
      } else {
        inputStartAge.value = value;
      }

      updateAgeLabel(inputStartAge.value, inputEndAge.value);
    });
  }

  function updateAgeLabel(startAge, endAge) {
    let str = $("#age-range-label").data("label").replace(/start_age/g, startAge);
    str = str.replace(/end_age/g, endAge);

    document.getElementById('age-range-label').setHTML(str);
  }

  return {
    init
  }
})();
