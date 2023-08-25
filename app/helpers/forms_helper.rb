# frozen_string_literal: true

module FormsHelper
  def link_to_add_fields(name, f, association, option = {})
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder, option: option)
    end

    link_to(name, "#", class: "add_#{association} btn add_association #{option[:class]}", data: { id: id, fields: fields.gsub("\n", "") })
  end

  def form_status_html(form)
    status_method = ["form_status", form.status, "html"].compact.join("_")

    send(status_method, form) rescue form.status
  end

  def form_status_draft_html(form)
    title = "#{I18n.t('notification.drafted_at')}: #{I18n.l(form.updated_at)}"

    "<span class='badge badge-secondary' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>Draft</span>"
  end

  def form_status_published_html(form)
    title = "<div class='text-left'>#{I18n.t('shared.published_at')}: #{display_date(form.published_at)}</div>"

    "<span class='badge badge-success' data-toggle='tooltip' data-html='true' data-placement='top' data-title='#{sanitize(title)}'>Released</span>"
  end

  def chat_group_list_html(groups)
    return "" unless groups.present?
    "<div class='text-left'>" +
    "<span>#{t('form.chat_group')}</span>: " +
    "<ol>" + groups.map { |group| "<li>#{group.title}</li>" }.join("") + "</ol>" +
    "</div>"
  end

  def tag_list_html(tags)
    return "" unless tags.present?

    tags.map { |tag|
      "<small class='tag rounded mr-1'>#{tag}</small>"
    }.join("")
  end
end
