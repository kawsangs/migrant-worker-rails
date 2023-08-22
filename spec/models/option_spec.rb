# frozen_string_literal: true

# == Schema Information
#
# Table name: options
#
#  id            :bigint           not null, primary key
#  question_id   :integer
#  name          :string
#  value         :string
#  score         :integer
#  alert_audio   :string
#  alert_message :text
#  warning       :boolean
#  recursive     :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  image         :string
#
require "rails_helper"

RSpec.describe Option, type: :model do
  it { is_expected.to have_many(:options_chat_groups) }
  it { is_expected.to have_many(:chat_groups).through(:options_chat_groups) }
end
