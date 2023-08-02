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
end
