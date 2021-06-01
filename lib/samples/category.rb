# frozen_string_literal: true

require_relative "base"

module Samples
  class Category < ::Samples::Base
    def self.load
      path = file_path("categories.xlsx")
      xlsx = Roo::Spreadsheet.open(path)
      xlsx.each_with_pagename do |page_name, sheet|
        rows = sheet.parse(headers: true)

        case page_name
        when "departure"
          upsert_category(rows, "Categories::Departure")
        when "safety"
          upsert_category(rows, "Categories::Safety")
        end
      end
    end

    def self.export(type = "json")
      class_name = "Exporters::#{type.camelcase}Exporter"
      class_name.constantize.new(::Category.all).export("categories")
    rescue
      Rails.logger.warn "#{class_name} is unknwon"
    end

    private
      def self.upsert_category(rows, category_type)
        rows[1..-1].each do |row|
          category = ::Category.find_or_initialize_by(uuid: row["code"])
          category.update(
            name: row["name"],
            description: row["description"],
            is_video: row["is_video"],
            parent_id: ::Category.find_by(uuid: row["parent_code"]).try(:id),
            type: category_type,
            hint: row["hint"],
          )
        end

        upsert_assets(rows)
      end

      def self.upsert_assets(rows)
        rows[1..-1].each do |row|
          category = ::Category.find_or_initialize_by(uuid: row["code"])
          category.update(
            image: get_image(row["image_name"]),
            audio: get_audio(row["audio_name"]),
            hint_image: get_image(row["hint_image"]),
            hint_audio: get_audio(row["hint_audio"])
          )
        end
      end
  end
end
