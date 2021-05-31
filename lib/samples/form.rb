# frozen_string_literal: true

require_relative "base"

module Samples
  class Form < ::Samples::Base
    def self.load
      path = file_path("form_stories.xlsx")
      xlsx = Roo::Spreadsheet.open(path)
      xlsx.each_with_pagename do |page_name, sheet|
        rows = sheet.parse(headers: true)

        case page_name
        when 'form'
          upsert_form(rows)
        when 'question'
          upsert_question(rows)
        when 'option'
          upsert_option(rows)
        end
      end
    end

    def self.export(type = "json")
      class_name = "Exporters::#{type.camelcase}Exporter"
      class_name.constantize.new(::Form.all).export("form_stories")
    rescue
      Rails.logger.warn "#{class_name} is unknwon"
    end

    private
      def self.upsert_form(rows)
        rows[1..-1].each do |row|
          form = ::Form.find_or_initialize_by(code: row["code"])
          form.update(name: row["name"], image: get_image(row["image"]), audio: get_audio(row["image"]))
        end
      end

      def self.upsert_question(rows)
        rows[1..-1].each do |row|
          form = ::Form.find_by(code: row["form_code"])
          next unless form.present? && row["name"].present?

          question = form.questions.find_or_initialize_by(code: row["code"])
          param = {
            name: row["name"],
            type: row["type"],
            hint: row["hint"],
            relevant: row["relevant"],
            audio: get_audio(row["audio"]),
            passing_score: row["passing_score"],
            passing_message: row["passing_message"],
            passing_audio: get_audio(row["passing_audio"]),
            failing_message: row["failing_message"],
            failing_audio: get_audio(row["failing_audio"]),
          }

          if row["criteria"].present?
            criterias = row["criteria"].split(';')
            param[:criterias_attributes] = criterias.map { |cri|
              data = cri.split("||")
              {
                question_code: data[0],
                operator: data[1],
                response_value: data[2]
              }
            }
          end

          question.update(param)
        end
      end

      def self.upsert_option(rows)
        rows[1..-1].each do |row|
          question = ::Question.find_by(code: row["question_code"])
          next unless question.present? && row["name"].present?

          question.options.create(
            name: row["name"],
            value: row["value"],
            score: row["score"],
            alert_message: row["alert_message"],
            alert_audio: get_audio(row["alert_audio"]),
            warning: (row["is_warning"] == 'TRUE'),
            recursive: (row["is_repeat"] == 'TRUE'),
            image: get_image(row["image"]),
          )
        end
      end
  end
end
