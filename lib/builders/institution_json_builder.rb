# frozen_string_literal: true

class InstitutionJsonBuilder
  attr_accessor :institution

  def initialize(institution)
    @institution = institution
  end

  def build
    data = JSON.parse(ActiveModelSerializers::SerializableResource.new(institution).to_json)
    assign_assets(data)
    data
  end

  private
    def assign_assets(data)
      data["logo"] = "require('../../assets/images/institution/#{data["logo_url"].split('/').last}')" if data["logo_url"].present?
      data["audio"] = data["audio_url"].split("/").last if data["audio_url"].present?
      data["offline"] = true
    end
end
