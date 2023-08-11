# frozen_string_literal: true

class AddSectionIdToQuestions < ActiveRecord::Migration[6.1]
  def change
    add_column :questions, :section_id, :uuid
  end
end
