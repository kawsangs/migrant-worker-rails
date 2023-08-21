# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id            :bigint           not null, primary key
#  uuid          :string
#  full_name     :string
#  sex           :string
#  age           :string
#  audio         :string
#  registered_at :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class User < ApplicationRecord
  mount_uploader :audio, AudioUploader

  has_many :quizzes, foreign_key: :user_uuid, primary_key: :uuid

  scope :newest, -> { order("registered_at DESC") }

  def self.filter(params = {})
    scope = all
    scope = scope.where("LOWER(full_name) LIKE ?", "%#{params[:keyword].downcase}%") if params[:keyword].present?
    scope
  end

  def profile_html
    "#{I18n.t('users.username')}: <b>#{full_name}</b>, #{I18n.t('users.gender')}: <b>#{sex}</b>, #{I18n.t('users.age')}: <b>#{age}</b>"
  end
end
