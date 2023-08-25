# frozen_string_literal: true

# == Schema Information
#
# Table name: notification_logs
#
#  id                  :uuid             not null, primary key
#  notification_id     :integer
#  failed_reason       :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  registered_token_id :integer
#
FactoryBot.define do
  factory :notification_log do
  end
end