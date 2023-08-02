# frozen_string_literal: true

# == Schema Information
#
# Table name: tags
#
#  id             :uuid             not null, primary key
#  name           :string
#  taggings_count :integer
#  display_order  :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Tag < ApplicationRecord
  has_many :taggings
  has_many :videos, through: :taggings, source: :taggable, source_type: "Video"

  before_create :set_display_order
  before_destroy :validate_if_in_use

  # Scope
  default_scope { order(display_order: :asc) }

  def self.filter(params = {})
    scope = all
    scope = scope.where("LOWER(name) LIKE ?", "%#{params[:name].downcase}%") if params[:name].present?
    scope
  end

  private
    def validate_if_in_use
      if taggings_count.positive?
        errors.add :tag, I18n.t("shared.cannot_delete")
        throw(:abort)
      end
    end
end
