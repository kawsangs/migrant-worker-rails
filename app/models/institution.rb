# frozen_string_literal: true

# == Schema Information
#
# Table name: institutions
#
#  id            :bigint           not null, primary key
#  name          :string           not null
#  kind          :integer          default(2)
#  address       :text             default("")
#  logo          :string
#  audio         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  code          :string
#  name_km       :string
#  display_order :integer
#
class Institution < ApplicationRecord
  has_many :contacts, inverse_of: :institution, dependent: :destroy
  has_many :country_institutions, dependent: :destroy
  has_many :countries, through: :country_institutions

  validates :country_institutions, length: { minimum: 1, message: "should have at least 1 country." }
  validates :name, :name_km, presence: true

  before_create :set_display_order

  mount_uploader :logo, ImageUploader
  mount_uploader :audio, AudioUploader

  accepts_nested_attributes_for :country_institutions, allow_destroy: true
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, allow_destroy: true

  # scope
  default_scope { order("updated_at DESC") }

  def self.filter(params = {})
    scope = all
    scope = scope.where("LOWER(name) LIKE ?", "%#{params[:name].strip.downcase}%") if params[:name].present?
    scope = scope.where("created_at BETWEEN ? AND ?", DateTime.parse(params[:start_date]).beginning_of_day, DateTime.parse(params[:end_date]).end_of_day) if params[:start_date].present? && params[:end_date].present?
    scope = scope.joins(:country_institutions).where("country_institutions.country_code in (?)", params[:countries]) if params[:countries].present?
    scope
  end

  def country_names
    countries.map(&:name).join(",")
  end

  private
    def set_display_order
      self.display_order ||= self.class.maximum(:display_order).to_i + 1
    end
end
