# frozen_string_literal: true

# == Schema Information
#
# Table name: pages
#
#  id             :uuid             not null, primary key
#  code           :string
#  name_km        :string
#  name_en        :string
#  parent_id      :uuid
#  visits_count   :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default(0), not null
#  children_count :integer          default(0), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Page < ApplicationRecord
  # Nested level
  acts_as_nested_set

  # Association
  has_many :visits

  # Validation
  before_validation :set_name_en

  # Callback
  before_create :secure_code

  def name
    self["name_#{I18n.locale}"]
  end

  def self.filter(params)
    keyword = params[:name].to_s.downcase
    scope = all
    scope = scope.where("LOWER(code) LIKE ? OR name_km LIKE ? OR name_en LIKE ?", "%#{keyword}%", "%#{keyword}%", "%#{keyword}%") if keyword.present?
    scope
  end

  private
    def set_name_en
      self.name_en ||= name_km
    end
end
