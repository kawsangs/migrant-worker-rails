# frozen_string_literal: true

namespace :form do
  desc "migrate form_type to story_form"
  task migrate_story_form: :environment do
    forms = Form.where(form_type: nil)
    forms.update_all(form_type: "Forms::StoryForm")
  end
end
