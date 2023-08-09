MW.Common.SelectRecurringTranslation = (() => {
  return {
    init
  }

  function init() {
    if ($("[data-current-locale]").data('currentLocale') != 'km') return;

    $.fn.recurring_select.texts = {
      locale_iso_code: "en",
      repeat: "កាលវិភាគ",
      frequency: "Frequency",
      daily: "ប្រចាំថ្ងៃ",
      weekly: "ប្រចាំសប្តាហ៍",
      monthly: "ប្រចាំខែ",
      yearly: "ប្រចាំឆ្នាំ",
      every: "រៀងរាល់",
      days: "ថ្ងៃ",
      weeks_on: "សប្តាហ៍",
      months: "ខែ",
      years: "ឆ្នាំ",
      first_day_of_week: 1,
      day_of_month: "ថ្ងៃនៃខែ",
      day_of_week: "ថ្ងៃនៃអាទិត្យ",
      cancel: "បោះបង់",
      ok: "យល់ព្រម",
      summary: "បរិយាយ",
      last_day: "ថ្ងៃចុងក្រោយ",
      days_first_letter: ["អា", "ច", "អ", "ពុ", "ព្រហ", "សុ", "ស"],
      order: ["ទី១", "ទី២", "ទី៣", "ទី៤", "ទី៥", "ទី៦"]
    }
  }
})();
