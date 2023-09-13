# frozen_string_literal: true

namespace :user do
  desc "Migrate unicode age"
  task migrate_unicode_age: :environment do
    users = User.where.not(age: nil)
    users.each do |user|
      age = format_number(user.age)
      age = nil if age.length > 2

      user.update(age: age)
    end
  end

  private
    def format_number(str)
      str.to_latin_number.remove_special_character
    end
end
