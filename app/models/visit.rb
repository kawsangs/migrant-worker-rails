# frozen_string_literal: true

# == Schema Information
#
# Table name: visits
#
#  id            :uuid             not null, primary key
#  page_id       :string
#  pageable_id   :string
#  pageable_type :string
#  device_id     :string
#  visit_date    :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_uuid     :string
#
class Visit < ApplicationRecord
  # Association
  belongs_to :page, counter_cache: true
  belongs_to :user, primary_key: :uuid, foreign_key: :user_uuid, optional: true
  belongs_to :pageable, polymorphic: true, optional: true
  belongs_to :device, primary_key: :device_id, foreign_key: :device_id, class_name: "RegisteredToken", optional: true

  # Callback
  before_validation :set_pageable

  # Delegation
  delegate :name, :code, to: :page, prefix: true, allow_nil: true
  delegate :name, to: :pageable, prefix: true, allow_nil: true
  delegate :display_device_id, to: :user, prefix: false, allow_nil: true

  # Nested attribute
  accepts_nested_attributes_for :page, reject_if: lambda { |attributes|
    attributes["code"].blank?
  }

  # Instant method
  def page_attributes=(attribute)
    _page = Page.find_or_initialize_by(code: attribute[:code])
    _page.parent ||= Page.find_or_create_by(code: attribute[:parent_code]) if attribute[:parent_code].present?
    _page.update(name_km: attribute[:name])

    self.page = _page
    set_pageable
  end

  def set_pageable
    self.pageable ||= page
  end

  def last_visit
    self.class.where(user_uuid: user_uuid, pageable_type: pageable_type, pageable_id: pageable_id)
              .where("visit_date >= ?", visit_date - 30.minutes)
              .first
  end

  # Class method
  def self.filter(params = {})
    scope = all
    scope = scope.where("visit_date BETWEEN ? AND ?", params[:start_date], params[:end_date]) if params[:start_date].present? && params[:end_date].present?
    scope = scope.where(page_id: params[:page_ids]) if params[:page_ids].present?
    scope = scope.joins(:user).where('users.device_os': params[:platform]) if params[:platform].present?
    scope
  end
end
