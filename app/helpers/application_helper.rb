# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    prefix = params["controller"].downcase.split("/").join("-")
    subfix = params["action"]

    "#{prefix}-#{subfix}"
  end

  def get_css_active_class(name)
    return "active" if params["controller"] == name
  end

  def pagy_label(pagy)
    "#{I18n.t('shared.display')} <b>#{pagy.from}</b> - <b>#{pagy.to}</b> of <b>#{pagy.count}</b>".html_safe
  end

  def program_languages
    [
      { code: "km", label: I18n.t("shared.km"), image: "khmer.png" },
      { code: "en", label: I18n.t("shared.en"), image: "english.png" }
    ]
  end
end
