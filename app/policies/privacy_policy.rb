# frozen_string_literal: true

class PrivacyPolicy < Struct.new(:user, :privacy)
  def index?
    true
  end
end
