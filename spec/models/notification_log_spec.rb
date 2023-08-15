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
require "rails_helper"

RSpec.describe NotificationLog, type: :model do
  it { is_expected.to belong_to(:notification) }
  it { is_expected.to belong_to(:registered_token) }
end
