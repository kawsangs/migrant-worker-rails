# frozen_string_literal: true

module Spreadsheets
  class Batches::NotificationBatchSpreadsheet < Spreadsheets::Batches::BaseSpreadsheet
    private
      def batch_model
        ::Batches::NotificationBatch
      end

      def importing_items
        @items.map do |row|
          item = Notification.new

          batch.importing_items.new(itemable: Spreadsheets::Batches::NotificationSpreadsheet.new(item).process(row))
        end
      end
  end
end
