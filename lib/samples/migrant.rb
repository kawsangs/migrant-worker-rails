# frozen_string_literal: true

module Samples
  class Migrant
    def self.load
      migrants = [
        { full_name: 'Nary', age: '30', sex: 'Female', phone_number: '011 222 333' },
        { full_name: 'Soka', age: '30', sex: 'Female', phone_number: '012 999 111' },
        { full_name: 'Sana', age: '30', sex: 'Female', phone_number: '015 888 222' }
      ]

      migrants.each do |migrant|
        ::Migrant.create(migrant)
      end
    end
  end
end
