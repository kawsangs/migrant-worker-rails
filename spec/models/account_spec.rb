# frozen_string_literal: true

# == Schema Information
#
# Table name: accounts
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  role                   :integer          not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  language_code          :string           default("en")
#  gf_user_id             :integer
#  deleted_at             :datetime
#  actived                :boolean          default(TRUE)
#  dashboard_accessible   :boolean          default(FALSE)
#
require "rails_helper"

RSpec.describe Account, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
