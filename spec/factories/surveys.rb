# frozen_string_literal: true

# == Schema Information
#
# Table name: surveys
#
#  id              :bigint           not null, primary key
#  uuid            :string
#  user_uuid       :string
#  form_id         :integer
#  quizzed_at      :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  notification_id :integer
#
FactoryBot.define do
  factory :survey do
    uuid { SecureRandom.uuid }
    user
    form
  end
end
