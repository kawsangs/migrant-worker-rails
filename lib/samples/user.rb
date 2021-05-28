# frozen_string_literal: true

module Samples
  class User
    def self.load
      users = [
        { full_name: "Nary", age: "30", sex: "Female" },
        { full_name: "Soka", age: "30", sex: "Female" },
        { full_name: "Sana", age: "30", sex: "Female" }
      ]

      users.each do |user|
        ::User.create(user)
      end
    end
  end
end
