# frozen_string_literal: true

require_relative "base"

module Samples
  class NeedForHelp < ::Samples::Base
    def self.load
      path = file_path("institutions.xlsx")
      xlsx = Roo::Spreadsheet.open(path)
      xlsx.each_with_pagename do |page_name, sheet|
        rows = sheet.parse(headers: true)

        case page_name
        when "country"
          upsert_country(rows)
        when "institution"
          upsert_institution(rows)
        end
      end
    end

    def self.export(type = "json")
      class_name = "Exporters::#{type.camelcase}Exporter"
      class_name.constantize.new(::Country.having_institutions).export("countries")
      class_name.constantize.new(::Institution.all).export("institutions")
    rescue
      Rails.logger.warn "#{class_name} is unknwon"
    end

    private
      def self.upsert_country(rows)
        rows[1..-1].each do |row|
          country = ::Country.find_or_initialize_by(code: row["code"])
          country.update(name: row["name"], name_km: row["name_km"])
        end
      end

      def self.upsert_institution(rows)
        rows[1..-1].each do |row|
          country = ::Country.find_by name: row["country_name"].capitalize
          next if country.nil?

          institution = ::Institution.find_or_initialize_by(code: row["code"])
          institution.update(
            name: row["name"],
            kind: row["kind"],
            audio: get_audio(row["audio"]),
            address: row["address"],
            country_institutions_attributes: [
              {
                id: institution.country_institutions.find_by(country_code: country.code).try(:id),
                country_code: country.code
              }
            ]
          )

          row["phone"].to_s.split("/").each do |num|
            phone = num.gsub(/\s/, "")
            institution.contacts.find_or_create_by(value: phone, type: "Phone")
          end

          row["facebook"].to_s.split("/").each do |fb|
            institution.contacts.find_or_create_by(value: fb, type: "Facebook")
          end
        end
      end
  end
end
