# frozen_string_literal: true

require "csv"

class UserService
  def initialize(users)
    @users = users
  end

  def export_csv
    CSV.generate(headers: true) do |csv|
      csv << column_header

      @users.each_with_index do |user, index|
        csv << build_csv_record(user, index)
      end
    end
  end

  private
    def build_csv_record(user, index)
      columns = [index+1]

      %w(full_name sex age audio_url).each do |col|
        columns.push(user.send(col))
      end
      columns.push(I18n.l(user.registered_at, format: :long)) if user.registered_at.present?
      columns
    end

    def column_header
      ["Number", "Full Name", "Sex", "Age", "Voice Record", "Registered At"]
    end
end
