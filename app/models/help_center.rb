# == Schema Information
#
# Table name: help_centers
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class HelpCenter < ApplicationRecord
  validates :name, presence: true,
                    uniqueness: { case_sensitive: false }
end
