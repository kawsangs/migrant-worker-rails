# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private
    def set_uuid
      self.uuid ||= SecureRandom.uuid

      return unless self.class.exists?(uuid: uuid)

      self.uuid = SecureRandom.uuid
      set_uuid
    end

    def set_display_order
      self.display_order ||= self.class.maximum(:display_order).to_i + 1
    end

    def secure_code
      self.code ||= SecureRandom.uuid[0..5]

      return unless self.class.exists?(code: code)

      self.code = SecureRandom.uuid[0..5]
      secure_code
    end
end
