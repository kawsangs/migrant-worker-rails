module ApplicationHelper
  include Pagy::Frontend

  def css_class_name
    prefix = params['controller'].downcase.split('/').join('-')
    subfix = params['action']

    "#{prefix}-#{subfix}"
  end

  def get_css_active_class(name)
    return "active" if params["controller"] == name
  end
end
