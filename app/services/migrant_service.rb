# frozen_string_literal: true

require 'csv'

class MigrantService
  def initialize(migrants)
    @migrants = migrants
  end

  def export_csv
    CSV.generate(headers: true) do |csv|
      csv << column_header

      @migrants.each_with_index do |migrant, index|
        csv << build_csv_record(migrant, index)
      end
    end
  end

  private
    def build_csv_record(migrant, index)
      columns = [index+1]

      %w(full_name sex age phone_number voice_url).each do |col|
        columns.push(migrant.send(col))
      end
      columns.push(I18n.l(migrant.created_at, format: :long))

      columns
    end

    def column_header
      ['Number', 'Full Name', 'Sex', 'Age', 'Phone Number', 'Voice Record', 'Create Date']
    end
end
