# frozen_string_literal: true

require "csv"

module Samples
  class Base
    private
      def self.file_path(file_name)
        file_path = Rails.root.join("lib", "samples", "assets", "csv", file_name).to_s

        return puts "Fail to import data. could not find #{file_path}" unless File.file?(file_path)

        file_path
      end

      def self.get_audio(filename)
        return unless filename.present?

        audio = audios.select { |file| file.split("/").last.split(".").first == "#{filename.split('.').first}" }.first
        Pathname.new(audio).open if audio.present?
      end

      def self.get_image(filename)
        return unless filename.present?

        image = images.select { |file| file.split("/").last.split(".").first == "#{filename.split('.').first}" }.first
        Pathname.new(image).open if image.present?
      end

      def self.audios
        @audios ||= Dir.glob(Rails.root.join("lib", "samples", "assets", "audios", "**", "**", "**", "**"))
      end

      def self.images
        @images ||= Dir.glob(Rails.root.join("lib", "samples", "assets", "images", "**", "**", "**", "**"))
      end
  end
end
